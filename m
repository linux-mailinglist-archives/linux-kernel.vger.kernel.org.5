Return-Path: <linux-kernel+bounces-64526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1536D853FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6771C2909A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CDD62A1D;
	Tue, 13 Feb 2024 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewR7Itku"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A1B62A02;
	Tue, 13 Feb 2024 23:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866201; cv=none; b=RY7hFXds0PuTXdIfnscje0yFeQfGl4ulmh6TJZx4iC1oJaxU+C8Js8zbtTs4Lu9u1OkSGIQNgknMJfCiLfs+15eMwKUk49IuRWELmHKghQD6LGIsjI6k6AGws0jiudvjUyvdkZJ2FsaPufSzf5Nr31PLk4v5CGcQut30XQct5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866201; c=relaxed/simple;
	bh=yn1oH6etk8WPbSVapAg4M6cLEbD0UbBLL7vryXpe9UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhCJRggenjkxX7t7/3vqfVIUNEwYDAw+NDOlkqFIYb68piWj8R6nu8sYqXPaX+P/l/Zo4ey+38YyAnhThsAyhFEd+3Jlx9P5aFu5DNdeAN9Xv7CK8vZY3IiwwLvUEME2nhOFRNtc38wSnb+H/Ly83MK2nE7ryw5NarEO2C+z64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewR7Itku; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68ef590377aso3370206d6.1;
        Tue, 13 Feb 2024 15:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707866198; x=1708470998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HODJpGHPgaeSYLExqKUI5k/ZPn8+GJoHxQaOjnaKjQ=;
        b=ewR7Itkuwv7KJzz2BJAyq2iRx0uf267wdbl5jvGbk8cjxITlC3bvFuA+z0nGi5vJfE
         9S9v6vEK8YWMrQBaj183gNf0/ZwLwWKAiK2xlnuoDT3d8shkxPSah3HgkDlR7lg3Sp9/
         5UWoVDs+dc65IsFtScPnvlmHFSzjaaRZ9ikZfJ32qd2RKzWK+k6Ws6SaH0X4qaGlgrOg
         4xO17mksH9ycSLGy6M1C9wJrD1LqYr2pNf6i2DCCEt/8CMeXMpeFIOCSYvbQd7nch8zC
         MkLiVeocZm6eh6cCSa3aEwuJdewR/DVhN71vCTOGTakPz3RnyvSDy4a5SQmG+1fbePPD
         Qw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866198; x=1708470998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HODJpGHPgaeSYLExqKUI5k/ZPn8+GJoHxQaOjnaKjQ=;
        b=D+SBXpF2AEmPr3rGo+UNofgcUmwHXDAlBSp+7urJnfoLC8v2wE9z3sGOL7bNckUIqh
         Lw+L8UEj2daBi++xNmrmRC41dcbr7HCSF2Dc9qqpHC0lYT6JDOyuGqJCRmsPk4yBQR5O
         pbyB+kJ20n11rcnq5Eqc8KDTYsnrJys8bxUKCtzJzb6EnTVn+qmKTRCcAXHEErTT8Aiq
         8nHnk3fsZmB7TbRatL1GHX1N5e9lVhDU0CzKdH0edJfkLcfmCUr0FjfyCLG8G9ig3LLl
         DJXMcG/ejBvTIZvut7issJEuTTqwHzXPjkrNORDCGkhVRZ5bMaN4z8UcUA4ExFIjn7Ne
         FZOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy1yOyJW7BNCa4FDBtQF7tTrKsVjAVoICYY1u6n/O8LNDDLvJykyOguIKI923YSrc5iv/MzsuPPGqUdo02IOtizCBKjL1XD6ODvNB/FCqxGvH561zhGZqdwEjtAHedm4iyJf8g
X-Gm-Message-State: AOJu0Yw5tHYHIN3tekyMprs8EkX+qQhFGByfBH+EQTp0WKHhAB7y+a9u
	V/SJM1Sv7btWTQrxptqLBTA+S5OM3KISL8XhmwTKyFZLRcg8aM2/
X-Google-Smtp-Source: AGHT+IGVOTcqr9t7r1mJWO+GREweKk2L52pbdK1UNKT0z8V8V54h42knfmxPrIADrDhaVLlfwUZ6VA==
X-Received: by 2002:a05:6214:27ca:b0:68e:e7dd:83dd with SMTP id ge10-20020a05621427ca00b0068ee7dd83ddmr1139874qvb.34.1707866198522;
        Tue, 13 Feb 2024 15:16:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUH0iobdVJQhOrcmu0taydggb4an1mBJNJRKfSkuUb73VrynX0NGkZzEKkef1qZrwg27/uQjzFtcdKyFiV2RAWhi/7z2fj510p6ClLL8fo8470xdBpTcCUqBfpqDzVGWGI42JRNIi2i4tecYlNOY2gvbYGh8IlItlQKDTIAWAcl2dN+ZyRhywxW/+3+J7cnsQyJYJXJ0sLHjcMhrqbt3Hphz6RQdnzI88A00LdAddxUoxBoKHORspvhnM6iir9l6uNiwz8+lKZ2OHF7a1OwDWi8XJdvdZRujsE7HBDIFZN18V7ITHb/mTDM/hVhMfcJXuaFUw94tdnC8GlgPPJKOKJDIzH7I3XGDlgSR96FffLMGNeMW6sl6JPPfN/vWMeFc5hWJxAHK12X6+0koUxWf0zY5CR03pKqxurXd/7w2p4YrsY=
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id lx15-20020a0562145f0f00b0068ee9aeacefsm919213qvb.146.2024.02.13.15.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 15:16:37 -0800 (PST)
Message-ID: <b3b50731-a364-425b-a0aa-c68c9f0f272a@gmail.com>
Date: Tue, 13 Feb 2024 15:16:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 01/15] net: dsa: vsc73xx: use
 read_poll_timeout instead delay loop
Content-Language: en-US
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-2-paweldembicki@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240213220331.239031-2-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 14:03, Pawel Dembicki wrote:
> This commit switches delay loop to read_poll_timeout macro during
> Arbiter empty check in adjust link function.
> 
> As Russel King suggested:
> 
> "This [change] avoids the issue that on the last iteration, the code reads
> the register, test it, find the condition that's being waiting for is
> false, _then_ waits and end up printing the error message - that last
> wait is rather useless, and as the arbiter state isn't checked after
> waiting, it could be that we had success during the last wait."
> 
> It also remove one short msleep delay.
> 
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


