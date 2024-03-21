Return-Path: <linux-kernel+bounces-110476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAE1885F75
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF9BB24A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C25620B00;
	Thu, 21 Mar 2024 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PTNoJZt3"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477CE28E7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041404; cv=none; b=l461GZ6FN0D4x1zEwyrrCjbNsafMCvvZUM+ZE4xCr4E9apos4am3O/yI1k7C3jIZ16xuWF31WpR4mDih56HC0TeZWGbKvUriD2DUapgMUVLM9s9A9RznnZgznNJ0LRUPx7haTt50IjOq0AubSjsPni0cbplKk+MI1BFEiJA4oeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041404; c=relaxed/simple;
	bh=3H8yzEixLugThZ6gDV6NOhM7SOQCmh3MHyqTzVOJYUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xg6dYtbkDT24PrSTkVweOtjtwAS40QP6RcHFJOsYxpi+X5HIPq4gJiA2Iwn2M3/JB1BS7JYpLEXxv9USk1dHN2cgCaRfPieJXVIHQce3wl1W+/WOfqSjfsqOfRLUG+F7K2BHHptinF3ZaxdjRiejpyFWVzE0unf52vfi3cjy6kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PTNoJZt3; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56b9dac4e6cso217a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711041401; x=1711646201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/JUieyU6p+t1fz5fZmjTRkLZEL/t4B8kEt2dsm3Nwg=;
        b=PTNoJZt3M0Op6tGm14WIOUt0Ht/Kqj8ffUHcAG6G9u6LMcxXJxKQveggd9qvOCIPQT
         TdI5ErU1NMyjmbCW19FpnL4QASXyO17caYCvfvlqv+VGcVKzgokaQwpW20NBW29cxmTG
         CaRG2awm2tf99dHu5FJnHvAu4DsRnkP1J9TJAiF2R3xXSEsaxQoP8HlltleiiRTRZj9r
         w3MJ3Nbn/oc9557nTWGIhhNpy3kPWpkRYGZCP2edKM8OR4nO+vSFJMJVLgBrYA/o9WkH
         tEiyJqbtrxCMw+4rUBUECMt8WHjMd7UXCNdqxSdIU+eNEOiwKgu4JqdTf1KRNQViLTsP
         fjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711041401; x=1711646201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/JUieyU6p+t1fz5fZmjTRkLZEL/t4B8kEt2dsm3Nwg=;
        b=g8pMSCzD02JHDUI4Ue1xTird3GdlAITz1VxNO4FAEC/QY05Mvl8Djho8Fi1JDdIx1J
         AeXZKraWAivx+Nay2oKvpfP1HWR+BQvewTZEzYX78ts6yHZpqMFnXlohicv2lbEM+g6i
         r1t38uVqnYSRObCSmfdE1pNp3+8VFQxprClrAQNodGKKRdaX1oqcCAAQKPjlmZkfLYZb
         jUC/H7ZbJTmYNLrOShoCP1FXkF5icLj8EqA09m4eTHJtKtoMQKITBhOg+oVkMGEzRUfQ
         /wvEIIQjEpoLrpGz0LpomKJoMax/KsLT9b2eyJQ5g5mjq4duzwFJ34WVsUSMvYD2mAgF
         jsjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSlCz7MktXQVqFrTsJEP2EtdLIZ1of2mJJsRNQnou1SHclgUDiMumryFATQIHiAkKfdZ0g23722kEP64D3vsOqN6UfRRGC3KpSsCuk
X-Gm-Message-State: AOJu0YwCtwAdmUALb4aeJjaVd9Wdx8XF7a8AFMn0hIre8xFZ2ndhZbjm
	F+efjbie08vH/OVpCPHCAQGu12jxgv8GhFzICc0l3aGM/eprocDNgeuHrOP4kjlOWO+KxxjyJ+c
	JbCxtegElDnjBJdkBrddst2kPpRlSIZk6Rqiq
X-Google-Smtp-Source: AGHT+IHCEzqZWBHQlpIXQyc9IfRalbHQaIraubeRBBm8PwEixQgIw3CxI4q9Xn0tMElGLlwQP8hM6kE6k5HXg8Ka+bI=
X-Received: by 2002:aa7:c6d7:0:b0:56b:bf41:c0a0 with SMTP id
 b23-20020aa7c6d7000000b0056bbf41c0a0mr222385eds.0.1711041401136; Thu, 21 Mar
 2024 10:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zfrmv4u0tVcYGS5n@nanopsycho> <20240321123446.7012-1-abelova@astralinux.ru>
In-Reply-To: <20240321123446.7012-1-abelova@astralinux.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Mar 2024 18:16:30 +0100
Message-ID: <CANn89iK1SO32Zggz5fh4J=NmrVW5RjkdbxJ+-ULP8ysmKXLGvg@mail.gmail.com>
Subject: Re: [PATCH v2] flow_dissector: prevent NULL pointer dereference in __skb_flow_dissect
To: Anastasia Belova <abelova@astralinux.ru>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 1:35=E2=80=AFPM Anastasia Belova <abelova@astralinu=
x.ru> wrote:
>
> skb is an optional parameter, so it may be NULL.
> Add check defore dereference in eth_hdr.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 690e36e726d0 ("net: Allow raw buffers to be passed into the flow d=
issector.")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  net/core/flow_dissector.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 272f09251343..68a8228ffae3 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -1139,6 +1139,8 @@ bool __skb_flow_dissect(const struct net *net,
>
>         if (dissector_uses_key(flow_dissector,
>                                FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> +               if (!skb)
> +                       goto out_bad;
>                 struct ethhdr *eth =3D eth_hdr(skb);
>                 struct flow_dissector_key_eth_addrs *key_eth_addrs;
>


I think you ignored my prior feedback.

In which case can we go to this point with skb =3D=3D NULL ?
How come nobody complained of crashes here ?

I think we need to know if adding code here is useful or not.

You have to understand that a patch like this might need days of work
from various teams in the world,
flooded by questionable CVE.

