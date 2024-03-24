Return-Path: <linux-kernel+bounces-115468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBC98893F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC09F28C24F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CDB2210DD;
	Mon, 25 Mar 2024 02:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCwNO1HQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF445147C8D;
	Sun, 24 Mar 2024 22:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320877; cv=none; b=e0f0uGT4fpuqA9C0FAiCSytO7hNVbYCSAy5Lzkx4iYH5DbU8yJaXxEeDNOlQhedRv/BsoNPChPa38VPoBjOcnl0LLcj5+m1LAeb0e/boX7Qui30hsFaIV2ko+rxcnoTIVDmsi7E/dDLhIa3Sj6/L8wmtxEBP5SOyM6NmJFfpN78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320877; c=relaxed/simple;
	bh=TlP6/AQtNqw7rwGx8wZwwQ5PsKZq/5mbyDLs6BK6zYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsxtPLxfnQf5NCcJ+91m/YkwvMkHa7RaiXNYWp2Ma+hR4A8DV2KmfwrY5EF0Fo8ereLzzFpZGZ8Nd3sWt1aCHw9u4wwjhiv9ksHHLfAzMOivX/nODzCZCFP6ARMZIR1FjLSEyELPTnL+PvxZZee78yklWzaK6cNatutjABoySSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCwNO1HQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D918DC433F1;
	Sun, 24 Mar 2024 22:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320876;
	bh=TlP6/AQtNqw7rwGx8wZwwQ5PsKZq/5mbyDLs6BK6zYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCwNO1HQkOM4Dz5X6PgWutXvDjsgejCMpycO9OyQ+SOmoQ5tTByuVx0oPBP6fL4e3
	 Y+qVqVv8kJk4WvhtVmhwf+iqN/Qu8oHobnxUqLQxOoklBMmH9wz69v7PuSao9m2drS
	 SW/zmquY9DhtGGVqHEbeJrOFtHKsHSSNUWCZj6iA+65MdisJIQCt4fnXCB/E6y00US
	 /BMraX3n+QpT+R8lPLD3OFODZSwyG8er0zvnFSz9qxF/MyrYnhWLsFBvKGjiMOUJig
	 qX2ZFOHu9oSmPDjTo9iN3UWk+I99PNFDO88+hYCZ950IGgM7qhHoCjMyY7CF5MchK8
	 8cECbzYeWiM7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 441/713] PCI/P2PDMA: Fix a sleeping issue in a RCU read section
Date: Sun, 24 Mar 2024 18:42:47 -0400
Message-ID: <20240324224720.1345309-442-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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

[ Upstream commit 1e5c66afd4a40bb7be17cb33cbb1a1085f727730 ]

It is not allowed to sleep within a RCU read section, so use GFP_ATOMIC
instead of GFP_KERNEL here.

Link: https://lore.kernel.org/r/02d9ec4a10235def0e764ff1f5be881ba12e16e8.1704397858.git.christophe.jaillet@wanadoo.fr
Fixes: ae21f835a5bd ("PCI/P2PDMA: Finish RCU conversion of pdev->p2pdma")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/p2pdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 0c361561b855c..4f47a13cb500f 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -661,7 +661,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	p2pdma = rcu_dereference(provider->p2pdma);
 	if (p2pdma)
 		xa_store(&p2pdma->map_types, map_types_idx(client),
-			 xa_mk_value(map_type), GFP_KERNEL);
+			 xa_mk_value(map_type), GFP_ATOMIC);
 	rcu_read_unlock();
 	return map_type;
 }
-- 
2.43.0


