Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBFE7FEB95
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjK3JNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjK3JNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:13:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA9CCF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:13:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19138C433C8;
        Thu, 30 Nov 2023 09:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701335587;
        bh=1b5n1u0HCJUEMU91f4bqm1fCxOvlLW0lTOnXR/X8puM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ohAjosXsG160KYRwo2lKfZlJUAku1zb2a0wMVGHa9Z+i69aKzYuMK8RMRilJb9x2L
         2ySPgaXWLL84rqqTC8/lNMcoKdO8CUQTDji/ZBLRhp3Y/rMyDf7AtyKXp49dHWXmMa
         B3tsCF70NVgb6m51WeXEs6vurx6QsXP0kjSS4QpgcB3DCJ3tExfkw4LSwape6GCJRq
         aaRc28CMOSJcYK4bGAkbjyBpLPxJSrQ8v96lP/7ANCZM4/c7+2A6aOLsX/f9j2+BcD
         WC6Qq8b9jq5cbNTYPlGNjQCaQ2+WcwXzyUYqiaVpsqUkTR1w7BIX6g3OR9xFLtvCRw
         ccAOpy68l5HQw==
Message-ID: <47ffbb30-34a7-4f5b-b262-3e068e574c8a@kernel.org>
Date:   Thu, 30 Nov 2023 11:13:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: typec: tps6598x: use device 'type' field to identify
 devices
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, christophe.jaillet@wanadoo.fr,
        a-govindraju@ti.com, trix@redhat.com, abdelalkuor@geotab.com
References: <20231123210021.463122-1-alex@shruggie.ro>
 <ZWdKI9UOZ6INP0Tu@kuha.fi.intel.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <ZWdKI9UOZ6INP0Tu@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/11/2023 16:26, Heikki Krogerus wrote:
