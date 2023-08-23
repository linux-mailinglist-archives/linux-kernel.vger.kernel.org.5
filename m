Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D167378503E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 07:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjHWF5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 01:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjHWF5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 01:57:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F35E47
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:57:18 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E84251EC04CC;
        Wed, 23 Aug 2023 07:57:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1692770236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Jekj/XN7VQmzj7iDipWSEqYR0+QJ8y1AHl8lSmzuAZQ=;
        b=pHSsgbNjC8P89aLWdeS6zkZJiQ9Ua+KzoLsWozWHFOOQCrWeqOJV/4HJpGB4hfkIqVkNy8
        b68I6aA4MB5nGELINFyFIJqpTL7hjJwMY1EGWMIEnZAhjBeKN8S8yraB8JhH90l+2Q8tT8
        xYNDDg5+8X2awoHYwzd/GnPeoQykrMw=
Date:   Wed, 23 Aug 2023 07:57:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 05/22] x86/srso: Fix SBPB enablement for mitigations=off
Message-ID: <20230823055720.GDZOWfwIMn+o7spi8v@fat_crate.local>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <141c92f20ab46cf0c028e86b946134cd702d0ea5.1692580085.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <141c92f20ab46cf0c028e86b946134cd702d0ea5.1692580085.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 06:19:02PM -0700, Josh Poimboeuf wrote:
> If the user has requested no mitigations with mitigations=off, use the
> lighter-weight SBPB instead of IBPB for other mitigations.
> 
> Note that even with mitigations=off, IBPB/SBPB may still be used for
> Spectre v2 user <-> user protection.  Whether that makes sense is a
> question for another day.

Well, with my user hat on, off means off.

IINM, spectre_v2_parse_cmdline() will give SPECTRE_V2_CMD_NONE to
spectre_v2_select_mitigation() when mitigations=off.

spectre_v2_user_select_mitigation() will use the
spectre_v2_select_mitigation()'s result, which turn into
SPECTRE_V2_USER_CMD_NONE and then not enable *BPB either.

So even if we set x86_pred_cmd to SBPB here, it won't do anything
because X86_FEATURE_USE_IBPB won't be set and
indirect_branch_prediction_barrier() will be a NOP.

IOW, I think we should separate the check:

        if (cpu_mitigations_off())
                return;

at the beginning of srso_select_mitigation() so that it is crystal
clear. Maybe even slap a comment over it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
