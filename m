Return-Path: <linux-kernel+bounces-165110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9C18B8831
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863EF1C2248C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCAF537F5;
	Wed,  1 May 2024 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQhZfsjz"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3D5336F
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714556608; cv=none; b=XvAyiYoXag++H96C/zH6Ye7cz8FQjTdn3sjjfiDA/URRi+XmDQrwyyMmeeVzDgrTknXJ8oGZqDY0kYEbwqdgkRx+e4eanmaYZSIz0GgtYCj4hCIkkddFpJ5l/RUKHysEe4CIlj6bsHcLUKP35jn//bpVUeTZBnJgpvEqkfU/m+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714556608; c=relaxed/simple;
	bh=QwiqexznvP+jb1oxOV2h+M948dOJkVQAhRjptoEqfYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rZjmHgqzKGy9323VzF87ETtNS0hUWrhAeGJT9ucaHnjCbXZMe56FxCOR1W7grUdHZVdSMTinjg/kLIyS9bEkfxQROToG8AQCeK094Vr0AA2zyHWqca7U5+EEff9jlJndNkCcJ5+HrFJXSOH8fm6IB2ErDxboWNacsrSxaVB/r6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQhZfsjz; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5872b74c44so747085266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 02:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714556604; x=1715161404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4+XAZ0hMBW5SZuGw8WshluOeMqW9oGtTouDmEr61Ms=;
        b=bQhZfsjzopcge0uFNFHgGZ4WHYd8536wRE5C/qv25VOQGBLd3koXM4ZtqxhdQPm0XE
         +jCrO4CqkKs3RNENPRVwBc79eGW+t/b1CheQEMIDdhLdDjeurzJ4NByBpctxYa+DRoRy
         moQxrSDXHLgqSyuNG9MFQM4cyeijgFaaVqFwLZwQQ2NgwhYbwWPA3FHPsjz7lycRCbIi
         6ah8uIvAShhNjq67dwAr70YjVpBsaH6Ppxq2DCCLhpYhwKguj/H+l9ueGnMa7ISXr4rB
         8K40gGbMX+psEDg9VYVsNmuwyV8K+jrIT4snGSs99IiF/xkDc5i62jZapVP4Sg2pcsoE
         /rZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714556604; x=1715161404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4+XAZ0hMBW5SZuGw8WshluOeMqW9oGtTouDmEr61Ms=;
        b=C6mINeS//oQG/aA01bp7a75jqjLdvY1rKg9UoCVYtYBaen7M6CUcLhmHFfPql3SO7x
         vfqflJ9dFyRscEjZ0zXrJElhTseJ2o+n9ymlGojU3fkN6i6TDxBfgvfoOh0/pQh5LIjC
         1V1zR97VEWymnzOxKgrrcrGduZbQpJOFyMSTOvXi9hnlBIGJCjES7OlaJzN4Em3/mBIK
         lKTWE9UmPdSvOPzfSmwTFkZAkj3b18krxIaMxnGjGanrZBiYM38THInjTt8dlx5hNeje
         lhvMyrXg1aHGyWyrIczokM24IEFCb3rXaoRFR/vjI92K9pmCc7dKSxiLVdynZ3l9Bl4n
         iCKA==
X-Forwarded-Encrypted: i=1; AJvYcCV9gcWldcgaxJnOYby7w0DebNcYVq/T1h7bOjJmDa6EahbSgchr23QN+C5GZOOXV8VbXSaQppIPPz/R89Fq+bzV7AG34Y872b65qUNA
X-Gm-Message-State: AOJu0YxVX0vTQWh4R5I6FcJLpv9iBNk95R+bXBRAiE7ger+bxkqi/kbR
	YekS2m9SBA3G90mf0HPddlUDR/DcJbPBpq/G33WB9W/cJ2Li/RyZ
X-Google-Smtp-Source: AGHT+IFofDjGrgf8j8VXC4OWsdZAojNr8HZKMdmV55DiyTOYSdijghgTOzp8Q6dLWbxK2HlQiT/ZpA==
X-Received: by 2002:a17:906:abc2:b0:a58:ff19:1bd7 with SMTP id kq2-20020a170906abc200b00a58ff191bd7mr1453943ejb.24.1714556603902;
        Wed, 01 May 2024 02:43:23 -0700 (PDT)
Received: from sacco-Inspiron-5559.station (net-37-182-167-227.cust.vodafonedsl.it. [37.182.167.227])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090666c900b00a52274ee0a7sm16328635ejp.171.2024.05.01.02.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 02:43:23 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: sudeep.holla@arm.com
Cc: gregkh@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	skhan@linuxfoundation.org,
	vincenzo.mezzela@gmail.com
Subject: [PATCH 2/2 v3] drivers: use __free attribute instead of of_node_put()
Date: Wed,  1 May 2024 11:43:13 +0200
Message-Id: <20240501094313.407820-3-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
References: <20240424125401.oxvt5n64d7a57ge3@bogus>
 <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the __free attribute for scope-based resource management.
Resources allocated with __free are automatically released at the end of
the scope. This enhancement aims to mitigate memory management issues
associated with forgetting to release resources by utilizing __free
instead of of_node_put().

The declaration of the device_node used within the do-while loops is
moved directly within the loop so that the resource is automatically
freed at the end of each iteration.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
 drivers/base/arch_topology.c | 51 +++++++++++++++---------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index ea8836f0bb4b..eef26e304018 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -8,6 +8,7 @@
 
 #include <linux/acpi.h>
 #include <linux/cacheinfo.h>
