Return-Path: <linux-kernel+bounces-126120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B5789326B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562541C21BAA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CB3149DFB;
	Sun, 31 Mar 2024 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2V0UH20"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9B314901B;
	Sun, 31 Mar 2024 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900991; cv=pass; b=hZy8S0l/hbausHYkao+4IYghN9HojOoKqgC0mByyuxNLK8M4X+DxWBG77XbJjw4kdiI42gIOsgMaKzxYNLO+FVD0IvYA8q6obI4ElXQ1vwbRq0oYqZW2u0CuqIeGwF++yTQhN24uY6z98khay8tfYmjPX9YniK/8iGwD9tovEbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900991; c=relaxed/simple;
	bh=W+lXDAUszoyOMZqfu30yCBMmZT/I9/hK9QyYre/7z38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PERpkc4t0SzReJe8lPfGzn1ojUbdgGQKsjuqsSgkCMBSL/7CJfwNMeBjw0RkfhNed2wUrghQxtIKP9MnSMvXGJ7xQPNGrpJUX0xLTwrBUI4pd+Fqb9MDdRCrU1eKXCF1oEZ891Z1os7hsOx9D8jG4z1Rc08UYZDAc8RlBy1BQMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2V0UH20; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id ADE0C2083E;
	Sun, 31 Mar 2024 18:03:08 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DVgsvW9k4ZKV; Sun, 31 Mar 2024 18:03:08 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 06B54208CC;
	Sun, 31 Mar 2024 18:03:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 06B54208CC
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id EDF2F800057;
	Sun, 31 Mar 2024 18:03:07 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:03:07 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 15:52:46 +0000
X-sender: <linux-kernel+bounces-125907-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAbl5rGbMv3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAG0AAADligAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 10911
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125907-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com A4B572083B
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711839845; cv=none; b=mt9Tj+MHJpRQHvhx0PU2pfraI/4QCFTWM79cei2kz4NW7wLukp1FKuogmsxYfVqCF50cueVDk/P1xnF3GSYl0MMwXKX2g/PD8g2SOO0T1WlvN+4IcA9QlhSe4DWzscksqozVQc0dlTaGlHS9gMD6KK7HUwD8WWiFkr0tlM2ep6A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711839845; c=relaxed/simple;
	bh=W+lXDAUszoyOMZqfu30yCBMmZT/I9/hK9QyYre/7z38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZyU7aYl40U+ITTDK4HXpC7AwbENlsq7vAyN2na83zeUUJibzM1QSH6P1vR1IGJZStWNck/Pw4soz6hxwyAUB0aAXgaLc8KyHjStKbl3Mvf40Tb0QmYBJNbHAZkavkDK+FU5sdmmzLOOzGvqofTs9ZD6sp7N4L/9Jyf9eV3aolg=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2V0UH20; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711839845;
	bh=W+lXDAUszoyOMZqfu30yCBMmZT/I9/hK9QyYre/7z38=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h2V0UH20f+Q2uS5n6JEAhKckjgV7uhFNTa5x+/kH0LgBh44SU/krbwlXI70KbegWG
	 SNmR6tI68tW6f0c42ZgfOh32R3kGntodhG1+ahO2ujFwiQP81GZwMlUf9FXmrssK7O
	 6Ea7eMaKgmNolDjg0fuDRhJnvJQA6gSw/ER6CCGRzxhYZtlvGb6RKRecfJnMaFpoos
	 vQV1n7Hhj3S08ZWtTZQxPeeFC0LH0HfzEoTSaYKCbTDI9jmEtrVLb0M+/4XeWodLDP
	 LUVQj55F6/DQUfpvUuS1mNZTrFLLyVEa7zJLJzC1l4djdj0hPtbd8l2felLocmP97B
	 /cfpFpqeBGCiA==
X-Forwarded-Encrypted: i=1; AJvYcCVdc4D3dZ0GvxZLMKHnna5DVDIUS54gh0tj9auCVoZvRD5XPwTYbqUAsf3MAfAyAzpvEm/xJ5xP18AW1G/HcIrOuYLC15RmQ8kVktYx
X-Gm-Message-State: AOJu0YzTCmh/MOa9+0lL7np8U2V+tbcNZ9Cih75U6R6Wo5cssD7A+BF6
	S/S/1dlFaegbfRccqa2FlAMV6e7n3vLLgMXX+s+RGxjZWyjw738+L74BiYPWkJBNTtT4GhCgEfH
	oT22xUdTgZ6KJdBJI7WOtMFPEZaY=
X-Google-Smtp-Source: AGHT+IFjNJB4zoGtwRlr5x40WVI1gdZMGC9MU8JMrl75Wwj636B+U+cRxHJT0p8X/Eg1DDwUBOkCFLOL5zeL9UoZmtI=
X-Received: by 2002:a2e:22c2:0:b0:2d4:6c1a:ee6f with SMTP id
 i185-20020a2e22c2000000b002d46c1aee6fmr3580757lji.35.1711839844071; Sat, 30
 Mar 2024 16:04:04 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330151945.95875-1-isak01@gmail.com>
In-Reply-To: <20240330151945.95875-1-isak01@gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 31 Mar 2024 08:03:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQzsm6LrqAj5kjZvdWA4tvDDnkeViMPqt_uU1RXcQ-tZw@mail.gmail.com>
Message-ID: <CAK7LNAQzsm6LrqAj5kjZvdWA4tvDDnkeViMPqt_uU1RXcQ-tZw@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Fix typo HEIGTH to HEIGHT
To: Isak Ellmer <isak01@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sun, Mar 31, 2024 at 12:20=E2=80=AFAM Isak Ellmer <isak01@gmail.com> wro=
te:
>
> Fixed a typo in some variables where height was misspelled as heigth.
>
> Signed-off-by: Isak Ellmer <isak01@gmail.com>
> ---


Applied to linux-kbuild/fixes.
Thanks.




--=20
Best Regards
Masahiro Yamada


