Return-Path: <linux-kernel+bounces-160627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62758B404E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44121B23F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71031BF2F;
	Fri, 26 Apr 2024 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMdP17QW"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F201CAA4;
	Fri, 26 Apr 2024 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714160818; cv=none; b=pbMRx7vJVTl/OqO/SvzuYQQw4gwBbSIwj8hFQntoWcCYCis75RIpoqRV+eWtKqv3PgKVTkBv5KzrB2aPcYnP9Q5sGaqVimMT2iA1pj7N7fLecGaVWd0S9TreLMaejwpN42mMKtz5r0A6E4qbMoimcuQSqjQZxq6tIrlR/L6Goqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714160818; c=relaxed/simple;
	bh=nCSonnRajlX4+T7mFxC0msM5n38BW5/60VTp4xsIYfE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nvjA2c2tn0p/APeKgy9HSzNVmgOP4YgWeHiqF8d58TUG+jz38/eyYELp8hF52mwOcenz2Wo3gUBAeRj298PEtZkgC0WRaNLT+OQEsggwBuATOtjnseepDrkBuScd2JpGLteToStazAianWMtKWsqkpNRzrNHE0UOjqvWHRqRA9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMdP17QW; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5aa362cc2ccso1619963eaf.3;
        Fri, 26 Apr 2024 12:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714160816; x=1714765616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NU1KOUvcmFNcmmSQaGXwe7JtZDkq7ucg19frndE6tYA=;
        b=QMdP17QWodBD7wZAuFIXgrImUlmuCYOwDjDFh6Z1ujqf2gN/NlchkQ35U62W2vF+85
         aMG2NJzLQmWZrdYbELjVsI/nr49BhaU6gQKa1ICwi3r/RfnAF8L980+yMH0LgfHZ5Nln
         Irf3TJOgHLpIhYGRue3ocMS0usQ94nhM4sSYOnp/m7Mxgh2sfnGXo5Sytp/kQIJV7BUQ
         e3j/H3oRZ8I3vZBJIP7VElcD5Ej3O0+HPHZn1rLManwZkdklW1NcuC9QO9ZF+iG5sDze
         cukodYxy0sv3jx/olz9z9O7XxMkwcRXXzrRznYf/QNS2kuoUj52u2RFgZXR6c4jKsASB
         iXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714160816; x=1714765616;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NU1KOUvcmFNcmmSQaGXwe7JtZDkq7ucg19frndE6tYA=;
        b=NtqfQ2iJgW3T5Qucx8FMfFyngnzvsRG1lsOZx7CvJrSasDUVWWlwvJp27dQyrrQpT6
         6SwKcB6kRYmI+Cg3GzMel8RFlbKMdZc8iMH9VYD+BoO26tesNYtMfFriCophA1ByNI9X
         kUFqXljRmUnvNxRqg+YcuMXWbE+OOuM9rpqkOxMWM+DN56QMd8h5wV87hZpDv/pJLgeW
         NMOWZPN6/mVtRoJkn6EugS4z45z23S7yxSIJ12NzEPVsfVrtx7Aif3oCznXIP8eT6Nmz
         T99kaKcPAKendb0s6dTJcHYyBG92qqRSfUsUpva0i+dzs+lSJSMjPici9zI3GE7M5AkT
         18uA==
X-Forwarded-Encrypted: i=1; AJvYcCXMpSlDgiD+Kg76UvQw5JfZSjah2fI6P5FEhPWimIidf8gKn/n0qpnZWb5wdkZv8LXCIKf3CuR9iFR+0mXWYf6hdZvep1ZuCo21ey7qg3+mSxD4Q6m6MKjB5k4AVNmQkG+fObn7uJ7D2ZYEBDS54krJRdk89Oyw0hBOmR90
X-Gm-Message-State: AOJu0YwWRxTRJel6Ippp32QQrh3PcdgU8khJEjC+feUmB5xr79tBN4Af
	nfdZlFUVsVVrLzX/CUkfC4aMPiDg18JiLjxVrWbICNo/FAEPEOqO
X-Google-Smtp-Source: AGHT+IGBf6wXDhuL1/HqYaClGhv1cB9JoV+I1C85uD3Y0tPYrq4wIdUPMZwACHhD92F7vIm4979Xyg==
X-Received: by 2002:a05:6358:d08b:b0:17f:89f2:5c18 with SMTP id jc11-20020a056358d08b00b0017f89f25c18mr3747152rwb.6.1714160815675;
        Fri, 26 Apr 2024 12:46:55 -0700 (PDT)
Received: from [10.69.55.76] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id df25-20020a05622a0ed900b0043a5c00b59asm1437250qtb.36.2024.04.26.12.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 12:46:55 -0700 (PDT)
Message-ID: <87cc6b80-3e8e-4c24-8007-4357f7180c28@gmail.com>
Date: Fri, 26 Apr 2024 12:46:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] net: bcmgenet: synchronize UMAC_CMD access
From: Doug Berger <opendmb@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240425222721.2148899-1-opendmb@gmail.com>
 <20240425222721.2148899-4-opendmb@gmail.com>
 <07b4cb83-08db-449d-9d73-88e84fa570bd@broadcom.com>
 <50522abe-57d0-47df-9917-e0cd6848650f@gmail.com>
Content-Language: en-US
In-Reply-To: <50522abe-57d0-47df-9917-e0cd6848650f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/2024 12:43 PM, Doug Berger wrote:
> At least a couple of callers could benefit from it. Thanks!
Yes, adding unimac_rmw_locked() as a helper for some cases probably does 
make sense for net-next.
-Doug