+#include <linux/cleanup.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
@@ -513,10 +514,10 @@ core_initcall(free_raw_capacity);
  */
 static int __init get_cpu_for_node(struct device_node *node)
 {
-	struct device_node *cpu_node;
 	int cpu;
 
-	cpu_node = of_parse_phandle(node, "cpu", 0);
+	struct device_node *cpu_node __free(device_node) =
+		of_parse_phandle(node, "cpu", 0);
 	if (!cpu_node)
 		return -1;
 
@@ -527,7 +528,6 @@ static int __init get_cpu_for_node(struct device_node *node)
 		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
 			cpu_node, cpumask_pr_args(cpu_possible_mask));
 
-	of_node_put(cpu_node);
 	return cpu;
 }
 
@@ -538,11 +538,11 @@ static int __init parse_core(struct device_node *core, int package_id,
 	bool leaf = true;
 	int i = 0;
 	int cpu;
-	struct device_node *t;
 
 	do {
 		snprintf(name, sizeof(name), "thread%d", i);
-		t = of_get_child_by_name(core, name);
+		struct device_node *t __free(device_node) =
+			of_get_child_by_name(core, name);
 		if (!t)
 			break;
 
@@ -555,10 +555,8 @@ static int __init parse_core(struct device_node *core, int package_id,
 			cpu_topology[cpu].thread_id = i;
 		} else if (cpu != -ENODEV) {
 			pr_err("%pOF: Can't get CPU for thread\n", t);
-			of_node_put(t);
 			return -EINVAL;
 		}
-		of_node_put(t);
 		i++;
 	} while (1);
 
@@ -587,7 +585,6 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 	char name[20];
 	bool leaf = true;
 	bool has_cores = false;
-	struct device_node *c;
 	int core_id = 0;
 	int i, ret;
 
@@ -599,7 +596,8 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 	i = 0;
 	do {
 		snprintf(name, sizeof(name), "cluster%d", i);
-		c = of_get_child_by_name(cluster, name);
+		struct device_node *c __free(device_node) =
+			of_get_child_by_name(cluster, name);
 		if (!c)
 			break;
 
@@ -607,7 +605,6 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 		ret = parse_cluster(c, package_id, i, depth + 1);
 		if (depth > 0)
 			pr_warn("Topology for clusters of clusters not yet supported\n");
-		of_node_put(c);
 		if (ret != 0)
 			return ret;
 		i++;
@@ -617,7 +614,8 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 	i = 0;
 	do {
 		snprintf(name, sizeof(name), "core%d", i);
-		c = of_get_child_by_name(cluster, name);
+		struct device_node *c __free(device_node) =
+			of_get_child_by_name(cluster, name);
 		if (!c)
 			break;
 
@@ -625,21 +623,19 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 
 		if (depth == 0) {
 			pr_err("%pOF: cpu-map children should be clusters\n", c);
-			of_node_put(c);
 			return -EINVAL;
 		}
 
 		if (leaf) {
 			ret = parse_core(c, package_id, cluster_id, core_id++);
+			if (ret != 0)
+				return ret;
 		} else {
 			pr_err("%pOF: Non-leaf cluster with core %s\n",
 				cluster, name);
-			ret = -EINVAL;
+			return -EINVAL;
 		}
 
-		of_node_put(c);
-		if (ret != 0)
-			return ret;
 		i++;
 	} while (1);
 
@@ -652,19 +648,18 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 static int __init parse_socket(struct device_node *socket)
 {
 	char name[20];
-	struct device_node *c;
 	bool has_socket = false;
 	int package_id = 0, ret;
 
 	do {
 		snprintf(name, sizeof(name), "socket%d", package_id);
-		c = of_get_child_by_name(socket, name);
+		struct device_node *c __free(device_node) =
+			of_get_child_by_name(socket, name);
 		if (!c)
 			break;
 
 		has_socket = true;
 		ret = parse_cluster(c, package_id, -1, 0);
-		of_node_put(c);
 		if (ret != 0)
 			return ret;
 
@@ -679,11 +674,11 @@ static int __init parse_socket(struct device_node *socket)
 
 static int __init parse_dt_topology(void)
 {
-	struct device_node *cn, *map;
 	int ret = 0;
 	int cpu;
 
-	cn = of_find_node_by_path("/cpus");
+	struct device_node *cn __free(device_node) =
+		of_find_node_by_path("/cpus");
 	if (!cn) {
 		pr_err("No CPU information found in DT\n");
 		return 0;
@@ -693,13 +688,14 @@ static int __init parse_dt_topology(void)
 	 * When topology is provided cpu-map is essentially a root
 	 * cluster with restricted subnodes.
 	 */
-	map = of_get_child_by_name(cn, "cpu-map");
+	struct device_node *map __free(device_node) =
+		of_get_child_by_name(cn, "cpu-map");
 	if (!map)
-		goto out;
+		return ret;
 
 	ret = parse_socket(map);
 	if (ret != 0)
-		goto out_map;
+		return ret;
 
 	topology_normalize_cpu_scale();
 
@@ -709,14 +705,9 @@ static int __init parse_dt_topology(void)
 	 */
 	for_each_possible_cpu(cpu)
 		if (cpu_topology[cpu].package_id < 0) {
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
 
-out_map:
-	of_node_put(map);
-out:
-	of_node_put(cn);
 	return ret;
 }
 #endif
-- 
2.34.1


