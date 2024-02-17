Return-Path: <linux-kernel+bounces-69999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 499D685918B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E08B1C20BAF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C4D7E114;
	Sat, 17 Feb 2024 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m9m/FrVr"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE3F41A91;
	Sat, 17 Feb 2024 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708193366; cv=none; b=jlx+nbGDpSSc0aHr7yuOh/MbJpRFAN1cC0fzfGt7+ZeBY0fa5Fl+gC2qF3DBEuPd0OzUxr+FXaSK0PMZ7i1R2aD82pOg5fOMjileSeB0r+f4Iwjroy1y6yanutRmURVHShFgbP65w9+ky4AENKwyuz4ynUT34TVMTY8ZVaT0nBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708193366; c=relaxed/simple;
	bh=3Kx8F3a38kE44wmpjeYUBBglZy2Yhk30yOTvCVmccZI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fi7znEdgx4MMbhdNMvvBILI96TismjdqnQGgThdtelK2PK/1Tbh43ATsmPJs/+9LXwqUQ6AHPVaq/JvxR97/iLUvnvp8DkSu9VwlP+1LyVaxsX55zX7+gF1q+nu7Md3zpeIAyLiVzWBk5iKUJU+VOV3s5wtDOa7lRrZy5HCTg5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m9m/FrVr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=D5hka2iRwHIJ0nHqjCwQ9odeFeQKeB0FEoZhwjpQjRw=; b=m9m/FrVrlmVdBho+MjDwoKimDQ
	4YCAGru8ScJ94PBR98SbEponUntGWYn1vr8JvHwIxreBkWoEXd5+iXHF/lioNymGGxDbESD/a2QS3
	e017KJsdCwG2iRKQBz2sfTzkLJqQ5dDNn87CJvGay6tO2Bo1KzN9+roRyemC280/O5OY=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbP7m-0084hf-J4; Sat, 17 Feb 2024 19:09:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v3 0/8] drivers: net: Convert EEE handling to use
 linkmode bitmaps
Date: Sat, 17 Feb 2024 12:08:21 -0600
Message-Id: <20240217-keee-u32-cleanup-v3-0-fcf6b62a0c7f@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABX20GUC/3WNQQ6DIBQFr2JY9zcISLCr3qPpAuFbSQ0aUGJjv
 HsJm3bRLicvM28nEYPDSC7VTgImF93kM/BTRcyg/QPB2cyEUSYoowKeiAgrZ2BG1H6doVPSSiU
 aZRUlWZsD9m4ryRvxuIDHbSH3vAwuLlN4la9Ul/1/NtVAoe8kUsVZa1t9HVfvz2YoqcS+9PqXz
 rIutGm46BS3Un704zjegA7HWPcAAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Ariel Elior <aelior@marvell.com>, 
 Manish Chopra <manishc@marvell.com>, 
 Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 Andrew Lunn <andrew@lunn.ch>, Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2843; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=3Kx8F3a38kE44wmpjeYUBBglZy2Yhk30yOTvCVmccZI=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl0PYwMe5qMhz9ZsflDQuNQ76sJnltsYIR9Y+6p
 C8sq2oUf0GJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZdD2MAAKCRDmvw3LpmlM
 hPCfD/0althDffrS4QaG2R2pNdI9MNwkgg+ZcCNO6lHixTc1h2GNTmg69uwk6c3yeMyImS9oVJ0
 kOQkic5svqF87Q5PKgM7YIPGy2eOWV6kxPD5pFAN+Gkt5T9rBSffcXdK1OoALxNP9v+VMaHHlsZ
 9J74ReHexGordDXaXiKafqoXz9r+k9gHF6f+rM4+goCjp2/nIyG6R9DBeCiDTyWffPaK2UUMyZu
 1l8hMFOyE8Ku1Ahrnxl2m9lIL/8Ic5oE2GJZqc/Dd0J7kAPlvSKExDsInmU6BiCheEk2gARapnc
 oGxyO+0aDxu4VD3eIVfk9mVwjoYaP79C4JPM8dvi0FIGf3iuHMrvBcdj0k3JFd/3fAMeuC4mlSv
 mwnKRxLL3CtCOwwQwkOl5g8d5jUKmTHew4bT8ywiLF31U+gfAkIvDyBB6QnhTp85VblhaTnOv1L
 A4xhJk0e/52YSWPtqoUw0T1prP2azBvV4yJBmPRjKjAiCwaTZhlU+4rZ5xyNO6akiEEvyrBd9io
 zzToa3m60gbdSRDkhnnhSP596k/NODTkR2a2DTaXInYS5T447zgJlSbLmjQ39MzJdN7BJoeOdZu
 0lO+BCg8rxtQt1Gq5RgecbOPDtG6DSPZ0LogwHoc2M4rlX8I8ZamnZvIqEGwNKytLcauEs90HSH
 cb3SERRwMogNeOA==
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

This patchset converts some MAC drivers still using the old _u32 to
link modes, with the aim of soon being able to remove the legacy _u32
members in the keee structure.

A couple of Intel drivers do odd things with EEE, setting the autoneg
bit. It is unclear why, no other driver does, ethtool does not display
it, and EEE is always negotiated. One patch in this series deletes
this code. Comments on why its actually useful and should be kept are
gratefully received.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v3:
- Add list of commits adding linkmodes to EEE to cover letter
- Fix grammar error in cover letter.
- Add Reviewed-by from Jacob Keller
- Link to v2: https://lore.kernel.org/r/20240214-keee-u32-cleanup-v2-0-4ac534b83d66@lunn.ch

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
base-commit: dfe7f12788f5428d8bc16e86eedcfa889a3e3b29
change-id: 20240204-keee-u32-cleanup-b86d68458d80

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


