Return-Path: <linux-kernel+bounces-64767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F38F85429C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4FBD1F27392
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E46D111B7;
	Wed, 14 Feb 2024 06:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="feM/altA"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE7F11184
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707890761; cv=none; b=iaVcNiNMyxxKMnc2INzz/t1/i0Pujakd530Du32eivXX6ozm0j4T3dAqiE8dXW8T1O7oMxGGPP5mjoVGpvXBPFVEV1G3eNlEtCDMijmruO7H9ASwG1IGTzB0LB3YZrbcBNWjX977PMhjh1wJvsTfop97TiTdP+enurisLOG/Oyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707890761; c=relaxed/simple;
	bh=iEbHcbHJ+9bB3Sa9kRTJ4KWMBUFabcdRFDkuVsMtWKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FWRaw1xTYE/KsyNB202Y/O7MM9BKJVbHUwjNGbDnZlWJ/x6I8hhv6fkylw7j/vsyT64F6EadT2TzxCe8FvodnizAPZzdr8cRdHa5tejQLKYjIkd+jCv0jnhM1MnNYaN7kJWEN7QlQw/qbmzhSVpKW5DBiRXHwpUzG8itpv8KiEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=feM/altA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1d409124358so51042715ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707890759; x=1708495559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PA0Wvzy3nOg04HsvD1HxZoLNsuEGHVAo5nrJURoHvxc=;
        b=feM/altAcmvKtvSZnjX8wLBL9s8JtK9fcFijOJekIbUXl+nVoP46azKtCp4ZvnXxBJ
         fluPcugcHXuJQ1rG1b6dgSXD4haI1WBFPLO0aW9fqKeQcjV7i2tErzlAaH63b2sF5PNJ
         Z2JAN1IkIaB6knI4pSDDH/tlBHT01bUYBQDZl3u/vYE5JDzycSOqW3Erel0Rr/i1EVsP
         xcEsW+zIPeSS0xInjsAIr75p7LIDVdZ1yZRMzwHQ7O5C3v8C5A4W/leXA3QqaiV+69Uo
         APzaCzMwE0v6Dx3eeWE05M0rpKtTEsiZgNRy0dUEE8O7/Zu6CwSRLXzfwY12wAepGXUj
         RCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707890759; x=1708495559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PA0Wvzy3nOg04HsvD1HxZoLNsuEGHVAo5nrJURoHvxc=;
        b=oN8FDCU35dE5vATIKKjKKKg9nZqJDjioYZJwGUhH2LW4dHMAaT27XbHtGWAfUtBERw
         xdPBwlrCoxArkYCH+FRTaWu3AcyWLei5mKV4wPLvTHNH2NhQKvd80HtWSjqWY7bH72XY
         0nP3ERmqPjubiuiCwb+VKeK0e4xAW2/2/xvw4nexp+Ynumuu8JEqhSVMJVmHzSfS+C5y
         AhJl1Rb37Czu4Vk+lMwEAXGu8Dp+oJejniFYdkPRF2pPGeJwpUsxXvSrqGsGo4qBsye6
         cZqTe/7ea/KI50PQXiav9GAt2EDy9OEfjL52wzdIKTo6/60rxDQxqGnlmEpsmSrR0O++
         cQZw==
X-Forwarded-Encrypted: i=1; AJvYcCVeDrJGPiQE+38JvyP9EHcusG2ohjQCY9GW4uHaKrLrRU9ODiEwtynPb3NNEg2g8rNeiXZMNTH8Q0rCL8g54l1+Bw7CrROJ7MvwMJH7
X-Gm-Message-State: AOJu0Yzzuiezu5KNKm3ontvMrMBUYnpxlV58tGEC22kvQlI/GcXp6QYo
	hqgsBm2iTkXi4Bbt9x6arGtgo3H1tgUBZBQR+dm9UlWw/g/dLgqn4l7xGHBI+PyQiGH/mfddESF
	fssu/EGMsqg==
X-Google-Smtp-Source: AGHT+IH74/+lNGXA9E0f/LU7sdPbr0lrApcPOuJOUZ+tXhmpN3a4MVpqvF5v90Hs3f8nUF/Bv1x3VtTwkY6wyA==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a17:902:ea11:b0:1db:6187:61d7 with SMTP
 id s17-20020a170902ea1100b001db618761d7mr9768plg.13.1707890759283; Tue, 13
 Feb 2024 22:05:59 -0800 (PST)
Date: Wed, 14 Feb 2024 06:05:34 +0000
In-Reply-To: <20240214060538.3524462-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214060538.3524462-1-kinseyho@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214060538.3524462-2-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 1/5] mm/mglru: drop unused parameter
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Donet Tom <donettom@linux.vnet.ibm.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

struct scan_control *sc is currently passed into try_to_inc_max_seq()
and run_aging(). This parameter is not used.

Drop the unused parameter struct scan_control *sc. No functional change.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 mm/vmscan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 54cb7685beba..9d15648561ec 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3834,7 +3834,7 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 }
 
 static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
-			       struct scan_control *sc, bool can_swap, bool force_scan)
+			       bool can_swap, bool force_scan)
 {
 	bool success;
 	struct lru_gen_mm_walk *walk;
@@ -4690,7 +4690,7 @@ static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc, bool
 		return nr_to_scan;
 
 	/* skip this lruvec as it's low on cold folios */
-	return try_to_inc_max_seq(lruvec, max_seq, sc, can_swap, false) ? -1 : 0;
+	return try_to_inc_max_seq(lruvec, max_seq, can_swap, false) ? -1 : 0;
 }
 
 static bool should_abort_scan(struct lruvec *lruvec, struct scan_control *sc)
@@ -5350,7 +5350,7 @@ static const struct seq_operations lru_gen_seq_ops = {
 	.show = lru_gen_seq_show,
 };
 
-static int run_aging(struct lruvec *lruvec, unsigned long seq, struct scan_control *sc,
+static int run_aging(struct lruvec *lruvec, unsigned long seq,
 		     bool can_swap, bool force_scan)
 {
 	DEFINE_MAX_SEQ(lruvec);
@@ -5365,7 +5365,7 @@ static int run_aging(struct lruvec *lruvec, unsigned long seq, struct scan_contr
 	if (!force_scan && min_seq[!can_swap] + MAX_NR_GENS - 1 <= max_seq)
 		return -ERANGE;
 
-	try_to_inc_max_seq(lruvec, max_seq, sc, can_swap, force_scan);
+	try_to_inc_max_seq(lruvec, max_seq, can_swap, force_scan);
 
 	return 0;
 }
@@ -5433,7 +5433,7 @@ static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
 
 	switch (cmd) {
 	case '+':
-		err = run_aging(lruvec, seq, sc, swappiness, opt);
+		err = run_aging(lruvec, seq, swappiness, opt);
 		break;
 	case '-':
 		err = run_eviction(lruvec, seq, sc, swappiness, opt);
-- 
2.43.0.687.g38aa6559b0-goog


