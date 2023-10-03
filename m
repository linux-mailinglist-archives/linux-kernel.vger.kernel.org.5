Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459507B68DE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjJCMUv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 08:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjJCMUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:20:49 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17ABAC;
        Tue,  3 Oct 2023 05:20:45 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 78D2418688D7;
        Tue,  3 Oct 2023 15:20:42 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DxCA32iw3j8i; Tue,  3 Oct 2023 15:20:42 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 3536D18688DD;
        Tue,  3 Oct 2023 15:20:40 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id f3V6pAVsiGZ3; Tue,  3 Oct 2023 15:20:40 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.102])
        by mail.astralinux.ru (Postfix) with ESMTPS id 8B17E18688EE;
        Tue,  3 Oct 2023 15:20:38 +0300 (MSK)
Received: from [10.177.20.58] (unknown [10.177.20.58])
        by new-mail.astralinux.ru (Postfix) with ESMTPA id 4S0H3B1Rq0zYcnK;
        Tue,  3 Oct 2023 15:20:38 +0300 (MSK)
Message-ID: <c31bcd98-cc0a-4edf-945b-f4e22e122b46@astralinux.ru>
Date:   Tue, 3 Oct 2023 15:20:16 +0300
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH] clk: cdce925: change condition in cdce925_clk_round_rate
Content-Language: ru
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <20230901130359.20561-1-abelova@astralinux.ru>
From:   =?UTF-8?B?0JDQvdCw0YHRgtCw0YHQuNGPINCb0Y7QsdC40LzQvtCy0LA=?= 
        <abelova@astralinux.ru>
In-Reply-To: <20230901130359.20561-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


01/09/23 16:03, Anastasia Belova пишет:

Just a friendly reminder.

> To avoid division by zero add check if
> divider is zero.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 19fbbbbcd3a3 ("Add TI CDCE925 I2C controlled clock synthesizer driver")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>   drivers/clk/clk-cdce925.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-cdce925.c b/drivers/clk/clk-cdce925.c
> index 96ac90364847..d903cdc3ad7d 100644
> --- a/drivers/clk/clk-cdce925.c
> +++ b/drivers/clk/clk-cdce925.c
> @@ -441,7 +441,7 @@ static long cdce925_clk_round_rate(struct clk_hw *hw, unsigned long rate,
>   	unsigned long l_parent_rate = *parent_rate;
>   	u16 divider = cdce925_calc_divider(rate, l_parent_rate);
>   
> -	if (l_parent_rate / divider != rate) {
> +	if (divider && l_parent_rate / divider != rate) {
>   		l_parent_rate = cdce925_clk_best_parent_rate(hw, rate);
>   		divider = cdce925_calc_divider(rate, l_parent_rate);
>   		*parent_rate = l_parent_rate;

