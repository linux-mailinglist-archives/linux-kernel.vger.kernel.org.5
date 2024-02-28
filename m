Return-Path: <linux-kernel+bounces-85440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F2E86B5FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4177D283290
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4ED159588;
	Wed, 28 Feb 2024 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKQsQ62s"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4803FBA2;
	Wed, 28 Feb 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141391; cv=none; b=W0COTqoZ4EuUKBCkhtxyfPXqrOCjDjcarpJamfwS+fyw/M7hB1i97FPMNhdMv/yRMRUZv0G7KlBZR9vZbsc3Yg4g+FTVBzVMU0Rh8lyr1n83ae4KfesxPsjKL0g+esa8Ehm8KIkzKeEK0yTJ242Zi8lgXUVPO+uKLZ6MW/6O+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141391; c=relaxed/simple;
	bh=SeuTGsKnwySucOn6iEbScm1gy7cOEmGzvuZ8qUGTARk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSTLczKxIRf7K0S/5cLh73XVdBl3LEx0bbX3VrXBx3Pz9BSZb5p9cfNOqTIwLvgfLsRimbeMt8nuPUx5FszCCYYgkE/d9u27CHOCqtaWhXiz+T4c8qvBFmE/JgkNitYgj0jnSkTARgzMh9b7hM2I1WGeW5U90fG+3cisNqPd6aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKQsQ62s; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c19b7d9de7so2020659b6e.2;
        Wed, 28 Feb 2024 09:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709141389; x=1709746189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8hdoeVf9X1lwZIz9iqQKc7IzOYBkljTE/nXMpcz9SPU=;
        b=KKQsQ62sDSjxBA0+WQalnIq2x0j4NB19bJWWN1If9AZlsTo9SKapXZPqSLgErFS7Mo
         +tD46uAQPUAoc6y3uqQTB2Muxnz08BkSIcqXnt27cmfxgQWhXuB5I4HYoRgZrIYyhWWZ
         +YoXsagZomF04FfQnbvowq5x37tb5Y9aXQ1+PWiU/LhlpBxM/ZsKqhWWVglHzHGyTCRi
         ACTxgqpVWEwiB6q3hIQrLEWWmjf74q6raOd/BXWtKoyuw2VA2ZG+QxrLYBLYglRcJsy0
         qdfrV7F7DT/1t0yyzFvLq7ghmc8uDk9leAQOyxsOXnhGQxJoe0ed+SMIU2c11Qc/dMca
         Mfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709141389; x=1709746189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hdoeVf9X1lwZIz9iqQKc7IzOYBkljTE/nXMpcz9SPU=;
        b=g+0lWkKTh0v1dn7UIRpk6LQF9U9+EfDASBDEhM0GawbUL2svKMqJhuZkF8VGwE+SBn
         BiFYeViZBiXD6NpbTJPgIUsO7EaSBrquXuZ3MsA97R9+ckyBnRDEHgQC0CYPOmayg8w2
         hSPhs1CpjUraaKcGn8kVWYa15U9us+wBsIhMcgC8rPCNQbSIWqIa+lAWEJazR0LCk7AJ
         wbsueYR+QBX7TPo2pPZ6/gKFN4j2FPb7DFI4yAdPj/GMdE9LLOLDU6IKP5Jx4uasPS8W
         Fmf2rENZz1cPKOhgR12iwTmo6v/PAyDO/oASRqV+JA/Zw5L/2Duz7S97ADYqgyhDTeHi
         WMXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8fcekHGpGa7BaVTq2Scd0l0eY8zVS9+pIOkwJorP4IHq7XIsapP+Q4orrSy06a92nA1eNScQSIG7vMIBVUJ5RqvzwWyjn5yobn7wl4ehh+kpQPMwMSLwUS/raHabYiXUxGSiLWkvk
