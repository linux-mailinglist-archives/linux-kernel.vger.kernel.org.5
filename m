Return-Path: <linux-kernel+bounces-126175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E6F893327
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6954B283374
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B01B153563;
	Sun, 31 Mar 2024 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XleIRPSp"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F151474DF;
	Sun, 31 Mar 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902499; cv=fail; b=GhcF8/dm2gdsM0eOp5XzjchxMmifUgB6yXuiDz63EPRTPA96z7sfYVjeo2OICe3bmRAEGaVXP+i6vFj2adhGYFpPPVOEPoILRk4ZDLSafrW5I6IUqYKJYyPsgYmgrvFX5J10oVIPdBzSy1gyYuh5jGvFrlT7S4EiIXb+O/5Qt6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902499; c=relaxed/simple;
	bh=C2nYC2jdPPnbqH8CNUAQTz0BUQJ52CSAOCEJzrV5r3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbGJkLHeVTCwlIEcU8wAFtzdcKXhJdqXj3hHk9nD7H6E9PTVUc1Mu7ofwZ8S3fm8sSD4epz6yV9Xj0KJUrN8mQO4m1mq7NhKHZfkplT8zGQ0X2klhbo9xc3pSLHnA0fQU/OWXrtn93Pblx4Zlc+Bl50VmAfL4/0RphcmKSQpFMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XleIRPSp reason="signature verification failed"; arc=none smtp.client-ip=209.85.161.45; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 14397208D7;
	Sun, 31 Mar 2024 18:28:16 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jr2x-6QYtVzx; Sun, 31 Mar 2024 18:28:15 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E55F2208D0;
	Sun, 31 Mar 2024 18:28:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E55F2208D0
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id D84A4800057;
	Sun, 31 Mar 2024 18:28:14 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:28:14 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:59 +0000
X-sender: <linux-crypto+bounces-3140-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAwapAQuxQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgB1AAAAqIoAAAUABAAUIAEAAAAcAAAAc3RlZmZlbi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 12137
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
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hi Eric,

>=20
> Amusingly, the existing KEYCTL_DH_* APIs, and the KEYCTL_ECDH_* APIs prop=
osed by
> this patch, only operate on user keys that the process has READ access to=
  This
> means that the keys can be trivially extracted by a shell script running =
in your
> user session.  That's *less* secure than using an isolated process...
>=20

I can see this being true for user or session keys, but I don't think this =
is=20
true of process or thread specific keys.  At least I couldn't read any keys=
 out=20
of a test app when I tried.

Regards,
-Denis

X-sender: <linux-kernel+bounces-125931-steffen.klassert=3Dsecunet.com@vger.=
kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAwapAQuxQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgB2AAAAqIoAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 12053
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sun, 31 Mar 2024 04:38:26 +0200
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Fronte=
nd
 Transport; Sun, 31 Mar 2024 04:38:26 +0200
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 2AB2D20322
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 04:38:26 +0200 (CEST)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.749
X-Spam-Level:
X-Spam-Status: No, score=3D-2.749 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, FREEMAIL_FORGED_FROMDOMAIN=3D0.001,
	FREEMAIL_FROM=3D0.001, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dunavailable autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dgmail.com
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y6JZ0jC6kB3o for <steffen.klassert@secunet.com>;
	Sun, 31 Mar 2024 04:38:25 +0200 (CEST)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.80.249; helo=3Dam.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125931-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com A615920199
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dgmail.com header.i=3D@gmail.com head=
er.b=3D"XleIRPSp"
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id A615920199
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 04:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584181F218D9
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 02:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1C03D6D;
	Sun, 31 Mar 2024 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dgmail.com header.i=3D@gmail.com head=
er.b=3D"XleIRPSp"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161=
45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A6C181;
	Sun, 31 Mar 2024 02:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D209.85.161.45
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711852689; cv=3Dnone; b=3DgXNEolHo55cI9s9E0fe7uOOSm88Jz7dwj3ls8ge3nw8=
RDM4vYnsK3QkV/TYCu8HKWXSxelrGFg26OaTa0ta2xAeaumLm+bNicuklMkDBxzgMakTmXxNf8x=
fV/uZLU1lr3i868qhdgUvfJgx0ptM9DjM8hr8IuQzNZ6hDb2tE66w=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711852689; c=3Drelaxed/simple;
	bh=3DSNeN2CYj+6bo6yYIrP8F5A4iIl0/Q9yGn+qoKYRUWH4=3D;
	h=3DMessage-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=3DWX0BCLiJLkXYSF23cXoAUUoCaN3U++73B96a084d5eB=
