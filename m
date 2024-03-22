Return-Path: <linux-kernel+bounces-111812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CC6887149
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB5A285979
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2BB5FEF4;
	Fri, 22 Mar 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKnuXbBz"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909BC5FBAE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126373; cv=none; b=aLAuA3i8lNrNPk7QNM5rwQ/72IkSYrM5gksn9LIJHnfZyFIUvRb4gNoPw5M0JbYHNKGOpZ9TRQHonQ4f4qtNH9ReULFmLT7iBL+y7k2xaEBRCjPuvIv9GNQ8k5GVGzZlHFaPM+nz8kiPKlX3+qhGyMZtQ31PQ59A9rSkfzIsHyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126373; c=relaxed/simple;
	bh=nIs8JKLHWhcAMkMuFWOz93kQ/3tiAi+vtEhNf0q70ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZnyUHh5M/Ys8s8YSVi3prLhyxL2GsgBJD5aMOqPLXEZegkt9Vm1DYYMVclyE8pfVPZ2UJyXx14cZVMolCDJjfoeCSCBU3CqBjI7xUQhFYHMGThB4PhSJQA5q+5kT/x1zrVf6WgWntTuGQkn/oW0qeJ/NXEhrH8L/+3tFN5vwWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKnuXbBz; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7e08498aa43so993549241.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126369; x=1711731169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlAhaai0XmtsEWjeCcLZPOJXYygjR0gXl78SmFs1efY=;
        b=NKnuXbBzA99kZTV1P7Gq0TDdz7mW/+G0yHSBHl98m4KSVCiytXxCg5bYMR0tupIzqO
         62oSYAhXBh4DgMCH2A2fg0DAo0oaiE8LydvUAB5pcHX69TxDsmLyr0rHB9cRksApVK4K
         bruMXjw9Z0+940YH8BA2yrc8bL1ZZSpfjwOm1BTCRZvZSAKkNlVDfM2SRAEU4mWWw8ft
         m2YnOEcH3iDfaeFFGojpI3ijgA1VSCly6PP6rpZyFuGExEYGDtb2FxR0qDNo+AMLGgL4
         DrBt3ZoczTNyjgUz6QyWBoD6PUt4ygjZg/Jgx6D5dkxxhCUAfSaKyDg1pDKTSeJLOhYf
         ryYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126369; x=1711731169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlAhaai0XmtsEWjeCcLZPOJXYygjR0gXl78SmFs1efY=;
        b=H8dKXETY8J1ItEjj5Gq/dkaYxs4Hg490r93DVF45ggTtLyWdUOHy+ef+j2YapiLYWp
         jtxUmGSiOiGWNxHtnyZyi7JCBZsPwERAQ557KIAIlFOyoDzViCm6++wKq5ORKfI0JDCK
         eewX1VtkUuQD9UYp0MrdhvA2rz6ioArIitOrp4/aPq7TJgHJlDsZB5vCdJzGR3lXelnr
         O/wx+Z2jyJpgez7fVPpTFyQ0KQ73upqUrgdls3VKxzUMPJ+T4TSpw5DGRl9OKKyCqqOA
         eFjAXlm+y0PyIqDu81uxR7EKvxttqG4v5qXYVgwLVuN+l3qSHsJdy3ladppszoSptxb9
         cPJA==
X-Gm-Message-State: AOJu0YxigA9NSfuGoH1MO8D9ZSFYxn1NIp2sjVWOJuBkyIvd58Aqb0TJ
	LrugHd57EM4EIQx2ae3W33D+JmActxR9EKe18r4Mq+YrUMvL+8crMFUqd+U=
X-Google-Smtp-Source: AGHT+IE5FqCK5eXVoI4hEVWqaKrMV/hBIglk7+a97G86DupCD/QFQEMSKGaby20Qb3Ze9eYeS6VkZg==
X-Received: by 2002:a67:f895:0:b0:475:623d:ff36 with SMTP id h21-20020a67f895000000b00475623dff36mr163607vso.2.1711126369494;
        Fri, 22 Mar 2024 09:52:49 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j1-20020a37ef01000000b00789e9bbf962sm894901qkk.133.2024.03.22.09.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:52:48 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	David.Laight@aculab.com,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 03/16] x86/boot: Disable stack protector for early boot code
Date: Fri, 22 Mar 2024 12:52:20 -0400
Message-ID: <20240322165233.71698-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322165233.71698-1-brgerst@gmail.com>
References: <20240322165233.71698-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 64-bit, this will prevent crashes when the canary access is changed
from %gs:40 to %gs:__stack_chk_guard(%rip).  RIP-relative addresses from
the identity-mapped early boot code will target the wrong address with
zero-based percpu.  KASLR could then shift that address to an unmapped
page causing a crash on boot.

This early boot code runs well before userspace is active and does not
need stack protector enabled.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/kernel/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 5d128167e2e2..9884d2c9de15 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -40,6 +40,8 @@ KMSAN_SANITIZE_sev.o					:= n
 KCOV_INSTRUMENT_head$(BITS).o				:= n
 KCOV_INSTRUMENT_sev.o					:= n
 
+CFLAGS_head32.o := -fno-stack-protector
+CFLAGS_head64.o := -fno-stack-protector
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
 obj-y			+= head_$(BITS).o
-- 
2.44.0


