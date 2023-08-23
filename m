Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD447861D2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 22:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbjHWUze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 16:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbjHWUzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 16:55:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D9210D9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 13:55:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5486863AF4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 20:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAD1C433C8;
        Wed, 23 Aug 2023 20:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692824104;
        bh=VN9A/kYkj2AAlR3l05XefPml2GafbaNSfx7qwrnSdnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lXkHHmbCAzgs552GVdiLAgBztmDfkEVTqpTDMNk62JB2m/GHOyspF4uFaaSYcRg87
         HqJoAG7toZPk5maahsbSbeaYaBcoCSzLZ9V9CdXXwVkVWOqyoFGZli7ewtRIrJsL4F
         suAp+t+qpHp6eoAyNZCr+bsBa2mf7kHz/HHOjYBq/19fEx4OHKmxJYWKxkXfiOdxDR
         /AT76XTW6+3cFWMbGqv1AuM1sQs5tiED4P6CbhWaXhAmpF+cp7pNXqwUJNYynvZ+bV
         XJymxw6koTn1gbFXPRZ2VwyS06UmHRq+852EmN9d4FPXV9I0z+h+3TwAXsegSGUbs4
         aLuV5d2a1X3eg==
Date:   Wed, 23 Aug 2023 13:55:02 -0700
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
Subject: Re: [PATCH 05/22] x86/srso: Fix SBPB enablement for mitigations=off
Message-ID: <20230823205502.hrf2obiopghol2eo@treble>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <141c92f20ab46cf0c028e86b946134cd702d0ea5.1692580085.git.jpoimboe@kernel.org>
 <20230823055720.GDZOWfwIMn+o7spi8v@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823055720.GDZOWfwIMn+o7spi8v@fat_crate.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 07:57:20AM +0200, Borislav Petkov wrote:
> On Sun, Aug 20, 2023 at 06:19:02PM -0700, Josh Poimboeuf wrote:
> > If the user has requested no mitigations with mitigations=off, use the
> > lighter-weight SBPB instead of IBPB for other mitigations.
> > 
> > Note that even with mitigations=off, IBPB/SBPB may still be used for
> > Spectre v2 user <-> user protection.  Whether that makes sense is a
> > question for another day.
> 
> Well, with my user hat on, off means off.
> 
> IINM, spectre_v2_parse_cmdline() will give SPECTRE_V2_CMD_NONE to
> spectre_v2_select_mitigation() when mitigations=off.
> 
> spectre_v2_user_select_mitigation() will use the
> spectre_v2_select_mitigation()'s result, which turn into
> SPECTRE_V2_USER_CMD_NONE and then not enable *BPB either.

Ah, right.  I missed how spectre_v2_parse_user_cmdline() checks
spectre_v2_cmd.  That is quite the maze.

> So even if we set x86_pred_cmd to SBPB here, it won't do anything
> because X86_FEATURE_USE_IBPB won't be set and
> indirect_branch_prediction_barrier() will be a NOP.

Right.

> IOW, I think we should separate the check:
> 
>         if (cpu_mitigations_off())
>                 return;
> 
> at the beginning of srso_select_mitigation() so that it is crystal
> clear. Maybe even slap a comment over it.

Yeah, that's fine.  I can drop this patch and add a new patch to do
that.

-- 
Josh
