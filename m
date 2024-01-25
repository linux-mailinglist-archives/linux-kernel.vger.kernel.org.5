Return-Path: <linux-kernel+bounces-39007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E0D83C98F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA74E1C238AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A85B14077E;
	Thu, 25 Jan 2024 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZStituk"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4EC13E217
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202408; cv=none; b=GiD+XrT2C3QXi9E4tRCKI8sqZOSQ7ULdxF/7IvJrDoAgucrFwoErvbdT3yIK3AyQa9tonGJw5fDU40xxSovLFz/6Cm+C558JgGUReJKjxgz4rgMkOkAHfG5jy57mV1XtM4fT3KiYdJ7rGvJIpUuP4nsomldlmNPvZNN2gFRL14M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202408; c=relaxed/simple;
	bh=2lD0mJRbexbDO4hMiYbWJiZjYr2zVinGlVqYH+MvpPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFtyRtJPlNPPovw5+CrFoqX0hzSOq2wD4xxwPOv5Tr8y05GZS+IGjuUB9TCvCIt6GPMMMyJqozAERPvSCaKnHRA5oZSvYf2mlszRSlxFsJxJ+XUgzsksaz5uafFC41ygITEWK9mdy62Z4Cp1JM5O7GH7UFKTI4aPKYe3uZksf2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZStituk; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce74ea4bf2so687936a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706202406; x=1706807206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqSNC1Qs7vJKYArzj5Yz+f/kmUUuHVOE7s2uOUNGw54=;
        b=eZStituk6+y+HPtIqosEeEY9RtgQJxuyaTirEFLj0UhpSBY5aY7FFnKq/nmwRTay0l
         jVqEPSkadFHJT5KuCBU+zXcViX48lC+gM23xVCk9NsRQ8nQV9tI0GBncgIYLQ80dLa2J
         onoiB4mBPwwbDHyKlfGerwbRfcd6ZtOjhONm0U1tpRcVU3D6IS3lGpLNX/SIvJu78UoH
         U3kBJSKoC59XEXDXv15rtIjNI4O8vQnHISy4XWaK1FZKp1y1vFoKfctKHAvMMe14WG1H
         p5NhPJXICiBPMre/TmJy7TatmScXMmM3MKLyB9Sw1bbXLrQ+ldMTSYl6x2u24ZcS1de7
         ulfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706202406; x=1706807206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eqSNC1Qs7vJKYArzj5Yz+f/kmUUuHVOE7s2uOUNGw54=;
        b=vJN6mAEvMbo7yyX9J1PO2aRYfNlAewTzpraEBujORRkx0zSn0MCeVDs1sl+AxsFKDh
         bBQacIZyAhsgad4+LyOynkZswTPouxEVi80Ka1SguQW9JR/vI7O06dGTLDcTEqX89q9d
         WYxbqrVAeBuQS7x8lCKm2/XIuV6OEtqBBLS4DgGooymswBmgk2pjiwttFBldI0jTsTgB
         yKfuRkE5AE/TGhyHkPN7d0xZPmTVD4cq8Nctit1/nBmjbVWHO1TXnEl/p8NmSnr0bObL
         4dX0QsgOPAMug1It9IbIahDJObFte7upYsWOsle6A7+l/jBG7Jvg4ZaKhWOPKt/N0PHG
         LBxw==
X-Gm-Message-State: AOJu0Yx6+H6XEwSGbxf5s1I2n2I+4aQhWqkSBEZ6uivBvOvFn1dqbma5
	E29MUG/tnFb74x5UVc3VgFGRx4vcxYI/xW1yQ5qdpw92RdvGsdjJYORlpxWm
