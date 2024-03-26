Return-Path: <linux-kernel+bounces-118344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5385688B8CE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099691F6100F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6416C129E88;
	Tue, 26 Mar 2024 03:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vdbvphlI"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372C4128801
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711424371; cv=none; b=MgldM0o5ZcZ/6XZISWsvSa6BVlIHW/zbyg+nmDC+vNADqPTo/FBARdMgPimIiXW+4NRRRmMtBF7S84kB1clTDZMEul373dcavV/kA5qNwVKd2q7QcAQdgy4CYth2/w/NoNSYaZUSkk/n0btVjJf9UJq+BVPsknpYBFrGE2S5kF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711424371; c=relaxed/simple;
	bh=uLOGpXy3TAm8xxYZtqs8rVS5uFMWT04mTqs9ZngYo1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GvFYeGEEp97c1G1VTXiwwQDaaz3q+e9m51Qf3cK8Ddk79YxKDkhWRPlaN6Pivf81zrJPE7A6fAxd9DV1sprrmkuQqzl5H8L31NOY0wnb5k5O5hPDENfIMbmowdkI5Z9VhLlZm4+Ae5IdXX74yo0ke1ldH7y5m5dFvs4oXuZ+oLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vdbvphlI; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a46b30857bso1250309eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711424368; x=1712029168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aYyWwyq5NdihiY0183Y4ocBSorvsV4N+BBq9vl7LYDQ=;
        b=vdbvphlIwlAg9HK0XXsLXppedzTrJW9OVl8mAKYqyD9j1lPQdeF0/ZzXT4VHR22Mx5
         abLyulArPJE0oJk/rjdDIZqtfQadEtUDBL+1evKs8vOUI7T2gPSJTcV5/ALdfOKIq9ue
         MTjTG2yrsQQ010jdDp0GI+46VOgYbtyojn/Q+p/Gws3GFfzJmDpbKNzuDABT+lzKsSVq
         z5ts63mGgyN5pT6RDuqKxTA4j47Gwiu4ck4Mbxll6hl3qaxf6kmvlSC1Gie3O06/x0Qp
         ugJ9JPh+d3UkdiUG7qLTqUGStw9wNWfyxXe8H9gaxitfFvwYbtZeyfEqsgn1oboeQ6zx
         rQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711424368; x=1712029168;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYyWwyq5NdihiY0183Y4ocBSorvsV4N+BBq9vl7LYDQ=;
        b=OrbncEN2riNtlPmUITVksVYg0Rlq7sneauko1ai0p/O/W3WM++FZJk3Vbgs3xbFFoU
         B77tu/3iu7Znmcw47dXuVyTGJvNNqg/g8fGITb6jYroccfI8CjGBhmAIEPBtwR6VDSBW
         mSMwk0fPmiqyVGINlrDaBSrhcUu/dwn61wVCHlvaEFhC6dZTd/eWh+OJwTAD3V4nOuE/
         fH9s/mbnAPBWch22xbnH5iq3V3vLSGDHq+5+SDpTWUZeR9oMlpxmgIGVj1iCaCIF/BTJ
         /8dZMiLALrvmFtTuqB6r2z7eVnkKPCfUVaeYqB/Uexyet+M+FPJpmyX6B8KmkQVc64J9
         Ltzg==
X-Forwarded-Encrypted: i=1; AJvYcCUr+8tUmwXmem/zJlnO1Sw6JphOGcOjgbM/Va24eF2wVXuGrmTrBQD0LMyvgJvdGV2NFmiKoFvvtx88H5qJzaF66tW+nsfixkpD/VSb
X-Gm-Message-State: AOJu0YxMPe7KLsB1tUi4+yFazowzyKEZLYjvp90gn1Cn0e75/25RmDv2
	vvp1dPN+FXlll8TUzzWMeOx4f/PHlXAyu0m45VVDszTUMOgUQzjikEAjHo6eZVg=
X-Google-Smtp-Source: AGHT+IElFKMAHk+SOA6w9kBY0nmgmx2P2dLSXK7tM7Mw9hlbm3C7RcjZHbgY1CFKwd2m+Z5N0UwVTA==
X-Received: by 2002:a05:6808:21a9:b0:3c3:be3e:aaa6 with SMTP id be41-20020a05680821a900b003c3be3eaaa6mr11077672oib.0.1711424367798;
        Mon, 25 Mar 2024 20:39:27 -0700 (PDT)
Received: from [192.168.201.244] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id ka5-20020a056a00938500b006eab499fb50sm1053889pfb.128.2024.03.25.20.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 20:39:27 -0700 (PDT)
Message-ID: <f7f547aa-998f-4e9f-89e1-1b10f83912d6@kernel.dk>
Date: Mon, 25 Mar 2024 21:39:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: io_uring: releasing CPU resources when polling
Content-Language: en-US
To: Xue <xue01.he@samsung.com>
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, peiwei.li@samsung.com, joshi.k@samsung.com,
 kundan.kumar@samsung.com, anuj20.g@samsung.com, wenwen.chen@samsung.com,
 ruyi.zhang@samsung.com, xiaobing.li@samsung.com, cliang01.li@samsung.com
References: <20240318090017.3959252-1-xue01.he@samsung.com>
 <CGME20240326032337epcas5p4d4725729834e3fdb006293d1aab4053d@epcas5p4.samsung.com>
 <20240326032331.1003213-1-xue01.he@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240326032331.1003213-1-xue01.he@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/24 9:23 PM, Xue wrote:
> Hi,
> 
> I hope this message finds you well.
> 
> I'm waiting to follow up on the patch I submitted on 3.18,
> titled "io_uring: releasing CPU resources when polling".
> 
> I haven't received feedback yet and wondering if you had
> a chance to look at it. Any guidance or suggestions you could
> provide would be greatly appreciated.

I did take a look at it, and I have to be honest - I don't like it at
all. It's a lot of expensive code in the fast path, for a problem that
should not really exist. The system is misconfigured if you're doing
polled IO for devices that don't have a poll queue. At some point the
block layer returned -EOPNOTSUPP for that, and honestly I think that's a
MUCH better solution than adding expensive code in the fast path for
something that is really a badly configured setup.

-- 
Jens Axboe


