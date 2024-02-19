Return-Path: <linux-kernel+bounces-71883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 082C785AC30
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B131D1F22F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1D4535A4;
	Mon, 19 Feb 2024 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw6EhW1Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C237524CF;
	Mon, 19 Feb 2024 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371880; cv=none; b=H2Gp5wEj2wKf7Pd4CMrdwQr08Kqy/mNPuGtfINQh1kBTRx68NbaD1pFgceywlaEuYlsx8CmENpsZQ6rPEXKCAL7Kg0zDbZGGhMgKC5IySrjxoLUuiWvyu6CqRFOCr4wFzhkros2GUHoPAfAbIZxkzezerPANhUwP4pgqzmSFdfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371880; c=relaxed/simple;
	bh=D150sO/L6KppSwNTajXy1QJufbQ+UvH1B/ezhNJc/3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rd4cHi/khmHKf8BUDl7ZEkJGWeLEY+ZtJUbFkguoxa+M9FpOldshgvgSn9caTOF/9ftmIRP9JGk+C+V50qPFF4GlrJZ33g8nFWS5bO3tNbDenpVbRMoqF74M1MElTCp2Jtj8F6dlsIO2PgfvAm9YaRdK0tDJpQct7Mqpajk35UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw6EhW1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB99DC43330;
	Mon, 19 Feb 2024 19:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371880;
	bh=D150sO/L6KppSwNTajXy1QJufbQ+UvH1B/ezhNJc/3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jw6EhW1ZSt+p4B9o5bnE7L9Um41kTj5LlJ11v+SKB5Ded8ERmyZ6Uj6cNq6Pz24hc
	 SSVGzfI+ODvl/iDjlDOa1b4q1K0xicVWz05XrBawu3mwE0yXj6ou25f7N3ILpAP6Dm
	 P1dGWjAGGJXayQ0NbhOx6KJKELZjE/o1FfJduSffxHkiwCDPacNfPB4nORfSoODhNu
	 p05pXuGzzwnuBHRXipFZXIfQ2nsJ208W4Jw+XfWueks3Es1fa2QlK9qHfGTLIEwhm4
	 iEafNu024SYNb9Lh7hz5l/4pa1BFxHUiyHicSjgD9rdIpsoB8/hWvwrcRhGXsXse17
	 ENhkkrCF6yh9A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/20] mm/damon/sysfs-schemes: implement quota effective_bytes file
Date: Mon, 19 Feb 2024 11:44:13 -0800
Message-Id: <20240219194431.159606-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219194431.159606-1-sj@kernel.org>
References: <20240219194431.159606-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface allows users to set two types of quotas, namely
time quota and size quota.  DAMOS converts time quota to a size quota
and use smaller one among the resulting two size quotas.  The resulting
effective size quota can be helpful for debugging and analysis, but not
exposed to the user.  The recently added feedback-driven quota
auto-tuning is making it even more mysterious.

Implement a DAMON sysfs interface read-only empty file, namely
'effective_bytes', under the quota goal DAMON sysfs directory.  It will
be extended to expose the effective quota to the end user.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index f6c7f43f06cc..dd46b2db5455 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1139,6 +1139,7 @@ struct damon_sysfs_quotas {
 	unsigned long ms;
 	unsigned long sz;
 	unsigned long reset_interval_ms;
+	unsigned long effective_sz;	/* Effective size quota in bytes */
 };
 
 static struct damon_sysfs_quotas *damon_sysfs_quotas_alloc(void)
@@ -1252,6 +1253,15 @@ static ssize_t reset_interval_ms_store(struct kobject *kobj,
 	return count;
 }
 
+static ssize_t effective_bytes_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+
+	return sysfs_emit(buf, "%lu\n", quotas->effective_sz);
+}
+
 static void damon_sysfs_quotas_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_quotas, kobj));
@@ -1266,10 +1276,14 @@ static struct kobj_attribute damon_sysfs_quotas_sz_attr =
 static struct kobj_attribute damon_sysfs_quotas_reset_interval_ms_attr =
 		__ATTR_RW_MODE(reset_interval_ms, 0600);
 
+static struct kobj_attribute damon_sysfs_quotas_effective_bytes_attr =
+		__ATTR_RO_MODE(effective_bytes, 0400);
+
 static struct attribute *damon_sysfs_quotas_attrs[] = {
 	&damon_sysfs_quotas_ms_attr.attr,
 	&damon_sysfs_quotas_sz_attr.attr,
 	&damon_sysfs_quotas_reset_interval_ms_attr.attr,
+	&damon_sysfs_quotas_effective_bytes_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_quotas);
-- 
2.39.2


