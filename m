Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED03C77CF1F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbjHOP2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbjHOP2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:28:17 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51985E5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:28:16 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FEFiP7008910;
        Tue, 15 Aug 2023 08:28:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=7VqvIZ5Kw60KAdQqYaseDlv9dFqfiOw23a8I9hkx92I=;
 b=E2M9DngD/Rmv8OUgqjF5lomP4SrwtBnguQUDbCW1e50WJDG+ikp9IfwkAmpBga+TaB5r
 Mtrj2Ay/qd3zGMIBtjpXuBMsK1BzuGr/hIEEhJfYBxcrR2SDZvYmn3KK9kTE7q2bR1zD
 tpJcAp8BtAQIezIHOq9l1YjRXEZ68ptoXjKysEWSPxjwSyrChSzkZdis03UrBW2Wkg+h
 k2NmK00qDcEFsE0lzGpnTj6iRyg65twHKHEJAvSPSYfVnUXamBVFQrTZ61Md2QnbTKJo
 KH7kx8c28EB+IDw7zYD7ABHAqUiDdScvnV+5X45PC0vaPBQ2hsl5WOWT+KeMJp5urqR0 vA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sgaydr8a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:28:02 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Aug
 2023 08:28:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 15 Aug 2023 08:28:00 -0700
Received: from localhost.localdomain (unknown [10.28.36.167])
        by maili.marvell.com (Postfix) with ESMTP id 7EC783F703F;
        Tue, 15 Aug 2023 08:27:57 -0700 (PDT)
From:   Amit Singh Tomar <amitsinght@marvell.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <james.morse@arm.com>, <gcherian@marvell.com>, <robh@kernel.org>,
        <peternewman@google.com>, Amit Singh Tomar <amitsinght@marvell.com>
Subject: [RFC 06/12] fs/resctrl: Extend schemata read for priority partition control
Date:   Tue, 15 Aug 2023 20:57:06 +0530
Message-ID: <20230815152712.1760046-7-amitsinght@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815152712.1760046-1-amitsinght@marvell.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pYw_XwpvMpH1BeJ9R0vvSqmdqsVVQ3z2
X-Proofpoint-ORIG-GUID: pYw_XwpvMpH1BeJ9R0vvSqmdqsVVQ3z2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_16,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, "schemata" file under resource control group reveals
information about Cache portion bitmap and Memory Bandwidth allocation.
With the introduction of priority partition control "schemata" is updated
to adopt priority value.

Let's enable support for reading the priority values for "schemata" file.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
 drivers/platform/mpam/mpam_resctrl.c |  4 ++++
 fs/resctrl/ctrlmondata.c             | 15 ++++++++++++---
 include/linux/resctrl.h              |  4 ++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/mpam/mpam_resctrl.c b/drivers/platform/mpam/mpam_resctrl.c
index cc843f1b0fb7..b491a0f897fd 100644
--- a/drivers/platform/mpam/mpam_resctrl.c
+++ b/drivers/platform/mpam/mpam_resctrl.c
@@ -735,7 +735,11 @@ static int mpam_resctrl_resource_init(struct mpam_resctrl_res *res)
 
 		if (has_ppart) {
 			r->priority_cap = true;
+			if (class->props.dspri_wd > 0x10)
+				class->props.dspri_wd = 0x10;
+
 			r->dspri_default_ctrl = BIT_MASK(class->props.dspri_wd) - 1;
+			r->dspri_data_width = (class->props.dspri_wd + 3) / 4;
 		}
 
 		/*
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index b19ac2509e38..8c8a4d09d22c 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -379,7 +379,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 	struct rdt_resource *r = schema->res;
 	struct rdt_domain *dom;
 	bool sep = false;
-	u32 ctrl_val;
+	u32 ctrl_val, dspri_ctrl_val;
 
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
@@ -395,9 +395,18 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 			ctrl_val = resctrl_arch_get_config(r, dom, closid,
 							   schema->conf_type);
 
-		seq_printf(s, r->format_str, dom->id, max_data_width,
-			   ctrl_val);
+		if (r->priority_cap) {
+			r->dspri_show = true;
+			dspri_ctrl_val = resctrl_arch_get_config(r, dom, closid,
+								 CDP_NONE);
+			seq_printf(s, r->format_str, dom->id, max_data_width, ctrl_val,
+					r->dspri_data_width, dspri_ctrl_val);
+		} else
+			seq_printf(s, r->format_str, dom->id, max_data_width,
+				   ctrl_val);
+
 		sep = true;
+		r->dspri_show = false;
 	}
 	seq_puts(s, "\n");
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index d5b0661c0f70..d7100c330945 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -199,12 +199,14 @@ struct resctrl_membw {
  * @mon_capable:	Is monitor feature available on this machine
  * @priority_capable:   Is priority partitioning feature available on this machine
  * @dspri_store:
+ * @dspri_show:		flag to indicate downstream priority read
  * @num_rmid:		Number of RMIDs available
  * @cache_level:	Which cache level defines scope of this resource
  * @cache:		Cache allocation related data
  * @membw:		If the component has bandwidth controls, their properties.
  * @domains:		RCU list of all domains for this resource
  * @name:		Name to use in "schemata" file.
+ * @dspri_data_width    Character width of dspri value when displaying
  * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @dspri_default_ctrl: Specifies default downstream priority value.
@@ -219,6 +221,7 @@ struct rdt_resource {
 	bool			mon_capable;
 	bool                    priority_cap;
 	bool			dspri_store;
+	bool                    dspri_show;
 	int			num_rmid;
 	int			cache_level;
 	struct resctrl_cache	cache;
@@ -226,6 +229,7 @@ struct rdt_resource {
 	struct list_head	domains;
 	char			*name;
 	int			data_width;
+	int			dspri_data_width;
 	u32			default_ctrl;
 	u32			dspri_default_ctrl;
 	const char		*format_str;
-- 
2.25.1

