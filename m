Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2037CD6B6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344708AbjJRIgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjJRIgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:36:50 -0400
Received: from out0-208.mail.aliyun.com (out0-208.mail.aliyun.com [140.205.0.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FCEB6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:36:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047205;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---.V1uac8-_1697618204;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.V1uac8-_1697618204)
          by smtp.aliyun-inc.com;
          Wed, 18 Oct 2023 16:36:45 +0800
Date:   Wed, 18 Oct 2023 16:36:43 +0800
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
Message-ID: <20231018083643.GB87734@k08j02272.eu95sqa>
References: <cover.1689130310.git.houwenlong.hwl@antgroup.com>
 <c85903a7cfad37d14a7e5a4df9fc7119a3669fb3.1689130310.git.houwenlong.hwl@antgroup.com>
 <ZS0lEmEpQOz4iQ4Q@gmail.com>
 <20231017072311.GA46993@k08j02272.eu95sqa>
 <ZS6F46vJfca5f6f8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS6F46vJfca5f6f8@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 09:02:27PM +0800, Ingo Molnar wrote:
> 
> * Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> 
> > Hi Ingo,
> > 
> > I have sent patch #6 separately for x86. Do you have any ideas about 
> > building the head code as PIE? Should I resend the patchset for the PIE 
> > feature?
> 
> So I had a brief look, and despite reading 0/43 it was unclear to me what 
> the precise advantages of building as PIE are.
>
> Ie. could you please outline:
> 
>  - *Exactly* how much PIE based KASLR randomization would gain us in terms 
>    of randomization granularity and effective number of randomization bits, 
>    compared to the current status quo?
> 
>  - How is code generation changed at the instruction level - how does 
>    kernel size change and what are the micro-advantages/disadvantages?
> 
>  - Are there any other advantages/motivation than improving KASLR?
> 
> Ie. before asking us to apply ~50 patches and add a whole new build mode 
> and the maintainance overhead to support it into infinity and beyond, could 
> you please offer a better list of pros and cons?
> 
Hi Ingo,

Thanks for your reply. I apologize for the confusion. Waht I meant to
say is that I would like to resend the remaining part of this patchset
that building the head code as PIE. As mentioned in the cover letter,
building the head code as PIE can eliminate certain workarounds such as
the "fixup_pointer" in head64.c and the inline assembly in
mem_encrypt_identity.c. This is considered a cleanup. However, it is
still necessary to use inline assembly to obtain the absolute symbol
value during the pagetable building process.

Regarding the entire PIE patchset, I agree that it is complex and there
are no obvious use cases apart from improving KASLR. As mentioned
earlier, the primary motivation is to increase the flexibility of the
kernel image address rather than prioritizing security, enabling the
kernel image to be placed at any virtual address. The use cases in our
internal environment are specific and not widespread, so we do not feel
an urgent need to push it forward at the moment.

Thanks!

> Thanks,
> 
> 	Ingo
