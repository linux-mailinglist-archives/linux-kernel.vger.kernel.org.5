Return-Path: <linux-kernel+bounces-89971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B92A86F85F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4342B28119A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B852C15D1;
	Mon,  4 Mar 2024 02:02:37 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274FB10F9;
	Mon,  4 Mar 2024 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709517757; cv=none; b=spdyYrcDw94hjcVlZ+fBGFADm1kwzWgMriHAjDRIQr6iheu1hUJYBPaNycSyUKBDWFZKMt2dPkNlrath8B1Byf/SnGDEEAPuxxIXPkpq+SSxstiwGOb/SU1jSjuVF/AL6mfL3kCzirYGhqRUwFWz2XSAnV0Q9zj/R+TjzWv/XIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709517757; c=relaxed/simple;
	bh=mNw8COTtyAK/yrEut5kqQsziR57os7Zc/8gQK6TzrhU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j5P4It95zdx/IShMvKLLKckPl1IHAu1NLc91A0EhVT+RMUnyNHhZQgxWjbcihTXa7/dpaLwDD6/rtLbXlKbT0hQNh/jJGLDar3APUuIh/dIHyqyPBjG/9tl42sFlFGYpxosQ3zwLN+XT0V9jvQTpvLoSQUOxsZ9mZGcTr+F5soA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Tp22Y5GbQz1Q9gy;
	Mon,  4 Mar 2024 10:00:05 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 2384F14038F;
	Mon,  4 Mar 2024 10:02:25 +0800 (CST)
Received: from huawei.com (10.67.189.167) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 4 Mar
 2024 10:02:24 +0800
From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
To: <gustavoars@kernel.org>, <akpm@linux-foundation.org>,
	<jpoimboe@kernel.org>, <peterz@infradead.org>, <dave.hansen@linux.intel.com>,
	<kirill.shutemov@linux.intel.com>, <keescook@chromium.org>,
	<xiaojiangfeng@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<linux-mm@kvack.org>, <nixiaoming@huawei.com>, <kepler.chenxin@huawei.com>,
	<wangbing6@huawei.com>, <wangfangpeng1@huawei.com>, <douzhaolei@huawei.com>
Subject: [PATCH] usercopy: delete __noreturn from usercopy_abort
Date: Mon, 4 Mar 2024 09:39:45 +0800
Message-ID: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
X-Mailer: git-send-email 1.8.5.6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)

When the last instruction of a noreturn function is a call
to another function, the return address falls outside
of the function boundary. This seems to cause kernel
to interrupt the backtrace.

My testcase is as follow:
```

static volatile size_t unconst = 0;
/*
check_object_size
    __check_object_size
        check_kernel_text_object
            usercopy_abort("kernel text", ...)
*/
void test_usercopy_kernel(void)
{
	check_object_size(schedule, unconst + PAGE_SIZE, 1);
}

static int __init test_usercopy_init(void)
{
        test_usercopy_kernel();
	return 0;
}

static void __exit test_usercopy_exit(void)
{
}

module_init(test_usercopy_init);
module_exit(test_usercopy_exit);
MODULE_LICENSE("GPL");
```

Running the testcase cause kernel oops,
and then the call stack is incorrect:
```
usercopy: Kernel memory exposure attempt detected from kernel text
Kernel BUG at usercopy_abort+0x98/0x9c
Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
Modules linked in: test_usercopy(O+) usbcore usb_common
CPU: 0 PID: 609 Comm: insmod Tainted: G           O      5.10.0 #11
Hardware name: Hisilicon A9
PC is at usercopy_abort+0x98/0x9c
LR is at usercopy_abort+0x98/0x9c
[...]
 (usercopy_abort) from (memfd_fcntl+0x0/0x654)
 (memfd_fcntl) from (0xef7368f8)
Code: e1a01004 e58dc004 e58de000 eb108378 (e7f001f2)
---[ end trace e5fdc684259b0883 ]---
Kernel panic - not syncing: Fatal exception
```

Why Does the kernel backtrace cause errors?
Because usercopy_abort is marked as __noreturn.

You can see the related disassembling:
```
c02f24ac <__check_object_size>:
static_key_count():
[...]
check_kernel_text_object():
linux/mm/usercopy.c:125
        usercopy_abort("kernel text", NULL, to_user, ptr - textlow, n);
c02f26c4:       e3040110        movw    r0, #16656      ; 0x4110
c02f26c8:       e58d5000        str     r5, [sp]
c02f26cc:       e0443003        sub     r3, r4, r3
c02f26d0:       e1a02007        mov     r2, r7
c02f26d4:       e34c0096        movt    r0, #49302      ; 0xc096
c02f26d8:       ebffff4c        bl      c02f2410 <usercopy_abort>

c02f26dc <memfd_fcntl>:
memfd_fcntl():
[...]
```

The last instruction of __check_object_size is a call to usercopy_abort,
which is a noreturn function, the return address falls outside of the
__check_object_size function boundary, the return address falls into
the next function memfd_fcntl, therefore,
an error occurs when the kernel backtrace.

Delete __noreturn from usercopy_abort,
the correct call stack is as follow:
```
 (usercopy_abort) from (__check_object_size+0x170/0x234)
 (__check_object_size) from (test_usercopy_init+0x8/0xc0 [test_usercopy])
 (test_usercopy_init [test_usercopy]) from (do_one_initcall+0xac/0x204)
 (do_one_initcall) from (do_init_module+0x44/0x1c8)
 (do_init_module) from (load_module+0x1d48/0x2434)
 (load_module) from (sys_finit_module+0xc0/0xf4)
 (sys_finit_module) from (ret_fast_syscall+0x0/0x50)
```

Fixes: b394d468e7d7 ("usercopy: Enhance and rename report_usercopy()")

Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
---
 include/linux/uaccess.h   | 2 +-
 mm/usercopy.c             | 2 +-
 tools/objtool/noreturns.h | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 3064314..c37af70 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -437,7 +437,7 @@ static inline void user_access_restore(unsigned long flags) { }
 #endif
 
 #ifdef CONFIG_HARDENED_USERCOPY
-void __noreturn usercopy_abort(const char *name, const char *detail,
+void usercopy_abort(const char *name, const char *detail,
 			       bool to_user, unsigned long offset,
 			       unsigned long len);
 #endif
diff --git a/mm/usercopy.c b/mm/usercopy.c
index 83c164a..ca1b22e 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -83,7 +83,7 @@ static noinline int check_stack_object(const void *obj, unsigned long len)
  * kmem_cache_create_usercopy() function to create the cache (and
  * carefully audit the whitelist range).
  */
-void __noreturn usercopy_abort(const char *name, const char *detail,
+void usercopy_abort(const char *name, const char *detail,
 			       bool to_user, unsigned long offset,
 			       unsigned long len)
 {
diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index 1685d7e..c7e341c 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -40,7 +40,6 @@
 NORETURN(snp_abort)
 NORETURN(start_kernel)
 NORETURN(stop_this_cpu)
-NORETURN(usercopy_abort)
 NORETURN(x86_64_start_kernel)
 NORETURN(x86_64_start_reservations)
 NORETURN(xen_cpu_bringup_again)
-- 
1.8.5.6


