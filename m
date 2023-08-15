Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD7B77CF24
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbjHOP2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbjHOP2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:28:24 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07AD9C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:28:23 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37F9DiUO003900;
        Tue, 15 Aug 2023 08:28:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=7g4+T3VrbKvrDF/q+3ydyFkkXGyTeBrP+Mv/4SWekxU=;
 b=Tqn6K5V8P16ak84ms58h15To+QY01SFFcMmZlL2pPQJZgBNl29PD2whXHEU2XLs0IbiE
 JkSeNRBAfmHZZVw0OcldnBCAurcaaAeyPpU+PWBCXw8uuHcDgLCvsyBtmfzNmqs6ACi+
 tEP7KRHb5tanGUEZ1mFtS7uZ0naO0Ey/+D9f2i8fZAHO/tP7S6X1hMEMtAFio7nj0vmT
 vTplYtdgusg76RfEitwQMkzLDyxOMOx5y8X7J0kyhO00353Dx5hck9kqEYmZmOsgXhQX
 NoBTwUp6/9APBoQW4I+lSYr1tm33c2r7Yv2/Vb3DSwgdeOTmbY2eYhV2gMis5eQiE56v YA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3se9kjajvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:28:13 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Aug
 2023 08:28:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 15 Aug 2023 08:28:11 -0700
Received: from localhost.localdomain (unknown [10.28.36.167])
        by maili.marvell.com (Postfix) with ESMTP id 1593B3F7060;
        Tue, 15 Aug 2023 08:28:07 -0700 (PDT)
From:   Amit Singh Tomar <amitsinght@marvell.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <james.morse@arm.com>, <gcherian@marvell.com>, <robh@kernel.org>,
        <peternewman@google.com>, Amit Singh Tomar <amitsinght@marvell.com>
Subject: [RFC 09/12] fs/resctrl: Extend schemata write for priority partition control
Date:   Tue, 15 Aug 2023 20:57:09 +0530
Message-ID: <20230815152712.1760046-10-amitsinght@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815152712.1760046-1-amitsinght@marvell.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: fFgMh3GFlFwCheWTmJoCQ-WhZaWvuvaL
X-Proofpoint-ORIG-GUID: fFgMh3GFlFwCheWTmJoCQ-WhZaWvuvaL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_16,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, Users can pass the configurations for CPBM, and MBA through
schemata file. For instance, CPBM can be passed using:

echo L3:0=ffff > schemata

This change allows, users to pass a new configuration for downstream
priority along with CPBM. For instance, dspri value of "0xa" can be
passed as:

echo L3:0=ffff,a > schemata

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
 fs/resctrl/ctrlmondata.c | 92 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index ffeb68270968..b444adee2002 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -30,6 +30,74 @@ typedef int (ctrlval_parser_t)(struct rdt_parse_data *data,
 			       struct resctrl_schema *s,
 			       struct rdt_domain *d);
 
+static bool dspri_validate(char *buf, unsigned long *data, struct rdt_resource *r)
+{
+
+	char *dup_buf, *dspri_token;
+	unsigned long dspri_val;
+	bool success = true;
+	int ret;
+
+	dup_buf = kstrdup(buf, GFP_KERNEL);
+	if (!dup_buf) {
+		rdt_last_cmd_printf("Failed to allocate buffer %s\n",
+					__func__);
+		success = false;
+		goto out;
+	}
+
+	strsep(&dup_buf, ",");
+	if (!dup_buf) {
+		rdt_last_cmd_printf("Unable to find priority value token %s\n",
+					__func__);
+		success = false;
+		goto out;
+	}
+
+	dspri_token = strsep(&dup_buf, ",");
+	ret = kstrtoul(dspri_token, 16, &dspri_val);
+	if (ret) {
+		rdt_last_cmd_printf("Non-hex character in the mask %s\n", buf);
+		success = false;
+		goto out;
+	}
+
+	if (dspri_val > r->dspri_default_ctrl) {
+		rdt_last_cmd_printf("dspri value %ld out of range [%d-%d]\n", dspri_val,
+					0, r->dspri_default_ctrl);
+		success = false;
+		goto out;
+	}
+
+	*data = dspri_val;
+
+out:
+	kfree(dup_buf);
+	return success;
+}
+
+static int parse_dspri(struct rdt_parse_data *data, struct resctrl_schema *s,
+			struct rdt_domain *d)
+{
+	struct resctrl_staged_config *cfg;
+	struct rdt_resource *r = s->res;
+	unsigned long pri_val;
+
+	cfg = &d->staged_config[s->conf_type];
+	if (cfg->have_new_ctrl) {
+		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
+		return -EINVAL;
+	}
+
+	if (!dspri_validate(data->buf, &pri_val, r))
+		return -EINVAL;
+
+	cfg->new_ctrl = pri_val;
+	cfg->have_new_ctrl = true;
+
+	return 0;
+}
+
 /*
  * Check whether MBA bandwidth percentage value is correct. The value is
  * checked against the minimum and max bandwidth values specified by the
@@ -293,6 +361,8 @@ static int rdtgroup_parse_resource(char *resname, char *tok,
 ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
 {
+	char *dup_buf = kstrdup(buf, GFP_KERNEL);
+	struct rdt_parse_data data;
 	struct resctrl_schema *s;
 	struct rdtgroup *rdtgrp;
 	struct rdt_domain *dom;
@@ -354,10 +424,32 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 		if (is_mba_sc(r))
 			continue;
 
+		if (r->priority_cap)
+			r->dspri_store = false;
+
 		if (!strcmp(resname, s->name)) {
 			ret = resctrl_arch_update_domains(r, rdtgrp->closid);
 			if (ret)
 				goto out;
+
+			if (r->priority_cap) {
+				r->dspri_store = true;
+				list_for_each_entry(dom, &r->domains, list) {
+					ctrlval_parser_t *parse_ctrlval = &parse_dspri;
+					char *dom_data = NULL;
+
+					dom_data = strsep(&dup_buf, ";");
+					dom_data = strim(dom_data);
+					data.buf = dom_data;
+					data.rdtgrp = rdtgrp;
+					if (parse_ctrlval(&data, s, dom))
+						return -EINVAL;
+				}
+
+				ret = resctrl_arch_update_domains(r, rdtgrp->closid);
+				if (ret)
+					goto out;
+			}
 		}
 	}
 
-- 
2.25.1

