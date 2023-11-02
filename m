Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82C97DF0ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347130AbjKBLJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347273AbjKBLJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:09:14 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3EF185
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:09:08 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 80FF140E0171;
        Thu,  2 Nov 2023 11:09:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Fu0uLlhIY8cI; Thu,  2 Nov 2023 11:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698923340; bh=Z7yuaClu/jsxBaffsXAcPnzmDZpHHAuwVJ/zhHZGqe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUR9QdtwhRBGodl/Fgntow3SLXUltbrokT6nLNfhPXBE5Z9PuUNnsfV96AwFUvyJ9
         KFR4iGd6lnLdJl7QBlvz6MdOsquMOeLghKN2j1xM3Fng/I9EA8o34JAoxCCjJQFysl
         /ic6+VYQ1f1aBTw6VoUuClBvgJ53qWd7BG7A8+aLY4IYfCNAqLa1pqkFvnIIAxZUqy
         Srx3Ia00W6Q9JoMtmemKqFXPdD0tQXRewmQZ+k5ddJ53SvadIYXyUctExn+h8ADpWk
         w2Vrdm17m1NIH3DDHlOSraQ8Ux77G9CaWflj2uEZXEIuEFqFZnGRo1duP1FF9Y8Ppw
         fKy6u7yDm3drFiQC4Olozg8+zevBxgHL88FPLe6tdVbQxL9O5bajzMiJrJxiN+o1UF
         FcyiBjqzClT2uZBbpYhxaZQ/Qxg8VHZHY0xEgdzfhMLzeP5xTeRkvlGQdffXi/KQgD
         EBuux1uwu2Atdl93ct7oR/MIiGkoUT9zY/VxbtsdRpKvkuk9aYNH0sT5QsKs96U5pl
         T1PKWaKhfOJ9thZc2RJfb56VpnJc2pygRIU6+PhcOO++Izi2U5+ljYPGtdWGiqYf6B
         rdb3KSN9VEDUN2J2iVoCueunOY7w7xWywHHsXUXR1K6cB8bR/dvhAOs1yMER1s29jn
         WSbPKBm8A6rR5uI2/cdz9X7I=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD0BF40E0192;
        Thu,  2 Nov 2023 11:08:54 +0000 (UTC)
Date:   Thu, 2 Nov 2023 12:08:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/barrier: Do not serialize MSR accesses on AMD
Message-ID: <20231102110848.GAZUODQGrEuKeFjKP/@fat_crate.local>
References: <20230703125419.GJ4253@hirez.programming.kicks-ass.net>
 <20230704074631.GAZKPOV/9BfqP0aU8v@fat_crate.local>
 <20230704090132.GP4253@hirez.programming.kicks-ass.net>
 <20230704092222.GBZKPkzgdM8rbPe7zA@fat_crate.local>
 <20231027153327.GKZTvYR3qslaTUjtCT@fat_crate.local>
 <20231027153458.GMZTvYou1tlK6HD8/Y@fat_crate.local>
 <20231027185641.GE26550@noisy.programming.kicks-ass.net>
 <20231027191633.GRZTwMkaiW1nyvnzzO@fat_crate.local>
 <20231027192907.GSZTwPg8v7NF6+Zn0w@fat_crate.local>
 <3c56e807-945c-4996-9ac1-3205a23248ab@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c56e807-945c-4996-9ac1-3205a23248ab@citrix.com>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 09:09:05PM +0100, Andrew Cooper wrote:
> Quoteth the APM (rev 3.41, June 2023):
>=20
> 16.11.2 WRMSR / RDMSR serialization for x2APIC Register
>=20
> The WRMSR instruction is used to write the APIC register set in x2APIC
> mode. Normally WRMSR is
> a serializing instruction, however when accessing x2APIC registers, the
> serializing aspect of WRMSR
> is relaxed to allow for more efficient access to those registers.
> Consequently, a WRMSR write to an
> x2APIC register may complete before older store operations are complete
> and have become globally
> visible. When strong ordering of an x2APIC write access is required wit=
h
> respect to preceding memory
> operations, software can insert a serializing instruction (such as
> MFENCE) before the WRMSR
> instruction.
>=20
> So which is right?=C2=A0 This commit message, or the APM?=C2=A0 (and ye=
s, if
> you're waiting on an APM update then the commit message should at least
> note that one is coming.)

To clarify this one: there will be a CPUID bit which states that an
MFENCE is not needed ATM and it'll be added to the APM. I'll add a note
about it to the commit message too.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
