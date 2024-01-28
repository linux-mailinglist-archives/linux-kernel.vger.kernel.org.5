Return-Path: <linux-kernel+bounces-41871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7889383F907
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6EDDB2187C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBA22E652;
	Sun, 28 Jan 2024 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tIOrCohy"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A854A3C489;
	Sun, 28 Jan 2024 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706465195; cv=none; b=ExQTqC5SmOvz7VD6kPD+hDD2dP3p4ArqnhhLRvnqdUcN5rcS8eIAQdnwXBeBKEy1e9JB+BgdAFAp2ekpULRpSEZIA+b9/i4/djRhRMUW/NCjeWsMf31pnz3mpLLYxAvIOfhrM4aCprUic9FaKmuJ4Ra9GTCYG2bGtd43FAfsj5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706465195; c=relaxed/simple;
	bh=9SWqwkxkc7LbiSD5VD/OyNGtFRJ/bAopc0MZJ5DlSvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OLRvkszrCrbufH21xcuoXQT2UIn3kP+C7G+tSHjdHDgtaw4vGGfB+ik05oMhBGMHij5ZfWV7+/2v/AGZNLRfzQPypAofZB6nNOrbNU4NezlonhvhpRUZbu8uTzHULnKFI/QBsEpYeHKrE+n1/XYBGOzEO9VhmTi5YLIf3RebsXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tIOrCohy; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E5F83413CE;
	Sun, 28 Jan 2024 18:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706465185;
	bh=dLYNl6OEot/tkl0vnc26UAKkt+SMWAraqyc+cGDkzMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=tIOrCohyNvMGB/Xqa1hFx6N+xOZi4izO98fMk2/D1/9U/Wv+AXMuaLhHlxiF0x7x4
	 UYEuEsv4QiCaW/Vy+U00+80z9rbqssgy8+1neN7fe5975fWaNsOHHgunsSTwFiMKea
	 /I6PmGlncnhqJZfkLgN+T41qROW1YkM9GeA+KvYZjO5c1XRHlwG4AdegTN/Wb1Lngk
	 a0KGLvHHGwy/k9QaNOgfs6uqZqmBgqyMiN2x2NaHUdaYi4l5/bJvJpVzQ/k0+6FkcE
	 SCsIZCprhjCX5Ke/TQdxA0+nIeR3xAgJGoTTG+RD/LrSE4BPFoHEZKqr+dj0NTJmqg
	 61At2TvNAlroQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] dt-bindings: riscv: cpus: reg matches hart ID
Date: Sun, 28 Jan 2024 19:06:21 +0100
Message-ID: <20240128180621.85686-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a description to the CPU reg property to clarify that
the reg property must match the hart ID.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index f392e367d673..fa9da59d9316 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -74,6 +74,10 @@ properties:
       - riscv,sv57
       - riscv,none
 
+  reg:
+    description:
+      The hart ID of this CPU node.
+
   riscv,cbom-block-size:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.43.0


