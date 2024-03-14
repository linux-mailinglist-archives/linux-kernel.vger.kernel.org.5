Return-Path: <linux-kernel+bounces-102749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A20687B6DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC461F2156B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304175256;
	Thu, 14 Mar 2024 03:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mGJ5hLTz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1BB8BE5;
	Thu, 14 Mar 2024 03:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710386856; cv=none; b=oww+hpnM+j8+Acj6W61l3hcQ81C26dNrk7CBplQ7eopH25qHCrsm8WWyoLpkEvH4MdKhSRGRJOTn6OfRejM5dlRpMtkQgHN6GyDUO+lf92SJWa+Jh0OSx42cQZQMQaBmCWE59f3uCfkEs46YVaegklgj5NTuCRhR1x3hwywW14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710386856; c=relaxed/simple;
	bh=mvHFDPgOfKDs4ElWYSlkdgyoAPxlTvHb6gfuyj65NzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQh7sW5ob5ZYrHx5ShvLOZt2tF2UbYsjxIEf2o6xvQPD7vG6Ju4ljc7D+FqAtpRAuv0ieQqKcEVwTvvBlqCHPryFekj5mZP3Oo+Tdpse91k+aNVggRXsQhu0ivhMsmzS+wSEKVXBxVxceyCrYhZQ/KB9Osibl85VzUHG+W7Rlyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=mGJ5hLTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4F5C43394;
	Thu, 14 Mar 2024 03:27:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mGJ5hLTz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1710386854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvHFDPgOfKDs4ElWYSlkdgyoAPxlTvHb6gfuyj65NzE=;
	b=mGJ5hLTz9O+W9CMwAzNGFBmRO1n5/Gqxz9yPeV2eZpDqINyVKsEYMw701YJWriWfgKxg/H
	2GWEYEbkH2dYzhmiRkrwE38Iy/E52ZaRPxoJRhb4rFEgCp3aaG3x11nLjLjibH4X2yo1Qm
	jz28KQyeaPZ5amNRUoJyQ/an044XWlI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 128074d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Mar 2024 03:27:33 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso368559276.3;
        Wed, 13 Mar 2024 20:27:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkY78+s/7JYl2PzICKtZnkZuMxrckierF/sfXMWDKBedUjjfsW3EQU+EfLEkYvsfGXyargdveteuEraaoDoIEtjrc7Xs1Vioppdua6zXQ4ELIuOBWt6CM1ChBil4jnbQH2bLVM
X-Gm-Message-State: AOJu0YzIuUuXXLXqyh5Csg20q5Ql/CcvgSdhvv91u09DvOy+7oo1VMO1
	LsTP35Pu8KIm9z+uiDt41BbozXSSMpFpkUyiDN/GywwgteIxeGt/+hAZBuOUqrLHHDfNV2V5GLw
	MhOTXxEMnKhTbww/laLV2n35LQVQ=
X-Google-Smtp-Source: AGHT+IGipbRUywjVyzfyxsuyOdfop1QdmEURhyUqVShack9PjxKn4e+Wp5XMqX4UTwrQK7k0qQflfCUqvZnmp+9H3+s=
X-Received: by 2002:a05:6902:110:b0:dd0:471:712 with SMTP id
 o16-20020a056902011000b00dd004710712mr569095ybh.33.1710386851905; Wed, 13 Mar
 2024 20:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308112746.2290505-1-leitao@debian.org> <ZfJtzhKJV4yo3LRF@zx2c4.com>
In-Reply-To: <ZfJtzhKJV4yo3LRF@zx2c4.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 13 Mar 2024 21:27:19 -0600
X-Gmail-Original-Message-ID: <CAHmME9prrtWu8jkj20WKvTZV6mjQE2Vt_mFWGOuy9St1FOrEOg@mail.gmail.com>
Message-ID: <CAHmME9prrtWu8jkj20WKvTZV6mjQE2Vt_mFWGOuy9St1FOrEOg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] wireguard: Leverage core stats allocator
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, horms@kernel.org, dsahern@kernel.org, 
	"open list:WIREGUARD SECURE NETWORK TUNNEL" <wireguard@lists.zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 9:24=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
>
> I applied this series to the wireguard tree. Thanks for the patches.

Actually, sorry, nevermind. 1/2 is fine, but 2/2 results in `ip -stats
link ...` returning all zeros.

Jason

