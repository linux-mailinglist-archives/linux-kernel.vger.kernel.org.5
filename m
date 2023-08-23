Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA6D784FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 07:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjHWFUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 01:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjHWFT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 01:19:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FC5E54
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:19:57 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 07D811EC04CC;
        Wed, 23 Aug 2023 07:19:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1692767996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=75aTNDR6HJinTwoq5er6R7fMgm56ytnfyZ2eCO+tpcU=;
        b=UcZZeZKm4iK1L3vtdhgw8HFILczt1bRi/e8z5mPVoJthlxUGFPKB13aZCATkqzdE5HktfW
        987jN87lrWYKpdNLHKxKUx/rrgwHhjEN8HVqSBJObf3sEMHYSs0RXxmp9ia54g1dkC4ggv
        KMN8GOPUofLbIkxUOCBC53LeCysIU6E=
Date:   Wed, 23 Aug 2023 07:20:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 02/22] x86/srso: Set CPUID feature bits independently of
 bug or mitigation status
Message-ID: <20230823052007.GBZOWXBymcCUOoMax3@fat_crate.local>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <caf4d0a1233ccc1c33f4ff8d3fe302c9289f4bea.1692580085.git.jpoimboe@kernel.org>
 <26a3421e-3a88-b326-4c4f-abdaa2262852@citrix.com>
 <20230821140619.GBZONvWz+iwQZwx/sC@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821140619.GBZONvWz+iwQZwx/sC@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 04:06:19PM +0200, Borislav Petkov wrote:
> And I still don't know what exactly we're going to support when Linux
> runs as a guest. For example, live migration between Zen1/2 and Zen3/4
> won't work due to the alternatives patching, for example...
> 
> IBPB won't work either because we detect those feature bits only once
> during boot, like every other feature bit...

The lowest common denominator of features exposed to the guests, should
work, as I'm being told. As in, Zen2 and Zen3 should hide the SBPB bit
from the guests, for example.

Anything else like kernel code patching based on early detection of
features won't fly. But that has never flown anyway unless you don't
change that set of features.

I'm thinking if anyone cares really deeply about live migration, anyone
should say so and then we can see what cases we can support upstream. My
guess is those who do, have enough engineers to patch their kernel the
way they want it...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
