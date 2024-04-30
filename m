Return-Path: <linux-kernel+bounces-164789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2218B82E3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262EA1C224C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5921A1BF6FD;
	Tue, 30 Apr 2024 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="oBDqUP6v"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A5786126;
	Tue, 30 Apr 2024 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518445; cv=none; b=n3RNKKAGqe2GBnq7ub5ZJlZUWmliVSJKdRN9IGxi3iw4lNsgfMktqD8ftlHgAFloiL3uppnl7RIudtExpo5ruXxr7KdjhnI4b/sWlv7FNi5TQQP6pBaIcqActrKWv+NdnqfxD1B9MNK9/1D+A0hDkZOZmdQWOrYNQNXMYaq3Sxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518445; c=relaxed/simple;
	bh=UiF7/ghBykYpbovESaEST/D8hgIqcnXCpRmmKBl/9Sk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=H1NX609JmP2dUN9+CoubS5ow3GP8w62RSeBfDh5A6R1BUKWH1K/uSpRZJZxGRCfAgp7wTs03S9uVavSorobNkrcQYCPMyuN/TsQt3Ns93Y0xzRB65J2hKo4d3oN/bsEamENXS//zImzWobh6D/pZ61/Yp5e1SB1AlFHdlR/P1MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=oBDqUP6v; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id F1774C0000E7;
	Tue, 30 Apr 2024 16:07:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com F1774C0000E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1714518437;
	bh=UiF7/ghBykYpbovESaEST/D8hgIqcnXCpRmmKBl/9Sk=;
	h=From:To:Cc:Subject:Date:From;
	b=oBDqUP6vITqnxbcMmr3MolIwZ1dWIOYCJGNidwL4h5os2h8NmxNo3Cmt55c/lEUR5
	 wrg11/ojF+Tf+Ao0J3ZqIs+7MRrNc62UfcIbDrV6wCJjKnNBRDDEeav5QFqTjpJdJL
	 DIWomqwRhcRGTlK3h7kvS9M0QOdvh/1LtKMwL6/Q=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 1B16618041CAC4;
	Tue, 30 Apr 2024 16:07:15 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] ARM: dts: BCM5301X: Fix PCIe controller warnings
Date: Tue, 30 Apr 2024 16:07:12 -0700
Message-Id: <20240430230714.3923578-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rafal,

Here is a counter proposal to your patch series:

https://lore.kernel.org/all/20240423110238.32148-1-zajec5@gmail.com/

which is a little bit smaller in terms of lines changed. Note that with
either my patches or yours, we still have the following warnings show
up:

arch/arm/boot/dts/broadcom/bcm4709-netgear-r8000.dts:133.15-145.4:
Warning (pci_device_reg): /axi@18000000/pcie@18012000/bridge@0,0,0: PCI
unit address format error, expected "0,0"
arch/arm/boot/dts/broadcom/bcm4709-netgear-r8000.dts:152.15-191.4:
Warning (pci_device_reg): /axi@18000000/pcie@18013000/bridge@1,0,0: PCI
unit address format error, expected "0,0"

Thanks!

Florian Fainelli (1):
  ARM: dts: BCM5301X: Relocate PCIe nodes to top-level

Rafał Miłecki (1):
  ARM: dts: BCM5301X: Describe PCIe controllers fully

 arch/arm/boot/dts/broadcom/bcm-ns.dtsi | 97 +++++++++++++++-----------
 1 file changed, 58 insertions(+), 39 deletions(-)

-- 
2.34.1


