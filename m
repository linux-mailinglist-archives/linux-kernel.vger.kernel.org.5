Return-Path: <linux-kernel+bounces-66057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F80855606
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C6A1C283C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2442145352;
	Wed, 14 Feb 2024 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YrF1ny+C"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F162E629
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950052; cv=none; b=abdzzJ/0jGu8nlRtritZxvmui8RjY7fNmhR7QSk5Z4gs/80G7wY8C+/pIOzeSrMQUmnSEg0z3r12Mol0UgyQ6ObiyQ83+tFRxFfRrZcoj2/Ef1iipyOD2mEknaMruSbdZnJ7GksTpd08PfnQuLVE9FVLcGM8daSMXA57NM3JnI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950052; c=relaxed/simple;
	bh=leH3pMjjZZlhwesnoi+WanMfgfX5sx1qPhM1PONSqZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V2cETILpOOuznw1m1DaDXDcR2H0J23dCT/6gdn7DYneArrlnIZM8ifPLffui9isx8L/ByAoiqQDbLho9EeKDBK70FVu+7bg9Lq7B87cNh+POA2Bv801+hoYlR+SGqHCuMHDnxpC4SA/BCUAfGsMFeAR9GDqdwWQZYFvnNgjHcsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YrF1ny+C; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so328345276.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707950050; x=1708554850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ODLPgmrC2GnAqjAqHk0mi7EspXfDsuvboDPS66T9iTs=;
        b=YrF1ny+CtmOwFPVMMerAqymwxfndKW1ll0ksnnT9yFezpEgEFrB6p1IN5rvCV04Ycq
         1ESeisaVaG3Fs3h+YbEDiCTpqPi2f1AXLImHpBDH1iONH31YckW6kqnOWET6lKPkSig2
         ZlfOayTdwT2nVIJL5dT8mKRj9aqPTLHs0dSzRIfPNmEEAF4hz7pp60bW/X+ZxM8wM9+t
         06Iwc8Idy2T3FieeadJLFsVTtdzHj2mF21Np1pDf3k7v/i9rzGqPDhdERHwJLtUAteVN
         w+4+XGWotFR4zlKN1jDGnwjb269j32hiI5VUaJCDzD/qVwOnJReVrnb/eXf8PfQd+uYo
         2ACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707950050; x=1708554850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODLPgmrC2GnAqjAqHk0mi7EspXfDsuvboDPS66T9iTs=;
        b=ghvX/rMxD3JYpjLu3te131lro+kLRkkZlf3Z7AcmZoKAH84eta6iicqXU2WZx2GXXm
         9h0eJAEjMHJfurICQiJZekhnTwsnRzvn1BQ9fBR4dmkbpDhCBe6v5iuIKpVgm0NYmOy7
         FJkvd7sJRT6fV8oENNgcp4yAkZ4TD2cIxYdZ1aPrDTZQhJ7/iGryqncB39gS8wDAf5Me
         QztUv5uYcNfwPlaR0zjcggt8UqkkQJ/xdkagPqvwdXuAVDoQvBDBeQCwlRcGSFrFPpeH
         HVVx5IsYNtR5JvX/qH8idOEwgVpis0NBVO2bHZrMaWgtPsyapB33LBqBGPgQ6GrZEiiD
         +gGg==
X-Gm-Message-State: AOJu0YyowfRCdPPkZ5ORQoGNTL8II24DBWuksbnuawezQKhlZlCeFgeu
	b1KyBlIejFK6EcHnRgPmY84pr4dl+bhY1tpnUVwK1srzx4gvvfbq8qXep6z4BHwnOzSvNRr8ox1
	i2FXkJdv1dQM4rBGK79o2zBVCLTBoh3iZLXdgnHDnSZo7OjWSXWabxu0HbPeUaEdlL3ch3BQwTY
	Fo59cDCtbdM+QSBI6BgYuadoRAHSP1hpKxwu+CyE4mMxOAtkXLo/j4K2jmWGfTtknePFo=
