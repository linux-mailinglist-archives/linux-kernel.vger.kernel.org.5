Return-Path: <linux-kernel+bounces-114466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFE4888ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17468B2D6E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C8817BB2B;
	Sun, 24 Mar 2024 23:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFT8aoze"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D52210DF;
	Sun, 24 Mar 2024 23:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321890; cv=none; b=swksaxz23u6RL4SnNgOkTP/xnudAlMJG/xYTapfGavn6W6gGIcTtsy+UHgMZkzPC4ZwfVaKBNXH5oEV3PBzid302PKsmHNanT2iFgnlymrTYH1RpgVWvbu/MJ1W/gZqEDpmNJp08mL5618+NWiq5qN4EOPjMi/wmVV/MM7VzRVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321890; c=relaxed/simple;
	bh=E2R52L8IyfHAqj1g/QjHvsRYE4HYLzHkG2Hu6aVvulI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjKle6M1vqmuWr6JVYlc02c5POr3RnoqRYPkjWua5IsbG/uZuArzFR0Fcb+dGXlqYKlgJjIA/GZGMIo1mI9H+Mnq0qqU4misdxql4eEjnNmQ//7L/ig6PWPuzHfkMCEbSI+9hZHDzobTyDAfl5XJ+2xjSrYnqJDTSJzB0ohqKHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFT8aoze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F74CC43399;
	Sun, 24 Mar 2024 23:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321889;
	bh=E2R52L8IyfHAqj1g/QjHvsRYE4HYLzHkG2Hu6aVvulI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rFT8aozewx0YZuFAmtz1kipYSVGhPDfk2U4aZGDMNQ9k8wrM/O/qSoAltrA3sYO7B
	 bx65qwp+yyU/xTxcD7/zm4mSrBuIYrHfodAyvB8FDD1zcfXeBnS0Fhod2y81lVD+kg
	 NrSQIAomrHtOfYUwFtw4tRGUZFE8bjYxym71AfiqLHFG71RUNv44XS5gCQhm/Y5tJ/
	 DD3G+Zo3Mi5Kx1Sj6qzFyD0V6fQbiPGfbOzhxOnllIMRIekc78hcnvHswU5ZRQyU1T
	 WxkJwhfjFzJCceFZhY81aqi/zKXEgUPoe0AnNWQ4ys5RtKuZt0zW+0beDk77awkasR
	 d8DWEUMeanoCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiri Pirko <jiri@nvidia.com>,
	Chenyuan Yang <chenyuan0y@gmail.com>,
	Parav Pandit <parav@nvidia.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 617/638] devlink: fix port new reply cmd type
Date: Sun, 24 Mar 2024 19:00:54 -0400
Message-ID: <20240324230116.1348576-618-sashal@kernel.org>
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
index 9b5ff0fccefdd..4d49c21997e61 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -881,7 +881,7 @@ int devlink_nl_cmd_port_new_doit(struct sk_buff *skb, struct genl_info *info)
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


