Return-Path: <linux-kernel+bounces-27760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F182282F575
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875061F219F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7276A1D526;
	Tue, 16 Jan 2024 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cMcoIqDi"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1DC1D527
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433751; cv=none; b=md6ZvQedLi7FbbI4gq6Bn176foswEpnUKXZQ0W2nxACoVMjNDpZzqBfK2TVxjuWobjlQuxr22rNF4Ple6vsf+lvSLCqfPjrPTcwMDuPMLxNrnSAlBXSOshNb1xYNYs2yZb3Jum/mjL9M8RlzJsw1X2qNguEeMzykNQC9ORCx+ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433751; c=relaxed/simple;
	bh=uUviqQzZ6yqzUj8cwWwwpNed4jYbfKHdOdB05Ot4mKc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=YjPi1FzTRP5F6i+kAXH8rUsSo9n0qC3tvQxOA8jXuxtnSo0tBnrakh3KH0SLFxXU8o6N80L6Z+uewj6Auv3qhDG9K+dciXdlgfv//WnWLWV0ECT8tS4iiTjtNG43gRIaLfT6HX9UDudatPx5CU9+3yX931BrgOQ/ZfcWzAgIPBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cMcoIqDi; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3b84173feso18850505ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1705433748; x=1706038548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lN21UoYVG3q3CIJY5zwTJEuSqGvtUy/320xHsRSfnj8=;
        b=cMcoIqDiDD0fkAYZBbh73X5BdRZmYmsmLnMWh29Bf7tO/sxASgDNtOqJ3ZFhPgDxEj
         mno0Pj9DPz2k/qZs7RrLLnVWHxNfJNHE/Jzp/sqSlLjFw6Rb6qAvusRLSYEY84yZeEOQ
         8V6LaKuftf2rlAeJ+T+/DVIe0Ke+vYVoUAAflUU85d6wxDe1kYWYL9gsNy34YEWDhBPw
         iRvMvqv5Owe9gEQ2bIDsEbTBgS4jHZOQfhlI9S/r2siqeN5srPBhI/950cpLDtIrRO6g
         3NSTu4gUZ8oa2hcU5Ib/fu6IqjF8KkII0aGZ0OgAfA4cH4IrmQ7MLtKXWgbSDniAZTlS
         ep+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705433748; x=1706038548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lN21UoYVG3q3CIJY5zwTJEuSqGvtUy/320xHsRSfnj8=;
        b=EqaBVTALVxEpAi9aSIPwVX87sY7IP5sT7rzMs96fRHWyQzjISYvtVZ/XZJdmD00vu0
         HghPp2CeUFNw3pZhTiXvgTuO/zShb0CNSOYBu3/5pU6RjzqsH7toNdifyA/OpQ8yR0nY
         RYz4ktE+SYe3ILSPv9rMXu/W25HogFW49/Xl8lUbZ4baPddu+tcXGsfrDeJSdD3+StBr
         Bh3E+0pVctvtDQIAy0sY+rpJQaDEpsmm6YcF+M98ESUv3rTpgZtb5oLGe5a0x+7BS82h
         DavyjiTf+No0g15reNi9xgmBHh/EYwgnj2OdsiMnjlbhP4UmOmVKKXVy6/e/msMJA4KV
         RYPQ==
X-Gm-Message-State: AOJu0YyzOeVJHKcnmCsU/f4s3K2P0Y3EAHhhlr8PMu8t1sAPSfEQs6vt
	+h5bkAZa20YaTNg9isvck33zwBCGjeBqnw==
X-Google-Smtp-Source: AGHT+IHgaQxu+fo0p7kBODmwbE8dEEysBWs3pa/bizoTyfXzhWrAErmsA8Qy48KS5AwByz9FYMDK9w==
X-Received: by 2002:a17:902:d50d:b0:1d5:4c03:9988 with SMTP id b13-20020a170902d50d00b001d54c039988mr15076371plg.2.1705433748520;
        Tue, 16 Jan 2024 11:35:48 -0800 (PST)
Received: from localhost ([208.88.158.129])
        by smtp.gmail.com with UTF8SMTPSA id g12-20020a1709026b4c00b001d08bbcf78bsm9538598plt.74.2024.01.16.11.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 11:35:48 -0800 (PST)
From: Tim Menninger <tmenninger@purestorage.com>
To: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: dsa: mv88e6xxx: Make *_c45 callbacks agree with phy_*_c45 callbacks
Date: Tue, 16 Jan 2024 19:35:42 +0000
Message-Id: <20240116193542.711482-1-tmenninger@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the read_c45 callback in the mii_bus struct in mv88e6xxx only if there
is a non-NULL phy_read_c45 callback on the chip mv88e6xxx_ops. Similarly
for write_c45 and phy_write_c45.

In commit 743a19e38d02 ("net: dsa: mv88e6xxx: Separate C22 and C45 transactions")
the MDIO bus driver split its API to separate C22 and C45 transfers.

In commit 1a136ca2e089 ("net: mdio: scan bus based on bus capabilities for C22 and C45")
we do a C45 mdio bus scan based on existence of the read_c45 callback
rather than checking MDIO bus capabilities then in
commit da099a7fb13d ("net: phy: Remove probe_capabilities") we remove the
probe_capabilities from the mii_bus struct.

The combination of the above results in a scenario (e.g. mv88e6185)
where we take a non-NULL read_c45 callback on the mii_bus struct to mean
we can perform a C45 read and proceed with a C45 MDIO bus scan. The scan
encounters a NULL phy_read_c45 callback in the mv88e6xxx_ops which implies
we can NOT perform a C45 read and fails with EOPNOTSUPP. The read_c45
callback should be NULL if phy_read_c45 is NULL, and similarly for
write_c45 and phy_write_c45.

Fixes: 1a136ca2e089 ("net: mdio: scan bus based on bus capabilities for C22 and C45")
Fixes: da099a7fb13d ("net: phy: Remove probe_capabilities")

Signed-off-by: Tim Menninger <tmenninger@purestorage.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 383b3c4d6f59..ba972d5427e5 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3739,8 +3739,10 @@ static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
 
 	bus->read = mv88e6xxx_mdio_read;
 	bus->write = mv88e6xxx_mdio_write;
-	bus->read_c45 = mv88e6xxx_mdio_read_c45;
-	bus->write_c45 = mv88e6xxx_mdio_write_c45;
+	bus->read_c45 = chip->info->ops->phy_read_c45
+		? mv88e6xxx_mdio_read_c45 : NULL;
+	bus->write_c45 = chip->info->ops->phy_write_c45
+		? mv88e6xxx_mdio_write_c45 : NULL;
 	bus->parent = chip->dev;
 	bus->phy_mask = ~GENMASK(chip->info->phy_base_addr +
 				 mv88e6xxx_num_ports(chip) - 1,
-- 
2.34.1


