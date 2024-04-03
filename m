Return-Path: <linux-kernel+bounces-130153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7881A8974D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5B6BB2F794
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D0C14B09A;
	Wed,  3 Apr 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PiIS8z13"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EC214A63E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160069; cv=none; b=lKmX/QHoBPvREEyKlBA+kvsxPPfxR+JvEy0CswHJkc93slhH4Zx1HnaGH1C9/NA8ojhFdiNXD4vD1McWXpszpY+5uLrwhbUiNhXV9G04HAAbFssbPXq69mU1TvumZVPCYmBuK703VJamBa3iyjWd+UfdylLN+ZeURN4iTz/aT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160069; c=relaxed/simple;
	bh=hD5yDhx3K11qOSGBNDBsF2hWDD99wueNyoFwjeFs7nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJDpC7ObIqEBGH3GMggLq3kmJAHToaGxgMinbMpU+c8AAaQ1hvrkP91dAc1p4ediku7YnJdGPq+7gnc6ku0DF0SECSe3dmLyyscnvzEHLECiyu61z24L2JIcdkUBXNGaiWj6i8tJSPlDAnpNS/lfRoSjOMg3w8J9rYcBigZkE30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PiIS8z13; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e0c7f7ba3so11021a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712160066; x=1712764866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hD5yDhx3K11qOSGBNDBsF2hWDD99wueNyoFwjeFs7nU=;
        b=PiIS8z13223ePGsajmfUoutx9n2GPnlrR8QsR7lKnd/nqw7KckVpbjoJnCrXhS28vD
         nyAYRWgZ+K4LO/T/Ybm4qyiJdx1EWESdN+VLePz9scAt3eIwtz8+q8X1vNZ7GSPKOGTk
         SOqhts7JbIDTL04yguorV5oAAelpCyEMUgAwS7/SakOtPJdLkYBB4v2WrFJdLRrOB1AX
         +sfGFRtOGrNDmdhkce+RScjuqrg+Dskf/84KkhrsR+EXvIDq00vwyxQtXXTjEiZzWGYz
         NoTwG+/w+bgFUzqxevLvjx5ptLytKaHb79djUamFS4syp/dON3cgJnfdU3vQTOnYkOXx
         o0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160066; x=1712764866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hD5yDhx3K11qOSGBNDBsF2hWDD99wueNyoFwjeFs7nU=;
        b=na+QnWhkM8U1k2iTIBTJfiYXR7grd/2RZs2PPhmi7bsCljMaCv0GI8XFxE15g+g/56
         9r6x6k16wgbV4kT+KNFA7YhfKa346aevlkHpXwdIVcqapSUJUoBxnS+eoJM46g9IUNPb
         fLBx9IZ6ZupXnAvxN19s6XurGS3XWjTZlAhJCEsK7UkYmw3PS+BV2z8cOlY9h/y63g/y
         0t1CixlOLDurxOvG1se+2elbmxOFcIbGA1NpoPcKCYTFe5/KuwqU1QJDab4alID9VWSr
         ilFmMen/Nr3lXvutydbq5zUzYJWPvHTOVPj/nV0+DrfFcf5mPbhV8EHMGOzr5gwr1U64
         72kA==
X-Forwarded-Encrypted: i=1; AJvYcCX5+4y6v0qbPWsO2D/9GW32Tba5UgtQMjMWxB5VKrTz+9eNTH4BPFlRD1+h5vbl2JUzYaVLCfq6D27Agd2Lp/8r9aF9e+hSVIHmnfi6
X-Gm-Message-State: AOJu0YyYSyyz66Z7jnbVNs2mwjhFG2qn6Zg4WRnvn7AEGY8mb2Y5DeIN
	TEmeQXXl4rNACYaZwkQIutTs8kBUCNGEI62zKvSX7cp0JhoJtU9ilhUgMiQYB65+0lD7dmmbVuc
	leA3mhGB3tBKx0P9bINClfrivAvwxtyn74pkxgqVKwwcqgPYoBQ==
X-Google-Smtp-Source: AGHT+IEUmY9XudXmbpFwSucPJOjKBvKxMo721EBg4Wsq2djPREp76AztlrfJ+3Sjw6qS3cf7aq0MWe0rE1oJJtQ1BJ8=
X-Received: by 2002:a05:6402:1c87:b0:56d:e27:369c with SMTP id
 cy7-20020a0564021c8700b0056d0e27369cmr180575edb.3.1712160065956; Wed, 03 Apr
 2024 09:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403152844.4061814-1-almasrymina@google.com> <20240403152844.4061814-2-almasrymina@google.com>
In-Reply-To: <20240403152844.4061814-2-almasrymina@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Apr 2024 18:00:52 +0200
Message-ID: <CANn89iKS2nwhzP-z0xwD4_R21+_7UjY1ajUbA2mFFi_gJpLtzg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/3] net: make napi_frag_unref reuse skb_page_unref
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
> The implementations of these 2 functions are almost identical. Remove
> the implementation of napi_frag_unref, and make it a call into
> skb_page_unref so we don't duplicate the implementation.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

