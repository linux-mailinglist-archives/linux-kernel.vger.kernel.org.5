Return-Path: <linux-kernel+bounces-51950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 167A08491CC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22896B2153C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CD211188;
	Sun,  4 Feb 2024 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eBhb6YHz"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F69BE5B;
	Sun,  4 Feb 2024 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707090046; cv=none; b=QzQxaqYKFQQZzr2kGr3lhGzBKP10157V8AwXwNyZkGlY4GND/t+lLIQucncrlTGU1qis9Nqex59y3AVEdu3zp1bfetLz4v42kRxyYZr0ssb0CGUXC3hcD1fVjBsZ7waMJeDxYpTsVycXhBlfR8M1IOfE2x0eb8HJheQcaC3GumE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707090046; c=relaxed/simple;
	bh=xTLNlRe9zpFCH+NSfLBy79yr+GAoL3YfMnIrGZaTLxU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Qjzj74sndKTkRTBL+hdJYrdBaqEGCygr6LrvvsfgVGP9COkmxtGxJVD7rPRmw0MN/pdNE5Gdr+0y699inZHyhId6E+tCcvsOb29mFWPPm3Oj5rL1JOPo0qEsQKW63KcgG/WCR6/5M4lsUF9U6oRWyHLc+aqqNGlXUiMaAkEpUJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eBhb6YHz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ofMfbIjqFytnpEYWawM8vASgAHDc01IrEgzRrZALl3A=; b=eBhb6YHzTA0gYHZgNDf9Zod3lL
	7NQnM5GNtN6wANB+ki7+CQSFvuLosaBr92vdf+M+HTUXxqSVha4SS8Ch3vm2K0x5oVQgwPiG0pmyw
	mvkoLInmj5SV1jQfNgp1oEZEN5sGAWatxlYodEXiYtBDaXgTenF5pDtodGSN/yBC0fL8=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWm6A-006z7T-0Z; Mon, 05 Feb 2024 00:40:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 0/8] drivers: net: Convert EEE handling to use linkmode
 bitmaps
Date: Sun, 04 Feb 2024 17:40:17 -0600
Message-Id: <20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGEgwGUC/x3M0QpAMBSH8VfRuXZqZrS8ilxgf5xotEVK3t1y+
 bv4vocigiBSkz0UcEmU3ScUeUbj0vsZLC6ZtNJGaWV4BcBnqXnc0Pvz4MHWrramss4qStkRMMn
 9L9vufT8UihgyYgAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1999; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=xTLNlRe9zpFCH+NSfLBy79yr+GAoL3YfMnIrGZaTLxU=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlwCBn8ggPNVIXSaz7IAvAixB8ka53ggNMSY2Zc
 vicaxrWtMeJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZcAgZwAKCRDmvw3LpmlM
 hG+VD/0TtJaWfgHoLdXUBMZQUhJbJSj69wqg80e7HoEDOYeyGWGwJ2wkFhMXkTzvjg011y2gFgj
 zALmvZsfxriALcG44ySLy82tVTE4Hij9IAV8rAcgn8msp1M7p708ctj8xZU+p1G1R9Tt0XtPF8M
 hI1f4AnAdPCAz3Wx0b6cKMl6P6LAYnYG+vLsjTWCiEp6WnW9V+CFgVAGeIrfoRvXTHKAkM4vnqe
 1DVzDxkalb2adpWWyhqGQmQY+N+dlERDDV8Cdfrw0z5ax2NIiZa3eIf1ovgz/SNgqzF5s2vmvot
 x9T/aoJ7qMBAazsfF4Z3sarXBWkOehFlBQZD0bBkN7MWVx6fBKp9t+f/6jNJRF6ZgIgJWapwGoz
 pa+dv3jwI77GHHq2VXO0kMe5sde/XpLzmavHeuCBZ0a0a//CkuMvjc+eHMVwYpqVAvd7sLrJTOW
 2yfZX4lt9/RsnCfrhNBjIht7H9KnGSpPShFfvNSKOJ5JRdFYhEbJ3tMdV5ZLNlnifaK5I+uSwVC
 swAFQBR1rgwp3dyCvH8PYwbHorQkGR8+uGphBacdWtMSveS588U5tzQSXaZ1aLosyBvT0Rnenpe
 jsRprUFXHnumRUuSEZnq4IRBK7RxhGYrUjgPRaJjRV2Pf3kv4fYRIR/o1G6NjaUfnf9vKjpEha9
 mLrKi2q/9IJSeBA==
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
base-commit: ffabe98cb576097b77d404d39e8b3df03caa986a
change-id: 20240204-keee-u32-cleanup-b86d68458d80

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


