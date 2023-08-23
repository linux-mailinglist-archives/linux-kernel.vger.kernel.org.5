Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C90784E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 03:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjHWB1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 21:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjHWB1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 21:27:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3B7CC6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 18:27:28 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB78D1EC0103;
        Wed, 23 Aug 2023 03:27:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1692754046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nWFAFgifpYsnGtjS8UwbDCSVEHH8sOkb0bgb+clZXY8=;
        b=HMoU96/va65dVXQ984dYPejGMLTKm6vPIfcjBGu/W195hN5t+2ln9H9MJ47HYDZSaGZ6mc
        s6lurirRI6SdbvtHP+8tA68zGWB5/rCWrIvAaA9Sr0jEr4iRNi+v1OmrxJ4U9N2hF/CDry
        Cte72CUYscP1f5MysQGNUyH9+DB+mMk=
Date:   Wed, 23 Aug 2023 03:27:28 +0200
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
Message-ID: <20230823012728.GCZOVggFCpKiTgqffx@fat_crate.local>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <23a121e309d5e880eb35c441d9bdfa642d6d59f4.1692580085.git.jpoimboe@kernel.org>
 <20230821141619.GCZONxs5OdbbXFYSq2@fat_crate.local>
 <20230821163649.dyhxdeewlf6eerda@treble>
 <20230822055452.GDZORNrNdYc3OmGygU@fat_crate.local>
 <20230822060706.GEZORQiq136ZR5Tnc0@fat_crate.local>
 <20230822215901.nkikxpcmlrssi42l@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230822215901.nkikxpcmlrssi42l@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 02:59:01PM -0700, Josh Poimboeuf wrote:
> Yeah, I had seen that.  The combination of spectre_v2_user=on with
> srso=off doesn't make a whole lot of sense, but... give the user what
> they want and all.  Which would presumably be IBPB *without* the SRSO
> mitigation (aka SBPB).

Right.

> I don't think we need to worry about that, SBPB is >= fam19 but retbleed
> is <= fam17.  So either way (0x17 or 0x19) entry_ibpb() should do IBPB.

Right, and SBPB is possible only on family => 0x19 anyway which is not
affected by retbleed.

I was worried that we might open some mitigation hole with the overwrite
but it seems we're fine:

family 0x17: retbleed=ibpb, srso=off - is fine, can't do SBPB anyway
family 0x19: retbleed=ibpb, srso=off - fine too, not affected by retbleed, can do SBPB

Unless I'm missing something again which is very likely, by now. ;-\

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
