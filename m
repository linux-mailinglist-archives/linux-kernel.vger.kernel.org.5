Return-Path: <linux-kernel+bounces-162363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852FD8B59D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AA328AECA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B9B6CDBC;
	Mon, 29 Apr 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwR95npn"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D5D42055;
	Mon, 29 Apr 2024 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397133; cv=none; b=q4vL3R/pa0e0L3TX6s0i2f3BXAOC+pzookvZ9dwqub6EbBkQF9FDPkPrerv1RS8gmiNnoQjnjFmOk52SeD++L/jUwDVaX25YoD6eELXYF0WBKFW58wteKBJ03vbshOBQIhyBe5n/aGYW54BIKALyUS5uKy8UtuRcM5DATaFKqD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397133; c=relaxed/simple;
	bh=OkGqsz24HaQ8U2SLy0X0H8hrrM/zi1dkI/vFgwhn/uQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gyIxuStPRn8rtoQhwLT9uqKE9DN5rbSdgTmghsODoGWdGYRRTU/aE8/gvA0SVQDUNNDaJL2O4H/ug+3eqrxrKYAjKFshJ0ww1mnfqHxZXclAfxbEZCnAq1khoRQ8i3+Txe1qLOtR7AlfZdHPulruJm/Fiat6AwNuafD8oWpRXt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwR95npn; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-790fb2b780dso55842285a.0;
        Mon, 29 Apr 2024 06:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714397130; x=1715001930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cRqB/pgj2GzUQ8QqpEYAm3EnSOnu+i1KftcUkQHuOo=;
        b=iwR95npnDYmpwzLAl04pqLIlzIzGY/St+actfwN1a0fBtKHZ/oq5D1tBhxM0xH2381
         NniEltmADqe82W4+rTxD+CtWD07HGNJUFm2b5Wv4U+w1/zp4gHUCG+y37TungxyjdiCy
         G0Wx6Dj07szgivNi1JpX16tMFHyRAzhoNqj8usq9ybouOAJfU1Aff8q2OgiW9GKA7qj3
         xHBxJnySP3+lnoCg1ra0cy6HTA9u1vRrENECtXWwrfjHzlDFtLa5Vxed3B6DQupu2hET
         NiNql8LLvb6ILD+aXx1cpBF9BKvsUwpR7ZExKBKIwrB6/LF10eQ1s5wQW/y0Qp260WEx
         glPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397130; x=1715001930;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1cRqB/pgj2GzUQ8QqpEYAm3EnSOnu+i1KftcUkQHuOo=;
        b=uiE41OdtNrLI6gkF2uKCgvkEctRCWevw4maDVE1M2nvDbWjOJj5sFWk9Bp7bNlosBA
         vY9+ibL2yKnSpAwOCfMKCf2yBNAEuRTeY57hXm8MOHW6AuaYMNBrEbq0Tw7B02hhmJov
         E0B8AammkLfpVz6FnqCfxYwuUyJmHx4F2qbTxIiaE65EMU8K9sz/zHh/1D2+SEj0aZJs
         NZycpmyfG/oahuB4teFO73Rv1FduvWaCxOUVsP6oM3Tr/SROSUs+E8PR756gx5hpzrYz
         Py/NnXJ94REs0JNkqhbhfm/y8ZJiiF1dWY9cRB0lsoGI+bNu7KsG2ezu2yUboZrVC4dI
         Cwiw==
X-Forwarded-Encrypted: i=1; AJvYcCVwSHjYTOLsHsWoDeeEvxbOXppqIJ+6owRRSaV6sZlj6dSTHp7+vpBggZmjP2LmbRygnWOrbtmhugBK4973CO1xh4JiF7VF
X-Gm-Message-State: AOJu0YytWtgvQI5afhEOuF4oo7FGSBswtOsbq9yZeLbwAh8wp856j+Uc
	eZJy7HWILjYGTdrhQEiGu5TpaY8LmJoZZeDfNWSmz8Z/UtrahGx0
X-Google-Smtp-Source: AGHT+IG9x6Gj2FQJ7A+ca3azZZYIXGA4pH/chdp4e42edoCOV+sYv8S45PCZtvS+Q0OSVBRLf1DUYg==
X-Received: by 2002:a05:620a:1a28:b0:790:f03a:243f with SMTP id bk40-20020a05620a1a2800b00790f03a243fmr4628229qkb.46.1714397130011;
        Mon, 29 Apr 2024 06:25:30 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id de28-20020a05620a371c00b0078d6b2b6fdbsm10352985qkb.133.2024.04.29.06.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:25:29 -0700 (PDT)
Date: Mon, 29 Apr 2024 09:25:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: shiming.cheng@mediatek.com, 
 willemdebruijn.kernel@gmail.com, 
 edumazet@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 matthias.bgg@gmail.com
Cc: linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 shiming.cheng@mediatek.com, 
 Lena Wang <lena.wang@mediatek.com>
Message-ID: <662f9fc92a908_2e2f1d294c2@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240428143010.18719-1-shiming.cheng@mediatek.com>
References: <20240428143010.18719-1-shiming.cheng@mediatek.com>
Subject: Re: [PATCH net] net: drop pulled SKB_GSO_FRAGLIST skb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

shiming.cheng@ wrote:
> From: Shiming Cheng <shiming.cheng@mediatek.com>
> 
> A SKB_GSO_FRAGLIST skb without GSO_BY_FRAGS is
> expected to have all segments except the last
> to be gso_size long. If this does not hold, the
> skb has been modified and the fraglist gso integrity
> is lost. Drop the packet, as it cannot be segmented
> correctly by skb_segment_list.
> 
> The skb could be salvaged. By linearizing, dropping
> the SKB_GSO_FRAGLIST bit and entering the normal
> skb_segment path rather than the skb_segment_list path.
> 
> That choice is currently made in the protocol caller,
> __udp_gso_segment. It's not trivial to add such a
> backup path here. So let's add this backstop against
> kernel crashes.
> 
> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> Signed-off-by: Lena Wang <lena.wang@mediatek.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

