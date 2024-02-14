Return-Path: <linux-kernel+bounces-66105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BABF38556FA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E2D28D75D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACC21419BB;
	Wed, 14 Feb 2024 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dWDTxDVg"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EED13F006;
	Wed, 14 Feb 2024 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952443; cv=none; b=TTnrgnKzp9fV+CMBqnME+gqobyCrXaN0KId+9uSHTRirYgL6nedpyijCRUFXughoLM+NCuIs1wVR98Wts8a6En3INi1yvuCy4NF35kOpIjI+nx2rAh6k8rGEG9UGxwFM/B8EXUw4d6tluntC6uom7BJiMq/JmkceU265ywoBpUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952443; c=relaxed/simple;
	bh=gLQgyk5X0dfGFtt2TT12BCejyHtjgLKvuI1NVtt0538=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MTB51t14FxkxtnyOXmhW/qSP+6hxzp0GpVXgZUm17qrLnsL4pent859xP1fiP9jzBI/tNGfdSM85cUrNBl8dzlxbgODeX1E63VsZdg8wxgp2XPT6Th1dAyzKi5MwVVJO7tmYwO+bWZ477lUCNmHZSWQ9v2MjIg5eP4uNZTDdY3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dWDTxDVg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ww5EvsQOF699jHBYzWd4MuRfBoadfrzO0BL2hjc2gH4=; b=dWDTxDVgFCcm1eSezpPWqrkHOt
	q1YKXH5ZsiCxLqjUpS1X8SFfaQPmlJimqna1uzCpAbUuPpNIpISxhJA1NQAHbJumWFQga4pcsYdtM
	THBl3jyIuWyFcXmHbjapk8+Z+1n9k9rTKaJGvNPeYo272zJSaB50K+eQE0YdvWXxVg1U=;
Received: from c-76-156-77-114.hsd1.mn.comcast.net ([76.156.77.114] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raORx-007pqx-4l; Thu, 15 Feb 2024 00:13:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v2 0/8] drivers: net: Convert EEE handling to use
 linkmode bitmaps
Date: Wed, 14 Feb 2024 17:13:17 -0600
Message-Id: <20240214-keee-u32-cleanup-v2-0-4ac534b83d66@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA1JzWUC/3WNQQqDMBBFryKz7pQYU4ldeY/iQs1YQ2WUxIhFc
 veG7Lt8PP77F3hyljw8iwscHdbblRPIWwHj3POb0JrEIIVUQgqFHyLCUEkcF+o5bDjo2tRaPbT
 RAtJsczTZMydfwLQj07lDl8xs/b66b/46yuz/Z48SBU5DTUJXsjFN3y6B+T7O0MUYf58MDWG4A
 AAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Ariel Elior <aelior@marvell.com>, 
 Manish Chopra <manishc@marvell.com>, 
 Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2155; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=gLQgyk5X0dfGFtt2TT12BCejyHtjgLKvuI1NVtt0538=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlzUkiGKMiPon6NtfhjVIhDqS+MTgu2ROwdFN6V
 xw/QM+lh/CJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZc1JIgAKCRDmvw3LpmlM
 hEvuD/wLKhX67mktUeliEEcXu/9ijGnoEzC9f7I6P41hTv8taKyQCcsxwJXIqrxHPqgmc8UaHFY
 nTaYI7j1ZPgZl2in7IoP8z70KgT2oZCi/6RAL1G8zybnb7UapD6fXbuZQoxN11sShSD9z9ld+X8
 foRAPfcma7ZDRLfOBejWREPkkd1eNVqs5uQhZMnyKI0i8+8uvW5fMIN8z7qF7zBZVnqESvDe8Vi
 dMI/zyq8gyiCrX5xtyKQ54dzTw1HxpMJ7n4PTkASp7YdsRFKYSFzJLJbcGHhyAeB+zhZ/xrrp2B
 oVrv1aMfe9W73U0dNWhmj8Q7xIPf8Kv2L/EJUIoAfYo0SMXXruaNhf/XpquBMrueYZo+hRQ2lIS
 ftygWZnJfZ7FbsuI/qNreZSaIs2UNViUTAdGhtKwY/AdUE+24Ci2PJiwntVEBAzFytFM43OdH7K
 eZeCO0Z/aD7ePbow3zoayL6q8xMZNRtcakQV1avmlj6gX/tLCFYTxDHF0TgA5brp+hBwR5G5LSw
 OQv+YgMUYLzoV+nsyEbzEakITZEKnPOYdM//4+2dpEJSDGndtBtTFqaUlrv7FvVDJUBdj/jIKl7
 Vw+lMmIToHcfgiUUJ6ifCkyCCMR0j9nCnveYiaCRtPWbJDo1MxCuVGnfC+qrpZEDjckowyb5UyD
 yfZFeNXcYdE47oQ==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

EEE has until recently been limited to lower speeds due to the use of
the legacy u32 for link speeds. This restriction has been lifted, with
the use of linkmode bitmaps. This patchset convert some MAC drivers
still using the old _u32 to link modes, with the aim of soon being
able to remove the legacy _u32 members in the keee structure.

A couple of Intel drivers do odd things with EEE, setting the autoneg
bit. It is unclear why, no other driver does, ethtool does not display
it, and EEE is always negotiated. One patch in this series deletes
this code. Comments on why its actually useful and should be kept are
gratefully received.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v2:
- igb: Fix type 100BaseT to 1000BaseT.
- Link to v1: https://lore.kernel.org/r/20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch

---
Andrew Lunn (8):
      net: usb: r8152: Use linkmode helpers for EEE
      net: usb: ax88179_178a: Use linkmode helpers for EEE
      net: qlogic: qede: Use linkmode helpers for EEE
      net: ethernet: ixgbe: Convert EEE to use linkmodes
      net: intel: i40e/igc: Remove setting Autoneg in EEE capabilities
      net: intel: e1000e: Use linkmode helpers for EEE
      net: intel: igb: Use linkmode helpers for EEE
      net: intel: igc: Use linkmode helpers for EEE

 drivers/net/ethernet/intel/e1000e/ethtool.c      | 17 +++++--
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c   |  7 +--
 drivers/net/ethernet/intel/igb/igb_ethtool.c     | 33 ++++++++-----
 drivers/net/ethernet/intel/igc/igc_ethtool.c     | 13 ++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 48 ++++++++++---------
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c  | 60 +++++++++++++++---------
 drivers/net/usb/Kconfig                          |  1 +
 drivers/net/usb/ax88179_178a.c                   |  9 ++--
 drivers/net/usb/r8152.c                          | 31 ++++++------
 9 files changed, 123 insertions(+), 96 deletions(-)
---
base-commit: d1d77120bc2867b3e449e07ee656a26b2fb03d1e
change-id: 20240204-keee-u32-cleanup-b86d68458d80

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


