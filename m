Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC99782B26
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbjHUOGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbjHUOGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:06:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D106CC2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:06:15 -0700 (PDT)
Received: from nazgul.tnic (dynamic-089-015-236-044.89.15.236.pool.telefonica.de [89.15.236.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B13F51EC0103;
        Mon, 21 Aug 2023 16:06:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1692626774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sD1jCM0kVamD4hqu3n1h6gfD6YtAWe5pfvQwH+Z+/0o=;
        b=h+3stTO6B9jBMjKj+7WJQPA9dSITsD0vncobvSxCvfjiZJbsiobGzdjyu65eshimMhT+2G
        V7ZZaS/okiPkpYXVLNqszcJ/QBgs0MwOPguvKVyRRAiaTmCx6nRR3FGN4+L55sg9LyCCwS
        PqZoXCJrclH8M7ol5VXbnYSZhq4gK3g=
Date:   Mon, 21 Aug 2023 16:06:19 +0200
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
Message-ID: <20230821140619.GBZONvWz+iwQZwx/sC@fat_crate.local>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <caf4d0a1233ccc1c33f4ff8d3fe302c9289f4bea.1692580085.git.jpoimboe@kernel.org>
 <26a3421e-3a88-b326-4c4f-abdaa2262852@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26a3421e-3a88-b326-4c4f-abdaa2262852@citrix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:27:50AM +0100, Andrew Cooper wrote:
> This patch is necessary but not sufficient to fix the bugs.  There needs
> to be a !cpu_has_hypervisor in here.

Yes, but in a separate patch.

And I still don't know what exactly we're going to support when Linux
runs as a guest. For example, live migration between Zen1/2 and Zen3/4
won't work due to the alternatives patching, for example...

IBPB won't work either because we detect those feature bits only once
during boot, like every other feature bit...

Whatever it is, I'd like to see it written down first so that we go and
look it up and point to it when someone's changing that code.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
