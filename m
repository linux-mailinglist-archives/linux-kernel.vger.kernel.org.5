Return-Path: <linux-kernel+bounces-105458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD8187DE22
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93F81F21A32
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F1B1CAAC;
	Sun, 17 Mar 2024 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv9K+v2x"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC29B1CA81;
	Sun, 17 Mar 2024 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710690676; cv=none; b=LHprTrdV9GPNyrhAna5KirUWBHsPIytciIBDw0mFemAUgJ6xSW2kZZODH7ZTdMdJttIIpeKL5uEHmKmM4rLwi61TzFx5MY1T0uFvypbjGuLlQkzXwq+oe+mWlchwRwXAJHO+Z6Dz+Ny8i0+4pvqd50fmMOU5Rxd/zMTUrhimN+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710690676; c=relaxed/simple;
	bh=Knbi8ECvoxJZzgUbotfa2HhgH5qH908FPV/fLMPvbss=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RXZbWGMW2d3lK5nfjYu/NToO5BpHszwrBrqQnDtm8nOGWZJhwb7fuSCFKCaLuG10SOQ/7Br78iheOKQOK+Mtwfri9Za6Z7BZHEMhkQjAX/s9Nl+FXtKqWuqLJMXo6gWbUCKfy9nG1UfwZO7pom2eimbktlvJ0HvRv9dxb1EcbKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tv9K+v2x; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d47a92cfefso46804381fa.1;
        Sun, 17 Mar 2024 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710690673; x=1711295473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6xHh0myDZ/4a+0J2/NsOabUugm5P6ZKzY67ZXaFfgI=;
        b=Tv9K+v2x7+XLTZeLWB2UIAZe94IG8ZKkMT+9cpVFbWMtBrV/4GRH11/QebnqI017AO
         Vol46K5IuJxP/OP+o+UEVbmf4qwe6zHd5umxwLEFoqHO2aAmWXqFig/Tn+UtNLbhomZ2
         4TLcCjr7w3g0UEkB4dsJ6ndXBxVxsrUaqr7F20UPCV2E/YGVibOw2Sk83FwKm7PIIbph
         yCRRiWTF4mbNN9fqku1TriUhZdtfDq4UnSh1Xs9EEL93+Jtlj4d8CQnrJJ0YSDZWofNE
         q6IrKMkQhERLklHrTu2V3ikBTa10TEECmE3KO3gxxqqA+hEKtaKXkGHHDQ4HQ/mDMgMT
         p/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710690673; x=1711295473;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6xHh0myDZ/4a+0J2/NsOabUugm5P6ZKzY67ZXaFfgI=;
        b=gr4g3nRnUA/2344qiU8Pn1e9WaJgzyVt6o8XIcXWYb2Qtmrq0Oc53sSm7JUAyt1Dpx
         Jy6OdWIGryNEraTHFavuE3NzKJ8RlELyFa+pI0MPDyGSQmC2cwtpFNid2eApapiP8qX2
         LIs0DiFlf+AlN2nldaiH2YpaGPIZP/Nn8B2Pe6oisXazTe1qWxWNCEetpXOCchrhVaWX
         OBEpvHtXQ1HfTEjsX7CQ2VeZwzKdVJZj5LvqLEZ4DsCHrBDzOhRpbjhc721OGMneQ76o
         gwnoyJdkL3XqC0SC0CGpgjcTHMZLdc60EtrBwPK22NmKF9oNUWFbBJe39FIoNrtla6zh
         h8ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7bA9tYWjSuWB+YPN3lnXXR2G7xYsZqOE4B03lMv/P/dW1Imxj61HyP+E6guygUrZ+A47lOsjeDN9l6DyMLCPYUCOlXbetmwTi44SXYAnqzCa7J69kd3z2yIpvSEwbdPHnf1alvgToK2Ps5cQf+bVLJc653mprn+DC7VWtMN6i2OQE/Zjg4z55yaEjd4/QCIkEv7luz2Z0Fif6Sk7O2Q==
X-Gm-Message-State: AOJu0YzDZsWYd5UdXdN1tWXmz1/tywWF8LbnjxVGkv8QGRY8yZAY88HN
	zmoLJ0PWhUggGVSfWYSgFObtu8vX+TMEVtuur1wLpsuLNvCigDr+
X-Google-Smtp-Source: AGHT+IGN3UivLHGlxSXapjlX6Y4g1qr5b2KnSwEX+5CCupeWG0w1xgNeNySKlc/nixI5uMbZyAJU2A==
X-Received: by 2002:a19:384e:0:b0:513:cfd6:d151 with SMTP id d14-20020a19384e000000b00513cfd6d151mr5384671lfj.18.1710690672962;
        Sun, 17 Mar 2024 08:51:12 -0700 (PDT)
Received: from [192.168.1.105] ([178.176.78.158])
        by smtp.gmail.com with ESMTPSA id q15-20020ac25a0f000000b00513e18a47a5sm491232lfn.130.2024.03.17.08.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 08:51:12 -0700 (PDT)
Subject: Re: [PATCH v5 3/5] usb: gadget: udc: add Renesas RZ/N1 USBF
 controller support
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Gareth Williams <gareth.williams.jx@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
References: <20230105152257.310642-1-herve.codina@bootlin.com>
 <20230105152257.310642-4-herve.codina@bootlin.com>
 <260e0089-0817-cf12-dfcd-c28263808518@gmail.com>
Message-ID: <84b7d23d-0a94-3aab-71fb-01fc37039178@gmail.com>
Date: Sun, 17 Mar 2024 18:51:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <260e0089-0817-cf12-dfcd-c28263808518@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 3/17/24 3:18 PM, Sergei Shtylyov wrote:
[...]

>> Add support for the Renesas USBF controller.
>> This controller is an USB2.0 UDC controller available in the
>> Renesas r9a06g032 SoC (RZ/N1 family).
> 
>    I think I've done the NEC EC-4255 USBF driver for Robert Bosch
> Car Multimedia, too bad it's never hit upstream... :-)

   EC-4260, sorry; it was mostly known to us back then as NaviEngine
(mid)...

>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

[...]

MBR, Sergey

