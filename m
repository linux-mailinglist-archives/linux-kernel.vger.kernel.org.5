Return-Path: <linux-kernel+bounces-160562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4528B3F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D01A288545
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9A016DEDC;
	Fri, 26 Apr 2024 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="nl4E27/l"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26AD45037;
	Fri, 26 Apr 2024 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155716; cv=none; b=fR1wZUZQeeNNpyeTWLYkrXvJ7iCDZkkwGzW2JnjOsFYN4zjKPoy+peLAeAJD60nqgpqFqCJpXdl5XVeIAtpxV6SkixXwU9Or6kWLWG66wgLiLg/TBaWDxjh2wQc3SmzS2/RwfcNFRIg0/cdSPJ+BvnEtYHcqaNwHyi1OSdZu8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155716; c=relaxed/simple;
	bh=+rY3/lx41ZeUHmpMN3pJXo/hx1ZdE2dNW5kkVDSOidw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vbd/Z1H9Fdz9lwSHdFfkHUvBvii5OoxL9JNGgsslqHz39WSY7p6gO8ZBqjFdxpHFnTBuf5wJPRZLJNj9/Y/1pRHeSwHCzeJkuLBMS2RB08x21T0FaxudvyGrGVnkdU+zX3KNXJGI8jiRfZM5BWtqbLbMI34cbParLxag+1XEO2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=nl4E27/l; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id BE1A4C0000F6;
	Fri, 26 Apr 2024 11:21:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com BE1A4C0000F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1714155707;
	bh=+rY3/lx41ZeUHmpMN3pJXo/hx1ZdE2dNW5kkVDSOidw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nl4E27/lddLEWA/cpJOj8l47wlmdAPMcpbJBAFF9nWJ2dtNSYrGT0MJYZRB2K1OZB
	 3qMVa/DFHDgJNj/spaJEj9CdXO5mvsWmtqXx7EfJakgMKkY7/R7FOTk+ILc5H4mb8s
	 cE4EzfAVhZYqvS1IjYaxJ86fs83bQvpUp4TMTuCs=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id B85BF18041CAC4;
	Fri, 26 Apr 2024 11:21:45 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	andrew@lunn.ch,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Nick Hawkins <nick.hawkins@hpe.com>,
	Michal Simek <michal.simek@amd.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Paul Barker <paul.barker@sancloud.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] arm: dts: bcm2711: Describe Ethernet LEDs
Date: Fri, 26 Apr 2024 11:21:46 -0700
Message-Id: <20240426182146.2131789-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423191500.1443636-1-florian.fainelli@broadcom.com>
References: <20240423191500.1443636-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Tue, 23 Apr 2024 12:14:55 -0700, Florian Fainelli <florian.fainelli@broadcom.com> wrote:
> Describe the Ethernet LEDs for the Raspberry Pi 4 model B board as well
> as the Raspberry Pi 4 CM board. The Raspberry Pi 400 board does not
> include RJ45 connector LEDs so the 'leds' node is deleted accordingly.
> 
> The Ethernet PHY LEDs are numbered in the PHY package/pin list from LED1
> through LED4, however their address within the LED registers function
> selector is 0-indexed.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

