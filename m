Return-Path: <linux-kernel+bounces-31302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A6A832C27
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9BD283825
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9E35475D;
	Fri, 19 Jan 2024 15:12:34 +0000 (UTC)
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net (zg8tmty3ljk5ljewns4xndka.icoremail.net [167.99.105.149])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DEC54667;
	Fri, 19 Jan 2024 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.99.105.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677154; cv=none; b=q5Vg/I0PWRVjeVBU9vqvbzaf+/jGSxxtaki5n4mnpdr0gfU5Wr0Xld+Ys66nIDMlvQZagHmvtAYaxrAu+gsjXdiUWTCF3VixJlikBYB9J3dFStBz2lBA6scWeIMxeHmkMAUwxFJP1wqqQ3NCi3HfFK9JfFESr1iv5C0L/gWg7iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677154; c=relaxed/simple;
	bh=ZpHwMNKONZyX/hLikKcxxkbOYJIh65C3dQXqbsmkVjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VvEZXRTeChrI1JAuTcNkJe5UmoH6zUN0X9aQq4ZJvkAnQNKyLAo4DsP+6b5g1eIxoUVsyWkjJYntPWs4cRhldNzhGRd0KSIr2frdXbRRpUtdYCiGH538237EVNPDL7PTiNsrGN/7Vw7kOsls4ATyZXwP5Uwr8VyGIhlML0czUcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=167.99.105.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from cmd.. (unknown [183.159.169.110])
	by mail-app3 (Coremail) with SMTP id cC_KCgAnLjlNkaplpfZOAA--.43165S2;
	Fri, 19 Jan 2024 23:12:14 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvalo@kernel.org
Cc: Lin Ma <linma@zju.edu.cn>
Subject: [PATCH wireless v2] nl80211/cfg80211: add nla_policy for S1G band
Date: Fri, 19 Jan 2024 23:12:01 +0800
Message-Id: <20240119151201.8670-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cC_KCgAnLjlNkaplpfZOAA--.43165S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw18tF1xZr4Utw1xCrykZrb_yoW8WFWkpr
	WkJrWqyr17tw47JFWrCa1xXasrXa1DG34rur4YyFyxZ3Z09w1FqF1Y9a43tr1furs5t34r
	XF4Dtw15t3ZI9a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUU
	UUU
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/

Our detector has identified another case of an incomplete policy.
Specifically, the commit df78a0c0b67d ("nl80211: S1G band and channel
definitions") introduced the NL80211_BAND_S1GHZ attribute to
nl80211_band, but it neglected to update the
nl80211_match_band_rssi_policy accordingly.

Similar commits that add new band types, such as the initial
commit 1e1b11b6a111 ("nl80211/cfg80211: Specify band specific min RSSI
thresholds with sched scan"), the commit e548a1c36b11 ("cfg80211: add 6GHz
in code handling array with NUM_NL80211_BANDS entries"), and the
commit 63fa04266629 ("nl80211: Add LC placeholder band definition to
nl80211_band"), all require updates to the policy.
Failure to do so could result in accessing an attribute of unexpected
length in the function nl80211_parse_sched_scan_per_band_rssi.

To resolve this issue, this commit adds the policy for the
NL80211_BAND_S1GHZ attribute.

Fixes: df78a0c0b67d ("nl80211: S1G band and channel definitions")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
V1 -> V2: change net-next to wireless as suggested

 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 60877b532993..980300621a60 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -911,6 +911,7 @@ nl80211_match_band_rssi_policy[NUM_NL80211_BANDS] = {
 	[NL80211_BAND_5GHZ] = { .type = NLA_S32 },
 	[NL80211_BAND_6GHZ] = { .type = NLA_S32 },
 	[NL80211_BAND_60GHZ] = { .type = NLA_S32 },
+	[NL80211_BAND_S1GHZ] = { .type = NLA_S32 },
 	[NL80211_BAND_LC]    = { .type = NLA_S32 },
 };
 
-- 
2.34.1


