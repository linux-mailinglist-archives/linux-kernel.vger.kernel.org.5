Return-Path: <linux-kernel+bounces-108965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C783E88129D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671F11F250B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4D547F7C;
	Wed, 20 Mar 2024 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNwmPUt4"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BC24595C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942221; cv=none; b=cOcKnXCr+UWboLM4RwFQOkPv2GJid4uhJd6E3OU2zz/i4H9ygxJBtNXiuGKFAbKk8k9mrF1szqbroIV0nPdc2h4fS0mICLoyE+S376gNq5L5iAzwEt2/5vQR7z2rWiTt70aAQhaL/rAN0yrrTz9WlSdTD0lumerj+VNS+TOTIA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942221; c=relaxed/simple;
	bh=xYKvdBLrMCdy1WgNitS9O8mKhVBkzipGCYuwKoYVqcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RObZHacpxDMHyAnByDB7CM3DsK/8+nJriJ7sVSWB27VxqsKn6CU7cnnhXQmk1WOggD97mz4J30hXmP6xF6JOJdc0Hh5iYccGL8AMSEuT9gyAnCaA8ZkJ2DCJEkXmPMvbcEgVjUEjZh4ISRikjNoHXSFz59NDoy64tanhhPG8iJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qNwmPUt4; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56bb5b9ab89so5423a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710942218; x=1711547018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrVFZA4ng78LSzJE5ZcpP00io6yMT77XJ0fpYFAjOxc=;
        b=qNwmPUt4virXx4SAO2P5iI0Rqa28Ey0/2fwgLWqtMkJtzhTfhCvPW7Pe93Dx9McI2Z
         +i7a+MiJL0pN50hD2rbTbrKFz1UT94A59+cLUUfsCseKoCOdKvLKnVSkOXpOyILCF0ce
         x5freRh2Osd1hPTxpSrdRzXDj8J+jr6g7crFeiDO5QnrQKCbxZ4vIKflnZgJYH3MCf/6
         D2s+MnXw+0Xrt8//GLepcILXgwGt2iiCFPggYhfx7ftwb8B5sMxkZQ57VSxhMO1F+JX6
         qnqt1Uf7gRjITxC4yh+iorMSLTbT3s+KQKnyftERtBLGNVB6NMBhXlakwCjSGo3NzS+n
         81tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710942218; x=1711547018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrVFZA4ng78LSzJE5ZcpP00io6yMT77XJ0fpYFAjOxc=;
        b=xAJo67doJjuRIE6N99ELfvhjphY14UT+Aqa9/3md0v2+QB5JXVXbRu/F9YBDVcSS/P
         r/I4kjIRkYNIRtIj3Mu2P5WnW5aiyostFjiAMpTXX233K9jcDV2bP7UD24GCMQZi6Bj4
         rtSdCOQWrshsnEFJUsoF1RKrorKGigXBl2f4E+KC4yaJMNCs+4/7iTVbWbK6TGsM8Ndx
         QizTKoa094n+gEj78TMcL+DFjRDv0Wihbkp6eP00NIzUxVoP3iEgD/qiX40Wu/RbDNm3
         RBYNCdCz/Q2u9zt1tDV/xlzYtt3wP+7ne1ZsSBmYkpGWui4gpCfhMTaXIeLxYDUG1F5V
         kkBA==
X-Forwarded-Encrypted: i=1; AJvYcCUEWYIjG+hn70P4W0EjPfmsG2j6Sf8dx4lvTT98qaNb/I0h7fOXFxVS1eeHNCMItXXGAny3PbICRDcVxC6w2KQautM2uDOjDiwpmd4m
X-Gm-Message-State: AOJu0YzrqdvSWdqCeoX21opANPlUMGJ3C0rVq54AqKtbLX+1soiK7/az
	IYU8sDeoEZ63fcAGLPt8LRF0JA3NxtgZ7ipG1B6fP8m2xpIJKEgL1pgLsczOj5OhJNsjj48Hvn0
	L8Lo+xWKPzhqAzNqkI7PHdqCtQN+zEu93l2ES
X-Google-Smtp-Source: AGHT+IEJKvr7Tzc6RXNtDOkJwcXM/dRpuZJ3OMy+BGhvJTaJQ6ME63/gEo74bq5MIIAJgCibGiGcffcitlwZ1GiiXQk=
X-Received: by 2002:aa7:d5cc:0:b0:568:c280:64e9 with SMTP id
 d12-20020aa7d5cc000000b00568c28064e9mr195623eds.4.1710942217863; Wed, 20 Mar
 2024 06:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320125635.1444-1-abelova@astralinux.ru> <Zfrmv4u0tVcYGS5n@nanopsycho>
In-Reply-To: <Zfrmv4u0tVcYGS5n@nanopsycho>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Mar 2024 14:43:22 +0100
Message-ID: <CANn89iLz4ZesK23DQJmMdn5EA2akh_z+8ZLU-oEuRKy3JDEbAw@mail.gmail.com>
Subject: Re: [PATCH] flow_dissector: prevent NULL pointer dereference in __skb_flow_dissect
To: Jiri Pirko <jiri@resnulli.us>
Cc: Anastasia Belova <abelova@astralinux.ru>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 2:38=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Wed, Mar 20, 2024 at 01:56:35PM CET, abelova@astralinux.ru wrote:
> >skb is an optional parameter, so it may be NULL.
> >Add check defore dereference in eth_hdr.
> >
> >Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Either drop this line which provides no value, or attach a link to the
> actual report.
>
>
> >
> >Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet add=
resses")
>
> This looks incorrect. I believe that this is the offending commit:
> commit 690e36e726d00d2528bc569809048adf61550d80
> Author: David S. Miller <davem@davemloft.net>
> Date:   Sat Aug 23 12:13:41 2014 -0700
>
>     net: Allow raw buffers to be passed into the flow dissector.
>
>
>
> >Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> >---
> > net/core/flow_dissector.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> >index 272f09251343..05db3a8aa771 100644
> >--- a/net/core/flow_dissector.c
> >+++ b/net/core/flow_dissector.c
> >@@ -1137,7 +1137,7 @@ bool __skb_flow_dissect(const struct net *net,
> >               rcu_read_unlock();
> >       }
> >
> >-      if (dissector_uses_key(flow_dissector,
> >+      if (skb && dissector_uses_key(flow_dissector,
> >                              FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> >               struct ethhdr *eth =3D eth_hdr(skb);
> >               struct flow_dissector_key_eth_addrs *key_eth_addrs;
>
> Looks like FLOW_DISSECT_RET_OUT_BAD should be returned in case the
> FLOW_DISSECTOR_KEY_ETH_ADDRS are selected and there is no skb, no?
>

It would be nice knowing in which context we could have a NULL skb and
FLOW_DISSECTOR_KEY_ETH_ADDRS
at the same time.

It seems this fix is based on some kind of static analysis, but no real bug=
.

