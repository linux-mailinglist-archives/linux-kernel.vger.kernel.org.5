Return-Path: <linux-kernel+bounces-54973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C818B84B5B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373061F253D8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F3B12FF90;
	Tue,  6 Feb 2024 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXDWTmM3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821A712FF6C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224233; cv=none; b=QdfYBDJ+fjhcN79tZOOrp7465KocJZn2aHo8lRfejUh/NVX7ueg5Sc7YTljoqENK120FYKWpGKs5TEIY08olqPcXVJYMXewsNr9gn3Q4nxtheG6VPy/BE4ZFpfZkdT5LmjDLwqCIVoIBei63tHN1dLsBI8X9/WL2Zwg4B4aHxMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224233; c=relaxed/simple;
	bh=lQsbLdL8Tqssed0wGZrcXhwd0o6AbXZEOEFKVlVzy5A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SwJRLgHqS3hRFpDLHp+0dcV23ouLK5BY5IN5xlSoBPb9pCornSMAYACldjYS8yhXcLOPRUO4EDxqp1Fv/zZpesgB0gdb8rXa+bhXppHtcpKi1Bn2cVkgkOSFbNZtgA2beKhfx/BPGnzrvyb5l8i3+aYvb+bDKrwqaXfQxxXN+uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXDWTmM3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707224230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/1k6MOkR23iKwCezCQdkU1QkjIYXCyaU/n1ekUYcUX0=;
	b=aXDWTmM32ytpijgBXJKXRnsmTrmV3fOFT2RX0xXvoUf8ZhlnydSCsFvpDZMMxYmJ6/Sxge
	KwEFU/EsSq0Yacuet/RgHsfc/NUkxa45ff2hG7gkZ6rdVgwCFRl+pd1mDJkBQpfXL4H2lr
	UtetWm9Wp64HrFkyqhopeJdjTEizyXg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-ii74QESFOoiavTadO1MfFg-1; Tue, 06 Feb 2024 07:57:09 -0500
X-MC-Unique: ii74QESFOoiavTadO1MfFg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e354aaf56so13003605e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 04:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707224228; x=1707829028;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1k6MOkR23iKwCezCQdkU1QkjIYXCyaU/n1ekUYcUX0=;
        b=ObOrxuMBoMKw2HVzA6G30VyvgEp9anqi0pX004Knb3os8KutCkxFVToxqNeiUN2z/K
         kDisVvo5pvTVGwMr1deI87Uo4UX6xreudKIgqVIwIkvk3o9JWkhie5godfo21tYl1NTe
         FSM8A6JXmM8i+M9rF7/54lbxAoRKXGy29HTBtvgh5FQ0vf/AajMaz43YDj+INBRO02Gl
         EdDE98l/S1ewH2bHXs06iRgXyn9UsjaWv3ICJQk+ODMxlQZvb2vzP74+8EvIWkO0kjkf
         kkTD9J6yiucxhgTAOsytiLk26zRRPySUKlpZ9Y2of6i1x1+biQPd42kBFe88/zH2bXF3
         CK2A==
X-Forwarded-Encrypted: i=1; AJvYcCV4QFHMwBR7Ot5W16bAT8YArFf9ihx4tt6srAfL4kkb1O6Rk41DmcFLL5+kiVUs0DoDX2eDOxkcG2l4LtaatQ0TybwrUHLVb1xpV7Bs
X-Gm-Message-State: AOJu0Yy2FuRaT6QU7ihW6BjJzsIei4r5Mg6X47QW4f+QdywbW15s7R2N
	sa3OuYYwOra0K++rQKvfAwoabY5VUe0y9mmOEUkXc2nsBRoS8zgfewokbYmY+kYyio1um+j8E4f
	r7PBfbFApzEaFbH3qxubeKXHsXI6dvt2gNl3+HE6e4sls3RszDxbXMv/LtIYDUQ==
