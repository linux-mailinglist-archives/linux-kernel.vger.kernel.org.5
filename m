Return-Path: <linux-kernel+bounces-67928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C27D7857327
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6C52804E1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59261B952;
	Fri, 16 Feb 2024 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4sqZ5DE"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B34B1B94C;
	Fri, 16 Feb 2024 01:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708045260; cv=none; b=QWOLl7ST9mRbqgt1mwzolNEMkf2dZxmyBTQzSv89fPICMCVBewcjOv/zAOguiwegqQRy+hs7VWZ3kT/Z77x7+xNfTBymo1YqmBFtYhuI2j1Afpf3d7IKtbTJACCqgD/7XjmYm8c1RDO50tJQk6MMOaNgXMQIAxVTxRuYhlQvhvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708045260; c=relaxed/simple;
	bh=AmzPTvv5M4opzOrGDol8wAuHPupOVjr12LX5HdJiY0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OszL+gzW82JSFgrDUsdXp52GIWLH8i9JesIYSomHRlsgfsv9G3btkT4LqYYGAbqMbUib5khobL0wPFacdSXKoxSQAy0yhbt9ogWii0tEl/TPRFyyY78bMdvGIWctdh+CUAQJil4dWdHtrBIX7564kTDErZXevW5IGIg6Sj/dczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4sqZ5DE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d153254b7so157683f8f.0;
        Thu, 15 Feb 2024 17:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708045256; x=1708650056; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sA/QklIh0ei5Flo8BxEpchDfFmK+iFfJziNsfkxsH4E=;
        b=N4sqZ5DElB/RAK6xCFsDYOLqTm2RCHJYoTNgzZw2uSGRJMf8A0+r8Pt5kXkNYz2zHC
         20sSo+uhUzd2nlJHfuisuG6wsG0TDZBIqY+b3ZWGz9Kc+ZZt04BYnGrvyvu0ciM+M9MO
         tDM6cKJ87v5k0g8T5yMvMDfoljdeaOJPfYFnFld+mXf+ff+zpRZdJ3OSY6eTgYNCjiUX
         XkgMtIi248rZz1qjvWRXCtgrr5kdS+w35YbYypzbXEHpqGMiGsj1CcsiBmeibEZgAXCR
         ZMHvtXf9WI56cup7Q/Wwh+zFbhYwE05ycpUWDDa+LJ2RyYEizSUE2f12hCD06QBbpQci
         A76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708045256; x=1708650056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sA/QklIh0ei5Flo8BxEpchDfFmK+iFfJziNsfkxsH4E=;
        b=lXbLNxVySB/iK0pwretI7jvQE+ZzpyHp8nSlRMNrpPnBdmYmtlA4/5bSMDa7IDx2j3
         Bl1o49FEMTzyqDJ5UVEy6swksprIZvzFE9nPLb8YW/hnImCXO0uIqetbFYb4RPAyXl0C
         H0Lti9DQc3z034PyptaCc6otyuM/THeZVCkzfSu3EE71N5wXjwTwo1sIFJZK5H5A/nh1
         0nEvNgFQA4Ic+o3v4dxjtRUhsCdmOSyCmXql/PhefN3hxh24Ms+VNhLXmbrmA2t5Wemv
         HEg6UBzSJLDpoxxI9ER1jtqhrnZNTapSdOFIetPeGFE3qJDFFQEmL12Zq947ZARaw2JZ
         kvbw==
X-Forwarded-Encrypted: i=1; AJvYcCXe3ts6tzH5onNB/yx8Qn24p9+qcZCwLGpHvOnBpNzmGPtctyvQ8ifgRaBAZl9dzdId9LLRGvm8PbaolrJX7HZ+eDfYOIPgUuCVUqerCnqWWq5wwzN68C3KZ9qYYPjb1dtanheO
X-Gm-Message-State: AOJu0YwExE2V42PXACsl5+YN1aZS3CU7MYEjYQkFfn9IaijL/9TFAiyr
	02X4cgNR3Nyyp1cYQKXvgq9CWJZef2m0slmJrqfBrpPBiOANX7Uz
X-Google-Smtp-Source: AGHT+IHLdYf0etTI3WWCm+mBFGoOsJwiVWqy35pH8x16+kG3WcTlLbpXpZOTKr6e0lzPmWc7Xz33Sg==
X-Received: by 2002:adf:fe0b:0:b0:33d:1d45:60a3 with SMTP id n11-20020adffe0b000000b0033d1d4560a3mr83158wrr.44.1708045256264;
        Thu, 15 Feb 2024 17:00:56 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id x6-20020adff0c6000000b0033cfc035940sm621176wro.34.2024.02.15.17.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 17:00:55 -0800 (PST)
