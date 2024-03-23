Return-Path: <linux-kernel+bounces-112375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C87887915
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3145F1F230C1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C11B405FB;
	Sat, 23 Mar 2024 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6D/877F"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40B02AD1A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711204121; cv=none; b=qKCk+WDfFOgRb7J91d4QChSjtXbcWcv5dD3ZKa24Qg6CzO7FiQr0ASonIQL6/qwHLaCaaR+bQAaODwUwewP0zg5juN1tsHwuglxh23oIZpgJvRMLnT/955a8IDph0qm2WcCNuxZHlyk6aDKsIiJgJRDcH8FdFpp9rWtZLOno6zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711204121; c=relaxed/simple;
	bh=V2NKjV/9MRruChSsK8vjvJS9GdHK98QZJJdEg6HlKI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMgUVyfTxIE96wuVYnL6W7Zh1POfATqdypxQtaGMA6yX0Z6jha/L8z20bmSJugVSeqmhSiawWG+NEga1ef0OimpJUMMd8EJmP+sGcYCiw9JZLrqIie//JH/d3MbtMFIb02D97MvF8zlLEFJyJT56M9uZWECFxTeOuIXOKcHnQdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L6D/877F; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a472f8c6a55so195971366b.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711204118; x=1711808918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V2NKjV/9MRruChSsK8vjvJS9GdHK98QZJJdEg6HlKI0=;
        b=L6D/877F0vFQfMAcSVH40n4xFxlxeIFF+5UpefLDiZ6Re3QjUIVvl/Pd3/JgwYgGwj
         DwQopVsnCFx6G+gqqf09boYG1JICoNb1v0Fa8PrqOF2L0bqMgqsD+9BlMxh++7sdj9gq
         VCycZHUKHywgJjjdGRiFX18jBNPa9zNqWyvGlNE3K/m/XcWUg9HKNM1EG1OuQpehp+2z
         a9breg75VpIm6MeqxyzCbAWOJ+5Q/EPG2z5T9Gsk1QnGuZRgw7DaWhy4WwhR68NC7GMq
         YVGvgWYuCRQ4vyQtiBkxbP5ZJw0G/oMw8lz+np1BtFEKNp1uijVC183ONvx05Ghe+VE9
         DbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711204118; x=1711808918;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2NKjV/9MRruChSsK8vjvJS9GdHK98QZJJdEg6HlKI0=;
        b=orxMXtBnefifxD1Az04PIYeahQVOgh/WiDYsmWAE5umH0AXpTFwU9EE78veq3XoHFr
         D/YSUu+pNHwebBaXHi7stfxZRS9QXtppZqaCMRa9y7HEFmqEy4asUqAO0YrSyDEw8TD4
         UWZeima3xhop2FRtg0yKWRnXQPCpJ+X2Kj7whf6OotNgyl2W3YF9wnuYGUdDCwb/JjFH
         kGaOFEnXwHPlLy4E5OjaAnbSsLYu2qgcyvJDNL3xpKWhbHQ7wrcRkxSsNKrw+Eoc/437
         d2LtFZTQCfqgrGEqvpSqQOYEV17a/eELhXs61rp0jGBve3xf0bea/9xJxF1g20t8eVOM
         Dldg==
X-Forwarded-Encrypted: i=1; AJvYcCVIi5pfvaWjanRmjaPGCyl/47o9V98tfPhiFPQPFFzUgm2goecuGMFmmSr9lN7KKLPmJMGns98D5YpAF1IdKJQH5ltnpJkbxDKTHO/s
X-Gm-Message-State: AOJu0YzwJeMSqMTq9tmemzVair+7Vy7jwusDXW22DKTlyY2NfXjdc0xE
	zvITaNW/AbMkSQMfo9KTQnCfP8XVHvQebyi6elKaNWlgNUMgQszJUE3/iw7iSO4=
X-Google-Smtp-Source: AGHT+IGNsLru95rurRaS/+SBs355qf8iBCJXXTsr35KUl82vOabRUAGxbh048dRdrxy1cWZleQeWRg==
X-Received: by 2002:a17:906:60c8:b0:a47:32b3:18c5 with SMTP id f8-20020a17090660c800b00a4732b318c5mr1681059ejk.68.1711204118269;
        Sat, 23 Mar 2024 07:28:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id bw2-20020a170906c1c200b00a471b5b25b9sm955586ejb.127.2024.03.23.07.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 07:28:37 -0700 (PDT)
Message-ID: <9700cc88-bddb-480d-9417-04b2ff539a2f@linaro.org>
Date: Sat, 23 Mar 2024 15:28:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] dt-bindings: iio: accel: adxl345: Add spi-3wire
To: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
References: <20240323122030.21800-1-l.rubusch@gmail.com>
 <20240323122030.21800-7-l.rubusch@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240323122030.21800-7-l.rubusch@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/03/2024 13:20, Lothar Rubusch wrote:
> Add spi-3wire because the driver optionally supports spi-3wire.

"the driver and the device"
Bindings should describe hardware, not drivers.

No need to resend just for this.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof


