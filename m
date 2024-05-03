Return-Path: <linux-kernel+bounces-168255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F118BB5C6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38C81B2413F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28C658ABF;
	Fri,  3 May 2024 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7Xcns+h"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEFB535A8;
	Fri,  3 May 2024 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772005; cv=none; b=HT2o2lzg6YVvVLJ9RBKBIeA7e4PtfMsboxkBl/LCwC12qe+HL/MqE2VDx5Hb2Z+a6b3VglJbN6rX8MPw6GUjb6mKVWOggrXpdVuuRyGcBrMGJZs0LrEVH9djg5yE7Q2xtC8pfoJ2KrU0Yrd1jJsrG21VgXcI4z/f5u2sEzn2TUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772005; c=relaxed/simple;
	bh=NCAXwfHyr61OCXX/ZRFhD5O/01D/pMK9dk2BzvaMrcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bnm6z5LYoDTS93WFK2S9vuHZ2wGrSESrWfBKFVHY7+EEFBhn8ZlzlPE92xmdHWmLGcSG0xCfTj1Fy4icFuDyxplmpJAx9KhoLQN/wTjQvKgQEkT84AuYwEwFYH7IyqcY4MOuFMEiKhRqMtOXlnI6Q37PF4CsqbLxvwC6c1ilwOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7Xcns+h; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f44d2b3130so166110b3a.2;
        Fri, 03 May 2024 14:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714772003; x=1715376803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yJ1rjd2I3L8WgYwmzP2Belj1FKW5S0lN+W1hzufyv1M=;
        b=V7Xcns+hoctowIec1VLFRsvlHL51CwS+X6jFv7OkMpCilJOnRsu4YZJ5TNFv10/OWK
         +jLS6wRi6nFpA44iMooN1kG3LDoreKMoAKfszooIdx+4hK5NTQUOJ6CI3D78e+wALS5F
         mhuZnPxBuomHf3xK9qlQDf3jR/S19wuOX1l0drObmUTIMrGpvz1cib1Q9GccKNmyCW2m
         Aka9sH3U9r3Qpw4sU//G0aP1PnOrjsAuNAHEqPaPdAZus6iWLW+7nHoHXbD3cbG0vzAJ
         hNV1Q9mElG3un6xkK/d2AXtsS5omu8RkfG2/DDstskmoA+UY23eAVwDK0DCK+CGcbLRb
         N2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772003; x=1715376803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJ1rjd2I3L8WgYwmzP2Belj1FKW5S0lN+W1hzufyv1M=;
        b=vsKCO1volPDijkoToIdpctue2zf5epReldeZB3Iown2URPNR2Ir7SgFRfpNRiCZPns
         b5XOAJum70kECvU3SlHZNEj9n/sCvKAQXlagZYfZKKnFLlktqeXE6o40hs7LM0IsawzF
         JEIYjTNNgvQJ86hkYv1G0/2JU8PvMrT8fyfyVgrA53eRJoontR1XYkcWK8zV1YSrkA/l
         14z+F6WXe9DkxJAcJB104Qxlocbrr5e8Bf+cVZBoi224626mDLVm+le7HFLo9vCR6QOh
         PnB71ENczTCaOEY9ovb/OUBhmivyUQMeLgN05XK3XwAoqaCyDM2LAaf37DMWNKdDAXke
         9NJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMCLkTtLRH5nBu6P45dPpMy4xDghlHDjU7jJ901xFutyoduHbIORUV0tdAKyqPPkPK0qaCWU+IYPX7D0IEtWiLzqrEaCAqXlogF3mRrOXSDcXcxCoPMYzyq+wTJuzWGXJD1q/Uz9emGbe8ryq+SwnbStTgWIjJLgV6qIFYT4fj6HKIXBM=
X-Gm-Message-State: AOJu0Yzd9+RHCDdupmZFSX2y8CVKL9cBGhKLZzspH/FVrox0IMeZykis
	+JIvj7xGlv/IZqSOL/F/lakKF9zhkbH9BmStNuXIz8pHGOg2+J0A
X-Google-Smtp-Source: AGHT+IGu4d+JB6H6GVxzxsiFWbM1p1lxUwqo0405OocYqBrS24F6eOYzEVRzk7IwracOeHHe6x7wyg==
X-Received: by 2002:a05:6a20:948c:b0:1ad:747:3fd9 with SMTP id hs12-20020a056a20948c00b001ad07473fd9mr3790769pzb.54.1714772003163;
        Fri, 03 May 2024 14:33:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y8-20020a17090264c800b001e868e29fabsm3793795pli.251.2024.05.03.14.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 14:33:22 -0700 (PDT)
Message-ID: <f010f127-ed51-43ca-9c88-7bc7e06025e1@gmail.com>
Date: Fri, 3 May 2024 14:33:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] mips: bmips: enable RAC on BMIPS4350
To: Christian Marangi <ansuelsmth@gmail.com>,
 Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <zajec5@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Daniel_Gonz=C3=A1lez_Cabanelas?=
 <dgcbueu@gmail.com>
References: <20240503212139.5811-1-ansuelsmth@gmail.com>
 <20240503212139.5811-6-ansuelsmth@gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240503212139.5811-6-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/3/24 14:21, Christian Marangi wrote:
> From: Daniel González Cabanelas <dgcbueu@gmail.com>
> 
> The data RAC is left disabled by the bootloader in some SoCs, at least in
> the core it boots from.
> Enabling this feature increases the performance up to +30% depending on the
> task.
> 
> Signed-off-by: Daniel González Cabanelas <dgcbueu@gmail.com>
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> [ rework code and reduce code duplication ]
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


