Return-Path: <linux-kernel+bounces-116142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDCC88959F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B501F31FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140A118276D;
	Mon, 25 Mar 2024 03:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXPLzQd9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343AF17A90B;
	Sun, 24 Mar 2024 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323691; cv=none; b=NyfIUsqxS8rNwhIOy25dK3Lnw7XlNY9serFblhlaWiAi271ZZllTejw5Ik2YOLhQyd6hXR4NalsFLDC50eDJtG/7aaw/LZkAHKqQmxMVdRqa+YeiCGeqm7X0r37vA10myKq2b8fghfzsSzSlHr7FtxWUhU1pukc+t4buBhunRHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323691; c=relaxed/simple;
	bh=YcupNQxkyz3XG7lX4bTxXOqOKbkMCzLitxyZm3jArR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZAw9lY2P0CWp+dLyZD5sEcYxTS3BvleIHlVUCNGmh99rQgXiFnhqzv7nUfN0/S8O9SiYbak+6IpPJYb0MiHgmdsPUw6b5CmrpjgHdSLUrOP2Tebn2GVosu3l+D5yoOVRkVnnR5T6m+0o67d4QjOuvIvdSRzbwh60kQLgeK72wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXPLzQd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2C4C433C7;
	Sun, 24 Mar 2024 23:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323691;
	bh=YcupNQxkyz3XG7lX4bTxXOqOKbkMCzLitxyZm3jArR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UXPLzQd9y8CVXAcGmKPRjvH4HWrDFM+p4q6PM7AW8waEP6oJeRONTjdYsdOqzZb6s
	 8VC2Xhen91ZJ5Ler+k1stvqJMRF3WxFDl48ngC90+nZhNNPnj1r/qEOVxBz04x2Qv9
	 cYFWGj5W2Pq61jMvfWCxdI1N2T44KNNyxebzBe9xJ+Rcisira8JjmHKh6LbV8RYAS8
	 lUHgxu3ZPBuyJQ4eIE7KLfDNr1pdRCZEYkcQUl5O8xCKpl79Ef8RFbKkUtbVyrF8Xi
	 RGr3YLg1KDpOW3RmPKlZKgzKJM3nviconz3kChRimcbo5V5aPBD7M2usCqNrIjByU6
	 g0SifJOLVA5Lw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <kafai@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 063/238] bpf: Factor out bpf_spin_lock into helpers.
Date: Sun, 24 Mar 2024 19:37:31 -0400
Message-ID: <20240324234027.1354210-64-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit c1b3fed319d32a721d4b9c17afaeb430444ff773 ]

Move ____bpf_spin_lock/unlock into helpers to make it more clear
that quadruple underscore bpf_spin_lock/unlock are irqsave/restore variants.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Link: https://lore.kernel.org/bpf/20210715005417.78572-3-alexei.starovoitov@gmail.com
Stable-dep-of: 178c54666f9c ("bpf: Mark bpf_spin_{lock,unlock}() helpers with notrace correctly")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/helpers.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 0efe7c7bfe5e9..d758641973d6d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -278,13 +278,18 @@ static inline void __bpf_spin_unlock(struct bpf_spin_lock *lock)
 
 static DEFINE_PER_CPU(unsigned long, irqsave_flags);
 
-notrace BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
+static inline void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
 	__bpf_spin_lock(lock);
 	__this_cpu_write(irqsave_flags, flags);
+}
+
+notrace BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
+{
+	__bpf_spin_lock_irqsave(lock);
 	return 0;
 }
 
@@ -295,13 +300,18 @@ const struct bpf_func_proto bpf_spin_lock_proto = {
 	.arg1_type	= ARG_PTR_TO_SPIN_LOCK,
 };
 
-notrace BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
+static inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
 {
 	unsigned long flags;
 
 	flags = __this_cpu_read(irqsave_flags);
 	__bpf_spin_unlock(lock);
 	local_irq_restore(flags);
+}
+
+notrace BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
+{
+	__bpf_spin_unlock_irqrestore(lock);
 	return 0;
 }
 
@@ -322,9 +332,9 @@ void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 	else
 		lock = dst + map->spin_lock_off;
 	preempt_disable();
-	____bpf_spin_lock(lock);
+	__bpf_spin_lock_irqsave(lock);
 	copy_map_value(map, dst, src);
-	____bpf_spin_unlock(lock);
+	__bpf_spin_unlock_irqrestore(lock);
 	preempt_enable();
 }
 
-- 
2.43.0


