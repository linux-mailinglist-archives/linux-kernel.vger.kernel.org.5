Return-Path: <linux-kernel+bounces-16987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D54D8246E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8381F23C25
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8526A25577;
	Thu,  4 Jan 2024 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPcxO3yM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7825568;
	Thu,  4 Jan 2024 17:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E46C433C7;
	Thu,  4 Jan 2024 17:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704388144;
	bh=RWeAVVvZw1mx2BvGayUBS6umOxU8tPTVMM+VecJn/f8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HPcxO3yMF3LAMwce01ASv+HwPrY6kxiRVKzBS1WDDfGH4hfeIaJwmR8OsadaPgI+q
	 QOUuo6L0QiaDmKaFgIzixHb4rGQY2OLcVMpdHSVSNOtxTMeeqw3c7Ivs6LXHNqPwTD
	 PgMzUiD+Pp/r/5exuDJyKI5s8fvXJy+BSB2KqspKzKTYzYTb0mqPYOKG5aPdV6OcCI
	 XbSNeR1xlNpU82dXUZRMygcOd4KqzAjbeRj6ZTOGJD5FZ12rEsBq6n9vdTz4oxocSk
	 jo5XHUncegf+8c0b7f2cxzV0k0qmTCOZoSBEjuDNeEVQK4eUq7A+i/ufwCtlMP5N6d
	 Cfsfs67PvbVag==
Message-ID: <5ed7ee66-ad7f-43ce-8550-a1a671cce9ad@kernel.org>
Date: Thu, 4 Jan 2024 19:08:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] usb: typec: tipd: add patch update support for
 tps6598x
Content-Language: en-US
To: Javier Carrasco <javier.carrasco@wolfvision.net>,
 Jai Luthra <j-luthra@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, vigneshr@ti.com,
 d-gole@ti.com, nm@ti.com
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws>
 <2nqiaxakx6setx4tzgddnbjadbh7miegz5p6wamsbbiyrfuq3x@un2uxajbswkg>
 <e9e8dd9f-b11b-43fc-8d76-6734dbddb540@kernel.org>
 <b0963302-b498-4a81-b635-0b4faf02e83b@wolfvision.net>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <b0963302-b498-4a81-b635-0b4faf02e83b@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/01/2024 18:36, Javier Carrasco wrote:
> On 04.01.24 17:15, Roger Quadros wrote:
>>
>>
>> On 04/01/2024 17:47, Jai Luthra wrote:
>>> Hi Javier,
>>> The following change seems to fix boot on SK-AM62A without reverting 
>>> this whole series:
>>>
>>> ------------------
>>>
>>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
>>> index a956eb976906a5..8ba2aa05db519b 100644
>>> --- a/drivers/usb/typec/tipd/core.c
>>> +++ b/drivers/usb/typec/tipd/core.c
>>> @@ -1223,11 +1223,16 @@ static int cd321x_reset(struct tps6598x *tps)
>>>  	return 0;
>>>  }
>>>  
>>> -static int tps6598x_reset(struct tps6598x *tps)
>>> +static int tps25750_reset(struct tps6598x *tps)
>>>  {
>>>  	return tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
>>>  }
>>>  
>>> +static int tps6598x_reset(struct tps6598x *tps)
>>> +{
>>> +	return 0;
>>> +}
>>> +
>>>  static int
>>>  tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>>>  {
>>> @@ -1545,7 +1550,7 @@ static const struct tipd_data tps25750_data = {
>>>  	.trace_status = trace_tps25750_status,
>>>  	.apply_patch = tps25750_apply_patch,
>>>  	.init = tps25750_init,
>>> -	.reset = tps6598x_reset,
>>> +	.reset = tps25750_reset,
>>>  };
>>>  
>>>  static const struct of_device_id tps6598x_of_match[] = {
>>>
>>> ------------------
>>>
>>> I am not an expert on this, will let you/others decide on what should be 
>>> the correct way to reset TPS6598x for patching without breaking this SK.
>>>
>>>
>>
>> This looks like a correct fix to me.
>> Could you please send a proper PATCH with Fixes tag? Thanks!
>>
> Hi Roger,
> 
> that fix only removes the reset function and does nothing instead, but
> the reset call is identical for both devices (hence why there was a
> single function for both devices). As I mentioned in my reply to Jai

This is incorrect.

Look at the original code, the GAID command is issued only if it is a
tps25750 device.

Below is your part of the code that replaces it with reset() ops.

> @@ -1340,8 +1360,8 @@ static int tps6598x_probe(struct i2c_client *client)
>  	tps6598x_write64(tps, TPS_REG_INT_MASK1, 0);
>  err_reset_controller:
>  	/* Reset PD controller to remove any applied patch */
> -	if (is_tps25750)
> -		tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
> +	tps->data->reset(tps);
> +
>  	return ret;
>  }

which means the GAID command will be executed for both tps25750 and tps6598x
as you have a single reset function for both.
This is a problem for boards using the tps6598x.

-- 
cheers,
-roger

