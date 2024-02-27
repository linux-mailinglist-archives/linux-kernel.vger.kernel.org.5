Return-Path: <linux-kernel+bounces-82630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED0D86876F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB5829234A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E691B27D;
	Tue, 27 Feb 2024 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8AHpO8z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF8C746E;
	Tue, 27 Feb 2024 02:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709002497; cv=none; b=PtvbZ+0E04vlwB3XIu0fNJKhWyZeqv2z/SLGbUp6JlOlTN88XDy2qKGBr7SFnc+4+j6kiEu6Nc0sSS8tyXZhNTmEaN+4bMHITNGnNY7H6HTlWmT/O63AFlYF2heXsI1seNSmz1Dk93Y854EOek1P57xyzhfL0ZNnOaXa3C1A8/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709002497; c=relaxed/simple;
	bh=FPwMebFM2o6jQzfsdgj1qAPJb2Wqu8P+xP0DHOAs0A0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDH/oPMGUniSLLc+VNHmqL3y7MoBjymNnGp1xshl2/dfXnoED0TLOBfX9DcFyztBNQZVW1Mm8r+s6dlLl7TnQ9XgdUzlmv0TsrSLjNPY8oVfKgLFV8ncc8a8H2QGMaXrgrZi7YMbgB655Uq5uj3vXD5dxmVbs9D7ldEsDVx+6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8AHpO8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD43C433F1;
	Tue, 27 Feb 2024 02:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709002497;
	bh=FPwMebFM2o6jQzfsdgj1qAPJb2Wqu8P+xP0DHOAs0A0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M8AHpO8zyDCBdZpyTgvTsDj045t4JZBKRZX0ilBP18SqZa7tZBbUyhNkdytAM6P9B
	 1d15L8LeUMafIaw3VRQtONp6sNG7DDzwWECANnv2r7fuABJ2/7ozUdDXVHXIHBX+hQ
	 Hl2Zdi+8/7ywp6G4htZDbzcYY/3PHwsD+rZXXoK1KvNvprNVGv+KkkGfV5kKxsBq7d
	 bpHpWOrOo2ad5bB09mee1nsWtfKuVZGOgaUknOFMXSI1NRL/OSYFU7wqDrEKYmlzTj
	 nnKlfScJ9p8OgQw/+KWRFSMrINMEvHa6XiaECxmoR0bwGF9gF/FDzmDIa9uqViWMZG
	 292ABBoLwMbDA==
Date: Mon, 26 Feb 2024 18:54:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, Russell King
 <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/16] net: dsa: vsc73xx: introduce tag
 8021q for vsc73xx
Message-ID: <20240226185455.107f07a7@kernel.org>
In-Reply-To: <20240223210049.3197486-13-paweldembicki@gmail.com>
References: <20240223210049.3197486-1-paweldembicki@gmail.com>
	<20240223210049.3197486-13-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 22:00:42 +0100 Pawel Dembicki wrote:
> This commit introduces a new tagger based on 802.1q tagging.
> It's designed for the vsc73xx driver. The VSC73xx family doesn't have
> any tag support for the RGMII port, but it could be based on VLANs.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> v5:
>   - removed skb_vlan_tag_present(skb) checking
>   - use 80 characters per line limit
> v4:
>   - rebase to net-next/main
> v3:
>   - Introduce a patch after the tagging patch split
> 
>  include/net/dsa.h           |  2 ++
>  net/dsa/Kconfig             |  6 ++++
>  net/dsa/Makefile            |  1 +
>  net/dsa/tag_vsc73xx_8021q.c | 66 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 75 insertions(+)
>  create mode 100644 net/dsa/tag_vsc73xx_8021q.c

> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_VSC73XX_8021Q, VSC73XX_8021Q_NAME);
> +
> +module_dsa_tag_driver(vsc73xx_8021q_netdev_ops);

W=1 build generates:

WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_vsc73xx_8021q.o
-- 
pw-bot: cr

