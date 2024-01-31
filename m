Return-Path: <linux-kernel+bounces-46897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1358445F5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF741F2CDB6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA3C12CDB2;
	Wed, 31 Jan 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zy19pVMm"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5772912C52E;
	Wed, 31 Jan 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721689; cv=none; b=n1tT4iyEe9cxnZJSw177aFW2Pol0qWaDhLF+WCF0GfD7R/TpPxkmK8ArsPUrr9tlzV117qHUiVY9h9iTzL0SU+dlwxsR/3iB5SZ5hFndKH/VzDN9+sm77k5F9nfE0WmI6/ncou8efIxmhpqTGNLdJiYLXh7g2hvaoLAIq97gl3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721689; c=relaxed/simple;
	bh=DT8cKO2kA6dk/iYsFZvSWzWmRwlCwwB25ggWisEk+NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTUcNm/7WkQoomnGAFLhza/nJK7QxhLW/FMTSjoUou6uZgEvHkwz1a1ZwdtMreAQt8WVhlISQ3QjZ6wadfIEiCzojFXvPGK1KauiC9luDY+bM0GniydEsUep8NJwPOukeG7wb4EQz/l8NolZf+IGV6JcX5VMcDwA4ayOEHPuGCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zy19pVMm; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d7005ea1d0so851033a12.1;
        Wed, 31 Jan 2024 09:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706721687; x=1707326487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5SSm7MOIIjmBXk7jPtuLN+d28cygO9K1d+Z2Gsb43Y=;
        b=Zy19pVMmkl7g3p9j2Ulk5ajli2lBLbabOraHaQ5+1t1OhuEv9/Mgs0c7UhTNZX7B2r
         E663a/BFMzGFqAP+j3SyQ6+KhIl5sInkBdJwaQqv9/o2bwKAH8RCjIjXyf3iyktmZOIl
         PhEAm5BrkfKjD/O5z7q078C1c58PsL4rHLb7yC2iZcNu+n/dvnzTZvHmEgxRp2nYAVnr
         cfA+EsDIDeAx8eRADRtfbV/+uxwru+Hd/ILDVsSWglNw2zjfGGleuipSR3cmSuf+0utK
         f1U/kzbDd1SYqV7g3u6GUL/UnlEXp3TpWxnVPJXDAIed/Yy/15DjIPpchZLGivysBFKJ
         CdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706721687; x=1707326487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5SSm7MOIIjmBXk7jPtuLN+d28cygO9K1d+Z2Gsb43Y=;
        b=cJY1lcoBzFCRVdjzMerXVlJi2VEqsXN/j4rT5/o1DCoYpnBaPyuQQV6X/F2fs8eqUP
         XKxP3tiVfCUurFoRomdLDGSsZsRGMlMtDaQeF4nq+7JD2TmsJfXpWVaQv4ehyKUk0uWJ
         +O5QgahWz6xpsPINBdp4ySMyBNCXVPpsmbgLRBWPhKAynIjDJj1TABkKLFvyYWEG+P2u
         hi5HdFCCocxDfKaPUerM1pMw17bL+HRZgQDKsulptYbUUT+xfIRxhG/sBLcjl9AVvvHi
         KQPiVmfoxrxkX++9VL2xnKJWdlnuwGbyC9rjbKusUSI7SbWshO/S7AlJ1m2vjX/CnCFc
         D/gg==
X-Gm-Message-State: AOJu0Yyuiuyg4NRzOCMxk14y5IzRtHERdTr9PDwPijy5ZyjuxUFA+27V
	P65XDWAEMsKiqnXQJJ8VjEIf8T+HoU7Wej2WTmPuDivltR/0A2Ou
X-Google-Smtp-Source: AGHT+IHz5UriK0T5vcvDs9E3AgpXqxZiB9W4t8xI/CKQd10IJROUUjz+9hmTamqGvJTut+ZXsyWI4A==
X-Received: by 2002:a05:6a21:168d:b0:19e:39cb:b35b with SMTP id np13-20020a056a21168d00b0019e39cbb35bmr1192254pzb.12.1706721687471;
        Wed, 31 Jan 2024 09:21:27 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u26-20020aa7849a000000b006dddc3e298esm10155628pfn.150.2024.01.31.09.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 09:21:26 -0800 (PST)
Message-ID: <612d5aaa-e890-4a91-b0e8-2c1b3a023870@gmail.com>
Date: Wed, 31 Jan 2024 09:21:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: dsa: Add KSZ8567 switch
 support
Content-Language: en-US
To: Philippe Schenker <dev@pschenker.ch>, netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 Marek Vasut <marex@denx.de>, Vladimir Oltean <olteanv@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, stefan.portmann@impulsing.ch,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Philippe Schenker <philippe.schenker@impulsing.ch>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20240130083419.135763-1-dev@pschenker.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240130083419.135763-1-dev@pschenker.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/24 00:34, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@impulsing.ch>
> 
> This commit adds the dt-binding for KSZ8567, a robust 7-port
> Ethernet switch. The KSZ8567 features two RGMII/MII/RMII interfaces,
> each capable of gigabit speeds, complemented by five 10/100 Mbps
> MAC/PHYs.
> 
> This binding is necessary to set specific capabilities for this switch
> chip that are necessary due to the ksz dsa driver only accepting
> specific chip ids.
> The KSZ8567 is very similar to KSZ9567 however only containing 100 Mbps
> phys on its downstream ports.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


