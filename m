Return-Path: <linux-kernel+bounces-97123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD058765C8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55BEF1C2187E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7AB3FB97;
	Fri,  8 Mar 2024 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GofPnRJp"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F61D38DF9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906328; cv=none; b=X8mKRXNFSXKKOyNZqkNjDJ1ydXsqFT/niYF24iw6+z7EjcYpQWDzue1hqaJI9zOjsXKDKf2NlMVR20GmrJpA+FrKGVvfLa9x8vdgBDAYqGQgjID6e3AQISzahYQ4YS4RWYMvK0pM+OHjR6lBbtYmwy7LBC4ja3TETCYA1B8xxq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906328; c=relaxed/simple;
	bh=A5c9YnK1XD9ztw+bdW/Fk6cIH6yGwP9iehA1nCjEi4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzxXVDgSZ/N3riZOn2YzN9SuHwuZEEep66eWRIyNdCYppHTtMgebG33XUmmwoeOlhA3vcg6y7YubIPbUIOPoAOK72iL3sMY7J5mbEG5KnGVuZG5i0vJwEIBAroGIBeS6q1jj5yLemt9iZJVUCF0ezm90kVTd7xb6DPtuO9b/DPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GofPnRJp; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so9485a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 05:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709906325; x=1710511125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBuF/mE2iPFE868dDTOlE0JcE/uZlhA0RB3KdQyjGQw=;
        b=GofPnRJpRAfaOK58ko4ChMpBx/aS11ZXqFvb7fUSY9kZXk5K1MuLMJNUE15/1KG8g7
         COo7E9ORzGYycnnGOImLmnnkBbl27GsfV73XwgTbmN1aNAQmzkGHsu/LyidsADujVHSw
         cMcOvyw2aTn8H9pDGKztWeOqIRhE1nPlk7BImZC1KShyJf0CYe1kz/kIp504ABx+BLvj
         Fp+X8EtpIuvPwoxfycwiJrHteuoco7ZMP/299TPptctFABkVGIfZrhChj5r4+PdKQ97P
         7MVawTIa2yNhi4nZqK4dH7wlt6apWgEHkKvvxc0usfVJXrsbPGAEaEPpz233B8NxyzpE
         dxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709906325; x=1710511125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBuF/mE2iPFE868dDTOlE0JcE/uZlhA0RB3KdQyjGQw=;
        b=Nue9RovBnNiavy6O4363+U0DHJevwsYxlw5s6dy7PhZzJgKhFo3uTGQ7RElrOugAmj
         xM95Vt0oldb6LjBfRjP5J1dRijGEDuciRMwFULL/UlQezVM11dRbYFXqKmDIIrAw5eCA
         h64WaoQqtZc0osTIIhVeWalbVKxPT0Gy0Y1iA6BHfhNIVQIxye9rMPfXhLMK8np/eb3p
         AIww6k7Z4sj2gBrThxRYWuvBxh/SLtkM2E+pDi1WJ1tJgJEkT9f71ijg4wSDgeaHrGiE
         e6y3F3Wl+bHW4pFCl/U8vS07o45uooqoRWxUZGG6Hb7WrFFnSx8zIJ3xT56p87bXXWVd
         aRKg==
X-Forwarded-Encrypted: i=1; AJvYcCU+b/6OT4P5SgRAV/AY8xhJo7QaGPSAu2NIdtd+0T7sF6MWPzyhY/Uyy0aK3xz1N92ukniVjnssGzAYH6Q1Yfczi+JjPsRF3mXNpxhM
X-Gm-Message-State: AOJu0YwpfHIOgAp+PpLx7wcsxszokiRwic8HkAcMfrLp7bHaQg5Kv/xu
	+0cDWV/SidiuJQdfoM0++THLbfPgskv1ohQx72yIOVnGQrrMXL1OJuzQEbJnEJxhEx07eiP34nS
	H8oC1BFENDhQDVhyT/LdQhHWl6GHJBQHc10kH
X-Google-Smtp-Source: AGHT+IEPWOFnbJg6WMrmkfNOZFtD9RE1AXOQNc1JoZLoDt1clsy51MvKrKJBXMcXzd9Ed4AvBLsruItkGrALYbUZqEg=
X-Received: by 2002:a05:6402:5202:b0:567:eb05:6d08 with SMTP id
 s2-20020a056402520200b00567eb056d08mr490497edd.6.1709906324710; Fri, 08 Mar
 2024 05:58:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308115722.14671-1-gakula@marvell.com>
In-Reply-To: <20240308115722.14671-1-gakula@marvell.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Mar 2024 14:58:31 +0100
Message-ID: <CANn89iJ2euG8SgmTpifRK2DV1N+PSPAgiSoZP-W+7YWE3Ygv6w@mail.gmail.com>
Subject: Re: [net PATCH] octeontx2-pf: Do not use HW TSO when gso_size < 16bytes
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, sgoutham@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 12:57=E2=80=AFPM Geetha sowjanya <gakula@marvell.com=
> wrote:
>
> Hardware doesn't support packet segmentation when segment size
> is < 16 bytes. Hence add an additional check and use SW
> segmentation in such case.
>
> Fixes: 86d7476078b8 ("octeontx2-pf: TCP segmentation offload support").
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/dri=
vers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index f828d32737af..2ac56abb3a0e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -967,6 +967,13 @@ static bool is_hw_tso_supported(struct otx2_nic *pfv=
f,
>  {
>         int payload_len, last_seg_size;
>
> +       /* Due to hw issue segment size less than 16 bytes
> +        * are not supported. Hence do not offload such TSO
> +        * segments.
> +        */
> +       if (skb_shinfo(skb)->gso_size < 16)
> +               return false;
> +
>         if (test_bit(HW_TSO, &pfvf->hw.cap_flag))
>                 return true;

How is this driver doing SW segmentation at this stage ?

You might perform this check in ndo_features_check() instead ?

otx2_sq_append_skb() is also forcing a linearization if
skb_shinfo(skb)->nr_frags >=3D OTX2_MAX_FRAGS_IN_SQE

This is quite bad, this one definitely should use ndo_features_check()
to mask NETIF_F_GSO_MASK for GSO packets.

Look at typhoon_features_check() for an example.

