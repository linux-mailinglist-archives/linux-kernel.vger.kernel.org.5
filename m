Return-Path: <linux-kernel+bounces-119704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7353B88CC41
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B1B324D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0018513C8E8;
	Tue, 26 Mar 2024 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsWXhVwE"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDD213C3D8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478812; cv=none; b=tYuBbZCDiayLkWvlh3HMC4RqYIyNFqzFMU/QfPbx3UAtKjNixk4hqQK3G21RJLdqJHVVfMJuydqd5LB3vmab9yfJbiCgU8RmX5D4OPNqR/tq/CF2RtteNQsNiljf1WjWtn+quw9nqeKX27v/rE2N4a/0PHvXxmnq/oZPqIxAA9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478812; c=relaxed/simple;
	bh=eigWPBre8ix82nCP/Se0x1ZtUOlbqBmM58WYT9wWDE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TYXz/8Qgddy4BAgBTFr5kQ67I4jxyx3ftyk/f4+IMKkfAh/IdBO0hOuhwLbTLLLA3tE+roMSGP6gdE26FLbgTXWDiD/SHOyjXcC7zFce3d03LmjTRaqVdDUr1ZeqDop9mww+gmln/0k6yUHKxFy49K9Cee1SnVogy6IcWDKJutM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsWXhVwE; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513dd2d2415so6291004e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711478808; x=1712083608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KM+j7SWnIc800SZqJLO3ijmaBxmx9VNT9BzC59XFSoI=;
        b=NsWXhVwE96fTwQVwtycgChzbbvlpxmVXns7gugto8cbccGlrSkOFfKq5spkhZY/E51
         pqUww/K+sEWbn9GQNhAU143JlF+fEl91E9gSgBTa6tn5Rk/UrnDstJtuUwll/5Nsxmwk
         hOuUNw0N9+5qqDPCNSrdEUN1OirpF1vdHhqLXF6D5OYp34zE1TbJEL4j8T6PJ+qLcDuR
         /NEAeO0Bot1c3qsBLFe+bp7/OjF5/JfRCYyyylD5Bq8IoKCK+Lg0FFswAp25ibN3Qyl+
         vmGxdbSaJH77uaSamwJ92EganDr8DInFy6lDPZVgCV1rSsM0wNhLSI9MKKpeXltwy7gq
         GM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711478808; x=1712083608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KM+j7SWnIc800SZqJLO3ijmaBxmx9VNT9BzC59XFSoI=;
        b=od72CxkpN33Q4GwoHXHnJ4AxFY2EfrpHcHleQm74gzFFXiIpMsbm5eGhHLvpyl2wbT
         bfcMhdyOOsX/EbZU7g2CHQe0yq6zLtkN18EzdOEeSCOSdnxCxJEn0a8qtCwIAITmhH4C
         bjQhm0nyi0rdj09SQXSfmklFitUvI48pfI3I7rsW4UMk4qqkIzwLThBpSjl389RmKN8i
         Qp4hiVewMUADRQWI7P8fUnIhJW5vi1dHS6W/1UBpOgTllgLgQBK10RxcVAQDbWUXTjaT
         J67GbyD6lZvXHRX/h5YvIbS90cvTcQChj1o6uOm2LWc33WjCQyjfy//6RRBsWJdm0s+/
         KlQA==
X-Gm-Message-State: AOJu0YwBf44JIxPZ0Pg76MtLfWWNVfMiAOOo5mA1hNJn+18W3PIsHrdj
	kYBdWFwAb5PhLHPBP/EQm4PKV2mHRF1FrZckVfW6kyrfn1ZMf0DmbPHzR8iI
X-Google-Smtp-Source: AGHT+IFelxkhcKFmmp7/mixbeup+BHJs6rctqQe4xIiikQNiFfR1ZoYCRp5HFfZoPeX7UfpQeSfXmg==
X-Received: by 2002:ac2:44d5:0:b0:513:c876:c80a with SMTP id d21-20020ac244d5000000b00513c876c80amr296837lfm.34.1711478808027;
        Tue, 26 Mar 2024 11:46:48 -0700 (PDT)
Received: from localhost.localdomain (109-252-14-191.nat.spd-mgts.ru. [109.252.14.191])
        by smtp.gmail.com with ESMTPSA id s17-20020a197711000000b00513c928de7bsm1614113lfc.59.2024.03.26.11.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 11:46:47 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: linux-kernel@vger.kernel.org
Cc: maximmosk4@gmail.com,
	Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
