Return-Path: <linux-kernel+bounces-115558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D20BB889424
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E60B1C2EA7B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B2A14B09B;
	Mon, 25 Mar 2024 02:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGheUJE7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E859E1F1ADC;
	Sun, 24 Mar 2024 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321088; cv=none; b=HyC7CXV6+IZ91PjgSi+RaSfpPxSXRXg5rr6/zvxtHA/9KaTxFZ4LqbK/ykAP/oYIjSzcIA9DuOVkMyMPBCeXsUkyLHK+ifO35tHGxoZaYO0yhKJAuJW41oYQhG4x0OhBg0y2D4f7pd3dZ3LzogsPttsq/vkSYCtKKVpgTDx7u+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321088; c=relaxed/simple;
	bh=mT8CPKPTFzdNbzFNWoRo7kKXrSvp1WjcoYFwixPGY5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuT/b5Pl/H/vz8MKIxrEQIkw2R5SvjtRxZp3QKPERmv3BhOeqet30RzsJcH2J9NOidd5Z284TJC68jlMfr/H09rirgiR7GVVCHdxtoTbjrBJs2OWc5LO9+9jrINj+PA4j7dHQwyYWavpw9WsbQtWMAeQi41IB7rB0bMdkl69qqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGheUJE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1394C433F1;
	Sun, 24 Mar 2024 22:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321087;
	bh=mT8CPKPTFzdNbzFNWoRo7kKXrSvp1WjcoYFwixPGY5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YGheUJE7Df+wgTgi+A48mNvb0wjqi0qjK3ozJ12A+EwoswXTBedvAxiAbBBNpNCBD
	 1P0myp1HbPdW8wq22EXrwsh719cxBV3cXHv+uzLbtqppMfoApeF7xLx5aNGIEMISJC
	 DOyRbTdMd98fDDGOxodiEC2LVPUS+l8Mm1xSeFOflm/dMGWOhCMWV84iys25TLcBcL
	 PP4h6SrEIfmmQ6xfIbWltF9O8oiyDjWvRXKuS+Ysreruui9xQCxyrBBXK89vvrHSMG
	 6xgB9JnyvRl3Nfp7mjq1ahtWGC8FfaYW5JsIKDOZngFs1nNQkEmMV9BRxLJgMshUjK
	 fR7qAGL15HfOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 651/713] devlink: Move private netlink flags to C file
Date: Sun, 24 Mar 2024 18:46:17 -0400
Message-ID: <20240324224720.1345309-652-sashal@kernel.org>
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

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 526dd6d7877b80b1f56d87156b65b8227c69d59f ]

The flags are not used outside of the C file so move them there.

Suggested-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: d7d75124965a ("devlink: Fix devlink parallel commands processing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/devlink/devl_internal.h | 3 ---
 net/devlink/netlink.c       | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 183dbe3807ab3..2a9b263300a4b 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -111,9 +111,6 @@ int devlink_rel_devlink_handle_put(struct sk_buff *msg, struct devlink *devlink,
 				   bool *msg_updated);
 
 /* Netlink */
-#define DEVLINK_NL_FLAG_NEED_PORT		BIT(0)
-#define DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT	BIT(1)
-
 enum devlink_multicast_groups {
 	DEVLINK_MCGRP_CONFIG,
 };
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index d0b90ebc8b152..7350138c8bb44 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -9,6 +9,9 @@
 
 #include "devl_internal.h"
 
+#define DEVLINK_NL_FLAG_NEED_PORT		BIT(0)
+#define DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT	BIT(1)
+
 static const struct genl_multicast_group devlink_nl_mcgrps[] = {
 	[DEVLINK_MCGRP_CONFIG] = { .name = DEVLINK_GENL_MCGRP_CONFIG_NAME },
 };
-- 
2.43.0


