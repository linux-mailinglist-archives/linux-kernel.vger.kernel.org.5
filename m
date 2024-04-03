Return-Path: <linux-kernel+bounces-128896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9326E896195
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEBE91C22599
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CF4D527;
	Wed,  3 Apr 2024 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o23BVmGE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE812E47;
	Wed,  3 Apr 2024 00:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105138; cv=none; b=t5JY05QFdqhTypWYWFilaxo5mGDqH8tS+EJcrFHGvdSH1YMntv/hh1szIRWKnH+xf2s85KAVt/hIM5UK9mLoLgsRF2dTURCOXluHBkE0pOJS2Z3PkBpEGhx+b12AZZCsz9V8jYGuTUaTsKc5RbwfLU6alHZNIQ2/+3gWDqaIzHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105138; c=relaxed/simple;
	bh=1iP1fkRum/nFXhcUmp2itsi1QhT9K7/xfja8hI0pYKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZW45sbZpZXrMppPcZRgD6ahaey8+sEce5o5FBKRX03VT1pOqR8DjqhphfUsyroy6ePeBQzCo4mxTXJ8tsBxUnxQnAhWfLAp5VFKEWhDYmKB7CY1UDi5p/C3Gtv8kV/9vwpaEzFgyoI9sB2bfBzAk1Uj84R/3/tKKyyAgUEr0qsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o23BVmGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E208CC433F1;
	Wed,  3 Apr 2024 00:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712105138;
	bh=1iP1fkRum/nFXhcUmp2itsi1QhT9K7/xfja8hI0pYKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o23BVmGEARVXMcTI63k8Ku8hl1/4DIdGxDB0thK6nl1dswtD2nxNw5ODAnGs/9IVJ
	 VCVV+gPtUdXGE/hqCVJuVqym3Rh86EvSH8roe8TzHOswlGR+7UQvy2yacAopZQ9XmQ
	 NBwkIxJwpJYmZrm3bXrNParV4RxRpeYXpK/x5IGgx19jfdUsmexRZBIsoaH3DAzbB0
	 lXkLufrVXj0vjWePK5VYtTt4Ad7wPZOOCKSW3i4VZLErqyFurmalKAip6nbAB67f1C
	 y8y1scvP4sQOmpY6riRUEQUbQOrFK8c4kms2DYpdS4TvOAEQ6deFbyd4oHBDDwU8mV
	 EFO7kBHoZiJFA==
Date: Tue, 2 Apr 2024 17:45:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 m.felsch@pengutronix.de, bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH net-next v2] net: phy: dp8382x: keep WOL settings across
 suspends
Message-ID: <20240402174536.75cbe074@kernel.org>
In-Reply-To: <20240328133358.30544-1-catalin.popescu@leica-geosystems.com>
References: <20240328133358.30544-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 14:33:58 +0100 Catalin Popescu wrote:
> -static int dp83822_set_wol(struct phy_device *phydev,
> -			   struct ethtool_wolinfo *wol)
> +static int _dp83822_set_wol(struct phy_device *phydev,
> +			    struct ethtool_wolinfo *wol)

Why the underscore, you can all this any number of things maybe
dp83822_config_wol() or dp83822_apply_wol()?

