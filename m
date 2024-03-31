Return-Path: <linux-kernel+bounces-126264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B14F893473
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EADB1C237AA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A1615E1F4;
	Sun, 31 Mar 2024 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XleIRPSp"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E3815E1E9;
	Sun, 31 Mar 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903398; cv=fail; b=MuvCzGbLjLSnMpTx9SANysrj+ngjJF7XRFKpQxwLPM5VLnxM80tt1fIXajB+eZlkmwsj/D2IQ2+GZFOkCa1uCs4/wMT3NoCC/BrpukZsJNVsJJKD9ztWi+X74I8yhFr2/VPHW7jxlbO4ActaE4CrmmU9ZSqRJYWIlhWo9ENe044=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903398; c=relaxed/simple;
	bh=SNeN2CYj+6bo6yYIrP8F5A4iIl0/Q9yGn+qoKYRUWH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHDLTHCFuv55MSj26bneF2n+YvTqjaHrvSfFzPx58pjeKxzXjenumIDJ7nozXhOouIXW9B4RIuFtTxyvw8SveRGNqi0VQRwBzVLBwexM5FCh35NiYIkSGqafI8NeBxoDQ1AXACroAcYRP3oa4roh/4Ey1owmxayZRFo2qr7tSpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XleIRPSp; arc=none smtp.client-ip=209.85.161.45; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D6944208C9;
	Sun, 31 Mar 2024 18:43:14 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cM1sOu2Vp0cp; Sun, 31 Mar 2024 18:43:14 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 64259208B7;
	Sun, 31 Mar 2024 18:43:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 64259208B7
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 56CB180005F;
	Sun, 31 Mar 2024 18:43:14 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:14 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:10 +0000
X-sender: <linux-crypto+bounces-3140-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAWmsFfe5Q3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 10041
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-crypto+bounces-3140-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 5A29B20199
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XleIRPSp"
X-Original-To: linux-crypto@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711852689; cv=none; b=gXNEolHo55cI9s9E0fe7uOOSm88Jz7dwj3ls8ge3nw8RDM4vYnsK3QkV/TYCu8HKWXSxelrGFg26OaTa0ta2xAeaumLm+bNicuklMkDBxzgMakTmXxNf8xfV/uZLU1lr3i868qhdgUvfJgx0ptM9DjM8hr8IuQzNZ6hDb2tE66w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711852689; c=relaxed/simple;
	bh=SNeN2CYj+6bo6yYIrP8F5A4iIl0/Q9yGn+qoKYRUWH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WX0BCLiJLkXYSF23cXoAUUoCaN3U++73B96a084d5eByR6abt19vx+RRgPeFHn/FNkK/J6TmDIJzyF4IYk3FZTEjQ9I/pyxKjnmYqJBhqHBxbDk+/e+NGJ90rlOfa4MF1hGhvlAequCF3PKJT9TuvWJc3UIpKmFlHj11ZC0GCMk=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XleIRPSp; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711852687; x=1712457487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lUs6NaIvupBIrN3kNgIHykr6WEWtZD3EhPX18G9uddY=;
        b=XleIRPSp55P9VHB7a2r/titnJwBaAjVmwFFWncW/trJnpln7+XtSjSvi9uqMgHENno
         mXoHhat/Z/Iu/etVc504MD8mbcqjpCdo92CyUAjqoOvDmqxWOTlUEoKSZpMXMU1tjGDE
         XbpXwWhrrBDGTCSBhMimQlOAAiFIgIn6MMASG45+bZdtNZH3XVRJ5bVJUjjXsZsqVSuD
         EAr0yLfv7Xw4ek1Nrgh1EsDej1shKOAN+fHmpmCt2k67uc0kQqgZTsLvlgNdkJABYumM
         NqMAc3CT/Ikjfg8Q4m9fVK1ahVo7HmKBBnIuDdfrFTz3L4Mf85eUXTvDWIq6NjILU5Zk
         EE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711852687; x=1712457487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUs6NaIvupBIrN3kNgIHykr6WEWtZD3EhPX18G9uddY=;
        b=dR8iI2wu/bgmWoKgd3fQy1Qs3x8Gg8zaFnPHbg0FZVEZ0RXNeEaOyPNYJ1aIfjy24D
         15h1F4+67W51lrSYAej/3JXzlWZZfwN+sEoBc+2m+UdBjvHf18AI150uR/j7E1kwLdbX
         sGYqzl76u5sQvTr0S681UIXwuJI8SbyuckQSRFHBqVNDfJVH0TIeYJflzO0R6FpSMC8R
         9zz21UCZ3xMyhIWChGyQmc7Wt48iBBORmO2pxhHMcl7c4qiPRydQGd654U39D+gB3weL
         ELldBLvIApWZmFYYutf7AN/jmQk6rSAo74Gm8P8UkZUIxFx+1qy0xVLs34o8roNuo1WX
         +QIg==
X-Forwarded-Encrypted: i=1; AJvYcCVwL3cU3nCsvXYDTwS66oYsIOZe9xNTNPxXhx+b5LI0hF4hupv8P5wIUYO2JPUDl0WepDijhDJPYBg1N560PbnJ5RAa4R88i26Vu9VypwbBZecB5aqbsTeOFXgu4wuUSU6yA7yyNW3bsx+drdJwvoi1WZf5gLyATZ+18fbURnSBI4TAocIuILlIqVomkqoToJcDzLA9S5fTrbiTCkqMZeE=
X-Gm-Message-State: AOJu0YyW7TJsviPHgdYwWIVD+v3Bv1LiX1phxqUeZ9O5THjJ2TKywZ9M
	IdQhsJIEEtX7xf5p5m/dh/a51J+VTrkHVZa0tY90NWObJeeGoGmG
X-Google-Smtp-Source: AGHT+IG8y/mw6Sg+NJ68AiBnOVhIGZhncP4yQFjwCnn6QvLTTTIKr8wBQM2lppgPQLGZ1h9+K7oVJA==
X-Received: by 2002:a05:6820:260e:b0:5a5:639a:2fb8 with SMTP id cy14-20020a056820260e00b005a5639a2fb8mr6074835oob.4.1711852687375;
        Sat, 30 Mar 2024 19:38:07 -0700 (PDT)
Message-ID: <aae9bc89-ca34-400f-9c5e-44be1df2befa@gmail.com>
Date: Sat, 30 Mar 2024 21:38:05 -0500
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KEYS: Add ECDH support
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Zhang Yiqun <zhangyiqun@phytium.com.cn>, dhowells@redhat.com,
 jarkko@kernel.org, corbet@lwn.net, keyrings@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org
References: <20240330065506.3146-1-zhangyiqun@phytium.com.cn>
 <20240330070436.GA2116@sol.localdomain>
 <087bbfcf95c9014ee8f87d482773244f0833b892.camel@HansenPartnership.com>
 <20240331004844.GA104623@sol.localdomain>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240331004844.GA104623@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hi Eric,

> 
> Amusingly, the existing KEYCTL_DH_* APIs, and the KEYCTL_ECDH_* APIs proposed by
> this patch, only operate on user keys that the process has READ access to.  This
> means that the keys can be trivially extracted by a shell script running in your
> user session.  That's *less* secure than using an isolated process...
> 

I can see this being true for user or session keys, but I don't think this is 
true of process or thread specific keys.  At least I couldn't read any keys out 
of a test app when I tried.

Regards,
-Denis


