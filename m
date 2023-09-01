Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC1978F73E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 04:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344948AbjIACk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 22:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbjIACkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 22:40:55 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E626E72;
        Thu, 31 Aug 2023 19:40:51 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 7F82C80C4;
        Fri,  1 Sep 2023 10:40:43 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 1 Sep
 2023 10:40:44 +0800
Received: from [192.168.120.76] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 1 Sep
 2023 10:40:42 +0800
Message-ID: <f130f1c5-d59b-6d5c-e2e8-5ce3e6948543@starfivetech.com>
Date:   Fri, 1 Sep 2023 10:40:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 2/3] mmc: starfive: Change tuning implementation
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20230830031846.127957-1-william.qiu@starfivetech.com>
 <20230830031846.127957-3-william.qiu@starfivetech.com>
 <CAJM55Z9CL8DN+uEhRoR7ZUuwtVudTUzA1+Q4Hn_rukCfT+SXeQ@mail.gmail.com>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <CAJM55Z9CL8DN+uEhRoR7ZUuwtVudTUzA1+Q4Hn_rukCfT+SXeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/30 18:28, Emil Renner Berthing wrote:
> On Wed, 30 Aug 2023 at 05:21, William Qiu <william.qiu@starfivetech.com> wrote:
>>
>> Before, we used syscon to achieve tuning, but the actual measurement
>> showed little effect, so the tuning implementation was modified here,
>> and it was realized by reading and writing the UHS_REG_EXT register.
>>
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
>>  drivers/mmc/host/dw_mmc-starfive.c | 131 ++++++++---------------------
>>  1 file changed, 37 insertions(+), 94 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-starfive.c b/drivers/mmc/host/dw_mmc-starfive.c
>> index fd05a648a8bb..593c995e49f5 100644
>> --- a/drivers/mmc/host/dw_mmc-starfive.c
>> +++ b/drivers/mmc/host/dw_mmc-starfive.c
>> @@ -20,14 +20,6 @@
>>  #define ALL_INT_CLR            0x1ffff
>>  #define MAX_DELAY_CHAIN                32
>>
>> -struct starfive_priv {
>> -       struct device *dev;
>> -       struct regmap *reg_syscon;
>> -       u32 syscon_offset;
>> -       u32 syscon_shift;
>> -       u32 syscon_mask;
>> -};
>> -
>>  static void dw_mci_starfive_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>>  {
>>         int ret;
>> @@ -44,117 +36,68 @@ static void dw_mci_starfive_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>>         }
>>  }
>>
>> +static void dw_mci_starfive_hs_set_bits(struct dw_mci *host, u32 smpl_phase)
> 
> "set bits" is very generic. Maybe dw_mci_starfive_set_sample_phase()
> or something more descriptive.
> 
Will update.
>> +{
>> +       /* change driver phase and sample phase */
>> +       u32 mask = 0x1f;
>> +       u32 reg_value;
>> +
>> +       reg_value = mci_readl(host, UHS_REG_EXT);
>> +
>> +       /* In UHS_REG_EXT, only 5 bits valid in DRV_PHASE and SMPL_PHASE */
>> +       reg_value &= ~(mask << 16);
>> +       reg_value |= (smpl_phase << 16);
>> +       mci_writel(host, UHS_REG_EXT, reg_value);
>> +
>> +       /* We should delay 1ms wait for timing setting finished. */
>> +       mdelay(1);
>> +}
> 
> This implementation could use some cleanup. Eg. why do we need the
> mask variable?
> How about something like this:
> 
> #define STARFIVE_SMPL_PHASE     GENMASK(20, 16)
> 
> u32 reg_value = mci_read(host, UHS_REG_EXT);
> reg_value &= ~STARFIVE_SMPL_PHASE;
> reg_value |= FIELD_PREP(STARFIVE_SMPL_PHASE, smpl_phase);
> mci_writel(host, UHS_REG_EXT, reg_value);
> ...
> 
I'll try it.
>>  static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
>>                                              u32 opcode)
>>  {
>>         static const int grade  = MAX_DELAY_CHAIN;
>>         struct dw_mci *host = slot->host;
>> -       struct starfive_priv *priv = host->priv;
>> -       int rise_point = -1, fall_point = -1;
>> -       int err, prev_err = 0;
>> +       int err = -1;
> 
> This variable is always set later so doesn't need initialization and
> is better called 'ret' as it's the return value of the function, and
> not necessarily an error.
Will update.
> 
>> +       int smpl_phase, smpl_raise = -1, smpl_fall = -1;
>>         int i;
>> -       bool found = 0;
>> -       u32 regval;
>> -
>> -       /*
>> -        * Use grade as the max delay chain, and use the rise_point and
>> -        * fall_point to ensure the best sampling point of a data input
>> -        * signals.
>> -        */
>> +
>>         for (i = 0; i < grade; i++) {
>> -               regval = i << priv->syscon_shift;
>> -               err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
>> -                                               priv->syscon_mask, regval);
>> -               if (err)
>> -                       return err;
>> +               smpl_phase = i;
> 
> This can now be written
> 
> for (sampl_phase = 0; sampl_phase < grade; sampl_phase++)
> 
Will update.
>> +               dw_mci_starfive_hs_set_bits(host, smpl_phase);
>>                 mci_writel(host, RINTSTS, ALL_INT_CLR);
>>
>>                 err = mmc_send_tuning(slot->mmc, opcode, NULL);
>> -               if (!err)
>> -                       found = 1;
>> -
>> -               if (i > 0) {
>> -                       if (err && !prev_err)
>> -                               fall_point = i - 1;
>> -                       if (!err && prev_err)
>> -                               rise_point = i;
>> -               }
>>
>> -               if (rise_point != -1 && fall_point != -1)
>> -                       goto tuning_out;
>> -
>> -               prev_err = err;
>> -               err = 0;
>> -       }
>> -
>> -tuning_out:
>> -       if (found) {
>> -               if (rise_point == -1)
>> -                       rise_point = 0;
>> -               if (fall_point == -1)
>> -                       fall_point = grade - 1;
>> -               if (fall_point < rise_point) {
>> -                       if ((rise_point + fall_point) >
>> -                           (grade - 1))
>> -                               i = fall_point / 2;
>> -                       else
>> -                               i = (rise_point + grade - 1) / 2;
>> -               } else {
>> -                       i = (rise_point + fall_point) / 2;
>> +               if (!err && smpl_raise < 0) {
>> +                       smpl_raise = i;
>> +               } else if (err && smpl_raise >= 0) {
>> +                       smpl_fall = i - 1;
>> +                       break;
>>                 }
>> +       }
>>
>> -               regval = i << priv->syscon_shift;
>> -               err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
>> -                                               priv->syscon_mask, regval);
>> -               if (err)
>> -                       return err;
>> -               mci_writel(host, RINTSTS, ALL_INT_CLR);
>> +       if (i >= grade && smpl_raise >= 0)
>> +               smpl_fall = grade - 1;
>>
>> -               dev_info(host->dev, "Found valid delay chain! use it [delay=%d]\n", i);
>> -       } else {
>> +       if (smpl_raise < 0) {
>>                 dev_err(host->dev, "No valid delay chain! use default\n");
>> +               dw_mci_starfive_hs_set_bits(host, 0);
>>                 err = -EINVAL;
>> +       } else {
>> +               smpl_phase = (smpl_raise + smpl_fall) / 2;
>> +               dw_mci_starfive_hs_set_bits(host, smpl_phase);
>> +               dev_dbg(host->dev, "Found valid delay chain! use it [delay=%d]\n", smpl_phase);
>> +               err = 0;
>>         }
> 
> Maybe something like:
> 
>   if (smpl_raise < 0) {
>     smpl_phase = 0;
>     dev_err(host->dev, "No valid delay chain, using default\n");
>     ret = -EINVAL;
>     goto out;
>   }
> 
>   smpl_phase = (smpl_raise + smpl_fall) / 2;
>   dev_dbg(...);
>   ret = 0;
> 
> out:
>   dw_mci_starfive_hs_set_bits(host, smpl_phase);
>   mci_writel(host, RINTSTS, ALL_INT_CLR);
>   return ret;
>>  }
>>
I'll try it.

