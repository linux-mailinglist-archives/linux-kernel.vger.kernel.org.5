Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B1D7EDC3E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344937AbjKPHrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjKPHrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:47:32 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9139F120
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 23:47:28 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SWBvJ5mmXzvQTW;
        Thu, 16 Nov 2023 15:47:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 16 Nov
 2023 15:47:25 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stafford Horne <shorne@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dinh Nguyen <dinguyen@kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH] arm64: Fix 32-bit compatible userspace write size overflow error
Date:   Thu, 16 Nov 2023 15:47:05 +0800
Message-ID: <20231116074706.3448008-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
not right. The specified "addr + size" is greater than 32-bit limit and
should return -EFAULT, but TASK_SIZE_MAX still defined as UL(1) << VA_BITS
in U32 mode, which is much greater than "addr + size" and cannot catch the
overflow error.

Fix above error by checking 32-bit limit if it is 32-bit compatible
userspace program.

How to reproduce:

The test program is as below:

cat test.c
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

aarch64-linux-gnu-gcc --static test.c -o test
arm-linux-gnueabi-gcc --static test.c -o test32

Before applying this patch, userspace 32-bit program return 1112 if the
write size = -1 as below:
	/root # ./test
	[INFO][test.c][32][main]:ret=-1
	[INFO][test.c][33][main]:size_max=-1
	[INFO][test.c][36][main]:INFO: end
	/root # ./test32
	[INFO][test.c][32][main]:ret=1112
	[INFO][test.c][33][main]:size_max=-1
	test32: test.c:34: main: Assertion `ret==-1' failed.
	Aborted

After applying this patch, userspace 32-bit program return -1 if the write
size = -1 as expected as below:
	/root # ./test
	[INFO][test.c][32][main]:ret=-1
	[INFO][test.c][33][main]:size_max=-1
	[INFO][test.c][36][main]:INFO: end
	/root # ./test32
	[INFO][test.c][32][main]:ret=-1
	[INFO][test.c][33][main]:size_max=-1
	[INFO][test.c][36][main]:INFO: end

Fixes: 967747bbc084 ("uaccess: remove CONFIG_SET_FS")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/processor.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index e5bc54522e71..6a087d58a90a 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -52,7 +52,12 @@
 
 #define DEFAULT_MAP_WINDOW_64	(UL(1) << VA_BITS_MIN)
 #define TASK_SIZE_64		(UL(1) << vabits_actual)
+#ifdef CONFIG_COMPAT
+#define TASK_SIZE_MAX		(test_thread_flag(TIF_32BIT) ? \
+				UL(0x100000000) : (UL(1) << VA_BITS))
+#else
 #define TASK_SIZE_MAX		(UL(1) << VA_BITS)
+#endif
 
 #ifdef CONFIG_COMPAT
 #if defined(CONFIG_ARM64_64K_PAGES) && defined(CONFIG_KUSER_HELPERS)
-- 
2.34.1

