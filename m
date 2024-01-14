Return-Path: <linux-kernel+bounces-25462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D0682D0A7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 13:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B335B21945
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313213C2C;
	Sun, 14 Jan 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="EInfFyvi"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4CF2905
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-553ba2f0c8fso8724361a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 04:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1705237011; x=1705841811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pY9ccWIX+AH6o9JCFXUPqHV0K431ksU7XgejXVYizs4=;
        b=EInfFyviTNKhmLFc+FjwyBILd1v36erFgsaw0mHIUh+IcRcOE/YbxrZbX8ougSAxFi
         lRtH9/uwK26zO9YKxRT8pGzFaOBMY/uI7+K3b036sX+lss0Ds6V3jVmv8wIOZzS9FrUQ
         SVyN+rgBjmubZq7ZNXf6c/a3jANYJlxEmpddc5RDLlzINiiPv/qDzvtTL7qOENWncbkB
         yx+yIShR+hOR3EEH5ZOdnvazccCGD96mgOkbqyhW6VxnnzVo9Sfg33hgVdgpwr6/rLiZ
         VoMciBZX2RaImkdq4ogURJxLX7IYi/XWH++go6r79ilJtdGzdhxS5HlOZ0mjNk1knPrn
         /73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705237011; x=1705841811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pY9ccWIX+AH6o9JCFXUPqHV0K431ksU7XgejXVYizs4=;
        b=XlAOufdP2iQPSBlKO5p+AaL5jKpzhhNR5cTQe42BpL47Xfo1U28uuXwNMfdwMB9gTb
         P0miFoPDFswvsA0CWa6QC3h483Emm+xX+1kicpUI1hqHTqb44f7EDvGA8YaM2bs1O/sS
         Uvz3JZS9uwCwarjUb5vUdpKEThR979FQvRzkUrvwAyCkLxuv8IAO06cDTZWl+jUCCQAm
         XBw8NjlljBwu/rnHmE8vMQn5jptLCqjEV1UHw5NLvNgPOwHctKn2WDtbi5Sk031pRBF3
         7mup3cjopZZzOkAAaOOK9FH5vjSUJj+kHI97GsNpxUBPn86Bc/jW2Dkvri87iwYVupXE
         RqhQ==
X-Gm-Message-State: AOJu0YyIFBt4eSiISWQPqYF58PbBiBs0Bgwm41P+hwxrgCARX5a7y66W
	wFl/oEoKU76YRS/41j9sCCYO+4QoaYFIfw==
X-Google-Smtp-Source: AGHT+IFo+PoeFkF9RxantxP3T0COudlNZgb/Up6ZJuGEEqst7uCWrA4UD+CwfVi++1aZwjTw03uquw==
X-Received: by 2002:a17:907:c11:b0:a28:f817:24ac with SMTP id ga17-20020a1709070c1100b00a28f81724acmr1096667ejc.35.1705237010265;
        Sun, 14 Jan 2024 04:56:50 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id fj10-20020a1709069c8a00b00a2d0868cdf9sm2168577ejc.35.2024.01.14.04.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 04:56:49 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: broonie@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: mazziesaccount@gmail.com,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: event: Add netlink command for event mask
Date: Sun, 14 Jan 2024 18:26:44 +0530
Message-ID: <20240114125645.2356445-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add netlink command to enable perticular event(s) broadcasting instead
of all regulator events.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 drivers/regulator/event.c          | 28 ++++++++++++++++++++++++++++
 include/uapi/regulator/regulator.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/regulator/event.c b/drivers/regulator/event.c
index ea3bd49544e8..8ae8e606bea8 100644
--- a/drivers/regulator/event.c
+++ b/drivers/regulator/event.c
@@ -14,17 +14,41 @@
 
 static atomic_t reg_event_seqnum = ATOMIC_INIT(0);
 
+static u64 event_mask;
+
 static const struct genl_multicast_group reg_event_mcgrps[] = {
 	{ .name = REG_GENL_MCAST_GROUP_NAME, },
 };
 
+static int reg_genl_cmd_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[REG_GENL_ATTR_EVENT_MASK]) {
+		event_mask = nla_get_u64(info->attrs[REG_GENL_ATTR_EVENT_MASK]);
+		pr_info("event_mask -> %llx", event_mask);
+		return 0;
+	}
+	pr_warn("Unknown attribute.");
+	return -EOPNOTSUPP;
+}
+
+static const struct genl_small_ops reg_genl_ops[] = {
+	{
+		.cmd = REG_GENL_CMD_EVENT,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = reg_genl_cmd_doit,
+	}
+};
+
 static struct genl_family reg_event_genl_family __ro_after_init = {
 	.module = THIS_MODULE,
 	.name = REG_GENL_FAMILY_NAME,
 	.version = REG_GENL_VERSION,
 	.maxattr = REG_GENL_ATTR_MAX,
+	.small_ops	= reg_genl_ops,
+	.n_small_ops	= ARRAY_SIZE(reg_genl_ops),
 	.mcgrps = reg_event_mcgrps,
 	.n_mcgrps = ARRAY_SIZE(reg_event_mcgrps),
+	.resv_start_op = __REG_GENL_CMD_MAX,
 };
 
 int reg_generate_netlink_event(const char *reg_name, u64 event)
@@ -35,6 +59,9 @@ int reg_generate_netlink_event(const char *reg_name, u64 event)
 	void *msg_header;
 	int size;
 
+	if (!(event_mask & event))
+		return 0;
+
 	/* allocate memory */
 	size = nla_total_size(sizeof(struct reg_genl_event)) +
 	    nla_total_size(0);
@@ -73,6 +100,7 @@ int reg_generate_netlink_event(const char *reg_name, u64 event)
 
 static int __init reg_event_genetlink_init(void)
 {
+	event_mask = 0;
 	return genl_register_family(&reg_event_genl_family);
 }
 
diff --git a/include/uapi/regulator/regulator.h b/include/uapi/regulator/regulator.h
index 71bf71a22e7f..21ffa36e2ab7 100644
--- a/include/uapi/regulator/regulator.h
+++ b/include/uapi/regulator/regulator.h
@@ -69,6 +69,7 @@ struct reg_genl_event {
 enum {
 	REG_GENL_ATTR_UNSPEC,
 	REG_GENL_ATTR_EVENT,	/* reg event info needed by user space */
+	REG_GENL_ATTR_EVENT_MASK,	/* reg event mask */
 	__REG_GENL_ATTR_MAX,
 };
 

base-commit: 94cc3087aac4103c33c6da84c092301afd783200
-- 
2.41.0


