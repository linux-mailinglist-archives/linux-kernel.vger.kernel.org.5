Return-Path: <linux-kernel+bounces-88817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA5286E719
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A494286A10
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF46C8BE3;
	Fri,  1 Mar 2024 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LOsV90QX"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B172EDB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313810; cv=none; b=UFIgAAJBHzbAm9QETxRRhfl3GoWtwjCvBW05rYlPUJ8d0Egs1F4wUuZeHJg7AJDo2I21cUvU7/PBDIOwPbxN5BHlwP5XOEbph/Rm3X/XAgaASSJpaDX9U64dM1a5zSNp+7jo19YQTCYF+ag8xUYx2Z0A9x09zKp7PZJnnnnJxPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313810; c=relaxed/simple;
	bh=ZB41xxYjV5A+nWYJEkfqZuC83VuREIATmp7V3mKC6cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YaJrCSiUG1CQcoQ3JiWq06KtpkKwy5MZe7wDNhWt9uRgh+GJPB4evfxtKJLeLnBv+pB4zrBs0kThm9sfxb3onl8CPb8x3FVQJKnLW8S1FnHECyeuZ/X8bBy/OuNrcGHT1EhlfJfmUJIvZkou0KBOsEFwTxk8NVvRbKeAU/A7194=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LOsV90QX; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60858cfbc98so1201247b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 09:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709313805; x=1709918605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GesJ1JUX6AzHnSVJK5O06OdbpXZSjoyV0Rx4Wyc+lJI=;
        b=LOsV90QXYpin+VPG0pmevGnHUUBTbM+T+45KAW1yzZtty4D3qiQ20d0El2JQbvh3hA
         qKZVoJhOL6t/pr5sWGNhwoWSY8i2jmx2I2LEmqY8334hemy5P++50GqdptEbSJbeGkT5
         D2LlufmFSMMy1aHrTczigrjSyNl9+xYX7z3dGesAJkzDf723Zo72G3vOlZB0Ysufsr1k
         XoC+kd8D5A/XdyA4ffQiFNNKHea68XL+wgyswp+vjID/yfisJwq65reSyEg0MtubB5Cq
         UX+VXS+dlKEJ+EpHQJVoq7ZWPsuPFDa0D97IYP2OYQRaFSfhiub2v3yhWST6jigtIb6R
         9vZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709313805; x=1709918605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GesJ1JUX6AzHnSVJK5O06OdbpXZSjoyV0Rx4Wyc+lJI=;
        b=jBVUiCnBzRqN7gdtnQwUwyNuFWAw84FKtPv1GQ2Ka1m/KAWiwxvJWzF/tQ30WnM/Vv
         l7xWRi3cyYxbUgApW1ewRLCjL2g/eLO+bTKN3H9SpmQCkt9oDKoyjHpkDunoAUWdZd/P
         TbQBILljHEYBtnVAFd6NkLgsMiwFVaieL9HQhiDjZeqrC96mUqAND8EHB/PgZQtzMhjK
         KrADhAuDRZE/ZEyGmwpwEcpZ+9jqZKZnV9c9yiU85AAwlQONPeBiS1LsZecggBnG8QsB
         18izwNIrr7+a2w101d0iO4r6sxpMZo2QTsG8uNzI+96692HoTFKg+0nZtu/yFEV4X+N1
         lfbw==
X-Forwarded-Encrypted: i=1; AJvYcCVNYjDC+omkkTbgpz07QUYCrCLF2oqOwonY1ZY6VD1Vad6iMo7qy6j+XoeGNt/Z0NI1oUsAh89x3z1YDkUd9MTIrNKLK5HNsh25heSQ
X-Gm-Message-State: AOJu0YwBlyoDkJ8eYb/GERjl6jrWMvR1dt/JJCWiOnbXxIWwSTDgQJp7
	Kbc33dW++7DEYqPS7DgTNxADRGFfxsMQnBt/V8J7cSq8/m/O9Htlg37G7wk921o=
X-Google-Smtp-Source: AGHT+IGC0G34ue7Mz6Bxa2+Ac9u3TgFULDTUIHDsYIc8Bej77mS7rq/TVrjQa3q10GvBOOUZsbMEmQ==
X-Received: by 2002:a0d:e248:0:b0:609:722b:1bec with SMTP id l69-20020a0de248000000b00609722b1becmr2246600ywe.1.1709313805287;
        Fri, 01 Mar 2024 09:23:25 -0800 (PST)
Received: from ?IPV6:2600:380:9d78:b2ac:81c:a8a9:d9d1:d5ee? ([2600:380:9d78:b2ac:81c:a8a9:d9d1:d5ee])
        by smtp.gmail.com with ESMTPSA id x2-20020a81b042000000b0060987e4cdfdsm239325ywk.117.2024.03.01.09.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 09:23:24 -0800 (PST)
Message-ID: <8d04d4e7-5d89-4ec4-8069-2b38ab350741@kernel.dk>
Date: Fri, 1 Mar 2024 10:23:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] io_uring/net: remove unnecessary check
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <7f5d7887-f76e-4e68-98c2-894bfedbf292@moroto.mountain>
 <3d17a814-2300-4902-8b2c-2a73c0e9bfc4@moroto.mountain>
 <da610465-d1ee-42b2-9f8d-099ed3c39e51@moroto.mountain>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <da610465-d1ee-42b2-9f8d-099ed3c39e51@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/1/24 9:56 AM, Dan Carpenter wrote:
> On Fri, Mar 01, 2024 at 06:29:52PM +0300, Dan Carpenter wrote:
>> "namelen" is type size_t so it can't be negative.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>> ---
> 
> Jens applied Muhammad's patch so this part isn't required any more (and
> would introduce a bug if it were).

Yeah good point - thanks, I've dropped it.

-- 
Jens Axboe



