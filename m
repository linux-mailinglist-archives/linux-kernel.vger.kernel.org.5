Return-Path: <linux-kernel+bounces-20010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0D2827835
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1811C22F3F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF81354FA3;
	Mon,  8 Jan 2024 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="infJdD5p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A206954F85;
	Mon,  8 Jan 2024 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4T83ZB0qJ2z9wqT;
	Mon,  8 Jan 2024 19:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1704741074; bh=BcZ3KVI53mstXqau6zectZz4RnmhY47xgMYJZN+ZIaQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=infJdD5p34mA9gKPvJptIjOzdbIfe9Hujjif438x1zRpCeP2wBWmtoAcqAHAmtZRD
	 9w7Xqc0zwSdpzlxCEYwJiFccWwGGOCclyO+ECrxq5anWS21fevSpvMz4Z/uAOFq2ul
	 7NNQLRs3Jt4dioKbYJv71J5E6QFXSAsWijtNImf4=
X-Riseup-User-ID: 7573B3426939D883A3225FA69B0B75C911D2C11A815A2296FDD774F32314207C
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4T83Z46ZlrzFrsD;
	Mon,  8 Jan 2024 19:11:08 +0000 (UTC)
Message-ID: <2737e91a-27dd-4c43-a678-47e041c42559@riseup.net>
Date: Mon, 8 Jan 2024 16:11:05 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] drm/vkms: Create KUnit tests for YUV conversions
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Jonathan Corbet <corbet@lwn.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>,
 Melissa Wen <melissa.srw@gmail.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240105-vkms-yuv-v1-0-34c4cd3455e0@riseup.net>
 <20240105-vkms-yuv-v1-7-34c4cd3455e0@riseup.net>
 <5z66ivuhfrzrnuzt6lwjfm5fuozxlgqsco3qb5rfzyf6mil5ms@2svqtlcncyjj>
From: Arthur Grillo <arthurgrillo@riseup.net>
In-Reply-To: <5z66ivuhfrzrnuzt6lwjfm5fuozxlgqsco3qb5rfzyf6mil5ms@2svqtlcncyjj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/01/24 07:15, Maxime Ripard wrote:
> Hi Arthur,
> 
> On Fri, Jan 05, 2024 at 01:35:08PM -0300, Arthur Grillo wrote:
>> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
>> index b654b6661a20..11df990a0fa9 100644
>> --- a/drivers/gpu/drm/vkms/vkms_formats.c
>> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
>> @@ -440,3 +440,7 @@ void *get_pixel_write_function(u32 format)
>>  		return NULL;
>>  	}
>>  }
>> +
>> +#ifdef CONFIG_DRM_VKMS_KUNIT_TESTS
>> +#include "tests/vkms_format_test.c"
>> +#endif
> 
> I assume this is due to testing a static function?

Yeah, you're right.

> 
> If so, the preferred way nowadays is to use EXPORT_SYMBOL_IF_KUNIT or
> EXPORT_SYMBOL_FOR_TESTS_ONLY if it's DRM/KMS only.

Oh, I didn't know about that. I think I will use EXPORT_SYMBOL_IF_KUNIT
as you can use VISIBLE_IF_KUNIT to maintain the function static if the
test is not used.

~Arthur Grillo
> 
> Maxime

