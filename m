Return-Path: <linux-kernel+bounces-167804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D081A8BAF61
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B4A2846F0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FC74CB35;
	Fri,  3 May 2024 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="42RFbvBF"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1991148788;
	Fri,  3 May 2024 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748846; cv=none; b=IiVGU7q/Is1aw5Q/J5Ohhup6jnYtTDwiI+xR0YjdCb27VsDiFv5zIOebaKJ4lQ3hkRB1KmCbPn2oTJAujYCWgK7OhH5qAD1z3S81bQuAY0Zfs/rbWi6D18VHcnOUHZbpZU2D3cRLeaze0o5NXC8Mozh7XxMf8KkpPn+BNrN90BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748846; c=relaxed/simple;
	bh=n90ymFXYX/mPfwdlXeVC+RLGTkwM83bllw5REKRbAYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8cb/1r6GDExCqFU6Q0YZdXmN15Mw3iV7+6JTu881Z22NL5TfWTK56CP1P0cq096jKXHSTVCd1KSP+z8FIicNSI8sk3UKmBm04oWwG13jsQcfZBUTAZLynhRh1q2MHHOdEeFJnYcP/jBAXu32s96x58Ne8euNcm0K0nnz+NbXFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=42RFbvBF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714748843;
	bh=n90ymFXYX/mPfwdlXeVC+RLGTkwM83bllw5REKRbAYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=42RFbvBFAwhCfVH7YzE1nz8tBDn7sHpGBECnfzeQ00h//pNKDSpkjCY8OX4wPsGsp
	 bsmONm+55u5/VTgK4SVIThbiTUoRamfbLcEj3Deflm4X3LsQSfRMzaIbWvIMPSCWDi
	 sflhY36Dgj5pgL+Zfx8CGu0yvHOIJpQiX3I1EDkJx39kYZKVdibuQgngZjV+Nus0YT
	 vw83sJX3dEz6VLxnD90KDPCm/98TAaxujsxMNISIYSeo6ElykIeEnmqcuI6/CPrOwe
	 ZUkJzN2TN+0cV9gWZC9sa5ciY6XXpFoBmqB/1t536HRx6GIElGnlmNMe6aITYAFfhw
	 nKTIeP0Xghnpg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E79473782160;
	Fri,  3 May 2024 15:07:22 +0000 (UTC)
Date: Fri, 3 May 2024 17:07:21 +0200
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Ivan Bornyakov <brnkv.i1@gmail.com>
Cc: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Wave515 decoder IP support
Message-ID: <20240503150721.qd6d7csev5452rss@basti-XPS-13-9310>
References: <20240415100726.19911-1-brnkv.i1@gmail.com>
 <mwgydgjstvedkatdvopt3wh4imhnzflr7ut3vejgl6fz3vbgzg@x4spldwklrm3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <mwgydgjstvedkatdvopt3wh4imhnzflr7ut3vejgl6fz3vbgzg@x4spldwklrm3>

Hey Ivan,

