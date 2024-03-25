Return-Path: <linux-kernel+bounces-117965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0811D88B1DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC4A1F670FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DC86FE15;
	Mon, 25 Mar 2024 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVk5gxma"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579AE6F51D;
	Mon, 25 Mar 2024 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399496; cv=none; b=GIQAAh7FJ9/yXzi0fwsI8X3R4Xf1nSKmJZ0rBbvVvWHEVNNJPLtV+agxs5KersnbE9bJ1h2+q6LXm/xLhg5XfFze4E6Sv+k1PSTmedrEJAVefRmqUTp2pe0dZrVfAgA5911sEOv+xCmC33tOAcLxPCW5/JIhXyUOzgdOWaenN6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399496; c=relaxed/simple;
	bh=LN4dT4d7P8qQBwedPyFT2jT5dVKTs6A7A2F7zwpITOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k05N8UxtkdGy5sxOsq/Rj0gCetrZZiMae1F6G4zDYTeWnQWFKY7F9g5S+pENvvi16+YC4wFrMxPm0jKIqbsVOrDFy6iOX9+FANoasINM6GoOuZUQyMZdjl65DM97tJ/T3aRQxpU7W01DTA27HYUxzIZ30oJzc201e91sDnplz3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVk5gxma; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-515a86daf09so2438341e87.3;
        Mon, 25 Mar 2024 13:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711399492; x=1712004292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdX7GSsZnXTSylOv9Y3Ibi+HXBYjvkvffIzYw5Muc/4=;
        b=KVk5gxmaOVB/NIwEAAcFSgfbxyXza7T6cOeCiNR6fMVCg57F5+Onh5vLv/77ZAUXi9
         BzS2tRSGpFyOUtCdMwzS2eB6WzYYk1wB2FQhSaakI1Kp6th1Inu+Op8AY9vn7P2HYRhV
         /UZ9EY6wwUqp8xnQCpbgnTMCu0lmQGfUdvhEFdHSvSIcvcT3fTtaRltOVPCK9/1UmVaI
         QEf1eSPWsKsKarahnxx6WkwED6mccvdwzGK0P6j+wTy/ZXKrLqXDfGy4iDjO2rMDUK6E
         vaSHkMiTD7+4eF50KLgIoQXCSkFffuBnJ4nGZK07mkF9xLNx6dHPvdfvf0xn6SdyM7Qm
         BB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399492; x=1712004292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdX7GSsZnXTSylOv9Y3Ibi+HXBYjvkvffIzYw5Muc/4=;
        b=AQDKu0Aj/Zk2Ak3hpCsLHGw9FK2An2bzRlvunwHoKRnaMIO+5CNLxy27TC88ZBMARA
         AbWId058r/y3kt1VM1z9NqBFQRL11WSoBla4Zq0WpPSXn9mzyijKNZhckPcDmF5CykwU
         Ty13TZhUtPzurFcKDZJkAXVCwzcUnheBgMWFfRRQAfw8STQVUv8Dqf+XNh6NTazlM0iJ
         K3WgcYSQYf9GuALwSrOQaTc+DWwQYpN2MxBAaehT38h2FVTCJxYSIdgiaZoxKHSJ9KLB
         X69Py+yYsVzlCIz8iECLshD8MN1zi2O4b/qG6kxtz/N7GuFUc3Hp4eRk6zm1Xy92VkVM
         m0qg==
X-Forwarded-Encrypted: i=1; AJvYcCXtdVzpe2kaPAfNC1NP7nTWOGz8CaPNgjUmE/U5uGEb6R9AvaZ5gkpkI/SUurBeIG8iLHkIkKhGmIQeBN9DacXFibYXi9YA/5x7Yk69
X-Gm-Message-State: AOJu0YwmE1HOXW7vCHf6+PzFXkailr9dsBaaHdz1pjF/D1mRFZHOQKRq
	n5H2wkm0vxIQV1/Ps97hwofpYFrsbZOYff9Entk+1Fkx2wZ0ICbITqyEHN5VLko=
X-Google-Smtp-Source: AGHT+IGR99AwEcs60I5LaFb36uz4ABm53DTgzPKYSJ5bOBquRnnhOw0ax9pVqsAi3sbZ2H26EjFTGA==
X-Received: by 2002:a05:6512:535:b0:515:a58e:82e with SMTP id o21-20020a056512053500b00515a58e082emr5233083lfc.62.1711399492034;
        Mon, 25 Mar 2024 13:44:52 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id k18-20020a056402049200b0056c1cba8480sm591751edv.25.2024.03.25.13.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:44:51 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 05/16] net: dsa: vsc73xx: add structure descriptions
Date: Mon, 25 Mar 2024 21:43:30 +0100
Message-Id: <20240325204344.2298241-6-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325204344.2298241-1-paweldembicki@gmail.com>
References: <20240325204344.2298241-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds updates to the documentation describing the structures
used in vsc73xx. This will help prevent kdoc-related issues in the future.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v7,v6:
  - resend only
v5:
  - improved description and stick to 80 characters per line
v4:
  - introduced patch

 drivers/net/dsa/vitesse-vsc73xx.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index fee1378508b5..e7b08599a625 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -15,7 +15,16 @@
 #define VSC73XX_MAX_NUM_PORTS	8
 
 /**
- * struct vsc73xx - VSC73xx state container
+ * struct vsc73xx - VSC73xx state container: main data structure
+ * @dev: The device pointer
+ * @reset: The descriptor for the GPIO line tied to the reset pin
+ * @ds: Pointer to the DSA core structure
+ * @gc: Main structure of the GPIO controller
+ * @chipid: Storage for the Chip ID value read from the CHIPID register of the
+ *	sswitch
+ * @addr: MAC address used in flow control frames
+ * @ops: Structure with hardware-dependent operations
+ * @priv: Pointer to the configuration interface structure
  */
 struct vsc73xx {
 	struct device			*dev;
@@ -28,6 +37,11 @@ struct vsc73xx {
 	void				*priv;
 };
 
+/**
+ * struct vsc73xx_ops - VSC73xx methods container
+ * @read: Method for register reading over the hardware-dependent interface
+ * @write: Method for register writing over the hardware-dependent interface
+ */
 struct vsc73xx_ops {
 	int (*read)(struct vsc73xx *vsc, u8 block, u8 subblock, u8 reg,
 		    u32 *val);
-- 
2.34.1


