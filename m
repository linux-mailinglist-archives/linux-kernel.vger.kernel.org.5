Return-Path: <linux-kernel+bounces-63081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13D6852AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DCA42842B2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638D41862A;
	Tue, 13 Feb 2024 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3s39C6k"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259E01DFE5
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812179; cv=none; b=PbsDjTCf+RNjpBJLTC0eMcKy8dsa8WvMl9zGHXwOwFVsQhaQnyX9Q1MCO0ev4iA7US9rUR+aMu9j6FjNkyXBiDABsTDTDF8VkYBtfg4T9LQF+8Ktr4weNP34k2OFTcNou8VSGJ08lpNCwPDeugaHXKPQarlh8ih3qAgrcmqlx7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812179; c=relaxed/simple;
	bh=U2Y+Kr0bMWSXAxm+KD/WY4ZomXjGBgW7nt3qNovWZek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQkBqln4bx9XmeMQ/3TjA6vT+epzs0yMKXmM1OdUnnMGwUAs2m0ZbSdpLRQKfMXsqyYvr15dv1MKctCewI1QL4N9jI/+DJum/8nepZVaHigZL6A/HkFITyZ1qigqU3qIhY+8HJIOUMG2Ad16roRyYM6Szb/9dTILCnrp4xmdlGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A3s39C6k; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-785d954b236so69512185a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707812177; x=1708416977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKJQkExMKM9CelsaTo12mwlgC53OjDZqQ7+f/ZWjGZo=;
        b=A3s39C6kbUDQXi7XLUq7MC4bsJ17k9vRCBOZNYDxXLrdqhY0bCA46jiqgTbBQBsXtd
         T52abosp/ABRzppd9+Y9XR6za1Pku0xoO9hxo15lt9k+HYuhAo7vq4kni9uSkkpJf8ZI
         AtZgoZCgBISDllAc6JoNFgJwmM7SGKWNtn8h1cGbF3SI0cloVoDxb7jzS4g8TxVzD9Xp
         abEY4URwisOGKpWal3HOpuzmR7aIHZUBTqGVWapFINDg+XwS5mKi0MXYfTbQhTwRfd+2
         ne3bVOXOplQVkhHzbyaR3CIVbpAUNP3+iFI0zpZF2iEA7WA9eS78wRrZIxQsyDDRQ6Ow
         v1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707812177; x=1708416977;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKJQkExMKM9CelsaTo12mwlgC53OjDZqQ7+f/ZWjGZo=;
        b=JOaMsoTHeVGzrEZDi6bqRy9Jj1bNW5UUl0czFK6dTCQr4ZZ+ucXNMkOSodH0blEGzM
         ne9u9v4xSP67kSoZrPzpwiIvcrja6/C/toZYXHBvzr4yQwg4OcvQ1rSPCRxt3jGcpGEc
         Hw5KgMfyYsHZ4EPyJlIR5dxuuIL8q0eBSwPZTv2uN3ypqzadoW9xWGFhs2edI/8Vekge
         gBiTqQG6lK2LOleWPxIiX7pFcbsYtNJSXedQr8M8VaiXhg0L2IUCxVsDEzPoXqzfqy0x
         B5dcpTB2mD6m+CnI1OHpzmCoBHIBBPriEPFlZKG3B17fPw2fkxNyzFAGIbmdoreLGABi
         ajwA==
X-Forwarded-Encrypted: i=1; AJvYcCWVXTXblAPva1VAj2qoZAhDvBc2jEQFBTA5HZ8f8AxW2gj0VZ5+txGTsvV1cvhd5MW+7yQbK81VaxAJR9iLw9OGTCylinXlsjpCdQDZ
X-Gm-Message-State: AOJu0Yz1Rx2L1QBQtDKNAF+U0yudWUG0ARj+jA110NXj7BNSTmB8l5so
	LoJYZjHDbRz09GOFlrr5sKCKtkWPa23mRMGbx0Xv09mKJ9zh1vS0OM4zCaJO88c=
X-Google-Smtp-Source: AGHT+IG6jo1lxsF+ClvpfvbjDv99ccu77l6Z35LSDCMmP9ugZtjW0POcLsQdhQYXMhWGIicalHcSqQ==
X-Received: by 2002:a05:620a:4556:b0:787:15df:39c0 with SMTP id u22-20020a05620a455600b0078715df39c0mr3056929qkp.71.1707812176946;
        Tue, 13 Feb 2024 00:16:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyVnVykstms9WOryasekInAxzKUDAPpQfoa7J7EpCrGx2aCT+4wbDQfnfbuzm7Q20r8FubRrythtMzBZbYGsiNAhlNP9MIGlM38yTIonLlo94enyvgLENRmxS8K6EX4sfxEsKwi4AvjFhwg8LIJ9Slg9NEPno5tyAfmRJOpz/RZQgQ1yrChbVxn1kpwVB+8jhxTSQ8/juzqPR/L+liz8EYgykssvGlUIlAIUVb2nRfLcOsuemnqpsX1eTZ0b0Aj5jrh4ProArEDBJA8DPhga+YujkKwlxTGsp1yjpNLIU94M8+L4d/ESy6yg5mKS5Q/9xcHC+mXXXuittp3oaC0oTt8+SbW7UTd3sLwLFFtimUsahSibArupZa3BlhFhdHx4Makp8VnParFTNbzB5n5DmPtJZoMHPojzENPtabQKhC0VTp7x6c+0dBsi6z3fc85K2VyApVxFZZtorEntbj2vwHVMvVmeFPbG35UZPuu63dZxmECd3RJR28ChKJFUHNlQZSpwvdORYqLnm5DHGkMC7bxKC2kOuxyJn/FvAapJoSkLMEpStFSMpScQxqiPu9HNHxfIujweG/1PoWw1h6KRFi8t+1sbx2OA==
Received: from [192.168.2.173] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id t14-20020a05620a034e00b00786e8e0f8f7sm926281qkm.3.2024.02.13.00.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 00:16:16 -0800 (PST)
Message-ID: <1d6e104d-6833-48c5-b95d-8f10617cd5c5@linaro.org>
Date: Tue, 13 Feb 2024 10:16:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] spi: dt-bindings: introduce FIFO depth
 properties
To: Rob Herring <robh@kernel.org>
Cc: arnd@arndb.de, krzysztof.kozlowski@linaro.org, andre.draszik@linaro.org,
 willmcvicker@google.com, andi.shyti@kernel.org, alim.akhtar@samsung.com,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
 conor+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
 semen.protsenko@linaro.org, devicetree@vger.kernel.org,
 peter.griffin@linaro.org, broonie@kernel.org
References: <20240212140331.915498-1-tudor.ambarus@linaro.org>
 <20240212140331.915498-2-tudor.ambarus@linaro.org>
 <170775215967.605422.1424850912641172864.robh@kernel.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <170775215967.605422.1424850912641172864.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12.02.2024 17:36, Rob Herring wrote:
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/spi/spi-controller.yaml:152:9: 
> [warning] wrong indentation: expected 6 but found 8 (indentation)
> ./Documentation/devicetree/bindings/spi/spi-controller.yaml:156:9: 
> [warning] wrong indentation: expected 6 but found 8 (indentation)
> 
> dtschema/dtc warnings/errors:

oh, the horror, I missed these. I'll re-check and resend.

Thanks,
ta

