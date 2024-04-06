Return-Path: <linux-kernel+bounces-134069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B812989ACD7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 22:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB601F221B0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 20:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC454DA06;
	Sat,  6 Apr 2024 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yO+53kOD"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C6A4C618;
	Sat,  6 Apr 2024 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712434598; cv=none; b=H2KjLfE406I0SLieNGMJeSIH9NM8FDBNoe/DoXsXHQmWzDa+Dyo+0xUSBMIvPuyOpGrZTshMz+qCN/zeLsNkgW2l0MjipwCbsPnllY2LpK5l9q8vqzfh6NteW5Scff21bF+rEXZpU4CkO7E6RsAaBYV9z38Ekx9zYMBA+nxyv+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712434598; c=relaxed/simple;
	bh=9vsvsSlB7PyisrqnrW90KGeFBPAOXUUXuVDxczrhdyU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oc4XLaGZ8qG8CYwKlgHMTt0W9QmkVidACE+71pUUPqOOwMEOpUu96ngMHZPD7fNuV/TbrRuxPAM6ngmRjbpQEWSKah4fIKA2eR6BhGytV245levzX7WdOWI8IaFqnnUkecwGZNfU5V3HVi7FnMVZr2/ec+La4Bdtygf0HAa0/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yO+53kOD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Pn/dpAfQMA/90C9TTh2WDaBSF21gvFE+TgCrSTNL37I=; b=yO+53kODrTZiQAOw7g9Zn4l2IV
	X49W3rbbUSrcMViKgxmDdSFN5dF7pAK9jJ+Q3Pz0SOlm8w9WP+jYDmiMVEpmHQe/xvvYBQPZyQqB3
	GBsVWUHk0W56SQNdlSAGj1T1yYaTX36iOA5XPVqbxF9TM1hwXMMHPc09CkEvi3TBDUC8=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtCSc-00COEr-FF; Sat, 06 Apr 2024 22:16:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next 0/2] net: Clean up some EEE code
Date: Sat, 06 Apr 2024 15:15:58 -0500
Message-Id: <20240406-lan78xx-eee-v1-0-2993b14b849c@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH6tEWYC/x3MQQqDMBBG4avIrB0YJRrxKsVFqH/aAZmWREpAc
 ndDl9/ivYsykiLT2l2U8NOsH2sY+o6e72AvsO7NNMroxMnMRzC/lMIAeIaTOHmEKI5a8U2IWv6
 3BxlONpSTtlpvb5zMmmcAAAA=
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Bryan Whitehead <bryan.whitehead@microchip.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=908; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=9vsvsSlB7PyisrqnrW90KGeFBPAOXUUXuVDxczrhdyU=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmEa2Rt1LdXEVRUCv6r9gzZOayhK3y5o4t++oYe
 JY6jJEugFaJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZhGtkQAKCRDmvw3LpmlM
 hGTWD/40KHE9MGbSigVcmevNSFOCNZ6Io/Q7uNfW3G+fFZJhRr5H5PDP7f8QiwvGunOxIL29kcO
 Qb+6VPtnAY97zukcega6/yKM8CjZpZS3Ke/VKspDaACHONx0Cgb9dfB+QZMF3kFfIgqPIji/MLS
 E7LWNkeHOm8hHlfDHZVlCS/Hz1XXifUl9B7UCiSl/IjTQjxPWES1ybk73nNDHy/BnomKjCJWM0R
 T6eyHb/oLcSal5iF9SnE2GoGiJ+DAvjHP+4O2LQaANZaY9eA7Dc6j3Wb4rYhXX5sFiiBPV2LodE
 Gpl+m1bbQGfD931spPptreGWHEiIe4IuWGMMVBuN3KHDb35+6I2ulA43Ipos0smJsZ9OFttpv9F
 FSrBziQar7xgXPhZ8vUa8qmrZvZwOXGDkU8EZYXi9m3oDULXRoVM+7DkuOr64UjfzvswBtoFq+6
 1EnbdENKhujpVL1mnKm8F0K4Y8lJG6OPba8NrEyGmoX8Dvq7d6hr/jiBBFViKY+vt39H0oOub4c
 +lG58slzz9HiqLnmHGQVJSpeU+s07HSgy6CL1w0cMlvgDqzGGnJbe8OkmHcVMOEAEuh9Jcyij0F
 L7HLJY315HjzNQnbTG6rsN8yM/d+mgIv8aH0/alUkFvepoYQW9ra6s1Opae3R2WGcuuDDSIPSRI
 b+N/JSSYmpmSodQ==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Previous patches have reworked the API between phylib and MAC drivers
with respect to EEE, pushing most of the work into phylib. These two
patches rework two drivers to make use of the new API, and fix their
EEE implementation, so that EEE is configured in the MAC based on what
is actually negotiated during autoneg.

Compile tested only.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
Andrew Lunn (2):
      net: usb: lan78xx: Fixup EEE
      net: lan743x: Fixup EEE

 drivers/net/ethernet/microchip/lan743x_ethtool.c | 21 ------------
 drivers/net/ethernet/microchip/lan743x_main.c    |  7 ++++
 drivers/net/usb/lan78xx.c                        | 42 +++++++++++++-----------
 3 files changed, 29 insertions(+), 41 deletions(-)
---
base-commit: 267e31750ae89f845cfe7df8f577b19482d9ef9b
change-id: 20240406-lan78xx-eee-6e40f57eaf04

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


