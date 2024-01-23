Return-Path: <linux-kernel+bounces-34565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A688380A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A764B28C810
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ACD131E50;
	Tue, 23 Jan 2024 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l9fXPBfn"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4097C130E59
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971825; cv=none; b=Hb8Jq428Azx01/l+FH5o+hwGXrkqtmVzPuc9WoDI8NMLR70C7Q0IY9I1Z2OdLijUf6cjX9FtHUzshkEIyBCYWnJPrmEOCPZ99N9AO6njPXxm2mA1qrDur9OzQClk8FS1cGv2f9QeZPDzGwOdqqqzcpYF2+WECOGlAJVEhhDpui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971825; c=relaxed/simple;
	bh=IB2lfGkRCBtaWjh4efF33fJJqpbLbcQ8iv2Ec/oLFcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sK74cSZW5PwWQpOCL1lufHg4zdm3DlUg0vj3L62sUSsGT5jgjnDRLvqEBPfT1FcmOd8jD+N/501DGBB/vSQ6YoZ+XFAnerLtEgbOhjHyMO7TgiBH07PiiqkcjNcX5j4s0e2kpYjHEbFpQNElDANk0tTb5zfXu4G6qivGBitzwMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l9fXPBfn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d71e184695so13647745ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705971821; x=1706576621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0d2UaZGLqhx8u565YivlSqF+Wqiy035MOx60/jiYzQ=;
        b=l9fXPBfnUqu56eaKYrQLJp2b6t5jO7o4VFSr0IhM5u54VaAqvyOLNQlJdySAnchxbj
         j/hTsyTkxD/fg3o/ioOnBmokyHL8aLKhHD/njv3BOI4otixka1sAKq2t0N17sU+NShKI
         1JYFkxEoplYM3YpzRRldxq+tabf6v4KNCiB8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705971821; x=1706576621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0d2UaZGLqhx8u565YivlSqF+Wqiy035MOx60/jiYzQ=;
        b=J+G7KeLl1+xqGb91FpCHgAh8jwUc0rSDnCAjML6G3/PCoG/X+JR/HyP2/c6e1BGL+Y
         ernvayfcYwGe3HbHaAolj1TIX+h7Pwkt2HvVQM2Fmdp4LTQbhbyto/qxKUtH1U/4/chv
         m68RAiAIZ861Qm/t2f8Z9WL/F4BCBB1FSmfqB5eqlGYOVvNlMesygndYvVIQz8jIebs+
         V8UWdo6n9/nxTGxNXqRpaOp2jdb+abbbRFEG9pMVNMHJsARLLOtd34jTQbZkWBxl6/Z6
         NBaedRlPmmft7RGerIQZHk/YW5saOSq7+gmdcQMfxZyVYuliSSJOGyagxuduLQVvC+Ow
         Ry2w==
X-Gm-Message-State: AOJu0Yw2x/g7w4ivqaSUtBNQ79QQm/gNQrwiA+GMLCUsjRmtmBQ+XuHW
	u9GxfHx9H+/StEwOx50s+5i3f0ojt9Uelq88/+046J7so1Sb09M1m6FrIOklxw==
X-Google-Smtp-Source: AGHT+IHYE/R5XonXRWLS/O4LizE4LdUTB1VLzM4BkeSVTle2CM1WdJXziTFcWq98gVQnc9ulPPYiUg==
X-Received: by 2002:a17:902:c952:b0:1d7:5ff8:ca07 with SMTP id i18-20020a170902c95200b001d75ff8ca07mr1511463pla.0.1705971821597;
        Mon, 22 Jan 2024 17:03:41 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090302c200b001d707987ce3sm7538451plk.194.2024.01.22.17.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 17:03:38 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 37/82] aio: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:12 -0800
Message-Id: <20240123002814.1396804-37-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=keescook@chromium.org;
 h=from:subject; bh=IB2lfGkRCBtaWjh4efF33fJJqpbLbcQ8iv2Ec/oLFcg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgH+XJvl/2u5/B92EhxeYdENMTRs1wnkh1xr
 9hUH/VuXyeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBwAKCRCJcvTf3G3A
 Jtg8D/9Kz/EW1ykUt81CF9pL76dSizLWvhro5VLsT0USPihaAkiPFGlwrR5ADLawemjbfsHCbL0
 y2ajirjz/gpH+F9soxesI7UTKaOtXNfrDeLFYYBxCuKefSRjlhkjBdN240HgsAMOJQrh+pe04NH
 rTO/yRaleiNL0aZYSoZIvvEuMd1fzbVOXjXOgUh0vu+Hsv16H/4kN3dIXYmPovEduhXyTJgSGH7
 ZGIslfnnmesh92mCEWrYn3rhjzLPCv7bWGujt9QQB96dWFdoz0ZN/EfR4AFYJhm/imLkEdIXduQ
 MUxFoV0gzuwMa87PuOG2dpH+U9DcliEY4H3Mq5RBdZs6wlbGVibNjbvVFxT4IoxpoLZLqlqQjch
 ZtxRmzdY8tMH/ZVW/mgikzYQifvrHq68kXRbwuglv+ZT81x8yxOlYRrQkY7XksLYSZAGda4eq73
 L/JYedm444TLva1eDV9R9UubQ2witsDaqTjZE/59j4zQeKdcoRakQBVcJlqhLmv44lrrPDC66Iy
 hv89rogp1k5rLt4h3Ud8wIFgTl2Lz/z9UcUpYgMp9QRJgeWoBzQi1ZAOByDnDHwWLA7hx85V//T
 3h+sL/yM7HR9K0A8NbZnruLp3tTkSoBzDEfB/XuJZvBkjRz6hG2z4ymvzYJ99psA2daJt9WCF+a APviVXHgDVSXNAg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Benjamin LaHaise <bcrl@kvack.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-aio@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index bb2ff48991f3..edd19be3f4b1 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -796,7 +796,7 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 	/* limit the number of system wide aios */
 	spin_lock(&aio_nr_lock);
 	if (aio_nr + ctx->max_reqs > aio_max_nr ||
-	    aio_nr + ctx->max_reqs < aio_nr) {
+	    add_would_overflow(aio_nr, ctx->max_reqs)) {
 		spin_unlock(&aio_nr_lock);
 		err = -EAGAIN;
 		goto err_ctx;
-- 
2.34.1


