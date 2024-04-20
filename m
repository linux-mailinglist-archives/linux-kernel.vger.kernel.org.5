Return-Path: <linux-kernel+bounces-152333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A368ABC8B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 19:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245241C21154
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 17:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B39539FF7;
	Sat, 20 Apr 2024 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oP0EDJoK"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A9BB669;
	Sat, 20 Apr 2024 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713632997; cv=none; b=FAe2spvUwMnR30PJcbUa9AzPBkoQEtvUzvtMwcElCPM0vADefYjOk+wj3GNZkJkj/0GM/eTvXYpe81HrGOF6nONZhlryGM/oGwGSqVz42zOCBLzMgfg7XBCfou6YSgvW9YVboQVcW9fO5nsGYwEQgwDnCpOxZZHRopyMqQbDtkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713632997; c=relaxed/simple;
	bh=0dVVpE/Ef2ZFUlq2btvCHR/zVZNJ9htirrWD1+sakCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcfMGbYAXFTi52ZNg/Xqszlv2R0x8mZ1JFnE/yv3mKAn1yJQqlKG55x9FW+KmFmupfre/E5lvYE4Ghj60a0I/5rdQuocEPbp7Ksha/iIURq0LWsoH1Vv6YY71M+dTFEKzKCuPZG42blNaSzXZb2YY9cC2UUVdqs7bmqPOgOYudk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oP0EDJoK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QJQv0IFfhCqqi5fGOn/2mKzOeCfHNZDrDncRR4s5SZs=; b=oP0EDJoK3Y66j0EyeUL0e8B6Ms
	0mqIUIQkm0RBDhCiH3xgjBq8AFgVIQWi2hxz/Co8ot1OtG+SIP17a7+/YigvV9/NKo4DmG++YWnSZ
	HZow2w+e8XBb6IBw/wnp5AnioOiFFpCjPVopZr9GQqIsbOZIMmDIJah9innXzfsKDoe4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ryEDb-00DWNy-5x; Sat, 20 Apr 2024 19:09:39 +0200
Date: Sat, 20 Apr 2024 19:09:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jon Nettleton <jon@solid-run.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: adin: add property for
 link-status pin polarity
Message-ID: <2c622947-3b54-4172-b009-0551f43c3504@lunn.ch>
References: <20240420-adin-pin-polarity-v2-0-bf9714da7648@solid-run.com>
 <20240420-adin-pin-polarity-v2-1-bf9714da7648@solid-run.com>
 <41567aec-adf2-422a-867e-9087ef33ef36@lunn.ch>
 <b3c4301b-afae-44fb-86c5-94f23d363c0a@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3c4301b-afae-44fb-86c5-94f23d363c0a@solid-run.com>

> Main reason for having a vendor-specific and non-led property
> is that this pin is not a led.

So you are not driving an LED with its? What are you using it for?

> This kind of configuration is much more like pinctrl than led.
 
So what is the pinctrl way of describing this? You should not be
inventing something new if there is an existing mechanism to describe
it. We want consistency, not 42 different ways of doing one thing.

	Andrew


