Return-Path: <linux-kernel+bounces-116260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C561889DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9ED32978A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166EC1802AD;
	Mon, 25 Mar 2024 03:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmQH2G0I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E056B2892DD;
	Sun, 24 Mar 2024 23:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324047; cv=none; b=st1uG4EIw4QDVMo/qbTl9czXIa7VEcFOYcfUtyH2b0dKuYp3hCr6SJZt0njKGuUr4WFffh/O6Uu5kGo2P4OFyl6uOxPWxMXWN8og4D3yU6QYsbocoGykEJk4bzHFebF+oCGlPK7p0Qhd+tYrE90a5OFUIkuKLoR7Md4JmsJeHfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324047; c=relaxed/simple;
	bh=E8FWAA6NlShkdP33sFC7FYILvWHw11jVzhdp93WUky8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQ7it6enSywMVEovqW2QrH53surOUFQGHV2ZvaObLVRCIsf/TxeNAkVWnFZ7HZLB+0EURPqk2P0YLtlNPGK57dmm8XtnBjELrWjsjIZ2/Pv3WDGxfgjHgSCx8BxXa3+oZzd9N/KlTj7HotwXttkjngVJxza0LEemnRCzIKGBSIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmQH2G0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA5FC43399;
	Sun, 24 Mar 2024 23:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324045;
	bh=E8FWAA6NlShkdP33sFC7FYILvWHw11jVzhdp93WUky8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EmQH2G0IYj4cpqHqlmGpwNsE+obwQjIPNPX1ZEEonor8Mnym9XklAUqqnZVFZYkFe
	 qgoPs1bi0IO7hHaw0yDelTlsplrCAtiE9KzQO73NhCFv8AxEjNcLLSntCzxrHjF5EI
	 FjC7UqxIP0vtmdG/t9lydMwFXAx5n3WcgmAplWwn8ovt37aAnCakiEHfKdVsebksmg
	 BVKrpWm/9VM/UrX97Y0G9dP2DssdaUAdoOOyURjzktelw9KmUv4ADiLI9NuAMsILGD
	 qJQCkAJchfAHnZX+r5/JkIKB+RBH0cnncWfI4vhKVLZP3hieBcy8SPiFpKU6X/wThg
	 BbE85hSJTOgIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andriin@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <kafai@fb.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 046/183] bpf: Add typecast to bpf helpers to help BTF generation
Date: Sun, 24 Mar 2024 19:44:19 -0400
Message-ID: <20240324234638.1355609-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit 7c6a469e3416fa23568c2395a3faa7dd6e376dcb ]

When pahole converts dwarf to btf it emits only used types.
Wrap existing bpf helper functions into typedef and use it in
typecast to make gcc emits this type into dwarf.
Then pahole will convert it to btf.
The "btf_#name_of_helper" types will be used to figure out
types of arguments of bpf helpers.
The generated code before and after is the same.
Only dwarf and btf sections are different.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Link: https://lore.kernel.org/bpf/20191016032505.2089704-3-ast@kernel.org
Stable-dep-of: 178c54666f9c ("bpf: Mark bpf_spin_{lock,unlock}() helpers with notrace correctly")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/filter.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 440014875acf4..11407e9e606db 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -479,10 +479,11 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 #define BPF_CALL_x(x, name, ...)					       \
 	static __always_inline						       \
 	u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__));   \
+	typedef u64 (*btf_##name)(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__)); \
 	u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));	       \
 	u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))	       \
 	{								       \
-		return ____##name(__BPF_MAP(x,__BPF_CAST,__BPF_N,__VA_ARGS__));\
+		return ((btf_##name)____##name)(__BPF_MAP(x,__BPF_CAST,__BPF_N,__VA_ARGS__));\
 	}								       \
 	static __always_inline						       \
 	u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__))
-- 
2.43.0


