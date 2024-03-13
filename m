Return-Path: <linux-kernel+bounces-102196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E7987AF54
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C55028851F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE0A19D9FB;
	Wed, 13 Mar 2024 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot70AY7z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94BE19D9DE;
	Wed, 13 Mar 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349491; cv=none; b=UOn+ByRM21hEZyXZABmjVJrr/2o6Yk9cFaN0f+uXtZ+RoB0JpVZByC1FDN9t+yuJZlVP46xw2qIk2KkyGuWazLzAhbSp4odgq5cFz5ent3rS4XTu7q5mIVTgz2nWIG+gQ+pAFRZ7OGh3ZTcuWgR7bK7IiEW/YKTzddYqtMnEVhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349491; c=relaxed/simple;
	bh=i0GI5Yyj/+4SXUqciw/0zrOzu/dUyyzv7oxm8eamf0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAoO9qiIDTBY+0roKYkjCJhACFxmSbC1n4bbgoPs9kuTA3joZilHjmcHoskAVK/y4pYyOQimMI/BUz07hKQfwvLS4HjnndpWb7tQOi/MpjnHcPYRVfAS+e0UyEwO2YIwQ3urqRHTKO67sVTqWmdVPjR72O3/lNnwJdRLnrvGe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot70AY7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A74C433C7;
	Wed, 13 Mar 2024 17:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349490;
	bh=i0GI5Yyj/+4SXUqciw/0zrOzu/dUyyzv7oxm8eamf0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ot70AY7zVf0Y9vxxd/I90ny/g6jT+e5pZ01vf78cBJ+fifL7xbKcM+C1EE8SE4Aqh
	 Q0b7erbht0snrh3WHLb35KbrIZBJfKgfsvRyGI1ellxTVMW8jzGCtcCNmnRs96QUuT
	 qO2rfeawdf+2Juswctt+o+gHeWDxiqzCU5tppLBCO5uv4jhqX80Iw+qynULjlxf54+
	 QNNxHwNZNclT1BVwls2AcYHZZn/C+8tnoPE2mNWjz8f3c4LgbPrvqS42ooLA4mhnam
	 QXZhUh7Q2dRE/jjoWX9uLQPq6Ojelhj3LyyCyAOFRMPTvXQGocHYUYqJSZn5s44jGI
	 ZfrnU7uMhOTxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lena Wang <lena.wang@mediatek.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 11/41] netfilter: nf_conntrack_h323: Add protection for bmp length out of range
Date: Wed, 13 Mar 2024 13:04:05 -0400
Message-ID: <20240313170435.616724-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Lena Wang <lena.wang@mediatek.com>

[ Upstream commit 767146637efc528b5e3d31297df115e85a2fd362 ]

UBSAN load reports an exception of BRK#5515 SHIFT_ISSUE:Bitwise shifts
that are out of bounds for their data type.

vmlinux   get_bitmap(b=75) + 712
<net/netfilter/nf_conntrack_h323_asn1.c:0>
vmlinux   decode_seq(bs=0xFFFFFFD008037000, f=0xFFFFFFD008037018, level=134443100) + 1956
<net/netfilter/nf_conntrack_h323_asn1.c:592>
vmlinux   decode_choice(base=0xFFFFFFD0080370F0, level=23843636) + 1216
<net/netfilter/nf_conntrack_h323_asn1.c:814>
vmlinux   decode_seq(f=0xFFFFFFD0080371A8, level=134443500) + 812
<net/netfilter/nf_conntrack_h323_asn1.c:576>
vmlinux   decode_choice(base=0xFFFFFFD008037280, level=0) + 1216
<net/netfilter/nf_conntrack_h323_asn1.c:814>
vmlinux   DecodeRasMessage() + 304
<net/netfilter/nf_conntrack_h323_asn1.c:833>
vmlinux   ras_help() + 684
<net/netfilter/nf_conntrack_h323_main.c:1728>
vmlinux   nf_confirm() + 188
<net/netfilter/nf_conntrack_proto.c:137>

Due to abnormal data in skb->data, the extension bitmap length
exceeds 32 when decoding ras message then uses the length to make
a shift operation. It will change into negative after several loop.
UBSAN load could detect a negative shift as an undefined behaviour
and reports exception.
So we add the protection to avoid the length exceeding 32. Or else
it will return out of range error and stop decoding.

Fixes: 5e35941d9901 ("[NETFILTER]: Add H.323 conntrack/NAT helper")
Signed-off-by: Lena Wang <lena.wang@mediatek.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_h323_asn1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
index 4c2ef42e189cb..82dae553a5fc7 100644
--- a/net/netfilter/nf_conntrack_h323_asn1.c
+++ b/net/netfilter/nf_conntrack_h323_asn1.c
@@ -536,6 +536,8 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 	/* Get fields bitmap */
 	if (nf_h323_error_boundary(bs, 0, f->sz))
 		return H323_ERROR_BOUND;
+	if (f->sz > 32)
+		return H323_ERROR_RANGE;
 	bmp = get_bitmap(bs, f->sz);
 	if (base)
 		*(unsigned int *)base = bmp;
@@ -592,6 +594,8 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 	bmp2_len = get_bits(bs, 7) + 1;
 	if (nf_h323_error_boundary(bs, 0, bmp2_len))
 		return H323_ERROR_BOUND;
+	if (bmp2_len > 32)
+		return H323_ERROR_RANGE;
 	bmp2 = get_bitmap(bs, bmp2_len);
 	bmp |= bmp2 >> f->sz;
 	if (base)
-- 
2.43.0


