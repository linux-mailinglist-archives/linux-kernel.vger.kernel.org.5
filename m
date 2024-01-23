Return-Path: <linux-kernel+bounces-34563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B018183809F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5289E1F2CDC0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8D6131729;
	Tue, 23 Jan 2024 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="liWP+5dR"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF61130E38
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971822; cv=none; b=c1XGQyzT6NLxJ2/VJKjQKSqYN3YMdPef/1Dohzpkmo/1K/qo5BJkMO/cML/KiJgxnEn5O/KfZamSrAbDLxCuttfdmUjgNuW6RtzGMJ+XqyEETKv/NW1eviQvBD/770evCV9O/27gaDdZmfS9SQOliLKjL+RYI3gY09npC3K3m80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971822; c=relaxed/simple;
	bh=rpDQeHt+rynn8n8QexVW4diSx8zR3w05Bt9ydWpzlak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NNbukgUWPmnAYYQahhlpgfNNsFehjjpiBtWsVfSyDAIIFl4ymaeWurEOEqULJNWTFfFoeLQFiM4clyPdClZ7Gx2qiywaEtrAUviu0fQcbca+hYuh+0U8NRrL1K593annx41purIcDL8uBQsAq5Bihqs/FZhWMPcTmR67NJkobtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=liWP+5dR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d71e184695so13647555ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705971819; x=1706576619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F152weUja9q4FQGMmlJGHPEDrqtjtzarPMH5qP0DvDA=;
        b=liWP+5dRu8mO1SL29LCzZQQncVwPybA2VRxCtasMgDIqtS3s99IzA/Okw5U2YKq7kC
         PY4UFynIz+BHDFIGmdFfJIhIfmHSo1HTZhIXt08DkEySulhZyNahwJTamAdYzfbVTE5q
         TyF08JsUXY4JEBkn7Ee603UteVcnHqceGadYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705971819; x=1706576619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F152weUja9q4FQGMmlJGHPEDrqtjtzarPMH5qP0DvDA=;
        b=iWQ2gJ6GAngnI+vNbi9sQ3KuDjZGS6wlXQ0K/vfh0Fv/O2d5NpwhifETMN4zBCf1hZ
         0ObxsBAnQE/Wiilz7a5wXIv6WQVvb3O1j/PIL2nmSammrOeijckt+lolu3jTnURian38
         SwGkC9x8g7DmifeBNJcPxZ2uTlnyFhyhu3leQvjQxeXGkAk6tbumQnNn+053bjGi2Ltr
         qhxFFmYu74A8A80Zc0q3P0ruPik0uT5j9XbgVXxTo4ruRylp2FVJex65dPykcdkSeGV1
         NEIozXuKLi4yyKIaUMKTP2+k0+TnIkpm9r7XTHgslZEJa3AC1DGGnMnNccw+rcip992L
         RSdg==
X-Gm-Message-State: AOJu0YySYlgVFnzNws6Rjw6Rc/Fgk9SjfUncST/y2vUIT5WqZPChpTdz
	hyDXbeyh23uFjF1bi/kjrATuJdYdYoyp6OICuzQWTpS0u62/9kNqeEBOKpmITQ==
X-Google-Smtp-Source: AGHT+IHKrMC4R4tlkBB0HVPBTYWpwu5nmSinWUOiPDQnbcd6H4zLw6As+CREnzYMfD/v5y6s7fSv2g==
X-Received: by 2002:a17:902:e5c8:b0:1d7:3563:88ef with SMTP id u8-20020a170902e5c800b001d7356388efmr2226123plf.99.1705971819267;
        Mon, 22 Jan 2024 17:03:39 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kq5-20020a170903284500b001d72df6edbfsm4407615plb.64.2024.01.22.17.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 17:03:38 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 44/82] btrfs: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:19 -0800
Message-Id: <20240123002814.1396804-44-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1822; i=keescook@chromium.org;
 h=from:subject; bh=rpDQeHt+rynn8n8QexVW4diSx8zR3w05Bt9ydWpzlak=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgIF3SUyZAUAUFUZymlnGYgNXvads8gEltU4
 lCweHT05OmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICAAKCRCJcvTf3G3A
 JoRpD/0eSwV1znH/V5v1Xfpt67/pUkb05v3F8q48Cf6//F/42CAYj23Ytdmx0cfwpXGt+VFMkbv
 zRJF9MjrXB4r3591E/RSQF1lHCS+Hg5gB4UJwMDNntlDeXgFlFBsmC1rh4swgRH1/63HU+ULvzH
 jSPbL4G7LX1fk61Q43I3EIuXOD9Pu3VTpjS9QKMYmjLOHCNMh+dLBAjFtDo9PISK//9+QDI8ma9
 WNPaqwXfJ5bafdFGZaZgTzI8xS92+4JUqWjATHQULDm64yY8UbnxuKuQtVOvsIiDo5wQ6/+C81c
 0iaGWTKKgc1eJAvfA1QfbHkPe2FTXEzeAkKyY5RStYZfIAczyJQMjLaJH0knv/gui/jE34zSVoi
 wNO1h5mqbLoJJo3heDU6/5GReq+QbCewLgC/TicVoUvq0F/1uXFmkZgKPjVN3P+bK9g9GQ6x4q0
 82Uii7IGzmSz74kvoe8Oi2vE7fOB51tWmLYEm3oRWqmq/pUEbeHIJstu0kLu3YDdlPLtfKPk4DJ
 Wsa8K7Ucf0phEF3e2luJDa6weV0X19JU2oZ0EVZJGAB/ouAN9fpbnYbwmUk91t09dWJUEsfeOr2
 +UH+Z12FhF4TJEvTo6pP+fKalx2yPK29Ew7Y7Vj+8DoPN4gftBuehK8yKjQa6SSNNVdIRzGBc8H 5wXugAOFGwhDEmw==
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
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/btrfs/ordered-data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 59850dc17b22..2e0865693cee 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -813,7 +813,7 @@ int btrfs_wait_ordered_range(struct inode *inode, u64 start, u64 len)
 	u64 orig_end;
 	struct btrfs_ordered_extent *ordered;
 
-	if (start + len < start) {
+	if (add_would_overflow(start, len)) {
 		orig_end = OFFSET_MAX;
 	} else {
 		orig_end = start + len - 1;
-- 
2.34.1


