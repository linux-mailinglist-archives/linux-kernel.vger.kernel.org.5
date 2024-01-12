Return-Path: <linux-kernel+bounces-24330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5983582BB13
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A47289D59
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ED85D73B;
	Fri, 12 Jan 2024 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z9k1mwSi"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42585D754
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 05:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e9de9795dfso116557157b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705038795; x=1705643595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MxvkESmzviEYCBtp91snCvTXp4bYwC2oMLMP2RAwiuA=;
        b=Z9k1mwSi3Lrc7sKciPEyKLWtgn/dQi3Igqi+JSP+YZoi4eO+aTjh9Dd0d6+6EB80EE
         lxHol5Bn8YJ79P6KQjHoBGzBF4nX4nEZDLSqWMc9fkx+y7lo2SzJe9DsLZrXRTo0f346
         M4gBmBmT75EIobbjPaN0TRNWod16RKAJWmtgg2Cx4jfe8iluEGCqF96krG3z8jZ6kVP/
         h8aUWwzv93o1DCGlE80pI2ZVBTCG0uojo7In9TDtlmuNcJEwaTDq8PNMexaMACdePyZn
         k6NkCHIsRBq99NtpqLci+xKTsCnQO4ZWjaENDMNPg90JZKXvBaxwvHougTEEJ13FrF6L
         +Myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705038795; x=1705643595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxvkESmzviEYCBtp91snCvTXp4bYwC2oMLMP2RAwiuA=;
        b=cfCHft7+FbUQ/Ym9tHJ+eaPFAl4NiHeu0TPgc82vReOePER5Xig9iD283XOG4fVbQC
         1KQFVoS6X35DHETJkuFXD+uAsFwsqn5t6S9rLzIpwFQ3XqA27iduJlvtyIdl1OjeI5Zq
         U9EuUpAAVhsqoKgMuE4sv6blMj8bNAsB39u8oEtBxinA26EpD+BPlqVaJPzBQAfx0bZq
         kI9m7X6yVgH1UO/40c5fRQq2iyeqplLAoqB9r+c09y4Bo40RaWlpwnbmoQ6cpGZ1QgHU
         lvvaeO9FLAPcvJN6c8XXHwdxK5cgwQK5eh4jsnmy1EbH73Hr3L9iaAjFAn6xXVy5QSRs
         LybA==
X-Gm-Message-State: AOJu0YwGAKVJYBxIND+NkQZ2QCGitbIarRKEZMDhmrB0g4dSDlvA6fIZ
	IXsqyGxZnXBsELS7x5K+9It6ErXeT36nNekrvXokeKU=
X-Google-Smtp-Source: AGHT+IEQgbkriNOGK5mfwWNuA4LMZiYYrvGPT1vz3dpLuatntUClCmGcbrPmnPd+PTEtKaWhmKYQgGZpVUGSTNxw
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:43a4])
 (user=vannapurve job=sendgmr) by 2002:a0d:e003:0:b0:5fb:7d88:a558 with SMTP
 id j3-20020a0de003000000b005fb7d88a558mr497217ywe.0.1705038794846; Thu, 11
 Jan 2024 21:53:14 -0800 (PST)
Date: Fri, 12 Jan 2024 05:52:51 +0000
In-Reply-To: <20240112055251.36101-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240112055251.36101-6-vannapurve@google.com>
Subject: [RFC V1 5/5] x86: CVMs: Ensure that memory conversions happen at 2M alignment
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, rientjes@google.com, bgardon@google.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, 
	jxgao@google.com, sagis@google.com, oupton@google.com, peterx@redhat.com, 
	vkuznets@redhat.com, dmatlack@google.com, pgonda@google.com, 
	michael.roth@amd.com, kirill@shutemov.name, thomas.lendacky@amd.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, andrew.jones@linux.dev, 
	corbet@lwn.net, hch@lst.de, m.szyprowski@samsung.com, bp@suse.de, 
	rostedt@goodmis.org, iommu@lists.linux.dev, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

Return error on conversion of memory ranges not aligned to 2M size.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/mm/pat/set_memory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index bda9f129835e..6f7b06a502f4 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2133,8 +2133,10 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	int ret;
 
 	/* Should not be working on unaligned addresses */
-	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
-		addr &= PAGE_MASK;
+	if (WARN_ONCE(addr & ~HPAGE_MASK, "misaligned address: %#lx\n", addr)
+		|| WARN_ONCE((numpages << PAGE_SHIFT) & ~HPAGE_MASK,
+			"misaligned numpages: %#lx\n", numpages))
+		return -EINVAL;
 
 	memset(&cpa, 0, sizeof(cpa));
 	cpa.vaddr = &addr;
-- 
2.43.0.275.g3460e3d667-goog


