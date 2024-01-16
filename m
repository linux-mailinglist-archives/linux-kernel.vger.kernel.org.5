Return-Path: <linux-kernel+bounces-27175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9DC82EB90
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF88C285168
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CB412B8B;
	Tue, 16 Jan 2024 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rCfPuGEz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF72D134AA;
	Tue, 16 Jan 2024 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705397521;
	bh=lKibuQYhp6UOERuWK5T8c3GPy90Vd3zY06KHV3ZrUEE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rCfPuGEzCOdXJ6v/LjRAwUeGg3bdSDkknK/f+4zu+QCr4L5EsxDxE56cCTAh4xIUB
	 VhPbUF63qbD3TxqT19NYXizSb/WRkLeXSvYben99FM9aHXfIQWmKtSswdE4MFW1kmL
	 vHTscwKtQEXzvsxjXpOsa/06fsfalTfNg3XCAFvnSrhSVbT4uyFDR49mhLWVWCNw9d
	 BSXVkc+OTkTSzaZP0+SboDfjH8aWeqv1cIslRoMW4QhcY6X7WmVLa6j3ZKTpFUpsTM
	 3RYpahiJ3lKTvg1pgpTkgzwxmrnhC5qyASoiaWCqL9jAoonDm+beCgVob8Fd3mvOM2
	 p1cwdUfVv2F5w==
Received: from [100.93.89.217] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C69CC37813E0;
	Tue, 16 Jan 2024 09:32:00 +0000 (UTC)
Message-ID: <521a2a44-9ec1-4898-aca7-721d07e12643@collabora.com>
Date: Tue, 16 Jan 2024 10:32:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: media videobuf2: Stop direct calls to queue
 num_buffers field
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, tfiga@chromium.org,
 m.szyprowski@samsung.com, mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20240115170826.214519-1-benjamin.gaignard@collabora.com>
 <20240115170826.214519-2-benjamin.gaignard@collabora.com>
 <c832da45-c818-420d-aaf8-05c15c1e5426@xs4all.nl>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <c832da45-c818-420d-aaf8-05c15c1e5426@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 16/01/2024 à 10:21, Hans Verkuil a écrit :
> On 15/01/2024 18:08, Benjamin Gaignard wrote:
>> Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
>> This allows us to change how the number of buffers is computed in the
>> future.
>>
>> Fixes: c838530d230b ("media: media videobuf2: Be more flexible on the number of queue stored buffers")
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   drivers/media/common/videobuf2/videobuf2-core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
>> index 41a832dd1426..b6bf8f232f48 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>> @@ -989,7 +989,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>>   	bool no_previous_buffers = !q_num_bufs;
>>   	int ret = 0;
>>   
>> -	if (q->num_buffers == q->max_num_buffers) {
>> +	if (q_num_bufs == q->max_num_buffers) {
>>   		dprintk(q, 1, "maximum number of buffers already allocated\n");
>>   		return -ENOBUFS;
>>   	}
> There is another case in vb2_ioctl_create_bufs() where num_buffers is accessed directly.
> Can you fix that one as well?

It is removed by the patch I have send just after this one:
"media: core: Refactor vb2_ioctl_create_bufs() to always set capabilities flags"

Regards,
Benjamin

>
> Regards,
>
> 	Hans
>

