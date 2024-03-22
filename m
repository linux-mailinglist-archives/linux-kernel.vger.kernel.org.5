Return-Path: <linux-kernel+bounces-111148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A069C88685B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CC91F25632
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33CE1CA8F;
	Fri, 22 Mar 2024 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HbD1IvwZ"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79411BDD9;
	Fri, 22 Mar 2024 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096779; cv=none; b=ZJD+CQaEERVZMwnyFqMwcnhrTgXwIPCKbXOrhtncqX98lCASCqSkg12dkRXpeLFbUut2jNnegfLLNiA3J0HDX4CuSpl01DcaPeKWqvhXg3CIaNKunecpWNTab5YpC2P88oHMoGQpNKjsVTank4MLyOBKNn34t/zQvxcd1fr5s+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096779; c=relaxed/simple;
	bh=8qz9C1oFZqtOS8DKNo2scRc67XzoLfuI7Z79A8V/CMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DHok/06blzm4XFyFhYaVugFmrOgA3XI+NS/jkuWsMOSFzdalfbhE/PexyinIkjcW0qGCS72cQsV9UqNrvgIgiT5wxSi1YjxA+RMttbhIacaXtllDZ7snGSnJw566tmeK8cd6DUlfx8/x5RcujQ/0YfJqZZfz1jNgTSYuLyOdfXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=HbD1IvwZ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1711096379;
	bh=8qz9C1oFZqtOS8DKNo2scRc67XzoLfuI7Z79A8V/CMs=;
	h=From:Date:Subject:To:Cc:From;
	b=HbD1IvwZU+Fa0R5+dXd4Z5PtorJ9kamLlngsQfK0DXHSSogIt7EswCusDU8mv0oyu
	 gqqDARm5PcYZcx9Z9domjyy5fu4OkBPYPRXMiQGYGkAH09iF5Zmt2r4575I3D75+1k
	 CXlr7MqC0963vTRwAT9PxZIv7q23tpRMGhGycHOg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 22 Mar 2024 09:31:19 +0100
Subject: [PATCH] kbuild: disable pahole multithreading for reproducible
 builds
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240322-pahole-reprodicible-v1-1-3eaafb1842da@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIANZB/WUC/x3MSwqAMAxF0a1IxhZqrKJuRRz4eWpAbElBBHHvF
 odncO9DESqI1GUPKS6J4s+EIs9o3sdzg5ElmdiysyWzCePuDxhFUL/ILFOCZbTWwVV1U1Mqg2K
 V+7/2w/t+PO3FuGUAAAA=
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711096377; l=1459;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8qz9C1oFZqtOS8DKNo2scRc67XzoLfuI7Z79A8V/CMs=;
 b=+1w57nbzBpgRD+AXa4yunHz9+Ji2wjrUngukytktGDUCX3+WZfibC3N9MyodM4RVgH+F813g6
 SR22gH31hmICRM3DTrBN3/7Gg8xNO/qXW16Ne5R8f5pg+i+KcKkCtIy
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

A BTF type_id is a numeric identifier allocated by pahole through
libbpfd. Ids are incremented for each allocation.
Running pahole multithreaded makes the sequence of allocations
non-deterministic which also makes the type_id itself non-deterministic.
As the type_id end up in the binary this breaks reproducibility.

Therefore, if the kernel is built reproducibly as indicated by
KBUILD_BUILD_TIMESTAMP, disable threading in pahole.

Fixes: b4f72786429c ("scripts/pahole-flags.sh: Parse DWARF and generate BTF with multithreading.")
Fixes: 72d091846de9 ("kbuild: avoid too many execution of scripts/pahole-flags.sh")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/Makefile.btf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index 82377e470aed..2356929e62e4 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -10,7 +10,10 @@ endif
 
 pahole-flags-$(call test-ge, $(pahole-ver), 121)	+= --btf_gen_floats
 
+# threaded execution randomizes BTF type_id allocation, breaking reproducibility
+ifeq ($(KBUILD_BUILD_TIMESTAMP),)
 pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= -j
+endif
 
 pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
 

---
base-commit: 8e938e39866920ddc266898e6ae1fffc5c8f51aa
change-id: 20240322-pahole-reprodicible-02e904e45686

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


