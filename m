Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797DC7A83EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbjITNwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjITNwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:52:54 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B158AC;
        Wed, 20 Sep 2023 06:52:48 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qixdE-0002e2-SC; Wed, 20 Sep 2023 15:52:44 +0200
Message-ID: <e34d4c14-af07-b5a1-8341-d8658c1efb39@leemhuis.info>
Date:   Wed, 20 Sep 2023 15:52:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: meson-mx-sdhc: Fix initialization frozen issue
Content-Language: en-US, de-DE
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ziyang Huang <hzyitc@outlook.com>,
        martin.blumenstingl@googlemail.com
Cc:     neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
References: <TYZPR01MB5556B56D834E02F41C44D81DC95FA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <CAPDyKFqyi97kjdiNM60WYK+cs4pw5pW3AyfiWKnsCRXd5BXUww@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAPDyKFqyi97kjdiNM60WYK+cs4pw5pW3AyfiWKnsCRXd5BXUww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695217968;03883f8f;
X-HE-SMSGID: 1qixdE-0002e2-SC
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.09.23 16:45, Ulf Hansson wrote:
> + Thorsten

I recently gave up on this, as it seems nobody cared anymore, but let's
give this another try.

> On Mon, 19 Jun 2023 at 19:36, Ziyang Huang <hzyitc@outlook.com> wrote:
>>
>> Commit 4bc31edebde5 ("mmc: core: Set HS clock speed before sending
>> HS CMD13") set HS clock (52MHz) before switching to HS mode. For this
>> freq, FCLK_DIV5 will be selected and div value is 10 (reg value is 9).
>> Then we set rx_clk_phase to 11 or 15 which is out of range and make
>> hardware frozen. After we send command request, no irq will be
>> interrupted and the mmc driver will keep to wait for request finished,
>> even durning rebooting.
>>
>> So let's set a common value - 1 just for initialization. Then let
>> meson_mx_sdhc_execute_tuning() to find the accurate value for data
>> transfer.
>>
>> Fixes: e4bf1b0970ef ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
>> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> 
> I don't quite understand if this patch is ok for everybody for me to apply?
> 
> It seems like it solves at least some part of the problems that
> Martin/Thorsten were looking at too [1], right?

Martin, could you help clarifying the situation here? It seems Ziyang
Huang is busy.

I briefly skimmed this thread again and to me it sounded like there was
a plan for an improved patch that hasn't shown up yet.

Also CCing Brian Norris who according to the bisection from Martin in
that "[1]" caused the regression (or am I missing/confusing something
here?).

> [1]
> https://lore.kernel.org/all/CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com/#r

Ciao, Thorsten

>> ---
>>  drivers/mmc/host/meson-mx-sdhc-mmc.c | 26 +++-----------------------
>>  1 file changed, 3 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
>> index da85c2f2..a01090a2 100644
>> --- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
>> +++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
>> @@ -269,7 +269,6 @@ static int meson_mx_sdhc_enable_clks(struct mmc_host *mmc)
>>  static int meson_mx_sdhc_set_clk(struct mmc_host *mmc, struct mmc_ios *ios)
>>  {
>>         struct meson_mx_sdhc_host *host = mmc_priv(mmc);
>> -       u32 rx_clk_phase;
>>         int ret;
>>
>>         meson_mx_sdhc_disable_clks(mmc);
>> @@ -290,31 +289,12 @@ static int meson_mx_sdhc_set_clk(struct mmc_host *mmc, struct mmc_ios *ios)
>>                 mmc->actual_clock = clk_get_rate(host->sd_clk);
>>
>>                 /*
>> -                * according to Amlogic the following latching points are
>> -                * selected with empirical values, there is no (known) formula
>> -                * to calculate these.
>> +                * This value is just for initialization. For data transmission,
>> +                * meson_mx_sdhc_execute_tuning() will find a accurate value
>>                  */
>> -               if (mmc->actual_clock > 100000000) {
>> -                       rx_clk_phase = 1;
>> -               } else if (mmc->actual_clock > 45000000) {
>> -                       if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
>> -                               rx_clk_phase = 15;
>> -                       else
>> -                               rx_clk_phase = 11;
>> -               } else if (mmc->actual_clock >= 25000000) {
>> -                       rx_clk_phase = 15;
>> -               } else if (mmc->actual_clock > 5000000) {
>> -                       rx_clk_phase = 23;
>> -               } else if (mmc->actual_clock > 1000000) {
>> -                       rx_clk_phase = 55;
>> -               } else {
>> -                       rx_clk_phase = 1061;
>> -               }
>> -
>>                 regmap_update_bits(host->regmap, MESON_SDHC_CLK2,
>>                                    MESON_SDHC_CLK2_RX_CLK_PHASE,
>> -                                  FIELD_PREP(MESON_SDHC_CLK2_RX_CLK_PHASE,
>> -                                             rx_clk_phase));
>> +                                  FIELD_PREP(MESON_SDHC_CLK2_RX_CLK_PHASE, 1));
>>         } else {
>>                 mmc->actual_clock = 0;
>>         }
>> --
>> 2.34.1
>>
> 
