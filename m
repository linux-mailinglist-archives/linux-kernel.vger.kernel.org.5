Return-Path: <linux-kernel+bounces-95989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD6F8755B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BEC1F22A94
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097A613328B;
	Thu,  7 Mar 2024 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fwQ/0QDK"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5171131E25
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834368; cv=none; b=s480SIWJYdZanR3tPDtSBmAnmKyJfGA7nUC3Dpj9alR6OOqpwaV1MTEllLOpxeGw9GRIfNm3zV3u2VE3Fm7W91gcnhdOc5QB6nR2lttHXGpa2mFu+dkQnlx73jH2uvEqmPwNYlCaYMEETmLZFYHuBN+74/VWekriGF6QU507heU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834368; c=relaxed/simple;
	bh=DOUOkcuf6REntWUk+39dCprquLsjGgsrA9o5nYOuJJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+DmK5olJasxjLgO891AHwlMXii9xJYJYt9SUHkNwkADcmd4kW+TmdjE3qaFnx24Pr/LzI8GuvOi3ES4FTHaVHQCJjQ3LnauRarJDspzK6jbS5wlKyuynCeJK1YuIsa6Xeh+LSZ0gKLz8QFfyHLB/ozA94mJtV0fMWD/0+X7yrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fwQ/0QDK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-568251882d7so738a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 09:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709834365; x=1710439165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2o2Pln6r840e13WOJWTSVZVF4sTC1hDT+VsrrLWTTjQ=;
        b=fwQ/0QDKdynqm0mcrInYhNelkKAhBVHVYHHEzeigU/oUkYJWcJszYX5LdwNfIUWCQ2
         japNRTD2DgP0iRatUEPiJO6+HAJxg04LLZ9GyvfLxiY0yj34BbN3LuMA05eCsIOn4OJG
         o4sI4IHPUiE+csSXFUd8QugHlPygT7T6wmsnqNDykil/rT5+YlwRXGq6G2cZLmQwwPQm
         o21iZNvQu3JoCfg61VDlx6CErp05nsllyy6fDV5VPcFaemDFQHxSuL5v1H8K1iSAuV/l
         sWnRzChBWN1lycpwei2FvxS71JgwU/RbIvHTmOoXN5dGv6QSUYdJoHpPguf1etNCVFX0
         K85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709834365; x=1710439165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2o2Pln6r840e13WOJWTSVZVF4sTC1hDT+VsrrLWTTjQ=;
        b=iUBrn1DtytqdxwiMrK5Jtm59zZYiotER3/8BpYcGC6smF0jKHUUaOQ/rZjxI9+tAR3
         sf4KC78Rx3+f2Gc+Lbx8sCFY+CZHue7izBNJSOXc760XhuFuAYKiRqPkNSkUI2VUZWyv
         cXep7hew4wm2BfZ1h6H0u/SH9qZ9IOJYJ7qSaQb/SfGmsHaST3ZUqBc5BjS1yplKIRpP
         vn5K3fLSDFcGYefDlt37xKidj4ySXtIZu4QxbTU6wTYTOZ+3oGxad7kfqEie1UBZWhLY
         vqqL9M9av6G/XnrHXvyY76pWhIpvehrb2JXkYiYWCINV63AY991xT1alwUVO9e3cY+5a
         4m5A==
X-Forwarded-Encrypted: i=1; AJvYcCWXnnXLVh8bAQ0+eXHMcy13BBrTDsI8kWKClpJGCUmtjjf1pxs9R2hOROTIut0DL4jtghToiDkVy+6CdpWpdulL+9IqdTRvyVtGUNc/
X-Gm-Message-State: AOJu0Yxcs3T485OQm0snr9EgWwHMAyDOgZvjy/zfoG4oIfCC9WoJbiZL
	SQ1lXs7aLWW9FdDJTvk1s3obP+CbFw3+ACR3kyVS91O6/sXL59iQCSuQG69z8KoZWgReYnMC4Ry
	kU7JtJw5BClZ/iA81V5Uo3/eRrtfdwoT1he7v
X-Google-Smtp-Source: AGHT+IFZzIgjjQB+W6AfKsYHZz4lpE8ZpdiWPzeNLAFZEGTcK+JeSYq4V7wUar3hDsxNIaEiyYfxPN2wpBKMlCM60Y4=
X-Received: by 2002:aa7:cd42:0:b0:566:b5f5:48cc with SMTP id
 v2-20020aa7cd42000000b00566b5f548ccmr227535edw.5.1709834364705; Thu, 07 Mar
 2024 09:59:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ce1600b-e733-448b-91ac-9d0ae2b866a4@gmail.com> <2076d2ff-cd17-4ab0-b1db-4875d96bf9a6@gmail.com>
In-Reply-To: <2076d2ff-cd17-4ab0-b1db-4875d96bf9a6@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Mar 2024 18:59:10 +0100
Message-ID: <CANn89iKq755tvJ1BZFXG5aX2YNd9AycbKu57taxi8gaSWn5Syw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] net: gro: set inner_network_header in
 receive phase
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemdebruijn.kernel@gmail.com, dsahern@kernel.org, shuah@kernel.org, 
	idosch@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 2:28=E2=80=AFPM Richard Gobert <richardbgobert@gmail=
com> wrote:
>
> This patch sets network_header and inner_network_header to their respecti=
ve
> values during the receive phase of GRO. This allows us to use
> inner_network_header later on in GRO. network_header is already set in
> dev_gro_receive and under encapsulation inner_network_header is set.
>

> +static inline int skb_gro_network_offset(const struct sk_buff *skb)
> +{
> +       const u32 mask =3D NAPI_GRO_CB(skb)->encap_mark - 1;
> +
> +       return (skb_network_offset(skb) & mask) | (skb_inner_network_offs=
et(skb) & ~mask);

Presumably this is not needed.

> +}
> +
>  static inline void *skb_gro_network_header(const struct sk_buff *skb)
>  {
> +       const int offset =3D skb_gro_network_offset(skb);
> +
>         if (skb_gro_may_pull(skb, skb_gro_offset(skb)))
> -               return skb_gro_header_fast(skb, skb_network_offset(skb));
> +               return skb_gro_header_fast(skb, offset);
>
> -       return skb_network_header(skb);
> +       return skb->data + offset;
>  }

I would instead add a new offset parameter to this function.

Again, ideally GRO should work without touching any skb->{offset}.

GRO stack should maintain the offsets it needs in its own storage
(stack parameter, or other storage if needed)

Upper stack can not trust any of these skb fields, otherwise we would
have some troubles with napi_reuse_skb()