yR6abt19vx+RRgPeFHn/FNkK/J6TmDIJzyF4IYk3FZTEjQ9I/pyxKjnmYqJBhqHBxbDk+/e+NGJ=
90rlOfa4MF1hGhvlAequCF3PKJT9TuvWJc3UIpKmFlHj11ZC0GCMk=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dgmail.com; spf=3Dpass smtp.mailfrom=3Dgm=
ail.com; dkim=3Dpass (2048-bit key) header.d=3Dgmail.com header.i=3D@gmail.=
com header.b=3DXleIRPSp; arc=3Dnone smtp.client-ip=3D209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dgmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dgmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a47cecb98b=
so2073304eaf.0;
        Sat, 30 Mar 2024 19:38:08 -0700 (PDT)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3Dgmail.com; s=3D20230601; t=3D1711852687; x=3D1712457487; darn=
=3Dvger.kernel.org;
        h=3Dcontent-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3DlUs6NaIvupBIrN3kNgIHykr6WEWtZD3EhPX18G9uddY=3D;
        b=3DXleIRPSp55P9VHB7a2r/titnJwBaAjVmwFFWncW/trJnpln7+XtSjSvi9uqMgHE=
Nno
         mXoHhat/Z/Iu/etVc504MD8mbcqjpCdo92CyUAjqoOvDmqxWOTlUEoKSZpMXMU1tjG=
DE
         XbpXwWhrrBDGTCSBhMimQlOAAiFIgIn6MMASG45+bZdtNZH3XVRJ5bVJUjjXsZsqVS=
uD
         EAr0yLfv7Xw4ek1Nrgh1EsDej1shKOAN+fHmpmCt2k67uc0kQqgZTsLvlgNdkJABYu=
mM
         NqMAc3CT/Ikjfg8Q4m9fVK1ahVo7HmKBBnIuDdfrFTz3L4Mf85eUXTvDWIq6NjILU5=
Zk
         EE5A=3D=3D
X-Google-DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3D1e100.net; s=3D20230601; t=3D1711852687; x=3D1712457487;
        h=3Dcontent-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DlUs6NaIvupBIrN3kNgIHykr6WEWtZD3EhPX18G9uddY=3D;
        b=3DdR8iI2wu/bgmWoKgd3fQy1Qs3x8Gg8zaFnPHbg0FZVEZ0RXNeEaOyPNYJ1aIfjy=
24D
         15h1F4+67W51lrSYAej/3JXzlWZZfwN+sEoBc+2m+UdBjvHf18AI150uR/j7E1kwLd=
bX
         sGYqzl76u5sQvTr0S681UIXwuJI8SbyuckQSRFHBqVNDfJVH0TIeYJflzO0R6FpSMC=
8R
         9zz21UCZ3xMyhIWChGyQmc7Wt48iBBORmO2pxhHMcl7c4qiPRydQGd654U39D+gB3w=
eL
         ELldBLvIApWZmFYYutf7AN/jmQk6rSAo74Gm8P8UkZUIxFx+1qy0xVLs34o8roNuo1=
WX
         +QIg=3D=3D
X-Forwarded-Encrypted: i=3D1; AJvYcCVwL3cU3nCsvXYDTwS66oYsIOZe9xNTNPxXhx+b5=
LI0hF4hupv8P5wIUYO2JPUDl0WepDijhDJPYBg1N560PbnJ5RAa4R88i26Vu9VypwbBZecB5aqb=
sTeOFXgu4wuUSU6yA7yyNW3bsx+drdJwvoi1WZf5gLyATZ+18fbURnSBI4TAocIuILlIqVomkqo=
ToJcDzLA9S5fTrbiTCkqMZeE=3D
X-Gm-Message-State: AOJu0YyW7TJsviPHgdYwWIVD+v3Bv1LiX1phxqUeZ9O5THjJ2TKywZ9=
M
	IdQhsJIEEtX7xf5p5m/dh/a51J+VTrkHVZa0tY90NWObJeeGoGmG
X-Google-Smtp-Source: AGHT+IG8y/mw6Sg+NJ68AiBnOVhIGZhncP4yQFjwCnn6QvLTTTIKr=
8wBQM2lppgPQLGZ1h9+K7oVJA=3D=3D
X-Received: by 2002:a05:6820:260e:b0:5a5:639a:2fb8 with SMTP id cy14-20020a=
056820260e00b005a5639a2fb8mr6074835oob.4.1711852687375;
        Sat, 30 Mar 2024 19:38:07 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.24=
7.242])
        by smtp.googlemail.com with ESMTPSA id bf14-20020a056820174e00b005a=
