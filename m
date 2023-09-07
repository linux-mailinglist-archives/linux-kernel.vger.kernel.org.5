Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98898797AFA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245687AbjIGR6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245646AbjIGR6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:58:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2AF1997
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694109499; x=1725645499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O6ZhqWgwoI8MAxW6/N8+5IhjZO91cgxHuTDSEqgn/Ok=;
  b=B0ZzDYdZYhPPaOulHfUOYFVDtRfbnphvUiXKj1irmz8DrottntMelvMx
   g+JFut2Lyefg3hffp172x9/VmqStMS/dv/0nlH3IWUbLiyhJI2Ndwgr/e
   8ssMsLsJuMPAOn3Ch2AVS7WVSWMfgS0JUWwcOx1xGWYTEfV4QkGkL48px
   V0K4ExyfmrYLbWobyVBO+06/SRw2ofKhYGNWmB2BzH0f7BiKqfoibAGgG
   IKB58eMg3ZDwGwAnv/BlhN5SgsmGXqlp8cP04dJgP7xEqWQ1actsHL8WW
   Cus4k73mmcZz/oGVQs1Rxqbi4fr28PMfyDKkDTvv0P+Z/etzo3SBiivr8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="367579634"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="367579634"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 06:14:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="885141188"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="885141188"
Received: from oshragax-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.215.248])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 06:13:58 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 73345104860; Thu,  7 Sep 2023 16:14:09 +0300 (+03)
Date:   Thu, 7 Sep 2023 16:14:09 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
Message-ID: <20230907131409.masxz42ik6u456qp@box.shutemov.name>
References: <20230829114816.GA508985@ziqianlu-dell>
 <ZO3hQ0rbr8QuUjVI@debian.me>
 <20230829125134.GA509331@ziqianlu-dell>
 <20230829125939.bcg2r6hwqf45npko@box.shutemov.name>
 <20230829140451.GA509854@ziqianlu-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829140451.GA509854@ziqianlu-dell>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 10:04:51PM +0800, Aaron Lu wrote:
> > Could you show dmesg of the first kernel before kexec?
> 
> Attached.
> 
> BTW, kexec is invoked like this:
> kver=6.4.0-rc5-00009-g75d090fd167a
> kdir=$HOME/kernels/$kver
> sudo kexec -l $kdir/vmlinuz-$kver --initrd=$kdir/initramfs-$kver.img --append="root=UUID=4381321e-e01e-455a-9d46-5e8c4c5b2d02 ro net.ifnames=0 acpi_rsdp=0x728e8014 no_hash_pointers sched_verbose selinux=0"

I don't understand why it happens.

Could you check if this patch changes anything:

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 94b7abcf624b..172c476ff6f3 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -456,10 +456,12 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 
 	debug_putstr("\nDecompressing Linux... ");
 
+#if 0
 	if (init_unaccepted_memory()) {
 		debug_putstr("Accepting memory... ");
 		accept_memory(__pa(output), __pa(output) + needed_size);
 	}
+#endif
 
 	__decompress(input_data, input_len, NULL, NULL, output, output_len,
 			NULL, error);
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
