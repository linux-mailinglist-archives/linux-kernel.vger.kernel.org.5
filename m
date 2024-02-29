Return-Path: <linux-kernel+bounces-86753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F0886CA4C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACE62849D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD3886245;
	Thu, 29 Feb 2024 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1HddHK0X"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230507CF20;
	Thu, 29 Feb 2024 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709213501; cv=none; b=BUXIU6xggg/xRDcUhgI8Z6bunHXpLSw2QpNqL0tQUhIK3uSxiDgxWWNdIojm9+UbIf+lx781MskOCy3nujLC2ApEgprqq8vzxZlJsj12rr381t1EkzUnOdOh4d2Qr3MQFRDdJNnIkAHuoJdbR854VstXa6xjbH8VdruG6N+BMmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709213501; c=relaxed/simple;
	bh=EVh9P/025mxxlhH1inLYgV/8t7xpr12BfBpPeBri0cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cvg2mXdbl8l4PMC5FqqDuMoGNd1R5AaQnIxcIrJWIhsj/Isu+PgV7g2ugEOAy5XyVqYh0XZaYLAqbOaN5Z5mW8B4DQW69Kktdn5M1V55vISGX3dpqcwua7Ki7ER0GMuN1kED3o5WS/sshxPi937FXRDCxJHCFa+tckf4zEd1eTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1HddHK0X; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709213498;
	bh=EVh9P/025mxxlhH1inLYgV/8t7xpr12BfBpPeBri0cM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1HddHK0XXe9nw946teYKsaGmMDMFLiJRF++YvM5xFjRkjOy4KKm+Ce0ZR7qhn9+q7
	 EipiXjduq1eblvmGwzTZDpOq3odGAS4H7Rt+eBotzEoUr9QOxUeaFaa/E+rK0JR+z6
	 INy90RYwgn3NGRiOvwVN3c+DsFFZGGQWicAYIsFBf7u2gw5VB+eWadw3EV+6aGQBDV
	 445M7V0YkOtv3kk9kgWoqA+pQkfJ37gtGQltLX88kHnPmmgDOVYjKl8MGQcJx4btkB
	 IV0vg9ndpR4DpR/B1D007ZyQEcaHFYAMp4t9a5bJxLBMXln4CvRNSUwiXugAFHI3XQ
	 Yoxz7IW3vHEwQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3976137820E1;
	Thu, 29 Feb 2024 13:31:38 +0000 (UTC)
Date: Thu, 29 Feb 2024 14:31:37 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	benjamin.gaignard@collabora.com, laurent.pinchart@ideasonboard.com,
	praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com,
	j-luthra@ti.com, b-brnich@ti.com, detheridge@ti.com,
	p-mantena@ti.com, vijayp@ti.com, andrzej.p@collabora.com,
	nicolas@ndufresne.ca, afd@ti.com, milkfafa@gmail.com
Subject: Re: [PATCH v6 1/3] media: dt-bindings: Add Imagination E5010 JPEG
 Encoder
Message-ID: <20240229133137.3rt3skfzny2y65xo@basti-XPS-13-9310>
References: <20240228141140.3530612-1-devarsht@ti.com>
 <20240228141140.3530612-2-devarsht@ti.com>
 <20240229102623.ihwhbba4qwzvxzzq@basti-XPS-13-9310>
 <0a7a8e83-8724-4bec-8b3d-a58cc0a70395@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <0a7a8e83-8724-4bec-8b3d-a58cc0a70395@linaro.org>

On 29.02.2024 13:16, Krzysztof Kozlowski wrote:
>On 29/02/2024 11:26, Sebastian Fricke wrote:
>> Hey Devarsh,
>>
>> On 28.02.2024 19:41, Devarsh Thakkar wrote:
>>> Add dt-bindings for Imagination E5010 JPEG Encoder [1] which is implemented
>>> as stateful V4L2 M2M driver.
>>>
>>> The device supports baseline encoding with two different quantization
>>> tables and compression ratio as demanded.
>>>
>>> Minimum resolution supported is 64x64 and Maximum resolution supported is
>>> 8192x8192.
>>>
>>> [1]:  AM62A TRM (Section 7.6 is for JPEG Encoder)
>>> Link: https://www.ti.com/lit/pdf/spruj16
>>>
>>> Co-developed-by: David Huang <d-huang@ti.com>
>>> Signed-off-by: David Huang <d-huang@ti.com>
>>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>
>> hmmm when did Rob give his reviewed by on this patch? (As this is not a
>> DT binding I find that odd)
>
>This is a DT binding, which is clearly expressed in subject prefix
>(proper one) and the patch contents.

Yup sorry for the noise, I confused the two patches.

>
>Best regards,
>Krzysztof

Greetings,
Sebastian

