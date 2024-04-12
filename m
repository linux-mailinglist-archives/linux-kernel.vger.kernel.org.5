Return-Path: <linux-kernel+bounces-142813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB7A8A3066
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF05286972
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8523C86264;
	Fri, 12 Apr 2024 14:21:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1779C55E4A;
	Fri, 12 Apr 2024 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931703; cv=none; b=IfoXcL8CAw2RLpBpqjqCTsWPQbyE0SR0RGpWH8zAeIBjt4puXaLi/gB4J5ho/iNd3SaZ9q/lKmmL32aQKlRorYjOobOgYSLpKscPB0t+Nam62JgNf/dnk1ptOdtQJ1NkA8mYsHhCcRdtPjLxiQUbnZcOTzIeSFzZb1ox2Xs59ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931703; c=relaxed/simple;
	bh=eMcIJ2tYDEaveTSh0VFnC7/4Ol3w4LLuM1Dwojb9NWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhDulPo8k2gkehVre4ZrJk7coWs5Zu+YuR8niXlJRpQLYoa67Zg4be52+YUvcQBRoqdXlidQPEC5vytz4yTVB6cu5jBcqF/ckfsqkghKo1QsN3I1eksANkkvhQPmO/HHBnLKwz2x9sKF2c/519vBCtHYV2khSzOZvFGBDzSviQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98461C113CC;
	Fri, 12 Apr 2024 14:21:41 +0000 (UTC)
Message-ID: <f7ca4107-0341-4631-8d8d-b9677782ac2f@xs4all.nl>
Date: Fri, 12 Apr 2024 16:21:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] media: dvb: Fix dtvs_stats packing.
Content-Language: en-US, nl
To: Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240410-pack-v1-0-70f287dd8a66@chromium.org>
 <20240410-pack-v1-2-70f287dd8a66@chromium.org>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240410-pack-v1-2-70f287dd8a66@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/04/2024 14:24, Ricardo Ribalda wrote:
> The structure is packed, which requires that all its fields need to be
> also packed.
> 
> ./include/uapi/linux/dvb/frontend.h:854:2: warning: field  within 'struct dtv_stats' is less aligned than 'union dtv_stats::(anonymous at ./include/uapi/linux/dvb/frontend.h:854:2)' and is usually due to 'struct dtv_stats' being packed, which can lead to unaligned accesses [-Wunaligned-access]
> 
> Explicitly set the inner union as packed.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  include/uapi/linux/dvb/frontend.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/dvb/frontend.h b/include/uapi/linux/dvb/frontend.h
> index 7e0983b987c2d..8d38c6befda8d 100644
> --- a/include/uapi/linux/dvb/frontend.h
> +++ b/include/uapi/linux/dvb/frontend.h
> @@ -854,7 +854,7 @@ struct dtv_stats {
>  	union {
>  		__u64 uvalue;	/* for counters and relative scales */
>  		__s64 svalue;	/* for 0.001 dB measures */
> -	};
> +	}  __attribute__ ((packed));
>  } __attribute__ ((packed));

This is used in the public API, and I think this change can cause ABI changes.

Can you compare the layouts? Also between gcc and llvm since gcc never warned
about this.

I'm not going to accept this unless it is clear that there are no ABI changes.

Note that the ABI test in the build scripts only tests V4L2 at the moment,
not the DVB API.

Regards,

	Hans


