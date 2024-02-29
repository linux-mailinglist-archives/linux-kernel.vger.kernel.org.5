Return-Path: <linux-kernel+bounces-87493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5294486D519
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4531C227DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CF51504E1;
	Thu, 29 Feb 2024 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYC6qSoA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949D315F149;
	Thu, 29 Feb 2024 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239257; cv=none; b=jEdRmgJpQ7O8uMZonTXTh+c2oCMS/YeKkrMfJwV8RaBZHmca66omG7V8xxmSXEnFCDM0Z3xtiH/eTkdrwcc5R/rbMES9GDGlYUIp1p1LAwvCZtUkTUynISS9vdrhUxMp4/zj5u6Mhi8CMyhMn1Dd4QoKw4pNWcVJDrNlLJBtP0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239257; c=relaxed/simple;
	bh=fCm23I8sefIMiHN4Ppc70lTcvGhr+Jve9juzMu0LdPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVyOBcHMXVnTLScA6EKoFWcMxvCpfX+0dEo/GH8wqjq5yjdjnyKmbRK4mERGy/nZ0BfPf9rJdIHm9GwaSe8ttTlr6zUOx/8FfIghhjbK/Eb+ewvipRbQkKMwVLPL/5wLYmypTfIR/OuvmSaoY0CHQMEu8DHATtIBRe0g8w4+eHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYC6qSoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27A5C43390;
	Thu, 29 Feb 2024 20:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239257;
	bh=fCm23I8sefIMiHN4Ppc70lTcvGhr+Jve9juzMu0LdPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RYC6qSoACVgp1rwOf0YXU0IIXXxDy62bFztx7Nos22X+kbLlHn3L32O83/8fiomta
	 +6JwLXtkgAOj3gQpmo2n1b9KWi9S+NlJBznFZHX5M3E6Orcfl6ZgMUtj1EqpqR9lIJ
	 3Kh+NUa9XAfODDhxRv8rRxXhyGN7uhpUlTVWonh51ifD7K52sTn/9E95dAF79tzjeH
	 KcvoxXP3xl68rs1djD9Wa2sNNKWwLRsHvy4eD3gY0ZVcMyTQ0VrzbbN6wj2Q89NJgh
	 PNwXT2LD2JuYPc9dlZBjwLHDtUgCIAV/0ZvyDx5EvlQZ1QPZJRvRVjd/CiAhZp0ubs
	 5zriKstLPD58Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	benve@cisco.com,
	satishkh@cisco.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 10/12] enic: Avoid false positive under FORTIFY_SOURCE
Date: Thu, 29 Feb 2024 15:40:32 -0500
Message-ID: <20240229204039.2861519-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204039.2861519-1-sashal@kernel.org>
References: <20240229204039.2861519-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.79
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 40b9385dd8e6a0515e1c9cd06a277483556b7286 ]

FORTIFY_SOURCE has been ignoring 0-sized destinations while the kernel
code base has been converted to flexible arrays. In order to enforce
the 0-sized destinations (e.g. with __counted_by), the remaining 0-sized
destinations need to be handled. Unfortunately, struct vic_provinfo
resists full conversion, as it contains a flexible array of flexible
arrays, which is only possible with the 0-sized fake flexible array.

Use unsafe_memcpy() to avoid future false positives under
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cisco/enic/vnic_vic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/vnic_vic.c b/drivers/net/ethernet/cisco/enic/vnic_vic.c
index 20fcb20b42ede..66b5778353389 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_vic.c
+++ b/drivers/net/ethernet/cisco/enic/vnic_vic.c
@@ -49,7 +49,8 @@ int vic_provinfo_add_tlv(struct vic_provinfo *vp, u16 type, u16 length,
 
 	tlv->type = htons(type);
 	tlv->length = htons(length);
-	memcpy(tlv->value, value, length);
+	unsafe_memcpy(tlv->value, value, length,
+		      /* Flexible array of flexible arrays */);
 
 	vp->num_tlvs = htonl(ntohl(vp->num_tlvs) + 1);
 	vp->length = htonl(ntohl(vp->length) +
-- 
2.43.0


