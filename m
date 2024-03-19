Return-Path: <linux-kernel+bounces-107061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F9987F717
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F4E1F22DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DF74594E;
	Tue, 19 Mar 2024 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qeX8sfCe"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80D34595A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710828316; cv=none; b=CjD6VDcNmLCJ74CN/eZDuAoXrB+IEVNGgS74vJ6+bMRphI/W8cveBcFbySqDwRx8haLU20qdgcxW1V4orrIZWsd2QM+hKAHeq83PgD03dEZt6qmxns7o2yQwJaZGxGpdKbXlOjQUwNqHXp/qWc8y7AvFrJAuQsiLi0rVXpY3EkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710828316; c=relaxed/simple;
	bh=oNoGwPyzMcPI14i+W+frwGr1pCQ9rhAS4wUQuOg5yag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3/0MzZqbTtTesymnhKQQGdxSlFfItIw2Qk7f5FGXcaFZPgAnhG0kSzsG1l+KipNPz8v3bK4tFtwNSIjH2wULy95B1P9bCSnjZA5Qh2u54XpNx0/KfLTMSlhOtVWw5rEGOFgZjVm0sr98W/L7aUFmqHhtPR7ugMQJDpJPMGyNT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qeX8sfCe; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d49f7e5d65so26096001fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710828313; x=1711433113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JUwlqGmu3zo/ZxFiud12XQN4abG9MgdC/LpP0njGEvo=;
        b=qeX8sfCevhWwFRAZtvILu2S2FqNo5MomjSB7MImPVbrob7lohNQcC7k3FQjg29w2dM
         LIrawwVaGewslZCOAGlwo842Ws2VRi31HSlgoWrLlgrrec2pxAI46xzLLgBY6bvolUyJ
         RjibWjrK0JHqmZEusqZy5pYHUXdU8eSiPIjP8WQbZ4poYJmnbHhhZ4PIQkeEX1PD1/g1
         /dOqyNi4GqCpW+jJWP4uZ4s+fZz49A5tiLIGMxpD4mpHSyi/XXE+bfTD6sTrN/piUbUH
         zjKD8ssFOmje1SJcnkEM5XUjQvzM5hhLfoZlov7OfPSa35fQ8UmfqrImZMMy7yrLX9kj
         DsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710828313; x=1711433113;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUwlqGmu3zo/ZxFiud12XQN4abG9MgdC/LpP0njGEvo=;
        b=cRi0XtY57jCbW/6vMXPkf3PrmWaGSOJzyjSvWrTeXUJOEv2Qd3hdouOgYLGihPdPtz
         2zOuVXTyVasGenfQAkF1YaaRI+qeqRQozVEsCBFmuOw8sDIsNfOhvIzot/pBK0gnZ7S0
         5V0sh/dvXpwxYljmVCAa/NQSousFstBkxnfgs6x5tVK/X7RpVosCy1z5ZvNTgGUkiJls
         lG0MkUJcTj06dnhbHpoWb24XBCyfjk7c3/hj9NqjlQ5MLcQsMUx+66e6PG7nGLlBTTge
         ko4cOFDNVWDo7WljEg7F/VxW9yqLs56F7CSPde/cfY7lhd6RVmj07++TJypH/FT3PpDD
         CJgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzhUcEl7+6wIC7xYVtem4cpcK2LuRbgOw890qv0m+r7wxa++fnUAWBhlcTIaFCw9Dfca/2V2/eZ/49guejW1bFbUHsHUa3zjoYKoo9
X-Gm-Message-State: AOJu0YzDpfLsM95o7G9C5/wv9Kh0+NOW3FMxZwi4J1uwyn6i/tNac+3q
	kicuEjpJBURl8kEK9/9R+8pFER6ATZvoxh4wNt1ZSxa0D4G2os00fFkXNYwqxF8=
X-Google-Smtp-Source: AGHT+IGip/lqxVHcaqh60m0oeHsfa6TK2HtM+Jhz+KWIDIv0hSMHRjmfTJBFsC2RyHcCHnhHQdqPLQ==
X-Received: by 2002:a2e:3a18:0:b0:2d4:ad34:85a5 with SMTP id h24-20020a2e3a18000000b002d4ad3485a5mr884906lja.37.1710828312937;
        Mon, 18 Mar 2024 23:05:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id a89-20020a509ee2000000b00568c299eaedsm3347638edf.81.2024.03.18.23.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 23:05:12 -0700 (PDT)
Message-ID: <28754b32-35c7-4285-a610-3e101da41047@linaro.org>
Date: Tue, 19 Mar 2024 07:05:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] media: raspberrypi: Support RPi5's CFE
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Naushir Patuck
 <naush@raspberrypi.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>
References: <20240318-rp1-cfe-v1-0-ac6d960ff22d@ideasonboard.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240318-rp1-cfe-v1-0-ac6d960ff22d@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/03/2024 16:49, Tomi Valkeinen wrote:
> This series adds support to the CFE hardware block on RaspberryPi 5. The
> CFE (Camera Front End) contains a CSI-2 receiver and Front End, a small
> ISP.
> 
> This series is currently based on multiple other serieses:
> 
> - Sakari's "[PATCH v8 00/38] Generic line based metadata support, internal
>   pads" for metadata support
> - Laurent's "[PATCH 00/15] media: Add driver for the Raspberry Pi <5
>   CSI-2 receiver" for a few new pixel formats and imx219 (for testing).
> - Jacopo's "[PATCH v5 0/9] media: raspberrypi: Add support for PiSP Back
>   End" for some shared uapi headers.
> 
> And to run this, one of course needs the basic RPi5 kernel support plus
> relevant dts changes to enable the cfe and camera.

Which makes it impossible to merge. Please work on decoupling.

Best regards,
Krzysztof


