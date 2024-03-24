Return-Path: <linux-kernel+bounces-116259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A366889DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45EE1F36DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E513C66D9;
	Mon, 25 Mar 2024 03:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRThhl+y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F51448C0;
	Sun, 24 Mar 2024 23:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324047; cv=none; b=i/kqAogsrfZ2vbwafDVjyjzutGgfPjG2IpBBtlTv1qBaRmOxAtvEUydrc5qiiD53WPUISvHdvDDxCkG95Rd8IGKBT1v43QL5s/x5eQ7M3jdakg+60dOABKcgoOHEW6NwcIMBI/Ed+WfyGO3ssLzfbAhSWPax7zkCWvvC+wZ3bLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324047; c=relaxed/simple;
	bh=IU3AvUhoUKQzZLdgLjENwdVUYdXucV+7GjJRGg9khUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/fjMazHY8nAkVuXD4zRt5/kt2wrLVaIiD2KYue9BF9MQ40Dxo9gYzCZJeQ6T/yqzRtyrSu7ia7sDN3y0fPoPXFMwYxDSu1iiDbmLR2SN15XSQPDHKzQ7vbkVM1UpwKiIsjQT5IskBzgjZn2LP6vy/+SQNhgUylOUCCCuZcC/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRThhl+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B6FC433F1;
	Sun, 24 Mar 2024 23:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324047;
	bh=IU3AvUhoUKQzZLdgLjENwdVUYdXucV+7GjJRGg9khUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRThhl+y2c7McaFvsfydy3obMV4plB1DmDzL8X270aHKcxCHc83xwQnIg9K2U6fna
	 MUbaF70+L/eLOJu3Fe1AQIKklys+/8PBBlzOVC/w2Q8y0VOThSi4TTIyI5M8GigLvA
	 Hndh12omXL2dIlEzgHbyb2Hm6DA8WFNSO4ZeCHq+KV0Lx+sX5U+6OuOzUObwlNIvl8
	 YEss07I+vN6LvuB14xcoTCcbYMwfbbN5EcE/3XAyRReCyY4PG4FZahB5lO5hgt1fjo
	 NPf0k14KRMwD9XsbAOIhYip1huBHyVc75iklpN78C4n8ag4qz3mPJm5eNxfLKdd2vX
	 l25RRwmzB85Zg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <kafai@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 047/183] bpf: Factor out bpf_spin_lock into helpers.
Date: Sun, 24 Mar 2024 19:44:20 -0400
Message-ID: <20240324234638.1355609-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index a77d2814cac5d..4ba3dc621a345 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -262,13 +262,18 @@ static inline void __bpf_spin_unlock(struct bpf_spin_lock *lock)
 
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
 
@@ -279,13 +284,18 @@ const struct bpf_func_proto bpf_spin_lock_proto = {
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
 
@@ -306,9 +316,9 @@ void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
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


