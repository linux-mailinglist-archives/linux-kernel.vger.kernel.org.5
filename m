Return-Path: <linux-kernel+bounces-70539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793188598FA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C826EB21031
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8F86F530;
	Sun, 18 Feb 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PeOqP6LT"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5426F51A
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283432; cv=none; b=otj9OfESdB8AQqcbOK0IV6mZpzZEh4bPbRGn03GeEsGxQa9OBeUqYRG1+gcH0E6LqPfeD45zq6YhJQgAGc8xVPqQpXulib8urgLkO2JHvlZ2+Nsx+SX/qzgKw15We3r9DQGzl0cSA4uHsteoLbCL+Zkls67ljZ79LxxuUkSQfv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283432; c=relaxed/simple;
	bh=2OiUQOvcZKm6PUzGnZ1RrYTTFoV1/H907nhnVmgSlG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6D5e3YjBakiZe38i34w39cxsm0z8V6BehaCJBzya6SNcTxCgv8Y/yWj29hNhCvbOITEBZemeXzTKd+5/iGbbGLiCXO7NCP4XwtaV1K11+MPJ+J7B0se4as/bEIxh+PpFCvks42iucPjhWmyAvO7egEbIbxpBfthuOeMP/qWWRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PeOqP6LT; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso3382876a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 11:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708283429; x=1708888229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ah3PVEu8tN1U7WxibGyKTgjBe3AELLyTP3yUvUcDK7E=;
        b=PeOqP6LTEl3a83ku7rMNhngJiFP7D2M4eN5dENNd9dXGwAL3lDFSt7KxvGt8ZiFwge
         jB91W2Nk5YxSXZ243KwqhNPIaqL7Nrfnb/dljD/Oh1VC6RdDFaXgMH/T/qMASGIkrkEu
         cO+ORYoSomxtxjcEWlBuYKqo3VpxmvYqt5H+L17nfm3M794qbvjRr1fD60GevYLJ0/kN
         b6210WenCgIr83wXBgNFoORIjEM+M1LsnYO+SLO4GbdwPBw0WNGSzh7cUfI/8ZglgSOO
         qsWNWbLyPp1XgWmUIQQs9XCY41w248B6q85UKzMW0L9WRTCIPoyNWgpLXbxItut8bsLS
         2U6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708283429; x=1708888229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ah3PVEu8tN1U7WxibGyKTgjBe3AELLyTP3yUvUcDK7E=;
        b=KCU5hR4QJprlvFLTnZ9CHoIs/PSSNT/WvHFIg64bevjLRgE98vcLCL5sRtM0i/HBT6
         teqZiRFyNpIYGsFKNK9fRlPKiy689xXKSjAuW6jradXoaJqica0FRwLtLIkqZQiyOyBu
         SIyPLx2pEydM701GImfPZbq0uKBav+1AB8XUg0qlWjnu/rK3dJCVeijHDEHmnzU5w6Xg
         eGtzY65VEpwHlDAJQ8XFJsWNzqk/mhDG1GwbRVceBDki7wlXTpVKkuw1isO9BGeaN+WS
         OGFnEPdsEfF5lOXTbQ3+hHBMBnn4OebpRoAkAXlg7FvOGz/YHaHbk2PEPAGXej5N9r5H
         POfw==
X-Forwarded-Encrypted: i=1; AJvYcCVw/oTyZh79VZAjZEHbcGOTerIfuf1SK2yHfnsQZiFl+mKDXRk8k0I2vEkMZcmTfDVuUxISaSJfsXoK/bcokxn3mbH+Ee7DQXng2Vaj
X-Gm-Message-State: AOJu0YwAll/RvDCzQjb1692Rm02aQncugEE5H9TQzvj5L6WnMoR+DqIg
	rIhVZ6DrMAf6u4OHbw1SxHsBL+xE7im9xOIoZ6JKW3bmyapV0iXsrVGD3jE0MqI=
X-Google-Smtp-Source: AGHT+IHG7EUQ1Lj6VSnjTbKaODUnEDyms7rRXGLPDHhArV02Xl+7l8pWi7wkq1Hz+7C0klZApkVexw==
X-Received: by 2002:a50:fb84:0:b0:564:2518:adfd with SMTP id e4-20020a50fb84000000b005642518adfdmr3719731edq.10.1708283428977;
        Sun, 18 Feb 2024 11:10:28 -0800 (PST)
Received: from ?IPV6:2001:1c06:2302:5600:366d:ca8f:f3af:381? (2001-1c06-2302-5600-366d-ca8f-f3af-0381.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:366d:ca8f:f3af:381])
        by smtp.gmail.com with ESMTPSA id p24-20020aa7c898000000b005617a858f21sm1942850eds.93.2024.02.18.11.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 11:10:28 -0800 (PST)
Message-ID: <f4e2cd9f-d8d2-4669-9bbc-57f67a24e734@linaro.org>
Date: Sun, 18 Feb 2024 19:10:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm6150: define USB-C related blocks
Content-Language: en-US
To: Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 gregkh@linuxfoundation.org, quic_wcheng@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240217163201.32989-1-danila@jiaxyga.com>
 <20240217163201.32989-4-danila@jiaxyga.com>
 <6bf11ccd-ff08-369b-913f-277c189afb76@linaro.org>
 <b0b732b8-456a-4021-8277-cd51f01ead17@jiaxyga.com>
 <44c669a0-3722-4a58-be78-0c91f0573ca1@linaro.org>
 <60728953-bdf0-4a06-a90a-d1191d41962b@jiaxyga.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <60728953-bdf0-4a06-a90a-d1191d41962b@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/02/2024 6:52 p.m., Danila Tikhonov wrote:
> You are referring to Dmitry Baryshkov, as I see. But Dmitry has already 
> reviewed my patch (message above).

Yes we previously debated and discussed verbatim copy of downstream 
versus the format we used for 8150b.

The original driver I wrote for tcpm and the dts that went with it 
derived from 4.19 where the interrupt definition was already right, so 
in that case copy/paste of downstream is fine.

However with earlier kernels, 4.14 in this case the signalling isn't right.

Please read the discussion and reconsider your patch.

> So it would be rude to change anything without his knowledge. Let's wait 
> for his answer
He'd have to be arguing against his own patch.....

One final nag - please use the kernel discussion format of bottom not 
top posting.

https://git.codelinaro.org/bryan.odonoghue/kernel/-/blob/sc8280xp-v6.8-rc4-camss/Documentation/process/submitting-patches.rst?ref_type=heads

---
bod


