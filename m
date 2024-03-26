Return-Path: <linux-kernel+bounces-119705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A66088CC42
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1EE324CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76E713C813;
	Tue, 26 Mar 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Swt4ChCf"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A6482EE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478821; cv=none; b=GTR19wS7QPJ7nnEsF1runpua12UKw0VYUDX4NQzBszgCqqJOjOtnOGcuQ6KjEG95aYzE6aFSGwltmqN6wW8dm/8dKq9c+FVrHE9bWTJSY0AJg7JMrj1/zXm3aYkpb9Q5g4D2mhJ/41lOo8FSQjO1BiLp78uAtnbi3YE8LK2NFk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478821; c=relaxed/simple;
	bh=SVQDdIo+IQ0WeadhhI20wUD7VZOzgjNjnHROGjPd/bI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OYeYTXz8kfM+Eb4jsX5h+Ixbo/ofe7BxjDY4Nrscw60e9oeBssdGharZF4pVEw1jSaFrvtrzPpqmY8pI4wArv5GY9LCR21oRGKfn/NaFLm581BKxO5cqwHwV0f2VfcsFSkB+q9yQhKlFW9v3gvA/fMKe1KfD0/MRGDTPG8AxD7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Swt4ChCf; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d6ee81bc87so8755741fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711478817; x=1712083617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+BNSxC+7kws2aQYyfMaC/PZOxk6eYvHPt4+RUgE5vU=;
        b=Swt4ChCf/3jZb4dFixOWc1jV1n5bVEcl+Z91We8hWwowput8u1rMp/YSn1B/h0/rgC
         bGsqGwFxMbSmIoBoHuFNKhK1NgOBin1ro9PWPLLybRC7Q4I8DLXC3Jpon+eqeVFqU9zG
         RduJ15AT18z7WfuUqa+QwHYJ+D7UCH0Z5IxU4LdBonTLWpHPTh675VdH8JW/2Hpbp7UR
         9rsshkM7xzk/5U3mufjpuRwFWlH/wMabw20iW525Ry3lEKJAQ37EmpEsTfyjREmhHtWH
         aLfgFl0YQl09g3XnT9lLr6ANTlbT/fK4TaqDBwsR9N2QYm3w31j4tvN0gRC47VJsgwYB
         dsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711478817; x=1712083617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+BNSxC+7kws2aQYyfMaC/PZOxk6eYvHPt4+RUgE5vU=;
        b=N6HNnZV28GZOF5PCBSxJNNmt1Q1fIqyKXElIjQD0xh6JlbhwZuffK3g0nc9FgbRKmO
         c02LHvnOluEuozIxFWqRsJNnw3vdGQnxdPOvTQe565IHDsnYIfbghQoFXir5VO2KHWw8
         dfmQKbMrkadvgj5vv0KSac35dFXloA6S7cz3uLBd3PRi5Fpak9tz4c6V3Lo7hQTi3MRi
         4V5xF0lBMXY9pdBDqZDVlUlaTOXNmoNFHYc+xsXrQDMC8384JMZ22qYiMUr+po4RP3EH
         exdHur+Efn4YnoOmaFVdZ8BVun+r2ZTBO6KdS3bCyCYH+RwBXHWB9sYldDXafJKgkgJG
         EMjQ==
X-Gm-Message-State: AOJu0YxY57R0+y7DQAKgVLY9JGcGWBIKCGYAHXrT9hbHv6OviDueexOe
	pfUMLf/BtLDrJ6MWqHkxbPTYRbVgktPDFcu0HKl1Xt5W5I8Byisr/+/0E5eT
X-Google-Smtp-Source: AGHT+IEPwWE/NBhqg0BPrapibCjhQfoyOUUhqKZZnlaMOf/9xEDo46Cjv/+WyDv/o8gXvStyRfelXQ==
X-Received: by 2002:a05:651c:2106:b0:2d4:92ea:21de with SMTP id a6-20020a05651c210600b002d492ea21demr422330ljq.0.1711478817291;
        Tue, 26 Mar 2024 11:46:57 -0700 (PDT)
Received: from localhost.localdomain (109-252-14-191.nat.spd-mgts.ru. [109.252.14.191])
        by smtp.gmail.com with ESMTPSA id u4-20020a2e91c4000000b002d6ef7199a0sm173447ljg.113.2024.03.26.11.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 11:46:56 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: linux-kernel@vger.kernel.org
Cc: maximmosk4@gmail.com,
	Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
Subject: [PATCH 4/8] module: replace seq_puts by seq_putc
Date: Tue, 26 Mar 2024 21:46:54 +0300
Message-Id: <20240326184654.8700-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326184514.8478-1-Maxim.Moskalets@kaspersky.com>
References: <20240326184514.8478-1-Maxim.Moskalets@kaspersky.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using seq_putc for single characters is faster and more appropriate
than seq_puts, since only one character is passed and there is no need
to use a more powerful and less fast function.

Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
---
 kernel/module/procfs.c   | 4 ++--
 kernel/module/tracking.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/module/procfs.c b/kernel/module/procfs.c
index 0a4841e88adb..dc91d3dba8f3 100644
--- a/kernel/module/procfs.c
+++ b/kernel/module/procfs.c
@@ -35,7 +35,7 @@ static inline void print_unload_info(struct seq_file *m, struct module *mod)
 	}
 
 	if (!printed_something)
-		seq_puts(m, "-");
+		seq_putc(m, '-');
 }
 #else /* !CONFIG_MODULE_UNLOAD */
 static inline void print_unload_info(struct seq_file *m, struct module *mod)
@@ -99,7 +99,7 @@ static int m_show(struct seq_file *m, void *p)
 	if (mod->taints)
 		seq_printf(m, " %s", module_flags(mod, buf, true));
 
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	return 0;
 }
 
diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index 16742d1c630c..dcc4dc4c7501 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -95,7 +95,7 @@ static int unloaded_tainted_modules_seq_show(struct seq_file *m, void *p)
 	buf[l++] = '\0';
 
 	seq_printf(m, "%s (%s) %llu", mod_taint->name, buf, mod_taint->count);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	return 0;
 }
-- 
2.39.2