X-Google-Smtp-Source: AGHT+IEdxuewwN8eca4ATiY9sKLns3Dxbq83VjZOnNMu8/lDGLoOd7qXkUWYU4F4N7m610kudwxHYWFgyVyvRObzuQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:e4bb:b13c:bc16:afe5])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:10c3:b0:dc6:ebd4:cca2 with
 SMTP id w3-20020a05690210c300b00dc6ebd4cca2mr97605ybu.11.1707950049630; Wed,
 14 Feb 2024 14:34:09 -0800 (PST)
Date: Wed, 14 Feb 2024 14:34:02 -0800
In-Reply-To: <20240214223405.1972973-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214223405.1972973-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214223405.1972973-2-almasrymina@google.com>
Subject: [PATCH net-next v8 1/2] net: introduce abstraction for network memory
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add the netmem_ref type, an abstraction for network memory.

To add support for new memory types to the net stack, we must first
abstract the current memory type. Currently parts of the net stack
use struct page directly:

- page_pool
- drivers
- skb_frag_t

Originally the plan was to reuse struct page* for the new memory types,
and to set the LSB on the page* to indicate it's not really a page.
However, for compiler type checking we need to introduce a new type.

netmem_ref is introduced to abstract the underlying memory type.
Currently it's a no-op abstraction that is always a struct page
underneath. In parallel there is an undergoing effort to add support
for devmem to the net stack:

https://lore.kernel.org/netdev/20231208005250.2910004-1-almasrymina@google.com/

netmem_ref can be pointers to different underlying memory types, and the
low bits are set to indicate the memory type. Helpers are provided
to convert netmem pointers to the underlying memory type (currently only
struct page). In the devmem series helpers are provided so that calling
code can use netmem without worrying about the underlying memory type
unless absolutely necessary.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v7:
- Fix netmem_ref kdoc.

v6:
- Applied Reviewed-by from Shakeel.

rfc v5:
- RFC due to merge window.
- Change to 'typedef unsigned long __bitwise netmem_ref;'
- Fixed commit message (Shakeel).
- Did not apply Shakeel's reviewed-by since the code changed
  significantly.

v4:
- use 'struct netmem;' instead of 'typedef void *__bitwise netmem_ref;'

  Using __bitwise with a non-integer type was wrong and triggered many
  patchwork bot errors/warnings.

  Using an integer type causes the compiler to warn when casting NULL to
  the integer type.

  Attempt to use an empty struct for our opaque network memory.

v3:

- Modify struct netmem from a union of struct page + new types to an opaque
  netmem_ref type.  I went with:

  +typedef void *__bitwise netmem_ref;

  rather than this that Jakub recommended:

  +typedef unsigned long __bitwise netmem_ref;

  Because with the latter the compiler issues warnings to cast NULL to
  netmem_ref. I hope that's ok.

- Add some function docs.

v2:

- Use container_of instead of a type cast (David).
---
 include/net/netmem.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 include/net/netmem.h

diff --git a/include/net/netmem.h b/include/net/netmem.h
new file mode 100644
index 000000000000..d8b810245c1d
--- /dev/null
+++ b/include/net/netmem.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ *	Network memory
+ *
+ *	Author:	Mina Almasry <almasrymina@google.com>
+ */
+
+#ifndef _NET_NETMEM_H
+#define _NET_NETMEM_H
+
+/**
+ * typedef netmem_ref - a nonexistent type marking a reference to generic
+ * network memory.
+ *
+ * A netmem_ref currently is always a reference to a struct page. This
+ * abstraction is introduced so support for new memory types can be added.
+ *
+ * Use the supplied helpers to obtain the underlying memory pointer and fields.
+ */
+typedef unsigned long __bitwise netmem_ref;
+
+/* This conversion fails (returns NULL) if the netmem_ref is not struct page
+ * backed.
+ *
+ * Currently struct page is the only possible netmem, and this helper never
+ * fails.
+ */
+static inline struct page *netmem_to_page(netmem_ref netmem)
+{
+	return (__force struct page *)netmem;
+}
+
+/* Converting from page to netmem is always safe, because a page can always be
+ * a netmem.
+ */
+static inline netmem_ref page_to_netmem(struct page *page)
+{
+	return (__force netmem_ref)page;
+}
+
+#endif /* _NET_NETMEM_H */
-- 
2.43.0.687.g38aa6559b0-goog


