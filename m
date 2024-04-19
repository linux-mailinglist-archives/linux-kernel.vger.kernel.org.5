Return-Path: <linux-kernel+bounces-151461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457CE8AAF39
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC15283956
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE93F129A9A;
	Fri, 19 Apr 2024 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+udUF+3"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE3486651
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713532861; cv=none; b=otrIGW/CkdGp9Tr+SI/Z6GwCyWuGWVO2aINFPYeF0cZkROguIYpe8JtYml9Q0+ZYsUCUA0KbOCr+y7nPPr/n925uLYKCQ6YC3ABEhHf3/NhnM5npMHMjetZiMcuT5I4at3dUIsmr8EVQxPFYXaC12zLdeHP/eQuTW2Pz6TfIloE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713532861; c=relaxed/simple;
	bh=udJLDl6GZInmHgm2z6TSjUsZN2dqLcxLxX58wpxCmrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UtPg3GkvJUFKrEXOqDNz8qMzY9VambbddexTL6S2yftq6IM4VfnL2dy+FLW1N+kTWEKMMg9UQlz8P4lwPSGAEPwBUFd9Vuwbvqv4XeYof0/Rys18bnYiaJ0ekASeoEb+XCdpNs48/qOUfeCScmv9yXiPjUP7opahBPyzPl8NreQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+udUF+3; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5557e3ebcaso337549866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713532856; x=1714137656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2T0/53+1tFUpSjtjKoF0i8GpNdHviseK2ocxRN4H8M=;
        b=V+udUF+3mqJSFnd477mrpfTeq38a2o+kgLv/zc6GXP5i09RANAeavbjLlmsDOHPenr
         uSFx8GwTz4dXpV3L0YRh11xct5VBcImTWaYUXLBVpg7xo2C4O72UN2wGz9tisjLnrsA1
         0LqqVKGPyNJ7VF39NgP1dyaui4iL0jz8T2gQllPSiBJCWvX9yx+sjTXh5PAWkOYWc6oG
         tXAZIqI/xbKeh53DW/81qDorHe2/Tio/G6DDJrV4LH7bHM5mdqKe8ujxlX07bdts5zQg
         9Mo+Lo8VRPRwLXZKn2Xz9SMt3xtRmLQR2RFEfRrJVBKCy1nQnplRA+LmJ8THkSIkbnLo
         Oarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713532856; x=1714137656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q2T0/53+1tFUpSjtjKoF0i8GpNdHviseK2ocxRN4H8M=;
        b=Jl9UoGmmcLKQzFSx8LhYagJwtjK4nuaKJX9lGJUgegZpcT7HcvVXlsnavQDPrIHThp
         +daOqqZ/Gyhv6+DicAqgDKHy7c5KC9jUVYNIdyPFCXm9RtwUBWQE8TO9/PXTEv8lbIO6
         BmBb7eIAUtYLlR2JEKwIKYH8dBnkBjgJXgi/nuKn8kwTJh+NeR7JfInIPqi0Xb+6/BAf
         5XxfP7RYTE7N53hem6bY1X/LAhw9typAnOuuZJEhc3brRgQEUcqh9sTLaV2Z24g3R6zF
         fJdWRmM6Tz+eSd9i1Vb8nMdHUrLjo/HHCekwmxQdiMsrUdlpnE/TkixOnhkApyMxyeH5
         W3bg==
X-Gm-Message-State: AOJu0Ywa3BmnWFj2NB8hu8w0DLCUNpVFT0vt1SYTWxvQ7RECfveIx5bQ
	qT1mU+8temk/FmUqhEUl13BXrbuWX/O2NWKtlFsKBROq+Zvbqf7w
X-Google-Smtp-Source: AGHT+IFnj0+2wa3SNfR1+MPzdAagVEJwGINCZM4LE+lylbL7IGU4KQvJr5CKpzm0kShiZmSStFkBRA==
X-Received: by 2002:a17:906:4152:b0:a52:9e:45c3 with SMTP id l18-20020a170906415200b00a52009e45c3mr4110765ejk.35.1713532856260;
        Fri, 19 Apr 2024 06:20:56 -0700 (PDT)