X-Gm-Message-State: AOJu0YxayHBQqnoRGwW9KC9Muxckix7Uo5VzoRBOh1h8JKVj/9c6RJZT
	k7/ZvRirGh5wCTIrC2flFrK6qJbzgKPMaiM5EKgDpu2tKOQmHOTi
X-Google-Smtp-Source: AGHT+IHtEgoMLT+50QSmpeH7io2fNwkoy8lWvsgbkzCG0MSdkUdY06fF90t9PcSBpHj+mdtbNxAHPg==
X-Received: by 2002:a05:6808:1391:b0:3c1:adc8:7e3b with SMTP id c17-20020a056808139100b003c1adc87e3bmr6056478oiw.41.1709141389380;
        Wed, 28 Feb 2024 09:29:49 -0800 (PST)
Received: from localhost ([2601:644:9381:2f20::2d05])
        by smtp.gmail.com with ESMTPSA id i21-20020aa787d5000000b006e55d5215dbsm1825588pfo.87.2024.02.28.09.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:29:49 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: netconsole: Add continuation line prefix to userdata messages
Date: Wed, 28 Feb 2024 09:29:46 -0800
Message-ID: <20240228172948.221910-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a space (' ') prefix to every userdata line to match docs for
dev-kmsg. To account for this extra character in each userdata entry,
reduce userdata entry names (directory name) from 54 characters to 53.

According to the dev-kmsg docs, a space is used for subsequent lines to
mark them as continuation lines.

> A line starting with ' ', is a continuation line, adding
> key/value pairs to the log message, which provide the machine
> readable context of the message, for reliable processing in
> userspace.

Testing for this patch::

 cd /sys/kernel/config/netconsole && mkdir cmdline0
 cd cmdline0
 mkdir userdata/test && echo "hello" > userdata/test/value
 mkdir userdata/test2 && echo "hello2" > userdata/test2/value
 echo "message" > /dev/kmsg

Outputs::

 6.8.0-rc5-virtme,12,493,231373579,-;message
  test=hello
  test2=hello2

And I confirmed all testing works as expected from the original patchset

Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in netconsole_target")
Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 Documentation/networking/netconsole.rst | 6 +++---
 drivers/net/netconsole.c                | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index b28c525e5d1e..c2dec12f6060 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -197,8 +197,8 @@ Messages will now include this additional user data::
 Sends::
 
  12,607,22085407756,-;This is a message
- foo=bar
- qux=baz
+  foo=bar
+  qux=baz
 
 Preview the userdata that will be appended with::
 
@@ -218,7 +218,7 @@ The `qux` key is omitted since it has no value::
 
  echo "This is a message" > /dev/kmsg
  12,607,22085407756,-;This is a message
- foo=bar
+  foo=bar
 
 Delete `userdata` entries with `rmdir`::
 
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 0de108a1c0c8..ffd3e19406b5 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -43,7 +43,7 @@ MODULE_DESCRIPTION("Console driver for network interfaces");
 MODULE_LICENSE("GPL");
 
 #define MAX_PARAM_LENGTH	256
-#define MAX_USERDATA_NAME_LENGTH	54
+#define MAX_USERDATA_NAME_LENGTH	53 /* 256 - 200 - 3 (for ' =\n' chars)*/
 #define MAX_USERDATA_VALUE_LENGTH	200
 #define MAX_USERDATA_ENTRY_LENGTH	256
 #define MAX_USERDATA_ITEMS		16
@@ -671,7 +671,7 @@ static void update_userdata(struct netconsole_target *nt)
 		 * checked to not exceed MAX items with child_count above
 		 */
 		complete_idx += scnprintf(&nt->userdata_complete[complete_idx],
-					  MAX_USERDATA_ENTRY_LENGTH, "%s=%s\n",
+					  MAX_USERDATA_ENTRY_LENGTH, " %s=%s\n",
 					  item->ci_name, udm_item->value);
 	}
 	nt->userdata_length = strnlen(nt->userdata_complete,
-- 
2.43.2


