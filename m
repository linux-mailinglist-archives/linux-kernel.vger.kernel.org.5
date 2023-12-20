Return-Path: <linux-kernel+bounces-7089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAF681A182
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7221F22490
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0E93D97A;
	Wed, 20 Dec 2023 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmtjauYY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027D03E460;
	Wed, 20 Dec 2023 14:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7D7C433C7;
	Wed, 20 Dec 2023 14:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703083963;
	bh=r+EJHtX2CGZmcAf/nPtnV8IlN+UOuN9MdxvhWB+ApXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FmtjauYYkwnHUrd8Gm2Ef81hb3wDHJTmCctE1r//mLSagn82uWDTCiwHb5MExl5EA
	 aVucD/2JWRBVU4yZ43PhTqo8WvpOHpa3Z/oeH10rz2gtVkuwkBEiZHVJpjAjhFk7eS
	 qdLVezYcIUcW0c89CevPCjeJoAUtavmVOnJfuC6mfBamIY8XY6rpsZtunp+AIfWa/4
	 xi2tws0HrZSv8qAxmQuB3sz2WPTKNkSFHEp2wafm+xOqkRORxqViQMlemLVk63WVuQ
	 L4AN3AT+2bndJ7VPlUx7gwJrCnUdhyeVebtmsp7Nu4+rFZ/p8NkoqGyeIYsUcwo6kh
	 BGjRfjI7TR1QA==
Date: Wed, 20 Dec 2023 14:52:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yauhen Kharuzhy <jekhor@gmail.com>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Daniel Thompson
 <daniel.thompson@linaro.org>, linux-kernel@vger.kernel.org, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: sensor-hub: Enable hid core report processing for
 all devices
Message-ID: <20231220145229.020abe62@jic23-huawei>
In-Reply-To: <20231219231503.1506801-1-jekhor@gmail.com>
References: <20231219231503.1506801-1-jekhor@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 01:15:03 +0200
Yauhen Kharuzhy <jekhor@gmail.com> wrote:

> After the commit 666cf30a589a ("HID: sensor-hub: Allow multi-function
> sensor devices") hub devices are claimed by hidraw driver in hid_connect().
> This causes stoppping of processing HID reports by hid core due to
> optimization.
> 
> In such case, the hid-sensor-custom driver cannot match a known custom
> sensor in hid_sensor_custom_get_known() because it try to check custom
> properties which weren't filled from the report because hid core didn't
> parsed it.
> 
> As result, custom sensors like hinge angle sensor and LISS sensors
> don't work.
> 
> Mark the sensor hub devices claimed by some driver to avoid hidraw-related
> optimizations.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
Fixes tag?

> ---
>  drivers/hid/hid-sensor-hub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 2eba152e8b90..26e93a331a51 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -632,7 +632,7 @@ static int sensor_hub_probe(struct hid_device *hdev,
>  	}
>  	INIT_LIST_HEAD(&hdev->inputs);
>  
> -	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT | HID_CONNECT_DRIVER);
>  	if (ret) {
>  		hid_err(hdev, "hw start failed\n");
>  		return ret;


