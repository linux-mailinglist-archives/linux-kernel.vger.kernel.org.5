Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2877B78E238
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343572AbjH3WSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343560AbjH3WSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:18:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B49CFB;
        Wed, 30 Aug 2023 15:18:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A160962C0A;
        Wed, 30 Aug 2023 22:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF95C433C8;
        Wed, 30 Aug 2023 22:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693433901;
        bh=r2S4tcK1nsnRmvP4S5aT+PK15LEdeTY3R3y2UJ7u114=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rvKmXxaVTmqRs2XtFrlEw88MbycRV5aYKyJWhnqiNxepcsp7/HEN3VJ8rvgAOAHw4
         C3V8dQTXicHO+/SjemWfmW0WZKWxM1THLDY2WmEAnn2HhRY9bV94T9GAn5lViyzxMF
         RhIIU15JZyspxFRUrfENOTYgip7uoeO2GBXEX7KxjJQBUZiSBt+OORjycrXruTWCe6
         X+9kucXmM6glY7QdF2ybDQYt/Y46xsT49VdUeceJKvtD/QyJcQtPFNp8ss8YSpnCei
         OKLchxIbrl3C8O6WCsKdprKpjY4o1wHERUdGZDPCdL7fW8S2ACecIaRYVX3m3XYwrN
         ec2PeOqAQZ/Ww==
Date:   Wed, 30 Aug 2023 23:18:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH] HWPOISON: add a pr_err message when forcibly send a
 sigbus
Message-ID: <20230830221814.GB30121@willie-the-truck>
References: <20230819102212.21103-1-xueshuai@linux.alibaba.com>
 <20230821105025.GB19469@willie-the-truck>
 <44c4d801-3e21-426b-2cf0-a7884d2bf5ff@linux.alibaba.com>
 <54114b64-4726-da46-8ffa-16749ec0887a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54114b64-4726-da46-8ffa-16749ec0887a@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 09:41:55AM +0800, Shuai Xue wrote:
> On 2023/8/22 09:15, Shuai Xue wrote:
> > On 2023/8/21 18:50, Will Deacon wrote:
> >>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> >>> index 3fe516b32577..38e2186882bd 100644
> >>> --- a/arch/arm64/mm/fault.c
> >>> +++ b/arch/arm64/mm/fault.c
> >>> @@ -679,6 +679,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
> >>>  	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
> >>>  		unsigned int lsb;
> >>>  
> >>> +		pr_err("MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
> >>> +		       current->comm, current->pid, far);
> >>>  		lsb = PAGE_SHIFT;
> >>>  		if (fault & VM_FAULT_HWPOISON_LARGE)
> >>>  			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
> >>
> >> Hmm, I'm not convinced by this. We have 'show_unhandled_signals' already,
> >> and there's plenty of code in memory-failure.c for handling poisoned pages
> >> reported by e.g. GHES. I don't think dumping extra messages in dmesg from
> >> the arch code really adds anything.
> > 
> > I see the show_unhandled_signals() will dump the stack but it rely on
> > /proc/sys/debug/exception-trace be set.
> > 
> > The memory failure is the top issue in our production cloud and also other hyperscalers.
> > We have received complaints from our operations engineers and end users that processes
> > are being inexplicably killed :(. Could you please consider add a message?

I don't have any objection to logging this stuff somehow, I'm just not
convinced that the console is the best place for that information in 2023.
Is there really nothing better?

Will
