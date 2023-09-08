Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F87879870A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 14:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbjIHMcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 08:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjIHMcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:32:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382161BD3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 05:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694176358; x=1725712358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/jAOUsolwoX7os7dExPnCevCBnOPmg9WR0YLup0hDJk=;
  b=CLLDd3E0KXOxBGOhhE+D5yX9GY7HwmI9oife1BV8a4Z2dpL/TDpIE0Yi
   2iE2b1U0USNZgijB78aP9Wk6VvDdn4LozRPWAbhnt+bEvZVLhm/tDZCU8
   olL7GY21XyLBovt1Ob2JW9lrk1pHJ8TlXUuoStM0Lkr+PHQEsS/nmmz94
   +Gx8HnMFXzODD62tkEqhsknBDpYOeObzzenl4nad942SguZIWCQptVous
   LdereX5tZDrPDS0x4y12+1I5WsBc8J2E5rjjdWi/hIbIouveWERSfMlwX
   wK8gtj9wGGUx9Y1/vcxd/KbcUoXspzz/0V6Lzkt8AZAAyD5N7VO2maUB0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="367896573"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="367896573"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 05:32:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="745599042"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="745599042"
Received: from drosu-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.61.43])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 05:32:35 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 69CF5104C1F; Fri,  8 Sep 2023 15:32:33 +0300 (+03)
Date:   Fri, 8 Sep 2023 15:32:33 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Aaron Lu <aaron.lu@intel.com>, Kees Cook <keescook@chromium.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
Message-ID: <20230908123233.dpbpohgrbyyxekzk@box.shutemov.name>
References: <20230829114816.GA508985@ziqianlu-dell>
 <ZO3hQ0rbr8QuUjVI@debian.me>
 <20230829125134.GA509331@ziqianlu-dell>
 <20230829125939.bcg2r6hwqf45npko@box.shutemov.name>
 <20230829140451.GA509854@ziqianlu-dell>
 <20230907131409.masxz42ik6u456qp@box.shutemov.name>
 <20230908060230.GA283801@ziqianlu-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908060230.GA283801@ziqianlu-dell>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 02:02:30PM +0800, Aaron Lu wrote:
> On Thu, Sep 07, 2023 at 04:14:09PM +0300, Kirill A. Shutemov wrote:
> > On Tue, Aug 29, 2023 at 10:04:51PM +0800, Aaron Lu wrote:
> > > > Could you show dmesg of the first kernel before kexec?
> > > 
> > > Attached.
> > > 
> > > BTW, kexec is invoked like this:
> > > kver=6.4.0-rc5-00009-g75d090fd167a
> > > kdir=$HOME/kernels/$kver
> > > sudo kexec -l $kdir/vmlinuz-$kver --initrd=$kdir/initramfs-$kver.img --append="root=UUID=4381321e-e01e-455a-9d46-5e8c4c5b2d02 ro net.ifnames=0 acpi_rsdp=0x728e8014 no_hash_pointers sched_verbose selinux=0"
> > 
> > I don't understand why it happens.
> > 
> > Could you check if this patch changes anything:
> > 
> > diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> > index 94b7abcf624b..172c476ff6f3 100644
> > --- a/arch/x86/boot/compressed/misc.c
> > +++ b/arch/x86/boot/compressed/misc.c
> > @@ -456,10 +456,12 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
> >  
> >  	debug_putstr("\nDecompressing Linux... ");
> >  
> > +#if 0
> >  	if (init_unaccepted_memory()) {
> >  		debug_putstr("Accepting memory... ");
> >  		accept_memory(__pa(output), __pa(output) + needed_size);
> >  	}
> > +#endif
> >  
> >  	__decompress(input_data, input_len, NULL, NULL, output, output_len,
> >  			NULL, error);
> > -- 
> 
> It solved the problem.

Looks like increasing BOOT_INIT_PGT_SIZE fixes the issue. I don't yet
understand why and how unaccepted memory is involved. I will look more
into it.

Enabling CONFIG_RANDOMIZE_BASE also makes the issue go away.

Kees, maybe you have a clue?

diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 9191280d9ea3..26ccce41d781 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -40,7 +40,7 @@
 #ifdef CONFIG_X86_64
 # define BOOT_STACK_SIZE	0x4000
 
-# define BOOT_INIT_PGT_SIZE	(6*4096)
+# define BOOT_INIT_PGT_SIZE	(7*4096)
 # ifdef CONFIG_RANDOMIZE_BASE
 /*
  * Assuming all cross the 512GB boundary:
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
