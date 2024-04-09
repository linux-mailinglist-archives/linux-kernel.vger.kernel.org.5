Return-Path: <linux-kernel+bounces-137148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063C589DD97
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6F2283AD5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0553E1327E1;
	Tue,  9 Apr 2024 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UhTwoZRp"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E6812D1F9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674904; cv=none; b=MKhhkcIQf/AoE+QRbh7Q6BzoVKnR5tUBDKxQhYf4C/OrmENQ2hjHIYwxuwRMiyGBbAgIK8Z5pKe73NvJhB3SbeqIZ9D39C2IixBeh4YdX7r6P0x02NbxivIY4n1JALvId9cX4hUCv/xrH4c4xiVPuvUamQn5SIXz/izIIk4h7UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674904; c=relaxed/simple;
	bh=alFFKiP7O8OXDXrwrinQEc5sBVduOBPmxmITpEnO00Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ovlmx9/FP1sObf4BGN5VQydGNePQFuQ4fqyeMz5nVTgMCEg0gghAJ7AxDBRzPyRM5O5BqQ44uYH5tCbZoQjdEkg//wS6bDnds5OBiVGQCggGB/0ubb6HU1Boqm/Iif3/GAFJyXbv14D+aji3ExlQZJBRSsXGBr7PZA/zBeCAbMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UhTwoZRp; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-343e775c794so2210024f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712674901; x=1713279701; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tfocfhDuzyWI0gzZPzgtgcqFin70HaxvYji+27WTX8o=;
        b=UhTwoZRpeaog1bL/00Z31rdHgQskb54bR29OKFOMS3A1f2r8V/JnPt6XPVqAMjPliv
         TR59xE7jiUgU5peoihUXX2EdQGBSEiwXKOtauLMoBafOB+hVUmGzXiQI1CtdpqFq1lHK
         f6JMf6FCHiM4XJiGfDEGYmGlL6txwo9t2ZlBKK3DPHmuLJzlScj2mM0Q0wQ6wlPJL6yT
         3GraD+DposwSJnG3Dx6Lmhq95EAGZ4iLTImAJQIP5PZGs03utkRvty9Gmw2HP4fvrp10
         oEqTqrUIibqyw/RNxgpioyLunLf9bsexuDHuFuNQLhZh0eMx8bRSNg2rRwstuqNpRH1i
         4rMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712674901; x=1713279701;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfocfhDuzyWI0gzZPzgtgcqFin70HaxvYji+27WTX8o=;
        b=bWCgNC6AH7Z8zC9IJ5JqHtal2UG/b3sS5j2KsllrwuvilkLl+tk+yXKZh+9TKjOb+W
         WaaZKfyXKOq5C88JvsVNBxQEo+KAbtDAPC1nckRIS73Y4kus8X5FxHkRu492dkCAN7mV
         v5Ave3YW1OSL+3ebqAGy/2dKjZE+evK50GagaLZNigDbtnH5ujCx5MCsU/o84ANNrsPW
         OrIR4L+Sboahs/X7B4c31GQRXGHjbgpoVSCfcYEeKBIk7d7YPoX0k5MO2uU2hgt31X0g
         IIXlc5kMjkVHi5fBDnmcLLPRNEdcEIMDkqrjGpRlkQ+jM+WchbA8i2trNLvINICiuGH9
         0iqQ==
X-Gm-Message-State: AOJu0Yy/8W1j2KaixArpvniL95oJ5/XH11k4GL1fYiaJ3Cj5I8Cct92b
	zL5LBBIepP2W/YuUoprW5SmSEJVo/Z/XKa2+TibE8IdSt5iVOGcqYZezrZaiSXSymbXWC82pxdl
	SixH6fWFhz2ufhxG/pNPwuwIqCKYfxW6p7ZwfG4MN17NgHHsA6aDWCeJWVSvK+MqajidhUXjWHr
	rHDTi945baw5SgINTIfnCXdRjb+kV4GA==
X-Google-Smtp-Source: AGHT+IFYuevMhVCNS8J4a0W+Y4P/tX4ObfbT6n8GZHMYJQGV+TZpStj+eAbIHkNNPAqkAizanpcTzDes
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:fcd0:0:b0:343:3f5b:8be5 with SMTP id
 f16-20020adffcd0000000b003433f5b8be5mr25778wrs.5.1712674900036; Tue, 09 Apr
 2024 08:01:40 -0700 (PDT)
Date: Tue,  9 Apr 2024 17:01:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943; i=ardb@kernel.org;
 h=from:subject; bh=vvI7uP53jbbpjHBqTcIzGIhjjZ2G0+4ci+o39TUrohg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU00wkfJaMX8/7u/nL26uVyuuT46dDI7j0x7Ta/W0beLi
 zK9y9w6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwESS9jP8L0m8H9OefeJLbG/7
 hGtcCW9eBda5aPCvW5W/wpw9al/8R0aG+zYX6vKnHOW6oeDcYh3n9k9mXqGwfnv4p0ifvsL85FN MAA==
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409150132.4097042-5-ardb+git@google.com>
Subject: [PATCH v2 0/3] kbuild: Avoid weak external linkage where possible
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Weak external linkage is intended for cases where a symbol reference
can remain unsatisfied in the final link. Taking the address of such a
symbol should yield NULL if the reference was not satisfied.

Given that ordinary RIP or PC relative references cannot produce NULL,
some kind of indirection is always needed in such cases, and in position
independent code, this results in a GOT entry. In ordinary code, it is
arch specific but amounts to the same thing.

While unavoidable in some cases, weak references are currently also used
to declare symbols that are always defined in the final link, but not in
the first linker pass. This means we end up with worse codegen for no
good reason. So let's clean this up, by providing preliminary
definitions that are only used as a fallback.

Changes since v1:
- update second occurrence of BTF start/end markers
- drop NULL check of __start_BTF[] which is no longer meaningful
- avoid the preliminary BTF symbols if CONFIG_DEBUG_INFO_BTF is not set
- add Andrii's ack to patch #3
- patches #1 and #2 unchanged

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>

Ard Biesheuvel (3):
  kallsyms: Avoid weak references for kallsyms symbols
  vmlinux: Avoid weak reference to notes section
  btf: Avoid weak external references

 include/asm-generic/vmlinux.lds.h | 28 ++++++++++++++++++
 kernel/bpf/btf.c                  |  4 +--
 kernel/bpf/sysfs_btf.c            |  6 ++--
 kernel/kallsyms.c                 |  6 ----
 kernel/kallsyms_internal.h        | 30 ++++++++------------
 kernel/ksysfs.c                   |  4 +--
 lib/buildid.c                     |  4 +--
 7 files changed, 49 insertions(+), 33 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


