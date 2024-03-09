Return-Path: <linux-kernel+bounces-97942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59403877200
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CCC281B1E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCC6446D1;
	Sat,  9 Mar 2024 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mrLTnH+h"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9215440873
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709998921; cv=none; b=AndA+BTC6kq05J3toDRxDJvKcbND8oSIBIqQ4buo/Dba1wQvPx8yVr0l3MN1/4I1k9vJ6EjJROgyhpv8N50dq86TliHPWl8Yp8frn7BLT1EORjlQdqvjjkjC6/0V7U92PctQnWls1olxx8nkcY6v0OsfwxO2TAAYB5SQsTXesIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709998921; c=relaxed/simple;
	bh=lgwpTNi1M3yVskswaglSg5hLDE71jPPK741kQGr7/SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGbdrhuHuq03oemai5pxxwrZgb5bJJdprrY5oOM7UwfcdI8CMTV/YDKgE0MutKUDon6gDSB/wBL+f+5B4sChyNf6JVIgx3opUtIDF3TxyzbZdIy7kgQG4eV7EPKdw+s/hB2K9smdEUkWrDwlkJdhgwC8qn0q+kb/VKtM4Hn1Vbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mrLTnH+h; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5682df7917eso8056a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 07:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709998918; x=1710603718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkDsUMSZYlTGnFq8L8u1MCZSuc7DRjwYv05YSVPzzQs=;
        b=mrLTnH+h/N6GRDiJvOJL72/FEFTtqWG/1a+jry6zxfXlDRsOZ+xrBxpkoUT1RxXHy6
         V7kIuUP0iXn+dFs4geLRYH/J6SlPL4BXNPvw1BvHg/M/SNGvU99xsvxi/QymhEgtxj7p
         4Q41RyntcpusFYdX/CBCDO1RoO/EPrnpRFYfrGh4oWCYiqNkdBl+tQ0DcZg5vdNjpBK+
         9S8gpIgwMzVKUE/W82e3E6c25ogxUgFOZGxNoxp8rq3pcoUg7lKdZ9Wqaa1Qo72l0kKD
         49gkk8Ezc7CcBFiKqQNga+TnIWmPO4Qceo6xJIuCrPF6yn0gRxcqXSUisUtr357M7UHZ
         bW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709998918; x=1710603718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkDsUMSZYlTGnFq8L8u1MCZSuc7DRjwYv05YSVPzzQs=;
        b=HS2oyaAIqlyurEgZbQSKLyfIifPYBQ9cGwdO7NhWv2IYQo+Ynf8KlTCWXX0/4DPUfT
         pBV890PYXPl8obHd40G4Z+DrkbCzjt2G2RkDO+IwK8gli9waxZ8MpCy4LXKHkFBgrS1E
         KSeBKF20Nw5u+Z50y1MVbjulUn00QHvFJ0p6BTgLOahPOQtHNMUXGXQeBZKG/oSbLLvV
         FsXV/ALbNL+kId03+sD+NJxAYhdDvk5LaGM3Et0bDv/IekaGCrlU0aXfpFSaFMklVRxn
         sC/SW1QaBLMs4FUwnNpR+8t00/ygY2Qi2fhhoZJXQooW1rdVrL6YCRZecx4Mw5moXrTY
         Yohw==
X-Forwarded-Encrypted: i=1; AJvYcCX+MhVtvFD5EZDWes4iReNdNUGCzN2PKLkaSE3Yde5EKtT1EmDNhuAzYS8/C2hE2gStS6ijDTanI0RxctPxBIPzYQul9cZwy64Z913q
X-Gm-Message-State: AOJu0YyLuS0RAOahpGBN8VZWzjihoxT76K5mhDUCpNGavwlVXuDU+Lwi
	3lyEIIfusJK2692/BZh6fq7iJNyIve0FFVWQ30rmrJ+hWk4I/RLa+HgU7rVSvcV5gw+qyK+biBh
	0ROUU6teiYFmHXXMyd2veCYOWkQgN4SjF1Ky4
X-Google-Smtp-Source: AGHT+IFPsTXjqJ8K9UyJJZ2xhpe/CdWpMxGY3SffBXmKELvxZlkX7xMtkQZqbztu95EV/lRThefqSgEfRLV/1omhcSI=
X-Received: by 2002:a05:6402:1b06:b0:568:3c0c:1755 with SMTP id
 by6-20020a0564021b0600b005683c0c1755mr84512edb.6.1709998917765; Sat, 09 Mar
 2024 07:41:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f939c84a-2322-4393-a5b0-9b1e0be8ed8e@gmail.com> <88831c36-a589-429f-8e8b-2ecb66a30263@gmail.com>
In-Reply-To: <88831c36-a589-429f-8e8b-2ecb66a30263@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 9 Mar 2024 16:41:46 +0100
Message-ID: <CANn89iK5+wqYdqMt_Rg3+jO+Xf4n4yO4kOK0kzNdqh99qgL3iQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/4] net: gro: move L3 flush checks to tcp_gro_receive
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemdebruijn.kernel@gmail.com, dsahern@kernel.org, xeb@mail.ru, 
	shuah@kernel.org, idosch@nvidia.com, razor@blackwall.org, amcohen@nvidia.com, 
	petrm@nvidia.com, jbenc@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com, 
	gavinl@nvidia.com, liujian56@huawei.com, horms@kernel.org, 
	linyunsheng@huawei.com, therbert@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 4:35=E2=80=AFPM Richard Gobert <richardbgobert@gmail=
com> wrote:
>
> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> iph->id, ...) against all packets in a loop. These flush checks are
> relevant only to tcp flows, and as such they're used to determine whether
> the packets can be merged later in tcp_gro_receive.
>
> These checks are not relevant to UDP packets.

I do not think this claim is true.

Incoming packets  ->  GRO -> GSO -> forwarded packets

The {GRO,GSO} step must be transparent, GRO is not LRO.

