Return-Path: <linux-kernel+bounces-113801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207BB8886AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC8E290C59
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022C91FA834;
	Sun, 24 Mar 2024 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohh8n+Al"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2A0146D73;
	Sun, 24 Mar 2024 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320821; cv=none; b=jQajULTOqMcKH0iF1Sr9sVdoZxIqloJz+vyqjUM/KaVf6Ot2IeRxwPrdj0oXpa4i0Xu6ZY8oQweA+hvtG9Nrmlj6Pq9YCo1ltvOLytgpmpiS1nZvk4q/qquaotRlcXM6PkiiYXwMAwVvetG1P70SzqYVizu27KQag1jB6eU61r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320821; c=relaxed/simple;
	bh=M2OsYs51VjFRIBUMTBUyP13zL0lmYIgF0zd8yxKnow8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeKmsVXRm834A1UCAbUJdMga2E6e3u5kvjrsO2ESAxsqwtLhkzAxk58SkJyFYbtq+b4Yec5ObyTcN7s2+a/TPb1gy0c3sL6DZ7wTFqkiiZT6DmpFFULP38RX1sOK57EBjq22VewKyVZ+Hm/EdZSYbaRXf3ggWEhdiSwY/RBofdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohh8n+Al; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971D0C433C7;
	Sun, 24 Mar 2024 22:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320819;
	bh=M2OsYs51VjFRIBUMTBUyP13zL0lmYIgF0zd8yxKnow8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ohh8n+Al/U10C36TRU0vkztZxwB4WEAPS6v8v+pw99+iDae9mMc99qMEW8Z6eJDT0
	 8QiwJiUGvamXiBJyQVEBSHt2txGUgIbOAOHyx9S8VA3JHBgnWppW9WYkv+dItswRU1
	 oY2inn/flD6AM2auRADlkU9ZHi0xCng9ESZ1Oy652hIOWzf7Lt2AG9pI8Bw6H0KGQx
	 MhjZ4XUsutTmSIRE5los+IFimfNpdxr82pYzwfU/9zby0zrSyxozhxoSgUGRPytH1S
	 QWEwitidWgKCGUxfykVqMuzduNVLI1leNQ7aSRqL5HnSuy+oW7Dplk7+2ZVo4NY8AS
	 RDQ2ubl2PCEug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: William Tu <witu@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 384/713] devlink: Fix length of eswitch inline-mode
Date: Sun, 24 Mar 2024 18:41:50 -0400
Message-ID: <20240324224720.1345309-385-sashal@kernel.org>
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

From: William Tu <witu@nvidia.com>

[ Upstream commit 8f4cd89bf10607de08231d6d91a73dd63336808e ]

Set eswitch inline-mode to be u8, not u16. Otherwise, errors below

$ devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
  inline-mode network
    Error: Attribute failed policy validation.
    kernel answers: Numerical result out of rang
    netlink: 'devlink': attribute type 26 has an invalid length.

Fixes: f2f9dd164db0 ("netlink: specs: devlink: add the remaining command to generate complete split_ops")
Signed-off-by: William Tu <witu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240310164547.35219-1-witu@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/netlink/specs/devlink.yaml | 2 +-
 net/devlink/netlink_gen.c                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 572d83a414d0d..42a9d77803b2b 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -244,7 +244,7 @@ attribute-sets:
 
       -
         name: eswitch-inline-mode
-        type: u16
+        type: u8
         enum: eswitch-inline-mode
       -
         name: dpipe-tables
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 788dfdc498a95..371f27f653317 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -198,7 +198,7 @@ static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITC
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_ESWITCH_MODE] = NLA_POLICY_MAX(NLA_U16, 1),
-	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = NLA_POLICY_MAX(NLA_U16, 3),
+	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = NLA_POLICY_MAX(NLA_U8, 3),
 	[DEVLINK_ATTR_ESWITCH_ENCAP_MODE] = NLA_POLICY_MAX(NLA_U8, 1),
 };
 
-- 
2.43.0


