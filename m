Return-Path: <linux-kernel+bounces-125931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BFF892E5C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 04:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A171F21870
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 02:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D08184E;
	Sun, 31 Mar 2024 02:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XleIRPSp"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A6C181;
	Sun, 31 Mar 2024 02:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711852689; cv=none; b=gXNEolHo55cI9s9E0fe7uOOSm88Jz7dwj3ls8ge3nw8RDM4vYnsK3QkV/TYCu8HKWXSxelrGFg26OaTa0ta2xAeaumLm+bNicuklMkDBxzgMakTmXxNf8xfV/uZLU1lr3i868qhdgUvfJgx0ptM9DjM8hr8IuQzNZ6hDb2tE66w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711852689; c=relaxed/simple;
	bh=SNeN2CYj+6bo6yYIrP8F5A4iIl0/Q9yGn+qoKYRUWH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WX0BCLiJLkXYSF23cXoAUUoCaN3U++73B96a084d5eByR6abt19vx+RRgPeFHn/FNkK/J6TmDIJzyF4IYk3FZTEjQ9I/pyxKjnmYqJBhqHBxbDk+/e+NGJ90rlOfa4MF1hGhvlAequCF3PKJT9TuvWJc3UIpKmFlHj11ZC0GCMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XleIRPSp; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a47cecb98bso2073304eaf.0;
        Sat, 30 Mar 2024 19:38:08 -0700 (PDT)
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
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bf14-20020a056820174e00b005a4bcb155basm1611035oob.23.2024.03.30.19.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

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

