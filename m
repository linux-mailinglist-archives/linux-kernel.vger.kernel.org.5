Return-Path: <linux-kernel+bounces-73788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE385CB36
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5011F22828
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAEB154C11;
	Tue, 20 Feb 2024 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="3chpQOZd"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C6154439
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469802; cv=none; b=ME8DDZm2rPmnkFVGTcikzf6PgQd16XjzO5cG8R3OmMU+G2GESG8mAnku4dA+n+5l5lXst6ID+SwG8raWZOJGwN+imiDL/+63CoWEtKyuTgRfK+7qG4IrgCWZUaC3fFQqaneOjtsdOvF2m7IZfQxZJ7a4D3/Mx63NbEPD0L5P6gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469802; c=relaxed/simple;
	bh=TQb+yjBJI0RqUJiGCwnQz9AbbKBBI+P+muUhOx96Ss8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xh19oJzT9H3GtIvqygI/JzgPFJQXLRu8zUUAF8sPEjbpuihCkEJa7dLs/5OrdOEFc5xDs5TWQs98HhnBXMOgobyd6/Dnx1FTEwB+ESl+g6ZqYiy/05wBOyCudYc96HR+EocGiIDJex/3N2jemyQZvvO0l/bEcZgP2neH3DFmDJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=3chpQOZd; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3e75e30d36so505778866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708469798; x=1709074598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+0dCCMqItsu36IAUkOXIrkrvGFkrhGQYZYWjbbWBV4=;
        b=3chpQOZd9Ae5hbi/Nxfjvr34v/txPuathr8Y6REY6LL8bwyLPE8NaLdRP34XuIZeH9
         9JjVG/k/9AzV2OiQ/cPPxofUS3NTvHOR/rFJMkJqRvB3Y4ajWicEYY+cLEAlTDPcQXVV
         OG/Y9HnG0Wo1tdrekWvrmgUhY9hEmZkJKB0HoJUenhZycc6ZIltFsA7Ivu6X1awAdIcR
         3MXiHV6fTX2p3BzETmSbjWLm6UQG77IjHa0MaAOF8XvGjZ4BgzcUJEvwQ62mZDARNxRs
         kIpO5Agt5TVe0M0viABSovSsCqhrqM1yhvLsWTPkcqQfJk5XA52w7juRCEVcWTdXZjwJ
         j7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469798; x=1709074598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+0dCCMqItsu36IAUkOXIrkrvGFkrhGQYZYWjbbWBV4=;
        b=g4MIdEtSX8LYhziIMYYnIR7rSumX0ZTuoqCarS0VOjVC6rRj25jGD0qHnfzOnmRFgl
         cvvHCdJSn6xnbp7m5czCdXMyXTaUxrFl/Mf7W0hMtvRZDxhERQcpPThZwohK7jGlRPm8
         ozwWwuZNiJMi4BRWyLimdmqxhVkpq+6By0W7KOQKfWH540UrTQCcIap6vUVuqAjFyEP4
         oM/usWSGM7V/2yE8vzClzkD0rWiILGC27TyV6LiDsFwwohEkwaBKlhMPyiQRLCQFcxkG
         EUYMuv0Ov0gZyuiTcAeRQM8LfE/QFYWN2/o66nFH6mys60+oGl8B2kMFyxXiCTIS8zpz
         pPDw==
X-Gm-Message-State: AOJu0YxCqTSJ93ptCsisScF3EgK8MpGvt5rm2uYaU366hMZd5dHByruw
	x7OVDr98G+TcKRmhMWOezuVHh1VNZmPxiXR56jNkmCI89wcCB00mmzt45iAW+DEBW4ium5nPQ+0
	g
X-Google-Smtp-Source: AGHT+IGjuPW+er1ehC/QrHQAlmcBaFalt4vDWYvAxCpzpYV/4O0IVe6YF7BJOdtNZ7Mngn2adOsMGg==
X-Received: by 2002:a17:906:b281:b0:a3d:d201:25cb with SMTP id q1-20020a170906b28100b00a3dd20125cbmr13013105ejz.6.1708469798725;
        Tue, 20 Feb 2024 14:56:38 -0800 (PST)
Received: from airbuntu.. (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id vw13-20020a170907a70d00b00a3c5d10bcdbsm4381946ejc.114.2024.02.20.14.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:56:38 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v6 4/4] sched/fair: Don't double balance_interval for migrate_misfit
Date: Tue, 20 Feb 2024 22:56:22 +0000
Message-Id: <20240220225622.2626569-5-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220225622.2626569-1-qyousef@layalina.io>
References: <20240220225622.2626569-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not necessarily an indication of the system being busy and
requires a backoff of the load balancer activities. But pushing it high
could mean generally delaying other misfit activities or other type of
imbalances.

Also don't pollute nr_balance_failed because of misfit failures. The
value is used for enabling cache hot migration and in migrate_util/load
types. None of which should be impacted (skewed) by misfit failures.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/fair.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 20006fcf7df2..4c1235a5dd60 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11467,8 +11467,12 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		 * We do not want newidle balance, which can be very
 		 * frequent, pollute the failure counter causing
 		 * excessive cache_hot migrations and active balances.
+		 *
+		 * Similarly for migration_misfit which is not related to
+		 * load/util migration, don't pollute nr_balance_failed.
 		 */
-		if (idle != CPU_NEWLY_IDLE)
+		if (idle != CPU_NEWLY_IDLE &&
+		    env.migration_type != migrate_misfit)
 			sd->nr_balance_failed++;
 
 		if (need_active_balance(&env)) {
@@ -11551,8 +11555,13 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	 * repeatedly reach this code, which would lead to balance_interval
 	 * skyrocketing in a short amount of time. Skip the balance_interval
 	 * increase logic to avoid that.
+	 *
+	 * Similarly misfit migration which is not necessarily an indication of
+	 * the system being busy and requires lb to backoff to let it settle
+	 * down.
 	 */
-	if (env.idle == CPU_NEWLY_IDLE)
+	if (env.idle == CPU_NEWLY_IDLE ||
+	    env.migration_type == migrate_misfit)
 		goto out;
 
 	/* tune up the balancing interval */
-- 
2.34.1


