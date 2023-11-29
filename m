Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE807FCC4F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 02:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjK2BWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 20:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2BWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 20:22:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E3E10C0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 17:22:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67609C433C8;
        Wed, 29 Nov 2023 01:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701220959;
        bh=FBEAIzoLgu9Zkuu5c9UADybKG5tCWoq0pA1ohTQwa20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HTEloEWxitIAf4LrB+uGaCeVqy52QvkDsiW2ua5f4z/AKXmiI4hBsmwz7PT6WTZ1s
         Wxwfavqo2J72G1RZWH7aANFIO7lWJsNGHPpk1qGbaREMhcIco32+aA0fD6htjwWtLz
         m3FgVonjktFJ978Fuc/dQrQaVIQfLkN/ghI7VTIk=
Date:   Tue, 28 Nov 2023 17:22:38 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Haibo Li <haibo.li@mediatek.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <xiaoming.yu@mediatek.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fix comparison of unsigned expression < 0
Message-Id: <20231128172238.f80ed8dd74ab2a13eba33091@linux-foundation.org>
In-Reply-To: <20231128075532.110251-1-haibo.li@mediatek.com>
References: <20231128075532.110251-1-haibo.li@mediatek.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 15:55:32 +0800 Haibo Li <haibo.li@mediatek.com> wrote:

> Kernel test robot reported:
> 
> '''
> mm/kasan/report.c:637 kasan_non_canonical_hook() warn:
> unsigned 'addr' is never less than zero.
> '''
> The KASAN_SHADOW_OFFSET is 0 on loongarch64.
> 
> To fix it,check the KASAN_SHADOW_OFFSET before do comparison.
> 
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -634,10 +634,10 @@ void kasan_non_canonical_hook(unsigned long addr)
>  {
>  	unsigned long orig_addr;
>  	const char *bug_type;
> -
> +#if KASAN_SHADOW_OFFSET > 0
>  	if (addr < KASAN_SHADOW_OFFSET)
>  		return;
> -
> +#endif

We'd rather not add ugly ifdefs for a simple test like this.  If we
replace "<" with "<=", does it fix?  I suspect that's wrong.

But really, some hardwired comparison with an absolute address seems
lazy.  If KASAN_SHADOW_OFFSET is variable on a per-architecture basis
then the expression which checks the validity of an arbitrary address
should also be per-architecture.

