Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4FB7CBC27
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjJQHXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjJQHXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:23:18 -0400
Received: from out0-209.mail.aliyun.com (out0-209.mail.aliyun.com [140.205.0.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E4E8E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:23:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047212;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---.V10sGCn_1697527391;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.V10sGCn_1697527391)
          by smtp.aliyun-inc.com;
          Tue, 17 Oct 2023 15:23:12 +0800
Date:   Tue, 17 Oct 2023 15:23:11 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "=?UTF-8?B?bWFpbnRhaW5lcjpYODYgQVJDSElURUNUVVJFIDMyLUJJVCBBTkQgNjQtQklU?=" 
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Pasha Tatashin" <pasha.tatashin@soleen.com>
Subject: Re: [PATCH RFC 1/7] x86/head/64: Mark startup_gdt and
 startup_gdt_descr as __initdata
Message-ID: <20231017072311.GA46993@k08j02272.eu95sqa>
References: <cover.1689130310.git.houwenlong.hwl@antgroup.com>
 <c85903a7cfad37d14a7e5a4df9fc7119a3669fb3.1689130310.git.houwenlong.hwl@antgroup.com>
 <ZS0lEmEpQOz4iQ4Q@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS0lEmEpQOz4iQ4Q@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 07:57:06PM +0800, Ingo Molnar wrote:
> 
> * Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> 
> > As startup_gdt and startup_gdt_descr are only used in booting, make them
> > as __initdata to allow them to be freed after boot.
> > 
> > Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> > ---
> >  arch/x86/kernel/head64.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> > index 49f7629b17f7..dd357807ffb5 100644
> > --- a/arch/x86/kernel/head64.c
> > +++ b/arch/x86/kernel/head64.c
> > @@ -69,7 +69,7 @@ EXPORT_SYMBOL(vmemmap_base);
> >  /*
> >   * GDT used on the boot CPU before switching to virtual addresses.
> >   */
> > -static struct desc_struct startup_gdt[GDT_ENTRIES] = {
> > +static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
> >  	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
> >  	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
> >  	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
> > @@ -79,7 +79,7 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] = {
> >   * Address needs to be set at runtime because it references the startup_gdt
> >   * while the kernel still uses a direct mapping.
> >   */
> > -static struct desc_ptr startup_gdt_descr = {
> > +static struct desc_ptr startup_gdt_descr __initdata = {
> >  	.size = sizeof(startup_gdt),
> >  	.address = 0,
> 
> Yeah, so I think this and patch #1 are independently useful of the PIE 
> feature, and I merged them into tip:x86/boot for a v6.7 merge.
> 
> Mind re-sending any other patches for x86 that can be merged? For example 
> patch #6 looks good too, but was mixed up a bit with a previous 
> PIE-enablement patch. Moving the __head definition to a header should also 
> probably done as a separate patch, followed by the widening of its use.
>
Hi Ingo,

I have sent patch #6 separately for x86. Do you have any ideas about
building the head code as PIE? Should I resend the patchset for the PIE
feature?

Thanks!

> Thanks,
> 
> 	Ingo
