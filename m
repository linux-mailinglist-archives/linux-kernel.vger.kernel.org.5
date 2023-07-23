Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A4475E044
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 09:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGWH0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 03:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGWH0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 03:26:34 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9466010CB;
        Sun, 23 Jul 2023 00:26:33 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4R7vx22wBPz9sZH;
        Sun, 23 Jul 2023 09:26:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1690097190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7npQ603oc29KQO3VKWFKZYl16ThZTZ9aYNERq2NUH/A=;
        b=vA+mmzj76oIcKC4z1Qe23xkhbKpQn4zqgyyKRQeVNqOSagdLdYgJviCH1xTIv+yD36QcuG
        sfMVhYdzjFqMm2aDrMqrD0cMpg722q0+7HXASJYK5syvwQAaOj5gxOmhzWdU8CXUV+AM4p
        M2L+fgZ+SDo8zWwq3T/SKHapVlCxfhj4TrkzbmBJ7+L8IWBvqtqzT3O+IImqvg2O3pbFaJ
        939f4P0ERs3CEDpQU99An2DTxiq5zjvjGc7jVx2APMBmDLA/MhOYJj0BdqfnvFI2PpwZC+
        8ObfkN9QPw1GBYUYRp2zVlCSk9bMI97jq+7hLNqR2Ug8opE4aWlocEgj32xn3A==
References: <20230717-pll-mipi_set_rate_parent-v4-0-04acf1d39765@oltmanns.dev>
 <20230717-pll-mipi_set_rate_parent-v4-7-04acf1d39765@oltmanns.dev>
 <htxtcpqimrloxvebm5iadqzybj3rt5c532smtm62kxeuaejaqw@syknyzrhgf7f>
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
Subject: Re: [PATCH v4 07/11] clk: sunxi-ng: nm: Support finding closest rate
In-reply-to: <htxtcpqimrloxvebm5iadqzybj3rt5c532smtm62kxeuaejaqw@syknyzrhgf7f>
Date:   Sun, 23 Jul 2023 09:26:27 +0200
Message-ID: <87edkzqeak.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4R7vx22wBPz9sZH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-07-17 at 16:12:30 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> [[PGP Signed Part:Undecided]]
> On Mon, Jul 17, 2023 at 03:34:31PM +0200, Frank Oltmanns wrote:
>> Use the helper function ccu_is_better_rate() to determine the rate that
>> is closest to the requested rate, thereby supporting rates that are
>> higher than the requested rate if the clock uses the
>> CCU_FEATURE_CLOSEST_RATE.
>>
>> Add the macro SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST which
>> sets CCU_FEATURE_CLOSEST_RATE.
>>
>> To avoid code duplication, add the macros
>> SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT that allows selecting
>> arbitrary features and use it in the original
>> SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX as well as the newly introduced
>> SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST macros.
>>
>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>> ---
>>  drivers/clk/sunxi-ng/ccu_nm.c | 11 ++++------
>>  drivers/clk/sunxi-ng/ccu_nm.h | 48 ++++++++++++++++++++++++++++++++++++++++---
>>  2 files changed, 49 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
>> index c1fd11542c45..35d00783d748 100644
>> --- a/drivers/clk/sunxi-ng/ccu_nm.c
>> +++ b/drivers/clk/sunxi-ng/ccu_nm.c
>> @@ -28,7 +28,7 @@ static unsigned long ccu_nm_calc_rate(unsigned long parent,
>>  }
>>
>>  static unsigned long ccu_nm_find_best(unsigned long parent, unsigned long rate,
>> -				      struct _ccu_nm *nm)
>> +				      struct _ccu_nm *nm, struct ccu_common *common)
>
> The common pointer must be the first argument.
>

Same question as for patch 08: Should I also pull *nm to the beginning?
If so, do you have a preference on the order of *nm and *common?

Thanks,
  Frank

>
> Once fixed,
> Acked-by: Maxime Ripard <mripard@kernel.org>
>
> Maxime
>
> [[End of PGP Signed Part]]
