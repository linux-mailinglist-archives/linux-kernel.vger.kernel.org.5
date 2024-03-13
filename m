Return-Path: <linux-kernel+bounces-101766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C50087ADB1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21FCE1F21F86
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E4460B84;
	Wed, 13 Mar 2024 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/IbJxUf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C160889;
	Wed, 13 Mar 2024 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347591; cv=none; b=QjWfDjd1Kays0AWfea4RdfgpuwKH+zqsYQ6q+vcxs5bft1aoF6Q0TuM1wLFmd0Al4CNPg0vDaTcxfhR0DczQvAAMSa33+MDlPwekuWiScT+vBgH1AUyZyIr47r6YzLVJMc1v//v9wIlFo22P10pWKEXMDUVUxE5XVK/lE/y6pzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347591; c=relaxed/simple;
	bh=BPbJntuskVES4ughBqn58IDptAR3zQxTerFw4OXbovw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgP3o1JadReuHb1Tg9wG506H8QLf/w/PC35qqbKNxUJuFyp5OfcOVPGyJwHCKZKNC6y5lP2HK84ekg8lhniMLGa+pIo1qr6lDFFwRrPLm7cwYBMqb2O6YvDG6en4wY7hcuNhd2FJBUqZaympx4p+NLrnZHd9umwuW/1Bo/JoNG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/IbJxUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF56C43394;
	Wed, 13 Mar 2024 16:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347591;
	bh=BPbJntuskVES4ughBqn58IDptAR3zQxTerFw4OXbovw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m/IbJxUfQ3Q+5opwuJgtd6grMc/7OLTyRDvCIvvq6W5HceBXy2AQn1a1MngBYrMxZ
	 kKBWgvV+q54cXJG3aAXbLy0IPe/xzuqqGI8QGX0ZoNRFnAC5sX0lGbPYX28SgrD48O
	 WDcPFoIj4HhuLozT+dtNR5Hg45/xX8wW4yo8yc0XLmSlVP8qR0VuvJIw/5WLud5nXZ
	 Npdslur149yS3gqGp4RxhoqD0WMleh80ZaV3rOMnPx/DkZci096Y6EfuZoYoRQC1so
	 /RQ204Pwl3sqpJNATqEJZ1/aaz4evIbAL0Abqp9W6FLU+hgTMJJ46zYs2pNrOH1qdd
	 VoDJg+5lMc1kQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 27/61] net: sparx5: Fix use after free inside sparx5_del_mact_entry
Date: Wed, 13 Mar 2024 12:32:02 -0400
Message-ID: <20240313163236.613880-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Horatiu Vultur <horatiu.vultur@microchip.com>

[ Upstream commit 89d72d4125e94aa3c2140fedd97ce07ba9e37674 ]

Based on the static analyzis of the code it looks like when an entry
from the MAC table was removed, the entry was still used after being
freed. More precise the vid of the mac_entry was used after calling
devm_kfree on the mac_entry.
The fix consists in first using the vid of the mac_entry to delete the
entry from the HW and after that to free it.

Fixes: b37a1bae742f ("net: sparx5: add mactable support")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240301080608.3053468-1-horatiu.vultur@microchip.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
index 4af285918ea2a..75868b3f548ec 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
@@ -347,10 +347,10 @@ int sparx5_del_mact_entry(struct sparx5 *sparx5,
 				 list) {
 		if ((vid == 0 || mact_entry->vid == vid) &&
 		    ether_addr_equal(addr, mact_entry->mac)) {
+			sparx5_mact_forget(sparx5, addr, mact_entry->vid);
+
 			list_del(&mact_entry->list);
 			devm_kfree(sparx5->dev, mact_entry);
-
-			sparx5_mact_forget(sparx5, addr, mact_entry->vid);
 		}
 	}
 	mutex_unlock(&sparx5->mact_lock);
-- 
2.43.0


