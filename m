Return-Path: <linux-kernel+bounces-30959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553C08326D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 989DCB24258
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDA73C493;
	Fri, 19 Jan 2024 09:37:54 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5271EB52;
	Fri, 19 Jan 2024 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705657074; cv=none; b=aVw7nF/kkkvTIT9QjO/CKIwpfbvhseC3BXoZbLWzfWEhzAHPcclxHGKS9ILP9VLtMZFPyvCIy7TbmXSId5jeMl5SoCLKA2+iW/wDXRLhtnZGAWL2pwP/fh5VlfcW/V2DCfALonsaKe6lIiwvsq+sz/U9nCzw1jUvxCQKlxoaaRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705657074; c=relaxed/simple;
	bh=fhRyHl9d9j86uNZdgU/t59QbpKu7S7LsJf51vQuHOmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NzTgUyp9RsKCdx1k1H70ej7fLOW0fu5jID8dxZPLD6khi1B+3En9/fAaxK3Cn4j/IdZ6fL9BPi50LZeoLBX3zp57nNcwc7RD9DpnxDyksgMWPvYUaLAwf+66n8o+bSbAP//E/SMWjICPURcGc2CpKWQeas7EhnT6rPwlIXdZZEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from cmd.. (unknown [39.174.92.167])
	by mail-app4 (Coremail) with SMTP id cS_KCgBHY4LZQqplMTVLAA--.7396S2;
	Fri, 19 Jan 2024 17:37:30 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: djohannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lin Ma <linma@zju.edu.cn>
Subject: [PATCH net-next v1] nl80211/cfg80211: add nla_policy for S1G band
Date: Fri, 19 Jan 2024 17:37:24 +0800
Message-Id: <20240119093724.7852-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cS_KCgBHY4LZQqplMTVLAA--.7396S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw18tF1xZr4Utw1xCrykZrb_yoW8XFWkpr
	WDJFZFy347tw47JFWrCa18XasrXanrG34rur4YyFyxZ3Z0gw1FqFyY93W3tr1fZFs5t34r
	XF4ktw15t3Wa93JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUU
	UU=
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

Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
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


