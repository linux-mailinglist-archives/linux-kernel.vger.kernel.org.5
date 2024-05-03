Return-Path: <linux-kernel+bounces-167456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2BC8BA9D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EF4285D69
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA08014F12F;
	Fri,  3 May 2024 09:20:02 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6FB14F12D
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714728002; cv=none; b=Opq61deuYXXJ9ddOZwe7uUMcsHeAL7yaL9I/2FBM7rCaodyEWT1yJ2QB/Ab57QOgoxY4N6JXdFnUFCm+8w5wex2hnI/PbhDtaxKJQyELG5zeWLS86qzycVOvOzMQTz/EOEBfEs0ReA7QfaamuJcx0EmMWfh49C3INZ+db0g8/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714728002; c=relaxed/simple;
	bh=+qRjQ1VwaUXuP9zHCouOBys/SL9KMiiI0zyt7a5DN0I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X5H1wQqd3Ya+3eslRX2yJmL4tRIvNzT8dd5e2eU/tofBQo89WPOx0AQ0Yo5V+1wYqUjFqtOjWvHZNcpEjoq2mjuidxkHuahu/cfjstGG1EyVEE1A5nKDwyLgqjvSmniHVfWrF0i6tif3KsUqNSUKNrYGJhP7Fx5V4dysGu+2O6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36c6b24fd6eso23908805ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 02:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714728000; x=1715332800;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nO3vVscP7MTaHhUfPIEwZUJkMUJ3OZUidwZ8npZ3Hyg=;
        b=Yu/5E4IlXMAaCmA4eSXT0g5j3m1GF/mBbWmt+zaRCalf0SZiI8Evg05b3DETbPEfHj
         5a+EswPQI9rDqWy3ojbSxFuN9PH7Axz76rNy1sCob/JcQEPT6YASgYRMJvayQ26XTfaF
         C+dBWNQcVYC1Q00WtlqrrJA080iSKMO6CGBUuuHNW9+0wdYB7vldLNiQFlnbf6VBU6DE
         BbiknqNGKpg9b5Dy7z69TuFnKirB5txy93HcG83+ygngyZZrQhsU0r+fnpyGaDTkd6S6
         RsZZX34FFIxR5oTtD/7Q3fU/8Kvsq2UvvVdaLwi/MxQ6JSbIeHasK1JjFnAuYiMs8I1C
         Ok2w==
X-Gm-Message-State: AOJu0YyfTmRnbVyFOOuies6gV3L9RoGp3qdosQpD4BayoHj03WKhuBZI
	4QRzUKtQgNCJ4EPzmQeRhjoxPFEFll/O29ZVTPsd8En5j2bNtU3OkI+jyeZK/qgt4M+0KOGtUm5
	RcEdLlu7WJ2+Il8TTFJspc+m+J+UQ1zNDpfp1rIJsv4ngAXzKkKtwtPY=
X-Google-Smtp-Source: AGHT+IGe7QgKW/D65TckaPss3ArqdFyqYTQJATq/UFErJNBCxHtbNbjXBQSCtgTyKdR7q+1juqG3duuzeiEI6uPNYmH7CbLIVqNE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0b:b0:36c:11a2:725f with SMTP id
 l11-20020a056e021c0b00b0036c11a2725fmr110965ilh.3.1714728000080; Fri, 03 May
 2024 02:20:00 -0700 (PDT)
Date: Fri, 03 May 2024 02:20:00 -0700
In-Reply-To: <00000000000022a23c061604edb3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054e74a0617893956@google.com>
Subject: Re: [syzbot] [PATCH] net/sched: taprio: fix CPU stuck due to the
 taprio hrtimer
From: syzbot <syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] net/sched: taprio: fix CPU stuck due to the taprio hrtimer
Author: luyun@kylinos.cn

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

---
 net/sched/sch_taprio.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index a0d54b422186..360778f65d9e 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -104,6 +104,7 @@ struct taprio_sched {
 	u32 max_sdu[TC_MAX_QUEUE]; /* save info from the user */
 	u32 fp[TC_QOPT_MAX_QUEUE]; /* only for dump and offloading */
 	u32 txtime_delay;
+	ktime_t offset;
 };
 
 struct __tc_taprio_qopt_offload {
@@ -170,6 +171,13 @@ static ktime_t sched_base_time(const struct sched_gate_list *sched)
 	return ns_to_ktime(sched->base_time);
 }
 
+static ktime_t taprio_get_offset(enum tk_offsets tk_offset)
+{
+	ktime_t time = ktime_get();
+
+	return ktime_sub_ns(ktime_mono_to_any(time, tk_offset), time);
+}
+
 static ktime_t taprio_mono_to_any(const struct taprio_sched *q, ktime_t mono)
 {
 	/* This pairs with WRITE_ONCE() in taprio_parse_clockid() */
@@ -918,6 +926,8 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 	int num_tc = netdev_get_num_tc(dev);
 	struct sched_entry *entry, *next;
 	struct Qdisc *sch = q->root;
+	enum tk_offsets tk_offset = READ_ONCE(q->tk_offset);
+	ktime_t now_offset = taprio_get_offset(tk_offset);
 	ktime_t end_time;
 	int tc;
 
@@ -957,6 +967,14 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 	end_time = ktime_add_ns(entry->end_time, next->interval);
 	end_time = min_t(ktime_t, end_time, oper->cycle_end_time);
 
+	if (q->offset != now_offset) {
+		ktime_t diff = ktime_sub_ns(now_offset, q->offset);
+
+		end_time = ktime_add_ns(end_time, diff);
+		oper->cycle_end_time = ktime_add_ns(oper->cycle_end_time, diff);
+		q->offset = now_offset;
+	}
+
 	for (tc = 0; tc < num_tc; tc++) {
 		if (next->gate_duration[tc] == oper->cycle_time)
 			next->gate_close_time[tc] = KTIME_MAX;
@@ -1205,11 +1223,13 @@ static int taprio_get_start_time(struct Qdisc *sch,
 				 ktime_t *start)
 {
 	struct taprio_sched *q = qdisc_priv(sch);
+	enum tk_offsets tk_offset = READ_ONCE(q->tk_offset);
 	ktime_t now, base, cycle;
 	s64 n;
 
 	base = sched_base_time(sched);
 	now = taprio_get_time(q);
+	q->offset = taprio_get_offset(tk_offset);
 
 	if (ktime_after(base, now)) {
 		*start = base;
-- 
2.34.1


