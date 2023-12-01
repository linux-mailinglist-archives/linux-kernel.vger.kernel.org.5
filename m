Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0E380080F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378224AbjLAKRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378203AbjLAKRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:17:24 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF1F84
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 02:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1701425849;
        bh=YDM8Y22Uw3soCEiLjFGP0Xjxg56+a/qHQ3QYMLfaxoE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mKl4ghrwdTD6YFAkhXpZeZdIY2tCvyKxhBS6fo49iNZ4/yKioR44Z+o5TfeX1/Dsv
         usslLBDHOt6xZVpfmF8cmIAlKMQUO4V++8Ss0t57au0Vw1PQ2Zq/EBt2weHaAPjqgy
         xUSirzcFpSWd7CisXNd+/ZoNtcn1VWPAsh/fYE6pjvdpTRDQKe5b0Ev7gCcp3v6FB1
         BopG7o9YpZRvFKlriWcDZO8S+qd2Dft8vxs8rm4eHm21ZL14vEKt+qcW/NBRYJF2gd
         G28DH3F1jjhsYIylMA+kTlNn6AjtePeS5lnvLzwLGNICWyYxgyLQfNFXvfU/AlnJKX
         GknLhUEvHBVsQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4ShTWs2kLFz4wx5;
        Fri,  1 Dec 2023 21:17:29 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kunwu Chan <chentao@kylinos.cn>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     kunwu.chan@hotmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH v2] powerpc/mm: Fix null-pointer dereference in
 pgtable_cache_add
In-Reply-To: <20231130090953.2322490-1-chentao@kylinos.cn>
References: <20231130090953.2322490-1-chentao@kylinos.cn>
Date:   Fri, 01 Dec 2023 21:17:28 +1100
Message-ID: <87cyvq1b2f.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kunwu Chan <chentao@kylinos.cn> writes:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
>
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
> v2: Use "panic" instead of "return"
> ---
>  arch/powerpc/mm/init-common.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
> index 119ef491f797..9788950b33f5 100644
> --- a/arch/powerpc/mm/init-common.c
> +++ b/arch/powerpc/mm/init-common.c
> @@ -139,6 +139,8 @@ void pgtable_cache_add(unsigned int shift)
>  
>  	align = max_t(unsigned long, align, minalign);
>  	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
> +	if (!name)
> +		panic("Failed to allocate memory for order %d", shift);
>  	new = kmem_cache_create(name, table_size, align, 0, ctor(shift));
>  	if (!new)
>  		panic("Could not allocate pgtable cache for order %d", shift);

It would be nice to avoid two calls to panic. Can you reorganise the
logic so that there's only one? Initialising new to NULL might help.

cheers
