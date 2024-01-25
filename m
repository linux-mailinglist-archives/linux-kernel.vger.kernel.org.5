Return-Path: <linux-kernel+bounces-38252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B934983BD24
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026701C21C96
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC8B1BC58;
	Thu, 25 Jan 2024 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqL2T9fK"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106B61BDC3;
	Thu, 25 Jan 2024 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174561; cv=none; b=IcfWX9vOgWEsVv/Do5nj18hwn37xuxqPLI365OA4YWqSmksgSPAnNXEBTPEq1nV0RS7WekmZXbTGy34dbkWiglSqO3bCPD0r3JODFPVp73169Mu4Jf6s6XMR3K0MTusepcFEi3B4x89xpLIOcfZxSJXIbaOa/152bKnbmw8mpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174561; c=relaxed/simple;
	bh=bxot2MLwbGx+WPC8RaoJz1YWvtizCki2E8FaJi5WOzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjSL3xQcsdKUSUuammJy1Uthp3h5PZXfPrhIeJGtqXi/m5CNqpotTrHtKmneoRZy3LFfmHkT9wLxf36YFlxUGt3e4M7bJS12h1rug9eUjjb0CzCgqM0P9zuEpNt/6MX3oJGZTKtp55VsWIlJYYMJwA/02+GM+PSrajffL0NSaws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqL2T9fK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2a17f3217aso628540966b.2;
        Thu, 25 Jan 2024 01:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706174558; x=1706779358; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=68+k4SXoZiAs2Pfmb+T8MrZfPAp6t3J0ktPdjp0hv2Q=;
        b=YqL2T9fKFZ430JaMoas57izwGE0KFt7P2u7RWMYeL7Ke3ilU9KQTdQrvDG2viRwESX
         BuQKb+8xAJpQbQLkTqkCV7qginMkMdd4nxHtWmI3LDoReV+iGHIYGrHTwZYABVYfntP8
         NyitbCXI5eGwAyIEyHrRvsjT+bKgtVM4PE8Lks/0/ckL/0XYkGHmEze3oXLWEtOZ+NA2
         fvQL68vvh9aCxUiI4iIvboTTrr0zrQ+WsPzp2OdltEnWr51uUbfDsmrkjgzcwOqV55bH
         yKSMby6kAW4uk9v30NaZyh2Wn0Dw3wU7oK1itVz46d3M6KmQt0S1L99Fg/bJdOpV69vW
         JjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706174558; x=1706779358;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68+k4SXoZiAs2Pfmb+T8MrZfPAp6t3J0ktPdjp0hv2Q=;
        b=kjXSoF6DsaOdrrA+AdsjfLTeHTRrWX3DkfJVS1+3RUu3xS6I8Jb14ER3nyjG5gvzA+
         j2BN5IHT4LdhQ87tcKXtmOlgXcJouMS1tGBdB2qJrULIs7G3pAX1aFA3Ih6xREzAWp+G
         7SZjbJxscS3vp4jESpAMLvr0oLUUxRIQKbAHBwo48IsIpid3SUQDs6/QaBwbUXKRK8Qz
         3Isa6lcPjqR6Q/4cdbj4Q+bgy7JmtHkByy1K2wtAnyk5iAZE+E5A2rTQn0cnZN8ZAoda
         wRlMy6deWsiKbuFj+e4/mYXxJ/iAUpmnnUN8W7ICJNGD4ccPyKjc/WkI1TlZHJh3/0m9
         WfcQ==
X-Gm-Message-State: AOJu0YzxYplXlGizPGUtMphamKkTxsLkqEikEeZgykup8Y1FHO4DyxuY
	PUzynIyxX5NiDW9ErcCo5lIKxZUFgKYpUw2VFmynsP7g5IQwJ/u9
X-Google-Smtp-Source: AGHT+IGb3kYbCaRZ+ZhuSYYXxrrQOg6MShvOglOKLYhAH70eCEZmTYRZfmR7UOLljeac6wIatBkRnA==
X-Received: by 2002:a17:906:1ccf:b0:a30:fb95:9387 with SMTP id i15-20020a1709061ccf00b00a30fb959387mr407499ejh.75.1706174557914;
        Thu, 25 Jan 2024 01:22:37 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id gw9-20020a170906f14900b00a311ab95fbdsm815922ejb.63.2024.01.25.01.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 01:22:37 -0800 (PST)
Date: Thu, 25 Jan 2024 11:22:34 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Bauer <mail@david-bauer.net>, mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: dsa: mt7530: support OF-based registration
 of switch MDIO bus
Message-ID: <20240125092234.czwjwc3izmsl3ekr@skbuf>
References: <20240122053431.7751-1-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122053431.7751-1-arinc.unal@arinc9.com>

On Mon, Jan 22, 2024 at 08:34:31AM +0300, Arınç ÜNAL wrote:
> Currently the MDIO bus of the switches the MT7530 DSA subdriver controls
> can only be registered as non-OF-based. Bring support for registering the
> bus OF-based.
> 
> The subdrivers that control switches [with MDIO bus] probed on OF must
> follow this logic to support all cases properly:
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
> The use of ds->user_mii_bus is inappropriate when the MDIO bus of the
> switch is described on the device tree [1], which is why we don't populate
> ds->user_mii_bus in that case.
> 
> Link: https://lore.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/ [1]
> Suggested-by: David Bauer <mail@david-bauer.net>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

