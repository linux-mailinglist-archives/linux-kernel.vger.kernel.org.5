Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B8D75E040
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 09:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjGWHZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 03:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGWHZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 03:25:29 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3D110CB;
        Sun, 23 Jul 2023 00:25:28 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4R7vvm4Pcdz9tBC;
        Sun, 23 Jul 2023 09:25:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1690097124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QUpiLW4Bjo600wsGfn6sWtbls6tv+Y76e5aMy/lLZRI=;
        b=pL5jsGfH/OXKALWyo2XjDske4VVW7aj41TCh0369DoyEZfqtCZo2q628fGWW0pw2wRmNts
        pDr8Nu266KYGfBJEtrPr4GShQMq9A4/IvAIPzGoEYPcrE/KdRUuii8WRSgYzCV4hPDSLal
        3sDpNdrjYGUQ64ezvLempkwb4k2IrdsEB7vIe9Gj3DA/rm/dIZ8WjUuTd73hxZKcNZvyBC
        89DifAsAT+b/AdgM/3n53/hPqVeLKj15eMRFeIkm8Y+FyHZvzfetfsecGSpwzsTT793g6b
        95gPumEjD8fq+8d4kq/os/mlm7WBqHxH/WZ84Ao5ZFwPcTR1HJTwOVoyXdpeoQ==
References: <20230717-pll-mipi_set_rate_parent-v4-0-04acf1d39765@oltmanns.dev>
 <20230717-pll-mipi_set_rate_parent-v4-8-04acf1d39765@oltmanns.dev>
 <ho2bblo2hzizst74hfqog3ga4cjf7eead2ntbl4e7xi5c32bhq@qpttu7ayv7vy>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/11] clk: sunxi-ng: nkm: Support finding closest rate
In-reply-to: <ho2bblo2hzizst74hfqog3ga4cjf7eead2ntbl4e7xi5c32bhq@qpttu7ayv7vy>
Date:   Sun, 23 Jul 2023 09:25:10 +0200
Message-ID: <87ilabqecp.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 2023-07-17 at 16:14:58 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> [[PGP Signed Part:Undecided]]
> On Mon, Jul 17, 2023 at 03:34:32PM +0200, Frank Oltmanns wrote:
>> When finding the best rate for a NKM clock, consider rates that are
>> higher than the requested rate, if the CCU_FEATURE_CLOSEST_RATE flag is
>> set by using the helper function ccu_is_better_rate().
>>
>> Accommodate ccu_mux_helper_determine_rate to this change.
>>
>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>> ---
>>  drivers/clk/sunxi-ng/ccu_mux.c |  2 +-
>>  drivers/clk/sunxi-ng/ccu_nkm.c | 18 ++++++++----------
>>  2 files changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
>> index 1d557e323169..3ca695439620 100644
>> --- a/drivers/clk/sunxi-ng/ccu_mux.c
>> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
>> @@ -139,7 +139,7 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
>>  			goto out;
>>  		}
>>
>> -		if ((req->rate - tmp_rate) < (req->rate - best_rate)) {
>> +		if (ccu_is_better_rate(common, req->rate, tmp_rate, best_rate)) {
>>  			best_rate = tmp_rate;
>>  			best_parent_rate = parent_rate;
>>  			best_parent = parent;
>> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
>> index 793160bc2d47..5439b9351cd7 100644
>> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
>> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
>> @@ -39,6 +39,7 @@ static unsigned long ccu_nkm_optimal_parent_rate(unsigned long rate, unsigned lo
>>  }
>>
>>  static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw *phw, struct _ccu_nkm *nkm,
>> +						       struct ccu_common *common,
>>  						       unsigned long *parent, unsigned long rate)
>>  {
>>  	unsigned long best_rate = 0, best_parent_rate = *parent, tmp_parent = *parent;
>> @@ -54,10 +55,8 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw *phw, struc
>>  				tmp_parent = clk_hw_round_rate(phw, tmp_parent);
>>
>>  				tmp_rate = tmp_parent * _n * _k / _m;
>> -				if (tmp_rate > rate)
>> -					continue;
>>
>> -				if ((rate - tmp_rate) < (rate - best_rate)) {
>> +				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate)) {
>>  					best_rate = tmp_rate;
>>  					best_parent_rate = tmp_parent;
>>  					best_n = _n;
>> @@ -78,7 +77,7 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw *phw, struc
>>  }
>>
>>  static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
>> -				       struct _ccu_nkm *nkm)
>> +				       struct _ccu_nkm *nkm, struct ccu_common *common)
>
> Same comment than on patch 7, common should be first in those two functions.
>

Ok, I wasn't sure what your expectation is for existing functions. For
ccu_find_best_with_parent_adj the order is:
  1. *phw
  2. *nkm
  3. *common
  4. *parent
  5. rate

We don't have the parent hw in ccu_nkm_find_best. The order prior to
this patch is:
  1. parent
  2. rate
  3. *nkm

We need to add *common to that, so I could add it to the beginning as
per your suggestion:
  1. *common
  2. parent
  3. rate
  4. *nkm

I could also pull *nkm to the beginning (similar to the parent_adj
version):
  4. *nkm
  1. *common
  2. parent
  3. rate

Thanks for your feedback,
  Frank

>
> Once fixed,
> Acked-by: Maxime Ripard <mripard@kernel.org>
>
> Maxime
>
> [[End of PGP Signed Part]]
