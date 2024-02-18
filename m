Return-Path: <linux-kernel+bounces-70448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093FF8597FC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52ACEB20F7F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0676F072;
	Sun, 18 Feb 2024 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ABls1Qsc"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4BC6EB49;
	Sun, 18 Feb 2024 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708276046; cv=none; b=otTnZYuA++nfissQkb5NvxCuQShG4xsTnfaUx6AmJuQeaUE1sS92MtVB/0uy26VYsDJwJKGnGW423tzLeYEb5f6XNoctaRHUXrp51tdaQypqkw3oC6YAA0yTSB9t5X71CZjk8L2JeZq1FYbAGslLIWDG6BSiYCDf52tREbS2T2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708276046; c=relaxed/simple;
	bh=KnWWE44bi6i3GJAn1com4/VFE+nzWpKzn2h99Q39t8s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mp/y9FdO8ORQNYOh58tnqMXD9qPw7bZ/1/LGQTB8z7gKy/l0Cz4GQtgNwlkAQipyL+xQrZeEqmgBQeCVPX6XZfqczdLTjiZuPnhOOxLKVMKoqbamXdoAoGba6l0lDIkhXfmXUFq29Z9JE7YL92DEbCcWMAAItHI6vnq06TXi8yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ABls1Qsc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kVSOAYnUZ/Uj/HdzYfiBeOH6nZiY2AIhv4z/jR6yzYY=; b=ABls1QscvCgWCOqXzGIgUsg6Hd
	cFkU9c0S2hCznDtLda8StQswNRGpoD0tt0EigrUpMcn9AdiP2sdDN3spLpYNASFFFQjjAnmGe7Anp
	wBEWXrHgvcplL5N/DG9vpKzWPN4XvFPo5b2Meq9yE8+JBGeiPiTz3V5ZRX800XHwlx/c=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbkdY-0088HX-BR; Sun, 18 Feb 2024 18:07:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v4 0/9] drivers: net: Convert EEE handling to use
 linkmode bitmaps
Date: Sun, 18 Feb 2024 11:06:57 -0600
Message-Id: <20240218-keee-u32-cleanup-v4-0-71f13b7c3e60@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADE50mUC/3XNSw6DIBgE4KsY1qVBQMSueo+mC4SfSmrQ4CM2x
 ruXsqlN7HIy+WZWNEBwMKBLtqIAsxtc52PgpwzpRvkHYGdiRpRQTijh+AkAeGIU6xaUn3pcS2G
 E5IU0kqDI+gDWLWnyhjyM2MMyontsGjeMXXilrzlP/f/ZOccE21oAkYxWplLXdvL+rJs0NdMdz
 484jZwrXTBeS2aE+OVsz8sDzj7v2opaUEV0ab9827Y3ZYlVwDYBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3317; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=KnWWE44bi6i3GJAn1com4/VFE+nzWpKzn2h99Q39t8s=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl0jk4TY6Sm1S4H9Bg6JfRKRwDdpQJ1s8bcO2+u
 jnIZ1HnW7yJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZdI5OAAKCRDmvw3LpmlM
 hEp7EAC+voC2p5IA0eRPw/PampkjjG/fDv5MJNbNhQeRmcZFgV/C01ROct516eG4irybkvGZc/I
 reljgKgDsKzq37Qan0Vbf0CRBMFSUc7q3I4VM+qtmu5gali0hi3IxWxWyq6WRYRqdigzEaCoOZh
 c7D8fiJPR2XFBylaWTmhasz/4nzgBp1IEmDyyWeR7Kt2ZeUfFajD5eM7OJ9LbkRstKcQqhF6mTx
 JFlvIska3YY9/ythPkevBZwFC9XWgV51mB0kzwjQ6wkqq1yMZ90RFoW0P7BVExDHUdLgzWVkhl8
 nz3acSnDa1qQe8MCnCYxAxDEGrc6SWesGJpJsl6ZgWeG2y57ZjeUSorBwzi/8oICQZM8fYO97mi
 GZuKzvv8pVPhHFal7CWk6rknkZHqqr/TQ6IwsDIA2nJ7VezUuzjdOVeBT+1xiRre6dR3qg/X8Gp
 jFKqcrNkxgs+zgcGd2t04E9oQqYmbe6G2CMB9fZaD+xBfpGuVMlBmmQ+11QaP2aP8IEKOGpSTe/
 Nobs5fSwPsBUF6OzOcvbMraK+o5wpASRHbytX8d358n6yRW1uxRUK2a+G2Z7Zy2uPmCELieliBH
 t44ktnlouSG6Zf2dWun6KLGpJ98pkzK73yb8kyz5wguI/jktfWFtKhKz5eok+AdBhK8xK/dwV4U
 33o72jMcwpgEufw==
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
 drivers/net/usb/ax88179_178a.c                   |  9 ++--
 drivers/net/usb/r8152.c                          | 33 +++++++------
 include/linux/ethtool.h                          |  3 --
 net/ethtool/eee.c                                | 31 ++----------
 net/ethtool/ioctl.c                              | 29 ++++--------
 12 files changed, 139 insertions(+), 147 deletions(-)
---
base-commit: a6e0cb150c514efba4aaba4069927de43d80bb59
change-id: 20240204-keee-u32-cleanup-b86d68458d80

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


