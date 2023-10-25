Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CDC7D680F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjJYKQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbjJYKQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:16:47 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FE513D;
        Wed, 25 Oct 2023 03:16:44 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qvawH-0002cu-Ry; Wed, 25 Oct 2023 12:16:37 +0200
Message-ID: <bf6332bc-a6a6-4702-821f-69f2e890fda9@leemhuis.info>
Date:   Wed, 25 Oct 2023 12:16:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: meson-mx-sdhc: Fix initialization frozen issue
Content-Language: en-US, de-DE
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ziyang Huang <hzyitc@outlook.com>
Cc:     neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        yinxin_1989@aliyun.com, briannorris@chromium.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <TYZPR01MB5556B56D834E02F41C44D81DC95FA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556A3E71554A2EC08597EA4C9CDA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <CAPDyKFrLUf+dcZbPtXFncu_KO_SgzKSN1KCW8ds4=OUGpT8+Gg@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAPDyKFrLUf+dcZbPtXFncu_KO_SgzKSN1KCW8ds4=OUGpT8+Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1698229004;fb7a1f22;
X-HE-SMSGID: 1qvawH-0002cu-Ry
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.10.23 13:14, Ulf Hansson wrote:
> On Tue, 10 Oct 2023 at 18:44, Ziyang Huang <hzyitc@outlook.com> wrote:
>>
>> Commit 4bc31edebde5 ("mmc: core: Set HS clock speed before sending
>> HS CMD13") set HS clock (52MHz) before switching to HS mode. For this
>> freq, FCLK_DIV5 will be selected and div value is 10 (reg value is 9).
>> Then we set rx_clk_phase to 11 or 15 which is out of range and make
>> hardware frozen. After we send command request, no irq will be
>> interrupted and the mmc driver will keep to wait for request finished,
>> even durning rebooting.
>>
>> So let's set it to Phase 90 which should work in most cases. Then let
>> meson_mx_sdhc_execute_tuning() to find the accurate value for data
>> transfer.
>>
>> If this doesn't work, maybe need to define a factor in dts.
>>
>> Fixes: e4bf1b0970ef ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
>> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> 
> I have re-added Thorsten to see if he has some time to test this on his end.

FWIW, I was only involved wrt to regression tracking. It iirc was was
Martin that had reported the problem here:
https://lore.kernel.org/all/CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com/

Side note: a proper Reported-by: tag together with a Link or Closes tag
would be good to have in the patch descriptions, as explained in the Docs.

Ciao, Thorsten

>> ---
>> Changes since v1:
>>   Use Phase 90 instand of value 1
>>
>>  drivers/mmc/host/meson-mx-sdhc-mmc.c | 26 +++++---------------------
>>  1 file changed, 5 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
>> index 97168cdfa8e9..29698fceb89c 100644
>> --- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
>> +++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
>> @@ -269,7 +269,7 @@ static int meson_mx_sdhc_enable_clks(struct mmc_host *mmc)
>>  static int meson_mx_sdhc_set_clk(struct mmc_host *mmc, struct mmc_ios *ios)
>>  {
>>         struct meson_mx_sdhc_host *host = mmc_priv(mmc);
>> -       u32 rx_clk_phase;
>> +       u32 val, rx_clk_phase;
>>         int ret;
>>
>>         meson_mx_sdhc_disable_clks(mmc);
>> @@ -290,27 +290,11 @@ static int meson_mx_sdhc_set_clk(struct mmc_host *mmc, struct mmc_ios *ios)
>>                 mmc->actual_clock = clk_get_rate(host->sd_clk);
>>
>>                 /*
>> -                * according to Amlogic the following latching points are
>> -                * selected with empirical values, there is no (known) formula
>> -                * to calculate these.
>> +                * Phase 90 should work in most cases. For data transmission,
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
>> +               regmap_read(host->regmap, MESON_SDHC_CLKC, &val);
>> +               rx_clk_phase = FIELD_GET(MESON_SDHC_CLKC_CLK_DIV, val) / 4;
>>                 regmap_update_bits(host->regmap, MESON_SDHC_CLK2,
>>                                    MESON_SDHC_CLK2_RX_CLK_PHASE,
>>                                    FIELD_PREP(MESON_SDHC_CLK2_RX_CLK_PHASE,
>> --
>> 2.34.1
>>
> 
