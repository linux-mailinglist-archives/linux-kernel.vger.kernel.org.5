Return-Path: <linux-kernel+bounces-46920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AE984465D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08643B25B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4A612DDB1;
	Wed, 31 Jan 2024 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYhqb3iX"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56F212CDBE;
	Wed, 31 Jan 2024 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722977; cv=none; b=f9heSAt9P5ehRHBWFiMgo8bbhj9nk82FJ5DygNA2oK4yurhGdHFq8o5dtWKWsUaOTKF4uIMs6SdUtoFTjamtDrSDJhFv45rZQWD1CH8WBRmf1QGD2npCDCHhmUicfm/3YkLzHSQva6CsRe0p7do87uUV6GCuUDCOrFnE0m8C0pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722977; c=relaxed/simple;
	bh=5mBrqsdSSNX4K1OVtEiQXCeAYA1ovM5trdUHizHWMCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J35WGWzcknwCJ/NWIflFlazHpGengieU70FHO3XFMHtdMVVsame/Qa8JfJpVKFJgv19PrkqA+Nn0pAEBXZ8A+C2meVSRdYurnCp8+F6hCWJ+pSq38lIQNTwbJcTK96/+2fPvSGmlUOfIAunrNLvd7e6XgT5aVGOjK7upFr7LWwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYhqb3iX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33aeac77bc4so4006f8f.0;
        Wed, 31 Jan 2024 09:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706722974; x=1707327774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AgYafR8d8OW74/fEtUK5QU/2T1EGv4L7kpyAYQKPOoA=;
        b=QYhqb3iXn+Y/gcqtUkW9CVw4Vqs7Ff4bplP5GrfYGeS0t4OuZqhdC0qaNsP90WC4sf
         eVD2mO4WK9X3vgMOBrKTSeUXr4VD3EJK1MgQdTTjiSlSxfDAJ8jBl4cfnQwpTbM/XNaQ
         FGyPxLkr9SqyuX6Ta0yH7Uo6ns0jRrCWNb8IgmFQU3aLHa4YGn8diKkPcIc4TQ/yHfOQ
         0IA2QGyPW3ckSE6Xf29PpDSunSuxSoHXW/BGCAacGr94Tl8kmQeYWkrqwBmIRKoGh48o
         KtRNxnT4nZf2XE4PvFaZuvtCAkm3YHBUN4Nku8i9q0A0rTx4nfP3/lxoZjNxRuco9Pb1
         k/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706722974; x=1707327774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgYafR8d8OW74/fEtUK5QU/2T1EGv4L7kpyAYQKPOoA=;
        b=dX9knFTWzbqDMpf/QRbUI5FVS7b8CnVfuJUBktaWECgnM4BKIQiWupA6Nwfni9ftTt
         yTarN7Id+Nm8/FXRsyh4QG/tmS8pTwsIInOrAjlR89PUEpTKy03R5006seOZB75AVkmH
         qCU05FOirERBjsUx+D2rrbyAFuZ3p4UoMxbVLdh6xxcjvVZ6CMqtKhjIL9NAu4V5NE0x
         mUMd82P42skZyO2mZHBGi3e36JKUkICidsNZ7c7vIZ3qFGE3n/A1TMWolzSi/iDRGtpF
         qmRPX3Raxyj3Uy/v6srRbPPPGAnv3JVqjVhDKtawxQZPsXB88JzkkZeF1wkK63x3fxpM
         yXkw==
X-Forwarded-Encrypted: i=0; AJvYcCWTdArYqC/KXEvf6pv+NLsgSr9hvmoPUJBE5MubMOuXGqecl4IFKdgGcC41MYAlxBe9vkX3kpHeT03Ocme17ZUd38k5IJahgu6tbPyFgK/Kv1jaWCL3KTN3RioYYgc0rQQILF0PESOOLZg=
X-Gm-Message-State: AOJu0YxVphPxEwLkWLmx1djG17WtFdMgsnmWPWz8g/sFu6M8vV6eylop
	Q2sG6jF+Pi4m2qpV5NrRJ9KPNYE/aCl7Qg4H+z4DY+pFDEmXUSuV
X-Google-Smtp-Source: AGHT+IHvk5WBJhdQvfPQj27osRuS4nNxP4VNndtdOFRqHSGbSaGTg8fwBOQCt4G7SehYlD0Tnj0p+g==
X-Received: by 2002:a5d:69c1:0:b0:33b:1126:7326 with SMTP id s1-20020a5d69c1000000b0033b11267326mr118212wrw.4.1706722973991;
        Wed, 31 Jan 2024 09:42:53 -0800 (PST)
Received: from [172.16.102.38] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id ay12-20020a5d6f0c000000b0033ad47d7b86sm14137987wrb.27.2024.01.31.09.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 09:42:53 -0800 (PST)
Message-ID: <a01a5a20-1dcc-4f90-9a72-29dc83d0d5f0@gmail.com>
Date: Wed, 31 Jan 2024 17:42:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ALSA: pcm: Add missing formats to formats list
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240125223522.1122765-1-ivan.orlov0322@gmail.com>
 <87wmrr2ca3.wl-tiwai@suse.de>
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <87wmrr2ca3.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/24 13:15, Takashi Iwai wrote:
> On Thu, 25 Jan 2024 23:35:19 +0100,
> Ivan Orlov wrote:
>>
>> Add 4 missing formats to 'snd_pcm_format_names' array in order to be
>> able to get their names with 'snd_pcm_format_name' function.
>>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> 
> Now applied all three patches.  This first one is to for-linus, while
> the rest two are to for-next for 6.9 kernel.
> 
> For further improvements (e.g. Amadeusz suggested), let's apply on top
> of that.
> 
> 
> thanks,
> 
> Takashi

Hi Takashi,

Thank you for applying this changes! I'll send the patch with the 
improvements suggested by Amadeusz as soon as possible.

-- 
Kind regards,
Ivan Orlov


