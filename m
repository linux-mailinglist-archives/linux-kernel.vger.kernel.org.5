Return-Path: <linux-kernel+bounces-101780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D2287AB85
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B631428ECDA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34D462814;
	Wed, 13 Mar 2024 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5M8AEvl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65D1627FF;
	Wed, 13 Mar 2024 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347608; cv=none; b=IaifTku2hU4ESqFgXAlW/YaCiTGu2EsTxbnNsnOJEJcBxAlc/Ru4FuU19j9fvPHs8gavN/DNcGq+WOeU2SUa3rs+0Sjd1YU9eZn2jzX3bNRSvdHcfd55WC61BPZSwc07suLROc4E5YBXIwepGpXS/iV1MuA2DaeYQz32FFmX8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347608; c=relaxed/simple;
	bh=3UekCyyDHThKiG9v+4KxnUS74Ovcmcs7JvlE63gLlaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ES+Tm2E8lfv/QPxAeV52Aqc9eG87HZnD9WZ5fgUegVJK94CVkjEoEstuVR4CR/J2oNIe2+fuTUsHQB3VuVDziCHwWU9PVPZmnKGpWDxpATxDYCFfP6wao/BGOX0gnz6rYqVuBK2WIq3t/SDwJVOt05uAgEmSQrKUqTPViXqhGr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5M8AEvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091D8C433F1;
	Wed, 13 Mar 2024 16:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347608;
	bh=3UekCyyDHThKiG9v+4KxnUS74Ovcmcs7JvlE63gLlaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f5M8AEvlCd6qcJgVf2cTMiscevbIC0ro1vyqtgoM50L5OIjeYztRDXQiDiyLPjJK1
	 Zu8MDEgXSOOI7V9Q6RvMOlCghpT/cJl73B2LBUBPa6bX7nMA+GuLpLs3f7PK/fbjgK
	 kAXkGfsu7HWpQ7LtdIliOgxtXYOjm/gubRuYNACCuvz7fn37MIcH0PGTubP1q2KZUl
	 bGsoDV00FSNQzXnqKwmYgbBtn8idzWKii3oq5Q5jXzYTnsz4gF66v3TDg3LdSRcLmi
	 kDWxocZprN0JY6w09pVb9vqvnkqIRg1A9R0EMY135SId88bjloqzOo4qAmaz90wJFP
	 GFQsxfieuTFTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lena Wang <lena.wang@mediatek.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 41/61] netfilter: nf_conntrack_h323: Add protection for bmp length out of range
Date: Wed, 13 Mar 2024 12:32:16 -0400
Message-ID: <20240313163236.613880-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
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


