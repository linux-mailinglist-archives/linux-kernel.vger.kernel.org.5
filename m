Return-Path: <linux-kernel+bounces-62596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF3A852370
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108EB2811E7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1507F43ADF;
	Tue, 13 Feb 2024 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4jz1ZDN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4890D4315B;
	Tue, 13 Feb 2024 00:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783552; cv=none; b=HpA0PyXy6biBiofz7PHsKzHbr75+xpTvlf/TJkIjwo8DYJxXHRQbnPEMhTLhGklVgUH6whzZ9r6uSXygO5gH5HD4eCsdJDPhrykhWWhwIX4dvEN7NF87+VWFQCKta3+Qqn99ih8pv+69v0VGpzvxq9Tg7zyK+71KwYGQgj9Lrxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783552; c=relaxed/simple;
	bh=3Qx5ZQ8ji0z5USPZOIa9QVHNyjXb4KYCIIyFGc42XLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDW82lIYXWUIsXYZh3Ur8O0ODRsSdqKzNj8uKtQlgDqLl3rlMcBcZ731uGa6a/s2FD1UNc1LHRW4k7xUq0CjnwK4XPwD0Slyo0Yt2bYFlUVBR7BiJfNXxSxAvVFCfdS6MnNIfnTQcQwEYQbtPrulERrl8SiltpVlVjbLRWH3e6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4jz1ZDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1574C433F1;
	Tue, 13 Feb 2024 00:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783552;
	bh=3Qx5ZQ8ji0z5USPZOIa9QVHNyjXb4KYCIIyFGc42XLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D4jz1ZDN5IR1rsyZLyMh0yg3ZOywqH9aijMNh+I4+G81AA/VcmZfghAdXuEHcEZ11
	 AEydB2dgkbdDvjlgT9A82DhB5z6bn7J25a429NR79k4BEZgnbz2meTiizaa2qeblP+
	 Q1Ja8TDtqbBt8BWOLhoiMAHGU7FwZtVj265Pm9UMmHkOCvD5qq5hBgAgF5ramNbyA/
	 JUaVpVuyjW3aaw8FtiGnxanQkyXfCyFh1BDoHah2bgM4qeYikZfhQk7XsCJ7fRkrss
	 VcFGsIrjQlr0+pk9b0pIOahAFuwpoifDidoX2+8qonRGUcn1OE4ucjo3XJ+0H9PhAS
	 sGIAeuzlXZZ2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 27/58] wifi: mac80211: fix driver debugfs for vif type change
Date: Mon, 12 Feb 2024 19:17:33 -0500
Message-ID: <20240213001837.668862-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 733c498a80853acbafe284a40468b91f4d41f0b4 ]

If a driver implements the change_interface() method, we switch
interface type without taking the interface down, but still will
recreate the debugfs for it since it's a new type. As such, we
should use the ieee80211_debugfs_recreate_netdev() function here
to also recreate the driver's files, if it is indeed from a type
change while up.

Link: https://msgid.link/20240129155402.7311a36ffeeb.I18df02bbeb685d4250911de5ffbaf090f60c3803@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/debugfs_netdev.c | 4 ++--
 net/mac80211/debugfs_netdev.h | 5 -----
 net/mac80211/iface.c          | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index dce5606ed66d..68596ef78b15 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -997,8 +997,8 @@ static void add_link_files(struct ieee80211_link_data *link,
 	}
 }
 
-void ieee80211_debugfs_add_netdev(struct ieee80211_sub_if_data *sdata,
-				  bool mld_vif)
+static void ieee80211_debugfs_add_netdev(struct ieee80211_sub_if_data *sdata,
+					 bool mld_vif)
 {
 	char buf[10+IFNAMSIZ];
 
diff --git a/net/mac80211/debugfs_netdev.h b/net/mac80211/debugfs_netdev.h
index b226b1aae88a..a02ec0a413f6 100644
--- a/net/mac80211/debugfs_netdev.h
+++ b/net/mac80211/debugfs_netdev.h
@@ -11,8 +11,6 @@
 #include "ieee80211_i.h"
 
 #ifdef CONFIG_MAC80211_DEBUGFS
-void ieee80211_debugfs_add_netdev(struct ieee80211_sub_if_data *sdata,
-				  bool mld_vif);
 void ieee80211_debugfs_remove_netdev(struct ieee80211_sub_if_data *sdata);
 void ieee80211_debugfs_rename_netdev(struct ieee80211_sub_if_data *sdata);
 void ieee80211_debugfs_recreate_netdev(struct ieee80211_sub_if_data *sdata,
@@ -24,9 +22,6 @@ void ieee80211_link_debugfs_remove(struct ieee80211_link_data *link);
 void ieee80211_link_debugfs_drv_add(struct ieee80211_link_data *link);
 void ieee80211_link_debugfs_drv_remove(struct ieee80211_link_data *link);
 #else
-static inline void ieee80211_debugfs_add_netdev(
-	struct ieee80211_sub_if_data *sdata, bool mld_vif)
-{}
 static inline void ieee80211_debugfs_remove_netdev(
 	struct ieee80211_sub_if_data *sdata)
 {}
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index e4e7c0b38cb6..11c4caa4748e 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1783,7 +1783,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	/* need to do this after the switch so vif.type is correct */
 	ieee80211_link_setup(&sdata->deflink);
 
-	ieee80211_debugfs_add_netdev(sdata, false);
+	ieee80211_debugfs_recreate_netdev(sdata, false);
 }
 
 static int ieee80211_runtime_change_iftype(struct ieee80211_sub_if_data *sdata,
-- 
2.43.0


