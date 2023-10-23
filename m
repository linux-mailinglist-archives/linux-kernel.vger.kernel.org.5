Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040EB7D3874
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjJWNwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjJWNwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:52:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89B0DE4;
        Mon, 23 Oct 2023 06:52:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55F232F4;
        Mon, 23 Oct 2023 06:52:57 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCADE3F64C;
        Mon, 23 Oct 2023 06:52:14 -0700 (PDT)
Date:   Mon, 23 Oct 2023 14:52:11 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH][next] clk: sunxi-ng: nkm: remove redundant
 initialization of tmp_parent
Message-ID: <20231023145211.4acaedda@donnerap.manchester.arm.com>
In-Reply-To: <20231023133502.666559-1-colin.i.king@gmail.com>
References: <20231023133502.666559-1-colin.i.king@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 14:35:02 +0100
Colin Ian King <colin.i.king@gmail.com> wrote:

Hi,

> Variable tmp_parent is being ininitialized with a value that is never
> read, the initialization is redundant and can be removed. Move the
> initialization and move the variable to the inner loop scope.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Yes, that seems to be correct:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/clk/sunxi-ng/ccu_nkm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index eed64547ad42..853f84398e2b 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -21,17 +21,16 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(struct ccu_common *common
>  						       unsigned long *parent, unsigned long rate,
>  						       struct _ccu_nkm *nkm)
>  {
> -	unsigned long best_rate = 0, best_parent_rate = *parent, tmp_parent = *parent;
> +	unsigned long best_rate = 0, best_parent_rate = *parent;
>  	unsigned long best_n = 0, best_k = 0, best_m = 0;
>  	unsigned long _n, _k, _m;
>  
>  	for (_k = nkm->min_k; _k <= nkm->max_k; _k++) {
>  		for (_n = nkm->min_n; _n <= nkm->max_n; _n++) {
>  			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {
> -				unsigned long tmp_rate;
> +				unsigned long tmp_rate, tmp_parent;
>  
>  				tmp_parent = clk_hw_round_rate(parent_hw, rate * _m / (_n * _k));
> -
>  				tmp_rate = tmp_parent * _n * _k / _m;
>  
>  				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate) ||

