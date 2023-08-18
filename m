Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC53781146
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378910AbjHRRJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378911AbjHRRJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:09:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C403C2D;
        Fri, 18 Aug 2023 10:09:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB91A62BD3;
        Fri, 18 Aug 2023 17:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F27C433C8;
        Fri, 18 Aug 2023 17:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692378571;
        bh=go70K6iNIJWJf0elUmAhaiRiRebNiH0/0hUJeSfZDc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hyC/8Qxibepj0bkrW5M0UTLFWLcMlbMpYWY3qzspmwZNYlOo7NZbnWF9Yup5G452U
         mg8spiw62TQr4TEMsG3Kx6WrgRcuMv7JjZ+XxZNk+xfeboahIV9y51KO5MbX17eF09
         tvemSlkF/GstlHBkIViv9PolCjtqfPHnbHTK7RFexD21lfk41LgRnJ52Xon5uf+rie
         2a+7DNY1C2Fd7kKlqDfDXcP8X4AOjPHM42G61kD+W/IfsHtsOYjVWpzE7DMjX77wby
         AkO7ZVMsXRKTm5ff0Ox+ijIisjAjKamyq7oCiylpucb6L12XKL6dL8q75LQRbQ2WaM
         F4uKQT9//WtVw==
Received: (nullmailer pid 212309 invoked by uid 1000);
        Fri, 18 Aug 2023 17:09:29 -0000
Date:   Fri, 18 Aug 2023 12:09:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] mm,ima,kexec,of: use memblock_free_late from
 ima_free_kexec_buffer
Message-ID: <20230818170929.GA151785-robh@kernel.org>
References: <20230817135759.0888e5ef@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817135759.0888e5ef@imladris.surriel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 01:57:59PM -0400, Rik van Riel wrote:
> The code calling ima_free_kexec_buffer runs long after the memblock
> allocator has already been torn down, potentially resulting in a use
> after free in memblock_isolate_range.
> 
> With KASAN or KFENCE, this use after free will result in a BUG
> from the idle task, and a subsequent kernel panic.
> 
> Switch ima_free_kexec_buffer over to memblock_free_late to avoid
> that issue.
> 
> Fixes: fee3ff99bc67 ("powerpc: Move arch independent ima kexec functions to
> drivers/of/kexec.c")

Didn't powerpc have the same issue before this commit? The move changed 
memblock_free() to memblock_phys_free(), but otherwise the code was the 
same. But wait, the old code looks broken as it reads a phys addr from 
DT and passes that to memblock_free() which wants a virt addr. Probably 
should have fixed that before moving things. I guess the Fixes here is 
right and powerpc needs a different backport for before commit 
fee3ff99bc67 if they care.

> Cc: stable@kernel.org
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Suggested-by: Mike Rappoport <rppt@kernel.org>
> ---
>  drivers/of/kexec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index f26d2ba8a371..68278340cecf 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -184,7 +184,8 @@ int __init ima_free_kexec_buffer(void)
>  	if (ret)
>  		return ret;
>  
> -	return memblock_phys_free(addr, size);
> +	memblock_free_late(addr, size);
> +	return 0;
>  }
>  #endif
>  
> -- 
> 2.41.0
> 
