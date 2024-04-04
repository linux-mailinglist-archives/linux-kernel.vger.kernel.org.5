Return-Path: <linux-kernel+bounces-131050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E7589826B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5071F1F25C7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCE25CDC9;
	Thu,  4 Apr 2024 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OxCZa6iR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4441535AC;
	Thu,  4 Apr 2024 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712216805; cv=none; b=Zbio6KOb5loDcwntyO+ck2m+ldcFI1kgKJmwHn7IlxUGeSYj7lh/mRfMSwOBxI8T15OiICe8Ca5CzXGgk8xgCv+4+390cf/yULa85ntMyPGc3ej/KuudvWVqWkqFnqxaSqML38NF09c8hv2jdyy8JPX8o1XXm2ztXFWoKZn+ydo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712216805; c=relaxed/simple;
	bh=8fjyQ4a6KkFNlvYWPQl0dz8P/T4HTCFfrRFJF+4Z1jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgJaJ+fZ5g4mZmA505xRh592wlNEIHdLflQo8eX/TLTnVx6WICIYrIq5Oj6yeUmZW6PAYDtz3ryrEl7McK3uReoqJauj+EOj3wHxt0yiRIpFjFYNjg8PP8SjMwLRjPyEyrQCAUmrMAOKc7VPj3AFmDGBjlkoS1CWuoVi0ftsyK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OxCZa6iR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712216796;
	bh=8fjyQ4a6KkFNlvYWPQl0dz8P/T4HTCFfrRFJF+4Z1jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxCZa6iRIEhboawFHu2UBNEkC6XN76y1a/xlEbuxzNb55C8vdi/P5bgXAFo06hxzp
	 bEDaqOwfK1bipWyKSBXephZQvbB4fkiD3rnv39GLuWJ2WhoYk89vl62A7v3N5/mgu1
	 aIy3hsNcwnyAbG7A4Vybr/v9OjFYYKW8jlH3WGnk4UIF+6S1aPKx3NS6mOKFARPCSf
	 jTuJXshEixcV1jIYtlSAVzAycwm0Av98XqraSH7Kb6ThvEi71PEl6jhBMphG3BvbiZ
	 6xFzGuF4SgbmyjRwhue0s53E9QC1Ml/lWj+WmukgF4blflPxpm9nqf/LDA+ew14g60
	 9hC/06o9EiPjQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E384F378209A;
	Thu,  4 Apr 2024 07:46:35 +0000 (UTC)
Date: Thu, 4 Apr 2024 09:46:34 +0200
From: "sebastian.fricke@collabora.com" <sebastian.fricke@collabora.com>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>
Cc: "mchehab@kernel.org" <mchehab@kernel.org>,
	"nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
	"hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Nas Chung <nas.chung@chipsnmedia.com>,
	"lafley.kim" <lafley.kim@chipsnmedia.com>,
	"b-brnich@ti.com" <b-brnich@ti.com>
Subject: Re: [RESEND PATCH v2 0/4] Add auto suspend/resume,YUV422
 format,SPS/PPS generation for each IDR
Message-ID: <20240404074634.fcxv62xi73ie2nhz@basti-XPS-13-9310>
References: <20240311105623.20406-1-jackson.lee@chipsnmedia.com>
 <SE1P216MB1303D2A884C6F904553E4432ED362@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <SE1P216MB1303D2A884C6F904553E4432ED362@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>

Hey Jackson,

On 25.03.2024 06:19, jackson.lee wrote:
>Hello Sebastian, Hans and Nicolas
>
>Could you please review the below patch series ?

Sorry for the delay, me and Nicolas are currently quite busy. So, the
review of the patchset will be delayed a bit longer, current goal would
be review this until the 20th of April. I'll try to keep you updated.

Greetings,
Sebastian

