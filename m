Return-Path: <linux-kernel+bounces-167001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5D48BA342
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10B01F2154B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77E81CA85;
	Thu,  2 May 2024 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fRoX6Vrz"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7209318EBF
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689227; cv=none; b=ZOox+PoXUmqqmZD/S4nt3E7I9qitRb2wkeNZDPxA/Zj730WolRsnT/zLiI6ApEiJReCrMOlDfgbnPJdSjPuzpcKyp2vPE8rgFJl+vwJsow45sDyqF1KL/xVepWMmL0j6oBJ0fXqPytNy1QJfYk8hQHwNCFMIjvNLnhw+T3l1Alk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689227; c=relaxed/simple;
	bh=OUKzE9BVu8bWw6VjJLw4TE6pDmrAN0hiIKHseOy5gQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zq+DtzmaR9RE1dSJp2jRutyYoJzE5WvyrT6qACIv7wMft9tAsXHEB2JxozoBJ3I4gH2wlTb3WSSdx3xLwVnL0AevrsUyjvsgydCvIvSwTTSYPR6KS6wvvt8W9Mh5JKxF2VrT0uX6KYfQQLgdbFJW4VnZyufm1Qobyqw/YosEptU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fRoX6Vrz; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso7835236b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 15:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714689224; x=1715294024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1A06K+cPndg/pyM0u+MnZKl+yBNNRhhQ81oQHFD2WfU=;
        b=fRoX6VrzxbPEaTpA/kP/AKhczr/5dmU/r3DUPek5TaOo4BZmeOkDEpoBawV+8fjjTf
         DcyRjCUDTs2Fr87wKT/FiHhxXIagUWChy0sRJXl8Q6LFB4ltBOsB/+dQdtxl9xnyHUbQ
         WG4qpZyVh1tLZDqDD2T7q0eLX4AEhuVVY575k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689224; x=1715294024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1A06K+cPndg/pyM0u+MnZKl+yBNNRhhQ81oQHFD2WfU=;
        b=FIah2ECaj9xRmuk8f71Kkao7hHvhN2gZvqDB2hxoioPLUBotf/JA7mkGeFK39BpGJX
         ri+XEN+dLFzECOQ1NNDRYs5FsXj/yIDvPAWoDcL+4PqktN1NV8B7lTxraYP1q/bX95+j
         TlY2YYpvqmBWzptMtvA3wHzu6ctTtcOP0fNkCiC07yM1EHd8PIvbEEEthieJJRuq4Zaj
         Ns5KytLnH02NjhZhsfKllNoxoZngds0Vpu73jIhGwlZzMhN4d8E/9UlG08EkNEZFKHM+
         2qUitvR/BxBkuAQfmfNjQQtQjfO3vzlOBGHqLx3/jMacAZbz70FX6s0emg3gPNODNbwO
         ixug==
X-Forwarded-Encrypted: i=1; AJvYcCWju6KQJmQo3QgLJVUvb/2SDe1P2/419a8o3fY392EmbphVImRk/W2b18AZmVeAb623XVjdzocnvh1z9ehky9KMhH8g9syFzkNFeOcf
X-Gm-Message-State: AOJu0YwaZRrA0UkUyc1AX/CUNdQdmE5/xJbJZbKjZPP45t2BtcMaB2Hh
	C1aAohZu/aTetbTxipq/7cpyu8HSmeWse8aYrmrZN0c6tUan2U/JqjeQcCsN7g==
X-Google-Smtp-Source: AGHT+IG2YWa+9vY4h3Nt4PaRaRqLrTI7aivCYrlbdPDKTXJ4+9jbccE7kk1f6L0pdlB3sdtwRrv0Kg==
X-Received: by 2002:a05:6a20:2ea1:b0:1a7:64dd:ebe8 with SMTP id bj33-20020a056a202ea100b001a764ddebe8mr1102791pzb.49.1714689223844;
        Thu, 02 May 2024 15:33:43 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c12-20020a631c4c000000b005c6617b52e6sm1794043pgm.5.2024.05.02.15.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:33:42 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matt Atwood <matthew.s.atwood@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/5] drm/vmwgfx: Do not directly manipulate file->f_count
Date: Thu,  2 May 2024 15:33:37 -0700
Message-Id: <20240502223341.1835070-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502222252.work.690-kees@kernel.org>
References: <20240502222252.work.690-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=keescook@chromium.org;
 h=from:subject; bh=OUKzE9BVu8bWw6VjJLw4TE6pDmrAN0hiIKHseOy5gQI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmNBTDv/zsdqEX/aWrvJELPzlHroMCjXF3QLhey
 S4S5ggvUL6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZjQUwwAKCRCJcvTf3G3A
 JkpxD/oDlial29qMNd66BSgea9O5UW/Aq3fbPMw4W3EMgMW8bVd/2Cha0TLF9V6wPXJVpP9GICw
 eySmpxWOHWSZcjcLDQcl3iM4a9UgU5v0D/1sXfoWYpKb8RVGeGLgKP3alVDBkkX0vAShE079Rgv
 AaOYBsxL4AWKH0J2mPuUNW1OfLBaqETFXnLQBSaj2UyS3/WXTVW1GHxm9VvBJGhFVxuE+wCb6J2
 xOaHDjJd0EfmnXYWA5G0fszOm/QZch9KwaaSnl4bvV6ennST4HrFfxcb3aoODK7M6tHEtze1gql
 3NOu5+wUDcxv68MozmrUGEAXWOvGgTGZ5kugToTTsHflWiG23cemytSMo203nmTfyKc8/u3S0AO
 fT0/foBY7k3RMwGcqYBnsdh1/Jq5xVXpDYVLyMgNRsgW1NXdWmM1cA+dosWN6PMw6lRAue96s9c
 i3rmc1I8FSgzzkU6CVzCHA2OvjWHWnAtCxDZFGoTWPNSt68KMgYxy+w7dhirZS3oY8UA8NByD4z
 iU0Wr8PshZ6X/yOrMNAqrLv/YHZHlXt9M1fl5FRs35Y9Cfj6SaJjRhsWINHqY7XmL7DbZgLHnfT
 2sm2WcxYxdug3OFoyke5UhhyXwLjB1tcBLaU3maUuNFLkfVGdBWJy1b3jBcj9FeFF/FmdXedjLE f5Rb9fzOhMoS+kQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The correct helper for taking an f_count reference is get_file().
Now that it checks for 0 counts, use it and check results.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Zack Rusin <zack.rusin@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/vmwgfx/ttm_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index 6806c05e57f6..68d8ee3020b1 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -475,7 +475,7 @@ void ttm_object_device_release(struct ttm_object_device **p_tdev)
  */
 static bool __must_check get_dma_buf_unless_doomed(struct dma_buf *dmabuf)
 {
-	return atomic_long_inc_not_zero(&dmabuf->file->f_count) != 0L;
+	return get_file(dmabuf->file) != NULL;
 }
 
 /**
-- 
2.34.1


