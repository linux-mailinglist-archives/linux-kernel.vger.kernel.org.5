Return-Path: <linux-kernel+bounces-72057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AAC85AE67
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B44E8B22D23
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AC45674E;
	Mon, 19 Feb 2024 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J4M/tSJy"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FEF55792
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708381704; cv=none; b=bDMZZQi6KDf2RIi9abFclwSWFEUHE2VGjLFKIHUcqiACspiynUrsjUoaIKqRW1WL6VMpsiSkhzYqosnSu5zhE+KVTP25g03v4rAVXVZ4kM4zg4F/uJ4XWKOnCPpajMCAMt7bC/MODuhRaRygWIPyDjJHkkKTDuG+P6kWY8JzL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708381704; c=relaxed/simple;
	bh=xfm6jm1SjOIoP0NYwIGg4sHKFEn2nlbRNl5VwkfOadc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Is91+uW2RRTOXza6zWOvfKozFs6yOB8e4NlIkZT1wfEg0mZU9xNE68NLYAcaEZ2OvSG3UwaZZCzmpNUW9rT0THbIwjLegh9oH1s7r+a1x13MRAvVkDPLq9/ZWZ2cVlxJtmjiZ8SgG27NzrWjQVhZ14PVc1Z791aZ0I86R2ULI3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J4M/tSJy; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c45829f3b6so31520739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708381700; x=1708986500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GvtVpu24juxIMlhGInfZIlPjBB2bdtPvceMgWyk+MJM=;
        b=J4M/tSJyqVxqSCFgaQf0FhNAYY3Mi4dCnxGFJtpR+5XYteFAquV7wU30j8OWDhvkhR
         rdYYHQgHXdrByypWdie+qLt+/27/OK2OnElK24fJQD3BAPuc5wjv7hQorJyD6NYoSSVt
         nl0RrThxd9PsNW+6GVXxQyfmRwgUMGZUek2Ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708381700; x=1708986500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvtVpu24juxIMlhGInfZIlPjBB2bdtPvceMgWyk+MJM=;
        b=VUK0/6x4h+gUyTvTiyiJ8i86yfgo762pc2NNfwEZ02oCVx0aKuQpb47MWJWvotC98P
         Y7um+I31r5ximy6GM9VxkIFlXamV2SCtRxwGmjY6dgiZtHH3toHe0Wf/hpKTjnH7/RAc
         kZDBEdWWixm7kn6twEu2siivvGU7F9wflQcEphvw5Owg8qDSl/qJlPmDqDFktg76KgNw
         WgrnemR2ARsfcE/kZyd1+xB7ryqK5jw8FGTrVPSreeNuW8T6g2bBZxhipT2yPWigLDio
         6wW4gnCawPBLEE3spQU66uUJmklNA5hGOr604RXLG9yyk928hir4cnKIhpQetvdQBYmN
         HJjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDLvcyFW6sT7a8howkD2YUP0ZE5/C5qds+3Ke5OB4+dGlTv6CrNKEh3vAPjjnVGGpuKS0P1/u1QMxlJ3ZZgn+JO3hzj5XzckG4/Hx3
X-Gm-Message-State: AOJu0YzJon51wXDir8VqXwzcLRn31HsrJZtthCPc2dz0/ygpHTI5AhlR
	R8u1GQICcIEQP0OZFssek8b0k6Ct3Hbsqri6qZlwRehfFCjBZAsqAtC1h5Su5Vs=
X-Google-Smtp-Source: AGHT+IF5ZE10mQTgDsLvD1ifbam2YQnVa3oxztXPgmU9bHt+UyMsXLRSNn539UO88nD6SmPSG1oO8Q==
X-Received: by 2002:a5d:8948:0:b0:7c7:28dc:da21 with SMTP id b8-20020a5d8948000000b007c728dcda21mr8565424iot.1.1708381700434;
        Mon, 19 Feb 2024 14:28:20 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id a18-20020a056638165200b0047127daf4ddsm1787440jat.140.2024.02.19.14.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 14:28:20 -0800 (PST)
Message-ID: <e2b42c87-f87e-4d09-b17f-82ed4002e989@linuxfoundation.org>
Date: Mon, 19 Feb 2024 15:28:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Spelling correction patch
Content-Language: en-US
To: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240217074353.19445-1-pvkumar5749404@gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240217074353.19445-1-pvkumar5749404@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/24 00:43, Prabhav Kumar Vaish wrote:

Missing change log?

Are you sure you included everybody get_maintainer.pl asked
you to

Patch summary line should include the subsystem. Refer to a few
change logs and patches.


> Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc | 2 +-
>   Documentation/ABI/testing/sysfs-bus-cxl                   | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> index 96aafa66b4a5..339cec3b2f1a 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> @@ -97,7 +97,7 @@ Date:		August 2023
>   KernelVersion:	6.7
>   Contact:	Anshuman Khandual <anshuman.khandual@arm.com>
>   Description:	(Read) Shows all supported Coresight TMC-ETR buffer modes available
> -		for the users to configure explicitly. This file is avaialble only
> +		for the users to configure explicitly. This file is available only
>   		for TMC ETR devices.
>   
>   What:		/sys/bus/coresight/devices/<memory_map>.tmc/buf_mode_preferred
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index fff2581b8033..bbf6de5a4ca1 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -224,7 +224,7 @@ Description:
>   		decoding a Host Physical Address range. Note that this number
>   		may be elevated without any regionX objects active or even
>   		enumerated, as this may be due to decoders established by
> -		platform firwmare or a previous kernel (kexec).
> +		platform firmware or a previous kernel (kexec).
>   
>   
>   What:		/sys/bus/cxl/devices/decoderX.Y


Otherwise it looks good. Send v2 with a proper change log
and short summary

thanks,
-- Shuah