Date: Fri, 16 Feb 2024 03:00:53 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: arinc.unal@arinc9.com
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: remove OF-based MDIO bus
 registration from DSA core
Message-ID: <20240216010053.asbu75kdi65jjuky@skbuf>
References: <20240213-for-netnext-dsa-mdio-bus-v2-1-0ff6f4823a9e@arinc9.com>
 <20240213-for-netnext-dsa-mdio-bus-v2-1-0ff6f4823a9e@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240213-for-netnext-dsa-mdio-bus-v2-1-0ff6f4823a9e@arinc9.com>
 <20240213-for-netnext-dsa-mdio-bus-v2-1-0ff6f4823a9e@arinc9.com>

On Tue, Feb 13, 2024 at 10:29:05AM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The code block under the "!ds->user_mii_bus && ds->ops->phy_read" check
> under dsa_switch_setup() populates ds->user_mii_bus. The use of
> ds->user_mii_bus is inappropriate when the MDIO bus of the switch is
> described on the device tree [1].
> 
> For this reason, use this code block only for switches [with MDIO bus]
> probed on platform_data, and OF which the switch MDIO bus isn't described
> on the device tree. Therefore, remove OF-based MDIO bus registration as
> it's useless for these cases.
> 
> These subdrivers which control switches [with MDIO bus] probed on OF, will
> lose the ability to register the MDIO bus OF-based:
> 
> drivers/net/dsa/b53/b53_common.c
> drivers/net/dsa/lan9303-core.c
> drivers/net/dsa/vitesse-vsc73xx-core.c
> 
> These subdrivers let the DSA core driver register the bus:
> - ds->ops->phy_read() and ds->ops->phy_write() are present.
> - ds->user_mii_bus is not populated.
> 
> The commit fe7324b93222 ("net: dsa: OF-ware slave_mii_bus") which brought
> OF-based MDIO bus registration on the DSA core driver is reasonably recent
> and, in this time frame, there have been no device trees in the Linux
> repository that started describing the MDIO bus, or dt-bindings defining
> the MDIO bus for the switches these subdrivers control. So I don't expect
> any devices to be affected.
> 
> The logic we encourage is that all subdrivers should register the switch
> MDIO bus on their own [2]. And, for subdrivers which control switches [with
> MDIO bus] probed on OF, this logic must be followed to support all cases
> properly:
> 
> No switch MDIO bus defined: Populate ds->user_mii_bus, register the MDIO
> bus, set the interrupts for PHYs if "interrupt-controller" is defined at
> the switch node. This case should only be covered for the switches which
> their dt-bindings documentation didn't document the MDIO bus from the
> start. This is to keep supporting the device trees that do not describe the
> MDIO bus on the device tree but the MDIO bus is being used nonetheless.
> 
> Switch MDIO bus defined: Don't populate ds->user_mii_bus, register the MDIO
> bus, set the interrupts for PHYs if ["interrupt-controller" is defined at
> the switch node and "interrupts" is defined at the PHY nodes under the
> switch MDIO bus node].
> 
> Switch MDIO bus defined but explicitly disabled: If the device tree says
> status = "disabled" for the MDIO bus, we shouldn't need an MDIO bus at all.
> Instead, just exit as early as possible and do not call any MDIO API.
> 
> After all subdrivers that control switches with MDIO buses are made to
> register the MDIO buses on their own, we will be able to get rid of
> dsa_switch_ops :: phy_read() and :: phy_write(), and the code block for
> registering the MDIO bus on the DSA core driver.
> 
> Link: https://lore.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/ [1]
> Link: https://lore.kernel.org/netdev/20240103184459.dcbh57wdnlox6w7d@skbuf/ [2]
> Suggested-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Acked-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
> Changes in v2:
> - Remove mention to drivers/net/dsa/realtek/realtek-mdio.c as it now
>   registers the MDIO bus OF-based on its own, and now under
>   drivers/net/dsa/realtek/rtl83xx.c. I've waited until this happened
>   because if this patch was applied beforehand, there would be no way to
>   set IRQs on PHYs as the subdriver doesn't do that for the MDIO bus
>   registered non-OF-based.
> - Link to v1: https://lore.kernel.org/r/20240122053348.6589-1-arinc.unal@arinc9.com
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

