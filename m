Return-Path: <linux-kernel+bounces-111825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 567E8887157
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B161C22237
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A5560DEE;
	Fri, 22 Mar 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQsICfS6"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A08F60889
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126388; cv=none; b=Kz5pOhnZP/LU4kSBwirY+tMqharGxzxo8nEvApkdacIKWYHshXa1AHkxLBX57vdwbtsHujZAHDxJGU5wN8pFpQic5gJUEHi033RpSyK0GSNxbt8CQQJb9kYA5sDpWenrawmchnLr9QhcEoP+3V5UpzbSEVW6DAA0tYq3gDUxyPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126388; c=relaxed/simple;
	bh=f3K2IlHly9KsbWiXAM8d/JSq/+g0AfeJL+4wTF0gobQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K41/yWktMGKhe37QyMeovcK1GBF56zZVv9sbBXZV57KOyxA7nsKkl0ju2VcV7h/mrToEfClxbTP9pyUnh1fLJCt3NBPhrXUN+kdD5qqrOjHQ6MiZxaPfkgqTN7CrFRj1mzqdaTmXe3REukyA7dYsr9oUniF5Y1XwNOIi3K+ZdXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQsICfS6; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-609fc742044so24997397b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126386; x=1711731186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClIpZptlCct6LbR2ubvvxFMAK2t5s49KsuXa2pT/TK4=;
        b=YQsICfS6uoyoCLCHgD1KTPJn7JfcM0R1ddPc4PztS5uPjLoVUnXnnj4NSCUb1TpFrk
         l7hf4gP04/ENo/uByyRcGjmvhL0t3gAtnXcOgtEJp2Go6j6UMJPLhJcnZwa1BiRBChq/
         lb3At7E23lcPk2/bjg4L7aizG0a4dy7lSOM0yIOjWBKqQIudq+tJy7WRCx/c9lN3uXIp
         NIBKGctnyaS1qr9r6zWgwZRAAPF8cvHzpnXO2RkW8L6zS6SxGhJjj8jrtosxy8hP50HN
         9ji3mPskhvjpLkTb1408TQ/HP8RXMyXFrstrpwgX6C930OoaHF3cnidXpIi27WL5OP9e
         oqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126386; x=1711731186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClIpZptlCct6LbR2ubvvxFMAK2t5s49KsuXa2pT/TK4=;
        b=oDn20bviXhFm5ZKN8rQYKCYMyhfD+VWQ/ppUBiC5uWur8Z2iabm86b+uiGZbRDEsVh
         +6uOqxLFtP18Ur5952ZkyGHFOQLEKuuea9YmDoYNampx8jpQ0Te/kqWF79xxPLQ2C6tO
         uK7aW83+O5ANH+u6khplPHIHrjllZ55Kw0t3RDvbqG/SMNPsl81338mY1gn3Jty0oSjX
         7mqz/YaivNGVhyALQZgnLijsdlgP5VZkb3prvOmKrJry+acOnaVjcJTja7wl1OoePcVM
         mXJroGVReQfUT5mJsW5VgGGiL5Xk/XNJEpXQQ+Zp+9N3HSI2DNSjVQXRquXR6tcKxLep
         y0Jg==
X-Gm-Message-State: AOJu0YyJKW6JRC+OOPYZDxgBJbSNFjdyWosylHHnPxg3NbC93EG+MxEX
	yO0kPwERSjX5GLtValQRHnvgkLAZKSWbfDVqHdZu2tY6gAPsVxYok2y7xyo=
X-Google-Smtp-Source: AGHT+IGCDYDmlDjwXduTWclfEmLjb0w2VmViDJPb3X5xJ3QOfOsK8VTmisl2+tEDgIwB06jFV9mv3A==
X-Received: by 2002:a81:910c:0:b0:610:f602:de1d with SMTP id i12-20020a81910c000000b00610f602de1dmr200975ywg.2.1711126386001;
        Fri, 22 Mar 2024 09:53:06 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j1-20020a37ef01000000b00789e9bbf962sm894901qkk.133.2024.03.22.09.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:53:05 -0700 (PDT)
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
Subject: [PATCH v4 15/16] percpu: Remove __per_cpu_load
Date: Fri, 22 Mar 2024 12:52:32 -0400
Message-ID: <20240322165233.71698-16-brgerst@gmail.com>
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

__per_cpu_load is now always equal to __per_cpu_start.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 include/asm-generic/sections.h    | 2 +-
 include/asm-generic/vmlinux.lds.h | 1 -
 mm/percpu.c                       | 4 ++--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index c768de6f19a9..0755bc39b0d8 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -39,7 +39,7 @@ extern char __init_begin[], __init_end[];
 extern char _sinittext[], _einittext[];
 extern char __start_ro_after_init[], __end_ro_after_init[];
 extern char _end[];
-extern char __per_cpu_load[], __per_cpu_start[], __per_cpu_end[];
+extern char __per_cpu_start[], __per_cpu_end[];
 extern char __kprobes_text_start[], __kprobes_text_end[];
 extern char __entry_text_start[], __entry_text_end[];
 extern char __start_rodata[], __end_rodata[];
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 430b2ed2aa58..a67452ea94d3 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1052,7 +1052,6 @@
 #define PERCPU_SECTION(cacheline)					\
 	. = ALIGN(PAGE_SIZE);						\
 	.data..percpu	: AT(ADDR(.data..percpu) - LOAD_OFFSET) {	\
-		__per_cpu_load = .;					\
 		PERCPU_INPUT(cacheline)					\
 	}
 
diff --git a/mm/percpu.c b/mm/percpu.c
index 4e11fc1e6def..a584b5a78f72 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3153,7 +3153,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 				continue;
 			}
 			/* copy and return the unused part */
-			memcpy(ptr, __per_cpu_load, ai->static_size);
+			memcpy(ptr, __per_cpu_start, ai->static_size);
 			pcpu_fc_free(ptr + size_sum, ai->unit_size - size_sum);
 		}
 	}
@@ -3336,7 +3336,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size, pcpu_fc_cpu_to_node_fn_t
 		flush_cache_vmap_early(unit_addr, unit_addr + ai->unit_size);
 
 		/* copy static data */
-		memcpy((void *)unit_addr, __per_cpu_load, ai->static_size);
+		memcpy((void *)unit_addr, __per_cpu_start, ai->static_size);
 	}
 
 	/* we're ready, commit */
-- 
2.44.0


