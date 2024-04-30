Return-Path: <linux-kernel+bounces-164354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC4B8B7CAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE1C1C20361
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDC5176FB2;
	Tue, 30 Apr 2024 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="JQMmw3R4"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38D51F5FA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494085; cv=none; b=F3qSFc9Mq7Axupneme1jxBHPBO5eBuDq3X8gZogdMN0/1u5K1MWoNPTJ2QOfkkEC6bsfYG1WIkEpIS9VJVf6O3e0eppcIMpfcbMEvnLQ7oJJolRybHqnLaQCaKCvCWn8aFRPShd68rag9B7Wz8APP8d6B6hkRnLZWsg2TXkBBpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494085; c=relaxed/simple;
	bh=ov2E1LXdhcvn+0Sr5iHwYH5U7dgRXwLTnepFTt5jYFA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QX5aMChUhPVYiEy1ovD4hmYol2+wmQ4X5xuJ4eKm5Lglq7aqB5E8RUpV09PPoWzKYLMbU8XuzTvPWMN6HJqZd6VwYayBkSHtG9+PiWyBp168rJ71ta3c5dy6nQNf+VMeAHUqywifd2hcjUxqsbOJagxl9cS4sQ3nKnTapDiFrrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=JQMmw3R4; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78edc3ad5fdso506807285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1714494082; x=1715098882; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mXGOQl9cAc/ekX6puhK0PlxYSMCVsGhUyl3CG8jYDPk=;
        b=JQMmw3R4W4v6+xgTFQKHTrS+YqwrJ9EwGqvGJyu4xwjHdvK5UPHAYAaDDGRczKAh3w
         PzF8oaUX/YSmzdFLsPJrdTruNGvs2wylBkpLzqTnRhXzOYlJKlMfb4uBzQnHUCzOV1Sk
         JAciZu3zSr7J8x1GRB3KlROEGzyUni9L2QbkXCVXWtVvP+Ko2IGcyHglv4mhqMzF7h4G
         UedjAv3gkQXEDawtfDAUWWtNNlgvXN/y0FUedxuDWdiNg7Jz8heOYlJwbgUILJEvUuAf
         Tw4udcSd+RpSEgyi+6fqH3ZHvwhEMgTkrNHJayYn/sKgxapDHIRGb0A9XPTC6SFhL5Mk
         fjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494082; x=1715098882;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXGOQl9cAc/ekX6puhK0PlxYSMCVsGhUyl3CG8jYDPk=;
        b=S5ci2V+bUkiV0cqgIO8Bb07lmcxAZ5cn9iRKRKsjhivFAySp0mQSeFBkjs0lBSTfMS
         kdP4NYMVvKptRqnQTj0bAx45egIQt2PfjdToeGivVAYBWHUNXZ59bPZZ+rRBAmf32XqL
         m8MqxrXSRetIcQ8XwjwiLJ40vEEqkI6EAKe0jRcROPIT6ZTxPti47M6+7IaCmnzGzOaO
         cuj5TWazxFH5UcIZRriCXENK4ZAmUCvMA0DOHYungB5xqoBCV8yZcLu6SXGoUPPmD3V8
         LGM26lrPpyk6Gj5mRgczWFDhVxP5DLZgydItVlp07+fG0qQpxNfkPNKUx3vL7uuxlfEg
         TyGw==
X-Forwarded-Encrypted: i=1; AJvYcCUYcarOM5ddadLOrMkvdVijketF04trHw2mZwK9krJDuxAgJ0Tv1HrTQBtvFlcZ7WhUAnvkgpwKOs7crMauWv4NRoduzC+fEHKEwq/b
X-Gm-Message-State: AOJu0YxuhqHuUJ+62q4JKjVWM92nApLCSYnetzbzGWM01Tl4VCMJ6UK5
	KQmw0pvQp4d/17cocKmM4LPfuaNhO3E9GT5oIuOuxDMyfnfKctFrgPp2k5FfTFo=
X-Google-Smtp-Source: AGHT+IH0NQBZBOgLEKq2kUdCPO3ctmAmOrn9KlWUcdcpsDQVdL8XpPMfwth/n2qHT+VVUlEawW7vPA==
X-Received: by 2002:a05:620a:4054:b0:790:edd8:ac18 with SMTP id i20-20020a05620a405400b00790edd8ac18mr5590333qko.35.1714494082626;
        Tue, 30 Apr 2024 09:21:22 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:17:6448::7a9])
        by smtp.gmail.com with ESMTPSA id i15-20020ac8764f000000b0043a7f359414sm3946068qtr.19.2024.04.30.09.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:21:22 -0700 (PDT)
Message-ID: <59899cfa3d3245309ce6952ae1028dceae27b488.camel@ndufresne.ca>
Subject: Re: [PATCH v7 1/2] dt-bindings: media: rockchip-vpu: Add rk3588
 vpu121 compatible string
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Jianfeng Liu <liujianfeng1994@gmail.com>, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
 mchehab@kernel.org,  robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de,  sebastian.reichel@collabora.com,
 sfr@canb.auug.org.au, sigmaris@gmail.com,  linkmauve@linkmauve.fr, Conor
 Dooley <conor.dooley@microchip.com>
Date: Tue, 30 Apr 2024 12:21:21 -0400
In-Reply-To: <20240430024002.708227-2-liujianfeng1994@gmail.com>
References: <20240430024002.708227-1-liujianfeng1994@gmail.com>
	 <20240430024002.708227-2-liujianfeng1994@gmail.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le mardi 30 avril 2024 =C3=A0 10:40 +0800, Jianfeng Liu a =C3=A9crit=C2=A0:
> Add Hantro G1 VPU compatible string for RK3588.
> RK3588 has the same Hantro G1 ip as RK3568, which are both
> known as VDPU121 in TRM of RK3568 and RK3588.
>=20
> Note that this VPU also has a jpeg encoder, which is one part of
> the five VEPU121 jpeg encoders on RK3588. So this VPU121 shoud be
> the same as vpu@ff650000 on RK3399. But we don't use the compatible
> string rk3399-vpu because of two reasons:
> 1, rk3399-vpu has disabled H264 decoding because RK3399 also has
> rkvdec to support 4K H264 decoding. And we need H264 decoding because
> rkvdec2 on rk3588 for H264 decoding is not supported now.
> 2, There are five VEPU121 jpeg encoders, but the kernel driver can't
> do scheduling. So it's better to disable the VEPU121 jpeg encoder
> at the moment.
>=20
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/=
Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> index c57e1f488..2710bb2fb 100644
> --- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> @@ -31,6 +31,9 @@ properties:
>        - items:
>            - const: rockchip,rk3228-vpu
>            - const: rockchip,rk3399-vpu
> +      - items:
> +          - const: rockchip,rk3588-vpu121
> +          - const: rockchip,rk3568-vpu

Sorry to come that late, but I'm noticing a big mistake here. You said you =
are
enabling VDPU121, the JPEG decoder. But we don't have a JPEG decoder driver
mainline, is there some patches missing ?

Nicolas

>=20
>    reg:
>      maxItems: 1
> --
> 2.34.1
>=20


