Return-Path: <linux-kernel+bounces-41466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D651983F24C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EB81F231AD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E66723745;
	Sat, 27 Jan 2024 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Ov+yiQW"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D192033C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706399205; cv=none; b=cy68mhag2raT3HM4YCO1VS60SkSmcTm2H9bS2N7TworrJp7ZAAUWZQfD8bmn83OVYyJijh3zUGhU8TneVBRqT3rFILQVaOWpxhy0RkvlikCkQdw06pkAELb/P/bz1Mk1b/paX+HLxOl4FQh0j/8mU2mjYUzHITKeqrC9movCAus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706399205; c=relaxed/simple;
	bh=P9bo665rDuTuKgck3NtYPkXUGHEK21LpXvICqeEA9QE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=csZivSUB9rtanflMxBOTB92VFZUX+awmAh625DXKdgCFyIOCMu9YxFW/JykXf2HXybDD9G16VU1q5KNl5rTfhADiW4478IEJbQztEIwxbLnp3DCkeO2C+Gt1no1JJbfzcvScuzVwQT9ZsWCEPTmQSKpWSbkuNjd5Hh5+b25hlL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--neelnatu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Ov+yiQW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--neelnatu.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc26605c3aaso2651798276.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 15:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706399203; x=1707004003; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CyDN4+TiT46Ds8Ohg+X9G0B6d1j9fxP1UwZKU33b3Qc=;
        b=3Ov+yiQWz22AnoiSnpnSUcu8Vqk7ejee/4CuOcY74ayBgpLjwp8zuBUgzMS554YPHR
         fPsqouKA8noDM4nLsNpuD9WaFK6efvK8rnwfvcFxCJEw1IurvkndlM1Dg5fejJelflle
         9soJHwzKfio+aXFxsv+791rudwqjL7cz8Cm4k83Cdo6Yuj0AWu8No18i5dXkR3vMTgWF
         w7/GP/piZvl1kab6/966osIAdTAmRqIzC/+GL2c5Vf9en8LIrzh/2LzEIR4pv7njBPHu
         I8lsLMW7UVkDO952aIYRuljv1sJcwPNG7Y4wHvmmFLNq/u1Avfp+ko3FCKXntxs7OcKI
         MrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706399203; x=1707004003;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CyDN4+TiT46Ds8Ohg+X9G0B6d1j9fxP1UwZKU33b3Qc=;
        b=cC0c9wLMvsEsRA1kDu4Rg/vDgclPaYUK6fklQvyGdeZyU3Wpzq1PgpKjF9+LyO21hi
         n3U+mwJ8Gc4E89+fbUroe6TzuW1qCZwkgcVqrp0kPy+xYMatEmCnhUGz+L3GjHP4K5Fj
         WhN6AgYOL3nxm8+oDUnxSUQACP/x3yLLm2WDG/pLaf4Dy23FmDlZBHmt6d9gzDRI1zT3
         b+sFCjJkN+CxN/GDv1woDbL4oYoR7myYwvjfhED5RjbHRALwwe0SOzP4BWwdsCuKni9e
         Lw0FO/lmDSYg0Coi+/ZPnY42GiMRUTatI7qdGSdPN73LIDqhmRbcf6CvSE4MkeoIp+rv
         A7nw==
X-Gm-Message-State: AOJu0Yz/ao4ZVNE1o352GeD6pixnRJsXhyBFifFI81feGDWZI4MyIDuH
	PMUswabuhg42jY4LnHwHf5RETj8TLHwnWRmmojSmoub6xXEMmZL6tgfaLkOp+X76C7aJj6VeYv8
	kIWJn5EOLNQ==
X-Google-Smtp-Source: AGHT+IEKkL4EMXHgh2RpZmfXmjVGCo7PoFbgzv69iMBgoK6/rpUgGJE5z20/1SaJyqVS/IvgcuZmrMBDsov7jw==
X-Received: from neelnatu.svl.corp.google.com ([2620:15c:2a3:200:9829:f4d9:886a:c45f])
 (user=neelnatu job=sendgmr) by 2002:a05:6902:250b:b0:dc2:65db:786c with SMTP
 id dt11-20020a056902250b00b00dc265db786cmr214540ybb.5.1706399203103; Sat, 27
 Jan 2024 15:46:43 -0800 (PST)
Date: Sat, 27 Jan 2024 15:46:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240127234636.609265-1-neelnatu@google.com>
Subject: [PATCH] kernfs: fix false-positive WARN(nr_mmapped) in kernfs_drain_open_files
From: Neel Natu <neelnatu@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Neel Natu <neelnatu@google.com>
Content-Type: text/plain; charset="UTF-8"

Prior to this change 'on->nr_mmapped' tracked the total number of
mmaps across all of its associated open files via kernfs_fop_mmap().
Thus if the file descriptor associated with a kernfs_open_file was
mmapped 10 times then we would have: 'of->mmapped = true' and
'of_on(of)->nr_mmapped = 10'.

The problem is that closing or draining a 'of->mmapped' file would
only decrement one from the 'of_on(of)->nr_mmapped' counter.

For e.g. we have this from kernfs_unlink_open_file():
        if (of->mmapped)
                on->nr_mmapped--;

The WARN_ON_ONCE(on->nr_mmapped) in kernfs_drain_open_files() is
easy to reproduce by:
1. opening a (mmap-able) kernfs file.
2. mmap-ing that file more than once (mapping just once masks the issue).
3. trigger a drain of that kernfs file.

Modulo out-of-tree patches I was able to trigger this reliably by
identifying pci device nodes in sysfs that have resource regions
that are mmap-able and that don't have any driver attached to them
(steps 1 and 2). For step 3 we can "echo 1 > remove" to trigger a
kernfs_drain.

Signed-off-by: Neel Natu <neelnatu@google.com>
---
 fs/kernfs/file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index ffa4565c275a..e9df2f87072c 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -483,9 +483,11 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 		goto out_put;
 
 	rc = 0;
-	of->mmapped = true;
-	of_on(of)->nr_mmapped++;
-	of->vm_ops = vma->vm_ops;
+	if (!of->mmapped) {
+		of->mmapped = true;
+		of_on(of)->nr_mmapped++;
+		of->vm_ops = vma->vm_ops;
+	}
 	vma->vm_ops = &kernfs_vm_ops;
 out_put:
 	kernfs_put_active(of->kn);
-- 
2.43.0.429.g432eaa2c6b-goog


