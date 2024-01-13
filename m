Return-Path: <linux-kernel+bounces-25174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEC982C910
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 03:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CB7DB23965
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A678918EC3;
	Sat, 13 Jan 2024 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="X3z7GvZx"
Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B9818B15;
	Sat, 13 Jan 2024 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Received: from [192.168.0.24] (71-212-26-68.tukw.qwest.net [71.212.26.68])
	by endrift.com (Postfix) with ESMTPSA id BC5A4A114;
	Fri, 12 Jan 2024 18:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1705111864; bh=v5VXITQd0KCg/Jf8oHl/mWiFAfKUv01SrcH7y13eI5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X3z7GvZxb5UUY8gvShzR5MYNYDzqvos9WjekT3UOSbOYC/YFPdc1GtZFGWb33yGdc
	 reY7rTDWr9spSGTWe81rvHTe1u6LUIfy6wrRBpSPDSMPoCrtFhqVfGCBOQC566bUHf
	 lRTuVKlDuDRBQg7FDt9ReCV2osgDY0xvMi7wnZjrpF0b0sQbZY0Yas5riIbnFe/V8j
	 yqJAzbHOVVfu7l3BA0qO2gCi1KMYm2zBG8n9YYUVpCj14oY0E7FmBzZz91tVCk2QT2
	 srmROlYgWZRstGR+JhqJaLpSvF+XvnBy9ZLLE43NgVnsyjDn7roQQcNFCLWsfMDxdU
	 1Ys0QN5Hb1AOw==
Message-ID: <5e17d884-5803-43b3-be94-063c2293f5a0@endrift.com>
Date: Fri, 12 Jan 2024 18:11:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] HID: hid-steam: Fix cleanup in probe()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <1fd87904-dabf-4879-bb89-72d13ebfc91e@moroto.mountain>
From: Vicki Pfau <vi@endrift.com>
In-Reply-To: <1fd87904-dabf-4879-bb89-72d13ebfc91e@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have applied this to our downstream and made sure it compiles and runs 
without obvious issues.

Reviewed-by: Vicki Pfau <vi@endrift.com>

Thanks,
Vicki

On 1/12/24 06:35, Dan Carpenter wrote:
> There are a number of issues in this code.  First of all if
> steam_create_client_hid() fails then it leads to an error pointer
> dereference when we call hid_destroy_device(steam->client_hdev).
> 
> Also there are a number of leaks.  hid_hw_stop() is not called if
> hid_hw_open() fails for example.  And it doesn't call steam_unregister()
> or hid_hw_close().
> 
> Fixes: 691ead124a0c ("HID: hid-steam: Clean up locking")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This is just from static analysis and code review.  I haven't tested
> it.  I only included the fixes tag for the error pointer dereference.
> 
>   drivers/hid/hid-steam.c | 26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 59df6ead7b54..b08a5ab58528 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -1128,14 +1128,14 @@ static int steam_probe(struct hid_device *hdev,
>   	 */
>   	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_HIDRAW);
>   	if (ret)
> -		goto hid_hw_start_fail;
> +		goto err_cancel_work;
>   
>   	ret = hid_hw_open(hdev);
>   	if (ret) {
>   		hid_err(hdev,
>   			"%s:hid_hw_open\n",
>   			__func__);
> -		goto hid_hw_open_fail;
> +		goto err_hw_stop;
>   	}
>   
>   	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
> @@ -1151,33 +1151,37 @@ static int steam_probe(struct hid_device *hdev,
>   			hid_err(hdev,
>   				"%s:steam_register failed with error %d\n",
>   				__func__, ret);
> -			goto input_register_fail;
> +			goto err_hw_close;
>   		}
>   	}
>   
>   	steam->client_hdev = steam_create_client_hid(hdev);
>   	if (IS_ERR(steam->client_hdev)) {
>   		ret = PTR_ERR(steam->client_hdev);
> -		goto client_hdev_fail;
> +		goto err_stream_unregister;
>   	}
>   	steam->client_hdev->driver_data = steam;
>   
>   	ret = hid_add_device(steam->client_hdev);
>   	if (ret)
> -		goto client_hdev_add_fail;
> +		goto err_destroy;
>   
>   	return 0;
>   
> -client_hdev_add_fail:
> -	hid_hw_stop(hdev);
> -client_hdev_fail:
> +err_destroy:
>   	hid_destroy_device(steam->client_hdev);
> -input_register_fail:
> -hid_hw_open_fail:
> -hid_hw_start_fail:
> +err_stream_unregister:
> +	if (steam->connected)
> +		steam_unregister(steam);
> +err_hw_close:
> +	hid_hw_close(hdev);
> +err_hw_stop:
> +	hid_hw_stop(hdev);
> +err_cancel_work:
>   	cancel_work_sync(&steam->work_connect);
>   	cancel_delayed_work_sync(&steam->mode_switch);
>   	cancel_work_sync(&steam->rumble_work);
> +
>   	return ret;
>   }
>   

