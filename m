Return-Path: <linux-kernel+bounces-166398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 257778B9A0F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF06284BDB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3BF62A02;
	Thu,  2 May 2024 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SW+uXZwG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893B40BF5
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649434; cv=none; b=hehnSKmKNbpT9Eqe547WhFrcN1yjRtY75kwRu2a4Hj7Sgq0c4Lh8tLV3Fds54AUx4K5Q2Z3LQkw6DA8eW/5LNZUkPP8MCwJVpk9bfSsaIW3awbgeE12QlhY09AQKK+VTSRSnjD6UB9eRL/nom1oa+JzkVHEck7dJflXNHRaDyU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649434; c=relaxed/simple;
	bh=+FFhrC4HjHF1MMyPVQHp7n3mauOwtIVUUY0xolNeibM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kk4v2ZwSfHEsEcXvE4rAsSs2FFRTkvuCdAOanKyY+9MFr2zrbLWe9o9EXxRAIbI+UhzUWhLp9m5pL75Qh4Y0DnyJtDKhxy0c/y2SS5aciQaWCHWCZUr4RPz8/frccvtSsgRnbrhh+gskQsdoGZMqDSPdrMxgizzBOoqXJ0rOwJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SW+uXZwG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714649431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5Y3vWTHjjhtO1jbHBZN8nWFXDT/PbGcaFek8+0s53CA=;
	b=SW+uXZwGK71aVtitfQ5PdtQl+PCi5+YllqwxfnClQ2pVuZxRNBM11mvm4HcAqQRHkoNreZ
	mtgNE7l40fdZEw0pAdELA2Ub2neP5ARBfDzQC4cWs45Elx04V7wyRDjyAI9KdjAnEDCDQg
	8qdNkKebxi6h6nw6tpPmioPOLgexLY0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-ncNb6Hv2Psel3hb-D9TTpQ-1; Thu, 02 May 2024 07:30:30 -0400
X-MC-Unique: ncNb6Hv2Psel3hb-D9TTpQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-51f60818372so2465e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 04:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714649429; x=1715254229;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y3vWTHjjhtO1jbHBZN8nWFXDT/PbGcaFek8+0s53CA=;
        b=XSBb6qWptQz9S6tm/7+I5odpRvcFqAsoHWkKfd6iKUZ/vRWWBwOteEbCk/EmA8Ujnj
         mf5MlJExjbbLHsojE54wHCYGIctgs/oYPuc8wv0mVujzaoLoJYElSQkuvTmOv/dBrux3
         oeiBo8I/QQ+4s6oymf5Sul769u5/wJ8fLso0LS+osBWUwzJGPQN9NahRTggG05D2HUvZ
         +oFD/OXWgqcLnqoHhKlIVeLTCwo+YtTaKtEYFHyHCQTkv7MexXDbjaubqPbP8mbUk8Yf
         CTsXKRABRtvK9JkYBDT+0oa+38saB/g84ncfcsPFgjzS3xleI+jkwVeHn+Wv5br+AD/g
         jhpg==
X-Gm-Message-State: AOJu0YxyLj73R5NNcVhyG3L8jvwuHYQRHbnTdLAjUKuk8AOahZYmIcYb
	WMSq3WAd2oI9JilaFFUklKr5p1QZOTELy8s7an59kLkk1lAVGFnhnm1NKQndlE86pisCQqbVln8
	EuluOU6BruG++DEa5n1l2xCKuwk4PGkpvOLwixcNCtQ6y1UzHELLXevqLlSxebA==
X-Received: by 2002:a2e:8186:0:b0:2dd:374d:724e with SMTP id e6-20020a2e8186000000b002dd374d724emr3321455ljg.1.1714649428985;
        Thu, 02 May 2024 04:30:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcdnbdQ9KyzURBWyekprZS5+zkmk56gC9X7/WH2UeT+fkyLByPmnxLXI4IS00kw/9l4mSm6Q==