On 02.05.2024 09:40, Ivan Bornyakov wrote:
>On Mon, Apr 15, 2024 at 01:07:18PM GMT, Ivan Bornyakov wrote:
>> Initial support for Wave515 multi-decoder IP among other refinements.
>> This was tested on FPGA prototype, so wave5_dt_ids[] was not expanded.
>>
>> fluster score for JCT-VC-HEVC_V1 testsuite with
>> GStreamer-H.265-V4L2-Gst1.0 decoder is 132/147
>>
>> The issue with Main10 tests is that fluster expects decoded file to be
>> in yuv420p10le format while this driver decodes HEVC Main10 into 8-bit
>> yuv420p. Though result is looks alright to the naked eye, proper
>> decoding into yuv420p10le is to be added.
>>
>> The rest failed fluster tests are common with Wave521.
>>
>> ChangeLog:
>>   v1:
>> https://lore.kernel.org/linux-media/20240318144225.30835-1-brnkv.i1@gmail.com/
>>   v2:
>> https://lore.kernel.org/linux-media/20240325064102.9278-1-brnkv.i1@gmail.com/
>>     * drop patch "dt-bindings: media: cnm,wave521c: drop resets restriction"
>>       The only user of Wave5 in mainline is TI K3 boards, thus there is
>>       no real need to alter dt-bindings
>>     * in patch "media: chips-media: wave5: support decoding HEVC Main10 profile"
>>       add check for flag "support_hevc10bit_dec"
>>     * in patch "media: chips-media: wave5: support reset lines" move
>>       reset_control_deassert() out of else branch, add
>>       reset_control_assert() to probe error path.
>>     * rework patch "media: chips-media: wave5: drop "sram-size" DT prop"
>>        - don't move alloc/free form device open/close
>>        - intead of exact configuration of reserved SRAM memory in DT and
>> 	 allocating all of it, allocate all available SRAM memory up to
>> 	 WAVE5_MAX_SRAM_SIZE from whatever pool provided.
>>     * adjust patch "media: chips-media: wave5: support Wave515 decoder"
>>       according to changes in patches
>>       "media: chips-media: wave5: support decoding HEVC Main10 profile" and
>>       "media: chips-media: wave5: drop "sram-size" DT prop"
>>   v3:
>> https://lore.kernel.org/linux-media/20240405164112.24571-1-brnkv.i1@gmail.com/
>>     * reword patch "media: chips-media: wave5: separate irq setup routine"
>>       a bit.
>>     * in patch "media: chips-media: wave5: drop "sram-size" DT prop"
>>        - move MAX_SRAM_SIZE define into match_data->sram_size
>>        - add placeholders for validation that allocated SRAM memory is
>> 	 enough to encode/decode bitstream of given resolution before
>> 	 setting W5_USE_SEC_AXI and W5_CMD_ENC_PIC_USE_SEC_AXI registers
>>        - reword accordingly
>>     * in patch "media: chips-media: wave5: support Wave515 decoder"
>>        - add comments around SRAM memory allocation/freeing about
>> 	 Wave515 specifics
>>        - add comments about BSOPTION_RD_PTR_VALID_FLAG bit in
>> 	 W5_BS_OPTION register
>>        - add W[AVE]521_ prefix to defines, for wich there are W[AVE]515_
>> 	 alternatieves
>>        - add semi-magic Wave515 specific formulas to estimate SRAM usage
>>   v4:
>>     * rebase onto next-20240415, no functional changes
>>
>> Ivan Bornyakov (5):
>>   media: chips-media: wave5: support decoding HEVC Main10 profile
>>   media: chips-media: wave5: support reset lines
>>   media: chips-media: wave5: separate irq setup routine
>>   media: chips-media: wave5: drop "sram-size" DT prop
>>   media: chips-media: wave5: support Wave515 decoder
>>
>>  .../platform/chips-media/wave5/wave5-helper.c |   8 +-
>>  .../platform/chips-media/wave5/wave5-hw.c     | 395 +++++++++++++-----
>>  .../chips-media/wave5/wave5-regdefine.h       |   5 +
>>  .../platform/chips-media/wave5/wave5-vdi.c    |  27 +-
>>  .../chips-media/wave5/wave5-vpu-dec.c         |  51 ++-
>>  .../chips-media/wave5/wave5-vpu-enc.c         |   2 +-
>>  .../platform/chips-media/wave5/wave5-vpu.c    |  35 +-
>>  .../platform/chips-media/wave5/wave5-vpuapi.h |   3 +
>>  .../chips-media/wave5/wave5-vpuconfig.h       |  16 +-
>>  .../media/platform/chips-media/wave5/wave5.h  |   6 +
>>  10 files changed, 407 insertions(+), 141 deletions(-)
>>
>> --
>> 2.44.0
>>
>
>Friendly ping.

Sorry again for the delay, I was nearly finished with the patch set last
week but the time wasn't sufficient. And I sadly have to delay it again
a bit as I am on vacation until 13.05. I expect finishing it probably
until 17.05.

Regards,
Sebastian

