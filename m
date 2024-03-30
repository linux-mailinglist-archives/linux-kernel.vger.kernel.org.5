Return-Path: <linux-kernel+bounces-125599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC1B892962
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 05:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48A46B2286A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 04:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCC779FE;
	Sat, 30 Mar 2024 04:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="pn+I6jol"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B691628F8
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 04:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711773308; cv=none; b=CCSe0oHWmv/bIY76BdqVl3OvZNDzMz6gNteeT8Zok6Ig/WUnK3ah3Pzcs39ltASfbeBoklvz+MjedW5uf9iqhtH/P6Ph5OUz6S/BQZf6j9w5/v8GT4TeYSzsPV6x/cCHQ7Lv1gTIHkwwO0gvhe7aYKXKazxgxqByKIh/qXo9lq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711773308; c=relaxed/simple;
	bh=KESsGVL3oQ1Tct2/upTcGdKcslstjs6sa4QhcS3OUb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwRiFY0AI8LUeb6Smqf4KVfXfGAbjaCZnbM+3tLKCwpsWDX+abSiQiyJ7kH96ego740kNmqmmQyimsmYJ/cBudYJkO0hiCbmhW5YNEs8ktfHhevBnNpN3k8VDjwihX3XHaR3mmnAKbYe6a/3wuO+nENQrcibyvayAY9WCtLb0hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=none smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b=pn+I6jol; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3666affcb59so10052875ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 21:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1711773305; x=1712378105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+ftDv20t3wS0Lsp+7lIK+iX7cApQwfKmXsWpq65Q1o=;
        b=pn+I6jol3VZursntEQ0kfg6PNtqDv6fzj+HujyJXw4SONL9CJ8gmjf5w8hS3CnClhT
         DuzeWzSIsxxMGWdfMUdz6l5JsiZFoQEqJ1PlVCzm93VS0RqG7VrfwI4ers5ivM1b9BXp
         Xf5tGj7ewRfsCXl1Gx1bVFopbSDiMp8e0PApo3fFvZVe4OjiG1h7TqMt4uE0D9lZmEAt
         rhWvaKA/zeflu4PDRRLvLdpCdyD6xr8ZsppcsbivxCGvdqc8oTdHrsTUcI3zjYfrrAz3
         r2xzoN7xDymOxGcIEb9pMGf8GMNc2jlKA8huKEvvTgJN1spctAwIoFq7ypTMbJKcRCnq
         CjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711773305; x=1712378105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+ftDv20t3wS0Lsp+7lIK+iX7cApQwfKmXsWpq65Q1o=;
        b=im8hQJPcI3e4mgm7pcsQfliFz5wPoqj4A8uIEGMViU73AMZVpea6h+Dy++8XI+8t+d
         1RxoKe7jKcXBeUYHfh3UmKszs+p90tnEye1boohUIhxCPDjbTv2oyHlhy81DeLZBlLjN
         ENDmuQGPNWPs6SPI11/JgaSlEYcS6DMAa/ofM9TEmCE00EPbgs58dDF2PXZwyQ7KiZcN
         QsZWDX51wimOc+fwF+JzM0Qi8xn9YMGZh7VGID2LFy4Bfz1pFfRgi6uR3PpmzYzvG91s
         21jY3/FbeDUca9Z04ZbFHvDXTlYuP4ml3VJxOVr5Oc/EsIzhYmKD6ClCPUj8EYA2cHft
         oOIg==
X-Forwarded-Encrypted: i=1; AJvYcCUG0Vy1ww6jsdxJAefn+HumTBj9O8eWuIzFhKlckgeKkH3o/E0ZKKBLW2oDsxakGXUuIBwenhsy9HOtYD+gMDD98lkPK0xnZTvx8PCh
X-Gm-Message-State: AOJu0Yw58BD6eOm5G9WE9/RFxJlHpKlGTZ5Py7+6FjzL7zLkmiIZ1Zlq
	PwphHM7+pW0v91JWlFCLg3yZpELlPL11ky0yjUQY3Lu1fIAA14197dAgNeKWwpg=
X-Google-Smtp-Source: AGHT+IGVLCNwHHytCGoayaTDND3tvqRbKIuPONixjN7UAmpNoIbU9H30r7YohRTWJyBUdfew/qU6jQ==
X-Received: by 2002:a05:6e02:268a:b0:365:cd40:c1e7 with SMTP id bz10-20020a056e02268a00b00365cd40c1e7mr4188375ilb.11.1711773304829;
        Fri, 29 Mar 2024 21:35:04 -0700 (PDT)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id x4-20020a920604000000b003684edeba7esm1442888ilg.88.2024.03.29.21.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 21:35:04 -0700 (PDT)
Message-ID: <7b28fe62-a1e9-1359-72aa-1dc75409d118@landley.net>
Date: Fri, 29 Mar 2024 23:44:01 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] sh: j2: drop incorrect SPI controller max frequency
 property
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 devicetree@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kousik Sanagavarapu <five231003@gmail.com>
References: <20240322064221.25776-1-krzysztof.kozlowski@linaro.org>
From: Rob Landley <rob@landley.net>
In-Reply-To: <20240322064221.25776-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/24 01:42, Krzysztof Kozlowski wrote:
> The J2 SPI controller bindings never allowed spi-max-frequency property
> in the controller node.  Neither old spi-bus.txt bindings, nor new DT
> schema allows it.  Linux driver does not parse that property from
> controller node, thus drop it from DTS as incorrect hardware
> description.  The SPI child device has already the same property with
> the same value, so functionality should not be affected.
> 
> Cc: Kousik Sanagavarapu <five231003@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Tested-by: Rob Landley <rob@landley.net>

(By which I mean a 6.8 kernel with this patch applied booted to a shell prompt
on my J2 turtle board.)

Rob

