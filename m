Return-Path: <linux-kernel+bounces-124354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F440891625
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5EA1F22DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0872C53E08;
	Fri, 29 Mar 2024 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hrTEbWLx"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A760051028
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704859; cv=none; b=ncvsvmZVmaGCPzBGK/FshICV+mWpq/DPOrV7XkEmrcz3NifAHTSrlaTEV7SaF1PiOC5bgX1bLG1pk/I0vmGtFXd+mLMy0i8hi9ka3nKTEs+nw1eLre9j0wGeCfMGB2O88N2MDzWSxnLil0/45K5rMYugg7QDBRLW7qbUNvw4lOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704859; c=relaxed/simple;
	bh=KUC09wtYmay5oVx7+9C+OUpDt1KQS0U9lKvW1u+lUzg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mwjmX8HhaIMs7y8rhtnnJR2f/2TtGcNCBRFwS59Q708/cYUc03NBKzh2E0VqE3jK97ZDFrkU9CCit6IyOyexZ1U7N687XOHTldM/Xs4c9N3huYMgNoelxZ5OPdlKXd8IW/wWfqmYfHwyz362lA8TMAs2AaFSG5fT9qMLLR1RWXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hrTEbWLx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd041665bso34122257b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711704857; x=1712309657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dw09Gs88ogil/diQ6Vr0EqHQANsVVhIyP+7ZdKbyIx8=;
        b=hrTEbWLxtEqFbiUq7dXs2Ij2MbDHo9jxMNEXhcM33fZCV6SANtjf9/OdUyJt+HCk7B
         XOzjuQSEPLKUZTTMKuRQVNvH9lnmgJSzevBo1s1Pv/yheReNYz+rZyAsDaSh+mX3p/Lf
         +KMyvL8hmFqI8GLUScCj5UReuS95++Qs7OT0TRm+GHhB3zPqi75m0G0mG0rk+y84cmDT
         3NpmH45Mw9DvIb00R8jFVHuayV/HnsfjZ+c6TOAYiT+rfAYCnGDyg7c69djn5gOW5Y4g
         6RaRmY4GnYX1mqz6SipPYu7Bu6DhY3tJgSPg4u9i/NUXaviVU20Y8W5OCTDYOXWxsxIJ
         dx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704857; x=1712309657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dw09Gs88ogil/diQ6Vr0EqHQANsVVhIyP+7ZdKbyIx8=;
        b=d88OtSt3JnvG9yKX/dtrDIzHAu6e0+Rm6T4Z4bXiLMjjk86SZ2dbTP0nsMvSjVlOvf
         udj2eMHqCBeibNHnZ1n4iWFJQigghKBUMUI4j8HIWiDaauF/nhYfo3+Cvy0ADksGUm6x
         XZ8QPqpJxkVbzXhrIhGeVDNDzQ2Mfbbt/cis80j6U3M3stp8fUgt+fX5zRJzDy93XC70
         yyrD1g1JoxMxwq525VMMlWvTqXZ7CqJ2IkWS8npH8XbmWatoeijpLZy4XbBlwCu1eAL3
         WvALUMqTAM56ibEkEeVs1jy0HZngmXQCKmQ6D9EAmCrsXmLPOJFPgJz2N3moMPP8qbC/
         Zqjg==
X-Gm-Message-State: AOJu0Yy1GaPS9e/dok9eKIK5hcu36EkaTozZI03UvS9rHdlM7jF/okKn
	atSM1LpNS7wJaW2uWw7bLt41Hx3dCYEKHL/wfx7BB5E+whT/zbm8U7D4iR0cYS2OcMi8KgvjyM5
	HR6hqwEtnhPUEcE15xYleaTk+W7LGzNipz0YKYbjX5alu064xUpSP0I0hswlvBAuUzeY1E0aux1
	nzsdbfC1OoUI+dQoN45Tjw8RVTun2bRA==
X-Google-Smtp-Source: AGHT+IHww5cAwsi1pr9pBu+czX3UmFai9nj7XcxpaVhRpi1LgYQNcAUBxrSuXEicaf9NQtedota600ow
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a0d:dd03:0:b0:611:7573:72b9 with SMTP id
 g3-20020a0ddd03000000b00611757372b9mr538832ywe.5.1711704856741; Fri, 29 Mar
 2024 02:34:16 -0700 (PDT)
Date: Fri, 29 Mar 2024 10:34:00 +0100
In-Reply-To: <20240329093356.276289-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329093356.276289-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1581; i=ardb@kernel.org;
 h=from:subject; bh=q5UGicb35M6dvlAOCgO0axQESJYA1rUn+GPk9ZrI1w0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIY2tm2OlVN6iHxUr9jYWMgmymJk94z0V9u5k6qIdE5rSD
 26LOdPVUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbSb8fwPzp8VsaB3SU2Br47
 13TyqzMf+HazQXOCcIe1VeufXy6Jrxn+Cj68+VHg2BXetLa8nEmMt64kzV5teF7ibP27fVkbfDK XsQEA
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329093356.276289-8-ardb+git@google.com>
Subject: [PATCH 3/3] btf: Avoid weak external references
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

If the BTF code is enabled in the build configuration, the start/stop
BTF markers are guaranteed to exist in the final link but not during the
first linker pass.

Avoid GOT based relocations to these markers in the final executable by
providing preliminary definitions that will be used by the first linker
pass, and superseded by the actual definitions in the subsequent ones.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 2 ++
 kernel/bpf/btf.c                  | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e8449be62058..141bddb511ee 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -456,6 +456,8 @@
  * independent code.
  */
 #define PRELIMINARY_SYMBOL_DEFINITIONS					\
+	PROVIDE(__start_BTF = .);					\
+	PROVIDE(__stop_BTF = .);					\
 	PROVIDE(kallsyms_addresses = .);				\
 	PROVIDE(kallsyms_offsets = .);					\
 	PROVIDE(kallsyms_names = .);					\
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 90c4a32d89ff..46a56bf067a8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5642,8 +5642,8 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	return ERR_PTR(err);
 }
 
-extern char __weak __start_BTF[];
-extern char __weak __stop_BTF[];
+extern char __start_BTF[];
+extern char __stop_BTF[];
 extern struct btf *btf_vmlinux;
 
 #define BPF_MAP_TYPE(_id, _ops)
-- 
2.44.0.478.gd926399ef9-goog


