Return-Path: <linux-kernel+bounces-117771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE2388AF6B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F171C61309
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF2810962;
	Mon, 25 Mar 2024 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrcrqrb9"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4457763A5;
	Mon, 25 Mar 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393640; cv=none; b=IRaHDA+YvoFFYeRvfkp8GvRYXUlDryuuiX13DSNdfI8BfPhWZVNCS3EjqWQNcq0qRH4lsVQ/LPmUcbVN5jjv6FAWM41s2CCR4oaCfayoOSUu4f3c3jDzzqexVE3EqqEs5EROCGguV6Nq5mTBBUzMeo011W74gFU4wrZ1+Ear0BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393640; c=relaxed/simple;
	bh=R1gMQnITYg/OSZ7ny+xj4dwu+8HA375SzGX3LTp4nDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bsftOcXpu9gNZY7hWwonOv/k2ljVcaycsT10KeButT4u2ghghIleOm93ANtbsDt/jFm2Bytb019/YM5n4eCoq2y0+11n4bLcXo4YIla3Gv0YF/hFPSiLE926ihkQPZY8Xbm5eSICzVO8zO5s5JOc+EjV4EoJ0pFa2jbm0rRj8d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrcrqrb9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34100f4f9a2so2803609f8f.2;
        Mon, 25 Mar 2024 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711393637; x=1711998437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qdQF1e0DPL90+YfbR/8OadJounnRa7UNnfPsT8scWp8=;
        b=nrcrqrb9CEYFxIWOC0GDtP8nI8HlAFvAV0PouQJM7UITUdo5V/EgoguLCgNKfYg0Y6
         z3Zhr2P7j93/wHc5g92kidwfV40r7P5A/GacbxRQOio/icqLwJOf1B+KsaVB6pwCWXEx
         iP2L+xQ7Z+mRsbdeuhSMq2Qe/uCwi2dI0dWpz6w1JSznpp7cc3PYD6Z/MDyVoE3bNEOi
         1SES6gherOiC6T3f4td1B2lkaQ/HGIFqjAcW85j2XKAExGnGkkqjdxYP4AoON150fOID
         s2QTdrQNDkgK+b3UQ5u6pn/YFohGczKqqf+ziSbCoAciQjj+FUpYf5UUJAACIYnZLw+C
         1LsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393637; x=1711998437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qdQF1e0DPL90+YfbR/8OadJounnRa7UNnfPsT8scWp8=;
        b=GsJXY5DvTj4Gjdjqxvi4rVp81kh1//7YsS5BCY3QJDorCMHC3K6YtQy6FH8EMm7IT0
         oo8lRAMn4piqHdcDMMS9//oy3+ZiUWGofW25g3h8Sdh7SYipXHog6zlUXwLhF4eNJ3OQ
         IK8wtyN+5h4eNFWsjDCab2rqAYJlklxE9xdOlNR0/1mIwdDJ09wYxv6CGEp2WOJr6YvX
         /D7Qs6UwKfLNN53Lq1f9G+pAOlMq/SrqzuCiG/d7MSv1eg3nl8JsV3yPFhjJpOQrVeYE
         joKYocGyH7wtValzT+zm0FDAeT4EcioSXJibwW/l1x7wtRLTu3nI+dXq5oVfzyJ/tDd0
         GhNA==
X-Forwarded-Encrypted: i=1; AJvYcCVGPCwjB3rN2u2t0tjDhCp3Cjoqb4As6qdMqV4G/7DiDmyNKeksYjHsUghFS2eMG8DnFTt4tjg2s0aWCtLM0IYZz4w5DtwT49SzsWixcIYqRN3+t+Dgfg9lhqQemSUe9wpDyCybyBUcCe+wTle6JPptkbBd7milZp8PQPkRDN08/d4gN6V/pzB3ww1fkdGwbqBwfoyMoV4ChtL+eg==
X-Gm-Message-State: AOJu0YyGHsWucimrO9OO1u5j6YsOsYP4btMerCDGVTLPXYSijkyBhZ88
	HCrlhVe64vEmZJrZns9QSoYbZ2p4MmsUWfxDWCtQc/yOEjfdkOvt
X-Google-Smtp-Source: AGHT+IENJ2YH4rBbHJIjWpOfKAtf1CaSVXXM3dTe50OdTvMGqH+p41Vt6oGnzPE/SuDaUCicZYLPBg==
X-Received: by 2002:adf:fa8b:0:b0:341:c449:d735 with SMTP id h11-20020adffa8b000000b00341c449d735mr4311383wrr.44.1711393637344;
        Mon, 25 Mar 2024 12:07:17 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id ay9-20020a5d6f09000000b0033b87c2725csm10356163wrb.104.2024.03.25.12.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:07:16 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: William Wortel <wwortel@dorpstraat.com>,
	stable@vger.kernel.org
Subject: [net PATCH] net: phy: qcom: at803x: fix kernel panic with at8031_probe
Date: Mon, 25 Mar 2024 20:06:19 +0100
Message-ID: <20240325190621.2665-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On reworking and splitting the at803x driver, in splitting function of
at803x PHYs it was added a NULL dereference bug where priv is referenced
before it's actually allocated and then is tried to write to for the
is_1000basex and is_fiber variables in the case of at8031, writing on
the wrong address.

Fix this by correctly setting priv local variable only after
at803x_probe is called and actually allocates priv in the phydev struct.

Reported-by: William Wortel <wwortel@dorpstraat.com>
Cc: <stable@vger.kernel.org>
Fixes: 25d2ba94005f ("net: phy: at803x: move specific at8031 probe mode check to dedicated probe")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/qcom/at803x.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
index 4717c59d51d0..e79657f76bea 100644
--- a/drivers/net/phy/qcom/at803x.c
+++ b/drivers/net/phy/qcom/at803x.c
@@ -797,7 +797,7 @@ static int at8031_parse_dt(struct phy_device *phydev)
 
 static int at8031_probe(struct phy_device *phydev)
 {
-	struct at803x_priv *priv = phydev->priv;
+	struct at803x_priv *priv;
 	int mode_cfg;
 	int ccr;
 	int ret;
@@ -806,6 +806,8 @@ static int at8031_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	priv = phydev->priv;
+
 	/* Only supported on AR8031/AR8033, the AR8030/AR8035 use strapping
 	 * options.
 	 */
-- 
2.43.0


