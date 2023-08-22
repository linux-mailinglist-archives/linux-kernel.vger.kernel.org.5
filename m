Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B094783990
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 07:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjHVFyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 01:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjHVFyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 01:54:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC17C1A2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 22:54:50 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 326E01EC0105;
        Tue, 22 Aug 2023 07:54:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1692683689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TUNYdX+jAgiy5w5ejIw89GCQEjBsUm2NlTPPddQmmaw=;
        b=fXIveyE/weQit9im9mDVuO2gmI6XaOkYTnCP8LJNVUi1Dnv2HbFMyFU2xWJ6dwzyraRBJn
        1z3Jp9UwfSOF/Vfq1ZR9MoPnoFVaozFHePNIPOAGwvrkSa5tw+66zmtSv2l24vsFPtChN7
        ++1FX5S3POJxdKefDtjPe4+zIaKJZjU=
Date:   Tue, 22 Aug 2023 07:54:52 +0200
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
Subject: Re: [PATCH 04/22] x86/srso: Fix SBPB enablement for
 spec_rstack_overflow=off
Message-ID: <20230822055452.GDZORNrNdYc3OmGygU@fat_crate.local>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <23a121e309d5e880eb35c441d9bdfa642d6d59f4.1692580085.git.jpoimboe@kernel.org>
 <20230821141619.GCZONxs5OdbbXFYSq2@fat_crate.local>
 <20230821163649.dyhxdeewlf6eerda@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821163649.dyhxdeewlf6eerda@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 09:36:49AM -0700, Josh Poimboeuf wrote:
> Hm?  How exactly is this overriding the retbleed IBPB mitigation?

Sorry, clearly -ETOOMANYMITIGATIONS.

I meant the spectre_v2_user thing which does
indirect_branch_prediction_barrier() based on X86_FEATURE_USE_IBPB.

indirect_branch_prediction_barrier() uses x86_pred_cmd to select which
MSR bits to set and it is initialized by default to PRED_CMD_IBPB.

If you goto pred_cmd, you will overwrite it with PRED_CMD_SBPB here.

I think it should not overwrite it and simply return like before.
Meaning: if SRSO mitigation is off but the spectre_v2_user isn't so you
get what you want.

If you do mitigations=off - which is what most use cases do when they
don't care about mitigations - then it'll work too.

I don't see a sensible use case where user->user spectre_v2 is enabled
but SRSO is off. Maybe there is...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
