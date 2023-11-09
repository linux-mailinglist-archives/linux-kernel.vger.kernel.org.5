Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324C97E64C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjKIHxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjKIHxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:53:00 -0500
X-Greylist: delayed 550 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Nov 2023 23:52:58 PST
Received: from codesynthesis.com (codesynthesis.com [188.40.148.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E571716;
        Wed,  8 Nov 2023 23:52:58 -0800 (PST)
Received: from brak.codesynthesis.com (unknown [105.186.92.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by codesynthesis.com (Postfix) with ESMTPSA id 55E5160D9F;
        Thu,  9 Nov 2023 07:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codesynthesis.com;
        s=mail1; t=1699515826;
        bh=fJ48MnwSMLL/XzmjxNLHtBoWhFyXgj04jwsCFx/3Hfs=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:From;
        b=RmY00MK5Rg1p2bfkJRAejhbFOLJapXmR89HNVZ3EBm/VjgibjKGCFeSK65GEm8Qp7
         7f9j1Jtr+eZAWyildkdVI5FnoKpLEsSBiJNckuM1L++5FiDEp+8rt9YCYWbIgMRdMb
         Al9k9Cj8OS7NQDRJOB2rhzeJeoJzRGMuS+3W9CmV5AryyGeE5UKAAZzMU29UM7zbiY
         x3wl9ICeAVqEmQZ1e99N5pzif5p18N2hGqk3Jl0HgiK1XdfCetqii0PTPMRIOpqlwL
         utdtn5Fd16cdAlWb9XZbkyCF9VkdxC5FIx/HpCvzr3tTDJ7dpJDm1ijUjadcTb7BzS
         uboZ2QLZ4arkQ==
Received: by brak.codesynthesis.com (Postfix, from userid 1000)
        id 2AE8B145E0D; Thu,  9 Nov 2023 09:43:44 +0200 (SAST)
Date:   Thu, 9 Nov 2023 09:43:44 +0200
From:   Boris Kolpackov <boris@codesynthesis.com>
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] kconfig: Add special rust_modules config option
Message-ID: <boris.20231109093619@codesynthesis.com>
References: <20231108022651.645950-2-mmaurer@google.com>
 <20231108022651.645950-5-mmaurer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108022651.645950-5-mmaurer@google.com>
Organization: Code Synthesis
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Maurer <mmaurer@google.com> writes:

> Adds support for the rust_modules kconfig type, which works similarly to
> modules, but for restricting or allowing the use of modules which
> directly depend on Rust.
>
> [...]
>
> +struct symbol *modules_rust_sym;
> +static tristate modules_rust_val;
> +
> +bool sym_depends_rust(struct symbol *sym)
> +{
> +	static struct symbol *rust_sym;
> +
> +	if (!rust_sym)
> +		rust_sym = sym_find("RUST");
> +	return expr_depends_symbol(sym->dir_dep.expr, rust_sym, true);
> +}
> +

Hm, this feels like a quick and dirty hack to me: will we be hardcoding
a symbol for each language?

I know there is little sympathy for other projects that use Kconfig,
and whatever Linux needs, goes, but still, this feels like a step too
far.
