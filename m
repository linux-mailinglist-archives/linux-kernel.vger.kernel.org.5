Return-Path: <linux-kernel+bounces-77025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5696F86003B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0BF1C24534
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FAE158D8F;
	Thu, 22 Feb 2024 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlQi9nmw"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2461586E7;
	Thu, 22 Feb 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624745; cv=none; b=l/ymSUgyKQF/W7eLYerfGO6rGjNQkvYqr54M1SEMb+SDqS9b39jxZvJ22sEiS18amzLJMoU23wUubvZyUfPKGaInTZ6X27F9U+lByooR7O57EYoxkYxbE5deQMskYfiYBrpzOvO88tSPfka1xutjernuXcNuwWKPBK8zPA4tS5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624745; c=relaxed/simple;
	bh=mJ4vI/M8uX6iTjXYqK2tKOismbv4AwjWdoffO2uKt1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBbltonXyiTHT9inbFl2GAqIAnlSdGBsN+DIcm7QfcsZ3nWKvDnrEcEzdoq1AvheJK2hHZKD5gtvoTy+83HRinWzprcImW/7cehRC62rVaZ1q3rUc/Aq8N8EWF7wklA8PVTcaeuku4nY0HMz6Cb9Lpwf+rEoSC5qz0wrxBxK4Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlQi9nmw; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512bce554a5so62864e87.3;
        Thu, 22 Feb 2024 09:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708624742; x=1709229542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp1g5lResVomu+V7VdkXdGM8kiQtYo+auuikQ/uSWZI=;
        b=YlQi9nmwp/xFKAn/G/yCXtUK5LfPvJfBSra+d5HpmzV/Dikaw9OjipKWaGF0oYXOq3
         EJw4RJOq6QIh8taWbF4uubMUo9/v0VSkP8QnMYG5dFYqU+aVBVP8Ygn3ArkrvLnkhYna
         pswNyjpPp45QULXGgW7M3zfYJfqMHOfE9B8mhNKtt6dNx5+ziC7udHZ322tlh37bhY+r
         bv4KgWwOCF+kZ4fMPelhzpSGUgMthtwsF5TETyt5ybi8xK8fmyQcY4Z8KBqvSRRM077i
         7jHLbWr1qM7nO5OGuUVeBTVHmXcWsVGX82Eez94r7pRaAuKWjM+Ks61SnXbPDSOMl+AU
         P/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624742; x=1709229542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jp1g5lResVomu+V7VdkXdGM8kiQtYo+auuikQ/uSWZI=;
        b=aH6h5uSbbOHn6oSh+XUK8WNgipCB0tA4VsRXm094wubPggiP4PZ6ovDDHf0ne3Y36m
         3DSD0kpwENuPJa2OQ8Fm1sslu2s91z5jCYPUDjkGefhOHY8w9gae4ZsKnD6RzrWab6kO
         LklF8Y7UaGfpqSjuiQ9obk7XVmscIzFK8dNajvHdJdFqA8alrJx//qCuYtbGzN0Bg3nT
         npVkvCSpRMUDUdPuU8sIBAt5JrzPlsN1Ce/jEbn17VP0ygwB6fO/NhbER+A/pStweqPI
         F3/XSPd1hsUcJtfGmB6iwxcWa4/xcdRRo46R3Ogkct3BOal76BqJVnCZrvJYP1Zn/77J
         EuCA==
X-Forwarded-Encrypted: i=1; AJvYcCWqfcmWXMsDY5LDUoQ96RWEjLZLrhr+E2ErAZDr2Fh3WfTQinJ55nEHLLOg9KjdrSdC7ystspkzKI28yuFjYhyq/QEVZIVAUb0sXEBWFsz0MV8TP5B9yvXOfkYkzRtZvy4lBJI5
X-Gm-Message-State: AOJu0YyVHDdrKn4ytE3DDxZdxxuG7bnM71mywF8uZlEJJOz9pdu+5vZy
	+GNxLp8qFo+xHd2pwHbzCxuzkWl3iJYIusTrPpOa5FuItXLLosvT
X-Google-Smtp-Source: AGHT+IGRpEI2oSqtm9dYNcKLyivAzdy3gMDPODH0h2w+FofbgIArs+mWBkkBVw4dyzhAIdDfbP1Bew==
X-Received: by 2002:ac2:5e25:0:b0:512:bed4:dfc8 with SMTP id o5-20020ac25e25000000b00512bed4dfc8mr6182428lfg.3.1708624741750;
        Thu, 22 Feb 2024 09:59:01 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id k13-20020a0565123d8d00b00512d47a6459sm694644lfv.148.2024.02.22.09.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:59:01 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/4] net: pcs: xpcs: Return EINVAL in the internal methods
Date: Thu, 22 Feb 2024 20:58:22 +0300
Message-ID: <20240222175843.26919-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222175843.26919-1-fancer.lancer@gmail.com>
References: <20240222175843.26919-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In particular the xpcs_soft_reset() and xpcs_do_config() functions
currently return -1 if invalid auto-negotiation mode is specified. That
value might be then passed to the generic kernel subsystems which require
a standard kernel errno value. Even though the erroneous conditions are
very specific (memory corruption or buggy driver implementation) using a
hard-coded -1 literal doesn't seem correct anyway especially when it comes
to passing it higher to the network subsystem or printing to the system
log.  Convert the hard-coded error values to -EINVAL then.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/pcs/pcs-xpcs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 7f8c63922a4b..92c47da61db4 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -292,7 +292,7 @@ static int xpcs_soft_reset(struct dw_xpcs *xpcs,
 		dev = MDIO_MMD_VEND2;
 		break;
 	default:
-		return -1;
+		return -EINVAL;
 	}
 
 	ret = xpcs_write(xpcs, dev, MDIO_CTRL1, MDIO_CTRL1_RESET);
@@ -889,7 +889,7 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 			return ret;
 		break;
 	default:
-		return -1;
+		return -EINVAL;
 	}
 
 	if (compat->pma_config) {
-- 
2.43.0


