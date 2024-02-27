Return-Path: <linux-kernel+bounces-83780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3A7869E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB43F1F26D83
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C1B148FE5;
	Tue, 27 Feb 2024 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7dxSv9L"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6E4EB43;
	Tue, 27 Feb 2024 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056506; cv=none; b=LXnT2LyBskVKpxGi5eD2XnhgsjI56/rjLBVxgakdpyQMjon99tounDPbWCLOnYEfArXaZKOlE/QNyfBUrgaMYnJnDyHZ3tO6kSDzBbo1Iqjt00BTHaKydxYp7uU25lTTgxzrfWzrciw49wm0iecGSz4Wwi0+dBPgcjXvRl+vf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056506; c=relaxed/simple;
	bh=jHN3tRkeyWXUF4PoS2kFP2C63E523qj7XuTWKcVW5ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qK0R5vv4ixuxwu7GlICjgzrUrkwGg53akabFMmSH/eUume+IdzAu/9iI6HHTtTMdcV+UtY1qLzkR6CRpgMJ3J7OP/eYUfxOIEkzYMZPWt+6NZNoXK5Sqq1T7cHX+pVDaBci/hvyqW5z3ml4yT+zZ/KlkYAekxUv4rj/TZ8YrVn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7dxSv9L; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5131316693cso981496e87.0;
        Tue, 27 Feb 2024 09:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709056503; x=1709661303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uk1KGO1+AohNid8DnjpbSS6vp6f+7NuWj+M0Q1V1DM=;
        b=e7dxSv9LqFAvxD92N7YS9hkCjLSf30rjr9QTIeDnS8ynVfx/TS4i6EkiaZFr6LoFxH
         qRWfe6/va35OaiWq9qjQP6eAIy6yExuPXlF57F30XE0u4La0dkW7/tIK5iSdaLLb0q12
         y8qvtAizorLMSof7JgIkS8UFRU7qlrnXNFQv541Q+jq1qz9ich3QpIaNH1CEzpdec5ow
         MHh5ZinKK/LMm4ef2IJi67vMq+skjwCWw12IWR2qFSbU+QdXP0Rz29OPe1YxlToa9Wp2
         268Cg94i+r2uYySNm+GLC3Yxam62+oEjTRqm15Ep92TATyT2wdKfs+G/H1rYu3HvKE3D
         s08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709056503; x=1709661303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uk1KGO1+AohNid8DnjpbSS6vp6f+7NuWj+M0Q1V1DM=;
        b=vVgzmn3CbM17h7d55wLqeLBeWqdGg2wSv7bOzN3DXmJPEzvDRfxpVtqBm1OZINQMQy
         /0qjGG41nlWIdYbqcjV5uaNeSCDblo4da8D/2FXC/pCEO5z0wO37dw8rVgWWBW6FACQU
         a21kVI46g3rYP7/9pYWjByvSdECxokFgJco0/BLjjg4lI8jwSbFIrDNbqLiq5cfzqdQp
         YND5iMNcPW1Mt6ZLRpc4V7hu5/7BaBfpIjhLodz2EKawHyNP87nwYcyFBCkpAaxRlWta
         NxYg9EUNv4Qc/zFOaTTeqgeH/TmVwnQLK2Efpub1p75uOxOUybE16V22RDV73hMKg/9O
         JyLg==
X-Forwarded-Encrypted: i=1; AJvYcCUkkeue2hYEpK3qodfj+Rim7/KcTfpD9oekZ+2g17y8LyQUKsqSpq8ozWOZMSfaMQ/HfU9/eGwcr5Baey17uwJJeO5x99l7H4Ho8eDvPmFoxReNCcuOq/0MMNI79mfs1KaI5mMj
X-Gm-Message-State: AOJu0YwJnUf/cZs3tVRD3aJF4p1OrMdBnqge+t7lAjwOb0+gPOaaYb9B
	pq8Fh9k5DdQ81YaWJN+Pdb/IAZcfXwKZEHcajM9TZcY2nsziF6Ks
