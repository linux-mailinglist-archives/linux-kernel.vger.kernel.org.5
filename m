Return-Path: <linux-kernel+bounces-75728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BBD85EE16
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C761C203AF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B0D12B7F;
	Thu, 22 Feb 2024 00:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeGesws4"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A824C11720;
	Thu, 22 Feb 2024 00:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708562105; cv=none; b=JYEmLCEAuHeWNlW27Oqrzbe4ofOIMneEGlDsoKdjsSYtXeeFOdbX0yCSAlffNkB37j4z6zQg+VdFGJ2LL7l6rR1kCKx2xEkvfGb2qcssHb44BjVn489l0u0eOR8exa4PbOjfE+uR5lNQtpw303gxwSKA8q6VdmbSDpiBo8vSGRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708562105; c=relaxed/simple;
	bh=HeAxr6RmqZTnbhdpIBx8pD8sph4h4esqJt4E0AhwFh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mp58Jgd1e+y/Q1/hokT0GENcJiAoGXNES6WRbAxxb5QfrBdRcQOeaZRg8mnHT7X8iMdBN+zGsgHDkjXOcUwYZpejzT71e9g1kyywwE2iqGHFHf0GoaSF/GBWCNU4hDymibNvooNTdkVK7b2OTOHuGlmmjlpuNXkdsgen9MOryxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeGesws4; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7875a838d79so202471785a.2;
        Wed, 21 Feb 2024 16:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708562102; x=1709166902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2JrJ5jovyaupsBQpWC5oSStAdx+X43YfCSVImiiIZg=;
        b=aeGesws4JVcCKOV1Agvi17DpqouZKVDZnM4kQq1LGQ3VLlxz3zHCm+zRgCTtEk0JGk
         5B9x8kM2ZqbKi3C9Xkc/ZOCuONG/btg05QrKIB1TJJ6BQj/NPRkRAmHgf7JFm1gVsszn
         g4mnRjAfFEIF5wjUIpgocImHc4OESiAi3oFwBQ99oH0nGqlpnuGIhEVNw01WMrOi/d94
         EWD3pFPAHYUFVCtV+moQv2ZRzCrapXDuqImDYxeduL6VszayJLM8VPElCCePVeCY6ofD
         gmttiAzCBonKjZIrQlts8Ff+NrNHDs+hbyrkNhasDGAPIe/0yHUvSx7YPZS9m2HX9pki
         QYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708562102; x=1709166902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2JrJ5jovyaupsBQpWC5oSStAdx+X43YfCSVImiiIZg=;
        b=c+yapD3/oyAMiCYisbqQ8CzeicOLFakykXILiVrrtzXn8v5ICEUECmnJ7jVcwEu/1l
         JB9XcywPInIGYbePGFBBANRr7NYyqEilrS7c3/WtMdJcEwVwlx4hti/rvRT1RuMJhdzO
         Np3AAF1Z6bnrJyha83uiYju0k01YM49goG7PzCjRqCzAPScyTllgI5p5jmD7e26ZqzNj
         yToFMT37ImW+hS0Rq+D6A6z5P7g4PSNk57UXXf/KK2bziJamuUyGBhlv9qWxANretozz
         CjzZSo+3M6tJL/9KSIQqGVK9zzOUNuNzfTx4JMZPivIlG5iJvUgy3fl0oqTffwXt3XRs
         u+BA==
X-Forwarded-Encrypted: i=1; AJvYcCWDA3COPVSDDMJGijBl/70T4CiRa7IDCqf95RMoC4ghES/l7hHoTleloU9QikOSWbujKBArp1EK75rHfSS3dMQowr9+6l1q+uASQL5fhoUMWnpRZ67S4W62gYBwnMAFzeij0ai7nbgcUg==
X-Gm-Message-State: AOJu0YzuYFbo8z/0sofSKdnIcGWRlYjz8HAG4fmmF1h4G7smwpezPfHN
	L8fmGT6dkNBqA01BBYszsZIRzwO16iCM6TxWWvPDmZ3Vh2V5GH2G
X-Google-Smtp-Source: AGHT+IEYXoCUv9uwVxBvPd4ZWMdMVNZBGtJ42BWDPA9KK+T3cDyPZx84QXdMTyGTLF4uhMbQI4kZEA==
X-Received: by 2002:a05:620a:34a:b0:785:ab77:fe6c with SMTP id t10-20020a05620a034a00b00785ab77fe6cmr18929305qkm.6.1708562102426;
        Wed, 21 Feb 2024 16:35:02 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w5-20020a05620a148500b0078723db4da9sm4804921qkj.98.2024.02.21.16.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 16:35:01 -0800 (PST)
Message-ID: <e978801c-8bf6-4117-b44d-1c485e3d8769@gmail.com>
Date: Wed, 21 Feb 2024 16:34:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/12] dt-bindings: mtd: brcmnand: Updates for bcmbca
 SoCs
Content-Language: en-US
To: William Zhang <william.zhang@broadcom.com>,
 Linux MTD List <linux-mtd@lists.infradead.org>,
 Linux ARM List <linux-arm-kernel@lists.infradead.org>,
 Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc: kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
 David Regan <dregan@broadcom.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Kamal Dasu <kdasu.kdev@gmail.com>,
 Rob Herring <robh+dt@kernel.org>
References: <20240207202257.271784-1-william.zhang@broadcom.com>
 <20240207202257.271784-2-william.zhang@broadcom.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240207202257.271784-2-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/24 12:22, William Zhang wrote:
> Update the descriptions to reflect different families of broadband SoC and
> use the general name bcmbca for ARM based SoC.
> 
> Remove the requirement of interrupts property to reflect the driver
> code and only require interrupt-names when interrupts property present.
> 
> Also add myself to the list of maintainers.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: David Regan <dregan@broadcom.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