4bcb155basm1611035oob.23.2024.03.30.19.38.06
        (version=3DTLS1_3 cipher=3DTLS_AES_128_GCM_SHA256 bits=3D128/128);
        Sat, 30 Mar 2024 19:38:07 -0700 (PDT)
Message-ID: <aae9bc89-ca34-400f-9c5e-44be1df2befa@gmail.com>
Date: Sat, 30 Mar 2024 21:38:05 -0500
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
Content-Type: text/plain; charset=3D"UTF-8"; format=3Dflowed
Content-Transfer-Encoding: 7bit
Return-Path: linux-kernel+bounces-125931-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 31 Mar 2024 02:38:26.2603
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 25f48256-d726-4dcd-c568-08dc=
512ba45a
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D0.407|SMR=3D0.357(SMRDE=3D0.050|SMRC=3D0.30=
6(SMRCL=3D0.100|X-SMRCR=3D0.306))|CAT=3D0.049(CATOS=3D0.011
 (CATSM=3D0.011(CATSM-Malware
 Agent=3D0.011))|CATRESL=3D0.023(CATRESLP2R=3D0.017)|CATORES=3D0.012
 (CATRS=3D0.012(CATRS-Index Routing Agent=3D0.011)));2024-03-31T02:38:26.69=
9Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 9469
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.032|SMR=3D0.022(SMRPI=3D0.020(SMRPI-FrontendProxyAgent=3D0.019))=
|SMS=3D0.009
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAfgBAAAPAAADH4sIAAAAAAAEAE1SXWvb=
MBRVE38k7jLYP7
 hvheDlJwxCE2jYHkbpy56KYt/Uoq5kJHmr/9N+5I6kzBQuRvfcc849
 Ev6bPSg6WtXUm2pTfUPR/m10Sr/0U02+Y+J35Tx6+n78df/04/nw8L
 yl/c+Tq0nqNlKuk+P9PKPBmsE4buk8BU/fKWDSN11NRvcTmYGt9IyG
 RseWXnlyYEkfDaFu2DnqpKPH4/5Asom9NzuiJ3gFzzeW+oMmOjRS05
 nJW/VbyR57+N1b2fgYhCS5jvueXGPV4MmOWoeLKU2TGW3wjFkcVimj
 4yrp7xxteyBb4M1oOWwMoYMSB+VML4P/NfNut4vvuKlOMY1jTrc/c1
 B4OzJdjE2bzLwsxq/pPHo6UWv0XbiU0q9JGy4cleYyvw20vrMsW3ID
 N+qimuiB1HtPPUsXnBoz9m0wi0Spp/RMZvSbCl6SPIMnh4H+dKwhwM
 txuwvxH/lF2tbhv/h6YB0SbCohFmKZic9rcbsU2UqsixtRiXIh8kwU
 QFBAPokyC5WDsBAFDnlsS7GK8jwVyEDwxbm4mqzyyE8gvuCvRYXC4U
 YsMAXzv88qelZFOAQ8Liowwt5SfAE/RUr4bAtCGSVok2eaLj5M8YUh
 fLIQbAkCmLGds+Up0oxEq6oUt/k/l0NX+VQDAAABDs4BUmV0cmlldm
 VyT3BlcmF0b3IsMTAsMTtSZXRyaWV2ZXJPcGVyYXRvciwxMSwwO1Bv
 c3REb2NQYXJzZXJPcGVyYXRvciwxMCwwO1Bvc3REb2NQYXJzZXJPcG
 VyYXRvciwxMSwwO1Bvc3RXb3JkQnJlYWtlckRpYWdub3N0aWNPcGVy
 YXRvciwxMCwwO1Bvc3RXb3JkQnJlYWtlckRpYWdub3N0aWNPcGVyYX
 RvciwxMSwwO1RyYW5zcG9ydFdyaXRlclByb2R1Y2VyLDIwLDY=3D
X-MS-Exchange-Forest-IndexAgent: 1 725
X-MS-Exchange-Forest-EmailMessageHash: 759BD60A
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

Hi Eric,

>=20
> Amusingly, the existing KEYCTL_DH_* APIs, and the KEYCTL_ECDH_* APIs prop=
osed by
> this patch, only operate on user keys that the process has READ access to=
  This
> means that the keys can be trivially extracted by a shell script running =
in your
> user session.  That's *less* secure than using an isolated process...
>=20

I can see this being true for user or session keys, but I don't think this =
is=20
true of process or thread specific keys.  At least I couldn't read any keys=
 out=20
of a test app when I tried.

Regards,
-Denis


