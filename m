Return-Path: <linux-kernel+bounces-27342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C3982EE05
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F43B223A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064A81B94C;
	Tue, 16 Jan 2024 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="s9ykoxOy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E747E1B940
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705405395;
	bh=Kn8EISzRHZjy8xP1XBx7o0mFsxZriHl3rVzKRE01vzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s9ykoxOyKhxyiMZpC/Q8EMeZVZf41xqcaTOiSues1mrs/P2cKhaUrFicd8vH2fkOz
	 mkPir1GALlh/NAFsPrGUxMW/b3KnyQGzboyIcaK07pGVnb2eb76obByg15AFyLrQrT
	 9Qz1xHdjO2oQuJe9LsKrP2Xf935QHlCicIM731DFAEPxEKuQtKWcORqCmCjdxr9LtU
	 k6L/emLR/KlvB90CzD3Q9ie0Jbcdqabu5U5DYUEygTc6pp1NNQaJ+BQi7qW7UhcGzi
	 SwiEuhUZ0OguSwHvfXdoRmBQj3BwBoFGE1YuzMZyflbw3mxzusBw+SaiGHSLwNn1YD
	 euVLoyejhrkQg==
Received: from [100.66.96.193] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 411A63782067;
	Tue, 16 Jan 2024 11:43:10 +0000 (UTC)
Message-ID: <490b1e71-d403-02f0-bfe3-04d9f3250d18@collabora.com>
Date: Tue, 16 Jan 2024 17:13:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] drm/ci: add tests on vkms
To: Helen Koike <helen.koike@collabora.com>, dri-devel@lists.freedesktop.org
Cc: hamohammed.sa@gmail.com, daniels@collabora.com,
 rodrigosiqueiramelo@gmail.com, mairacanal@riseup.net,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 linux-kernel@vger.kernel.org, melissa.srw@gmail.com,
 david.heidelberg@collabora.com, airlied@gmail.com
References: <20240102094129.1767591-1-vignesh.raman@collabora.com>
 <c06f3ca9-e588-4012-b864-102ad3e7ea8d@collabora.com>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <c06f3ca9-e588-4012-b864-102ad3e7ea8d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Helen,

On 15/01/24 20:54, Helen Koike wrote:
>> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml 
>> b/drivers/gpu/drm/ci/gitlab-ci.yml
>> index 084e3ff8e3f4..4b636d39734c 100644
>> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
>> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
>> @@ -108,6 +108,7 @@ stages:
>>     - rockchip
>>     - virtio-gpu
>>     - lint
>> +  - software-driver
> 
> I had created this new stage with the intention to also move virtio-gpu 
> to it, so we can patch all "non-real" hardware, what do you think?

Yes we can move virtio-gpu job also to software-driver stage.

>> diff --git a/drivers/gpu/drm/ci/x86_64.config 
>> b/drivers/gpu/drm/ci/x86_64.config
>> index 1cbd49a5b23a..ab4dcca749cc 100644
>> --- a/drivers/gpu/drm/ci/x86_64.config
>> +++ b/drivers/gpu/drm/ci/x86_64.config
>> @@ -24,6 +24,7 @@ CONFIG_DRM=y
>>   CONFIG_DRM_PANEL_SIMPLE=y
>>   CONFIG_PWM_CROS_EC=y
>>   CONFIG_BACKLIGHT_PWM=y
>> +CONFIG_DRM_VKMS=y
> 
> I was wondering if this wouldn't get in the way of other tests, but I 
> guess IGT_FORCE_DRIVER can handle, we just need to make sure it is set 
> and we are testing the correct one.

Yes, we need to skip the vkms tests for other drivers. I think we can go 
with your modprobe approach. We need kmod in debian/x86_64_test-gl 
container to get it working. I have created a MR in mesa for this.

https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27088

Once this is merged, will uprev mesa in drm-ci and send updated vkms patch.

Thanks.

Regards,
Vignesh

