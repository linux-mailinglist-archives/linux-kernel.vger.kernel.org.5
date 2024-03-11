Return-Path: <linux-kernel+bounces-99482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 765E8878911
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314C3281C76
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ADF54FAA;
	Mon, 11 Mar 2024 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rR6J15n0"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D4256B62
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186230; cv=none; b=LLRVa+IHqQtXFZFLHy93g2s2TEs5i+z59Ss63qMqxBsILK6cIH+bUBJ5aXPE90wD04Ppdwzd+mxQ8p41DhSr1/n53xYC0G6aHl4Gi7uuFXEibNTbx85MSkZn+LsfjxRm0jOMECTQBFccVt9sTAKqQ0A1UzImCJ2jry9X+3CevQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186230; c=relaxed/simple;
	bh=vB/me0X2TI4dQAXS9eSBwB79LBYLQgmarkesGSgK1ck=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o6IRI0kLDvzQNDYQJ/0BrfldY2vrB24eAyUGKuRiIUvaunbaUEMqv6dw0KP+b0erl85GIHaFjalaHQEKIHsBHSxBnIIuhDRJ9tYG1JDW4HQFR8enq1jP5twHaMWcCMAbyS4ZywRiXDvp6HnMko0iaRW4j7kNwzyIT/wv8hpRJCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rR6J15n0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso6102935276.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710186228; x=1710791028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o6UJtu1HH16m2XbkBIYqvJ1tQp9TP2uMiQKdHkNHJvQ=;
        b=rR6J15n0PkHtUxmrGggUMqUPy4c3TuajwBbr/CZzoC9/3WsDARjDSK1Bf4X6Bw3yyX
         HDpTZIrI7iLxo5D5bBQ2vAiQ9fav62s/K8nNIrgv4XEYxFn1BIb/eEWnsi1yOgkboydN
         VMMklPNWN+7G1zFRHkBloh763Cr9m8xMrm6SrRZbnqBys2UsSilWxhUgpJq0WOY19qka
         HFo+aMdQqJs1Igi+oEWa9eriR2GxAufGSC2I4c9qhRwuWrwqF/H/mpzq91JQefaV8LXt
         htxm2bzSBQpYIN0/PgVotxjfULMT58KnH/Jwe0jhWqZ2BInC0I38jhCjtRrHm+D+wcec
         OFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710186228; x=1710791028;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o6UJtu1HH16m2XbkBIYqvJ1tQp9TP2uMiQKdHkNHJvQ=;
        b=IiTHFQ+Hiu43eX0XsuqObdmkQZVAyeXZ2n4sb4V4nH9g4Fmim/4N+mVzEBPtd5JORJ
         caBqZE7Ff0QsvC9gP21NloZtUxWFBOMQMMkEcs7IeecAkYUG9FQeyfm4ifGJ5+7W3TlS
         S8j2XtGOp+56olHGB3hCQKOWF8IAjQdn57yJI2+LyWkvMSEmxdM/iXfcCHO3D3I8/B70
         BKBNRlxdiabaD0yVfrq4HjH0u/vvWg30seD/oTuZt0KXe6jCLHJZk87Gp/EUK+XuSZh+
         3Egutu0m0qzMQooCnh3Xlb/i2wlK44JQUvQ0YjeiVwRk8GkyVY9MANCCMVHeUwHtsrL+
         uOYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHUFqXahRn6EQ1zkq7UfqvztdcV/OTTNx8xoFLD7/mnsi0JQXwbkAwkW2cLSlxQxlUedPC11CmCD43gnzYslYuPsUiA7fOMq0DgBj8
X-Gm-Message-State: AOJu0Yz3EeKMPTf8RjMeemZtVydc2Yj6eFWZCAgGTDJ+mDj/UFHdTZKY
	F2GoDVIbuKjzrS4IG8bD/dfmVJkF2mR94DHK0ZOSLIbn9rCHI4LcQvCAS0Vj4wo6yELiELmKYcz
	fgyA9TFOgpBdHUahqBw==
X-Google-Smtp-Source: AGHT+IEjE4RPBh2h1ZjpLGnSOpuQW3myo032wQ/NGNsdybflZDgTA9lg25piUM2Q2N+xBQnJoHArMT+oFGdf8EMZ
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:f02:b0:dcd:2f2d:7a0f with SMTP
 id et2-20020a0569020f0200b00dcd2f2d7a0fmr387205ybb.9.1710186228508; Mon, 11
 Mar 2024 12:43:48 -0700 (PDT)
Date: Mon, 11 Mar 2024 19:43:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240311194346.2291333-1-yosryahmed@google.com>
Subject: [PATCH] percpu: clean up all mappings when pcpu_map_pages() fails
From: Yosry Ahmed <yosryahmed@google.com>
To: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

In pcpu_map_pages(), if __pcpu_map_pages() fails on a CPU, we call
__pcpu_unmap_pages() to clean up mappings on all CPUs where mappings
were created, but not on the CPU where __pcpu_map_pages() fails.

__pcpu_map_pages() and __pcpu_unmap_pages() are wrappers around
vmap_pages_range_noflush() and vunmap_range_noflush(). All other callers
of vmap_pages_range_noflush() call vunmap_range_noflush() when mapping
fails, except pcpu_map_pages(). The reason could be that partial
mappings may be left behind from a failed mapping attempt.

Call __pcpu_unmap_pages() for the failed CPU as well in
pcpu_map_pages().

This was found by code inspection, no failures or bugs were observed.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

Perhaps the reason __pcpu_unmap_pages() is not currently being called
for the failed CPU is that the size and alignment requirements make sure
we never leave any partial mappings behind? I have no idea. Nonetheless,
I think we want this change as that could be fragile, and is
inconsistent with other callers.

---
 mm/percpu-vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index 2054c9213c433..cd69caf6aa8d8 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -231,10 +231,10 @@ static int pcpu_map_pages(struct pcpu_chunk *chunk,
 	return 0;
 err:
 	for_each_possible_cpu(tcpu) {
-		if (tcpu == cpu)
-			break;
 		__pcpu_unmap_pages(pcpu_chunk_addr(chunk, tcpu, page_start),
 				   page_end - page_start);
+		if (tcpu == cpu)
+			break;
 	}
 	pcpu_post_unmap_tlb_flush(chunk, page_start, page_end);
 	return err;
-- 
2.44.0.278.ge034bb2e1d-goog