>
>
>https://patchwork.linuxtv.org/project/linux-media/list/?series=12404
>
>
>thanks
>Jackson
>
>> -----Original Message-----
>> From: jackson.lee <jackson.lee@chipsnmedia.com>
>> Sent: Monday, March 11, 2024 7:56 PM
>> To: mchehab@kernel.org; nicolas@ndufresne.ca;
>> sebastian.fricke@collabora.com
>> Cc: linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
>> hverkuil@xs4all.nl; Nas Chung <nas.chung@chipsnmedia.com>; lafley.kim
>> <lafley.kim@chipsnmedia.com>; b-brnich@ti.com; jackson.lee
>> <jackson.lee@chipsnmedia.com>
>> Subject: [RESEND PATCH v2 0/4] Add auto suspend/resume,YUV422
>> format,SPS/PPS generation for each IDR
>>
>> From: "Jackson.lee" <jackson.lee@chipsnmedia.com>
>>
>> The wave5 codec driver is a stateful encoder/decoder.
>> The following patches is for supporting yuv422 inpuy format, supporting
>> runtime suspend/resume feature and extra things.
>>
>> v4l2-compliance results:
>> ========================
>>
>> v4l2-compliance 1.24.1, 64 bits, 64-bit time_t
>>
>> Buffer ioctls:
>>             warn: v4l2-test-buffers.cpp(693): VIDIOC_CREATE_BUFS not
>> supported
>>             warn: v4l2-test-buffers.cpp(693): VIDIOC_CREATE_BUFS not
>> supported
>>     test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>>     test VIDIOC_EXPBUF: OK
>>     test Requests: OK (Not Supported)
>>
>> Total for wave5-dec device /dev/video0: 45, Succeeded: 45, Failed: 0,
>> Warnings: 2 Total for wave5-enc device /dev/video1: 45, Succeeded: 45,
>> Failed: 0, Warnings: 0
>>
>> Fluster test results:
>> =====================
>>
>> Running test suite JCT-VC-HEVC_V1 with decoder GStreamer-H.265-V4L2-Gst1.0
>> Using 1 parallel job(s)
>> Ran 132/147 tests successfully               in 94.782 secs
>>
>> (1 test fails because of not supporting to parse multi frames, 1 test
>> fails because of a missing frame and slight corruption, 2 tests fail
>> because of sizes which are incompatible with the IP, 11 tests fail because
>> of unsupported 10 bit format)
>>
>> Running test suite JVT-AVC_V1 with decoder GStreamer-H.264-V4L2-Gst1.0
>> Using 1 parallel job(s)
>> Ran 77/135 tests successfully               in 37.364 secs
>>
>> (58 fail because the hardware is unable to decode  MBAFF / FMO / Field /
>> Extended profile streams.)
>>
>>
>> Chnage since v1:
>> =================
>>
>> * For [PATCH v2 0/4] media: chips-media: wave5: Support SPS/PPS generation
>> for each IDR
>>  - define a macro for register addresses
>>
>> * For [PATCH v2 1/4] media: chips-media: wave5: Support runtime
>> suspend/resume
>>  - add auto suspend/resume
>>
>> * For [PATCH v2 2/4] media: chips-media: wave5: Use helpers to calculate
>> bytesperline and sizeimage
>>  - use helper functions to calculate bytesperline and sizeimage
>>
>> * For [PATCH v2 3/4] media: chips-media: wave5: Support YUV422 raw pixel-
>> formats on the encoder
>>  - remove unnecessary codes
>>
>> Change since v0:
>> =================
>> The DEFAULT_SRC_SIZE macro was defined using multiple lines, To make a
>> simple define, tab and multiple lines has been removed, The macro is
>> defined using one line.
>>
>> Jackson.lee (4):
>>   media: chips-media: wave5: Support SPS/PPS generation for each IDR
>>   media: chips-media: wave5: Support runtime suspend/resume
>>   media: chips-media: wave5: Use helpers to calculate bytesperline and
>>     sizeimage.
>>   media: chips-media: wave5: Support YUV422 raw pixel-formats on the
>>     encoder.
>>
>>  .../platform/chips-media/wave5/wave5-helper.c |  24 ++
>>  .../platform/chips-media/wave5/wave5-helper.h |   4 +
>>  .../platform/chips-media/wave5/wave5-hw.c     |  23 +-
>>  .../chips-media/wave5/wave5-vpu-dec.c         | 261 +++++-------------
>>  .../chips-media/wave5/wave5-vpu-enc.c         | 260 +++++++++--------
>>  .../platform/chips-media/wave5/wave5-vpu.c    |  43 +++
>>  .../platform/chips-media/wave5/wave5-vpu.h    |   4 -
>>  .../platform/chips-media/wave5/wave5-vpuapi.c |  14 +-
>>  .../platform/chips-media/wave5/wave5-vpuapi.h |   1 +
>>  .../chips-media/wave5/wave5-vpuconfig.h       |  25 +-
>>  .../media/platform/chips-media/wave5/wave5.h  |   3 +
>>  11 files changed, 329 insertions(+), 333 deletions(-)
>>
>> --
>> 2.43.0
>