> Hi,
> 
> Sorry to keep you waiting.
> 
> On Thu, Nov 23, 2023 at 11:00:21PM +0200, Alexandru Ardelean wrote:
>> Using the {of_}device_is_compatible function(s) is not too expensive.
>> But since the driver already needs to match for the 'struct tipd_data'
>> device parameters (via device_get_match_data()), we can add a simple 'type'
>> field.
>>
>> This adds a minor optimization in certain operations, where we the check
>> for TPS25750 (or Apple CD321X) is a bit faster.
>>
>> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
>> ---
>>  drivers/usb/typec/tipd/core.c | 34 ++++++++++++++++++++++------------
>>  1 file changed, 22 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
>> index fbd23de5c5cb..69d3e11bb30c 100644
>> --- a/drivers/usb/typec/tipd/core.c
>> +++ b/drivers/usb/typec/tipd/core.c
>> @@ -105,7 +105,14 @@ static const char *const modes[] = {
>>  
>>  struct tps6598x;
>>  
>> +enum tipd_type {
>> +	TIPD_TYPE_TI_TPS6598X,
>> +	TIPD_TYPE_APPLE_CD321X,
>> +	TIPD_TYPE_TI_TPS25750X,
>> +};
>> +
>>  struct tipd_data {
>> +	enum tipd_type type;
>>  	irq_handler_t irq_handler;
>>  	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
>>  	void (*trace_power_status)(u16 status);
> 
> Why not just match against the structures themselves?
> 
>         if (tps->data == &tps25750_data)
>                 ...

Then you need to declare tps25750_data and friends at the top of the file?

A better approach might be to have type agnostic quirk flags for the special
behavior required for different types. This way, multiple devices can share
the same quirk if needed.

e.g.
NEEDS_POWER_UP instead of TIPD_TYPE_APPLE_CD321X
SKIP_VID_READ instead of TIPD_TYPE_TI_TPS25750X
INIT_ON_RESUME instead of TIPD_TYPE_TI_TPS25750X

Also rename cd321x_switch_power_state() to tps6598x_switch_power_state().

> 
>> @@ -1195,7 +1202,6 @@ tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>>  
>>  static int tps6598x_probe(struct i2c_client *client)
>>  {
>> -	struct device_node *np = client->dev.of_node;
>>  	struct tps6598x *tps;
>>  	struct fwnode_handle *fwnode;
>>  	u32 status;
>> @@ -1211,11 +1217,19 @@ static int tps6598x_probe(struct i2c_client *client)
>>  	mutex_init(&tps->lock);
>>  	tps->dev = &client->dev;
>>  
>> +	if (dev_fwnode(tps->dev))
>> +		tps->data = device_get_match_data(tps->dev);
>> +	else
>> +		tps->data = i2c_get_match_data(client);
>> +
>> +	if (!tps->data)
>> +		return -EINVAL;
>> +
>>  	tps->regmap = devm_regmap_init_i2c(client, &tps6598x_regmap_config);
>>  	if (IS_ERR(tps->regmap))
>>  		return PTR_ERR(tps->regmap);
>>  
>> -	is_tps25750 = device_is_compatible(tps->dev, "ti,tps25750");
>> +	is_tps25750 = (tps->data->type == TIPD_TYPE_TI_TPS25750X);
>>  	if (!is_tps25750) {
>>  		ret = tps6598x_read32(tps, TPS_REG_VID, &vid);
>>  		if (ret < 0 || !vid)
>> @@ -1229,7 +1243,7 @@ static int tps6598x_probe(struct i2c_client *client)
>>  	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>>  		tps->i2c_protocol = true;
>>  
>> -	if (np && of_device_is_compatible(np, "apple,cd321x")) {
>> +	if (tps->data->type == TIPD_TYPE_APPLE_CD321X) {
>>  		/* Switch CD321X chips to the correct system power state */
>>  		ret = cd321x_switch_power_state(tps, TPS_SYSTEM_POWER_STATE_S0);
>>  		if (ret)
>> @@ -1247,13 +1261,6 @@ static int tps6598x_probe(struct i2c_client *client)
>>  			TPS_REG_INT_PLUG_EVENT;
>>  	}
>>  
>> -	if (dev_fwnode(tps->dev))
>> -		tps->data = device_get_match_data(tps->dev);
>> -	else
>> -		tps->data = i2c_get_match_data(client);
>> -	if (!tps->data)
>> -		return -EINVAL;
>> -
>>  	/* Make sure the controller has application firmware running */
>>  	ret = tps6598x_check_mode(tps);
>>  	if (ret < 0)
>> @@ -1366,7 +1373,7 @@ static void tps6598x_remove(struct i2c_client *client)
>>  	usb_role_switch_put(tps->role_sw);
>>  
>>  	/* Reset PD controller to remove any applied patch */
>> -	if (device_is_compatible(tps->dev, "ti,tps25750"))
>> +	if (tps->data->type == TIPD_TYPE_TI_TPS25750X)
>>  		tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
>>  }
>>  
>> @@ -1396,7 +1403,7 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
>>  	if (ret < 0)
>>  		return ret;
>>  
>> -	if (device_is_compatible(tps->dev, "ti,tps25750") && ret == TPS_MODE_PTCH) {
>> +	if (tps->data->type == TIPD_TYPE_TI_TPS25750X && ret == TPS_MODE_PTCH) {
>>  		ret = tps25750_init(tps);
>>  		if (ret)
>>  			return ret;
>> @@ -1419,6 +1426,7 @@ static const struct dev_pm_ops tps6598x_pm_ops = {
>>  };
>>  
>>  static const struct tipd_data cd321x_data = {
>> +	.type = TIPD_TYPE_APPLE_CD321X,
>>  	.irq_handler = cd321x_interrupt,
>>  	.register_port = tps6598x_register_port,
>>  	.trace_power_status = trace_tps6598x_power_status,
>> @@ -1426,6 +1434,7 @@ static const struct tipd_data cd321x_data = {
>>  };
>>  
>>  static const struct tipd_data tps6598x_data = {
>> +	.type = TIPD_TYPE_TI_TPS6598X,
>>  	.irq_handler = tps6598x_interrupt,
>>  	.register_port = tps6598x_register_port,
>>  	.trace_power_status = trace_tps6598x_power_status,
>> @@ -1433,6 +1442,7 @@ static const struct tipd_data tps6598x_data = {
>>  };
>>  
>>  static const struct tipd_data tps25750_data = {
>> +	.type = TIPD_TYPE_TI_TPS25750X,
>>  	.irq_handler = tps25750_interrupt,
>>  	.register_port = tps25750_register_port,
>>  	.trace_power_status = trace_tps25750_power_status,
>> -- 
>> 2.42.1
> 
> thanks,
> 

-- 
cheers,
-roger
