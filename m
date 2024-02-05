Return-Path: <linux-kernel+bounces-52898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7303E849DFD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3065C28824E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351642D604;
	Mon,  5 Feb 2024 15:24:45 +0000 (UTC)
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872022C85C;
	Mon,  5 Feb 2024 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.38.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146684; cv=none; b=pB1/9jwwVUJSQOVdP/a1k3KaBKRCWgn9xY4AEPwb2/+tGPBjMGXUyzuxOmc83KiQVtwjyOFa03lH0fbyxM8rEKf0xhBMR8L889cyKY3HgCOdrnNNdqTrtEC/dC5QQ2CiKzZ3p8FonCq3IiuH0OEPGwyPh3KnFC3plPd/TpKOpys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146684; c=relaxed/simple;
	bh=fEE6msD4XdTRoTXofN5+urjqqiYv6m5CX0D62N32MYg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FJ5uaGIeU2pE3AzMKIaFv+wOO2xo6PWun6BRqq6/rPhmvgdT5Mb38yZAzEwwX9d/EmeYQWJ05rSe9f/8q+Mvf2j+G3onwultatKSfsDR7+/vnbq6aiTEABRDaUiIzPvK15LDJeNBzQgGPtGz1PjSxNl7DdGQDEFjMQhL/6IJkJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=217.74.38.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id 2E9C31865695;
	Mon,  5 Feb 2024 18:24:31 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id VQTBXYzT9CdU; Mon,  5 Feb 2024 18:24:30 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id CC8F1186563B;
	Mon,  5 Feb 2024 18:24:30 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kfOHWGwef5L5; Mon,  5 Feb 2024 18:24:30 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.58])
	by mail.astralinux.ru (Postfix) with ESMTPSA id 1C40A18639A5;
	Mon,  5 Feb 2024 18:24:30 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Kamil Debski <k.debski@samsung.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] media: coda: cast an operand of multiplication to a larger type
Date: Mon,  5 Feb 2024 18:23:50 +0300
Message-Id: <20240205152350.22547-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If width and height are 0xffff (or close), the result of
multiplication overflow. Add casting to a larger type
to avoid undefined behavior.

Such values are possible in CODA7, but unlikely.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 918c66fd4126 ("[media] coda: add CODA7541 decoding support")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 drivers/media/platform/chips-media/coda/coda-bit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/coda/coda-bit.c b/drivers=
/media/platform/chips-media/coda/coda-bit.c
index ed47d5bd8d61..84ded154adfe 100644
--- a/drivers/media/platform/chips-media/coda/coda-bit.c
+++ b/drivers/media/platform/chips-media/coda/coda-bit.c
@@ -585,7 +585,7 @@ static int coda_alloc_context_buffers(struct coda_ctx=
 *ctx,
=20
 	if (!ctx->slicebuf.vaddr && q_data->fourcc =3D=3D V4L2_PIX_FMT_H264) {
 		/* worst case slice size */
-		size =3D (DIV_ROUND_UP(q_data->rect.width, 16) *
+		size =3D (unsigned long)(DIV_ROUND_UP(q_data->rect.width, 16) *
 			DIV_ROUND_UP(q_data->rect.height, 16)) * 3200 / 8 + 512;
 		ret =3D coda_alloc_context_buf(ctx, &ctx->slicebuf, size,
 					     "slicebuf");
--=20
2.30.2


