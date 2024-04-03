Return-Path: <linux-kernel+bounces-130196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A6A89753D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BCE1F2B3C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E9215098F;
	Wed,  3 Apr 2024 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OuX/YlS6"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21921B978
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161805; cv=none; b=PzkcUGaMkaizlsjYiw2ySmbnyH29iXbsa62LeBa1giTfKfB2RNhBgoE6OdrC9MLcO7PJ7T02OU2lRfHDXqTXzlP8e1lHVhvrdzVJTfkb8lmo4ZxyfABSleVWlJt2b6sYW1KjhgaplOHyXGc7d2y4/UeUe7s0ivlbxtjVMCans70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161805; c=relaxed/simple;
	bh=euAFO8Clw3pP5qIbVAUGnUfJ30fBuMGE4BnruenTn1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PW3f6Hcnqc218evMu3oBd9XUh9HcHAKTjJLc0jS1ZJ1AkjrtW/p9n3Rry8EvcJ0inKXBCr+bbemB+bvUtDO3rB86HIp2HgcGf3TwduK1U3j6ff7kV5a+pXzGdle2b3mVfBp02jyumMIDcVW8x0L4b6RnOfITZsvpMlOePRp7vZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OuX/YlS6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56dec96530bso47a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 09:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712161802; x=1712766602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euAFO8Clw3pP5qIbVAUGnUfJ30fBuMGE4BnruenTn1M=;
        b=OuX/YlS6hFRVamHfsUEQxVkL8OipuVmE8x2/toE+hvMPLuWAjoeKOnLP7x/V4SdR2j
         /mThhrmUkLcy7ARb/cikquMaskrv3fk4Dy+JUtK0R6WvAtRK3EOqPI/Mo13DtaScrgrW
         rHjQxAUBvawDCcr/tylL0xGkFtn2+y8Y9Njnhdbo4VbdtpSabUjWRfxGUEBxqV4FA6T2
         k8cs8UUdQTlpJAgwqhjhT57MLtWIGU+B9BkXumK1uWCp1y93FK6zHVVnnyYj4ebVWurL
         gDkjeUfQPvLKMz4XujD6NwTVUZ8PXp/YTr+d5vrkkIpPpRWjF9P5w6rbSW75VHBfj75N
         hH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712161802; x=1712766602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euAFO8Clw3pP5qIbVAUGnUfJ30fBuMGE4BnruenTn1M=;
        b=iIhevJTwnpwGDMjnI4aB9tDAPUqjgf2/Ot3d4UTJGCp0HaQvcp1Ixb7RzaSyqrvf5P
         y03KIwq/qCsJf0iiNr2q/jTkTI88UOam7Ojolvz31yzhor1rmH4h5YS0ROqfMffvfKOl
         KAoqWzcIyP8iF9V40uA/6GW/mvDotbvVjiibuzF6BNkwTte2du/MjKG9VaKSiV8d5WHq
         DaD6TldkFsbGUcqsvLCYDd75FokfDmiqD0393FEJ9DdnE4pIn06tKmd+ZD5NdJbv0q/6
         x4woSqfNEtg2kgoJTPVXjSc6ASY8RcgCWDpKzL42Oat2p5zyI1++pxf03Y+O1i3vJWsn
         qg3g==
X-Forwarded-Encrypted: i=1; AJvYcCWd/7oGe5/YT4p6FSbDOVMw8f0W8ZXgzZxEKknJjED29hSf4yobCtfxK+LRxEeW8+XOsle1tSy+LsU//Q6YgKK2e0PAOdJZDKqJ4THT
X-Gm-Message-State: AOJu0Yy+c1UkNlJABAD+QJPZg6QMxPYNOYIsQL1XcOFkc759HdMfB/Ms
	oGRg5ILirgyZvu1R8WYSWuO7wcj3wa8zsUALHOrthTF0TTBF9/hx7gshh0HEEx8kcziOFjnoOeJ
	cFAjMm0NRJ+JrvkgpPWxWR7oLsnUtpZXwXKhn
X-Google-Smtp-Source: AGHT+IEdTYNLl3lph2QKQnGHmuW7zrGgUGa3PMyy86dc1vzA0Cv5mhOyz+7L5WrG3+kBN6Pb5mRVv2h2QvEzuPHul8Y=
X-Received: by 2002:a05:6402:1289:b0:56d:ecf2:2a14 with SMTP id
 w9-20020a056402128900b0056decf22a14mr246927edv.0.1712161802179; Wed, 03 Apr
 2024 09:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403152844.4061814-1-almasrymina@google.com> <20240403152844.4061814-4-almasrymina@google.com>
In-Reply-To: <20240403152844.4061814-4-almasrymina@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Apr 2024 18:29:51 +0200
Message-ID: <CANn89iKDCjgn1QZv3N9Qem5E+4GxWc=xB0OE=9jc+8-ceRP-BQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/3] net: remove napi_frag_unref
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ayush Sawal <ayush.sawal@chelsio.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, 
	=?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Florian Westphal <fw@strlen.de>, David Howells <dhowells@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 5:28=E2=80=AFPM Mina Almasry <almasrymina@google.com=
> wrote:
>
> With the changes in the last patches, napi_frag_unref() is now
> reduandant. Remove it and use skb_page_unref directly.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

