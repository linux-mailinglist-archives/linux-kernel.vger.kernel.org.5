Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B217EC102
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbjKOK5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjKOK5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:57:11 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CF5DA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:57:05 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SVg4338DpzNmJ3;
        Wed, 15 Nov 2023 18:52:51 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 15 Nov
 2023 18:57:03 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH] x86: Fix 32-bit compatible userspace write size overflow error
Date:   Wed, 15 Nov 2023 18:56:26 +0800
Message-ID: <20231115105626.953273-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For 32-bit compatible userspace program, write with size = -1 return not
-1 but unexpected other values, which is due to the __access_ok() check is
insufficient. The specified "ptr + size" is greater than 32-bit limit and
should return -EFAULT, but it is not checked and can not catch the overflow
error.

Fix above error by checking 32-bit limit if it is 32-bit compatible
userspace program.

How to reproduce:

The test program is as below:

root@syzkaller:~# cat test.c
	#include <unistd.h>
	#include <fcntl.h>
	#include <stdio.h>
	#include <stdint.h>
	#include <stdlib.h>
	#include <assert.h>

	#define pinfo(fmt, args...) \
	    fprintf(stderr, "[INFO][%s][%d][%s]:"fmt, \
	    __FILE__,__LINE__,__func__,##args)

	#undef SIZE_MAX
	#define SIZE_MAX -1

	int main()
	{
	    char wbuf[3] = { 'x', 'y', 'z' };
	    char *path = "write.tmp";
	    int ret;

	    int fd = open(path, O_RDWR | O_CREAT);
	    if (fd<0)
	    {
	        pinfo("fd=%d\n", fd);
	        exit(-1);
	    }

	    assert(write(fd, wbuf, 3) == 3);

	    ret = write (fd, wbuf, SIZE_MAX);
	    pinfo("ret=%d\n", ret);
	    pinfo("size_max=%d\n",SIZE_MAX);
	    assert(ret==-1);
	    close(fd);
	    pinfo("INFO: end\n");

	    return 0;
	}

Before applying this patch, userspace 32-bit program return 3799 if the
write size = -1 as below:
	root@syzkaller:~# gcc test.c -o test
	root@syzkaller:~# gcc -m32 test.c -o test32
	root@syzkaller:~# ./test
	[INFO][test.c][32][main]:ret=-1
	[INFO][test.c][33][main]:size_max=-1
	[INFO][test.c][36][main]:INFO: end
	root@syzkaller:~# ./test32
	[INFO][test.c][32][main]:ret=3799
	[INFO][test.c][33][main]:size_max=-1
	test32: test.c:34: main: Assertion `ret==-1' failed.
	Aborted

After applying this patch, userspace 32-bit program return -1 if the write
size = -1 as expected as below:
	root@syzkaller:~# gcc test.c -o test
	root@syzkaller:~# gcc -m32 test.c -o test32
	root@syzkaller:~# ./test
	[INFO][test.c][32][main]:ret=-1
	[INFO][test.c][33][main]:size_max=-1
	[INFO][test.c][36][main]:INFO: end
	root@syzkaller:~# ./test32
	[INFO][test.c][32][main]:ret=-1
	[INFO][test.c][33][main]:size_max=-1
	[INFO][test.c][36][main]:INFO: end

Fixes: b9bd9f605c4a ("x86: uaccess: move 32-bit and 64-bit parts into proper <asm/uaccess_N.h> header")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/x86/include/asm/uaccess_64.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index f2c02e4469cc..9febfbca3a88 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -88,6 +88,12 @@ static inline bool __access_ok(const void __user *ptr, unsigned long size)
 		return valid_user_address(ptr);
 	} else {
 		unsigned long sum = size + (unsigned long)ptr;
+
+#ifdef CONFIG_COMPAT
+		if (in_ia32_syscall())
+			return valid_user_address(sum) &&
+			sum >= (unsigned long)ptr && sum < UL(0x100000000);
+#endif
 		return valid_user_address(sum) && sum >= (unsigned long)ptr;
 	}
 }
-- 
2.34.1

