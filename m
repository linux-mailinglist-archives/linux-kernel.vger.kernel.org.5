Return-Path: <linux-kernel+bounces-163742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD3A8B6F14
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91EF7B20A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B04A129A6F;
	Tue, 30 Apr 2024 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVVLGyW9"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9536A1292E6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471565; cv=none; b=MDs8V9lowlYTB40ZmwhIebdnCgvwJ2xj6kzFbaSAZdch6tz4sk9VC3K21tcksKGcVHE1dLAgn1bh6oope/f57pSE8AcpSrPaYzNATTEMdH8kUm+Xi1Q8PBddhjSCaRvknWEdeeymmCz9yJVLwJdjyLKYZIQv28Jm0qCxJ9zPbuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471565; c=relaxed/simple;
	bh=vY4aoY3iaFAJ2bC/Y7S6nr2UjhvIQZxJpKt5Dq+pFsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pkZDZJ5JpAZTt7RLNFHFjhWY+in3Idc8aq5gG/hMeTcJ999uqsTb9RsXX8aJHtuOcfUopiIoN2z+d8n018RbBZ7ehjhBuBCpIEcjqNzIVWinWZdQrvcxGyngAsfQ1+l/p6HrzTVXQzbSIgueTKDYJV4NeKP1wLWI+s7HLm5py9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aVVLGyW9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a56d7d457a1so659730466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714471562; x=1715076362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Imt5NuxiWRDkGwv25eI3unf3OhsvTV+2hr3+gzwt8xQ=;
        b=aVVLGyW9DXeA6T94DWpnVNVMGiuzp2Kt8wn1GeHJLVQPs/H5/h2Qmyx+oGBhef1dEN
         yVprDLC8ykYgQDoxuqBBZU2YwjsRWyckuXtqOnersOtLIyh8ap4jLhVMA870/aruZCbp
         7Ipd+9QbQfQggkho3KbJUfbENzGS9bqtEvmelEK+E076sHnMfuoLEsjXaeulIk8uzyQN
         VTz3m0ooaKUxI5zTUB/VIy1+AWU6Sy+kA1uQjEJiCNMviVSoA9WkYwNBpqxVWeKatg7r
         UA0G4/ziac3zhWZnIWhfckVV019m5eCRFYURYad2V3UV+J2eDkStkDWsUfvgLRL4j7lU
         PlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714471562; x=1715076362;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Imt5NuxiWRDkGwv25eI3unf3OhsvTV+2hr3+gzwt8xQ=;
        b=GiBFDwflEHhLqsFuW46tkHtQJ+eNi5fLgRNRseEdGfhPXEpzvF8U+yYv3w9aUC61sx
         NwT350WaS5sUtLW0u6PbsBUj+XGzMO570s2dX1Vk7qEHWjNOkIl9Ai2y28O4QwqP4b9E
         PP1oFdYOcO9Eeck1zXbWaxAbJ/zZbhnoSgIVMfBrC3bSofrZanpNmkIfZ6eIei2yu3Ic
         LZMW5W7GUfr4G1wHWnGXWUv7xcTPwzrOP3ONiA62ecsdeTC2cCeM29yeIzl8nCzZU66A
         9OUzicNG9O25kTtvqYyGZSYwBtPYdmSAaomfvzkU+XFb7szLHPHvvsClw/zfVdezsmVV
         Djwg==
X-Forwarded-Encrypted: i=1; AJvYcCVL/ge6GkavqF6tAwAc0I6TKqGTwrpjTbki5T/h8OcQ+OHoclhTXhRs2FHYoY29Cg1H4T3w/fKq6lQDOtuW3hmYjSrO6tj+wWxrto+k
X-Gm-Message-State: AOJu0Yx+d72jYbxidJwTaXo7UtrgaWsmYIfnddvDD+iqle41ZBOMerlS
	K7DBJ8MwQ7SAliserRvSJ+6XC0n8mwcs/PPCr8vzmPuE5HdxDmeYFN4Pojj2Ltc=
X-Google-Smtp-Source: AGHT+IHbDHXsXH9cDLJ3ZcCccN3C4QSKeVMVqF2Q9jgGEnK0JJReoQed5qCZssca/DhiuahhQlczqg==
X-Received: by 2002:a17:906:914:b0:a54:4f06:4d00 with SMTP id i20-20020a170906091400b00a544f064d00mr8632436ejd.65.1714471561942;
        Tue, 30 Apr 2024 03:06:01 -0700 (PDT)
Received: from [192.168.114.15] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id qt3-20020a170906ece300b00a5887fed95dsm7880033ejb.2.2024.04.30.03.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 03:06:01 -0700 (PDT)
Message-ID: <d62b312b-8650-4b1c-9ce4-f73b0831efa6@linaro.org>
Date: Tue, 30 Apr 2024 12:05:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8650-hdk: enable GPU
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240425-topic-sm8650-upstream-hdk-gpu-v1-1-465a11af7441@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240425-topic-sm8650-upstream-hdk-gpu-v1-1-465a11af7441@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.04.2024 10:07 AM, Neil Armstrong wrote:
> Add path of the GPU firmware for the SM8650-HDK board
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

