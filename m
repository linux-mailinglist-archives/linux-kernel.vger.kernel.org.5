Return-Path: <linux-kernel+bounces-159689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 587F28B323B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F941B23C59
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C8A13CF9D;
	Fri, 26 Apr 2024 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E87rWalv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE72613C9AD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714119692; cv=none; b=D6v+P/LJ2dSm0cUzrOeF4941KUXedbaeOZQM/mhE6S+7QXADvf7NcWNcmwB5rGKVKsgo8bqbeG/LfPZACrA1UKkj8wdHpRsWdLe3DWFQb2uBAr8c+PnZ+p4XXGQtMoRapNODpJxcVuCIDj9RTvno4VWTFuapK83ep8AojyL3HEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714119692; c=relaxed/simple;
	bh=lnYud5aJOqHbh4DFWlT+sclBir546QfmOn5fvmD4Yus=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qDKtP8m4eXK0Fh2OU1KrGFEakPpXepnnKCyyt/CBhBkkHpzRRNl0zyDSpr611c9lIJqU8hZDsvPEqX0LF4OeinDPIYomhrHvXsPvM7sZbvJXmDelLAKIIdSm6VfM6jD9a9yT/Y+VLKOcf7A4qGnA4eLPQA6NYA7XMb09t9EdmSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E87rWalv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714119689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vg5yFseHR4p52Q+OUrRFDV07kK0bwj6ehh8BARaHsHQ=;
	b=E87rWalv/kRydxYggvrpoUjoiWokprmHiK2ye8tb/qim9OK0lazPlIiFeIX4tKwMHpKPCj
	YXEn3Q47m94jaZDiYpiE0m1gzd9uxV4c5wZKrNgviE9OehDj2H50eIknaWiqhZ/6+FVJze
	LvN9PRbImkwEL2RkZTpCUgDvfN6pEkU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-utOXyuCyOS-OQqRAnMGBmw-1; Fri, 26 Apr 2024 04:21:27 -0400
X-MC-Unique: utOXyuCyOS-OQqRAnMGBmw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6a05461964cso6783246d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 01:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714119687; x=1714724487;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vg5yFseHR4p52Q+OUrRFDV07kK0bwj6ehh8BARaHsHQ=;
        b=dH1PMB4wKbozGp8bpvEUvDOegP5/Ez/kS0rNOGIkUQK6s6jeLpM4j5rufz+/LGv61D
         pO91ybxQLDqsU174jMYCwGtjBUa5FnjDXa3uV+9vkWunz0JCs6XQateZXHXch+75IRzZ
         h8fRiSCWsbT52ytCvN0QN6jeKQbUjHSiZFInRNNq2bl/Vj9tVsrRatQGW3DkLTjXeEqr
         cWLabMYvJK99sAOuacTN1NDdbOGyd8RK26J4CGfz3cWQxmHYH6DR2lhdPUThd7IstDut
         pjgvr+4vInsZlJGpf3GP2M5QGGwv7DUHj/2LV9UiBNYvy7czvBYrao1j+qZ3QMTZw1kn
         rs3g==
X-Forwarded-Encrypted: i=1; AJvYcCUY9gnxa2WLA8LI8T29cPKhSdlw3prBo1m+PnFfVnvmUeF1eMRMcMTajCLqbYAUFmZGoqS+ylqSWg85COfzmxojRNKgqBtOtWYMdQzk
X-Gm-Message-State: AOJu0YyU+rs/k81eKIPGjzHRvqKNpvzhEgkMQNdv/4f8H4LFQo9LvZPk
	o9VcB07w8d/Dfx/fzLRIu+Fj+uWaG0kNrevzuVcmXXy2XPIuWGI+YFhLYbl2LNNiYi7oGyBV58n
	fCOzbC8IzsYomG/fLyeJkPeN4NJpeM5flbgwiBmPrVy5EcWPbplAnhxnM7RJGBg==
X-Received: by 2002:a05:620a:4092:b0:790:9a35:4a37 with SMTP id f18-20020a05620a409200b007909a354a37mr2137225qko.4.1714119687126;
        Fri, 26 Apr 2024 01:21:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDAucunkTGMfCOr5V9vc+LO4VZ6M0c4FMlBPJiK3LmorPQwUc1TUN2Wm87uDbxEqc7CFHCrA==
X-Received: by 2002:a05:620a:4092:b0:790:9a35:4a37 with SMTP id f18-20020a05620a409200b007909a354a37mr2137213qko.4.1714119686731;
        Fri, 26 Apr 2024 01:21:26 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:171d:a510::f71])
        by smtp.gmail.com with ESMTPSA id t17-20020a05620a451100b0078edf6393edsm7696690qkp.73.2024.04.26.01.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 01:21:26 -0700 (PDT)
Message-ID: <17d72e2d11808ca678432749aaad7702d4d1ff8e.camel@redhat.com>
Subject: Re: [PATCH v3 net-next v3 3/6] net: add code for TCP fraglist GRO
From: Paolo Abeni <pabeni@redhat.com>
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Date: Fri, 26 Apr 2024 10:21:23 +0200
In-Reply-To: <20240426065143.4667-4-nbd@nbd.name>
References: <20240426065143.4667-1-nbd@nbd.name>
	 <20240426065143.4667-4-nbd@nbd.name>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-26 at 08:51 +0200, Felix Fietkau wrote:
> This implements fraglist GRO similar to how it's handled in UDP, however
> no functional changes are added yet. The next change adds a heuristic for
> using fraglist GRO instead of regular GRO.
>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c   | 22 ++++++++++++++++++++++
>  net/ipv6/tcpv6_offload.c |  9 +++++++++
>  2 files changed, 31 insertions(+)
>=20
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index c493e95e09a5..ffd6b7a4163a 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -332,6 +332,19 @@ struct sk_buff *tcp_gro_receive(struct list_head *he=
ad, struct sk_buff *skb)
>  	flush |=3D (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
>  	flush |=3D skb_cmp_decrypted(p, skb);
> =20
> +	if (NAPI_GRO_CB(p)->is_flist) {
> +		flush |=3D (__force int)(flags ^ tcp_flag_word(th2));
> +		flush |=3D skb->ip_summed !=3D p->ip_summed;
> +		flush |=3D skb->csum_level !=3D p->csum_level;
> +		flush |=3D !pskb_may_pull(skb, skb_gro_offset(skb));

I'm sorry, I'm lagging behind. I think the TCP flags handling here is
correct - preserving the original ones should work.

The question a made WRT 2 above checks being non necessary/redundant:

		flush |=3D (__force int)(flags ^ tcp_flag_word(th2));
		flush |=3D !pskb_may_pull(skb, skb_gro_offset(skb));

still stands, I think.

Thanks,

Paolo


