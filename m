Return-Path: <linux-kernel+bounces-69706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697B3858D7E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 07:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20648282B1A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 06:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467EF1CF99;
	Sat, 17 Feb 2024 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PSM2Juy3"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E291CA9B
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708151150; cv=none; b=Mla8fRce7xxNNwlrKflqzeSHJ/TKIdBT1MCnIBfRxXUatkmqVYZOFMnQPiAOI+F0VMySw0gxud3vsoBxVlUxFdoMVCPRh14iqoYEFCjemI1kG8OApzTifKXid8bOvfbpv9tEuq/91WUO0Iz9RlQ0MzcqiSIplYFOP81F7e3HHUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708151150; c=relaxed/simple;
	bh=Y9GWQSNdeMe/TiCQJCjXENrVrfi7E3amSjOSWzM2S1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CLqZDkQxHoSbDZ9MKLPdcOT6RtZnBUbuDNN2ZCwTnVJngIV9ye4zgaAKVXN4BuCUO6iwGrlgLkZ6nZeaDASUr03rk8UXuijpvQdMwbpJkJ0UTeOzOFxdkyMShkc2zNjfCHXT6uYin2mFNxqTC8HM5v8E54vqtq/8NCMTRu0iGoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PSM2Juy3; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d3907ff128so2332574a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708151147; x=1708755947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2RXdELjA1+Y5TPLiUTm0d2mhfp+RAxxenDK5Rv9UCY=;
        b=PSM2Juy3NgnPRmxXplM3Wgy7959T+vLMrYBXBrlbGwTI4LRMympMzyf7Oba6Kxq+M0
         oLkEU/4veTGKHBrBNvnNeXue0AEP1spIBpvIvX+eYMlFgP3lCl//sJc5aUhqjeNGVwX4
         0IhOfT2NCGli2rJy/vCZS4aywrhoQOywPKfxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708151147; x=1708755947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2RXdELjA1+Y5TPLiUTm0d2mhfp+RAxxenDK5Rv9UCY=;
        b=JcQbU24FWWDKf1v24o8WBFSXKO7tMBI7ORFyfVsvsw2sjSL710+p116rW/VdZGZyRy
         cN+9I6dPK9nNkh+gKJ2Ix6eZyCwDcSGsrrScN6+uJRyPUadHg6G/BetWdd8LHST1txy4
         wAdZnmkfMv3WRH0A20YUHXJUIHYrbuLK/wiMNo5yCMPJhDXyEiRIGVsZdZBAu1zi1g5b
         Z4i7N20l41qeHdTkH8/L4EYq1vRcFm/v38aaXy02XmDmq6XrNfU2KeOhOdVMsUoJ84Aa
         ZqM8wtBmDeBY2/y7bS8UWd7rcXo9MRfu3jiVh8Pka/pqsrZmcY6gPqnJ/Rto2jUieRu5
         Aoyw==
X-Forwarded-Encrypted: i=1; AJvYcCV5UsqeHzS+IwB3G1hZYFjzO1uG9UwmFEuGtgpIVCksnWjHjy9GlybAMFNMoEHtqjd0a+TbLuHnGNmdzbCDsnNp6KcnYxRRfNizyDMH
X-Gm-Message-State: AOJu0YxkZ4Xh//1h4tu+WGwZKyj131op8F7pPDNGrsoYbTxm/9Os/n26
	Y2LWpe4zeaekdhrOvIbTuD1OWsLHAJIOFpdB4ej16z5faBpJUwwwz2G5oqa7xo9UgekTh4oLeVw
	=
X-Google-Smtp-Source: AGHT+IFmbsrgSelSyVzmXuB/u0yC3Rb3JZKRSRjPThoVTEFLQ9HMIMVjPwpT7DE29BVipx3A1VGplg==
X-Received: by 2002:a17:902:e80d:b0:1d9:427a:991 with SMTP id u13-20020a170902e80d00b001d9427a0991mr8385363plg.20.1708151147280;
        Fri, 16 Feb 2024 22:25:47 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mm11-20020a1709030a0b00b001db6da30331sm788247plb.86.2024.02.16.22.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 22:25:46 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	y0un9n132@gmail.com,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tony Battersby <tonyb@cybernetics.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] binfmt_elf: Leave a gap between .bss and brk
Date: Fri, 16 Feb 2024 22:25:44 -0800
Message-Id: <20240217062545.1631668-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217062035.work.493-kees@kernel.org>
References: <20240217062035.work.493-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1512; i=keescook@chromium.org;
 h=from:subject; bh=Y9GWQSNdeMe/TiCQJCjXENrVrfi7E3amSjOSWzM2S1o=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl0FFoSMLWKnRZV/Xpg3nYIyPCuv0NWoUMuFI3f
 ssQMNwOx8mJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdBRaAAKCRCJcvTf3G3A
 JvXFD/0ZGY+pv/RW0jEwUr/fOJKrMeYvRA+q8dAhwBU4yZf/9WvOK1OItaQt6erwqczIQcGDsKX
 RWFEhlQbXwgzOXrwCvEVU3X/MwTvOZFnZ0wTXOJZIuqX6uhvJuDZYq+kDfDixzSf+vvZ5N5gZBO
 TJzXBbBFV7TqO+okj4IS3xOJWZewgGjhNT8vbeQcPdzj69HDDkXXfpLkoSfygpZcWqlp9XDZiNy
 vXK3r7lesiRP3IhhoJj7l67XzCYktFTMcgxwx7uHCkePYddv5NSQpYuV1e3GrWYPneqbU/ta/RX
 cWwsnNmxh2abzRU47UKh05W/uYImIbey5l0CSZI/7QN6m152TAREIrmIXwl2k22fjZgwgd+Apv8
 4oW4U/bqzoG9w1PMnHKDMQ9jsdEQB9hjMCKn8XCd+7Gv1wyNPPDXV5RFfLYuFJeaPMBdmXP7zFy
 E345+0/LhEK6UZl9XBsjpHxXtro8hrLNXyQJNR0dzipAEXd7VeizjMBrL4dibLwpq9Vt5GEwcbV
 rdHrk6W8yGkeyTm7dflKIXZxINWwAC8JEcnyTOaMiaSf+7Trt7zTSHdjJwqs75llY8Q2hwdTTG3
 H4HQ8+CnaTwekWZMYV2AJy4oOxU2TWbO/56rrPwpm2xEE837qZM9Jz9EeaTLbA9t0NKKZotRk7n IeAJGDC3TTWSd+A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Currently the brk starts its randomization immediately after .bss,
which means there is a chance that when the random offset is 0, linear
overflows from .bss can reach into the brk area. Leave at least a single
page gap between .bss and brk (when it has not already been explicitly
relocated into the mmap range).

Reported-by: y0un9n132@gmail.com
Closes: https://lore.kernel.org/linux-hardening/CA+2EKTVLvc8hDZc+2Yhwmus=dzOUG5E4gV7ayCbu0MPJTZzWkw@mail.gmail.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 fs/binfmt_elf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 5397b552fbeb..7862962f7a85 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1262,6 +1262,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
 		    elf_ex->e_type == ET_DYN && !interpreter) {
 			mm->brk = mm->start_brk = ELF_ET_DYN_BASE;
+		} else {
+			/* Otherwise leave a gap between .bss and brk. */
+			mm->brk = mm->start_brk = mm->brk + PAGE_SIZE;
 		}
 
 		mm->brk = mm->start_brk = arch_randomize_brk(mm);
-- 
2.34.1