Subject: [PATCH 3/8] trace: replace seq_puts by seq_putc
Date: Tue, 26 Mar 2024 21:46:45 +0300
Message-Id: <20240326184645.8660-1-Maxim.Moskalets@kaspersky.com>
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
 kernel/trace/trace_events_hist.c | 26 +++++++++++++-------------
 kernel/trace/trace_events_user.c |  8 ++++----
 kernel/trace/trace_hwlat.c       |  4 ++--
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 6ece1308d36a..5992278cbfb5 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4898,14 +4898,14 @@ static void print_action_spec(struct seq_file *m,
 		for (i = 0; i < hist_data->n_save_vars; i++) {
 			seq_printf(m, "%s", hist_data->save_vars[i]->var->var.name);
 			if (i < hist_data->n_save_vars - 1)
-				seq_puts(m, ",");
+				seq_putc(m, ',');
 		}
 	} else if (data->action == ACTION_TRACE) {
 		if (data->use_trace_keyword)
 			seq_printf(m, "%s", data->synth_event_name);
 		for (i = 0; i < data->n_params; i++) {
 			if (i || data->use_trace_keyword)
-				seq_puts(m, ",");
+				seq_putc(m, ',');
 			seq_printf(m, "%s", data->params[i]);
 		}
 	}
@@ -4924,7 +4924,7 @@ static void print_track_data_spec(struct seq_file *m,
 
 	print_action_spec(m, hist_data, data);
 
-	seq_puts(m, ")");
+	seq_putc(m, ')');
 }
 
 static void print_onmatch_spec(struct seq_file *m,
@@ -4938,7 +4938,7 @@ static void print_onmatch_spec(struct seq_file *m,
 
 	print_action_spec(m, hist_data, data);
 
-	seq_puts(m, ")");
+	seq_putc(m, ')');
 }
 
 static bool actions_match(struct hist_trigger_data *hist_data,
@@ -5413,9 +5413,9 @@ static void hist_trigger_print_key(struct seq_file *m,
 	}
 
 	if (!multiline)
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 
-	seq_puts(m, "}");
+	seq_putc(m, '}');
 }
 
 /* Get the 100 times of the percentage of @val in @total */
@@ -5511,13 +5511,13 @@ static void hist_trigger_entry_print(struct seq_file *m,
 		if (flags & HIST_FIELD_FL_VAR || flags & HIST_FIELD_FL_EXPR)
 			continue;
 
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 		hist_trigger_print_val(m, i, field_name, flags, stats, elt);
 	}
 
 	print_actions(m, hist_data, elt);
 
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 }
 
 static int print_entries(struct seq_file *m,
@@ -5971,7 +5971,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 		field = hist_data->fields[i];
 
 		if (i > hist_data->n_vals)
-			seq_puts(m, ",");
+			seq_putc(m, ',');
 
 		if (field->flags & HIST_FIELD_FL_STACKTRACE) {
 			if (field->field)
@@ -5997,7 +5997,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 			seq_puts(m, "hitcount");
 		} else {
 			if (show_val)
-				seq_puts(m, ",");
+				seq_putc(m, ',');
 			hist_field_print(m, field);
 		}
 		show_val = true;
@@ -6006,14 +6006,14 @@ static int event_hist_trigger_print(struct seq_file *m,
 	if (have_var) {
 		unsigned int n = 0;
 
-		seq_puts(m, ":");
+		seq_putc(m, ':');
 
 		for_each_hist_val_field(i, hist_data) {
 			field = hist_data->fields[i];
 
 			if (field->flags & HIST_FIELD_FL_VAR) {
 				if (n++)
-					seq_puts(m, ",");
+					seq_putc(m, ',');
 				hist_field_print(m, field);
 			}
 		}
@@ -6035,7 +6035,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 			return -EINVAL;
 
 		if (i > 0)
-			seq_puts(m, ",");
+			seq_putc(m, ',');
 
 		if (idx == HITCOUNT_IDX)
 			seq_puts(m, "hitcount");
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 70d428c394b6..762f8b4667ca 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1823,7 +1823,7 @@ static int user_event_show(struct seq_file *m, struct dyn_event *ev)
 
 	list_for_each_entry_reverse(field, head, link) {
 		if (depth == 0)
-			seq_puts(m, " ");
+			seq_putc(m, ' ');
 		else
 			seq_puts(m, "; ");
 
@@ -1835,7 +1835,7 @@ static int user_event_show(struct seq_file *m, struct dyn_event *ev)
 		depth++;
 	}
 
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	return 0;
 }
@@ -2733,13 +2733,13 @@ static int user_seq_show(struct seq_file *m, void *p)
 			busy++;
 		}
 
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 		active++;
 	}
 
 	mutex_unlock(&group->reg_mutex);
 
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	seq_printf(m, "Active: %d\n", active);
 	seq_printf(m, "Busy: %d\n", busy);
 
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index b791524a6536..874a81cf9bb7 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -636,14 +636,14 @@ static int s_mode_show(struct seq_file *s, void *v)
 		seq_printf(s, "%s", thread_mode_str[mode]);
 
 	if (mode < MODE_MAX - 1) /* if mode is any but last */
-		seq_puts(s, " ");
+		seq_putc(s, ' ');
 
 	return 0;
 }
 
 static void s_mode_stop(struct seq_file *s, void *v)
 {
-	seq_puts(s, "\n");
+	seq_putc(s, '\n');
 	mutex_unlock(&hwlat_data.lock);
 }
 
-- 
2.39.2


