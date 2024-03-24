Return-Path: <linux-kernel+bounces-115579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A6F889C89
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574821F361EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412903406F1;
	Mon, 25 Mar 2024 02:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9lB33lS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE8B12D749;
	Sun, 24 Mar 2024 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321129; cv=none; b=OwrSRlyjxLWQzw18PWtFDXf1LNK0Y+fxORVeyFcvUYppa5FjzUOFsmXjkTLwWMTSHhj5A6RvNZPZk/mGkwr/FQ0SJQeMwurcGWbVtHTuXJTFQ81eo7YKvultPrYhoI7ZJcq0FyqLcdvL2XXW79JUNzPA+esS1mCix5BGy1IV0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321129; c=relaxed/simple;
	bh=bmFoJjVU2AEf7TV1FyCbH/W1afH2kBekjgg9DWjUQ9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiYqBZaOCSXGtzPKuLN4DJCodnsGGi1/KyhrEZFBJLZT7NBTd4xbrqRfZmcAT3LD4rTJaiNtZcKR3H49I4UGxiHl9Xc3q9iWCzacAYBjlhnAQmFtFKdPTTqQP36xy/58I6efOfiIsW1yM0Fot6+40Kudk5LuckWs75VZX59m+To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9lB33lS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788F9C433F1;
	Sun, 24 Mar 2024 22:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321128;
	bh=bmFoJjVU2AEf7TV1FyCbH/W1afH2kBekjgg9DWjUQ9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i9lB33lSDLgvVuLcAhHyqLvRYYVt9aWh33X2FuKjxSvYEmlbA3D3RB3u4lyvjpc7y
	 GH2qwAVI2VMgdUV0KMamJoscN20X9c0c9gbT+WWPm2yJOGJ1b1l+rtmcVtdR/Y67QY
	 r3qjY0tMY1+zFe6H0wGkrrVlL4qiWMZUO04Wdh5DgAs92HIgHShFaCBQ0OHrMr/r7n
	 bJmQhEe3IXMBYHgpguTFdjxVDYAwMEw7GGp6NJMIRAz3xQCCm/2vstkh8QMAvY4Ylg
	 lBrdSXbZTMMAXRCO7kXCInnenjiNzQlif015+c6vA+nTZV1eI5iyLCubX1qg3VWYRc
	 bbDYikeu2qToQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiri Pirko <jiri@nvidia.com>,
	Chenyuan Yang <chenyuan0y@gmail.com>,
	Parav Pandit <parav@nvidia.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 689/713] devlink: fix port new reply cmd type
Date: Sun, 24 Mar 2024 18:46:55 -0400
Message-ID: <20240324224720.1345309-690-sashal@kernel.org>
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
index d39ee6053cc7b..2b3c2b1a3eb37 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -887,7 +887,7 @@ int devlink_nl_port_new_doit(struct sk_buff *skb, struct genl_info *info)
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


