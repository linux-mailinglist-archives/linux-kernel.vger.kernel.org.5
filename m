Return-Path: <linux-kernel+bounces-34485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F87B837CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D531C269F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0195A0F2;
	Tue, 23 Jan 2024 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dv/4wML5"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D0215A483
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969746; cv=none; b=Nw+P8+tLRq61ydbvY1QRYPLr9nhcyhUapIPTUtzEcuql4nDoYKZoTnhIlFpnKP/uVltkH0O2k5RvSKXKQjWg6Z4R9b7+DZwQuOz8PsOvOCi4710pVfFVC8hy4ZdqClbNzkypRrg/rYyT8jQSV/2IxkQZ1s0IK9TwLR158A5ABTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969746; c=relaxed/simple;
	bh=56np0SyxUjCTgMP+9tKKP1D3ChYs2w37QiPXxMh01j8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sVBRRbjpbP9ME6GnaC/f+CvcMq+hkYYXcM4Fgv4QSMfRRl6wrG58adUiNbMjCqyiGjic0ZE6DtSd/cZ1YdnZE9fvk969Pdx0aWeEZzPp7KWrCHZA9L6nlIih1Ubn5588bsrlIxceNZLpLM9lbNf5d3NL5vhqGkAZw6JdLRAG3qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Dv/4wML5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d6fbaaec91so30354655ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969745; x=1706574545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2wmo1vvNOov2EEiIOf/RbN5b/05Srikd0wbYgbK+ps=;
        b=Dv/4wML54fGsUrh04Xt3iEoknuhKBC6fH6haRIX2fKe/t5ZbZFDwU+8XRA7G6/OvAo
         yqIwZpF3+LdUvGMd7Us7ujFWJ3Xnend+uO3brm/dKyuTycwYSE0k++pRtrT+yyPp1BjO
         ggL0oxwaBdQxOW36+eZzIA2//ssI/XXI9UDeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969745; x=1706574545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2wmo1vvNOov2EEiIOf/RbN5b/05Srikd0wbYgbK+ps=;
        b=eVthnMY4UdlXTrLxgjWdtm7TUJVxvYJXqVAFNHE8dfvBHIBlFV9vLZqTxb7zFf+vqE
         cQkrwJDGgxww1UWr2wu1cpfMGLsep0Sguck4EFdLH0mrd/a2no/fdpOubKeMdJOsEdDL
         nOjRhNlJjg6kCxHM4SmfkWSyAXBWFHSPAnboY2FPOKPsVUPio1tymgynd2Luy+zupwMk
         BokjP5mXMQUun9qCojwRMH+iT/7twvgbiEb1qdwvR2X3DgtDZLctk0BJ19xdqw0ade0c
         q8qcHAF8fKG6eqodsN+Led6dlXFU2Q1CGbWmKDGprKwztqKJWZcZdbGpwZnWEuwdELAz
         L0sQ==
X-Gm-Message-State: AOJu0YxYIOAmNCoEdkSlmKzrYowe1EXKR6huesMdzTPSuxCVi/6KWCWv
	uPekQkz0z3Guf+HSvcjXTBOwTTlZ0dYHvCWi/Q9pS4uHW6SRvsk9WcBSojX5Gw==
X-Google-Smtp-Source: AGHT+IGG7bSIRs5hNa/qiAaeklkTYTEQimmy/waSXnO2AlAO5lkF1BydAnMo+sx+5Eh6BMzcdfFjIg==
X-Received: by 2002:a17:903:24d:b0:1d7:ae7:854 with SMTP id j13-20020a170903024d00b001d70ae70854mr6142733plh.127.1705969744870;
        Mon, 22 Jan 2024 16:29:04 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902d3c400b001d6f29c12f7sm7780642plb.135.2024.01.22.16.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:29:00 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 54/82] hpfs: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:29 -0800
Message-Id: <20240123002814.1396804-54-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821; i=keescook@chromium.org;
 h=from:subject; bh=56np0SyxUjCTgMP+9tKKP1D3ChYs2w37QiPXxMh01j8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgJNeBYHmccG3P4Um7r7rC1q7zY4IG1ilwQC
 7i8d6Fb8H6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICQAKCRCJcvTf3G3A
 JnqxD/4jJwT6D13eg4925zRy0AvUOgOehBe9WOd2FtYf+6bVVSdyEMjk90RP6WW4WsjI4hht0Ol
 BdSWyL3oTgr2ZAXh5YwVa82/Y+sf4kuijkik4GAbUTqi1BLIHtWDkSd4qF69MbAL6gqMtyV15lu
 wFL4M5BLZHqglughQKr7/pADyG2O1WB2zUNNlEYkJDrMip8nw5zPPfsOXV4ym75dff4zjiJT91U
 0vud2HVt+gkr5Qly4EosO5ixEPfR/r6cYZjqvai4nGnq40/Ob97pVDcA4+mzBrAVag2NMlHLnVQ
 Jgkkx1V/1PGHUEC7Qk8ax5o/8lCH92qV1AHbM4EVTtWBZgFWE/bi0Dp9I2lqIPNrvpjKkq45qq/
 Qn9ixqv3ShkNNVEUOEdRVc0mHG80mjA1KaPcFSjE3DZyGteYRvUJbCDAoqwVk47P5ruf8ZXZVmY
 lKiybeBY0mxvE4Hq2y/Ozd3u7ZRlrdiaGwUtrCv4tA9LpdCO4eqAQ6TFfdAb1JCMPdeWbt98xeZ
 fMqY48reU5uEP7W4SvEHEadhdzEnG+rNP3eXWpwK8SQFkwelNC2te384HJnc9B9/jP/U0m9JWBD
 KhDIRXBSMYc1RbWug7wZRLrFutl9+bDk84ozLU4+oD7wAs88uRWLLYXn2jqr5zx3PTCQg9/SDtv 78aI/3WraN+2U4A==
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
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/hpfs/alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hpfs/alloc.c b/fs/hpfs/alloc.c
index 66617b1557c6..e9c7cc6033b5 100644
--- a/fs/hpfs/alloc.c
+++ b/fs/hpfs/alloc.c
@@ -99,7 +99,7 @@ static int chk_if_allocated(struct super_block *s, secno sec, char *msg)
 	
 int hpfs_chk_sectors(struct super_block *s, secno start, int len, char *msg)
 {
-	if (start + len < start || start < 0x12 ||
+	if (add_would_overflow(start, len) || start < 0x12 ||
 	    start + len > hpfs_sb(s)->sb_fs_size) {
 	    	hpfs_error(s, "sector(s) '%s' badly placed at %08x", msg, start);
 		return 1;
-- 
2.34.1


