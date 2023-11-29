Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5860E7FD7BE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjK2NR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjK2NR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:17:56 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B20F83;
        Wed, 29 Nov 2023 05:18:01 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF0CC6000C;
        Wed, 29 Nov 2023 13:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701263880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wKI+hTaPWm9IgB2aTUcFEiK9e3vWZZ3L59iijkA2Q1w=;
        b=RNzpWIu9JDcfZ5DhmRBpo9HLxcgCW3Fr2eDAtIYGYc1vNMb9mcz5nIQusxdIz8N+YPtS/0
        byNtojZWtUvlkhiVE04+UNxqiOF7Xf73IvIw6g+Fxj6LIIuZ/8EAzke92HkCQMm+TX5mym
        3rviZ8V5WLGK+6h7MjqZ7FICB6wq0xUiXMWQDh8VoZoIqMXdlrmKdv3gMcACGcC9ensBQ4
        yuI303ITJutfY8Ja23fjyaK89BXl4WOZlWlhu3+0CAqmMy8R+ga+pUIzpfJz1EJURmjUp+
        KWGqzS+pWlcleVSy94DLBKXAx7j4ufmBSKSP2edIMK/anUBBK0bFAes7WU9t/g==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Roger Quadros <rogerq@kernel.org>,
        Thomas Richard <thomas.richard@bootlin.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        s-vadapalli@ti.com, grygorii.strashko@ti.com,
        dan.carpenter@linaro.org, thomas.petazzoni@bootlin.com,
        u-kumar1@ti.com
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: improve suspend/resume
 support for J7200
In-Reply-To: <e37e8d74-d741-44fb-9e28-2b9203331637@kernel.org>
References: <20231128131936.600233-1-thomas.richard@bootlin.com>
 <e37e8d74-d741-44fb-9e28-2b9203331637@kernel.org>
Date:   Wed, 29 Nov 2023 14:17:59 +0100
Message-ID: <87bkbcg0l4.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

> Hi,
>
> On 28/11/2023 15:19, Thomas Richard wrote:
>> From: Gregory CLEMENT <gregory.clement@bootlin.com>
>
> Subject is vague. Please be explicit about you are trying to do.

Yes we can do better.

>
>> 
>> On J7200 the SoC is off during suspend, so the clocks have to be
>
> What do you mean by SoC is off? I suppose you are referring to a certain
> low power state of the SoC?

As during suspend to ram all the power rails of the SoC are shutdown, I
guess we can say that the SoC is off.

>
> By "clocks have to be completely powered down" you mean they have to
> be gated in addition to be disabled? What happens if they are left ungated?
> Does it prevent SoC form entering the target low power state?

That prevent to resume properly. The SoC being off, if you don't
explicitly shut down the clocks, then the state of the clock does not
math the expectation of the kernel.

>
>> completely power down, and phy_set_mode_ext must be called again.
>
> Why must phy_set_mode_ext() be called again?

If I remember well, it was because this information is lost during
suspend so we have to set it again.

>
>> 
>
> Not all SoCs behave like J7200 so can we please restrict this change
> to J7200? Thanks.

Did you test it on a Sitara SoC ?

Does it cause a regression ?

Gregory

>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>> ---
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 25 ++++++++++++++++++++++++
>>  drivers/net/ethernet/ti/am65-cpts.c      | 11 +++++++++--
>>  2 files changed, 34 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> index ece9f8df98ae..e95ef30bd67f 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> @@ -2115,6 +2115,27 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
>>  	return ret;
>>  }
>>  
>> +static int am65_cpsw_nuss_resume_slave_ports(struct am65_cpsw_common *common)
>> +{
>> +	struct device *dev = common->dev;
>> +	int i;
>> +
>> +	for (i = 1; i <= common->port_num; i++) {
>> +		struct am65_cpsw_port *port;
>> +		int ret;
>> +
>> +		port = am65_common_get_port(common, i);
>> +
>> +		ret = phy_set_mode_ext(port->slave.ifphy, PHY_MODE_ETHERNET, port->slave.phy_if);
>> +		if (ret) {
>> +			dev_err(dev, "port %d error setting phy mode %d\n", i, ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static void am65_cpsw_pcpu_stats_free(void *data)
>>  {
>>  	struct am65_cpsw_ndev_stats __percpu *stats = data;
>> @@ -3087,6 +3108,10 @@ static int am65_cpsw_nuss_resume(struct device *dev)
>>  	if (common->rx_irq_disabled)
>>  		disable_irq(common->rx_chns.irq);
>>  
>> +	ret = am65_cpsw_nuss_resume_slave_ports(common);
>> +	if (ret)
>> +		dev_err(dev, "failed to resume slave ports: %d", ret);
>> +
>>  	am65_cpts_resume(common->cpts);
>>  
>>  	for (i = 0; i < common->port_num; i++) {
>> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
>> index c66618d91c28..e6db5b61409a 100644
>> --- a/drivers/net/ethernet/ti/am65-cpts.c
>> +++ b/drivers/net/ethernet/ti/am65-cpts.c
>> @@ -1189,7 +1189,11 @@ void am65_cpts_suspend(struct am65_cpts *cpts)
>>  	cpts->sr_cpts_ns = am65_cpts_gettime(cpts, NULL);
>>  	cpts->sr_ktime_ns = ktime_to_ns(ktime_get_real());
>>  	am65_cpts_disable(cpts);
>> -	clk_disable(cpts->refclk);
>> +
>> +	/* During suspend the SoC can be power off, so let's not only
>> +	 * disable but also unprepare the clock
>> +	 */
>> +	clk_disable_unprepare(cpts->refclk);
>>  
>>  	/* Save GENF state */
>>  	memcpy_fromio(&cpts->sr_genf, &cpts->reg->genf, sizeof(cpts->sr_genf));
>> @@ -1204,8 +1208,11 @@ void am65_cpts_resume(struct am65_cpts *cpts)
>>  	int i;
>>  	s64 ktime_ns;
>>  
>> +	/* During suspend the SoC can be power off, so let's not only
>> +	 * enable but also prepare the clock
>> +	 */
>> +	clk_prepare_enable(cpts->refclk);
>>  	/* restore state and enable CPTS */
>> -	clk_enable(cpts->refclk);
>>  	am65_cpts_write32(cpts, cpts->sr_rftclk_sel, rftclk_sel);
>>  	am65_cpts_set_add_val(cpts);
>>  	am65_cpts_write32(cpts, cpts->sr_control, control);
>
> -- 
> cheers,
> -roger

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
