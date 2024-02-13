Return-Path: <linux-kernel+bounces-63354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA7C852E12
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5672820A4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72B92BB0F;
	Tue, 13 Feb 2024 10:37:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABF6250E5
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820624; cv=none; b=kgJ0bBpvetYsASLCaCkNgJ1ZJTj3I8VCtY+hPULJefzTTU1aEcUmTmaS4z1ed3qYngZBeMYya8Yy7SGwujbosS2kBW+VCgZ6TryvGJGODqdHu8UJ9UE9w0wHpbbAPXU6Vl3UtrrehNODc8FO8is1RqdKbYIuk44VCLEJpr0DTuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820624; c=relaxed/simple;
	bh=NQFk6wv6h9t3jdfRJgwcW/SYE2bxvuDeigGOTR/4ws0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R8B6JIVs7/KxiNd33+nSYF6BhFawLh3U904OA811u0mN5/o1tZrmGLJ3AWGo7D9Yh4e7w+epBh7tAc1xispch59uSuD9LDYXEU3JeGR1tCN1v5Msu/IqnaJhJKW0wHYq/5DYFJ+YV3+d0xjPlx7whdYsG4ek2nShhVeq/x/qgI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZq9s-0003Ji-H9
	for linux-kernel@vger.kernel.org; Tue, 13 Feb 2024 11:37:00 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZq9r-000Sq3-Uq
	for linux-kernel@vger.kernel.org; Tue, 13 Feb 2024 11:36:59 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 9DCD328D55D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:36:59 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 6BF6028D51F;
	Tue, 13 Feb 2024 10:36:55 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id dc26c151;
	Tue, 13 Feb 2024 10:36:54 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v8 0/3] Add ECC feature support to Tx and Rx FIFOs for
 Xilinx CAN Controller.
Date: Tue, 13 Feb 2024 11:36:42 +0100
Message-Id: <20240213-xilinx_ecc-v8-0-8d75f8b80771@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADpGy2UC/23MQQrCMBCF4auUWRuZJMZWV95Dithk2g5IWpIaI
 qV3N3bt8n/wvhUiBaYI12qFQIkjT75Ec6jAjk8/kGBXGhSqEyqpReYX+/wga0WjJfbGmDNKhHK
 YA/Wcd+zelh45LlP47HaSv/Uvk6RAQVpp7C5Yu66+zeSH9xImz/noCNpt277ak10qqQAAAA==
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, 
 Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Srinivas Goud <srinivas.goud@amd.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=NQFk6wv6h9t3jdfRJgwcW/SYE2bxvuDeigGOTR/4ws0=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBly0Y9E5T3iPK50/89vKqgjcywzg9volRy+nQIf
 dUYqANooaqJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZctGPQAKCRAoOKI+ei28
 b0E8CACYXyqGOOSlVUU8TCQhBIQYUM7pvlFJyeiYZH6lEk+WOOJlHzCRj7m2H7me41Ph+IsapmR
 Dhw0+wnW2N/gY38OdzFsVPiYm9D5LW8TeIV4KsMyx6k6+rekLJ4lvfgYYEbMKxZqtmliJAwwTOC
 JK82YS/oatenIiKRfMehabQrk6nNkxUn3Ax/ABdTPDE21DVZjy+AwWV1Fh5H6yarXmrdUXd0sDo
 Fq25I0WAhK8FICjoXMGwUEcyZWrjooJUFD8WLEJ8NNryH4uG1s0OTqlgYqrZ4TTJZwPVwqhS0Jk
 97l52iA8Y4ynL8GY3JsxnNVFDZ6Wk5YwAFrysPByB8JKbn1D
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

ECC is an IP configuration option where counter registers are added in
IP for 1bit/2bit ECC errors count and reset.

Also driver reports 1bit/2bit ECC errors for FIFOs based on ECC error
interrupts.

Add xlnx,has-ecc optional property for Xilinx AXI CAN controller
to support ECC if the ECC block is enabled in the HW.

Add ethtool stats interface for getting all the ECC errors information.

There is no public documentation for it available.

Changes in v8:
- Use u64_stats_sync instead of spinlock
- Renamed stats strings: use "_" instead of "-"
- Renamed stats strings: add "_errors" trailer
- Renamed stats variables similar to stats strings

Changes in v7:
- Update with spinlock only for stats counters

Changes in v6:
- Update commit description

Changes in v5:
- Fix review comments
- Change the sequence of updates the stats
- Add get_strings and get_sset_count stats interface
- Use u64 stats helper function

Changes in v4:
- Fix DT binding check warning
- Update xlnx,has-ecc property description

Changes in v3:
- Update mailing list
- Update commit description

Changes in v2:
- Address review comments
- Add ethtool stats interface
- Update commit description

---
Srinivas Goud (3):
      dt-bindings: can: xilinx_can: Add 'xlnx,has-ecc' optional property
      can: xilinx_can: Add ECC support
      can: xilinx_can: Add ethtool stats interface for ECC errors

 .../devicetree/bindings/net/can/xilinx,can.yaml    |   5 +
 drivers/net/can/xilinx_can.c                       | 169 ++++++++++++++++++++-
 2 files changed, 170 insertions(+), 4 deletions(-)
---
base-commit: a3522a2edb3faf8cb98d38c2a99f5967beef24e2
change-id: 20240213-xilinx_ecc-8310f5556010

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



