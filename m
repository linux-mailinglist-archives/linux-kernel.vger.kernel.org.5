Return-Path: <linux-kernel+bounces-156490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01468B033A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B13C28112D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E146F157E7D;
	Wed, 24 Apr 2024 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KLrHFgia"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4023C43AB4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943928; cv=none; b=MeIyUMrCiS6ENl674jtiLsp31Ul2FxGmADQpB2IGfy80+iiVZHlkKb9raZ1fN9V7OwUpnqTdCPouDxkei5Ewf3jtYov4Lt6jGQJN1cyJ8rF7HlfX6t5iTv+fHF1UZujrvV2ZILQQlYYm4+VpS942v0UwK01ZZpDt1+LBuG2ogxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943928; c=relaxed/simple;
	bh=j3gUoUGa5ys9Ijh+sP8F7wcjNrsOzLt0nu0CtCgbBOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Few+uWCncLmId4RQGLa/8dnSHHpdiRga/G0fpDv9+1pXgjZfV/V5kF01ctfLMGzv0HY4BWeBQwU6neOdgw7DdSrYBWvPKDWdtx898reifUUDcPcvQDDqkH35xEkAEFZb2U7EVgbWAH5BYJ8fIhtgUlNm9r8itbg97Y0KzyYcYB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KLrHFgia; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41af670176cso3825855e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713943924; x=1714548724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ydbMWnucjNW5W0ihcxuue8zS6Y542TI1AxUBXYzljqs=;
        b=KLrHFgiakx7lWRWkbl/1U1VFANXyUN8XF1QUhmk1+9bR/6Mu76PT1omBOizjq+Sp5K
         DTbwZSxTRdNEU4pxrv84F6FPMp/ON2LG34VDFcMwWRiuHQ9m7kUaF58Ovl98Pqk7TTvR
         uv8Kx6vT/hqoziPOKVLHQN7syVCVPJwvkJFjsW9RF5YE8DB02YeWpgkPKUCdhtFnxIos
         gN2sp9VplrTZSvOiXIlh7L8tQrIQP2onKO68Cwm0je992mf4WSq9Ip0eyQhZHTboPw3w
         geJzHB9AHPsQPKIWDMe5RqomnE9xijUAa6M8cbg0swYP6pOyZ4QpzB7VQgOXZ0UcA09N
         9mHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713943924; x=1714548724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydbMWnucjNW5W0ihcxuue8zS6Y542TI1AxUBXYzljqs=;
        b=uq8CztP10i97naUS8o2TIlv7Ipl7A56VnHGo1D5Rm8eCwpvkMAavAWZDgEtaDXTvKX
         rtXsSjsn9VVmwUStcZ6EDh0YxgGH01pUXiaZAincrL1uf4T6Dadm6Y7J0YROeDFszhbf
         0GpVcMnVaiVLKVXlG195x+xDVh99KE1n9o78p3OVolG8ZT5hyIP9bS2QFAzOAvvke58Y
         sPD2T4F883OiMrNmZjcJ1hf7cGN6dGf7UhpiSmQJYKy4J59txdS42rV6iXP1ty0jkvA2
         Ysru3ZZW3bhtK5YCnwGKh5rbiLXb4eDkMIo7t4BFRDaMO1w0I/TpXvc8DSZAr0jA/HXh
         GhTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTk8y6lyMuXVK7YzomLMT9fq5oJsuVcNbmumhxDo7W3joumogYP5YVM3DNz92Bv3sGL3q9RPhQOe5psXFQxjhyPjuLk5vwpHhTzt9+
X-Gm-Message-State: AOJu0YwiVIXq62oPoOJuA0ua56qgeV9riAQLuQwyPFYCM2qe1TSVe05R
	Sx+RDZ/L9vWbxMDCy9VTd2Y6zsHrjsLNVFNNVx9yA4g26RPNpOhS1sr+nRB8MC8=
X-Google-Smtp-Source: AGHT+IH1WdqgrfhL0KiIP4WMhCAE0JNU2DDRhzjylMNgDpRA76AHoG+t01DFBTXh60MopUmb/UkMwg==
X-Received: by 2002:a05:600c:cc8:b0:41a:4819:ebf4 with SMTP id fk8-20020a05600c0cc800b0041a4819ebf4mr1607591wmb.39.1713943924231;
        Wed, 24 Apr 2024 00:32:04 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b00418d5b16f85sm22712851wmn.21.2024.04.24.00.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 00:32:03 -0700 (PDT)
Message-ID: <d4dc3f45-5bae-44a8-8169-58077f8b7966@tuxon.dev>
Date: Wed, 24 Apr 2024 10:32:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] Timeout error with Microchip OTPC driver on
 SAM9X60
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20240412140802.1571935-1-ada@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240412140802.1571935-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Alexander,

On 12.04.2024 17:08, Alexander Dahl wrote:
> Hei hei,
> 
> on a custom sam9x60 based board we want to access a unique ID of the
> SoC.  Microchip sam-ba has a command 'readuniqueid' which returns the
> content of the OTPC Product UID x Register in that case.
> 
> (On a different board with a SAMA5D2 we use the Serial Number x Register
> exposed through the atmel soc driver, which is not present in the
> SAM9X60 series.)
> 
> There is a driver for the OTPC of the SAMA7G5 and after comparing
> register layouts it seems that one is almost identical to the one used
> by SAM9X60.  So I thought just adapting the driver for SAM9X60 should be
> easy.  (At least as a start, the driver has no support for that UID
> register, but I suppose it would be the right place to implement it.)
> 
> However it does not work.  I used the patch attached with
> additional debug messages on a SAM9X60-Curiosity board.  (That patch is
> not meant for inclusion, just for showing what I've tried.)
> 
> On probe the function mchp_otpc_init_packets_list() returns with
> ETIMEDOUT, which it can only do if mchp_otpc_prepare_read() returns with
> timeout and that can only happen if read_poll_timeout() times out on
> reading the Status Register.  Poking that register with `devmem
> 0xeff0000c 32` gives 0x00000040 which means "A packet read is on-going".


Would it be possible that the OTP memory is not properly initialized and
the algorithm to initialized the packet list to confuse the hardware?

I see in the datasheet the following: "The initial value of the OTP memory
is ‘0’ but the memory may contain some “defective” bits already set to the
value ‘1’."

Otherwise, from the top of my mind I don't have any idea on what might happen.

Thank you,
Claudiu Beznea

> 
> Kinda stuck here.  Any ideas?
> 
> Greets and have a nice weekend everyone
> Alex
> 
> Alexander Dahl (1):
>   nvmem: microchip-otpc: Add support for SAM9X60
> 
>  .../dts/microchip/at91-sam9x60_curiosity.dts     |  4 ++++
>  arch/arm/boot/dts/microchip/sam9x60.dtsi         |  7 +++++++
>  drivers/nvmem/microchip-otpc.c                   | 16 +++++++++++++---
>  3 files changed, 24 insertions(+), 3 deletions(-)
> 
> 
> base-commit: fec50db7033ea478773b159e0e2efb135270e3b7

