Return-Path: <linux-kernel+bounces-62697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4583F85247B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A941C23A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA047B3D2;
	Tue, 13 Feb 2024 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAUcZlpU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB077AE4C;
	Tue, 13 Feb 2024 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783772; cv=none; b=Al+0SDmYfDr/6ZcJidQR5VcyPcyFjK1TMuFBvY8aBxWWdSblqZ0LpPFOlwSy4dpJuOW2YdrRkDFfkjXo9wXvWtClYkKgEZOUqmx0feZg2JDlzeCMy2o0qRZ6y5T1ExjwWD6WTDbT8zDwkNeEQ0/mB3mdnjjjiHy6GXtwGw/LvR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783772; c=relaxed/simple;
	bh=YjKj5fdO5GCYBNAPM/rveeibmJo9xambdJjrbfrOhoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2MyJ82MPEjjYACb6KE2BbnoynfTAvCeSt1DyB04Kj04qne7UrvxrYWhUIhr3epJsK3dOJGiBUCMl9NrGWt34KloPzWH+NfRtPTIV18SjqctJ73iWvhyiDhb3paer9l1NMVzvGlQnJLMvjjzfa1QM81qDh0zGemosIGUFt5qK1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAUcZlpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAA5C433A6;
	Tue, 13 Feb 2024 00:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783772;
	bh=YjKj5fdO5GCYBNAPM/rveeibmJo9xambdJjrbfrOhoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OAUcZlpUrHXdu7fwCo+7xeORW361KD6Zf/2N3M49nH94+lKR5nzOJFkAB3oGS/oQu
	 /9DY2q88fDjDVtWfDgJAKHlZ3rGCnRqRMLvKBKpkdaurmQQoFHAgqozS5Ur8/AJgmF
	 XIduxZz2ifgeYkpwXOlS+vf+NlMdqgSIVALup8uTsF+nlHEnCb1AwXsCBzJsts57wz
	 KoJCh/EOnPYroxupMYG45ryN3ZO7WgtoK3khPcZiZPpSzheksj7fixyoURIbUl+yo2
	 m1MJyCdoOWquC5KVrEAzmb6i0fIO3vcrwBiy1oK1AwaVneV9K6Ot5q6JLrK+4PbdNz
	 75GMdJQlJ1lzw==
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
Subject: [PATCH AUTOSEL 6.1 13/28] wifi: mac80211: set station RX-NSS on reconfig
Date: Mon, 12 Feb 2024 19:22:11 -0500
Message-ID: <20240213002235.671934-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002235.671934-1-sashal@kernel.org>
References: <20240213002235.671934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit dd6c064cfc3fc18d871107c6f5db8837e88572e4 ]

When a station is added/reconfigured by userspace, e.g. a TDLS
peer or a SoftAP client STA, rx_nss is currently not always set,
so that it might be left zero. Set it up properly.

Link: https://msgid.link/20240129155354.98f148a3d654.I193a02155f557ea54dc9d0232da66cf96734119a@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a2c4866080bd..6cf0b77839d1 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1775,6 +1775,8 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 					      sband->band);
 	}
 
+	ieee80211_sta_set_rx_nss(link_sta);
+
 	return ret;
 }
 
-- 
2.43.0


