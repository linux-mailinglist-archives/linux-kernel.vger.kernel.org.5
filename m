Return-Path: <linux-kernel+bounces-153157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAD58ACA60
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB4E280DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EAA13E03D;
	Mon, 22 Apr 2024 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="APkK0V17"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF15131191
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780886; cv=none; b=g7apV8Cr7dcoFH8CaQvZfgGxSpR/O5LTAW3jtYCN8tA7HGLAQy64tAj/2ykTYRT1LkdcL0TZiUBmSecjAs4MtrxxV/Ws1nbsNi56JRbZgZ7fXSZLNyAv5ad8sZLt4VaMz/nurMg1ATP8ok30J9OS5+j8HpYpejc/vJSxl7QmCN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780886; c=relaxed/simple;
	bh=y1uyTZyZT7fmnmEaQccbReWvwF6AsXMce0Wrf+L9o1U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PU7uY5yOpFa+dzZqv6bFMZ7XlYxZP1FYFjI0kf/uErMbQwYYqdSrorlqLNct4GFppF5ydL1PWRi8Hsd8hC7zyZOLi6IT6JcA62ePi6LBfAt1La8RBaP2sxjUDqgJgDVIFFOTGX+aEpuNxkcPAFwiNJkvOhO2b/TGdMHjJoGzlko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=APkK0V17; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a4f291f80so6263355e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 03:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713780883; x=1714385683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z/jZRj0ApPmqFTPbrQgdn6ghlIFuc/SPp6X8dQcLFs8=;
        b=APkK0V17rQs3+jSw/2hPJZm1SPCexke798QnHlv0M4ZFQ3Q7HF1q9WQvXYJhA9/S8o
         BfhVzWRr20N6KbVDwNiE/SP9hLRb2Fh6E0DKHfGcJPz+hQAtb1FTIBYgIrDunZKHZ2gN
         C1DL0AugMOTN1EuOG/q9DtmVgTVqQaBFu+OnjmZT1X69Q/5xexecu0EJe83GFAppy9ip
         MXxXIgj9W6IuFW8wPDPNCFh4OU2K0n4mH20BDNfzTfv2WFbjRSNpRyO63DoZ4YOg/8DI
         GD4gR136KISqUXOBp58gmlVlRUeUnqCoM5CUVdBMW0xyEyniOAIUFFE3oVICAnEFpi9I
         uByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713780883; x=1714385683;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/jZRj0ApPmqFTPbrQgdn6ghlIFuc/SPp6X8dQcLFs8=;
        b=wh6QAba9qQEFJz7+wnlPnihtJAF1LlS41Jdt1+AarQJ51V3f+1U66UN3kg6vZl7578
         vWmJDFVTakqRrg6DdzJcT0JQkt2z/Q3ZV+eh8OdRl0+ficwuwsd+bgo6m9BrsQsnaM+E
         oCu04Onaez3DKA+kYvvQ/r+p4vKloXGOISrLh9BbhA5Rt5Ymn9LuGce9aIBo6mfP48xI
         Jx161ScPM3XwgL+S+iDaEhHuuEuKXrjaqg/0nR9fvTFsmcBcrIqd4lUWETcZ1FZW7eeQ
         ZWHME/PBEXy0+QvqD4iYT/uuR/sy5CrQEEYOzSYxnDhrANMVBG0gzy6gZxMvpR1fEvHv
         XbBA==
X-Forwarded-Encrypted: i=1; AJvYcCXz+//x7ikeEUzlF471oIzTWYyH1Tnf4J7YPGo65Enf2lKVj3ERaYllOcKSUSYnUrS5RgRsEIxMwxbKBaD3RPpjBTOXehI05Bs3Ne3B
X-Gm-Message-State: AOJu0YxJHxsaL8Lc07xzYOfH1wgY4+g0YObqpMu2rbh8oJ8eOBQH9BQt
	/fEGPVfWnmPrBYTvkl74GE/gwdrm3njSByIG+LmpwdhAzartOUk/ZJe6cxRV3SE=
X-Google-Smtp-Source: AGHT+IHetYw7932B5YL7ed8rYTbB4etGEW6Iq5lMrmBoLE8jUlzBGcgBZ9v5QparsTsNqbK8iQ1/ng==
X-Received: by 2002:a05:600c:c0e:b0:41a:7fc8:a650 with SMTP id fm14-20020a05600c0c0e00b0041a7fc8a650mr823046wmb.0.1713780882859;
        Mon, 22 Apr 2024 03:14:42 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.100])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c4f1000b0041a1fee2854sm5577618wmq.17.2024.04.22.03.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 03:14:42 -0700 (PDT)
Message-ID: <2ef19e86-d93b-4b3b-8f41-f96fb230d594@linaro.org>
Date: Mon, 22 Apr 2024 11:14:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] mtd: spi-nor: simplify spi_nor_get_flash_info()
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Ricardo Ribalda <ribalda@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20240419141249.609534-1-mwalle@kernel.org>
 <20240419141249.609534-6-mwalle@kernel.org>
 <ea3b32a8-7a1c-4a32-beb5-acc6f6435954@linaro.org>
 <D0QK66M6GGD7.2ESAAEDMDOUUO@kernel.org>
 <f3e8b15f-bc39-4fc9-81d4-fbebef74c145@linaro.org>
Content-Language: en-US
In-Reply-To: <f3e8b15f-bc39-4fc9-81d4-fbebef74c145@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/24 11:12, Tudor Ambarus wrote:
> 
> 
> On 4/22/24 10:53, Michael Walle wrote:
>> Hi,
>>
>>> 	if (name)
>>> 		info = spi_nor_match_name(nor, name);
>>>
>>> 	if (!info || info->id) {
> 
> here
> 
>>> 		jinfo = spi_nor_detect(nor);
>>> 		if (IS_ERR(jinfo))
>>> 			return jinfo;
>>> 		
>>> 		if (jinfo != info)
>>
>> info could be NULL here. So "info &&", apart from that looks good.
> 
> it can't be NULL, the parent if indicated above assures info isn't NULL

ah, I read it wrong it's if (!info), you're right!

> 
>>
>>> 			dev_warn(();
>>> 		info = jinfo;
>>> 	}
>>
>> Pratyush, should I'll drop your Rb tag then.
>>
>> -michael

