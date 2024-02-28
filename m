Return-Path: <linux-kernel+bounces-84415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDF386A67A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4733F1F21CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8551947E;
	Wed, 28 Feb 2024 02:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8dq+jJx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D8F63BF;
	Wed, 28 Feb 2024 02:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709086883; cv=none; b=qNH9U871rmEajAHr8dVGS7JCgf7HVLd8o9USkJVOzBpTX8oVdw9ZZIDsDWUWNFbiM3i+hykL8Tydxtrt1QJtzrEZTJdgLlm0Or2yHRSpUviuvD96Is62f/Xbf5BaX+aGqV8/PvRP47UTLFlXO5tzzCr5J4hQPJqCfixL4Carf/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709086883; c=relaxed/simple;
	bh=xZxmXfqYKc+OAJ6LSPpz1sYEgmU+RdmlU27lF29hLrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KX2JqBpwK/DRHsxIVKhANjPxZf9NcYL3LU4xBdEWv8qFzsEW+ZNvV5+R36Bu15RvHAP0s21+TXrWxdnf1/PJBe9Lpi73df8HhMaMKulTkLTgnmjoqFLcTSwvYHIeOYKYeuRqEdQzivrE8i2eFEoMo8E1QaXyqJyJNLqSiddxe+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8dq+jJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371FAC433C7;
	Wed, 28 Feb 2024 02:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709086882;
	bh=xZxmXfqYKc+OAJ6LSPpz1sYEgmU+RdmlU27lF29hLrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a8dq+jJxOgYA8WGLYp6tcJ/2kW/gr8MXR+GJVVNv07PU5+V1cJm2iGQ5FkFArEXJV
	 LvguIfMWhwHw+bgn4AnagWgMeLdoJb0JFxXC9HFg0wjWnZa6+iJGpCuukJ6caZTr10
	 OK0pp2HHWKeiYaVFf5USMQP3ixWLXu4aBYI7nGa+fceq5e/WMn6HAQ8xd0a22EzXDj
	 EpEirJ0vxTZAG7cbM3i1SKL+FRkOk7zSyDJFYnC97wUCwyBiU1EEUgSpEiJtrJAK/a
	 ODxlzOIxt4oysIYnVX8RXLn0OZU+BJeSe75YwAog0JPdhwKML2NwjcrUpQCl3dXez3
	 vQ1apNBEeXFZQ==
Date: Tue, 27 Feb 2024 18:21:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen =?UTF-8?B?QsOkdHo=?= <steffen@innosonix.de>
Cc: Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: mv88e6xxx: fix marvell 6320/21 switch
 probing
Message-ID: <20240227182121.055df038@kernel.org>
In-Reply-To: <20240226091325.53986-1-steffen@innosonix.de>
References: <20240226091325.53986-1-steffen@innosonix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Feb 2024 10:13:23 +0100 Steffen B=C3=A4tz wrote:
> +static void mv88e632x_phylink_get_caps(struct mv88e6xxx_chip *chip, int =
port,
> +				       struct phylink_config *config)
> +{
> +	unsigned long *supported =3D config->supported_interfaces;
> +	int err, cmode;

err and cmode are unused in this patch, please move cmode addition
to patch 2 and drop err which appears to remain unused after patch 2.
--=20
pw-bot: cr

