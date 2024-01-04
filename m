Return-Path: <linux-kernel+bounces-16913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20448245F6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F971C22153
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C0824B29;
	Thu,  4 Jan 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYk2jAgs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4049324A1B;
	Thu,  4 Jan 2024 16:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC28C433C8;
	Thu,  4 Jan 2024 16:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704384938;
	bh=+AK3EiDB7WkkEDGaWDzjr4SA9IZ3WUxn71kdFfQXzs4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dYk2jAgsD9rODtIPU35JFrPztzYN+tWpHo6cTE8ctXePesyvwzr3Qk0JPlSQdt0cV
	 eRzHzR07Q6yqNRoyeEcIFxnIsLlNW7uy9atHYcuf0gIyxw9zQDIPstZ7m2GQfZuAVN
	 NW7Hy5ViIivZVdir0kXQHeqfBzM2vmquzkG4h6V4210NY55Q7EHvCr8yXNdFSXPRo7
	 zvCuaDW9dTXKWdhN6PF3W9K89vAVZbcoVl4JIyEv+RxBM/8u9wu/aSfLkYRtlNrZoS
	 mWKNyqPGxJ+gUJV8DBlvJkFU457+MLEJl/ujTNwvUYyJK2bg8xWMo2ocXcg035Dw0I
	 We1nQitOIECqQ==
Message-ID: <e9e8dd9f-b11b-43fc-8d76-6734dbddb540@kernel.org>
Date: Thu, 4 Jan 2024 18:15:36 +0200
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
To: Jai Luthra <j-luthra@ti.com>,
 Javier Carrasco <javier.carrasco@wolfvision.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, vigneshr@ti.com,
 d-gole@ti.com, nm@ti.com
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws>
 <2nqiaxakx6setx4tzgddnbjadbh7miegz5p6wamsbbiyrfuq3x@un2uxajbswkg>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <2nqiaxakx6setx4tzgddnbjadbh7miegz5p6wamsbbiyrfuq3x@un2uxajbswkg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/01/2024 17:47, Jai Luthra wrote:
> Hi Javier,
> 
> On Jan 04, 2024 at 19:50:05 +0530, Jai Luthra wrote:
>> Hi Javier, Greg,
>>
>> On Dec 14, 2023 at 17:29:08 +0100, Javier Carrasco wrote:
>>> This series extends the patch update mechanism to support the tps6598x.
>>>
>>> Currently there is only support for the tps25750 part and some
>>> conditional clauses are used to make a special case out of it. Now that
>>> different parts support patch updates, a more general approach is
>>> proposed.
>>>
>>> The update mechanism differs from the one required by tps25750 and it is
>>> explained in the commit message as a summary of the application note in
>>> that respect.
>>>
>>> Note that the series makes use of the TPS_SETUP_MS introduced in
>>> commit 6a4d4a27f986 ("usb: typec: tps6598x: add reset gpio support"),
>>> which is currently available in usb-next / usb-testing.
>>>
>>> A TPS65987D has been used to test this functionality with positive
>>> results.
>>>
>>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>>> ---
>>> Changes in v2:
>>> - Remove probe defeferring mechanism and expect the firmware to be
>>>   available (Heikki Krogerus).
>>> - Link to v1: 
>>> https://lore.kernel.org/r/20231207-tps6598x_update-v1-0-dc21b5301d91@wolfvision.net
>>>
>>
>> FYI, this series breaks boot for TI SK-AM62A and SK-AM62 which use 
>> TPS6598x as the USB-C PD chip.
>>
>> The platforms stopped booting since next-20240103 [1], and reverting 
>> this series [4] seems to fix the issue [2]
>>
>> Is there any change needed in the board device-tree [3] and bindings?
>>
>> We don't specify any firmware in the device-tree node, but seems like 
>> that is an assumption in this series. I tried reverting it (below 
>> change) but that did *not* help with the stuck boot.
>>
>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
>> index a956eb976906..fa3bd7349265 100644
>> --- a/drivers/usb/typec/tipd/core.c
>> +++ b/drivers/usb/typec/tipd/core.c
>> @@ -1139,7 +1139,7 @@ static int tps6598x_apply_patch(struct tps6598x *tps)
>>         ret = device_property_read_string(tps->dev, "firmware-name",
>>                                           &firmware_name);
>>         if (ret)
>> -               return ret;
>> +               return 0;
>>
>>         ret = tps_request_firmware(tps, &fw);
>>         if (ret)
>>
>>
>> [1] https://linux.kernelci.org/soc/ti/job/next/kernel/next-20240103/plan/baseline-nfs/
>> [2] https://gist.github.com/jailuthra/0c077176585e4df2f8b78f7784087865
>> [3] https://gitlab.com/linux-kernel/linux-next/-/blob/master/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts#L305
>> [4] https://github.com/jailuthra/linux/commits/next-20240103-tps6598-fix/
> 
> The following change seems to fix boot on SK-AM62A without reverting 
> this whole series:
> 
> ------------------
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index a956eb976906a5..8ba2aa05db519b 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1223,11 +1223,16 @@ static int cd321x_reset(struct tps6598x *tps)
>  	return 0;
>  }
>  
> -static int tps6598x_reset(struct tps6598x *tps)
> +static int tps25750_reset(struct tps6598x *tps)
>  {
>  	return tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
>  }
>  
> +static int tps6598x_reset(struct tps6598x *tps)
> +{
> +	return 0;
> +}
> +
>  static int
>  tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>  {
> @@ -1545,7 +1550,7 @@ static const struct tipd_data tps25750_data = {
>  	.trace_status = trace_tps25750_status,
>  	.apply_patch = tps25750_apply_patch,
>  	.init = tps25750_init,
> -	.reset = tps6598x_reset,
> +	.reset = tps25750_reset,
>  };
>  
>  static const struct of_device_id tps6598x_of_match[] = {
> 
> ------------------
> 
> I am not an expert on this, will let you/others decide on what should be 
> the correct way to reset TPS6598x for patching without breaking this SK.
> 
> 

This looks like a correct fix to me.
Could you please send a proper PATCH with Fixes tag? Thanks!

-- 
cheers,
-roger

