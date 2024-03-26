Return-Path: <linux-kernel+bounces-119707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E318488CC47
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B181C65B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BBE13CC72;
	Tue, 26 Mar 2024 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQMK5M0j"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931EE13CC75
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478829; cv=none; b=k+buwH0/tm1IcRVRDALqQ2rsJ90V8O/wn9eJXRcP2d9b4bxZoYdixXnzsI8SfRwctxjHS+CXKrqeRFNevTsth+VMV9MsvQ+eSEQBveAosVy3WwPb0oGZLh+edZoHo7nWeLoG1zaZhq3AzNmlhftA39i42Dly9Dkjw2CzcHNayYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478829; c=relaxed/simple;
	bh=T8dQDg721TMeOxVX+4bCSMO1oVhUAaIGWnDcDr+ZAG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qpcMt9cOV22k9iumgHC2Xi06YIfYxLn69j9F37SvczYY3QbVQZuJIupHrJKG92g0wCz9P2hJcKJRimaiiWyAP+GCqNEZDs5p5qX3cfo2w3F3XoLRRZq7huq88cnKBS0o2KZ9F66FKJBWHEXwrdlLqbtJmGvlpL2JX1qW7A5yKxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQMK5M0j; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-515a86daf09so4000933e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711478825; x=1712083625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZ+eJwDoGKUGIZxflpcMnwv/9sVegxaxVgL5v55tN+g=;
        b=cQMK5M0jGSl10K9i4YA4DSFXTuDUQr/fe7kiQo5YOBLa1NCCHHSEJyqsc//wv8OoHp
         t1ZQTuXWkM4rJJxh5Hay/xmuXei+W4qZRQamI+KBjJvmmdAm9T1DGa/GPfxpwVu/2Fl/
         8bT9A0jx0gFrikClVYmwM2CnMlLOzu9W22cH5V9eyFCCRph+X+1BRxAjOrYIFIPnQbpK
         880U9fZV78u8JwjUqR3BDo2oRlhAeknyRdQNKlfCW8qKqvYACuF7rlZSXRLKmQSfS+Vl
         gZpdq1Uts1mT1Nj+GTXYgEtAYTS0i4rgHBHA3dc3qadpc9FQ5IknSvnnwXgH9cpuI7Vn
         ENzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711478825; x=1712083625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZ+eJwDoGKUGIZxflpcMnwv/9sVegxaxVgL5v55tN+g=;
        b=smAvMiCehTlOZ/lwG/SnZJnjeR2gPQtAd0dOlt9GRBCOfjP5knBwWHPFG1jbf/f/y0
         Xwfe2KBU5M8j07ogcg6g6RajE3pPu5JnT08hzS0p0t3+Z7wnsmHLapGxMsa1VoIEPfJO
         UecOFW+VLbbaWyGynr65nfAy/VeXL/fhLfxlVh5yv1nFdJDl2oI+pW8iLej/xdTKm2aW
         4EKCnS0SBQCyxqM8oRVjj4OdSXoc6eJgmW8nEpPh/tTuAToERSjMWBNC8Of75frP4CEw
         TBwohX+9t2raOCelOxNVMctRbdU8HftmReCEZe8C62GtNiYNadK0a1Q4LA1454GcmJ3O
         1MHg==
X-Gm-Message-State: AOJu0YzrB4W4K/H4OyCTtjnUXTzWMkCkyxii74R0GrSwOf9WBdDWNsEW
	r3rWZ2DED/At3ZZeePso4JVsTv5Qy2B0EYvt7j1q3wQ6mwm9xe0NAthyQr0a
X-Google-Smtp-Source: AGHT+IG0UR4ZxalYUP3/BGhC3ydzBVAx8ZbJv+hJuW20soqYkAUdt+i/vabzYxhkausLup9ufaY2ZA==
X-Received: by 2002:a19:2d17:0:b0:513:e27c:78f0 with SMTP id k23-20020a192d17000000b00513e27c78f0mr7501017lfj.46.1711478825321;
        Tue, 26 Mar 2024 11:47:05 -0700 (PDT)
Received: from localhost.localdomain (109-252-14-191.nat.spd-mgts.ru. [109.252.14.191])
        by smtp.gmail.com with ESMTPSA id h10-20020ac2596a000000b00513d24f1d38sm1586371lfp.172.2024.03.26.11.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 11:47:04 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: linux-kernel@vger.kernel.org
Cc: maximmosk4@gmail.com,
	Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
Subject: [PATCH 5/8] sched: replace seq_puts by seq_putc
Date: Tue, 26 Mar 2024 21:47:02 +0300
Message-Id: <20240326184702.8768-1-Maxim.Moskalets@kaspersky.com>
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
 kernel/sched/cpuacct.c |  4 ++--
 kernel/sched/debug.c   | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 0de9dda09949..0c1ce2e1c89b 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -245,14 +245,14 @@ static int cpuacct_all_seq_show(struct seq_file *m, void *V)
 	seq_puts(m, "cpu");
 	for (index = 0; index < CPUACCT_STAT_NSTATS; index++)
 		seq_printf(m, " %s", cpuacct_stat_desc[index]);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	for_each_possible_cpu(cpu) {
 		seq_printf(m, "%d", cpu);
 		for (index = 0; index < CPUACCT_STAT_NSTATS; index++)
 			seq_printf(m, " %llu",
 				   cpuacct_cpuusage_read(ca, cpu, index));
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 	return 0;
 }
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8d5d98a5834d..03d78cff66e3 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -62,7 +62,7 @@ static int sched_feat_show(struct seq_file *m, void *v)
 			seq_puts(m, "NO_");
 		seq_printf(m, "%s ", sched_feat_names[i]);
 	}
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	return 0;
 }
@@ -251,15 +251,15 @@ static int sched_dynamic_show(struct seq_file *m, void *v)
 
 	for (i = 0; i < ARRAY_SIZE(preempt_modes); i++) {
 		if (preempt_dynamic_mode == i)
-			seq_puts(m, "(");
+			seq_putc(m, '(');
 		seq_puts(m, preempt_modes[i]);
 		if (preempt_dynamic_mode == i)
-			seq_puts(m, ")");
+			seq_putc(m, ')');
 
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 	}
 
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	return 0;
 }
 
@@ -389,9 +389,9 @@ static int sd_flags_show(struct seq_file *m, void *v)
 
 	for_each_set_bit(idx, &flags, __SD_FLAG_CNT) {
 		seq_puts(m, sd_flag_debug[idx].name);
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 	}
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	return 0;
 }
-- 
2.39.2