X-Received: by 2002:a2e:8186:0:b0:2dd:374d:724e with SMTP id e6-20020a2e8186000000b002dd374d724emr3321430ljg.1.1714649428491;
        Thu, 02 May 2024 04:30:28 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b52:6510:426c:715f:ad06:c489])
        by smtp.gmail.com with ESMTPSA id o31-20020a05600c511f00b0041b4c293f75sm1633939wms.13.2024.05.02.04.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 04:30:27 -0700 (PDT)
Message-ID: <b3e2ea3cc3c3a4c8be831a837bc23d40e3395dfe.camel@redhat.com>
Subject: Re: [PATCH net-next v2] net/mlx5e: flower: check for unsupported
 control flags
From: Paolo Abeni <pabeni@redhat.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>, =?ISO-8859-1?Q?Asbj=F8rn?=
	Sloth =?ISO-8859-1?Q?T=F8nnesen?=
	 <ast@fiberby.net>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Saeed
 Mahameed <saeedm@nvidia.com>,  Tariq Toukan <tariqt@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Jianbo Liu <jianbol@nvidia.com>
Date: Thu, 02 May 2024 13:30:26 +0200
In-Reply-To: <25a4890f-8b6f-4fb3-970f-b022b7ad5be8@gmail.com>
References: <20240422152728.175677-1-ast@fiberby.net>
	 <25a4890f-8b6f-4fb3-970f-b022b7ad5be8@gmail.com>
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

On Tue, 2024-04-30 at 08:15 +0300, Tariq Toukan wrote:
>=20
> On 22/04/2024 18:27, Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> > Use flow_rule_is_supp_control_flags() to reject filters
> > with unsupported control flags.
> >=20
> > In case any unsupported control flags are masked,
> > flow_rule_is_supp_control_flags() sets a NL extended
> > error message, and we return -EOPNOTSUPP.
> >=20
> > Remove FLOW_DIS_FIRST_FRAG specific error message,
> > and treat it as any other unsupported control flag.
> >=20
> > Only compile-tested.
> >=20
> > Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> > ---
> >=20
> > Changelog:
> >=20
> > v2:
> > - remove existing FLOW_DIS_FIRST_FRAG "support" (requested by Jianbo)
> >=20
> > v1: https://lore.kernel.org/netdev/20240417135110.99900-1-ast@fiberby.n=
et/
> >=20
> >   drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 10 ++++------
> >   1 file changed, 4 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_tc.c
> > index aeb32cb27182..30673292e15f 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> > @@ -2801,12 +2801,6 @@ static int __parse_cls_flower(struct mlx5e_priv =
*priv,
> >   		flow_rule_match_control(rule, &match);
> >   		addr_type =3D match.key->addr_type;
> >  =20
> > -		/* the HW doesn't support frag first/later */
> > -		if (match.mask->flags & FLOW_DIS_FIRST_FRAG) {
> > -			NL_SET_ERR_MSG_MOD(extack, "Match on frag first/later is not suppor=
ted");
> > -			return -EOPNOTSUPP;
> > -		}
> > -
> >   		if (match.mask->flags & FLOW_DIS_IS_FRAGMENT) {
> >   			MLX5_SET(fte_match_set_lyr_2_4, headers_c, frag, 1);
> >   			MLX5_SET(fte_match_set_lyr_2_4, headers_v, frag,
> > @@ -2819,6 +2813,10 @@ static int __parse_cls_flower(struct mlx5e_priv =
*priv,
> >   			else
> >   				*match_level =3D MLX5_MATCH_L3;
> >   		}
> > +
> > +		if (!flow_rule_is_supp_control_flags(FLOW_DIS_IS_FRAGMENT,
> > +						     match.mask->flags, extack))
> > +			return -EOPNOTSUPP;
> >   	}
> >  =20
> >   	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
>=20
> Acked-by: Tariq Toukan <tariqt@nvidia.com>

@Tariq/@Saeed: do you want to take this patch towards your tree and
send or do you prefer we merge it directly? I tend to read the above
ack as the 2nd option, but given this is only build tested I guess the
first would be better...

Thanks,

Paolo


