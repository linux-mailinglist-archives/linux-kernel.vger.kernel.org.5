Return-Path: <linux-kernel+bounces-113055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB2388811B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F44280C8D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F025814535C;
	Sun, 24 Mar 2024 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZTAye+F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367E14533E;
	Sun, 24 Mar 2024 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319864; cv=none; b=P/IsOhiZc8sOO96g/LpPFwYnRmzAIgUbQb3yvcS+6FFtfWtDgPF3afyK474IyVuJbM6ZpgMnsNZ9XkNsXZau9crDvutQyMadB3kg95navhlyhqegbI20DdRsKn8j3MsoyJ9XHk0CbIP7xzNbpKKe3UVICK3MZjYq2m/TdedJccA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319864; c=relaxed/simple;
	bh=uZTzWKQcsPV7yMNUkAApk1NzfA6xdSEQZjBPmeeK1cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWs65jjO8re06H13+fjWu+dsTOsvX+YMH8mTjvPWz7RpZkQjQQhjeC9jFq/z+YSJeZkldqTrmqlep63xddXJi7YRrMKzNxYyUrzvB2P3Q5BaMxgwAef8O4TJW3QuVXE+Il7VMHgz537eZ6W8flevMyrNzz591Gz4+YhFM9KJQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZTAye+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5ECC433C7;
	Sun, 24 Mar 2024 22:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319863;
	bh=uZTzWKQcsPV7yMNUkAApk1NzfA6xdSEQZjBPmeeK1cY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZTAye+FIEYc8WOjGO85crlkXyeS0xAbshohxmpfxCq++fteGbUCyNJw6HVtyP2ZW
	 /8r6SFQdmPY5x6d6jxpq7BfbjjOwSU2lRyTSNrcSdLTnYNla6CeUkV1sCYjIyQoAF+
	 kPpd2aN0Aav14O3feJv0cxlwSVoDc7LhxW53+dBqQkRYasP/PsvStzTQkp2+3HXM+A
	 o4PDEfOammlVYuF/+N4FsXvD95A5wUJ9TJUm35NOXCwXqR3piXbYsvAs5Lw5Yv/auy
	 JM9QND4uANgOgX0PQbi0cbR9x+TaQ1HQGuhVra3/L1sspunWvbW8cDTDvF0QwEcxmu
	 23gJzI8NVIqKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viktor Malik <vmalik@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 168/715] tools/resolve_btfids: Fix cross-compilation to non-host endianness
Date: Sun, 24 Mar 2024 18:25:47 -0400
Message-ID: <20240324223455.1342824-169-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Viktor Malik <vmalik@redhat.com>

[ Upstream commit 903fad4394666bc23975c93fb58f137ce64b5192 ]

The .BTF_ids section is pre-filled with zeroed BTF ID entries during the
build and afterwards patched by resolve_btfids with correct values.
Since resolve_btfids always writes in host-native endianness, it relies
on libelf to do the translation when the target ELF is cross-compiled to
a different endianness (this was introduced in commit 61e8aeda9398
("bpf: Fix libelf endian handling in resolv_btfids")).

Unfortunately, the translation will corrupt the flags fields of SET8
entries because these were written during vmlinux compilation and are in
the correct endianness already. This will lead to numerous selftests
failures such as:

    $ sudo ./test_verifier 502 502
    #502/p sleepable fentry accept FAIL
    Failed to load prog 'Invalid argument'!
    bpf_fentry_test1 is not sleepable
    verification time 34 usec
    stack depth 0
    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
    Summary: 0 PASSED, 0 SKIPPED, 1 FAILED

Since it's not possible to instruct libelf to translate just certain
values, let's manually bswap the flags (both global and entry flags) in
resolve_btfids when needed, so that libelf then translates everything
correctly.

Fixes: ef2c6f370a63 ("tools/resolve_btfids: Add support for 8-byte BTF sets")
Signed-off-by: Viktor Malik <vmalik@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/7b6bff690919555574ce0f13d2a5996cacf7bf69.1707223196.git.vmalik@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/resolve_btfids/main.c | 35 +++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 32634f00abba4..d9520cb826b31 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -90,6 +90,14 @@
 
 #define ADDR_CNT	100
 
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+# define ELFDATANATIVE	ELFDATA2LSB
+#elif __BYTE_ORDER == __BIG_ENDIAN
+# define ELFDATANATIVE	ELFDATA2MSB
+#else
+# error "Unknown machine endianness!"
+#endif
+
 struct btf_id {
 	struct rb_node	 rb_node;
 	char		*name;
@@ -117,6 +125,7 @@ struct object {
 		int		 idlist_shndx;
 		size_t		 strtabidx;
 		unsigned long	 idlist_addr;
+		int		 encoding;
 	} efile;
 
 	struct rb_root	sets;
@@ -320,6 +329,7 @@ static int elf_collect(struct object *obj)
 {
 	Elf_Scn *scn = NULL;
 	size_t shdrstrndx;
+	GElf_Ehdr ehdr;
 	int idx = 0;
 	Elf *elf;
 	int fd;
@@ -351,6 +361,13 @@ static int elf_collect(struct object *obj)
 		return -1;
 	}
 
+	if (gelf_getehdr(obj->efile.elf, &ehdr) == NULL) {
+		pr_err("FAILED cannot get ELF header: %s\n",
+			elf_errmsg(-1));
+		return -1;
+	}
+	obj->efile.encoding = ehdr.e_ident[EI_DATA];
+
 	/*
 	 * Scan all the elf sections and look for save data
 	 * from .BTF_ids section and symbols.
@@ -681,6 +698,24 @@ static int sets_patch(struct object *obj)
 			 */
 			BUILD_BUG_ON(set8->pairs != &set8->pairs[0].id);
 			qsort(set8->pairs, set8->cnt, sizeof(set8->pairs[0]), cmp_id);
+
+			/*
+			 * When ELF endianness does not match endianness of the
+			 * host, libelf will do the translation when updating
+			 * the ELF. This, however, corrupts SET8 flags which are
+			 * already in the target endianness. So, let's bswap
+			 * them to the host endianness and libelf will then
+			 * correctly translate everything.
+			 */
+			if (obj->efile.encoding != ELFDATANATIVE) {
+				int i;
+
+				set8->flags = bswap_32(set8->flags);
+				for (i = 0; i < set8->cnt; i++) {
+					set8->pairs[i].flags =
+						bswap_32(set8->pairs[i].flags);
+				}
+			}
 		}
 
 		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
-- 
2.43.0


