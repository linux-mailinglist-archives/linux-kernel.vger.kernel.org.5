Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36203802429
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 14:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjLCNUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 08:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjLCNUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 08:20:09 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACE394
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 05:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1701609611;
        bh=8sq+syTh1UjJkuKljU0mYRoAqe7ukDVJOSXLZA2MlIM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IHj8xAUYjWqr1mWy7VTN7DHzb1+kh+QmF8kbtdZ0WCmnMEWfnNXpXCczwsjjv4Oag
         v7bF39UVwNfwjdVhkXZt2uc7++svqylU9fyFGxsqjOfWarj74up/FOZTT1jfuEhz+j
         pSsq1oDjWkHVxq4IiVy7Ua4+C9zjmg+oLO3gIwxw=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id AA0FF66C98;
        Sun,  3 Dec 2023 08:20:09 -0500 (EST)
Message-ID: <e860c6d42dc67e2c662c732ce56309874456f21b.camel@xry111.site>
Subject: Re: [PATCH v5 8/8] LoongArch: Add ORC stack unwinder support
From:   Xi Ruoyao <xry111@xry111.site>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Sun, 03 Dec 2023 21:20:07 +0800
In-Reply-To: <20231129130701.27744-9-yangtiezhu@loongson.cn>
References: <20231129130701.27744-1-yangtiezhu@loongson.cn>
         <20231129130701.27744-9-yangtiezhu@loongson.cn>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-29 at 21:07 +0800, Tiezhu Yang wrote:
> +KBUILD_AFLAGS			+=3D $(call cc-option,-mthin-add-sub) $(call cc-option,-=
Wa$(comma)-mthin-add-sub)
> +KBUILD_CFLAGS			+=3D $(call cc-option,-mthin-add-sub) $(call cc-option,-=
Wa$(comma)-mthin-add-sub)
> +
> +ifdef CONFIG_OBJTOOL
> +KBUILD_CFLAGS			+=3D -fno-optimize-sibling-calls -fno-jump-tables -falig=
n-functions=3D4 -falign-labels=3D4
> +endif

I still hate regressing the optimization with a passion.

And -falign-labels=3D4 implies -falign-functions=3D4 so at least we can
remove -falign-functions=3D4.

And in GCC >=3D 14 the defaults are -falign-labels=3D16 and -falign-
functions=3D32.  These values are determined by benchmarking on LA464 so
I'd suggest using them (maybe unless CONFIG_CC_OPTIMIZE_FOR_SIZE).

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