X-Google-Smtp-Source: AGHT+IFhN03eZ2Y8wahOmH6bSHTe04BlfUZRUSMV04bYlxOVrRzZ6W1snsfIqv3MkiF9LHfdQJUaQg==
X-Received: by 2002:ac2:59c6:0:b0:513:13e3:89e7 with SMTP id x6-20020ac259c6000000b0051313e389e7mr971169lfn.45.1709056502688;
        Tue, 27 Feb 2024 09:55:02 -0800 (PST)
Received: from fedora.. (cpe-109-60-83-139.zg3.cable.xnet.hr. [109.60.83.139])
        by smtp.googlemail.com with ESMTPSA id fd1-20020a056402388100b00566439b97c4sm629268edb.44.2024.02.27.09.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:55:01 -0800 (PST)
From: Robert Marko <robimarko@gmail.com>
To: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: rename mv88e6xxx_g2_scratch_gpio_set_smi
Date: Tue, 27 Feb 2024 18:54:21 +0100
Message-ID: <20240227175457.2766628-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227175457.2766628-1-robimarko@gmail.com>
References: <20240227175457.2766628-1-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The name mv88e6xxx_g2_scratch_gpio_set_smi is a bit ambiguous as it appears
to only be applicable to the 6390 family, so lets rename it to
mv88e6390_g2_scratch_gpio_set_smi to make it more obvious.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c            | 2 +-
 drivers/net/dsa/mv88e6xxx/global2.h         | 2 +-
 drivers/net/dsa/mv88e6xxx/global2_scratch.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 9caecb4dfbfa..f9378fca8305 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3712,7 +3712,7 @@ static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
 
 	if (external) {
 		mv88e6xxx_reg_lock(chip);
-		err = mv88e6xxx_g2_scratch_gpio_set_smi(chip, true);
+		err = mv88e6390_g2_scratch_gpio_set_smi(chip, true);
 		mv88e6xxx_reg_unlock(chip);
 
 		if (err)
diff --git a/drivers/net/dsa/mv88e6xxx/global2.h b/drivers/net/dsa/mv88e6xxx/global2.h
index d9434f7cae53..20fefa08f54e 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.h
+++ b/drivers/net/dsa/mv88e6xxx/global2.h
@@ -378,7 +378,7 @@ extern const struct mv88e6xxx_avb_ops mv88e6390_avb_ops;
 
 extern const struct mv88e6xxx_gpio_ops mv88e6352_gpio_ops;
 
-int mv88e6xxx_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
+int mv88e6390_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
 				      bool external);
 int mv88e6352_g2_scratch_port_has_serdes(struct mv88e6xxx_chip *chip, int port);
 int mv88e6xxx_g2_atu_stats_set(struct mv88e6xxx_chip *chip, u16 kind, u16 bin);
diff --git a/drivers/net/dsa/mv88e6xxx/global2_scratch.c b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
index a9d6e40321a2..0e15efd898f2 100644
--- a/drivers/net/dsa/mv88e6xxx/global2_scratch.c
+++ b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
@@ -240,7 +240,7 @@ const struct mv88e6xxx_gpio_ops mv88e6352_gpio_ops = {
 };
 
 /**
- * mv88e6xxx_g2_scratch_gpio_set_smi - set gpio muxing for external smi
+ * mv88e6390_g2_scratch_gpio_set_smi - set gpio muxing for external smi
  * @chip: chip private data
  * @external: set mux for external smi, or free for gpio usage
  *
@@ -248,7 +248,7 @@ const struct mv88e6xxx_gpio_ops mv88e6352_gpio_ops = {
  * an external SMI interface, or they may be made free for other
  * GPIO uses.
  */
-int mv88e6xxx_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
+int mv88e6390_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
 				      bool external)
 {
 	int misc_cfg = MV88E6352_G2_SCRATCH_MISC_CFG;
-- 
2.43.2


