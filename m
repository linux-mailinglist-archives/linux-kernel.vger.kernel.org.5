Return-Path: <linux-kernel+bounces-62003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A86298519E9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B84283AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F5D8494;
	Mon, 12 Feb 2024 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhxfrIEK"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327B3154B1;
	Mon, 12 Feb 2024 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756299; cv=none; b=kGXm84tcWKZJIpN6KvfyDOOkEaQ9QVVdkGto4iZXq4Jdelp5foi642IolzP1rnTRekhjY+yseMdS+9Htj1lhbbFwJHgAdCsrTmWbpIuLEY9OuL7FJzU9ALDFOUMyAaTdujCbqFLQa7mxEE52Zb8VfPny3jRMSuMUc3PZPqXlp3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756299; c=relaxed/simple;
	bh=4UAvf6tMeDjUjgIt85ujGhNvNkUKpw+Bw4u6o4GJWr4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kyKns+qIeDyv8mqGVHywz96DwRW2CYI2712qRu96CrXWMo35/QgLMY8SRoQbGgUfqms7MH8Y/Uudzx1maslK+mjGxODQWVv2JvfCtB6wD+tJs4860E3Nx8yFT1do25EMehtd+i02RCvUaxnOgy1nRgeI2eFzmb1QI0BSE2EUl14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhxfrIEK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33b86bc8974so500188f8f.2;
        Mon, 12 Feb 2024 08:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707756296; x=1708361096; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aogiPWx9iamxsGoJiTEZzs3mhZ4z87cPE84LPd+suNs=;
        b=jhxfrIEKhY30tE8jI6DMmdYrERAXe9jXyF4kni7RGrUu3rDiT/9T/BZQ8RlNDwioqR
         QgINlRiOW2tDXT80FZetJhSlxw8OER3wGeZsd9IR+W2pcMDaJ9AiJT6Gh+nlIZKQITGg
         xieAtNVs1NFbh7ziydT0ollvDCPXegdKEL6bMjeuEAwlr5ebpfjzTIzOCp7ZZuD1bBPi
         OftSKZQEjLJ2pQTw+vghXUhVbm+kkTVK8lTsMRrt3GOc8swRZXNwGhg9RMxqxk+H6XXs
         kryOC8ToPqLbh8Fu6KbfxVO56Ko73QS9y7bcBWSFNp13O3z/J+19JzVq8xFuvZdSFpGw
         7hZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707756296; x=1708361096;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aogiPWx9iamxsGoJiTEZzs3mhZ4z87cPE84LPd+suNs=;
        b=T50p6+tj46gKHSshiOHgrJwk3LmDsep7try7pYHfwQ7BOolLrDfDfbjlM5WgtVAfvP
         /CW17drYb9pPBhWhl+ez4s9MGLRl9WtC2+LBnYBUvxj4ARajG3fbHZivMbY00qt6r/LG
         32ASRxX6WDmVT4dpI2z6guKX8BnawS2tDV6pf/V6ZTwVQiFhL1XFMfCW7OvXtPrxdXwB
         ZM2NVfP1RnWt0gZuzCIIRkIbOesvsQTotY2xS6MzP6StakrYeI5LU8PRh/DKQu++976o
         U7XqhoIp+Qxsr/cF/293v9/OeOV2OLjdZG2d5n02TK2qV5aXVHHl6UC/alaIob5XXgqy
         alfw==
X-Gm-Message-State: AOJu0YwrhptCPYgK4dGMquTCUiSJpQNxPFzUU84AVktu/qKHHfXu8sue
	fyDMWhw8XsRlBccWxx6mPTp9/U6kR/WwiAF9bu6OoS3eXYcA92zg
