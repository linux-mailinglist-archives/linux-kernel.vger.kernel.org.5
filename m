Return-Path: <linux-kernel+bounces-157432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD1B8B1199
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE541F27567
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A55216DECC;
	Wed, 24 Apr 2024 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c7X5eaPt"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D916D4FF;
	Wed, 24 Apr 2024 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981578; cv=none; b=duNDyXGOl38A88Rht0wv0qr2sb4bbGYL6xVzkggsJ5frbtbGMJHECnDmc3QmUejdDPQ7tU5nZfjzPM87Z7pM4+cYnmEPzTjd6JZck33F9lqiZiS/t4QjpljwLf1CCREcwNOcWcQMQ4vJfwwsF8zhYdJXQRDbwynApRRVnSX+szc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981578; c=relaxed/simple;
	bh=/veUJopAkIUjc8wzJgZwVe4oSCNeeFHu9uxxV5n1XJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRRArw+Eigp812Zcy2IQp1ip2P/DVI8bdbGb19RajYTQ2yhy6R90OL/sWnNWRc5p6CbVm/cvpmIl29M5BHekENc1m8eLVq4SCp81ym58FJDQYO/IZChkH3RIjkyB5TX3/P2fTHv5rN9hzCGF0TiuVNew+JgO3HrqO9SANZHSIKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c7X5eaPt; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 742DDC00498D;
	Wed, 24 Apr 2024 10:59:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 742DDC00498D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713981575;
	bh=/veUJopAkIUjc8wzJgZwVe4oSCNeeFHu9uxxV5n1XJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7X5eaPtrb8/wgjefazfZ1yXVFOgDMpog3EP3VDe3RnkivwI4I0utcYTg79I80e/o
	 qiqk2j7lQPRB7Ns5AOjj2kx95uuObYcAlk6C2vQln59PQDrvuWI+xWM/Fuv/wkbxFt
	 5USSSSZIqtjFuzSg6WVI9VJjFJfzsIVfXh+vv+TA=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 832CE18041CAC4;
	Wed, 24 Apr 2024 10:59:33 -0700 (PDT)
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
Subject: Re: [PATCH v3 4/5] ARM: dts: BCM5301X: Add DT for ASUS RT-AC5300
Date: Wed, 24 Apr 2024 10:59:34 -0700
Message-Id: <20240424175934.1527022-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-4-23d33cfafe7a@arinc9.com>
References: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-0-23d33cfafe7a@arinc9.com> <20240423-for-soc-asus-rt-ac3200-ac5300-v3-4-23d33cfafe7a@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Tue, 23 Apr 2024 12:50:48 +0300, Arınç ÜNAL via B4 Relay <devnull+arinc.unal.arinc9.com@kernel.org> wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Add the device tree for ASUS RT-AC5300 which is an AC5300 router featuring
> 5 Ethernet ports over the integrated Broadcom switch.
> 
> Hardware info:
> * Processor: Broadcom BCM4709C0 dual-core @ 1.4 GHz
> * Switch: BCM53012 in BCM4709C0
> * DDR3 RAM: 512 MB
> * Flash: 128 MB
> * 2.4GHz: BCM4366 4x4 single chip 802.11b/g/n SoC
> * 5GHz: BCM4366 4x4 two chips 802.11a/n/ac SoC
> * Ports: 4 LAN Ports, 1 WAN Port
> 
> Co-developed-by: Tom Brautaset <tbrautaset@gmail.com>
> Signed-off-by: Tom Brautaset <tbrautaset@gmail.com>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

