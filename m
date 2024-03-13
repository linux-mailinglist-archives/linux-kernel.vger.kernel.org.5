Return-Path: <linux-kernel+bounces-101885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A559787AC6E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4398F1F2B5D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBDB7A71B;
	Wed, 13 Mar 2024 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6WgFEQG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE347A137;
	Wed, 13 Mar 2024 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348020; cv=none; b=tNNtxO3G+O+lnf1VJMYg0BJmbV9EKsyh2KqF+UWL6mqA43kn6SvH8caMLhhSHIwJN2+sDoyxG0KM9KBZBHffM6r4aVW9/qbGr2xYxYEj81XluBDmnIIxGEZFLgkTIyul/5vWggGufMNd19xzklMqgmzb8N6RyFOAWggkX2N31ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348020; c=relaxed/simple;
	bh=3UekCyyDHThKiG9v+4KxnUS74Ovcmcs7JvlE63gLlaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lR2GXls3qy0ZgFNppEyIMp14Wt/7dn5g2aO+S6RgaK5oWURVFfsLtAoUKodUXzY4BjHtbucAGhlBRgvMEi3ZPQCyBsYJhxaR5oZf9QTr2pER3ekyn2a4W6UvYfrd4tMGAbly+kuiOJXPAiITLeFAYlxLV2K2t94+ZWksHNWVkEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6WgFEQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD3EC43394;
	Wed, 13 Mar 2024 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348020;
	bh=3UekCyyDHThKiG9v+4KxnUS74Ovcmcs7JvlE63gLlaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6WgFEQGhA6jLvP0ldvrH7ilz5s8/3wnUE6l1jW5HCYTPTwp0m9qsILytAmJ/BJ7S
	 Auoxy31X9R8MAABfOVokKk5p8lA8IuuXHOj79Z1EkZ3Pfpurgq1iE/NlG3Pppkg8Z+
	 5dtApWZ/iZIgeJmTMI0A8lotjeW4JfURfuwU8LGXfw7KAuQNQ/qNX7fxAuA8vgQjhT
	 C53irg534iCnI4Cv2oijLyZ6pjnAZ3CWDkx4FZE3WzIlNXdqVHEdkX98FhlWuzdH7Y
	 rVZIcjCJF0aTd//KFAGqWBp8NJSwv3m2UbJ4Xnp45/ris4xD++zm9/MYd9HiaP1tah
	 5Y86k0t8zWwcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lena Wang <lena.wang@mediatek.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 17/71] netfilter: nf_conntrack_h323: Add protection for bmp length out of range
Date: Wed, 13 Mar 2024 12:39:03 -0400
Message-ID: <20240313163957.615276-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
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
index e697a824b0018..540d97715bd23 100644
--- a/net/netfilter/nf_conntrack_h323_asn1.c
+++ b/net/netfilter/nf_conntrack_h323_asn1.c
@@ -533,6 +533,8 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 	/* Get fields bitmap */
 	if (nf_h323_error_boundary(bs, 0, f->sz))
 		return H323_ERROR_BOUND;
+	if (f->sz > 32)
+		return H323_ERROR_RANGE;
 	bmp = get_bitmap(bs, f->sz);
 	if (base)
 		*(unsigned int *)base = bmp;
@@ -589,6 +591,8 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
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


