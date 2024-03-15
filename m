Return-Path: <linux-kernel+bounces-104365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD64287CCA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAC81C21A41
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547731BC59;
	Fri, 15 Mar 2024 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZNYn0Yp"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C611BC46
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710503146; cv=none; b=H0nXKCv8lrprJfHwT2+MHplUtYdxvWgYIxnsYjZ9+uQ+h/i4U39IEiN/4WgKU2Fte/ITwds/vPEQUszo8eKKgefrVaFNj7CEGOTEVH6fVjSr3/LnGgwFX/EutZCLTCbj52w7R5RZcsZiOi0GmvPasnBgNnAL87uNbA5xImdw8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710503146; c=relaxed/simple;
	bh=v+ffqsIQhZPzUtfCnGhq98QZ2xGpGGacXEy26mUQkrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pl7gUH5YSG0SA2XttbxwTg1kXdlePKW3/HS4RT9kJM1C2BmVEd04M2OzHaLSUF04OEHhi+eL4Z0JQFmSZCC/waGpznQsk2z6VFf2QtAlYZ9WUbj53D6vwUuEuXY8yxCw7S2WEze62e/lV6jVyyVvxx92Llc3lBJxyRY1VbpWx6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZNYn0Yp; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d094bc2244so27204331fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710503143; x=1711107943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ytxwYT73KPkuac+IALOznX/62UDC2uDlXZyOBGPDf8I=;
        b=aZNYn0YpjOf7mthlUp7FL09xpaasbgV3X3uRBg+Q2paRoc9faEFHwSqj+B04Xw7JUw
         4wJJIjI3MMlE9Lnm3in1kHLZpPFz+dp2uBf1hYNIFkYXCoFELT2Uz9Eo4tVDwBbSGtfz
         v7rZz6rk9iZGynOTPmjH5xlsoBJeQkI4MfCow62wpXTOVoNbjxl9joMWpu312VMhgbZ7
         lPJB46Zq1eF8w/mh7LfdgciEcqYZ2jVW/YBY51xN87wDEyKB2kAFgEU+RG9svkzGFrwm
         UrsBLKjrHcXaS2RHsolPMeuKijB6teiyQLM1YmEsX/GFSU2XbyCNvbkbGBNAFKRRl8FO
         ybfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710503143; x=1711107943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytxwYT73KPkuac+IALOznX/62UDC2uDlXZyOBGPDf8I=;
        b=CyBaaJ++8M7bTFCiPwJhBpeD+SFjO07G2RjMHBW6gvNwbqhJMVph6CFHr8+R7uk3Lv
         p4oihvT5lj12IjDe2wxelesooxcUrb4quhFIBFfZEg38FNdVmRlogs1EX5tsa2SGskMn
         lyLTiP30Nv0QmN0eKC+4DN+SMZ3TkMGR3CWzHWdbaejjnCK72ge+KRBqcSR4twiMNET2
         031nuG/3addV1sa+sVB2M3JzDtWGCkAIH4KrTMdHQkm/0uoUzjbt3+7sGfQR/K/7djLI
         uxsHzMovjQPAMLZ8YyJZi706BqSlrZZYtiAUWTA4IV8AZeMny4YxfMB1PHYPC4VkTWz6
         3lzw==
X-Forwarded-Encrypted: i=1; AJvYcCWpsf18L1BIV1p7gjh/nA4z50e4D0i3PRVdLpZNNbxvEmfinVywC9Z28utBr90UvvXHS4g/hP4HL5TmEmPNNCYzO0u2e9pn4c1CRy3G
X-Gm-Message-State: AOJu0YxmffUFSZIULX0zFScJzWHCytGafS4Au0U3L5IuTj3bVnaP9tFz
	0vxwfMyvkJ0Hm9tsA7Onc2cLItWGDEVd60FfZTf56YtqBYAPFAb7
X-Google-Smtp-Source: AGHT+IGLbeqJChmscbnuZSlweMy9pO7O1KZ31yDNJk9aeEILZnKxh06ZqNMVVTbfRZJwXRjffmDvrw==
X-Received: by 2002:a2e:88d6:0:b0:2d4:22d1:d96c with SMTP id a22-20020a2e88d6000000b002d422d1d96cmr2956550ljk.25.1710503142885;
        Fri, 15 Mar 2024 04:45:42 -0700 (PDT)
Received: from [172.25.56.57] ([212.22.67.162])
        by smtp.gmail.com with ESMTPSA id e26-20020a2e819a000000b002d236114533sm485536ljg.75.2024.03.15.04.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 04:45:42 -0700 (PDT)
Message-ID: <529774b9-20be-485d-b218-2452ce536770@gmail.com>
Date: Fri, 15 Mar 2024 14:45:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: rawnand: hynix: fixed typo
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Hector Palacios <hector.palacios@digi.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240313102721.1991299-1-korotkov.maxim.s@gmail.com>
 <20240315122314.10c88c2e@xps-13>
Content-Language: en-US
From: Maxim Korotkov <korotkov.maxim.s@gmail.com>
In-Reply-To: <20240315122314.10c88c2e@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 15.03.2024 14:23, Miquel Raynal wrote:
> Isn't it done like that on purpose? Read-retry is not a mandatory
> feature.

Works it as designed? I'm not sure about it.
I wouldn't rule it out, but it's a little weird that the 
hynix_nand_rr_init() function
is used as if it can return an error but never returns.

Probably  checking  of value returned from hynix_nand_rr_init()
should be removed in hynix_nand_init()

Best regards, Max





