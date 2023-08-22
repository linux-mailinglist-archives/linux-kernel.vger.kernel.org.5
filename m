Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D46784C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjHVV7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHVV7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:59:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661A5CE8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:59:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 037FF60EA0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 21:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D606BC433C7;
        Tue, 22 Aug 2023 21:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692741544;
        bh=sfm1SPxcuzXHDiKsq8vWr9D2Z8Po/kb2b91YeVVlxEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bTL/cfik2EBAetBY5d9zs3VVGPWGM2570QAHibQ8QhiMUaWqfnDqTwZrj9Zrf+M5M
         /fZjqo4q1iDSvYX0/T5X1OxAsYLhNnCYb9PVqADTSRpJ4oJx6zGTOGuO7GfqrUriSo
         BdEPcIvQqH1ganyJLo61lNqDU8q4Ts2mZOYCwraHEUdmSgC1jo/eVxb2HkmWHIjU04
         V4RPOLk4E6EtI4c4Tqemz69PnC5AXtKkGGFOeWRNFvzzNwQzKPQcFTs+zg033/uQeu
         mxOSb77L0WAZiVw5iKJEyHxvrAEZTxRxaY9WZTqcnNMWAabQYcPPTbTPyBhiwumj+9
         t2S0q1v5t19Cw==
Date:   Tue, 22 Aug 2023 14:59:01 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 04/22] x86/srso: Fix SBPB enablement for
 spec_rstack_overflow=off
Message-ID: <20230822215901.nkikxpcmlrssi42l@treble>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <23a121e309d5e880eb35c441d9bdfa642d6d59f4.1692580085.git.jpoimboe@kernel.org>
 <20230821141619.GCZONxs5OdbbXFYSq2@fat_crate.local>
 <20230821163649.dyhxdeewlf6eerda@treble>
 <20230822055452.GDZORNrNdYc3OmGygU@fat_crate.local>
 <20230822060706.GEZORQiq136ZR5Tnc0@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230822060706.GEZORQiq136ZR5Tnc0@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 08:07:06AM +0200, Borislav Petkov wrote:
> On Tue, Aug 22, 2023 at 07:54:52AM +0200, Borislav Petkov wrote:
> > If you goto pred_cmd, you will overwrite it with PRED_CMD_SBPB here.
> 
> Looking at this more:
> 
> "If SRSO mitigation is not required or is disabled, software may use
> SBPB on context/virtual machine switch to help protect against
> vulnerabilities like Spectre v2."
> 
> I think we actually want this overwrite to happen.

Yeah, I had seen that.  The combination of spectre_v2_user=on with
srso=off doesn't make a whole lot of sense, but... give the user what
they want and all.  Which would presumably be IBPB *without* the SRSO
mitigation (aka SBPB).

> But then if retbleed=ibpb, entry_ibpb() will do bit 0 unconditionally...
> 
> Hmm, lemme talk to people.

I don't think we need to worry about that, SBPB is >= fam19 but retbleed
is <= fam17.  So either way (0x17 or 0x19) entry_ibpb() should do IBPB.

-- 
Josh