Thanks for taking time to review this patch series and giving so much
helpful suggestions.

Best regards,
William
>> -static int dw_mci_starfive_parse_dt(struct dw_mci *host)
>> -{
>> -       struct of_phandle_args args;
>> -       struct starfive_priv *priv;
>> -       int ret;
>> -
>> -       priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
>> -       if (!priv)
>> -               return -ENOMEM;
>> -
>> -       ret = of_parse_phandle_with_fixed_args(host->dev->of_node,
>> -                                               "starfive,sysreg", 3, 0, &args);
>> -       if (ret) {
>> -               dev_err(host->dev, "Failed to parse starfive,sysreg\n");
>> -               return -EINVAL;
>> -       }
>> -
>> -       priv->reg_syscon = syscon_node_to_regmap(args.np);
>> -       of_node_put(args.np);
>> -       if (IS_ERR(priv->reg_syscon))
>> -               return PTR_ERR(priv->reg_syscon);
>> -
>> -       priv->syscon_offset = args.args[0];
>> -       priv->syscon_shift  = args.args[1];
>> -       priv->syscon_mask   = args.args[2];
>> -
>> -       host->priv = priv;
>> -
>> -       return 0;
>> -}
>> -
>>  static const struct dw_mci_drv_data starfive_data = {
>>         .common_caps            = MMC_CAP_CMD23,
>>         .set_ios                = dw_mci_starfive_set_ios,
>> -       .parse_dt               = dw_mci_starfive_parse_dt,
>>         .execute_tuning         = dw_mci_starfive_execute_tuning,
>>  };
>>
>> --
>> 2.34.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
