Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF067B46A4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 11:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjJAJxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 05:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjJAJxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 05:53:42 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B75B8
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 02:53:39 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E4AE240E019B;
        Sun,  1 Oct 2023 09:53:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GnTKQD7mL6Fz; Sun,  1 Oct 2023 09:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696154015; bh=YAnqLYJ9lEkW0/4qFzt7X1T1d41TPSUW+zk8qYXXTgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vg/1QrjmR1r0edAyJAiBHuc4eD82Kx4WtZ3OducFe/c8LePRMbRRe+vB8UKPQeb7q
         rttwuuBzVLgQiS6aVJFMJ77Yl01/0tN09+jSA5gl6gcJOHFe+r7A7iQbs1NyT29fPl
         RisNB0BbHi50ugrwp8nTRv6S+sZDECCQ8Hpy936u1u+sWE5vLpQG31P18/cJS6fWIL
         N0gTXsErb/wS3EI2wmuVr79GRbhUZmPjiqiGO3+SucQi37ph5ytmzoJq72Q/GWDvSE
         pQLJgU1fgX79quqY2gXr6mwr0NhsUmkaaWbZGL9tTACq6D5jnpdZ8/rPTA00JfJ/2c
         e6G8bZjy4xXzTLWkJ7X6yDHLI4kjNoREhErB1SWVj2jQ/IEx4BJKyAoHMjrERbb4T0
         AIS4WtQTL91h5YXW6T+fc4IRQ9y4O/GEFur9Tg8+juxspapk00BVVmhaFtwiyo0Exz
         0mEZfFnI1ZiRrMVRvDbnLJjYul9SKqglH17zCqn+RLcFqHCj8/57NouJtXgeE55ycr
         zYI5bpkLgWiS0DRLPF/XcYHf5Pvg8G/iIcCR5a5I0H6bzzlZk1Os0MaQaek6sNKu8K
         N3wmBMQW27Py7ZVL4LKdtPu+m4WvkU6RC5rhorz0j7YFb70Vh0xuBt3Em19aQ785w6
         ssYmjW7sTRJykBz4WtQxxk6E=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 100B040E0176;
        Sun,  1 Oct 2023 09:53:30 +0000 (UTC)
Date:   Sun, 1 Oct 2023 11:53:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH kernel v2] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Message-ID: <20231001095322.GAZRlBkle6JC2rfM6u@fat_crate.local>
References: <20230926040526.957240-1-aik@amd.com>
 <20230930071759.GAZRfLpz38AAITSZzW@fat_crate.local>
 <e009f70e-32fc-404a-8560-f059b8999895@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e009f70e-32fc-404a-8560-f059b8999895@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 08:40:30PM +1100, Alexey Kardashevskiy wrote:
> Ingo says different, who wins? :)

I do: a function gives you type checking - a macro doesn't.

> > Then, it should be defined only in sev-shared.c for now.
> 
> sev-shared.c makes me sad. Including .c is not ... nice,

There's a point in doing things this way.

> I would avoid adding stuff to it at any cost.

Care to give a technical argument why or is it just general sadness?
Because I don't care about non-technical sentiments.

> > Furthermore, it should not be called "rdmsr" or so but something like
> > 
> > ghcb_prot_read_msr()
> > 
> > or so to denote that it is using the GHCB protocol to read the MSR. I'm
> > sure it'll gain more users with time.
> 
> What is "prot" going to signify?

"... or so to denote that it is using the GHCB protocol..."
					       ^^^^^^^^

it is right there.

> And what about Tom's "x86/sev: Fix SNP CPUID requests to the hypervisor",
> are you taking that one or I have to repost this one and the Tom's patch?

Yes, use this branch:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-urgent

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
