Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4447CC9A2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343965AbjJQRPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjJQRPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:15:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2199210A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:15:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41991C433C8;
        Tue, 17 Oct 2023 17:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697562907;
        bh=+CBjLEFb4wmDDnNBt4MhS4XRtqrlhYVNwouQ49mHSfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k5SYs4+rLij5pmhwLIoXkGMJ64onj4o3ZyPX+EQB9hXaLm+pDshJR0BxB84at44WO
         +JXB4wK29d62NAy5GKmojMalQz7qI9YPX+HINaKUhh2BrvItdVn6bs0VuYUrY/1CO8
         79JgLcBtPNmWwcazvqI5RygM/ljBEIsppD6wV5j7S5u/FMBYE+2HuCCL9rsea5Tm3A
         h1WuL5PyB/cq139Iue9WN4RJ2VDLVmuYrP/wsQ8XPZujAzJ4Ba9BoHq/dFZZq1wHg8
         vYecG/yPBfyq9zfpPrIP1KnPQ4L7gzDwJ0fQZp6ImT+Bag+jgFh96zBfAmBGEtia2W
         2OSL2MxoXH9gA==
Date:   Tue, 17 Oct 2023 10:15:05 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Breno Leitao <leitao@debian.org>, tglx@linutronix.de, bp@alien8.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <20231017171505.6bsecux7vjuluhp2@treble>
References: <20231010103028.4192223-1-leitao@debian.org>
 <ZSca08rnmZfkONEH@gmail.com>
 <ZSfucR6docdnLznb@gmail.com>
 <20231012170548.o5vi4kgpvpjyld7s@treble>
 <ZShALJDaxJ9VJvek@gmail.com>
 <20231012204347.4aei5jr64fsv2iv5@treble>
 <ZSkhE2GWfGRW+9Hh@gmail.com>
 <20231015141147.qeczgcfnl73zcqao@treble>
 <ZS0GQoEsG/20IvnE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZS0GQoEsG/20IvnE@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:45:38AM +0200, Ingo Molnar wrote:
> * Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > On Fri, Oct 13, 2023 at 12:50:59PM +0200, Ingo Molnar wrote:
> > > * Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > > > On Thu, Oct 12, 2023 at 08:51:24PM +0200, Ingo Molnar wrote:
> > > > > > Another way to avoid ifdeffery:
> > > > > > 
> > > > > > static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
> > > > > > 	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_CMD_AUTO : RETBLEED_CMD_OFF;
> > > > > 
> > > > > I think we could make it a simple:
> > > > > 
> > > > > 	static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init = IS_ENABLED(CONFIG_MITIGATION_RETBLEED);
> > > > > 
> > > > > Because RETBLEED_CMD_AUTO && RETBLEED_CMD_OFF maps naturally to 1 and 0. 
> > > > > Maybe add a comment to the enum to maintain this property in the future 
> > > > > too.
> > > > 
> > > > Hm, that both obfuscates the default and makes it fragile.  The fact
> > > > that it would need a comment to try to prevent breaking it in the future
> > > > is a clue that maybe we shouldn't do it ;-)
> > > 
> > > Can be enforced with BUILD_BUG_ON().
> > 
> > That replaces fragility with brittleness.  If we change a default then
> > we have to go rearrange the corresponding enum, and update the
> > BUILD_BUG_ONs.
> 
> How realistic is that? A world in which an enum named '*_OFF' isn't zero 
> and the most obvious second enum isn't 'auto' would be unconditionally sad 
> IMO...

I'm glad you asked ;-)

Not only is it realistic, it already seems to be the case for the
majority of the enums which are used for defaults:

enum l1tf_mitigations {
	L1TF_MITIGATION_OFF,
	L1TF_MITIGATION_FLUSH_NOWARN,
	L1TF_MITIGATION_FLUSH, /* default */
	L1TF_MITIGATION_FLUSH_NOSMT,
	L1TF_MITIGATION_FULL,
	L1TF_MITIGATION_FULL_FORCE
};

enum taa_mitigations {
	TAA_MITIGATION_OFF,
	TAA_MITIGATION_UCODE_NEEDED,
	TAA_MITIGATION_VERW, /* default */
	TAA_MITIGATION_TSX_DISABLED,
};

enum mmio_mitigations {
	MMIO_MITIGATION_OFF,
	MMIO_MITIGATION_UCODE_NEEDED,
	MMIO_MITIGATION_VERW, /* default */
};

enum srbds_mitigations {
	SRBDS_MITIGATION_OFF,
	SRBDS_MITIGATION_UCODE_NEEDED,
	SRBDS_MITIGATION_FULL, /* default */
	SRBDS_MITIGATION_TSX_OFF,
	SRBDS_MITIGATION_HYPERVISOR,
};

enum l1d_flush_mitigations {
	L1D_FLUSH_OFF = 0, / * default */
	L1D_FLUSH_ON,
};

enum gds_mitigations {
	GDS_MITIGATION_OFF,
	GDS_MITIGATION_UCODE_NEEDED,
	GDS_MITIGATION_FORCE,
	GDS_MITIGATION_FULL, /* default */
	GDS_MITIGATION_FULL_LOCKED,
	GDS_MITIGATION_HYPERVISOR,
};

enum srso_mitigation_cmd {
	SRSO_CMD_OFF,
	SRSO_CMD_MICROCODE,
	SRSO_CMD_SAFE_RET, /* default */
	SRSO_CMD_IBPB,
	SRSO_CMD_IBPB_ON_VMEXIT,
};

It's dangerous (and in fact antithetical to the concept of enums!) to
make assumptions about enum values, for both existing and future code.

> > More importantly, it's still less readable because the reader now has to 
> > go read the enum values to cross-reference the hard-coded values of 0 and 
> > 1 with the enums which are used everywhere else.
> 
> They'd have to do that anyway, to make sense of the enum jungle.

Why?  The enum values are completely opaque to the code as far as I can
tell.  Changing that will just make the code even more obtuse.

I don't see any benefit in hard-coding them.  What's the point?

-- 
Josh
