Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66638788020
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242246AbjHYGmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242623AbjHYGmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:42:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F022129
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:41:58 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E52801EC0338;
        Fri, 25 Aug 2023 08:41:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1692945717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=n6ZUfPPmuShCDZMNulO4E5XiMbW+NH4bF6taV+K6lUM=;
        b=q0MM2F+JHF3YNlG4TG88j7crhewEQXXUvVvb7oibXCW8qe3bzX5qa2FW9h5WKyoOGfjouq
        iEAq6TsXjB4Y3iz2XtmUTGMT9f9KvIkYzpD2M9J9D4BbBdolj+LPQKybS+h1g93K4PEJGA
        IqNmYYEhS596GBt3cn2Voql6vipPXaE=
Date:   Fri, 25 Aug 2023 08:42:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 02/22] x86/srso: Set CPUID feature bits independently of
 bug or mitigation status
Message-ID: <20230825064209.GCZOhNQf4wP1qWObOG@fat_crate.local>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <caf4d0a1233ccc1c33f4ff8d3fe302c9289f4bea.1692580085.git.jpoimboe@kernel.org>
 <26a3421e-3a88-b326-4c4f-abdaa2262852@citrix.com>
 <20230821140619.GBZONvWz+iwQZwx/sC@fat_crate.local>
 <20230823052007.GBZOWXBymcCUOoMax3@fat_crate.local>
 <22eb07b3-6de4-9fc2-fb05-2c7ebe6dc951@citrix.com>
 <20230824042420.GAZObbdNb38eKaCPAm@fat_crate.local>
 <20230824220440.ltmozuypice2kmwg@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230824220440.ltmozuypice2kmwg@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 03:04:40PM -0700, Josh Poimboeuf wrote:
> Something like this?

Yeah, that's solving the immediate issue but what I mean is, I'd prefer
to have a statement saying:

"This is the use cases Foo and Bar related to live migration which we
want to support because of reasons X and Y."

So that we can know what we're actually supporting. I keep hearing of
cloud vendors doing live migration but nothing about what the kernel
running as a guest needs to support. And whether migration across
generations should be supported. At all. And whether the kernel needs to
even support anything.

And if we don't know the use cases we can't even commit to supporting
them. Or not break them in the future.

And above you can replace "live migration" with any other feature that
is requested. It helps immensely if we know how the kernel is used as
most of us tip maintainers, IMNSVHO, are blissfully unaware of live
migration.

I hope that makes more sense.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
