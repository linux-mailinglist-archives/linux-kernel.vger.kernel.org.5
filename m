Return-Path: <linux-kernel+bounces-87448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C4C86D489
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270EC1C21AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3E0153503;
	Thu, 29 Feb 2024 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ymw3dy0N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DEA144056;
	Thu, 29 Feb 2024 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239082; cv=none; b=jnEKacVaWJwvgXUIgSc/Bfy9dblMp72D+GrSHgRu6ZD9cmceo4QxT2tVpXCXhWmeUq+rtIL8+j/h+ROpTTQdNT/YRELsIADuqpG7zHbA5Nwnd0caWv/vsXbapfFqLitwGy2gOiHsqhNIAuKopkKBoOaUZVfTa6cNTr5hPODzDIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239082; c=relaxed/simple;
	bh=fCm23I8sefIMiHN4Ppc70lTcvGhr+Jve9juzMu0LdPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLhRTj0rOD9dGoIy+up78KQtSoH9+5jGfppCzM68Rdiuh9gNl7Kj59CdCU95jy9jqUTycCAqpxk8NVeSaCDh/y6F7YrKbV9B0XrSzUA5O4luhCwv/rmuJVuCUgOK08vvw1QWT1yHTgTtnkBRhQV5eFIl6R9jZhHalNDZXqS9WRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ymw3dy0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4008BC43394;
	Thu, 29 Feb 2024 20:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239081;
	bh=fCm23I8sefIMiHN4Ppc70lTcvGhr+Jve9juzMu0LdPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ymw3dy0NZQxGLBCzNXPfHQ+pdhmosVMpsiDCORPutbSpu+ERHxNtjgQzw/bNmHCQu
	 nPZiVWOPH9V3tgfwDkmM9UH0bHGPxblh2nqck6nvGZXiJVFyjoGQGdTuk64XYqYHfk
	 ukam37+gS720FQHbKMls+l+p15fo2jwCQDhC9dnlv7l+C6T49u6MA/e5DfNLeYPLWi
	 PhSzuBdJMv+0VangPBibKq1VWb+NYfuXSXDgSJoCJl/Mme6xWBjRA1BISKJCMyityv
	 MevSVOPnjbDHnSuWfAd/TniayamqPOzil39mvdgn+2fnRWcwJWhXWfOPzj/MvTFRAR
	 vH60b+Sly3QzQ==
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
Subject: [PATCH AUTOSEL 6.7 15/24] enic: Avoid false positive under FORTIFY_SOURCE
Date: Thu, 29 Feb 2024 15:36:55 -0500
Message-ID: <20240229203729.2860356-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203729.2860356-1-sashal@kernel.org>
References: <20240229203729.2860356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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


