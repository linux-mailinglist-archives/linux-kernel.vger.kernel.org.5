Return-Path: <linux-kernel+bounces-60238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E138501CE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6D81F29665
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AA64C90;
	Sat, 10 Feb 2024 01:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JiSdTLJf"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0098723D2;
	Sat, 10 Feb 2024 01:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707529302; cv=none; b=Bly83cmGxJoS8FrrdTw57OptUYnt2F0EYSprssv8BnCZ3Wot3AAjYeVb3GBYq4P5lReNsxwlsTN3HtYJMykqiR2t0cd68kYbRL7NiVocmcCQ0p331dRFczPG2Tb9azuoWTM/8Pn2ny5bPThSMLyoZmD5Ek9H7hUJ+hRR2Vi2g/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707529302; c=relaxed/simple;
	bh=pFrHOmILJr7qbCi/S+lolbteXmNpgWRexn1o5Da00S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geFypYDh9fkChAOEmMdFwXoOr6LCvt7CYMSpiX1CeApObNDs/txDO/j1P+kBn6J6EwAZk+ExBcbJ4+87AOzwJFrHr2jNsCRyJXYi+cWWP/n/rNu/gd5VcFr68TIXawVVH/i7EBHPiU6NxbvYD1YzSVsVZeu+6Jt9odPP3cRfLb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JiSdTLJf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BLzW7Y/8c2/ag6+noiRzfUXrBz7t5LZulT+/Bpmfbzc=; b=JiSdTLJffjNTIbl4ECb4DaEbhj
	pKJdik7457NutgzHsGeww5rivj4Pb/O3nk0UQqHi8HdEyeP8TjTFpZaV6jA5Qdt3vHe7xob5ILFnH
	sYa2iV+7wCTaYwicWb+2y88ic1vsniRlPhWgmJItWtBbkiU+/cC3d8eKDT1GubhekhLo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rYcN6-007Qyr-RK; Sat, 10 Feb 2024 02:41:36 +0100
Date: Sat, 10 Feb 2024 02:41:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v7 08/10] net: phy: qcom: move common qca808x
 LED define to shared header
Message-ID: <7de8e4b7-a924-4793-a1f9-753116497f00@lunn.ch>
References: <20240206173115.7654-1-ansuelsmth@gmail.com>
 <20240206173115.7654-9-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206173115.7654-9-ansuelsmth@gmail.com>

On Tue, Feb 06, 2024 at 06:31:11PM +0100, Christian Marangi wrote:
> The LED implementation of qca808x and qca807x is the same but qca807x
> supports also Fiber port and have different hw control bits for Fiber
> port.
> 
> In preparation for qca807x introduction, move all the common define to
> shared header.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

