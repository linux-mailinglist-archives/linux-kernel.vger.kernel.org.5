Return-Path: <linux-kernel+bounces-115952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F53A8898CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 412FCB3DFA7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9469039140E;
	Mon, 25 Mar 2024 03:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRceyeT7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460AA22E165;
	Sun, 24 Mar 2024 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322198; cv=none; b=iL4fzYXA1qeAqiDodHS/rOmxqvouYPU3vDnwHS6qWNUG6Dzwz1ydu7IJ25lQAvX4RvFVVHCQPfvxoie0/jA1ZhcHFkoIOTaH4m6xtnL6PqIIMUkiQt3opKr9Ok7B7k5RCGc4pKpjBsZF2I1iACh2JGXYPjO6hpGGcQpcBdjtT/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322198; c=relaxed/simple;
	bh=u9V+WyAANI9l04UH2rsHq7yZipBH/zr5JZGM795s4MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIH0NSIkCDZ2feS7JxxkBaNi1/ecezLVjkNH3SnhvU6EUejG0R4BXGfdkuMrz1hDUosdvzUajQthSAlb1/p6favT4X5JP29J0zyTAQzIHwMAF9yz+Rs7pn+DCsCbZ9EA2WFQPCX37P2WatPwOlXkrV9XC7kq9RWh1kuso+yzP98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRceyeT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839D9C43399;
	Sun, 24 Mar 2024 23:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322197;
	bh=u9V+WyAANI9l04UH2rsHq7yZipBH/zr5JZGM795s4MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dRceyeT7O23LeciVxCuXR0xKygcSgz+cOcDOxkqAnPq7J5XWOYh+lad/YIzyzMSE1
	 dW+OBiM5AstuYII9NvAjBp46lEQ9JKzFpqOV+hr+4VVJNeln1cJAx7DuCmAMhQeWMB
	 X1AnRiYrgFoyyy2qO5DO3OUKu2uGqGkOvL4ZkEhtma+gom22YCZYBF2OsttFjMr1/f
	 QY3XsLZNaGttqSs51G1rZpdPXuzQBAzfFoxP5sU1MN+dJkdlruJR/RxwLoxES/eGQo
	 VqEfYaIn1fmeuQcLQppqh40kG8WYBxZxDr5USyyXwbTqJ5X6mPhFnYf3eQmDfEvo/w
	 RRRfMfT/Z9Mgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 276/451] PCI: switchtec: Fix an error handling path in switchtec_pci_probe()
Date: Sun, 24 Mar 2024 19:09:12 -0400
Message-ID: <20240324231207.1351418-277-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit dec529b0b0572b32f9eb91c882dd1f08ca657efb ]

The commit in Fixes changed the logic on how resources are released and
introduced a new switchtec_exit_pci() that need to be called explicitly in
order to undo a corresponding switchtec_init_pci().

This was done in the remove function, but not in the probe.

Fix the probe now.

Fixes: df25461119d9 ("PCI: switchtec: Fix stdev_release() crash after surprise hot remove")
Link: https://lore.kernel.org/r/01446d2ccb91a578239915812f2b7dfbeb2882af.1703428183.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/switch/switchtec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 3f3320d0a4f8f..d05a482639e3c 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1674,7 +1674,7 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 	rc = switchtec_init_isr(stdev);
 	if (rc) {
 		dev_err(&stdev->dev, "failed to init isr.\n");
-		goto err_put;
+		goto err_exit_pci;
 	}
 
 	iowrite32(SWITCHTEC_EVENT_CLEAR |
@@ -1695,6 +1695,8 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 
 err_devadd:
 	stdev_kill(stdev);
+err_exit_pci:
+	switchtec_exit_pci(stdev);
 err_put:
 	ida_free(&switchtec_minor_ida, MINOR(stdev->dev.devt));
 	put_device(&stdev->dev);
-- 
2.43.0


