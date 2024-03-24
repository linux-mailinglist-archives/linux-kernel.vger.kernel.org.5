Return-Path: <linux-kernel+bounces-113582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B88888579
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0CB6284975
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59E91CA4FF;
	Sun, 24 Mar 2024 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ciz9SzHL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04121CA4E6;
	Sun, 24 Mar 2024 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320386; cv=none; b=Ewq2zpEgIdJKj8xFgdkIy7u40RAOKqGO90m5Ie1HbMMHkTjJQ1Lbt0Iut8bm6kNOuU070WpQNzgja3fqGgsEYIKppl4R/tXbXxkBdLL+XXvbijzJupPeg+AtZ0FUCFl/b2RgQThREec9VCIl67ryZ1B8H4Gg6OLV0gpNM3Z88LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320386; c=relaxed/simple;
	bh=M3RyVEmAdG18Uf98CnWxfJEQF+9AM22OpQEfaCG5vEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKMnhN/DrYbMlHgUEIRq7L26nPBnl/Iys1xzZsRE2cOEpT8qcZ+wAwi2VAuccAahaXcYvYmOZ2HY57mIHgzM7ptyUO/Rja3Hdo7Rzpu8astRTF8yqZb3cq9MgcyfmX0ibPGV+wGOlnheE0Whna8IkMZdZROxPPqCMDIG6G1E9ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ciz9SzHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB982C433C7;
	Sun, 24 Mar 2024 22:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320385;
	bh=M3RyVEmAdG18Uf98CnWxfJEQF+9AM22OpQEfaCG5vEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ciz9SzHLi4mD3stnIFjkQSJuTDCPC5qhpAvFjUapvBU6OE7x4ule3ObgwiQISZC0T
	 ujBuIyTaZfLuRY3tOV5HjIKvAGIgF4nopD2f9QTBsMt2Bi0QU3UtlNZQcJCHHmuUsD
	 +bmnrDG6gdaNk9SFt/s5fLMksrSQqO7NO5IXCuU9laMc5L0emKgh3pE0Iwc45TutZT
	 PJ4eTu9H300urfkS/riyliRvJQ3n3IAYni9yfoq3DzFRCsu2P2W05TNJE90B01pmNu
	 l05Q3hjwnktCaBbhBnPhYh0gDPPY9WJ7iI/KSzHBl3AvFBYfj/W2rGEahSgw4vJHxa
	 owgBwap1inb4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiri Pirko <jiri@nvidia.com>,
	Chenyuan Yang <chenyuan0y@gmail.com>,
	Parav Pandit <parav@nvidia.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 691/715] devlink: fix port new reply cmd type
Date: Sun, 24 Mar 2024 18:34:30 -0400
Message-ID: <20240324223455.1342824-692-sashal@kernel.org>
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

From: Jiri Pirko <jiri@nvidia.com>

[ Upstream commit 78a2f5e6c15d8dcbd6495bb9635c7cb89235dfc5 ]

Due to a c&p error, port new reply fills-up cmd with wrong value,
any other existing port command replies and notifications.

Fix it by filling cmd with value DEVLINK_CMD_PORT_NEW.

Skimmed through devlink userspace implementations, none of them cares
about this cmd value.

Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
Closes: https://lore.kernel.org/all/ZfZcDxGV3tSy4qsV@cy-server/
Fixes: cd76dcd68d96 ("devlink: Support add and delete devlink port")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Link: https://lore.kernel.org/r/20240318091908.2736542-1-jiri@resnulli.us
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/devlink/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/port.c b/net/devlink/port.c
index 4b2d46ccfe484..118d130d2afd5 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -889,7 +889,7 @@ int devlink_nl_port_new_doit(struct sk_buff *skb, struct genl_info *info)
 		err = -ENOMEM;
 		goto err_out_port_del;
 	}
-	err = devlink_nl_port_fill(msg, devlink_port, DEVLINK_CMD_NEW,
+	err = devlink_nl_port_fill(msg, devlink_port, DEVLINK_CMD_PORT_NEW,
 				   info->snd_portid, info->snd_seq, 0, NULL);
 	if (WARN_ON_ONCE(err))
 		goto err_out_msg_free;
-- 
2.43.0


