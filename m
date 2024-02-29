Return-Path: <linux-kernel+bounces-87156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA0A86D060
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C888B23A16
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FE76CC0A;
	Thu, 29 Feb 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WCoLnECL"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211CC383BB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227182; cv=none; b=R+D86E0MDrAkUfvKRvz/5Xfa0Hp7xg5zpBRlIytwU12nIJpVb6jSsdz3408TBaUfDLOQdLJ611zdnyg0/Sh97+MJwRRuonau+WVt//rYJs7/ppGWPKnbSg9ag3Km1Po499FAqXTBiUqXKKxUaHh1iZWSTQ6rq3zu2S2gjDuqOHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227182; c=relaxed/simple;
	bh=6+rl/GJVImeAP5L4FgFElC4Bja1VWI5nUPej4fO1So4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bY2MM8aM2OBly8Z/Q4K4Ct3UAoHRyuISflat2bzCCiiJQj2Pn/AqXnpOT+FcAO202/gtoRMGiKFdAYNughU7DjJ5bsn/Pdkzf4nXkSF7W8EMAKvHMiHOOqGiXobGPvx1RwvdfxGTgdx4jG6U6Yb3EsLvcC4GYGgtkDtyF5Z4/wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WCoLnECL; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3651ee59db4so1303405ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709227178; x=1709831978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nOgy56I4Hpij+0HEOIiQF0kFHBK0lqM4qJcV/nWXy5g=;
        b=WCoLnECLH1NUbvB9TmZacgdLottY0zEYjRkNh4TG0QlMKaCcfQeHpTOnRZeSHcXfLA
         vveDG5kI/2k4E+4QCddNBTCbi8P9RlRFOxUBmbeC6Yb8blV4VASrdMe0y3POiTCCyWYj
         ZXOdHcFYW4dsTeft1IuPbt125yN0YW7in6WADsLaYJYsex+qkEev+RFPTfPE2VKGSCMj
         PCQEoxzHjE1GfBGr3rqdWOPwrE0KqZDdzSskFapLBGLCc539wsa8/H7AUyh//7Z5SRKl
         sriXyxErrERkv8edUVAoc5h5mKsJwyuonyUA6wIe2IwPjx09TrHiqtET7w1fz87b4Grd
         sSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709227178; x=1709831978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOgy56I4Hpij+0HEOIiQF0kFHBK0lqM4qJcV/nWXy5g=;
        b=uGmKbfTKgfJCCV/YnJZeR1Ia8E5YIMyD+OqRvcMJcYQSX9wA6OTXMGXKmyQc1dIpK2
         xb7aGCqn0ywKsKWZCitsbDZpoLSl91G5OY4xlQ9xWx2RlkONqcxxYdlHY2gn/07n1C7G
         Gb3vUxp7HyPZK+EtLim+ISG2Dv625IZ003o1Qp21YLQo2xfGvzaFhitpG8KasSOFcvj1
         xcY4NvfRBA9+pUgT/odg3N9qer40mDUb2V0gBPdQd5MCSpWdb2pfQflQK8oo+8VIRY1S
         CsYMJyzhV4AzDRQq3ke2kJzi6cEWOeJZ1Ol2CyVi/IWuCm0tw4te/vXx18yV3/7tY1j8
         8ANA==
X-Forwarded-Encrypted: i=1; AJvYcCWDDOO1Ahyw4xBRxngok6ErtdJChPlk3QyuOjY+GaWkMLwx2g1jgRSt7BTKmmyLeUlmLU3WD0ZKA3s4kZljaJPyIug/haJBdyrxNmS9
X-Gm-Message-State: AOJu0YzFx/GGkTjWE0IJpmuaZv23M6GjXLJcGF4FBOkEJFLIZgaMzWFG
	f1NPqMOPASmOOxC+OPE6DDHWc0uok5ReekhEVpjBhdqIMG89bX1XQivXST4+f8Q=
X-Google-Smtp-Source: AGHT+IGKS/vzutMl+3Z3yfI9+PyG1fFtEDiGpu7nqJq12sQy7kqUUVuEOO2U3Bz+ISy7w+atkzDp5g==
X-Received: by 2002:a05:6602:2561:b0:7c7:b54b:19b0 with SMTP id dj1-20020a056602256100b007c7b54b19b0mr2982780iob.0.1709227178021;
        Thu, 29 Feb 2024 09:19:38 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z11-20020a056638000b00b00472d64a444csm405509jao.62.2024.02.29.09.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:19:37 -0800 (PST)
Message-ID: <c3abe716-3d8f-47dc-9c7d-203b05b25393@kernel.dk>
Date: Thu, 29 Feb 2024 10:19:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/core: switch struct rq->nr_iowait to a normal
 int
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com
References: <20240228192355.290114-1-axboe@kernel.dk>
 <20240228192355.290114-2-axboe@kernel.dk> <8734tb8b57.ffs@tglx>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8734tb8b57.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/29/24 9:53 AM, Thomas Gleixner wrote:
> On Wed, Feb 28 2024 at 12:16, Jens Axboe wrote:
>> In 3 of the 4 spots where we modify rq->nr_iowait we already hold the
> 
> We modify something and hold locks? It's documented that changelogs
> should not impersonate code. It simply does not make any sense.

Agree it doesn't read that well... It's meant to say that we already
hold the rq lock in 3 of the 4 spots, hence using atomic_inc/dec is
pointless for those cases.

> Other than that:
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks for the review!

-- 
Jens Axboe


