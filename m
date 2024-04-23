Return-Path: <linux-kernel+bounces-155152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34C48AE5EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4380E1F224FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B3484FD9;
	Tue, 23 Apr 2024 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EdikYgOQ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B200883CD6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874996; cv=none; b=dvPrdFD8nyifIBY/lYpG4oCsZ5o7DZIct9aN9gqvsAQ/MdwmJahs7oBbPSsbZfzssHD/zStS3ZVqnyTBDgx+PJKL5eh0UHprFqamut647Cn71a4kbF6yCygHOty0+DtF3xjXMD7aj7jdWXEYf6XNGvV0i6wkHzNANqzjjbOU+3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874996; c=relaxed/simple;
	bh=TUxh2dmmpJX7WBc4srURr73XE2ORniuV1E9p5uloACs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyz75VNDtuUHJvE6q+V/SH2VpRTBp9bUirIiW4U+HukY+VU8pdpUZ5yWH6CpDHBMrpRGOvjoEoZGMe5xN6d4uT9/3QBPT5PlK9nn/tMeUtxDJBt97M/8QVZHmfHsSbTsyMLXI+lMoxoiOahYwZ7H9Pxpqk7nw4vOnr8mM3pTeEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EdikYgOQ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5176f217b7bso9345352e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713874992; x=1714479792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LGk9qx4loxnh2Hbq3VLgz6hVCnEHtgT/Tl0bzU4S7gs=;
        b=EdikYgOQaOF+DjJj6wYiMtlrYBQptQABUHj1f/A5evpmcQ0/gjFqbk9NJ11xzorI9e
         dN+IbtCl+fAB1LulXWXrU2f30m9turJKLV02tMAxZnqE80dg7xPlvM4Jschtt3ohvAtZ
         8EVQz2uKc+FvUNTlqbgl4v7mf+AqK/ptNM0U9GBH0Q4qzYcSqzbVu/TyihX3HKhVwImI
         wUSzzKPoRCmcJE2A7/szmaIOC3ETbjWK4hTxEJRAAsHWNXG2GVoYzL94Aq9bfiHqV+9a
         BGEhb6vKlhDxuKff3KBphSU+Y3fbT/ruGpM2wIKdWTI7ciwnoh5UDlUHmynjqY2g3awS
         vOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713874992; x=1714479792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGk9qx4loxnh2Hbq3VLgz6hVCnEHtgT/Tl0bzU4S7gs=;
        b=qgWAWec5aJZjjfbZH5wfyravtJtX+jHEmLOha6dO+1itdbVk3aDbETPj2d35Sjo9Xa
         qh7Gdeqr5zYBeC9lMCPZ/J3Cq2njlRel5FwbkY7BiNK8Nyl9VVaEJlihAWfA54dCb/PZ
         rHzmwpF7cl5B7w9+UdbGVYx2KZOruBvqaTpxrYc8kXbjNwCx7hsrxFXYmL6pqJ6lQC43
         rQ75UPZldR5Dn2kKqgkqyRdZ6U/KUZz7Vw5fqPeXCJxC1ihigW5Tv+aittxyQdgupWT7
         CNRdmC8qet4gSoqidk1bDQATU3KVWTwmI3aSHlJbAedmL9A62rk/JZUdeIQBd89y1eG8
         bqJw==
X-Gm-Message-State: AOJu0YzycH9l5bOro9IM+OuCcp7HBGmoiWjbn8mkCWNZFJk3mtxxCjQK
	D/ikTXJDhSK/d28d+9Tirgv6M8YTD6SW4OnAx8/d/01MCk1YVcQsRtrlEBVoQuQ=
X-Google-Smtp-Source: AGHT+IGqlffKALibqA7oQ0C8VqbOeS6gh87vCW6HVVS6KS/gfpEZGOEf1bmt5zpFpHDf5E5+lyF7aA==
X-Received: by 2002:a19:5e12:0:b0:515:af1f:5bad with SMTP id s18-20020a195e12000000b00515af1f5badmr9270103lfb.28.1713874991796;
        Tue, 23 Apr 2024 05:23:11 -0700 (PDT)
Received: from [172.30.205.0] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id s27-20020ac2465b000000b00519296c7d91sm2007161lfo.71.2024.04.23.05.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 05:23:11 -0700 (PDT)
Message-ID: <9267bf8f-bbd9-4b61-80ff-c1f43277ef0e@linaro.org>
Date: Tue, 23 Apr 2024 14:23:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq9574: add MDIO bus
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, andersson@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, robert.marko@sartura.hr,
 ansuelsmth@gmail.com
References: <20240323160935.2848095-1-mr.nuke.me@gmail.com>
 <20240323160935.2848095-2-mr.nuke.me@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240323160935.2848095-2-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/23/24 17:09, Alexandru Gagniuc wrote:
> The IPQ95xx uses an IPQ4019 compatible MDIO controller that is already
> supported. Add a DT node to expose it.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 7f2e5cbf3bbb..4ab9da9fffb6 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -232,6 +232,16 @@ rng: rng@e3000 {
>   			clock-names = "core";
>   		};
>   
> +		mdio: mdio@90000 {
> +			compatible =  "qcom,ipq9574-mdio", "qcom,ipq4019-mdio";
> +			reg = <0x90000 0x64>;

Please pad the size part to 8 hex digits with leading zeroes

Konrad

