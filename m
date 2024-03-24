Return-Path: <linux-kernel+bounces-113300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EE7888339
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9959F1C23501
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68471190693;
	Sun, 24 Mar 2024 22:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZajpdAo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946C5190673;
	Sun, 24 Mar 2024 22:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320100; cv=none; b=L4rmif/WAjITv/OUMuQJoxoyE/MhzS7vfxHVu69dFUWw956FvmnSzQ+xh5nOvU9aMuReL8nJyfATqAeSbj8Fgez/OWd552PhB+zTo2PR9eJKzH4TweLqxXXeyEzCzE2KHq1eMCUsbCWYVzHPA/VtrczQrGE4c4gNzBHXtRRCOF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320100; c=relaxed/simple;
	bh=TlP6/AQtNqw7rwGx8wZwwQ5PsKZq/5mbyDLs6BK6zYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKTKZXTa/dEXKZxJtI1un/M5eNGidjH5nqWEiFmk0bo2hL6anYyEK8G9coeO3pgCxLY4M3EUDe1ayPERRFJ3Qjmd3r2a07S+4JKrUVoNirZNuMjDBxuRl4pZiRiVSn0usFLVn/um7UucQXpT/i7rFuCN7c5R3RSbJLCo/DUkxsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZajpdAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87E5C433B1;
	Sun, 24 Mar 2024 22:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320100;
	bh=TlP6/AQtNqw7rwGx8wZwwQ5PsKZq/5mbyDLs6BK6zYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DZajpdAoykbNCnHMIsqUTaodqw8q5CwUnj8WGZght53Fwo9LDHtAWG6oQP59ormkv
	 YIVTwK0krC6KEo9gW2kwPdxTK1sdNTD1f41XhbnmD/g9esIPzUlJto5df6kLA0JB1i
	 AiN3wI7bp/XvY2k1fVpyBCX8mHYmnUuijBfDuMOsigpStfuOqtJ7aBVdD7E1FDr4dp
	 U8I3IkhGEF5qTWHMGPCP9ndaa5RaQ4WyGWHuBATd/NgqRpufAyfH+aRqn502m101ZD
	 eWn4toqt4dY7HEJCvnvtARdNCw8zyk6dmcu8pV0nkYSP0X43Ap+4j+CldftBsOci59
	 68qRY98qVvfyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 409/715] PCI/P2PDMA: Fix a sleeping issue in a RCU read section
Date: Sun, 24 Mar 2024 18:29:48 -0400
Message-ID: <20240324223455.1342824-410-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


