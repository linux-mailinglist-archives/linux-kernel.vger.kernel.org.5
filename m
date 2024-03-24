Return-Path: <linux-kernel+bounces-114291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DADA88899C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB181C281E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF6E25FF57;
	Sun, 24 Mar 2024 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOuPZQVQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AE11ED0CC;
	Sun, 24 Mar 2024 23:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321665; cv=none; b=tlN0QtqSd8/KkmeqyHNUYLeCcnkk1eEEK/GjFQpa1u1v18kTg8jMZe12f/GbitIrepxatowwK+aNTIXhQ0L7BnbSVqiklH1JEIbatTHiI8va9ghtwAmkyiU4J+SoKzxOgmkYibfIkI8a+V6gozpdJXxtqBd6DSPvAl+bsG4BphY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321665; c=relaxed/simple;
	bh=ppeDvN+dAlDV8DFEvXcl8obmqcthApyH6YVITn8wH9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbsJmHrOtltOzEBNgBGod9KNQ9+pjGC41YKRpciqdEdU02saqGTZGvKxxk6B1aH638XXWJlXKFVz1iy4c7PINSd//x4bR3d0OiRYFcDd9wZIIBswDzfVAfkPUFWXrGR5tjyFTXTO5FOLQZL8zj8t0auSpNF14/mbb7x0Kr5b1+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOuPZQVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B709CC433B1;
	Sun, 24 Mar 2024 23:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321664;
	bh=ppeDvN+dAlDV8DFEvXcl8obmqcthApyH6YVITn8wH9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dOuPZQVQ32S8aYiA2zb78E2YQm+qwQarIS8RI2tDROvddTcwaWsEu1L5V+aIEbtik
	 8UNuXz9Cg6s7uF9qbSZ/mHaDCfz+niDB7LturbZ1NZZqrl3yM7Scm7rpKHHYUgNLNu
	 /jKY391IMZuFpROo9Y9C4v1sbch2ndK9qAoFMu10UFMbkUNfW97kXfvzkHCFAaojlh
	 x6c9rBWVd11E31WBoerkv4kDuyAFOo7/WxvYYrVoxSOp/jemwTKc9KLk2Vg8NznQVj
	 wpwzCs5YmvCAanHIr7RcG1na1CQJ/ZlTiOnN44jF/GangTtXMDh6T8D29e0FmdPbt2
	 e1wZ6/oJ4ByyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 394/638] PCI/P2PDMA: Fix a sleeping issue in a RCU read section
Date: Sun, 24 Mar 2024 18:57:11 -0400
Message-ID: <20240324230116.1348576-395-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index fa7370f9561ac..b8becc7257cda 100644
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


