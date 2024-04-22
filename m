Return-Path: <linux-kernel+bounces-153156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8EA8ACA5C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FD51C20B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4357E13E037;
	Mon, 22 Apr 2024 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HbvQ6wFK"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184D783CDF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780730; cv=none; b=qd80ET5qoW3nLxoTdnTt8uOhLhrKycbMlvH5ndJk8gWV4Y6eu5yL2LLTf8WxjIiD54tMU31GDKVgnbWcAqgHUF5hScLXnOoa2YkuuIMTlAE1AVZFMXJxodY7aXIaOLCdOw+LvbbgW0vVSoLCfmud4iOc4HWbBxHE3B+AWBBoAQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780730; c=relaxed/simple;
	bh=UQBdkNqpZFefi/RhzpFWxjHspNLPA3qwhlzro7wf3zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J92hJEna6+vhNi+BD8LcyklOITIfyTjzFQmoyTRANLCE4puzGHYs9EBYwhHks5sMHuS8fY+FftNyJNt4Qzvzm7qhoO+9G0MQBNplKS6+7S1OA3y+8W9/yU8PQVBFqPp5ZwDI8Eso8KL0vts0BjdF+kCKLRU55lJwTIV4L40Ktwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HbvQ6wFK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-419fc79e4dcso8672915e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 03:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713780727; x=1714385527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=15JM2M/xqlCzHoodyQ630yrxmvJgVvqpmySiVd+V/Fk=;
        b=HbvQ6wFK/xEir/GuSu8sLQYpCfHSRVNjQJ+uYB2ieYEkxJKQqZwbjZaZSyvgjmRdFb
         MFcZVpTcPrmBoM97g7Sez41L7KHkFyyPAets2TYuZQrrmlUIS9BHKWIo7SpfUYykABTo
         Ibv9qx0/OmSUfipS/zoHC9KUnjNWmY9JVGSdfJe+J0i5AxkhmkV34KCe2Y05L+3CpmTP
         UltYx7uPWmPEY1+7F9Nlc8T5OA/EIDF6NWHO4tVWJm5fKGFrXlmC3AaMJLrds9kIIEeK
         y5+wyHSugqxs+lL2LVLBw+Vuqmb8CHTnKEs1Q35Vgp9fa0p/LyBTyD4qhvsd1xXg535k
         Edqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713780727; x=1714385527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15JM2M/xqlCzHoodyQ630yrxmvJgVvqpmySiVd+V/Fk=;
        b=t/ANL0STCyCvXF5pZ88bKaSsvQ/bj0+XGzB5BnFBkVGSjaEg49JAGwpFclZxnqEUSt
         /v+zxuSufiAzU340nK3y+ku9ZV0AkznbMt2w4cgkoPs66hPHQNyub3HghBmMz59+Py0m
         d9HmPrRhHL7w+cDCjIuu9ZLOk5SojjbPfnsZu6BJTUKB37Qi4WKCBcdizRVtwUK4sfU9
         LXYrKj1f1RBVu/z6Mlm70ltGJmzMc02dVvtnaqUxuUABf6f/xh3cKc0Jq0lnfJ4sxRnp
         LIDoXh1YCGHMKjkNe7uuCnQrzcoErAz+vbnRgWOXY9seABRsCEvSTWvwn2TUbdGjhis4
         v0Xw==
X-Forwarded-Encrypted: i=1; AJvYcCW0Bzauu+kTeHCS1+7ZInjW9XRo4d74tcZ8QHOkjl8Yc2twWp6widVMhu/jOjeBshSXVPqgS/fwUh5/pUlu8IINn1OPzZNOnNqjw35i
X-Gm-Message-State: AOJu0YyMcXmWMICxfrYWcxIKILLDnMGfwl2zdSO/dfsl6h2HjBj+1R3H
	CgtfY44n8GQCdH4ic9UqouSn1zICrESSP2FB2DvodVe/lPONUCWBpArBN2z1l18=
X-Google-Smtp-Source: AGHT+IGlxfUD/9upZ3EyuURAuTDTjlpfJAidPtl7Th74AJneff1eN1nJHe3LNgaT13H4lkg1l1pYqA==
X-Received: by 2002:a05:600c:3d16:b0:41a:3407:78e5 with SMTP id bh22-20020a05600c3d1600b0041a340778e5mr2410887wmb.12.1713780727484;
        Mon, 22 Apr 2024 03:12:07 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.100])
        by smtp.gmail.com with ESMTPSA id fj3-20020a05600c0c8300b00416b2cbad06sm20011653wmb.41.2024.04.22.03.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 03:12:07 -0700 (PDT)
Message-ID: <f3e8b15f-bc39-4fc9-81d4-fbebef74c145@linaro.org>
Date: Mon, 22 Apr 2024 11:12:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] mtd: spi-nor: simplify spi_nor_get_flash_info()
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Ricardo Ribalda <ribalda@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20240419141249.609534-1-mwalle@kernel.org>
 <20240419141249.609534-6-mwalle@kernel.org>
 <ea3b32a8-7a1c-4a32-beb5-acc6f6435954@linaro.org>
 <D0QK66M6GGD7.2ESAAEDMDOUUO@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <D0QK66M6GGD7.2ESAAEDMDOUUO@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/24 10:53, Michael Walle wrote:
> Hi,
> 
>> 	if (name)
>> 		info = spi_nor_match_name(nor, name);
>>
>> 	if (!info || info->id) {

here

>> 		jinfo = spi_nor_detect(nor);
>> 		if (IS_ERR(jinfo))
>> 			return jinfo;
>> 		
>> 		if (jinfo != info)
> 
> info could be NULL here. So "info &&", apart from that looks good.

it can't be NULL, the parent if indicated above assures info isn't NULL

> 
>> 			dev_warn(();
>> 		info = jinfo;
>> 	}
> 
> Pratyush, should I'll drop your Rb tag then.
> 
> -michael

