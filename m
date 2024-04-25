Return-Path: <linux-kernel+bounces-158861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 685D18B25E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982621C21A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B995314C5A3;
	Thu, 25 Apr 2024 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=florommel.de header.i=@florommel.de header.b="if+UMpp3"
Received: from read.uberspace.de (read.uberspace.de [185.26.156.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8341614C587
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061014; cv=none; b=YM3aLrHjrt3pThw3nlAYwEUFBF5KB1jkXJnR6umlmx6P+WolmcrybLg41g0bY2Ftrl4p8ChtbswBQSstyzCO6oi8M4GbJqtZ76RrI/MnG/SJZGDO7lJ5nIN132ca6zUgexPJDTGp0aVIHGizVvFxwdSWGHWBkDPhcqLB7CU67No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061014; c=relaxed/simple;
	bh=xNNR/wUpIxuzrAufWGl/DeCwf0nh9qPTmwwaiUo3cnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvvDW8VF4GGX3Sx2g7ULQgha/QRRLtDUo+mKYkRiIdZszC6x9T0tBm2tzVl/5rKylKZ7LltCdQBEeXNBfM8cZzjrXDrkOmawQvrKvo8Iz/footsRE2ZSedWk+Z073ut8rElqwqxHcnATG6O1e4LFMR8VuTW4//Vc27xw13wRjn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de; spf=pass smtp.mailfrom=florommel.de; dkim=fail (0-bit key) header.d=florommel.de header.i=@florommel.de header.b=if+UMpp3 reason="key not found in DNS"; arc=none smtp.client-ip=185.26.156.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=florommel.de
Received: (qmail 30710 invoked by uid 990); 25 Apr 2024 15:36:38 -0000
Authentication-Results: read.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by read.uberspace.de (Haraka/3.0.1) with ESMTPSA; Thu, 25 Apr 2024 17:36:37 +0200
From: Florian Rommel <mail@florommel.de>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Florian Rommel <mail@florommel.de>
Subject: [PATCH 3/4] scripts/gdb: Make get_thread_info accept pointers
Date: Thu, 25 Apr 2024 17:35:00 +0200
Message-ID: <20240425153501.749966-4-mail@florommel.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425153501.749966-1-mail@florommel.de>
References: <20240425153501.749966-1-mail@florommel.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.99722) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.59722
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=florommel.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=xNNR/wUpIxuzrAufWGl/DeCwf0nh9qPTmwwaiUo3cnU=;
	b=if+UMpp33eD8jvzlf3x4MCEysYOpDE0DI8Z+EW1cVgQr2KvtIWi2UvgA57uWFuqro/7Um6CIY2
	kMRu2eCLEjid0StnfLgZWxavb90h9YQPoLGFZ9dcuca87OPuHIgw6jpIQamARhebgbVWan8A9Zg2
	nqYR+cYkN3zcfkUKpOxTN1YyXSd2EpDr/dlNxv0Xk77FyiS0cAj9IqzB/vJBqYqzZmUeaKgoyqTG
	V5msunxNXu5KCg0CgOc/r0hcoafQn521Gw2ewSZ3PwmcskH+YDrrshvSXGtRzfwFSTMKlHjzoecv
	AZauQ+P8ovMwJohbLFgKzN/Chdx6aogFzUzoaPCmciDDJq4nRNCxR4Ig3KucMqgW66Jf/4Zr6Aip
	CANAA9RBBk5955H3N3cEcvYT8SErWkKuUXjVlFmycNenkOFgw6TtjHDMXiBSyGTAuGJ28yUn/c7K
	81IMFfYZxPEb4O1+Od3dJpaJyLul7Cd9FH4z5i1hjHI22kjiyo28M78MNXWVtk7GNv5TZF609ZHT
	QhkDYcBnseHMQGfTgacRZcLhwuRDxIFQml+rtF0xdVQdlaWYC48NqIMLRpjDouJ8/b5eMfrJUPMy
	w1SC2DBagPMCmH3XZI+LBImT/hlGvYzisD34OgiQl3RbOsrMP3Xub1MkErlU7Lm1/rRdgnSDuRHk
	Y=

get_thread_info ($lx_thread_info) only accepted a dereferenced task
parameter.  Passing a pointer to a task_struct (like $lx_per_cpu does with
KGDB) threw an exception.

With this patch, both (dereferenced values and pointers) are accepted.

Before (on x86, KGDB):
>>> p $lx_per_cpu(cpu_info)
Traceback (most recent call last):
  File "./scripts/gdb/linux/cpus.py", line 158, in invoke
    return per_cpu(var_ptr, cpu)
           ^^^^^^^^^^^^^^^^^^^^^
  File "./scripts/gdb/linux/cpus.py", line 42, in per_cpu
    cpu = get_current_cpu()
          ^^^^^^^^^^^^^^^^^
  File "./scripts/gdb/linux/cpus.py", line 33, in get_current_cpu
    return tasks.get_thread_info(tasks.get_task_by_pid(tid))['cpu']
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "./scripts/gdb/linux/tasks.py", line 88, in get_thread_info
    if task.type.fields()[0].type == thread_info_type.get_type():
       ~~~~~~~~~~~~~~~~~~^^^
IndexError: list index out of range

Signed-off-by: Florian Rommel <mail@florommel.de>
---
 scripts/gdb/linux/tasks.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/tasks.py b/scripts/gdb/linux/tasks.py
index 6793d6e86e77..62348397c1f5 100644
--- a/scripts/gdb/linux/tasks.py
+++ b/scripts/gdb/linux/tasks.py
@@ -85,7 +85,7 @@ thread_info_type = utils.CachedType("struct thread_info")
 
 def get_thread_info(task):
     thread_info_ptr_type = thread_info_type.get_type().pointer()
-    if task.type.fields()[0].type == thread_info_type.get_type():
+    if task_type.get_type().fields()[0].type == thread_info_type.get_type():
         return task['thread_info']
     thread_info = task['stack'].cast(thread_info_ptr_type)
     return thread_info.dereference()
-- 
2.44.0


