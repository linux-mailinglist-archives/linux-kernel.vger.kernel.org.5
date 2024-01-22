Return-Path: <linux-kernel+bounces-33050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899608363CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB3B0B2457A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3403CF42;
	Mon, 22 Jan 2024 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GwEOqQZa"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094913BB36
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927804; cv=none; b=VF9rTkBfjbhDzimfd/y/aYEW2htZeko5OpTwD0HxaHVbsqNC0h2fmCRz/PGr5ytPeADBy5eTzMcseFCOPP3ruWJEWP6OY+Ms24PGFC7cHcltVH38105X0q6S7ChOJi3mMNc6fDXBSzgA0Am3YZ2WI5DAHivCJV2saipGyTuGS5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927804; c=relaxed/simple;
	bh=55JIc7dCSA5xuR94QdhnCjCcwwwxXgDQu/NTWoMRKH4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PA+PF8Ta3dLLo0gBlnZSGhPxfjF0iOa9DgEAiSTrwxHZqOuCnQAmOYcRe+2JokXsUmRa+1z0aPd24J0iGLCRGl+XxlXKReY3GQBcdO01hZcu0l/BGawg5hxsXnF+52mLBVr6AIf8ZNb6Nt2oj2pqOvVclrSKIto86vX0fMZ4E8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GwEOqQZa; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40LNgiRR029110;
	Mon, 22 Jan 2024 04:49:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=vgg4W+elBBHQ1iNiHwrobNDs41uUbpD9UC5VyEFuwz4=; b=GwE
	OqQZaBrhj/bN5TtkxIORQlIiNffIz01cXRAeZMkKEW43hT2QaQmJW9Bc9AG0pNzM
	AGaJvHspAt5v6Hn+PjF1kEmoK6xiGGB8QC63Cm69zRMOyrdmMctvX5GIATDHMYbm
	vY9bwemZIYOWgsK2vtmwRs8nkETsgF11OW+hloDSpwoMr9hqIIj2r4zP8T4BgFkc
	mXGRu5qSQhz7HMMABXpLaR0to/5kt+TMypP26dBCWfKeQiqqps+c66OvBGPmJcKi
	eOo2XqdBU93lnrkVWTCwfYKn8lpoSeirRd1J+2oRNDefG1HopGgVrpAbPTEw8SVe
	9+94S/fb0XAkIqk007A==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vrejncu3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 04:49:47 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 22 Jan
 2024 04:49:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 22 Jan 2024 04:49:45 -0800
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 515263F7071;
	Mon, 22 Jan 2024 04:49:43 -0800 (PST)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        <george.cherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v3 2/2] perf/marvell : Odyssey LLC-TAD performance monitor support
Date: Mon, 22 Jan 2024 18:19:33 +0530
Message-ID: <20240122124933.1311925-3-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122124933.1311925-1-gthiagarajan@marvell.com>
References: <20240122124933.1311925-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mVRSxIR4noxfQKBBgceXIjtQCmZ5eV7E
X-Proofpoint-GUID: mVRSxIR4noxfQKBBgceXIjtQCmZ5eV7E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_02,2024-01-22_01,2023-05-22_02

Each TAD provides eight 64-bit counters for monitoring
cache behavior.The driver always configures the same counter for
all the TADs. The user would end up effectively reserving one of
eight counters in every TAD to look across all TADs.
The occurrences of events are aggregated and presented to the user
at the end of running the workload. The driver does not provide a
way for the user to partition TADs so that different TADs are used for
different applications.

The performance events reflect various internal or interface activities.
By combining the values from multiple performance counters, cache
performance can be measured in terms such as: cache miss rate, cache
allocations, interface retry rate, internal resource occupancy, etc.

Each supported counter's event and formatting information is exposed
to sysfs at /sys/devices/tad/. Use perf tool stat command to measure
the pmu events. For instance:

perf stat -e tad_hit_ltg,tad_hit_dtg <workload>

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 drivers/perf/marvell_cn10k_tad_pmu.c | 41 +++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index fec8e82edb95..b5786fcec0ec 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -214,6 +214,24 @@ static const struct attribute_group tad_pmu_events_attr_group = {
 	.attrs = tad_pmu_event_attrs,
 };
 
+static struct attribute *ody_tad_pmu_event_attrs[] = {
+	TAD_PMU_EVENT_ATTR(tad_req_msh_in_exlmn, 0x3),
+	TAD_PMU_EVENT_ATTR(tad_alloc_dtg, 0x1a),
+	TAD_PMU_EVENT_ATTR(tad_alloc_ltg, 0x1b),
+	TAD_PMU_EVENT_ATTR(tad_alloc_any, 0x1c),
+	TAD_PMU_EVENT_ATTR(tad_hit_dtg, 0x1d),
+	TAD_PMU_EVENT_ATTR(tad_hit_ltg, 0x1e),
+	TAD_PMU_EVENT_ATTR(tad_hit_any, 0x1f),
+	TAD_PMU_EVENT_ATTR(tad_tag_rd, 0x20),
+	TAD_PMU_EVENT_ATTR(tad_tot_cycle, 0xFF),
+	NULL
+};
+
+static const struct attribute_group ody_tad_pmu_events_attr_group = {
+	.name = "events",
+	.attrs = ody_tad_pmu_event_attrs,
+};
+
 PMU_FORMAT_ATTR(event, "config:0-7");
 
 static struct attribute *tad_pmu_format_attrs[] = {
@@ -252,11 +270,19 @@ static const struct attribute_group *tad_pmu_attr_groups[] = {
 	NULL
 };
 
+static const struct attribute_group *ody_tad_pmu_attr_groups[] = {
+	&ody_tad_pmu_events_attr_group,
+	&tad_pmu_format_attr_group,
+	&tad_pmu_cpumask_attr_group,
+	NULL
+};
+
 static int tad_pmu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct tad_region *regions;
 	struct tad_pmu *tad_pmu;
+	const char *compatible;
 	struct resource *res;
 	u32 tad_pmu_page_size;
 	u32 tad_page_size;
@@ -276,6 +302,12 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	ret = device_property_read_string(dev, "compatible", &compatible);
+	if (ret) {
+		dev_err(&pdev->dev, "compatible property not found\n");
+		return ret;
+	}
+
 	ret = device_property_read_u32(dev, "marvell,tad-page-size",
 				       &tad_page_size);
 	if (ret) {
@@ -319,7 +351,6 @@ static int tad_pmu_probe(struct platform_device *pdev)
 	tad_pmu->pmu = (struct pmu) {
 
 		.module		= THIS_MODULE,
-		.attr_groups	= tad_pmu_attr_groups,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
 				  PERF_PMU_CAP_NO_INTERRUPT,
 		.task_ctx_nr	= perf_invalid_context,
@@ -332,6 +363,13 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		.read		= tad_pmu_event_counter_read,
 	};
 
+	if ((strncmp("marvell,cn10k-ddr-pmu", compatible,
+		     strlen(compatible)) == 0)) {
+		tad_pmu->pmu.attr_groups = tad_pmu_attr_groups;
+	} else {
+		tad_pmu->pmu.attr_groups = ody_tad_pmu_attr_groups;
+	}
+
 	tad_pmu->cpu = raw_smp_processor_id();
 
 	/* Register pmu instance for cpu hotplug */
@@ -372,6 +410,7 @@ static const struct of_device_id tad_pmu_of_match[] = {
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id tad_pmu_acpi_match[] = {
 	{"MRVL000B", 0},
+	{"MRVL000D", 0},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, tad_pmu_acpi_match);
-- 
2.25.1