X-Google-Smtp-Source: AGHT+IG7aE22RYKQ9NJhsrVpUg/5Ge6dVQwXUeEeYO508F1i6eo4xx5/zfzvuLoG+w0BNk64e293oA==
X-Received: by 2002:a05:6a20:d49b:b0:199:89a0:9f2b with SMTP id im27-20020a056a20d49b00b0019989a09f2bmr130107pzb.26.1706202406219;
        Thu, 25 Jan 2024 09:06:46 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id s5-20020a056a00194500b006da96503d9fsm16040070pfk.109.2024.01.25.09.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:06:45 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/10] tools/workqueue/wq_dump.py: Add node_nr/max_active dump
Date: Thu, 25 Jan 2024 07:06:03 -1000
Message-ID: <20240125170628.2017784-11-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125170628.2017784-1-tj@kernel.org>
References: <20240125170628.2017784-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print out per-node nr/max_active numbers to improve visibility into
node_nr_active operations.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/workqueue/wq_dump.py | 41 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/workqueue/wq_dump.py b/tools/workqueue/wq_dump.py
index 333b2fc00b82..bd381511bd9a 100644
--- a/tools/workqueue/wq_dump.py
+++ b/tools/workqueue/wq_dump.py
@@ -50,6 +50,7 @@ import drgn
 from drgn.helpers.linux.list import list_for_each_entry,list_empty
 from drgn.helpers.linux.percpu import per_cpu_ptr
 from drgn.helpers.linux.cpumask import for_each_cpu,for_each_possible_cpu
+from drgn.helpers.linux.nodemask import for_each_node
 from drgn.helpers.linux.idr import idr_for_each
 
 import argparse
@@ -107,7 +108,6 @@ WQ_AFFN_NUMA            = prog['WQ_AFFN_NUMA']
 WQ_AFFN_SYSTEM          = prog['WQ_AFFN_SYSTEM']
 
 WQ_NAME_LEN             = prog['WQ_NAME_LEN'].value_()
-
 cpumask_str_len         = len(cpumask_str(wq_unbound_cpumask))
 
 print('Affinity Scopes')
@@ -205,3 +205,42 @@ print(f'[{"workqueue":^{WQ_NAME_LEN-2}}\\ {"unbound_cpus":{ucpus_len}}    pid {"
     print(f' {wq.rescuer.task.pid.value_():6}', end='')
     print(f' {cpumask_str(wq.rescuer.task.cpus_ptr):{rcpus_len}}', end='')
     print('')
+
+print('')
+print('Unbound workqueue -> node_nr/max_active')
+print('=======================================')
+
+if 'node_to_cpumask_map' in prog:
+    __cpu_online_mask = prog['__cpu_online_mask']
+    node_to_cpumask_map = prog['node_to_cpumask_map']
+    nr_node_ids = prog['nr_node_ids'].value_()
+
+    print(f'online_cpus={cpumask_str(__cpu_online_mask.address_of_())}')
+    for node in for_each_node():
+        print(f'NODE[{node:02}]={cpumask_str(node_to_cpumask_map[node])}')
+    print('')
+
+    print(f'[{"workqueue":^{WQ_NAME_LEN-2}}\\ min max', end='')
+    first = True
+    for node in for_each_node():
+        if first:
+            print(f'  NODE {node}', end='')
+            first = False
+        else:
+            print(f' {node:7}', end='')
+    print(f' {"dfl":>7} ]')
+    print('')
+
+    for wq in list_for_each_entry('struct workqueue_struct', workqueues.address_of_(), 'list'):
+        if not (wq.flags & WQ_UNBOUND):
+            continue
+
+        print(f'{wq.name.string_().decode():{WQ_NAME_LEN}} ', end='')
+        print(f'{wq.min_active.value_():3} {wq.max_active.value_():3}', end='')
+        for node in for_each_node():
+            nna = wq.node_nr_active[node]
+            print(f' {nna.nr.counter.value_():3}/{nna.max.value_():3}', end='')
+        nna = wq.node_nr_active[nr_node_ids]
+        print(f' {nna.nr.counter.value_():3}/{nna.max.value_():3}')
+else:
+    printf(f'node_to_cpumask_map not present, is NUMA enabled?')
-- 
2.43.0


