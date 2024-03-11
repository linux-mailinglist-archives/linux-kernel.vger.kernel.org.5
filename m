Return-Path: <linux-kernel+bounces-98619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BD2877CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816B31C20FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BAB17BA1;
	Mon, 11 Mar 2024 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RjgNcBN4"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DDE17996
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149398; cv=none; b=hUEvN7VuGoTKsfYav0rph/zRTNXzu4giZO1F/moOkMvnfBGjtrzpvMMbipJENbuJ9czwSxgS08YI66e247BP7RkUo2PDQBN9HyvcQ1Xk6rjEXHJ3qXCpFQ7VQB4tRGdqAzLmiA6j/1iEla+Hr82TQRsy8KkxFR5C6ipMxWS3IoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149398; c=relaxed/simple;
	bh=i9RYgl3dciT8uNyydDWLqhOtA/+iznvnbV3o1iIP4VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHLFSN5biWkxbnUx+L5GHhudO2uf2MclvE3TMOJGzAnyJQYkrReWrqmtg6c/9onocCrI2UmL4qz0QjbHkB0CC/J3uvTB4zEfuYSQYlvHEbEXKXWlRBWbGV4buq5DR6G3w7hNb5Rme/+YGoAwnhIibhFIm7j7sI3bqAqHFx+q2B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RjgNcBN4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710149394;
	bh=i9RYgl3dciT8uNyydDWLqhOtA/+iznvnbV3o1iIP4VM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RjgNcBN4JGTFQz6V5ia0dLRVYt8OyPfrVGXd2DOv/ZD5+r4gQnsrHV28H6Z6EEdd2
	 7mdJ/9kWPi54ryf5Z+WTc2meEWl9lncGBOFZ7hcHAewhxZs6mZhAbQIRGU6oK3NLcp
	 f2ideDNaxmY4K/yUo0rULM4W2+BDXZxJSSWW41W78xJiFNli0ugWI1ll6yRuqGQhEo
	 OdXQxh06cDgBnik8sITyQNVpNRB/0h38/iUkzHK5cWBzliABmvmcdhy1BYjfIL8QGq
	 jbf1Lb+Td2MBUqMeZgZtwJz/oPE8Fg0g/P6Gz/KVC/0hhvdrRr9wWVvQhZ6fkvZ8a9
	 pdNUQys79xN3A==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B04C03780C13;
	Mon, 11 Mar 2024 09:29:54 +0000 (UTC)
Date: Mon, 11 Mar 2024 10:29:53 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>
Cc: mchehab@kernel.org, nicolas@ndufresne.ca, linux-kernel@vger.kernel.org,
	hverkuil@xs4all.nl, nas.chung@chipsnmedia.com,
	lafley.kim@chipsnmedia.com
Subject: Re: [PATCH v2 0/4] wave5 codec driver
Message-ID: <20240311092953.bhddzoigalhoyydi@basti-XPS-13-9310>
References: <20240311042442.10755-1-jackson.lee@chipsnmedia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20240311042442.10755-1-jackson.lee@chipsnmedia.com>

Hey Jackson,

just as a quick info, I feel like the title of the cover letter is a bit
confusing, as it sounds like it contains the source code for the wave5
codec driver, which we already have. Usually the title of the cover
letter should indicate to the reader what to expect in the patch-set
(which can also be a really nice indication for when you try to do too
much in a single patch-set, because then it will be hard to make a
concise title).

Greetings,
Sebastian

On 11.03.2024 13:24, jackson.lee wrote:
>From: "Jackson.lee" <jackson.lee@chipsnmedia.com>
>
>The wave5 codec driver is a stateful encoder/decoder.
>The following patches is for supporting yuv422 inpuy format, supporting
>runtime suspend/resume feature and extra things.
>
>v4l2-compliance results:
>========================
>
>v4l2-compliance 1.24.1, 64 bits, 64-bit time_t
>
>Buffer ioctls:
>	    warn: v4l2-test-buffers.cpp(693): VIDIOC_CREATE_BUFS not supported
>	    warn: v4l2-test-buffers.cpp(693): VIDIOC_CREATE_BUFS not supported
>    test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>    test VIDIOC_EXPBUF: OK
>    test Requests: OK (Not Supported)
>
>Total for wave5-dec device /dev/video0: 45, Succeeded: 45, Failed: 0, Warnings: 2
>Total for wave5-enc device /dev/video1: 45, Succeeded: 45, Failed: 0, Warnings: 0
>
>Fluster test results:
>=====================
>
>Running test suite JCT-VC-HEVC_V1 with decoder GStreamer-H.265-V4L2-Gst1.0 Using 1 parallel job(s)
>Ran 132/147 tests successfully               in 94.782 secs
>
>(1 test fails because of not supporting to parse multi frames, 1 test fails because of a missing frame and slight corruption, 2 tests fail because of sizes which are incompatible with the IP, 11 tests fail because of unsupported 10 bit format)
>
>Running test suite JVT-AVC_V1 with decoder GStreamer-H.264-V4L2-Gst1.0 Using 1 parallel job(s)
>Ran 77/135 tests successfully               in 37.364 secs
>
>(58 fail because the hardware is unable to decode  MBAFF / FMO / Field / Extended profile streams.)
>
>
>Chnage since v1:
>=================
>
>* For [PATCH v2 0/4] media: chips-media: wave5: Support SPS/PPS generation for each IDR
> - define a macro for register addresses
>
>* For [PATCH v2 1/4] media: chips-media: wave5: Support runtime suspend/resume
> - add auto suspend/resume
>
>* For [PATCH v2 2/4] media: chips-media: wave5: Use helpers to calculate bytesperline and sizeimage
> - use helper functions to calculate bytesperline and sizeimage
>
>* For [PATCH v2 3/4] media: chips-media: wave5: Support YUV422 raw pixel-formats on the encoder
> - remove unnecessary codes
>
>Change since v0:
>=================
>The DEFAULT_SRC_SIZE macro was defined using multiple lines,
>To make a simple define, tab and multiple lines has been removed,
>The macro is defined using one line.
>
>
>Jackson.lee (4):
>  media: chips-media: wave5: Support SPS/PPS generation for each IDR
>  media: chips-media: wave5: Support runtime suspend/resume
>  media: chips-media: wave5: Use helpers to calculate bytesperline and
>    sizeimage.
>  media: chips-media: wave5: Support YUV422 raw pixel-formats on the
>    encoder.
>
> .../platform/chips-media/wave5/wave5-helper.c |  24 ++
> .../platform/chips-media/wave5/wave5-helper.h |   4 +
> .../platform/chips-media/wave5/wave5-hw.c     |  23 +-
> .../chips-media/wave5/wave5-vpu-dec.c         | 261 +++++-------------
> .../chips-media/wave5/wave5-vpu-enc.c         | 260 +++++++++--------
> .../platform/chips-media/wave5/wave5-vpu.c    |  43 +++
> .../platform/chips-media/wave5/wave5-vpu.h    |   4 -
> .../platform/chips-media/wave5/wave5-vpuapi.c |  14 +-
> .../platform/chips-media/wave5/wave5-vpuapi.h |   1 +
> .../chips-media/wave5/wave5-vpuconfig.h       |  25 +-
> .../media/platform/chips-media/wave5/wave5.h  |   3 +
> 11 files changed, 329 insertions(+), 333 deletions(-)
>
>-- 
>2.43.0
>