Received: from sacco-Inspiron-5559.station (net-37-182-167-227.cust.vodafonedsl.it. [37.182.167.227])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709063e4a00b00a555e515182sm2187990eji.58.2024.04.19.06.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 06:20:55 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: sudeep.holla@arm.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org,
	Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [PATCH] drivers: use __free attribute instead of of_node_put()
Date: Fri, 19 Apr 2024 15:19:56 +0200
Message-Id: <20240419131956.665769-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
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
 drivers/base/arch_topology.c | 41 ++++++++++++++----------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 024b78a0cfc1..58eeb8183747 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -513,10 +513,10 @@ core_initcall(free_raw_capacity);
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
 
@@ -527,7 +527,6 @@ static int __init get_cpu_for_node(struct device_node *node)
 		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
 			cpu_node, cpumask_pr_args(cpu_possible_mask));
 
-	of_node_put(cpu_node);
 	return cpu;
 }
 
@@ -538,11 +537,11 @@ static int __init parse_core(struct device_node *core, int package_id,
 	bool leaf = true;
 	int i = 0;
 	int cpu;
-	struct device_node *t;
 
 	do {
 		snprintf(name, sizeof(name), "thread%d", i);
-		t = of_get_child_by_name(core, name);
+		struct device_node *t __free(device_node) =
+			of_get_child_by_name(core, name);
 		if (t) {
 			leaf = false;
 			cpu = get_cpu_for_node(t);
@@ -553,10 +552,8 @@ static int __init parse_core(struct device_node *core, int package_id,
 				cpu_topology[cpu].thread_id = i;
 			} else if (cpu != -ENODEV) {
 				pr_err("%pOF: Can't get CPU for thread\n", t);
-				of_node_put(t);
 				return -EINVAL;
 			}
-			of_node_put(t);
 		}
 		i++;
 	} while (t);
@@ -586,7 +583,6 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 	char name[20];
 	bool leaf = true;
 	bool has_cores = false;
-	struct device_node *c;
 	int core_id = 0;
 	int i, ret;
 
@@ -598,13 +594,13 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 	i = 0;
 	do {
 		snprintf(name, sizeof(name), "cluster%d", i);
-		c = of_get_child_by_name(cluster, name);
+		struct device_node *c __free(device_node) =
+			of_get_child_by_name(cluster, name);
 		if (c) {
 			leaf = false;
 			ret = parse_cluster(c, package_id, i, depth + 1);
 			if (depth > 0)
 				pr_warn("Topology for clusters of clusters not yet supported\n");
-			of_node_put(c);
 			if (ret != 0)
 				return ret;
 		}
@@ -615,14 +611,14 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 	i = 0;
 	do {
 		snprintf(name, sizeof(name), "core%d", i);
-		c = of_get_child_by_name(cluster, name);
+		struct device_node *c __free(device_node) =
+			of_get_child_by_name(cluster, name);
 		if (c) {
 			has_cores = true;
 
 			if (depth == 0) {
 				pr_err("%pOF: cpu-map children should be clusters\n",
 				       c);
-				of_node_put(c);
 				return -EINVAL;
 			}
 
@@ -635,7 +631,6 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 				ret = -EINVAL;
 			}
 
-			of_node_put(c);
 			if (ret != 0)
 				return ret;
 		}
@@ -651,17 +646,16 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
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
 		if (c) {
 			has_socket = true;
 			ret = parse_cluster(c, package_id, -1, 0);
-			of_node_put(c);
 			if (ret != 0)
 				return ret;
 		}
@@ -676,11 +670,11 @@ static int __init parse_socket(struct device_node *socket)
 
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
@@ -690,13 +684,14 @@ static int __init parse_dt_topology(void)
 	 * When topology is provided cpu-map is essentially a root
 	 * cluster with restricted subnodes.
 	 */
-	map = of_get_child_by_name(cn, "cpu-map");
+	struct device_node *map __free(devide_node) =
+		of_get_child_by_name(cn, "cpu-map");
 	if (!map)
-		goto out;
+		return ret;
 
 	ret = parse_socket(map);
 	if (ret != 0)
-		goto out_map;
+		return ret;
 
 	topology_normalize_cpu_scale();
 
@@ -710,10 +705,6 @@ static int __init parse_dt_topology(void)
 			break;
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


