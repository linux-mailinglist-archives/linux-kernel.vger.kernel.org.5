Return-Path: <linux-kernel+bounces-78673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0253A861708
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23701F27B97
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F89483CD3;
	Fri, 23 Feb 2024 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dYYKWQtp"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7005E83CAC;
	Fri, 23 Feb 2024 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704375; cv=none; b=K5XiISXvEsrQoImvt1Lit22OV9y+3WC5cFTw1ooVOc33cpiEdjjEW+ok7MPmbNZmKnJi+SdH+sYaUI0vTWHPtD/IEgTOG8DYOk4mfBdQn70oFXq/IPJ2tQbcXKj3pZTDUMDnhsopNUnzWEmHMBg2YQsTIwYkwpmPXJ/IWpWbDSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704375; c=relaxed/simple;
	bh=yKnpEwT+GUdr4sidHu1T7WVOyx1tP0rVrEJh41iue8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzA9I7CYrX2dDsc1aJCcTaSUyi6kfjBY4cEDhhOrhI7jywDkKVr+REpIJknZcYW0I+ksWe+780jkLVDCH+bnTDD+mnzhi53VtvLffCUaJky8XZ4Rr07KBTv3ghtyQ/Y86cFWenC/EaN41wkcTRGbNDGg7IC0oSSc/xa2H4svxW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dYYKWQtp; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ABB86240008;
	Fri, 23 Feb 2024 16:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708704371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKnpEwT+GUdr4sidHu1T7WVOyx1tP0rVrEJh41iue8E=;
	b=dYYKWQtpneyHT1LfFVIMoP1rtF3PWdboBPvFJkLWhTioSgGmd9L0wNoMA5Gh+IV/GNpEuS
	LZ8RyI7qGaC47hiGEiiG0IhJDXtHr4gsixqYudNaWi0qCFwDnfch2wRdNhLEzoF2a54bH4
	znc3lv6OV37uEFo84+toCqrRgf419ZtTyrYFHtNa959nYpPFy/00dxSCch3cLA5+wb7qhu
	1fLADf/upqwSoz6EauYtokv6M0yl1J50tN4lZ3F4rLmignnTMV+pxlg3QDV4QnGgjzf0oN
	A4S+pTW+vg6fphLokt6t5rfQjyzhPgh3zHygzJk6Z8ha1FOqfdR/hR4jIe0ihg==
Date: Fri, 23 Feb 2024 17:06:07 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Johan Hovold <johan@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: phy_device: free the phy_device on the
 phy_device_create error path
Message-ID: <20240223170607.0d2aa8b1@device-28.home>
In-Reply-To: <20240223160155.861528-1-maxime.chevallier@bootlin.com>
References: <20240223160155.861528-1-maxime.chevallier@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 23 Feb 2024 17:01:54 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> When error'ing out from phy_device_create(), the previously kzalloc'd "dev"
> pointer gets overwritten with an error pointer, without freeing it
> beforehand, thus leaking the allocated phy_device. Add the missing kfree
> back.

Disregard , I immediatly realised that this was freed in
phy_device_release in our case. Sorry about the noise.

Maxime

