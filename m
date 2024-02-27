Return-Path: <linux-kernel+bounces-82522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEBD8685CC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75552865F4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064615C89;
	Tue, 27 Feb 2024 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gs2hyjJR"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6904136E;
	Tue, 27 Feb 2024 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997385; cv=none; b=aXBlfJ3XWgYP17sJF5sJcR3MZT2dlToKo6k9SAR5QN7I1XPgxfWFAJ+rv+P1txdX+wA1UJIc8od7tmu/LOavrEUIVkDKJSMHiwAR4gppiw/5sf4kDQxIEfvEvSNlbBAWAlvdaVS9aM7AO2LO2bY/rq/HIwXht+mqQMMD7aoKfXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997385; c=relaxed/simple;
	bh=X9uF/uCVLaYoZ/UKfRhY0Z/OtU/iRssDZmmPq6jkPiM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hta3X0/AaosfIDEr6KF9zLSoGwLLA8C809rkZbEfVxDxMJsVLy3rLJp3WRJldWuiAX6hOif3oeRoFyW3GpW5ugp2U0XHLuVbxAYp4zoIrGAZuxqW1EMw4WgUcRYMMSpZ16Tku7Q2CeUl2QOrqkk9KCA2ePilIYPONhymMTlQSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gs2hyjJR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E00RMWjz0kyaXuAuFrpIZAawFdA5eOtO3b61GfROLOc=; b=gs2hyjJRfYIytPByhHfY+tvJxF
	Hs9orAF8y7IH78BCZebggQ6gGQVRulrBASCr3Gqi2zkkLHp2vdX3YV6Z3Js1PlXclJXJBWbDEO/dn
	xei5YpU/iVoZkI5BD/LvEgEQUfVc6u5IvOVMhDtzTJAjyItPpxqRmZGTNCK+hPhRSbU4=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1remI1-008mef-Hg; Tue, 27 Feb 2024 02:29:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v5 0/9] drivers: net: Convert EEE handling to use
 linkmode bitmaps
Date: Mon, 26 Feb 2024 19:29:06 -0600
Message-Id: <20240226-keee-u32-cleanup-v5-0-9e7323c41c38@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOM63WUC/3XNyQ6CMBgE4FcxPVvTjVI8+R7GQ5e/0kgKYQuG8
 O5WLkKCx8nkm5lRB22ADl1PM2phDF2oYwrZ+YRsqeMTcHApI0aYIIwI/AIAPHCGbQU6Dg02Sjq
 pRKacIiixpgUfpnXyjiL0OMLUo0dqytD1dftev0a69v9nR4oJ9kYCUZwVrtC3aojxYst1amQbT
 o84S1xom3FhFHdS7jnf8vyA8++79dJIponN/Z6LLVcHXCSeU0+5yS0HSX58WZYPUsEI7XUBAAA
 =
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Ariel Elior <aelior@marvell.com>, 
 Manish Chopra <manishc@marvell.com>, 
 Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3525; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=X9uF/uCVLaYoZ/UKfRhY0Z/OtU/iRssDZmmPq6jkPiM=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl3Tru++alK1pI+HFFTn3B6TRBO+BgOSJimGIPa
 V5ZehTnmfCJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZd067gAKCRDmvw3LpmlM
 hCTQEACRK0RLiDwcvtAXAUhYgWBAlZhpmnjHVNP/FiJfh/UQ14VH1mDJ4KuB8eNlODtbe3ayb6L
 FdyyVYFL4Ey+70ol4q6CwcSj0KyNUau7O9vY5lu0WnpLlR4OGtFVrrtnZswPX6dwoQJwo1LUXJL
 BSSieOH2fqhR9jHIH26jZWec9GATWVZEwndwbhX7cUKXmtKnjkw+5YjGWSFqlNf5CRnpsAR7ztu
 unnzlbIA4TuB0xosZRvpEnWbvUos/sOSMUtnoMCZ8SX4JxXE5Q0iWlmdHxcQGTsh4y34Al9afdk
 4y4cx0mGbnq5Qf2RiE4ImsAFDxRf824FJmgjMapfyVlXoQo3ko+45hyPnGjADfNHg5EBpTGzIPP
 FOic2wqC+pABPtBrVEsrYsIjlJAys/iAtQ/q4p/uN9c+BgwO9xYgKM3Z4oo0JLE1JO8VCBh88aP
 QhNhGX86SIvBoSZ9TmyDUSeUH+jbj0fdKM7y3nLB7y2Ak6UBKHJDQbBDY41T4C6Xf4NSGNgUHPk
 9pQm24HsHqbb6BHv78Q/Hm4hc0ZfD3J+YB3E2q2zSxPK/qMLSiZfC7tqZVV4B85PmBWqcgNbK8x
 IlF1qUVa5MJzKtvOY3Gx3bCZPeWmJ0qJzT8XCngGQPBmq/LF+xsNhijW/dG5YK81UngUldh3tZ+
 mocBIDvC/btMcmQ==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