X-Google-Smtp-Source: AGHT+IE2bXWI0Cjr/ufrLe9ZMhXhO3vMwdu8pOdp7/5tmJ3s20byT+ET+47/262D86z59Rglhlix8A==
X-Received: by 2002:adf:f050:0:b0:33b:4967:4d2 with SMTP id t16-20020adff050000000b0033b496704d2mr5545729wro.41.1707756296237;
        Mon, 12 Feb 2024 08:44:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCCznL4B0+Zm2htBLr3PiX2fwM06xhFy47awuh1W5sFjX6kE/NdvRa1VsW8o2EiNOyLJPpqDqnpRDm0A0virs6YAXAs1h+y5dAxKaWtTGGJmnWWeCrWifXynTD5NoZ5IWAwPWi9OFwgd3Kty8cGZk9M6DK1wjfo5HdKHtZO8AAepEqJjcpKF1Sztvp/dEMQn+D2P6JSrcGGsFoleyWTEPiWg4wsYu0Ly8YwjU17jLKHi6YkDIqNmc+2G7d6kLXRtJjxmxKPSUtiQC01KhIrnCnDdl0feWeSQTiADdogpq7NhOVI2TuznpdolRtXcL0NDPmpO0ol8BnWjCn185qaHb2QMyp4pCxci5B+P34vUhOUkEwKo3099qqeotcA3DG7cCc7nHWrFdlIe6ZHsQog5wKhzoGwOAzxHhTCLDeFCOQ5SJvFbvi5pa73e7FbnzSrh6XmaRBRKJEe0FlCjjqFNF1yWZWEIpPUP7OMWVEQJGhAme+ZI27yBklbw8w8HiVZtU3GEmL3hVkbhmomWScym9ZG7RVKPSx+x1wtjsFUz1jYSSDSaraXx73+oNLd0vYPlEvA49ICyZM84zKLm/gc/vqQ5hfr5H8JxZTl1M66F8PyrAnBCoNupbTquNGMFJvl5jpVKBh
Received: from [192.168.0.9] (cm-83-97-153-254.telecable.es. [83.97.153.254])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d6787000000b0033b541e987csm7206803wru.33.2024.02.12.08.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:44:55 -0800 (PST)
Message-ID: <61af7b121b23fe8ed06df5348692f862b9b125bf.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] phy: rockchip: Add Samsung HDMI/eDP Combo PHY
 driver
From: Luis de Arquer <ldearquer@gmail.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Johan Jonker <jbx6244@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Andy Yan <andy.yan@rock-chips.com>, Vinod Koul
 <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Algea Cao <algea.cao@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, kernel@collabora.com
Date: Mon, 12 Feb 2024 17:44:43 +0100
In-Reply-To: <20240205-phy-hdptx-v2-2-a7150814c047@collabora.com>
References: <20240205-phy-hdptx-v2-0-a7150814c047@collabora.com>
	 <20240205-phy-hdptx-v2-2-a7150814c047@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Cristian,

On Mon, 2024-02-05 at 13:24 +0200, Cristian Ciocaltea wrote:
> +
> +static bool hdptx_phy_clk_pll_calc(unsigned int data_rate,
> +				   struct ropll_config *cfg)
> +{
> +	const unsigned int fout =3D data_rate / 2, fref =3D 24000;
> +	unsigned long k =3D 0, lc, k_sub, lc_sub;
> +	unsigned int fvco, sdc;
> +	u32 mdiv, sdiv, n =3D 8;
> +
> +	for (sdiv =3D 16; sdiv >=3D 1; sdiv--) {
> +		if (sdiv % 2 && sdiv !=3D 1)
> +			continue;
> +
> +		fvco =3D fout * sdiv;
> +
> +		if (fvco < 2000000 || fvco > 4000000)
> +			continue;
> +

What about adding a check to data_rate, maybe like

if (fout > 0x0FFFFFFF)
	return false;

or similar, before the for loop, to keep the multiplication safe?

Right now it would be redundant, given that data_rate was, at some
point, encoded in 28 bits within bus_width. But can prevent future pain,
especially after changing to phy_configure_opts_hdmi.

Luis

