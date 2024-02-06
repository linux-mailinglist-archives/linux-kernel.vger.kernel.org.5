Return-Path: <linux-kernel+bounces-55447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9EC84BCCE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886031F259FA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEFF11CAF;
	Tue,  6 Feb 2024 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofAMUZFH"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE5A134A6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707243467; cv=none; b=bTCmzBIRMzzMfOCYN66M5GfFANgMaUKR6E2r8KiiDB3ju+TODldao4VJnuedMkwqDuNMpgjKxo6onBMhMyqB9yguCRDkWffYWiBeH+9dGX+LaQutPFiRVHVU9ScxWCuXqCHSWOv+xc/lNxKHb0TjkJ59NeNbRvtcTu3amHg/TWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707243467; c=relaxed/simple;
	bh=hdKmjhASF46rbObskXulPw+dctUILb9sWSBGdEm2MkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FswDRyRfzu9tuuB4aadXb882MfejelC9J25YlPGv9aOeKGoRcaK83zl7wAr7XVYhgsgGzH5AMoCroPsXtdC81X3hcUh5zS65oWusDwZQIhDMeC88Tr9ytnLnDjO9bZjiqTUZXLl+5CzAv/UHT7oDa2osFe+TkbL9XEfvLJAEMO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofAMUZFH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3510d79ae9so698749766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707243464; x=1707848264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJxm5o5JwedjLGG4ET8BuqK0l6wSaCzMfVG0K+Iz704=;
        b=ofAMUZFHsJegEgvbCEwdotHB/me2r+0g0wLAGyzbz40zY0IHVtvASI7EI9bD8XLrrE
         W9PKow7thoHuUlvrxgF+3o0WjTKMQZ5SHvRmL/fy4mpLpOXyWpdFv2YNjo4JdyKgtPLh
         eU1uT+U9oTF2lBk7BwMNo3Nqg5m8LcXe9xZBp7lVkv73LhsNpNcA7JokG1EPQlw2IJ7A
         cmmhMNAq3B3rhIGFx+ib/9K/gXJSl6ItXfA4NFStL/SELUxa+mxGeDfYHTQbZJPo0IpG
         kmR0C2oikckLSacDtGUbC5JUFhg317HS85NNwYnE5TD7iWPx5Qsql/iwTZg8Cs7sNFdw
         uBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707243464; x=1707848264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJxm5o5JwedjLGG4ET8BuqK0l6wSaCzMfVG0K+Iz704=;
        b=I1efr1wCNF8Rtg2vgur68oV/w5Ji8017c/Lb26VFZA/v1fnm9hHwjQwh6c15iuJ1Xc
         /eCQ/SCiSyybZV0vDes2La2/b2ZGcaTpJTZttCu54AEaZhZrtRzPBjlEteFGhpF5Eeox
         MdqfcuD201FMaR9Yd7LieW/I4zxKCxiIOA/UaE4Xqi7dYAFpo8+SNZbNmHrSVZqa0YBO
         g54nZUr9mwqESG0nbPM0CeRf9gS8yr508zQlEqgnwQurovXfnF1wu+zhhDqa6GFDQM++
         mYst8tkjGP3wCrW6Fwh7+96ankxr+Ksv6BEI5uaFje8dk6hgU5zsyhpWjVCUR/jlYiWI
         5A4Q==
X-Gm-Message-State: AOJu0YxLW7j4mnrTfBetMt7a7sS37hrZJTcY4MRmFWjy+irD8sPO6tgO
	DI8JPgxSBa9sXoUf4gtKBJuHoQixPfZN3AHUdhWdYPoYdRrkVbCqgHc7+4zKuyO17S9NC9wl3Y9
	YOyf7JNzJmezHdLMgJJdtV5pQTbTOoiinfeoC
X-Google-Smtp-Source: AGHT+IGWmPcNjm+wpDbul+AOT67RZaICat9JknWnwinU+ss7qWQ27bTyn7o4GQeZ3P1FafwEylGLQlPwraAAnqMleUs=
X-Received: by 2002:a17:906:710e:b0:a36:5079:d6c9 with SMTP id
 x14-20020a170906710e00b00a365079d6c9mr2033956ejj.76.1707243463572; Tue, 06
 Feb 2024 10:17:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201213429.4120839-1-almasrymina@google.com>
 <20240201213429.4120839-3-almasrymina@google.com> <1560533cb4eb3f36e640c9931fba93e0d0378652.camel@redhat.com>
In-Reply-To: <1560533cb4eb3f36e640c9931fba93e0d0378652.camel@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 6 Feb 2024 10:17:30 -0800
Message-ID: <CAHS8izM-QqyiYz100sC-QPhVOnD0zbc4TZhcTxZzritOa_z7FA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/2] net: add netmem to skb_frag_t
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 1:30=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Thu, 2024-02-01 at 13:34 -0800, Mina Almasry wrote:
> > @@ -2528,8 +2562,25 @@ static inline void skb_fill_page_desc_noacc(stru=
ct sk_buff *skb, int i,
> >       shinfo->nr_frags =3D i + 1;
> >  }
> >
> > -void skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page, in=
t off,
> > -                  int size, unsigned int truesize);
> > +static inline void skb_add_rx_frag_netmem(struct sk_buff *skb, int i,
> > +                                       netmem_ref netmem, int off, int=
 size,
> > +                                       unsigned int truesize)
> > +{
> > +     DEBUG_NET_WARN_ON_ONCE(size > truesize);
> > +
> > +     skb_fill_netmem_desc(skb, i, netmem, off, size);
> > +     skb->len +=3D size;
> > +     skb->data_len +=3D size;
> > +     skb->truesize +=3D truesize;
> > +}
>
> > +
> > +static inline void skb_add_rx_frag(struct sk_buff *skb, int i,
> > +                                struct page *page, int off, int size,
> > +                                unsigned int truesize)
> > +{
> > +     skb_add_rx_frag_netmem(skb, i, page_to_netmem(page), off, size,
> > +                            truesize);
> > +}
>
> I'm very sorry, I was not clear in my previous feedback: only
> skb_add_rx_frag() was supposed to be 'static inline'.
>
> skb_add_rx_frag_netmem() contains a few more instructions and there are
> a lot of callers, always inline it does not look the best option.
>
> I'm sorry for requiring an additional iteration, but feel free to ad my
> Acked-by with the above change.
>

No worries, minor miscommunication. I'm happy to respin with the change. Th=
anks!



--=20
Thanks,
Mina

