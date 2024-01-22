Return-Path: <linux-kernel+bounces-34181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F375A83754A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941941F27F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E38481C4;
	Mon, 22 Jan 2024 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExGJlTbB"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77190481C8;
	Mon, 22 Jan 2024 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958976; cv=none; b=IbMFw45dvFGpFU38XgHsM65kdNkXOaCXfb6en0Vu2XXMZ6oBIyblaxTJlfUIXsRR2dSkqBXtc3qbwKVkM4u9KpLtC47fj24wBYz6yIsIDeQOtNxMIx4h7XRQiSWiuK/n4J0oOVJqKfoyWZchUkZTuaWKrr9hA6ZhPsMHpC5DeIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958976; c=relaxed/simple;
	bh=/WQVGD5RStqq2TMulnJzeOS49hKDoHVe7AeXru/8hBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qQzEoEqt0WmLX6fOkhx6rN9yeV2xTXNz5FYS2YITtdshelFaYuXSC52b2JAIJiL1Eq9/37R/VT0BUp6O9Un1ZRacpY+dEuwWIudMz/e4y3ochXGQJrrJ47uFqvnAheP8XVRbV8D1ksrwWqfNUt60hzXcBUNtU88YP1EFEGYiUrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExGJlTbB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so11884025e9.2;
        Mon, 22 Jan 2024 13:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705958972; x=1706563772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awRh8a2uyaBPV9HuU86fl9/hVsMJE3K/Mn7kByHoWp8=;
        b=ExGJlTbBnx/HSHcFD3pwcca1Xzd+KD8fm7NooMz2yDMOk/hyyEnt/EcEiq/RAJO7rQ
         BzfW6NlDFH27WKUmcrLgQ7ucHpT3TvP2PL97JXzrDAo0rIESFcXNexzjGfd7gG2iO73q
         QPSN/K+o6YkvnmMtNi3wEMbemWPGAcloDnCSTbExPtybe4iN7mAR8evNc/eRKHF8CC14
         CwfJcwApzUyYGeDqS57OkH8hkzP1fWu3B9GbC7mxTRS583/uDgvpynbDdGFqFkpbgWKT
         DFMoK+0Hr557hIR7YghST/0BPhNrAvbpJHeTfmQTZgzmrkn1pbhsXRHKhFgKP9rNvOrU
         /3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705958972; x=1706563772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awRh8a2uyaBPV9HuU86fl9/hVsMJE3K/Mn7kByHoWp8=;
        b=OVNLgcrHEZy+cVBhLtGZV1ZnZBh2muTi3GwKiQadYlOJIlfqKlhNdhUMIemk6UdCmk
         pz3ggyjz1rDBvdasVaMK9QAMlgy5dZHZez0j7ojoz/zIla3goBWI7eX1v9RNmenE/Qak
         uRi41IKTM+H+4CHgPxcY97V07JgKCYgbOskb0+M6pwwJ3Uguu0oU5pXXy8H+FjkDdK59
         Z1ymqBSypVocE3u15zZ6RO5DsKDbf1o2YyagHnyu9pA63ffz7r+Bpfy8z8DBTR8e1tXi
         Xm8U2MB6upcF3NP4YCKhVinqxM9SPuFLU3M43TpVHnchc9bVYwwg+WvW48vXzH4trwQY
         I1sw==
X-Gm-Message-State: AOJu0Yw7K8p7KOMOutOLabeZvNzGBV0zk4ac6+HvUFEulmgIGH3/TiKl
	mldFexC3ygusaz7DRudw4P2qvOUwHzAvoky843bftKjRRACfmVAU
X-Google-Smtp-Source: AGHT+IFFOWp+bguLvf1DMyURSpDXOBzhNo0Mu5eclUHg/AEXVIozX+6WTexu834LKa4ZbX6/xBPNXA==
X-Received: by 2002:a05:600c:1f92:b0:40e:6650:b873 with SMTP id je18-20020a05600c1f9200b0040e6650b873mr2905440wmb.28.1705958972648;
        Mon, 22 Jan 2024 13:29:32 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a26af4d96c6sm13823336ejt.4.2024.01.22.13.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:29:32 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 net-next 01/13] net: phy: Add BaseT1 auto-negotiation constants
Date: Mon, 22 Jan 2024 22:28:34 +0100
Message-Id: <20240122212848.3645785-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122212848.3645785-1-dima.fedrau@gmail.com>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added constants for advertising 100BT1 and 1000BT1 in register BASE-T1
auto-negotiation advertisement register [31:16] (Register 7.515)

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 include/uapi/linux/mdio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index d03863da180e..020ccc810d23 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -348,6 +348,8 @@
 
 /* BASE-T1 auto-negotiation advertisement register [31:16] */
 #define MDIO_AN_T1_ADV_M_B10L		0x4000	/* device is compatible with 10BASE-T1L */
+#define MDIO_AN_T1_ADV_M_1000BT1	0x0080	/* advertise 1000BASE-T1 */
+#define MDIO_AN_T1_ADV_M_100BT1		0x0020	/* advertise 100BASE-T1 */
 #define MDIO_AN_T1_ADV_M_MST		0x0010	/* advertise master preference */
 
 /* BASE-T1 auto-negotiation advertisement register [47:32] */
-- 
2.39.2


