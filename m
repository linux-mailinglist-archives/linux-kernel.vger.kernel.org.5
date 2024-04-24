Return-Path: <linux-kernel+bounces-157431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B88A78B1194
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D3928B8A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5311216D4FB;
	Wed, 24 Apr 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S35toCIt"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E23116D4FF;
	Wed, 24 Apr 2024 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981569; cv=none; b=qy2Jxi+f69eO5pTHZBoOZuEmA4BDxP0ust7NpO8YDiFt2xFEzB27s9Rw8s49BcIdUmrVDpZmB/9bgqfAx4BwsfUz5G5QZqE57oZiRr/+9wGxQYTpmljm9OBFkpzn5/7/pSIgOxfONtmbKl4A2phP9Mg7MWIfEmzoYZ5N3MJBX+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981569; c=relaxed/simple;
	bh=DclvhczCBGLD7U9ub5/L3zxMMJIP4QCaAQuzL4vaiWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slg2pRxOKgUXOjpe6K1fix7w8Dr4q4y8pgdkITkze1os0zbsTOHKlmV4ZCjvtMzK/tRDQmyacUBbUcQx5ZPkttVNItjYXrDy3LaMlfFQ6m/YLZ+BAN7ndGOuut8r+pGUPT9HQwRyRXaEfe7xZtCJhKOx8H106rNJNIztFkZru8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S35toCIt; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 19904C004995;
	Wed, 24 Apr 2024 10:59:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 19904C004995
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713981567;
	bh=DclvhczCBGLD7U9ub5/L3zxMMJIP4QCaAQuzL4vaiWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S35toCItajViRZRCNdF4hd1v3pgqDdRm4s3a3i0bKX/5Wa8DILzmZikM1Y26T3Ceh
	 873BLpPUv1DQgD8X72uUN65Ka3B5BOat2Sp0mP/2pFb2N5Ii4ApeppQaxPIRnkNczL
	 3wJ/UJvsQE13iiXcN4EZcNlVeaIVtU6n1OSXUXh8=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 1FE1418041CAC4;
	Wed, 24 Apr 2024 10:59:25 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	=?iso-8859-9?b?QXL9bucg3E5BTA==?= via B4 Relay <devnull+arinc.unal.arinc9.com@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Rafal Milecki <zajec5@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Tom Brautaset <tbrautaset@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	=?iso-8859-9?b?QXL9bucg3E5BTA==?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH v3 3/5] ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
Date: Wed, 24 Apr 2024 10:59:26 -0700
Message-Id: <20240424175926.1526934-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-3-23d33cfafe7a@arinc9.com>
References: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-0-23d33cfafe7a@arinc9.com> <20240423-for-soc-asus-rt-ac3200-ac5300-v3-3-23d33cfafe7a@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Tue, 23 Apr 2024 12:50:47 +0300, Arınç ÜNAL via B4 Relay <devnull+arinc.unal.arinc9.com@kernel.org> wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Add the device tree for ASUS RT-AC3200 which is an AC3200 router featuring
> 5 Ethernet ports over the integrated Broadcom switch.
> 
> Hardware info:
> * Processor: Broadcom BCM4709A0 dual-core @ 1.0 GHz
> * Switch: BCM53012 in BCM4709A0
> * DDR3 RAM: 256 MB
> * Flash: 128 MB
> * 2.4GHz: BCM43602 3x3 single chip 802.11b/g/n SoC
> * 5GHz: BCM43602 3x3 two chips 802.11a/n/ac SoC
> * Ports: 4 LAN Ports, 1 WAN Port
> 
> Co-developed-by: Tom Brautaset <tbrautaset@gmail.com>
> Signed-off-by: Tom Brautaset <tbrautaset@gmail.com>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

