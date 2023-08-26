Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F087897E5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjHZP5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjHZP5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:57:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3108A1BCD
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 08:57:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE1B962926
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 15:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAE1C433C7;
        Sat, 26 Aug 2023 15:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693065464;
        bh=ZLi6SnUEQaEqUm3Se6W/o998WV3XUnBEHIK8cdXO59w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HaEOxwq3ywvgF3GKb3s2lAZi3Ss0f5Qmonfcc9sC/9wqGS0nES1JbHL83yzrSnn5x
         TckdK5K1GaJtdzOnQ2Fqw7+VUw+yFTmkVfoWxPRkzDcBj6SIKo8PCQDeB2IxUVWVSZ
         x9RDwn/3wksGs2ZjWADn2Xb0c6SedhUDjL0GiIXNBFx6ljEH/HW4DK4jYYR2PWhFQM
         uWJPKG2NMRiKs/kZbLJ5xRoo7Tm1M4h+qbvU/WDuytykV0/B2S7rPeJ+msFJlUz6VJ
         JAt3ePjWZmVetSKWOTsLThIY3c38wyUdlTqh870MPONOuONM2j2mTgOx8PLfayWo5n
         elSOo4JaEh5TQ==
Date:   Sat, 26 Aug 2023 08:57:42 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/23] SRSO fixes/cleanups
Message-ID: <20230826155742.2hqirzpouzh5pduf@treble>
References: <cover.1692919072.git.jpoimboe@kernel.org>
 <ZOiEvVOqwjZHzVgT@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZOiEvVOqwjZHzVgT@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 12:38:53PM +0200, Ingo Molnar wrote:
> Thank you, this all looks very nice. I've applied your fixes to
> tip:x86/bugs, with the exception of the two KVM enablement patches.
> 
> I've also cherry-picked the apply_returns() fix separately to x86/urgent,
> AFAICS that's the only super-urgent fix we want to push to the final v6.5
> release before the weekend, right? The other fixes look like
> reporting bugs, Kconfig oddities and inefficiencies at worst. Backporters
> may still pick the rest from x86/bugs too - but we are too close to the
> release right now.

As far as I can tell, the apply_returns() fix isn't necessarily urgent,
since after commit 095b8303f383 it went from being an actual bug to just
dead code: the optimization will never take effect now that none of the
rethunk cases use __x86_return_thunk.

On the other hand, if I'm too late sending this, it should be harmless
to merge it into the final v6.5 release.

For the rest of the patches, I think the merge window is fine.

Thanks!

-- 
Josh
