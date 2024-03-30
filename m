Return-Path: <linux-kernel+bounces-126275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2192189349B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EEAB1C23702
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2BE15F418;
	Sun, 31 Mar 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2V0UH20"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59232145B08;
	Sun, 31 Mar 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903429; cv=pass; b=jlirg4fqXx47pX5IgNzHCooDBsVyFExviE4H7X7sVHIvNkb1NRRKipeGKso5HMHYcyggIOuj3r/DX6l8MDLYCBBCzPwSmkOQ/r6qaRzIotYWRi9RUxQw1qkmtoXEIb1NK59cwDf1o/W4z8QayRHIuABCns6kK10VNZHNR+5XEBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903429; c=relaxed/simple;
	bh=W+lXDAUszoyOMZqfu30yCBMmZT/I9/hK9QyYre/7z38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwt3GFpOq1SqXi1LUDOxWFlSXB7789oJ8QwzEG/OUbRiNEpKw8a8FupfmRj3rid1hrEWb94fgoMRsO/wCKILbm2wIGRkC1P0DbawfvVGBXrZvg1lZKVrs3w2fFdaI/W/tjXYdgNa1B3paquc2dz4KpQeQ3XvkF38/kYniK7FOq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2V0UH20; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E2D83208CC;
	Sun, 31 Mar 2024 18:43:45 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8kKDFpgXKduH; Sun, 31 Mar 2024 18:43:45 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id EF76D208CB;
	Sun, 31 Mar 2024 18:43:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com EF76D208CB
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id E2F51800061;
	Sun, 31 Mar 2024 18:43:44 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:44 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:07 +0000
X-sender: <linux-kernel+bounces-125907-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-essen-01.secunet.de
X-ExtendedProps: BQBjAAoA0mYFfe5Q3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.197
X-EndOfInjectedXHeaders: 7660
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


