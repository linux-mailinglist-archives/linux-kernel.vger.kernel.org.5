Return-Path: <linux-kernel+bounces-45944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5705B843834
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB2B285C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70FA55C2D;
	Wed, 31 Jan 2024 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJplRV2g"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDEB5812E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687156; cv=none; b=nNx065p1WtSHWFHV14cYWYa+znqr9VTMJVnmtIUjg0z/sOornFf8kzVKKH/WleW8RWMcEvH28eG092s77oIkQ2lenCV/KqboA/NCPv35gflbQbokrjoUy09zqbWWuxlluFQiYOhmRH5tGKkjF+R9T0WGQg69odVqnDwNbGMs/hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687156; c=relaxed/simple;
	bh=oXO0S8EkQBuqNAP1QcV7YXuCyhbIOsW0r8fEkR0rwqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HrmlDCoDTTv6VBNzUq7tySVnHlw2R+7ZLsHKZvJJ90XqGqb1DqEDjVPlmh7s5+WgX+zJFPM3KckpQBeXce7/9H+MVBx0my1YDGdnns6X2RKPsWLf9ynLNsUCxrPHB0mo/fIuqWYC6cCMZllaaHI4R8vFd4Kwhhp6lUBYcAJuysk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jJplRV2g; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26f73732c5so599936366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706687153; x=1707291953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GlX3/XcJ4q7qlkl7qz5VNzVWUimap3oMgXG/HE+rFCQ=;
        b=jJplRV2gzWQUlCVBCV3VhqDp6jasH7lQr8AdmrTe3R+NZMeXF/tGJMHjUa0mhjGc6N
         oIS05w3QoAYvR/RM15KhwniMyE2jmbJcQL2GooMURKrEnoLcDgCSGVdc4ms/RCY1HNxO
         LfUWTlg3kkF/35Bk9hSXgsFddAv9wqXl035671spssWckpLH90t2WGKR3oalNd5nYxBd
         mrtsi5o18RJLx5h9I0Tpj20ijtlXLJuK8oWr8p7bHJ9zgRfc3AWPHsTkqOqTEgbqeaEz
         ZwptHzL5o21kl0PBHT4YttcMYIJDSLSV/RHFlEOwanFNUZxp+EFODLawrXdLYIF5yq9Z
         bXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706687153; x=1707291953;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlX3/XcJ4q7qlkl7qz5VNzVWUimap3oMgXG/HE+rFCQ=;
        b=rHidmJoZZgK7WAviR2yzCzHlxD8F5pyw1n5x7JrBQ8taOL0X9eB54V9EBjAGOISzQT
         xEm+ZR0G5J4gGCdvJTmlURi8BYOq2Q4k1p+QPP0MWTj8ZaS66Lx2k0Jz6u/HJKEmN3ev
         6E3JZvQrq4obDv488fFk7JGP3ZtuFzyFIdaaFMLGt2y54vQis6e04I9xQwFixEgCGUqZ
         flPEfMojjNyCMoIo23oLCBR+lEGKO1oqnBm/MVAEBneDKYgZWTUwrnT/6ixC2nqpQVAc
         D7I6ALNdDlmzUzvegoTl7nfpf8JJFGdM7d8+cbx2gpY/Jj/QvhVzHJl3lxa36fn1/1AG
         PAuQ==
X-Gm-Message-State: AOJu0YwpCdgi7xIwt3loPBOWYIHt8nTCYN6GeYcdQlmdlt0cW5zXvx26
	bQUFc24x1DF1KcxWOASP1jsn+/EUDprCyFDhKv3baTLSCnw8UyXeIF3W10P1mYU=
X-Google-Smtp-Source: AGHT+IFdt9UmrYZi1LDJaUZN6v4OsBwX0Wx45/vHyal7niLOuagGLOWO4SXaO/A1B2GY2WReWwPAPA==
X-Received: by 2002:a17:906:234e:b0:a36:2dc:1903 with SMTP id m14-20020a170906234e00b00a3602dc1903mr494495eja.68.1706687153351;
        Tue, 30 Jan 2024 23:45:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWsega7ZdA6a/BqxICUW4OxzCdFaE0moY3j8YVcxaOlRVZhqUSqLh3uwJ6d030OhbTppkjffadP3AiTtuXNpXPQTpMDPeh3ZnETrX72AyaWeCVL7sAltxVTJSVcbT1z88FjbLt96vM13+kwvUInZavDGXLBFJPFWLRtyURoI+Y13a0Lf3fLV8n+gfpK1RURRhYyHiWtMx8Eci4LAkGHBbUO/LwKX0sg4Ec2Yac3anBtBAbSoPV8LmWTTChxGTGXg5GjU9Y5IBCvTXgH4pH2FqGaYkX3Fto49XCVALQiymP6VvKKyMz1a5vdgdzyZNHbGkpz8SAab/PvxOHUVxUyYn3/V/8x6LUO2Um+d9RZwVvGvixxNGWPCKw2HBItGqNA3NUqvEyrAGhT3gjYHzdvtPsjVWaGFl3GfBH7ns+Tztks2OJ0skbQxqag6lKVZqtssAsRYPyx8aAYNrmwZv+mmj49zs98zv7Iin8=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id d11-20020a170907272b00b00a360fe9a7b0sm1738640ejl.23.2024.01.30.23.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 23:45:52 -0800 (PST)
Message-ID: <b48fa0bd-18e1-4268-9e7a-8199f5d180e8@linaro.org>
Date: Wed, 31 Jan 2024 08:45:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] dt-bindings: net: cdns,macb: Add
 wol-arp-packet property
Content-Language: en-US
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com
References: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
 <20240130104845.3995341-3-vineeth.karumanchi@amd.com>
 <824aad4d-6b05-4641-b75d-ceaa08b0a4e8@lunn.ch>
 <09ce2e81-01cc-431f-8acb-076a54e5a7e6@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <09ce2e81-01cc-431f-8acb-076a54e5a7e6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2024 08:39, Vineeth Karumanchi wrote:
> Hi Andrew,
> 
> 
> On 31/01/24 6:56 am, Andrew Lunn wrote:
>> On Tue, Jan 30, 2024 at 04:18:44PM +0530, Vineeth Karumanchi wrote:
>>> "wol-arp-packet" property enables WOL with ARP packet.
>>> It is an extension to "magic-packet for WOL.
>>
>> It not clear why this is needed. Is this not a standard feature of the
>> IP? Is there no hardware bit indicating the capability?
>>
> 
> WOL via both ARP and Magic packet is supported by the IP version on ZU+ 
> and Versal. However, user can choose which type of packet to recognize 
> as a WOL event - magic packet or ARP. The existing DT binding already 
> describes one entry for wol via magic packet. Hence, adding a new packet 
> type using the same methodology.

And why would this be board-level configuration? This looks like OS policy.

Best regards,
Krzysztof


