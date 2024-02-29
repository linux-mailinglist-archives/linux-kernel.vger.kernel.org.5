Return-Path: <linux-kernel+bounces-87473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CBC86D4D7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC1CDB23DDE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2634815FE02;
	Thu, 29 Feb 2024 20:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhXeDgqZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6284815E5C8;
	Thu, 29 Feb 2024 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239205; cv=none; b=M1f3Yb3COcP4phJy3FqVeyJkg57sxkqr7VMvj4sC3i1ff8t/PPWPqeiN69JgR+ykZOujl4plCioOmCYtukfF0drSI8Fiyh7C4ptBCFTqSMoiQo1R8M2cHWUPWHECRyhaXL5g8or2d+SXNoFMJz8U5tqDTDEF1T7ZCLbARgQxZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239205; c=relaxed/simple;
	bh=fCm23I8sefIMiHN4Ppc70lTcvGhr+Jve9juzMu0LdPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxNNvzNsTqf++BTUgkXkloP9MO6vU408rqnXDWdVeoJciHtw0xfjD21BYDSBLYM4xTsHzOuiyAT0lcDy5+xho7qjcLEl94qKahEPXGRUcbBVjoq40x9VeybH0yS+NaunLRPKCpZ0aP8CA3qQcvpFQzImSCa8Zou+RsGs5/qNuqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhXeDgqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49A5C43390;
	Thu, 29 Feb 2024 20:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239205;
	bh=fCm23I8sefIMiHN4Ppc70lTcvGhr+Jve9juzMu0LdPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhXeDgqZrDG1FgPFqB7wQGS97FGvfjXqahbYCCPzzkwi5nYnBupCX2RR2STnhi8is
	 2tARzWwCxJluVEanedovVOF7gEZurogRfeCZcq13Ed80MjJNyBBv83jBtsGhBuF3qS
	 s1xfOTNSuA5LofqbXLI8YiwekIffQ1hk4nfeG0gwkg+Sv1go+nIi/7f/wMrb8OxfLW
	 FHhZSsxK0UH7h3STfEAu9SwNU/pgv/reXzr+GMdGpXSbapSe14dQvmcV1/gKWnRTl2
	 CCPJDxVWuwEoRCU3RhdaNVhHFeKUGj0HAgowJL1rG1sjzr+TSyDjAJYP7sOlEYh8kV
	 3FHUXmdm6Irrg==
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
Subject: [PATCH AUTOSEL 6.6 14/22] enic: Avoid false positive under FORTIFY_SOURCE
Date: Thu, 29 Feb 2024 15:39:07 -0500
Message-ID: <20240229203933.2861006-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203933.2861006-1-sashal@kernel.org>
References: <20240229203933.2861006-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
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