EEE has until recently been limited to lower speeds due to the use of
the legacy u32 for link speeds. This restriction has been lifted, with
the use of linkmode bitmaps, added in the following patches:

1f069de63602 ethtool: add linkmode bitmap support to struct ethtool_keee
1d756ff13da6 ethtool: add suffix _u32 to legacy bitmap members of struct ethtool_keee
285cc15cc555 ethtool: adjust struct ethtool_keee to kernel needs
0b3100bc8fa7 ethtool: switch back from ethtool_keee to ethtool_eee for ioctl
d80a52335374 ethtool: replace struct ethtool_eee with a new struct ethtool_keee on kernel side

This patchset converts the remaining MAC drivers still using the old
_u32 to link modes.

A couple of Intel drivers do odd things with EEE, setting the autoneg
bit. It is unclear why, no other driver does, ethtool does not display
it, and EEE is always negotiated. One patch in this series deletes
this code.

With all users of the legacy _u32 changed to link modes, the _u32
values are removed from keee, and support for them in the ethtool core
is removed.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v5:
- Restore zeroing eee_data.advertised in ax8817_178a
- Fix lp_advertised -> supported in ixgdb
- Link to v4: https://lore.kernel.org/r/20240218-keee-u32-cleanup-v4-0-71f13b7c3e60@lunn.ch

Changes in v4:
- Add missing conversion in igb
- Add missing conversion in r8152
- Add patch to remove now unused _u32 members
- Link to v3: https://lore.kernel.org/r/20240217-keee-u32-cleanup-v3-0-fcf6b62a0c7f@lunn.ch

Changes in v3:
- Add list of commits adding linkmodes to EEE to cover letter
- Fix grammar error in cover letter.
- Add Reviewed-by from Jacob Keller
- Link to v2: https://lore.kernel.org/r/20240214-keee-u32-cleanup-v2-0-4ac534b83d66@lunn.ch

Changes in v2:
- igb: Fix type 100BaseT to 1000BaseT.
- Link to v1: https://lore.kernel.org/r/20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch

---
Andrew Lunn (9):
      net: usb: r8152: Use linkmode helpers for EEE
      net: usb: ax88179_178a: Use linkmode helpers for EEE
      net: qlogic: qede: Use linkmode helpers for EEE
      net: ethernet: ixgbe: Convert EEE to use linkmodes
      net: intel: i40e/igc: Remove setting Autoneg in EEE capabilities
      net: intel: e1000e: Use linkmode helpers for EEE
      net: intel: igb: Use linkmode helpers for EEE
      net: intel: igc: Use linkmode helpers for EEE
      net: ethtool: eee: Remove legacy _u32 from keee

 drivers/net/ethernet/intel/e1000e/ethtool.c      | 17 +++++--
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c   |  7 +--
 drivers/net/ethernet/intel/igb/igb_ethtool.c     | 35 +++++++++-----
 drivers/net/ethernet/intel/igc/igc_ethtool.c     | 13 ++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 48 ++++++++++---------
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c  | 60 +++++++++++++++---------
 drivers/net/usb/Kconfig                          |  1 +
 drivers/net/usb/ax88179_178a.c                   | 10 ++--
 drivers/net/usb/r8152.c                          | 33 +++++++------
 include/linux/ethtool.h                          |  3 --
 net/ethtool/eee.c                                | 31 ++----------
 net/ethtool/ioctl.c                              | 29 ++++--------
 12 files changed, 140 insertions(+), 147 deletions(-)
---
base-commit: 25d4342574644bca5cbe1ace865955e406b9a741
change-id: 20240204-keee-u32-cleanup-b86d68458d80

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


