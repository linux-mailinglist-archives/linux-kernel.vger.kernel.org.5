Return-Path: <linux-kernel+bounces-124680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8830A891B53
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2926EB267C2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF04171E4D;
	Fri, 29 Mar 2024 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fh2TUUOQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50954171677;
	Fri, 29 Mar 2024 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715688; cv=none; b=JkZBY8lP8UyKc/w7GJepB0n7zcNe7ZLbFW8JWSOnx25mfM/A1ax9Vw8jqJxPQa9qt4IOEknJSSVtTH2MlYqabFRIfYMT6T9IxGFPh6YaFTIJpBfRXpipTejQXsYmrGZTppoipaJLbjyf6kBMa3NyATi5XAd4AaxrjsXgNxSUNug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715688; c=relaxed/simple;
	bh=twDLGvPJQ+B9GgLuoQNBwZ3oy3K0DvO0WQRtvidVAOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCQ8jQ9T6vCwA6l2qLu8qBosTCibtP1Nzi/S23vup+oOQ8WHRG6e4lVMWwsMP55fR8ZV3ujHr/rAcZDODn9LF7ecXuJ/zeH3abz5PuJqAXmz1EyYveAvQaNlFLX6I09CUu4dpmO2atXIu31c815SOwJy2+h3J0/rjkLeT/qk6rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fh2TUUOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC54C43390;
	Fri, 29 Mar 2024 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715688;
	bh=twDLGvPJQ+B9GgLuoQNBwZ3oy3K0DvO0WQRtvidVAOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fh2TUUOQh/MOln2k3r8glWjaI5cp4k/Z6mAzVFE8xZZGuVlCPbC1MhmKUBk62LuGa
	 1lDx0wDScro2g4ySwlWeRm+OsWnh9sYMnVaA0gmIA3AE7e2rcvxJBS/5mi+9GRTriu
	 crPPIBkEEcY+VkOVR2rOFiardWW47WqmXeH8l60NqNRQQE6YDLMZxPdWnJ4s/DTeI/
	 7bCrVyY6rEN20fa8R4xopHFKkyV+XzQ5SUlOSkeuMi68OMPqGSDxMLSNG/fto+A4iT
	 T+D3ZFI1MLMC5O4BWoQiUT9MGJgFSVx/XnHTv6dYlutPZBov2W8pIS8CcjYNr0LzJW
	 usG/DITda+UJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markus Elfring <elfring@users.sourceforge.net>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Sasha Levin <sashal@kernel.org>,
	mareklindner@neomailbox.ch,
	a@unstable.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 02/15] batman-adv: Return directly after a failed batadv_dat_select_candidates() in batadv_dat_forward_data()
Date: Fri, 29 Mar 2024 08:34:25 -0400
Message-ID: <20240329123445.3086536-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123445.3086536-1-sashal@kernel.org>
References: <20240329123445.3086536-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
Content-Transfer-Encoding: 8bit

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit ffc15626c861f811f9778914be004fcf43810a91 ]

The kfree() function was called in one case by
the batadv_dat_forward_data() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus return directly after a batadv_dat_select_candidates() call failed
  at the beginning.

* Delete the label “out” which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/distributed-arp-table.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index dda62dcd59c8a..c5b7e9994a018 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -682,7 +682,7 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 
 	cand = batadv_dat_select_candidates(bat_priv, ip, vid);
 	if (!cand)
-		goto out;
+		return ret;
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
 
@@ -726,7 +726,6 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 		batadv_orig_node_put(cand[i].orig_node);
 	}
 
-out:
 	kfree(cand);
 	return ret;
 }
-- 
2.43.0


