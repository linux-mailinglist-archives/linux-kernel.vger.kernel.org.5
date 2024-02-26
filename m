Return-Path: <linux-kernel+bounces-80922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C9C866E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80261C23C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16123537FC;
	Mon, 26 Feb 2024 08:41:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0E7535BD;
	Mon, 26 Feb 2024 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936878; cv=none; b=UO0vxvOB3gGI2l2CXngXohTj+Qw5Vdx3dWeHeVYxvyCyC6/sG40pLpyZowf5XYLhJMmb9RdlMbbtXHJKv8dkySdkPrGOIYY9zOMI100ucfvGvkv3okQjnjoaRx2gqoZgBv/6Pjaq8C4smBtLR9yQ1KG8NsFnfxWS8Md7x0V4kkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936878; c=relaxed/simple;
	bh=HZBY62gKoi716H6fyVPpem58WiRdnL0aIJBx56d/GZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aG/ZezwMB+S8aiDNAuszVMfkECIHRNqJJFiDJXdzVUie4/J8/MBqmmlx2FbL8YBm2txZ3hqwc10FE57cHix+ONjFG4URJ9rxiw/YH/mU6k/Sb4ngkWAS8+004g5tRSE8/4dUzAy4Au1mGJU+rzt9xi+scqodfyMVkNmBVOYDiMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F96C433F1;
	Mon, 26 Feb 2024 08:41:16 +0000 (UTC)
Message-ID: <21ccdf91-19e1-497e-be65-ef2063ea0b7f@xs4all.nl>
Date: Mon, 26 Feb 2024 09:41:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] media: dvbdev: export adapter's name and bus ID to
 DVB uevent variables
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hyunwoo Kim <imv4bel@gmail.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Zhipeng Lu <alexious@zju.edu.cn>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <cover.1708422122.git.mchehab@kernel.org>
 <22e1d85d8896681a3f3f9abdc323e634b49fa1fd.1708422122.git.mchehab@kernel.org>
Content-Language: en-US, nl
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <22e1d85d8896681a3f3f9abdc323e634b49fa1fd.1708422122.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/02/2024 10:46, Mauro Carvalho Chehab wrote:
> Add two new variables for uevent, helping udev to be able to setup
> a persistent name for the device.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans

> ---
>  drivers/media/dvb-core/dvbdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
> index 733d0bc4b4cc..01227c695cbd 100644
> --- a/drivers/media/dvb-core/dvbdev.c
> +++ b/drivers/media/dvb-core/dvbdev.c
> @@ -1064,6 +1064,8 @@ static int dvb_uevent(const struct device *dev, struct kobj_uevent_env *env)
>  {
>  	const struct dvb_device *dvbdev = dev_get_drvdata(dev);
>  
> +	add_uevent_var(env, "DVB_ADAPTER_NAME=%s", dvbdev->adapter->name);
> +	add_uevent_var(env, "DVB_ADAPTER_PDEV=%s", dev_name(dev->parent));
>  	add_uevent_var(env, "DVB_ADAPTER_NUM=%d", dvbdev->adapter->num);
>  	add_uevent_var(env, "DVB_DEVICE_TYPE=%s", dnames[dvbdev->type]);
>  	add_uevent_var(env, "DVB_DEVICE_NUM=%d", dvbdev->id);


