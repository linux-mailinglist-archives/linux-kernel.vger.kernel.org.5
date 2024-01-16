Return-Path: <linux-kernel+bounces-28233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B92C82FBF2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995DD1C271FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C1E67C42;
	Tue, 16 Jan 2024 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubcZxb/V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA54916D897;
	Tue, 16 Jan 2024 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435516; cv=none; b=MA7rR8O0fek3JZWOYNycnwxC9PuzGeMNtq3893LJv+MjbZuDtaksba1XoAKj1aH/17ZKaMxdI/Eq7P3jh4AxLFOxj6sblC1JIbsusGUVTraC1pWzz94c9Ale6+rsqGEHVhwk7niS/peCzgxVFFAm0r2BEF/fE9Lz/dlpOJjZPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435516; c=relaxed/simple;
	bh=JNUs/LQJo+qUNmb0T0rSBK5V7IO4R3L3oqT2O4dn6pE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=C3ZYe7z8J8cXLzbBfM8RTGkBSr2MiSY7w/6bn+joSxizq2CWWCvNdFUsuM29i9usXXkFB9+e0AWxw3DBTp2HT/yOIzrgfRXLc29kSR4YDnNOKI7dTerD8/YfPnwNvAm8ZgCiyNSsfXFBzbhlnzxKzLhjDMvnxq2PBWqHupE1AB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubcZxb/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEDEC43394;
	Tue, 16 Jan 2024 20:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435516;
	bh=JNUs/LQJo+qUNmb0T0rSBK5V7IO4R3L3oqT2O4dn6pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ubcZxb/V3QrqR6eqheT+2G7PJfZ3rguO42pUMj4w0mpsbRm9PdAmnnc02REFLQHBC
	 AFr/5QoCUVkAba2wnktOnXsekRaxzEl1Lq/c/6eDqIVaB1A+KJegjSGkS4gK7RjPJ9
	 HwFk6hix4OjDVBw0yPhGY7bN4sMSZz67Wg8JKQBvUHxeBSoaPXx4bVMMln3wLl9Cq7
	 4mAXCtcXikR9Uzgk12QZDNM4D4W6R4GGL2bu5IOpEK/BZhuAWGnDD30Vn3SFIpUhEs
	 1y03gJbKmx3/tlEHQryyYRAEPDWqUunyA6S8Fw14R/h8CFgBXcQTdTrcWPeNq2qqRA
	 uM2Zlgx3in4AA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 22/22] wifi: cfg80211: free beacon_ies when overridden from hidden BSS
Date: Tue, 16 Jan 2024 15:04:16 -0500
Message-ID: <20240116200432.260016-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200432.260016-1-sashal@kernel.org>
References: <20240116200432.260016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit 32af9a9e1069e55bc02741fb00ac9d0ca1a2eaef ]

This is a more of a cosmetic fix. The branch will only be taken if
proberesp_ies is set, which implies that beacon_ies is not set unless we
are connected to an AP that just did a channel switch. And, in that case
we should have found the BSS in the internal storage to begin with.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20231220133549.b898e22dadff.Id8c4c10aedd176ef2e18a4cad747b299f150f9df@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index d871349036a5..7f1a4ba975dd 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1018,8 +1018,12 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 				list_add(&new->hidden_list,
 					 &hidden->hidden_list);
 				hidden->refcount++;
+
+				ies = (void *)rcu_dereference(new->pub.beacon_ies);
 				rcu_assign_pointer(new->pub.beacon_ies,
 						   hidden->pub.beacon_ies);
+				if (ies)
+					kfree_rcu(ies, rcu_head);
 			}
 		} else {
 			/*
-- 
2.43.0


