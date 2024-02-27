Return-Path: <linux-kernel+bounces-83586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ADE869BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E8B1C22F49
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0DC14831F;
	Tue, 27 Feb 2024 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GnAkpX+r"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE01482F5;
	Tue, 27 Feb 2024 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050715; cv=none; b=QIKQFwjv8XuyGzVHFXzJr+/E10tNIh0gatgbwKJxP6ASiP0nGXiu9tD7toUlil5w7A4phgGTpU4DYpyf07P1lOJWV0KOuyAy71AogAhuEGYM5t5vcPISuJF/MoW3wh4HPvhMHV4mfA40JjJjWewcPIMSrK6ge7rnW8C3U6Xb++I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050715; c=relaxed/simple;
	bh=8jzB12U7eaeJ7iZKhIrGbomEj2GPEGQMeudR/3OpjlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJxozJqaL7OSdHDmWJQAJNnKKWIgJf4ECosuodurGDUapvWz3l3DXSz0CUR/lYRA9DXFiAjTHXYEEfYhWzQc+Q5BMhze8/Oy3/68GcOknDmYvROW/VNhULx5kM3+cIQHTeMC64asMTk+wZjViGG4EHwXH4Dbh2RN4CvuMMVZwkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GnAkpX+r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xy+YBUBt7Fbhm/C9bGcKgBSMqkXQX+ab81pGfZyrjfo=; b=GnAkpX+rSx4xKNsjYNU/5dh8+L
	ZtcOCzuiRICGQL9fbS0mW5+I5PMioYJUj3Y73l1cEiIM/Qn9/aphayHRnA3v5wQuchh2GvHxdzv7c
	PHHEkNd+LBOfM1jrPr4sF8yKryKD8iAHKQB6K4Tx2OTtGaoOmviC88Mu3EDFMoTSNq24=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rf0AC-008rvK-Ni; Tue, 27 Feb 2024 17:18:40 +0100
Date: Tue, 27 Feb 2024 17:18:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com, maxime.chevallier@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: Re: [PATCH v2 6/6] net: phy: DP83640: Add fiber mode
 enabling/disabling from device tree
Message-ID: <a9c2144a-f26b-4a71-b808-ce3a94f1264d@lunn.ch>
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
 <20240227093945.21525-7-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227093945.21525-7-bastien.curutchet@bootlin.com>

On Tue, Feb 27, 2024 at 10:39:45AM +0100, Bastien Curutchet wrote:
> The PHY is able to use copper or fiber. The fiber mode can be enabled or
> disabled by hardware strap. If hardware strap is incorrect, PHY can't
> establish link.
> 
> Add a DT attribute 'ti,fiber-mode' that can be use to override the
> hardware strap configuration. If the property is not present, hardware
> strap configuration is left as is.

How have you tested this? Do you have a RDK with it connected to an
SFP cage?

    Andrew