X-Received: by 2002:adf:ff87:0:b0:33b:278a:15f5 with SMTP id j7-20020adfff87000000b0033b278a15f5mr1561247wrr.6.1707224227956;
        Tue, 06 Feb 2024 04:57:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+/r+BZJ1AMNA3sDifj1tOVO7pP7JJorz2AxV/XzGUJY3E9lJnU0Ig0zj4E2wS9SNs3sbxeg==
X-Received: by 2002:adf:ff87:0:b0:33b:278a:15f5 with SMTP id j7-20020adfff87000000b0033b278a15f5mr1561224wrr.6.1707224227590;
        Tue, 06 Feb 2024 04:57:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX10sRN0oC/+J0PgFJ0e+6CxNmAR+EoVRUnC55Q8jPprs+DMo8lofnd5V0xLOkzcFCXyjGwEO+/P4hmxx14h3WvgOzgKrLoYzB5P02x3DIbHw81oujWRSRX9qHdDquEyJq0hNaMdwJ+0l1li7amCld4XgNQVLUmwpHaTy0qDBzmPmhQrpVbXqQEZslPm/RG9XDgl7zcAYjlYqJFK9qD8PT4XiNsuYoxxeZskM+PXU6eAIfKo/Dn6B32F5yroddZN+L/vPklBdG7KzuJXl4Do5jNqb9oj+sMDvWpD3LUCobY6iYQq3jWr7F56ynCxevDzAX5HCsFbztkG6pSQT4GQaO1fBinA90nmB4/u7iqd+xpBmuga3DYxHNG6YAyeOOhQdi6ghqtY+dgvfy+8VzmLIf+LpuuXOsFbSaFGeGyRdAn7QqtCLSV80fMeX0oshSB8wE3azFAgMA7Zk9mvhuuwamsEa/2XRqEoB+GBJq+DWDBg0xOI9D//LFfdxjkYLI4qjyrTnYHc47NHvUNMqbjI5OVFSR3P7Fi5dE3QK4aBg==
Received: from gerbillo.redhat.com (146-241-224-127.dyn.eolo.it. [146.241.224.127])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d6511000000b0033af3a43e91sm2050801wru.46.2024.02.06.04.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 04:57:07 -0800 (PST)
Message-ID: <1f5fd28c7acaf22e09a8ae41b829ea9ac0a317b5.camel@redhat.com>
Subject: Re: [PATCH net] net: stmmac: xgmac: fix a typo of register name in
 DPP safety handling
From: Paolo Abeni <pabeni@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>, Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Joao Pinto <jpinto@synopsys.com>,
 Simon Horman <horms@kernel.org>, Serge Semin <fancer.lancer@gmail.com>, 
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 xfr@outlook.com, rock.xu@nio.com
Date: Tue, 06 Feb 2024 13:57:05 +0100
In-Reply-To: <Zb49M9fKRR2HeGhR@nanopsycho>
References: <20240203053133.1129236-1-0x1207@gmail.com>
	 <Zb49M9fKRR2HeGhR@nanopsycho>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-02-03 at 14:18 +0100, Jiri Pirko wrote:
> Sat, Feb 03, 2024 at 06:31:33AM CET, 0x1207@gmail.com wrote:
> > DDPP is copied from Synopsys Data book:
> >=20
> > DDPP: Disable Data path Parity Protection.
> >    When it is 0x0, Data path Parity Protection is enabled.
> >    When it is 0x1, Data path Parity Protection is disabled.
> >=20
> > The macro name should be XGMAC_DPP_DISABLE.
> >=20
> > Fixes: 46eba193d04f ("net: stmmac: xgmac: fix handling of DPP safety er=
ror for DMA channels")
> > Signed-off-by: Furong Xu <0x1207@gmail.com>
>=20
> Looks okay, but this is net-next material.

The blamed commit has been applied to net before Serge spotted the typo
during patch review. I think it deserves the net target, so the typo
will never land into vanilla.

Cheers,

Paolo


