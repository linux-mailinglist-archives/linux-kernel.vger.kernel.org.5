Return-Path: <linux-kernel+bounces-117599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD2088AE1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09D33B61146
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4560130A7B;
	Mon, 25 Mar 2024 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tWFgFCu+"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDDD12F5B6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387664; cv=none; b=bUR1elUgHZFR6ehAHOc4VITr5afFp30e0t94cpzD/bvZRSVjpMowKts0gmtfgtuyUJQA+nQ+GYCiZ8wMV2TqJqa27yzVq5Y5du8Vv5XP8BsvcvfctZT5ZE6efMyUoiHRRr6nZVH+h5R/4//EkV7eP9/2qJ8jQZDHNVCYlYapYLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387664; c=relaxed/simple;
	bh=r3fjiYp+AgZHV3ei77GMW6DjlOuXQfdqooVdsxOJZz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JeQJMtsDn7XCrdex1pT7m3YBgoRf08UbEyyStwwTz5GpgmPHLe1QpoRCAgfU6vdX3fYx1UNpImVhEeYSWdkOax+Gdqb0ypQGuCrq94n68DZ5970kM97GGz3kYT2z+G3A2biyKI77a8lPmARa82LV2QnHrZumrHKPPuuwqi7WEnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tWFgFCu+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a3bb05c9bso74651097b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711387661; x=1711992461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+xKnD/Hk5bulpibeGFuTyXe+4qbZ8qSnGUgzX6Q+tg=;
        b=tWFgFCu+7+B8iCj4l+XNvEkD6WEFf837r+nJK2b9bKdKyecR4o6DmXl8TeRq8iLfHN
         QS1ETtisUldJfyfqDSZvaA/ZJjadZRdeDUGvuqD35eeBEoc4yBaY1T4Ka3sBu7AhlXHU
         CF6L/84pzItEDEBrsmMqmiJws1J5dA+E4XY6nKpZp8hThPwoR/253VFmTDdVpvnBiUvn
         FyXbsWATbxD+Z6cGQ6REWOT9XjmW+CmRrSxNxTzpcPgzDwpZEhSje9AETBNgVyLCC0R4
         53wi/PoD5mqvao6C0HQsdVNbHj5oStlH5UiNX6pCLvRmLl95/1TPLEekK/85KkmK5AGi
         KXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387661; x=1711992461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+xKnD/Hk5bulpibeGFuTyXe+4qbZ8qSnGUgzX6Q+tg=;
        b=ZVU2EP9FaBZInAuEEwI4VC/ZsCYHuaRGOUb4Rq0WmyBVWyBIPmyhsl1OLf0bJ1Rjeb
         DmxwVzSODfEF/OQM8TxNtOHnOKsMuhDda/6mF4ikY4GZ8Hr/W6Lw+DprmomxR0tuHEEl
         TzenSWvd4rMgfWO3rbcVEsnfSm2167Lkc3LyDS7PBhbtI/21CApUQa7+YhJuizSTHv9t
         +U4Utg/nXCgNHWBP/JkY/lOW1Cxsptab9wNm8pvmZzHqJA+a/AlkXJP6nFojx+FMpZ0X
         aOupjzXwRtCMCl7RXYriuxS0dh+Og/xT18j/Ie861OxnENmQg7r+Tq0BbpYDF2qxeGW1
         ZheA==
X-Forwarded-Encrypted: i=1; AJvYcCX+U0ENzV6P5snj0Sz6EO0+JfeVF106u5dI4bBtFQFux2cXr8c/xAuExdj0glJ4F3PB4v/D5844jOpDACjtYj97+WuO1hfDN9gjcvRI
X-Gm-Message-State: AOJu0Yz0B5QJBur+XKKRfuNcWMYpNqB+q4GFi0WQhgc+EVGMjToUjdRg
	6lgzJMaUTx/ZpxZnmgV2J7K75CIXCPtkBRIMexd312jLpBRLxt9a8CEh5se3hIJ7VK4Q7tUFnmT
	jaGcBvB4GGD1apHFJJjaSTA==
X-Google-Smtp-Source: AGHT+IGOXDCr9eFN0hGMBkiz/xvjtcpSPh1J7eXfROpiF4bMJ8dytnsQwF5v/Y0UX1Wt2YJvnTIPvhFgMbCVu+AJLg==
X-Received: from peternewman-us.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3dcc])
 (user=peternewman job=sendgmr) by 2002:a81:8387:0:b0:611:a290:b8e3 with SMTP
 id t129-20020a818387000000b00611a290b8e3mr157140ywf.0.1711387661638; Mon, 25
 Mar 2024 10:27:41 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:27:04 -0700
In-Reply-To: <20240325172707.73966-1-peternewman@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325172707.73966-1-peternewman@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325172707.73966-4-peternewman@google.com>
Subject: [PATCH v1 3/6] x86/resctrl: Disallow mongroup rename on MPAM
From: Peter Newman <peternewman@google.com>
To: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	James Morse <james.morse@arm.com>
Cc: Stephane Eranian <eranian@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen <tandersen@netflix.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"

Moving a monitoring group to a different parent control assumes that the
monitors will not be impacted. This is not the case on MPAM where the
PMG is an extension of the PARTID.

Detect this situation by requiring the change in CLOSID not to affect
the result of resctrl_arch_rmid_idx_encode(), otherwise return
-EOPNOTSUPP.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9b1969e4235a..8d6979dbfd02 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3879,6 +3879,19 @@ static int rdtgroup_rename(struct kernfs_node *kn,
 		goto out;
 	}
 
+	/*
+	 * If changing the CLOSID impacts the RMID, this operation is not
+	 * supported.
+	 */
+	if (resctrl_arch_rmid_idx_encode(rdtgrp->mon.parent->closid,
+					 rdtgrp->mon.rmid) !=
+	    resctrl_arch_rmid_idx_encode(new_prdtgrp->closid,
+					 rdtgrp->mon.rmid)) {
+		rdt_last_cmd_puts("changing parent control group not supported\n");
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	/*
 	 * If the MON group is monitoring CPUs, the CPUs must be assigned to the
 	 * current parent CTRL_MON group and therefore cannot be assigned to
-- 
2.44.0.396.g6e790dbe36-goog


