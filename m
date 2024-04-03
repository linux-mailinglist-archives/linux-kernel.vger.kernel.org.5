Return-Path: <linux-kernel+bounces-130412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD09B8977BB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095E91C2122A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11B71534F2;
	Wed,  3 Apr 2024 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCduND7N"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A6B433CB;
	Wed,  3 Apr 2024 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167408; cv=none; b=ozhraiIgl/tI/t6+p6x2iSYp1r/T68Iqopuv9qmKh4I6s/C4gOnUtY+nyWGe6mr/fJ3M1hfI/rPoqzGksTr5X5KvWliFd3yCMjPmz78aaj/e4g6ZUuaD9jz2pSNyhir/Z52yO27ZzKjUzkSfszBBT6DeJevTob+irE028KgD3tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167408; c=relaxed/simple;
	bh=ylgZVFHrWdJiZJ1iW6APhUGogXswDFL7SuFFgkc0/po=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S6oII9Ht/6FMcTQFv81c9TOfD9oLp/N6hEQg7CRJ9tTXP+BcSvREv4DJUFICV5wwq/Ot0R5TZ21CyU2xUxFGCDp37aBmwB8ljsKfPOwM4AL1dfM1HeBxNgVuTk/kBhu7WJ6Ivw4kB76gNl6QtHyD8yhA65rt7ajgvOKzCJY7ufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCduND7N; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516bfcc76efso125269e87.3;
        Wed, 03 Apr 2024 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712167405; x=1712772205; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=A/GPjX1bC89s3pKDiOr4iTqFW1vCdSA+wrVsNDwDxNc=;
        b=cCduND7NgACZ0ze8ImTboEr7cuZryMcm+322JUUsheQtTFFZejrB46risqOE5THJIr
         Db+1EryOK1jDIgD67bml+433itbZTUh1OTUlC8E2guzrY6tEPHsvWV0NLP6fQECplehw
         NZcVMoPKXHrWnjKhXDIt+azNS0mcfftrbPSde6+TWaTiQwp2gviKPDwpL9M5QPZQPGAu
         A4jesV50b+lB/o602n0ffxfanQP+lxwB72pjewq+dJrCOxYokioAPEwPimpgoS9L02Fp
         f1vnt1dsPSR9EMABGdpwPm83w7QtCp8OD3COe751PiS+R5coOGyC7IwtNTvejfBgmBhq
         6HIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712167405; x=1712772205;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/GPjX1bC89s3pKDiOr4iTqFW1vCdSA+wrVsNDwDxNc=;
        b=e1LFMymJmMROEDYL+o8c7H34Hf2IXEwlITcoelNwgNB3n6E6pA7MupwG41tQSBzwDl
         JjS6FHhnP55F2c2ktdDkwn1lFno+mLV5j2gctS2p+ZGb+ogFL/zN5MrcF3clY6SXvG94
         6k+uwfADqRpQlJa9dEwODYdRRLwzvMKcfLBIh+YLsM98JS2GlH3ROw2OfUY1LMwpmFR8
         6p0+p739u2UZ2b28+owtD5Mn9IdfGbCTpKjFMx+IR3PSMEVUfsMNZuyNaxAJgEWjmdbP
         K29BqvPbFDIrFaab6WlHDQbEbJa+1ZU1CSqk9GdMJS1jJFX5eBM4gfOdRJ0klhwarZxK
         Fnwg==
X-Forwarded-Encrypted: i=1; AJvYcCUptbj1O9H+PRsjFzdvP92OaTmMzyg5dE18DuXY5/0Kb/+gb/zzhfBHsQdBFq+ujrxWCmzCDHkmU9mz+g1P+UE9Yt/VZ2BfRU8sbmI1VNcXMDdLhW28Lzrf1QY+LPJ3an7mFy9f
X-Gm-Message-State: AOJu0YwWvXZC0a2JHOFEgbj4qGhWqgr7ZPZR/BNi4U0IASkSx9TMBcHo
	NmKibtfbXgAqBpwbiRAE9ELI6t8WMbRIXgcUZdE5CqPmWR1/rRwh
X-Google-Smtp-Source: AGHT+IEyRUvecg0QN9/sEZf6ib0h8zoehWz/cWHULxKPtojfgajVSxFN5JsBkLEueNTDZDaVhyCn2w==
X-Received: by 2002:a05:6512:20a:b0:515:bf94:cd38 with SMTP id a10-20020a056512020a00b00515bf94cd38mr153383lfo.36.1712167404358;
        Wed, 03 Apr 2024 11:03:24 -0700 (PDT)
Received: from localhost (c90-143-176-166.bredband.tele2.se. [90.143.176.166])
        by smtp.gmail.com with ESMTPSA id bi15-20020a0565120e8f00b005159412ab81sm2092597lfb.216.2024.04.03.11.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 11:03:23 -0700 (PDT)
From: Casper Andersson <casper.casan@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Paolo Abeni <pabeni@redhat.com>, Ravi
 Gunasekaran <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>,
 Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Murali Karicheri
 <m-karicheri2@ti.com>, Jiri Pirko <jiri@resnulli.us>, Dan Carpenter
 <dan.carpenter@linaro.org>, Ziyang Xuan <william.xuanziyang@huawei.com>,
 Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v4] net: hsr: Provide RedBox support (HSR-SAN)
In-Reply-To: <20240402085850.229058-1-lukma@denx.de>
References: <20240402085850.229058-1-lukma@denx.de>
Date: Wed, 03 Apr 2024 20:03:22 +0200
Message-ID: <86v84yfhn9.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi,

Out of curiosity, are you planning to implement the remaining RedBox
modes too (PRP-SAN, HSR-HSR, HSR-PRP)?

On 2024-04-02 10:58 +0200, Lukasz Majewski wrote:
> Changes for v3:
>
> - Modify frame passed Port C (Interlink) to have RedBox's source address (SA)
>   This fixes issue with connecting L2 switch to Interlink Port as switches
>   drop frames with SA other than one registered in their (internal) routing
>   tables.

> +	/* When HSR node is used as RedBox - the frame received from HSR ring
> +	 * requires source MAC address (SA) replacement to one which can be
> +	 * recognized by SAN devices (otherwise, frames are dropped by switch)
> +	 */
> +	if (port->type == HSR_PT_INTERLINK)
> +		ether_addr_copy(eth_hdr(skb)->h_source,
> +				port->hsr->macaddress_redbox);

I'm not really understanding the reason for this change. Can you explain
it in more detail? The standard does not say to modify the SA. However,
it also does not say to *not* modify it in HSR-SAN mode like it does in
other places. In HSR-HSR and HSR-PRP mode modifying SA breaks the
duplicate discard. So keeping the same behavior for all modes would be
ideal.

I imagine any HW offloaded solutions will not modify the SA, so if
possible the SW should also behave as such.

BR,
Casper

