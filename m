Return-Path: <linux-kernel+bounces-31951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF4C835423
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 02:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EC92832B9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 01:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781E0360B9;
	Sun, 21 Jan 2024 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ak+Dibr1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62DB360BF
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 01:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705802143; cv=none; b=e6xjZbnPUZXT47ierZnLcZ4Y7+k5cGREAI1382FgLztbdToTF+D8Oc1BBp79M5kf2fFTFt2eBEGdFyj+oOzqrowSzW7mgCRxQ7hbG3/CjCe8mj0Oc+TwwXlyHvSHlP1Lqkvh5t1AB9aQ8k02IXsbw3H/gmkU1ZzRFh6DOtNaj8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705802143; c=relaxed/simple;
	bh=F07fcMUCVAhZ2po5qnBsuN6WuYRNvBEurPJ6lfARstY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTeTnbr1kQuYkWJgSU5PkratszdPHdbSFvP4VP2sfTkd43l8Ktv/2pYEpK4gJb7vxQu7PIPSYonf1vLjOVm2xRbMO6AraPhJwcwbWPn3JZEc6i/RXy0W7qLZcxaCb2+fBgKpsVhn41LAFfWxgw8ymPekliSyeppfDqLVtMnUe8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ak+Dibr1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705802139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bn2lkxxGrsi3E9Vcx5NFx8RtBRe4v7W5psgsNCHmDng=;
	b=Ak+Dibr1FCJBwu59M+szqYrFMurngkYybSCz40DgcaN/FN0foN3qHK03OeTfzPJF6t8FzY
	ll36sUY5ZsY2GvQgruA6/8fbe2plhiQhbPoe+EwYeSeUXuE9sM6mM4vDjrwUciFP73NYAY
	sn8bbpEW39QIFr7Iw6eN9Bg4ECWDRZ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-1HnnZH15OaydAjxT0WE9tA-1; Sat, 20 Jan 2024 20:55:35 -0500
X-MC-Unique: 1HnnZH15OaydAjxT0WE9tA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A53885A588;
	Sun, 21 Jan 2024 01:55:35 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B83D651D5;
	Sun, 21 Jan 2024 01:55:33 +0000 (UTC)
Date: Sun, 21 Jan 2024 09:55:29 +0800
From: Baoquan He <bhe@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, kexec@lists.infradead.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
	akpm@linux-foundation.org, ebiederm@xmission.com,
	hbathini@linux.ibm.com, piliu@redhat.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 11/14] arm, crash: wrap crash dumping code into crash
 related ifdefs
Message-ID: <Zax5kXfiREk2bDbu@MiWiFi-R3L-srv>
References: <20240119145241.769622-12-bhe@redhat.com>
 <202401202057.aPg08Eh8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401202057.aPg08Eh8-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 01/20/24 at 08:13pm, kernel test robot wrote:
> Hi Baoquan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to tip/x86/core arm64/for-next/core powerpc/next powerpc/fixes v6.7 next-20240119]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/kexec-split-crashkernel-reservation-code-out-from-crash_core-c/20240119-225820
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20240119145241.769622-12-bhe%40redhat.com
> patch subject: [PATCH v2 11/14] arm, crash: wrap crash dumping code into crash related ifdefs
> config: arm-randconfig-001-20240120 (https://download.01.org/0day-ci/archive/20240120/202401202057.aPg08Eh8-lkp@intel.com/config)
> compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project d92ce344bf641e6bb025b41b3f1a77dd25e2b3e9)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240120/202401202057.aPg08Eh8-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401202057.aPg08Eh8-lkp@intel.com/

Thanks for reporting this, I can reproduce it.

In the provided config, it has:

# CONFIG_MMU is not set
and all kexec/kdump related config items are unset. 

The if (!IS_ENABLED(CONFIG_CRASH_RESERVE)) checking will cause funciton
reserve_crashkernel() is compiled, but not built in. With CONFIG_MMU=no,
SECTION_SIZE is undefined on arm. So fix it by wrapping up
reserve_crashkernel() inside CONFIG_CRASH_RESERVE ifdeffery scope.


From d580b65f6aa042233e228aab45609c3de88ab29e Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Mon, 15 Jan 2024 22:32:19 -0500
Subject: [PATCH] arm, crash: wrap crash dumping code into crash related ifdefs
Content-type: text/plain

Now crash codes under kernel/ folder has been split out from kexec
code, crash dumping can be separated from kexec reboot in config
items on arm with some adjustments.

Here use CONFIG_CRASH_RESERVE ifdef to replace CONFIG_KEXEC ifdef.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm/kernel/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index ff2299ce1ad7..7b33b157fca0 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -979,7 +979,7 @@ static int __init init_machine_late(void)
 }
 late_initcall(init_machine_late);
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_CRASH_RESERVE
 /*
  * The crash region must be aligned to 128MB to avoid
  * zImage relocating below the reserved region.
@@ -1066,7 +1066,7 @@ static void __init reserve_crashkernel(void)
 }
 #else
 static inline void reserve_crashkernel(void) {}
-#endif /* CONFIG_KEXEC */
+#endif /* CONFIG_CRASH_RESERVE*/
 
 void __init hyp_mode_check(void)
 {
-- 
2.41.0


