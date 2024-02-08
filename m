Return-Path: <linux-kernel+bounces-58319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC6B84E49D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C304F285676
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D7F7D413;
	Thu,  8 Feb 2024 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yACR2spe"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38792FC59
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408110; cv=none; b=tDAjDxxn2uMvK1SEy7LD3wnTqHnjfNaqRS5RshEPl9fjtwVAAj3JGfJv3jdVGMFtoP2aXnGALRQ3mSgYCAp6CZld40Yb90up0Z9ixB233rz9cUt9r4GyasRFBH8KWcD7dKlFwUCncoxJIpx5xOp8HGoQrKuVM1pcDYjfS9gwQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408110; c=relaxed/simple;
	bh=bbq0kK4QxUPVpr9UAcnQH1VIyV8lGLWYWod59IocLeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6ERvCik3ktszOqIayNWhXD0mCnh+2TMXbl5VRPhjDvPv/mCfrccgFErn7fbpIiTQrLQk5vilGP2Z8X0qQ8D13VQ341Q3tr6W2nRDhZi7rcCVcdkg5BWp83TN8tZUBPpysE2TMAGL3vAdjkxe3Czd0Pjsj8bp1RnjL+sa4cIAM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yACR2spe; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3864258438so3825566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 08:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707408107; x=1708012907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bbq0kK4QxUPVpr9UAcnQH1VIyV8lGLWYWod59IocLeA=;
        b=yACR2speHzGEz/5Nvn1d/adwOaccs+2oN8kd3i9d0Hpkhw5Wxys32UbwuVNd4aKXl6
         7jCcnDtYXvTliWTGrqZrSWG/S7Byv8cNGINPV9ro7d3apVxBb4ApDjTBsoDKXZZqLaNY
         1+XzDB0baRqutiwN/nwX/KR0vyGSU7PmbJaA17DE6ajU3Nmi3wLJrQsWIGRIaGG3sZIW
         /kPYOCG5SKcp5lK/hagmHuhRFSbaTnDRlOnjtCQpkNHOXrTHOaAI4mMXrGvP31IYrHK/
         ul/JwrpDRM1qGDROZApk0a82kXlNzZDOY7rmM3gvNFlejyEUgrYB9VXqIB7awPbpruBS
         eu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707408107; x=1708012907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bbq0kK4QxUPVpr9UAcnQH1VIyV8lGLWYWod59IocLeA=;
        b=hM4491eiaBM3h5g0PWGKDE2bT0m1AqhdzpHXdbQ8H6pJEoHRlXPHi88+I5hMmZ9n7J
         LaA+vgpxZ0DgrEEjAU13Wi9wSrTzWQV6tvK4kuOw2sf0aIR0FVfnkcg2kEnXw5Chd0xL
         R5A+V/Xi7flaZNW/pXB9umSEFACj8YLvzxAbvcg03k4p65hg17z20aOTQ2xY7tcuiYaq
         oxDfCgs5Nta6XCtdRdCLBpLuzUvBIgS4VlZqpywZSsZkM443zOB5CdWL/245UYgliWAH
         5fK1LUtwnVfyRixhYjaFvdnxLlOw3du+gVKET9C52KuJF4qmz5XXr+9qVa3XjzsHwyI5
         Hl+w==
X-Gm-Message-State: AOJu0YyqskP0X35tacy1DeNv8ZVbAwP7TAor5Gjl4SA2ZqFrmXkbQfna
	wEM6HTLIQ0lMRufvDM2/IIgOZwiMcun0dZewr4XCOgXl26dARMVoiFrw/h+9IYA=
X-Google-Smtp-Source: AGHT+IFEuek5qTM7UWELHa/lyZamlxFWdXVtG52RH9ie1CdZHr4LEnsj2A4aMUO5YM8auyafHb3Oig==
X-Received: by 2002:a17:906:185:b0:a38:2ba9:7f8c with SMTP id 5-20020a170906018500b00a382ba97f8cmr2946557ejb.21.1707408107160;
        Thu, 08 Feb 2024 08:01:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXd7cNi3s+bHjFRA2142fSRiX6cLZXDDfH/h6NofR9tCPCz+k4Cx+/e5jK9u3Pl7Bfa7hFd4tfS09lfAQsidTi0s0duewY9brVuZup7PVzmkxR/T07AlvMeUd6scL/5KV6ygFaszzpYZABTRsGwvraJ0iyZRvIWwkWMdbrtuBhRwor/v/Urv2qqn/mnnAueIKrtDALUKOPGIfbo+82dJ2IDVCvCK3ioBHe8e4kMchv4ZtpIzWq0w6XBKAkkcUM0jhg+4IHK/+kudhXjY0LXMknFR32bftPMoW9I6fVolpvw3p19S9ELln9lD5GCYOD9F2Zqwd+OqSCJXNY+NUG7ueF639JdJa/jVM8CQA+j/SRbrc9DoQ2g/owsgP+n0nNVVxtsASn4ZTMSl0IDMvwQMjUvdX7y6i+c36vF1anc7dmb+0drTkUCtVjRaEdw+TmSt2IYqt2orGpWG8Na9tMp4E2+RFbk5Z1Uo99udABkrbZgvel9HrItlMoCYPPdQEVwee7Yde4uyehRYC26H9UfQq3eYmhCMJiPnXDctJzdqUCoycjreF5WnnWmhAnAX1AsIIDX/Jo=
Received: from [172.20.10.10] ([213.233.104.156])
        by smtp.gmail.com with ESMTPSA id lj17-20020a170906f9d100b00a3773acd6d6sm184873ejb.149.2024.02.08.08.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 08:01:46 -0800 (PST)
Message-ID: <7dd1567f-1b66-4932-8e6e-fb8e394b796d@linaro.org>
Date: Thu, 8 Feb 2024 16:01:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] spi: s3c64xx: switch gs101 to new port config data
Content-Language: en-US
To: broonie@kernel.org, robh@kernel.org, andi.shyti@kernel.org,
 semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 arnd@arndb.de
References: <20240208135045.3728927-1-tudor.ambarus@linaro.org>
 <20240208135045.3728927-12-tudor.ambarus@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240208135045.3728927-12-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/8/24 13:50, Tudor Ambarus wrote:
> Exynos850 integrates 3 SPI

I should have replaced this with "GS101 integrates 16 SPI", as here I'm
updating gs101.

