Return-Path: <linux-kernel+bounces-58376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A1684E56A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D672D1C20FF5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4B37F7DB;
	Thu,  8 Feb 2024 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p+yzr3Te"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBC12033E;
	Thu,  8 Feb 2024 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411059; cv=none; b=h02Ea78dOL9w8SM04bkZfHDRf3O4N3BSlykX5FTWLxsYZbywv3WXoSP+nfzjfU34t3yJ3kYMpOCTxmmc2Z7HF3imXwqqZQs9rFL77tzP/ZOzgVEKFnXmUr1cTLYcE9gTamgHxgojkXs4jOmwZS+Dz/Jth4f3pDNtWl2CTAAmLP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411059; c=relaxed/simple;
	bh=IpTWOJ7jw1jce6Nm7HL8Rn2M6zfevU0umwNI6t7pqKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu7qrmHmyCzuMNBl3pQhWcdAeWq3j7S21HO0RFUWLRrhXbeXJpYAcmCCseVhSoUtgVek2LwOq/L+jgEt2aPUq5czvSXQPk9GnKJy6oG7WRB17UhdcjZ4CqVkMGa90d+2iiIz7GEXMTk+g382FiR+n/F/Y9SAA7gF0TxEuX9H0Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p+yzr3Te; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=VFlLZXO5D/bkJdcVm5PdbHGTQa3JUoin3uH1z/Cctyw=; b=p+
	yzr3Teo7i/V4oJ23K8x0SfIj/Ve6c2Orr5VsA+vT4e0YQGaeW2NHntnqOuagBU34EfK1nqlF5dRD0
	rjfSn/QHulJQ9Oj92l7vtFtch205J0Ln+maSyR0JE6vV24GNNbwCxnRv5WiRPU1bSkRq8jKIw8cEx
	NsbQw3SFlNBPHVk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rY7bq-007KKQ-AL; Thu, 08 Feb 2024 17:50:46 +0100
Date: Thu, 8 Feb 2024 17:50:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"afd@ti.com" <afd@ti.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2 2/2] net: phy: dp83826: support TX data voltage tuning
Message-ID: <71efc6d3-bef1-4c2e-aa6c-195e26f791dc@lunn.ch>
References: <20240207175845.764775-1-catalin.popescu@leica-geosystems.com>
 <20240207175845.764775-2-catalin.popescu@leica-geosystems.com>
 <4dc382bd-3477-45cb-8044-fc5c2c7251f4@lunn.ch>
 <f37e9df4-e1bd-4d40-bd99-3998cfd803f4@leica-geosystems.com>
 <145e1c28-af2b-4aca-9fd3-f9d7a272516c@lunn.ch>
 <68f0b7ce-6c77-41b2-9749-1cd8f72c253d@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68f0b7ce-6c77-41b2-9749-1cd8f72c253d@leica-geosystems.com>

> Now, I understand your question 🙂
> To answer, DP83826_CFG_DAC_MINUS_DEFAULT will indeed leave the register 
> unchanged. However, dp83822 driver exports a PHY callback soft_reset 
> which does a SW reset which actually has the same effect as the HW reset 
> pin according to the datasheet. Since the PAL enforces the call to 
> soft_reset before config_init, in dp83826_config_init we can rely on the 
> registers reset value.

Great. Please add a version of this to the commit message. That shows
we did our due diligence and we don't expect any surprises in the
future.

    Andrew

---
pw-bot: cr

