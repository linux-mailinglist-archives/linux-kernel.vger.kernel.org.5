Return-Path: <linux-kernel+bounces-2241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BED3815A19
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2062850D0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D310E30357;
	Sat, 16 Dec 2023 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVfDD0+D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CCA3033C;
	Sat, 16 Dec 2023 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c6736d10fso20803665e9.1;
        Sat, 16 Dec 2023 08:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702743132; x=1703347932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tzgV5uucFiwLPoh25yXTuojgO0xZ6QpV2BGTK0ZCxzo=;
        b=gVfDD0+DYUsJzlLZ7dZdSv8Ohu8HHJeIep9qHDpOjtTuDeXbfF1fzxHsHp/2At0faj
         kf2Vb7bIioTJjA2NeVekMBo0QeblfPd/DreT3wA3xdJ7vUcgjP9/JVLlFl9BQVFJJbJg
         cdngVo1m7yznEKum6ATX8eESu0ybt/AWx/zupojzEuPSMrYTbp12TGrND5mxvI+xZLa7
         roJKm3dYvBWfeuqN7eigaPGJDORuvsOhCZGvbhVbeGRYHuQv8aL0VxItarUB4ERtajTm
         6F5Vym6qzb55uyQ09aDce47stTbWPzNX8GDJwjhBQptHGwKPQsDhDT8sZaZE+IZickZY
         WR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702743132; x=1703347932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzgV5uucFiwLPoh25yXTuojgO0xZ6QpV2BGTK0ZCxzo=;
        b=xTIB8ESILdCCiqU/YeBRFKXzdg9UFHTy9oTey6OapZMBCrIsF9DcKJqZmBOGd+Q2fQ
         loj83xBxrtYXMq7/XnQiCRvTFOkWi5F3XR3RftWyzmLpGVIp2YMxQOZ/xmI7mjTG/mOb
         65yXBES01vO+/K6E+HS4GV7WPu0ADs3oZiALKg9Tsip5L8DImfyQIgqVS7ayl3R0DVwq
         oNFJxG3vOh0jXYv9NgkhNYs2bRfarWh8Q06TW1EO4Skgwxf+I+vD6+TUSCpc4S530TJ4
         8/y7u9UarH/XukzgSRc+iRHTTFBBD7k1BqvaonlHKEfLLY0FkZ4sHhVkPX7D33UyNYu2
         MgfQ==
X-Gm-Message-State: AOJu0YzbCnWYPhXe0r+8gB8OrVVzwFNbhxFb4NcbcY5LBNjs+N3ElDkQ
	Z//Rn/m3JKZ8uzO9iCja3UA=
X-Google-Smtp-Source: AGHT+IECuvsd4KNd4VepUqqnFf8n+QqLc8S7qMPsoLsoO6CLdK46FHA56ghlUVzS7Os1CynIEjlipw==
X-Received: by 2002:a05:600c:1913:b0:40c:6aa4:30a6 with SMTP id j19-20020a05600c191300b0040c6aa430a6mr1642955wmq.184.1702743131679;
        Sat, 16 Dec 2023 08:12:11 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g9-20020a05600c310900b0040c3953cda5sm30818925wmo.45.2023.12.16.08.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:12:11 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v4 0/3] net: add define to describe link speed modes
Date: Sat, 16 Dec 2023 17:12:03 +0100
Message-Id: <20231216161206.1729-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a simple series to add a way to describe link speed modes number.

An additional helper is added and the phy_speeds is better documented
and expanded to return just the modes number.
Documentation on the additional helper is not added to the phy.h as
suggested from another patch where in double documentation define .c is
preferred.

This is also needed in the upcoming changes in the netdev trigger for LEDs
where phy_speeds functions is used to declare a more compact array instead
of using a "big enough" approach.

Changes v4:
- Improve kdoc for functions (thanks Randy)
Changes v3:
- Fix various compilation error (wrong revision pushed)
Changes v2:
- Drop stupid enum-define hack
- Introduce helper function
- Document phy_speeds function
- Extent phy_speeds function

Christian Marangi (3):
  net: phy: refactor and better document phy_speeds function
  net: phy: add simple helper to return count of supported speeds
  net: phy: led: dynamically allocate speed modes array

 drivers/net/phy/phy-core.c         | 50 +++++++++++++++++++++++++++---
 drivers/net/phy/phy.c              | 12 +++++++
 drivers/net/phy/phy_led_triggers.c | 16 ++++++++--
 include/linux/phy.h                |  2 ++
 4 files changed, 72 insertions(+), 8 deletions(-)

-- 
2.40.1


