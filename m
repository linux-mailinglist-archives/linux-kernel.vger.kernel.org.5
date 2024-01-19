Return-Path: <linux-kernel+bounces-30836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBAF8324DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5701F2348F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857466FB0;
	Fri, 19 Jan 2024 07:09:13 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD352186F;
	Fri, 19 Jan 2024 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705648153; cv=none; b=dpVg5etD4A6FiPbjXvimtA3GDNwjF+RAOKMt6SVnUE/pXL0+r3a8Ock46z9KcSF4QYrIjmmdhc7h5lTZNNWGxtPVu+aUvAaVDMf735HR0MUaV30BNsLFOEDms10iIHDG8kKeexwK+EBLVLcXkudOqhFghOiFeVmqp7EpDdA4GWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705648153; c=relaxed/simple;
	bh=B4FqppSt2LDQB57hJ959RB88Rbm/8I/Enz2IwTTW/88=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=umaRovsyPI59M5DyakqWbUr1kaRlRxFbtz8T2amNXTcJsqFYcyX1DxyujwWvOO0WDti+UkmHJccoJ1WLtDZmbEmRqur6I7PDegakDJZ+7uD2th8RiSatDXVQdK32nDA3W2SENDay6h9AOKVc0XQkkWMwF+PbmfFGvNB/r9QgRd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from cmd.. (unknown [183.159.169.110])
	by mail-app3 (Coremail) with SMTP id cC_KCgDnyjQAIKplWz1JAA--.63700S2;
	Fri, 19 Jan 2024 15:08:48 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	razor@blackwall.org,
	leon@kernel.org,
	linma@zju.edu.cn,
	haleyb.dev@gmail.com,
	ja@ssi.bg,
	judyhsiao@chromium.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1] neighbour: complement nl_ntbl_parm_policy
Date: Fri, 19 Jan 2024 15:08:47 +0800
Message-Id: <20240119070847.5402-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cC_KCgDnyjQAIKplWz1JAA--.63700S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Gr43JryUuF1rZF4UJF4DXFb_yoW8Jry5pa
	yDu3429ayDZr47Aa9rXayv93WIgr1qqan8Xr17C34ay3s7tr1kC34Utry0vr1SyF4kJrya
	qa15Ar43JFWIvwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUr4SrUUUUU
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/

In the neightbl_set function, the attributes array is parsed and validated
using the nl_ntbl_parm_policy policy. However, this policy overlooks the
NDTPA_QUEUE_LENBYTES attribute since the commit 6b3f8674bccb ("[NEIGH]:
Convert neighbour table modification to new netlink api").
As a result, no validation is performed when accessing the
NDTPA_QUEUE_LENBYTES attribute.

This patch addresses this issue by complementing the policy to ensure that
every attribute being accessed is properly validated.

Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 net/core/neighbour.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 552719c3bbc3..ece0447cf409 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2293,6 +2293,7 @@ static const struct nla_policy nl_neightbl_policy[NDTA_MAX+1] = {
 static const struct nla_policy nl_ntbl_parm_policy[NDTPA_MAX+1] = {
 	[NDTPA_IFINDEX]			= { .type = NLA_U32 },
 	[NDTPA_QUEUE_LEN]		= { .type = NLA_U32 },
+	[NPTPA_QUEUE_LEN_BYTES]         = { .type = NLA_U32 },
 	[NDTPA_PROXY_QLEN]		= { .type = NLA_U32 },
 	[NDTPA_APP_PROBES]		= { .type = NLA_U32 },
 	[NDTPA_UCAST_PROBES]		= { .type = NLA_U32 },
-- 
2.34.1


