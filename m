Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8077C811C68
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442580AbjLMS1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjLMS1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:27:40 -0500
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBD710C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:27:46 -0800 (PST)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id AC6E210CFA728; Wed, 13 Dec 2023 10:27:33 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 2/4] mm/ksm: add sysfs knobs for advisor
Date:   Wed, 13 Dec 2023 10:27:27 -0800
Message-Id: <20231213182729.587081-3-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231213182729.587081-1-shr@devkernel.io>
References: <20231213182729.587081-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,HELO_MISC_IP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_NEUTRAL,
        TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds four new knobs for the KSM advisor to influence its behaviour.

The knobs are:
- advisor_mode:
    none:      no advisor (default)
    scan-time: scan time advisor
- advisor_max_cpu: 70 (default, cpu usage percent)
- advisor_min_pages_to_scan: 500 (default)
- advisor_max_pages_to_scan: 30000 (default)
- advisor_target_scan_time: 200 (default in seconds)

The new values will take effect on the next scan round.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/ksm.c | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 139 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 4f7b71a1f3112..f7387a6d02050 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -302,10 +302,10 @@ unsigned long ksm_zero_pages;
 static unsigned long ksm_pages_skipped;
=20
 /* Don't scan more than max pages per batch. */
-static unsigned long ksm_advisor_max_pages =3D 30000;
+static unsigned long ksm_advisor_max_pages_to_scan =3D 30000;
=20
 /* At least scan this many pages per batch. */
-static unsigned long ksm_advisor_min_pages =3D 500;
+static unsigned long ksm_advisor_min_pages_to_scan =3D 500;
=20
 /* Min CPU for scanning pages per scan */
 static unsigned int ksm_advisor_min_cpu =3D  10;
@@ -341,6 +341,16 @@ enum ksm_advisor_type {
 };
 static enum ksm_advisor_type ksm_advisor;
=20
+static void set_advisor_defaults(void)
+{
+	if (ksm_advisor =3D=3D KSM_ADVISOR_NONE) {
+		ksm_thread_pages_to_scan =3D DEFAULT_PAGES_TO_SCAN;
+	} else if (ksm_advisor =3D=3D KSM_ADVISOR_SCAN_TIME) {
+		advisor_ctx =3D (const struct advisor_ctx){ 0 };
+		ksm_thread_pages_to_scan =3D ksm_advisor_min_pages_to_scan;
+	}
+}
+
 static inline void advisor_start_scan(void)
 {
 	if (ksm_advisor =3D=3D KSM_ADVISOR_SCAN_TIME)
@@ -434,7 +444,7 @@ static void scan_time_advisor(void)
=20
 	pages =3D min(pages, per_page_cost * ksm_advisor_max_cpu);
 	pages =3D max(pages, per_page_cost * ksm_advisor_min_cpu);
-	pages =3D min(pages, ksm_advisor_max_pages);
+	pages =3D min(pages, ksm_advisor_max_pages_to_scan);
=20
 	/* Update advisor context */
 	advisor_ctx.change =3D change;
@@ -3722,6 +3732,127 @@ static ssize_t smart_scan_store(struct kobject *k=
obj,
 }
 KSM_ATTR(smart_scan);
=20
+static ssize_t advisor_mode_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	const char *output;
+
+	if (ksm_advisor =3D=3D KSM_ADVISOR_NONE)
+		output =3D "[none] scan-time";
+	else if (ksm_advisor =3D=3D KSM_ADVISOR_SCAN_TIME)
+		output =3D "none [scan-time]";
+
+	return sysfs_emit(buf, "%s\n", output);
+}
+
+static ssize_t advisor_mode_store(struct kobject *kobj,
+				  struct kobj_attribute *attr, const char *buf,
+				  size_t count)
+{
+	if (sysfs_streq("scan-time", buf))
+		ksm_advisor =3D KSM_ADVISOR_SCAN_TIME;
+	else if (sysfs_streq("none", buf))
+		ksm_advisor =3D KSM_ADVISOR_NONE;
+	else
+		return -EINVAL;
+
+	/* Set advisor default values */
+	set_advisor_defaults();
+
+	return count;
+}
+KSM_ATTR(advisor_mode);
+
+static ssize_t advisor_max_cpu_show(struct kobject *kobj,
+				    struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", ksm_advisor_max_cpu);
+}
+
+static ssize_t advisor_max_cpu_store(struct kobject *kobj,
+				     struct kobj_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int err;
+	unsigned long value;
+
+	err =3D kstrtoul(buf, 10, &value);
+	if (err)
+		return -EINVAL;
+
+	ksm_advisor_max_cpu =3D value;
+	return count;
+}
+KSM_ATTR(advisor_max_cpu);
+
+static ssize_t advisor_min_pages_to_scan_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", ksm_advisor_min_pages_to_scan);
+}
+
+static ssize_t advisor_min_pages_to_scan_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t count)
+{
+	int err;
+	unsigned long value;
+
+	err =3D kstrtoul(buf, 10, &value);
+	if (err)
+		return -EINVAL;
+
+	ksm_advisor_min_pages_to_scan =3D value;
+	return count;
+}
+KSM_ATTR(advisor_min_pages_to_scan);
+
+static ssize_t advisor_max_pages_to_scan_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", ksm_advisor_max_pages_to_scan);
+}
+
+static ssize_t advisor_max_pages_to_scan_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t count)
+{
+	int err;
+	unsigned long value;
+
+	err =3D kstrtoul(buf, 10, &value);
+	if (err)
+		return -EINVAL;
+
+	ksm_advisor_max_pages_to_scan =3D value;
+	return count;
+}
+KSM_ATTR(advisor_max_pages_to_scan);
+
+static ssize_t advisor_target_scan_time_show(struct kobject *kobj,
+					     struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", ksm_advisor_target_scan_time);
+}
+
+static ssize_t advisor_target_scan_time_store(struct kobject *kobj,
+					      struct kobj_attribute *attr,
+					      const char *buf, size_t count)
+{
+	int err;
+	unsigned long value;
+
+	err =3D kstrtoul(buf, 10, &value);
+	if (err)
+		return -EINVAL;
+	if (value < 1)
+		return -EINVAL;
+
+	ksm_advisor_target_scan_time =3D value;
+	return count;
+}
+KSM_ATTR(advisor_target_scan_time);
+
 static struct attribute *ksm_attrs[] =3D {
 	&sleep_millisecs_attr.attr,
 	&pages_to_scan_attr.attr,
@@ -3744,6 +3875,11 @@ static struct attribute *ksm_attrs[] =3D {
 	&use_zero_pages_attr.attr,
 	&general_profit_attr.attr,
 	&smart_scan_attr.attr,
+	&advisor_mode_attr.attr,
+	&advisor_max_cpu_attr.attr,
+	&advisor_min_pages_to_scan_attr.attr,
+	&advisor_max_pages_to_scan_attr.attr,
+	&advisor_target_scan_time_attr.attr,
 	NULL,
 };
=20
--=20
2.39.3

