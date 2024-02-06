Return-Path: <linux-kernel+bounces-55322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 561AE84BB16
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C056E1F25C82
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B4C6FB0;
	Tue,  6 Feb 2024 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EeRA6zSb"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107BCC133
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237309; cv=none; b=PvD6KrOAYWcvn/02e3KdKL1F4u+/WRAhFRAKkrD4nMH1StPc+WLUV3bEm0S26wstOyCzCzQw7rEt+eiaEAW4kUZRUWEO4sitxAriu14fGGZ2uYl6TYRzHkUpxKBZgsvgu4vF+hFzZFbtuPTmQYRDkj76NIqvCCxPDA1POSzjVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237309; c=relaxed/simple;
	bh=I1MfE6AhaDeVgzj4aA9PyyPGYZWM6AIX3a3/cMVgTaw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nmLofkN+9z3FHeXdeTKH0IDxYvhMuHcd5A8AIh+gmFIo6SoK5HoPovlAPu38FbgZvWpuvmuZhEJdHabQvjRswBJYCTMir3FlznDXBDc6pNHSE//kU+4PpC6hlMCevwQYeWvl3i7LC+AfumOSLuTz5Tyn9AvBldZ/kAe4Wy/f32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EeRA6zSb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d98fc5ebceso16242935ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 08:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707237307; x=1707842107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l9k8qmh5FtuqJT0VlM3e5bdRxi2TqKIV+Oi2Qsz4LGI=;
        b=EeRA6zSbxkQuNXdyLY3C5+++uJrEXJzDiD2Hs/eQ3woDOTwVKsUYtmr1uQ+jPoV9TI
         RRpQNkocwFMaxUBrCzDU8bvsMdnhqmPEe8qu8hbWjtEWwk9J9BiwQ967+opu/L9PMTsD
         6odQiI2HQtfsqdMilID04vqiQoC98SYtAbbCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237307; x=1707842107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9k8qmh5FtuqJT0VlM3e5bdRxi2TqKIV+Oi2Qsz4LGI=;
        b=vfRSmOm61nwDjzrPXPozBMuGj37grgbsnUyXaHUDfnRePIiFxjkbB25ket/ARX2gbT
         sa9iOwFRnQQv3rrK/FmNGmGZr1CLxffgUwFEiVZlYmhEandS6Ki7KqsZ/uKLKpX9Sj+p
         ZVq9KFzyly1ZKPhofOgV3IvBY8Niro2ZQkuJbn1R9lHXNwjvX1gY0QZki6pfug5FDj7x
         c1Ku+z5MeC78/jyrqaEtHpomPWzM8ACEjgk/cgZehkNzhdBdZfWlHATYb4jQvrC/76J5
         t9uefm1vB6SoUTDnhjIVDS6UtwuEi3LQmozYflYkIYtCU35M1WJZbYlgifVTDTztyyjX
         dLzA==
X-Gm-Message-State: AOJu0YzQ31sgN8+DRHfN934/q2PG4LmF7rotPo/2/B/i80D5W1skpPjv
	BqrQEHiY7O/Ssk/ZNPnQ9GvgX3Kns6bK9DqBR2V9a5ot1HJK7piFT/yCoC0/HA==
X-Google-Smtp-Source: AGHT+IG8UBzgoFf0n/CYjiadrh9Keq0fKG2KclHIN6IbzHjapSkd7T5jS0c/GDpxVFGoQoKnhSVs/A==
X-Received: by 2002:a17:902:7842:b0:1d9:c01a:dee6 with SMTP id e2-20020a170902784200b001d9c01adee6mr2028518pln.44.1707237307417;
        Tue, 06 Feb 2024 08:35:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW5fumqxc1sH0MT/vwOXV2DI8bT3uU6YjbFErJAbqcnzXatDTQZA8UvmAQpn3MsO5TYa8t2ydZ5E7QAyfKaKjRBHmqs2qx9tGgj5OeJ6pRk9/CfUWTJ9wVbRwywVPp08C2Nz0lDEjiYP29tR+I7FErOnCh5DdrkGRO8T/i1YNI5HrjiZRCg6wzD3Zi1oJLZY4Xbp49ngh+pUWLvyE9zWQOZbhKlbTr+4+L1klJ74sj2y9Dwhvy2qgPQNFZbWyY/lFJrhXmB+MQd1JpFN2xgNuTGMHaHatWPrIeSTMNAGr02qkgjzZWaR3qIXHW59DlFoIV6jqLavP4FVl+QjkX9kzcjwWKyvD7M48MBHWCbOYvzH9jk7psJuuedBjanbpGG/hSC02PvBXGI2rlZfx8hsGFuVGz9ZcH5e+iJOzwWIx4zKflXlg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k196-20020a6284cd000000b006e02f222c2esm2224188pfd.30.2024.02.06.08.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:35:06 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Kees Cook <keescook@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	zuoqilin <zuoqilin@yulong.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: Refactor 1-element array into flexible array in struct mwifiex_ie_types_chan_list_param_set
Date: Tue,  6 Feb 2024 08:35:04 -0800
Message-Id: <20240206163501.work.158-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2956; i=keescook@chromium.org;
 h=from:subject:message-id; bh=I1MfE6AhaDeVgzj4aA9PyyPGYZWM6AIX3a3/cMVgTaw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwl+4Lx4aPOoiEcILogqM539VTMsu2tv0D/daM
 eRXD6FTw+aJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcJfuAAKCRCJcvTf3G3A
 JolcD/4yGn/OpLY/UrZ49y0DuN14RPalUzJvqINjBVH38HNl0YSWy2Rfpj9047GXuyUUMFFLHHx
 QfEAYxSwu8rRhq3w1YjGVVOEOv0/QAMDghDgUwT2q8SRD/XsU/WS3jgjBcz8XZnyv050u2m3Gr8
 a+8E+X9y7Mzf7XSetpEbknoE+CeWCfyMc/6wWHYOCbzhXXW8EY0AyJe6JgqAPEAaUw+XehXUSLD
 EwFdq3dC0zKmBCzLrXC+zbIJvlG7z/CQIbYTodjvcAFGNBXlrjC8S3kqB74Fu2E1JobMDuPgX9O
 dFKHJ6bPPNKVueX/dovLXiM7ESte1OMN1s0U/pOQz9feafcPSg6E8aEulB54RMsMbTfcXxFgWiP
 dnmVDjQ9Dpv3NkwUZlY1zYB3BEciX9O4PwhwObEcF8gmY4LLaXSI6HP/mrr6tf/jKZ5S/4ksfuM
 c2oouHiKEXQunEXv3nloSvYIN6cOycT1uyO997pesTbC8Z7TwGLZVEmJo+rW1McKlPe23Y6V92b
 tywErVOd+98zGQPNz2v+AjwObBw79yyikxe4DzMj//96A1EPgSOPtnZHWaHFsl6fKp2xTHm0A55
 3KU2wEnoVlVgcP2tcnWD42CrVBPR62sT9IISncwlDrZ2b4kwRx38I1zw1aObyIBYt0QgcPStKtG
 M+Hd05+ LE24MRPQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

struct mwifiex_ie_types_chan_list_param_set::chan_scan_param is treated
as a flexible array, so convert it into one so that it doesn't trip the
array bounds sanitizer[1]. The code was already calculating sizes by not
including the trailing single element, so no sizeof() change are needed.

Link: https://github.com/KSPP/linux/issues/51 [1]
Cc: Brian Norris <briannorris@chromium.org>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: zuoqilin <zuoqilin@yulong.com>
Cc: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index a2ddac363b10..0326b121747c 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -664,15 +664,14 @@ mwifiex_scan_channel_list(struct mwifiex_private *priv,
 
 			/* Copy the current channel TLV to the command being
 			   prepared */
-			memcpy(chan_tlv_out->chan_scan_param + tlv_idx,
+			memcpy(&chan_tlv_out->chan_scan_param[tlv_idx],
 			       tmp_chan_list,
-			       sizeof(chan_tlv_out->chan_scan_param));
+			       sizeof(*chan_tlv_out->chan_scan_param));
 
 			/* Increment the TLV header length by the size
 			   appended */
 			le16_unaligned_add_cpu(&chan_tlv_out->header.len,
-					       sizeof(
-						chan_tlv_out->chan_scan_param));
+					       sizeof(*chan_tlv_out->chan_scan_param));
 
 			/*
 			 * The tlv buffer length is set to the number of bytes
@@ -2369,12 +2368,11 @@ int mwifiex_cmd_802_11_bg_scan_config(struct mwifiex_private *priv,
 		     chan_idx < MWIFIEX_BG_SCAN_CHAN_MAX &&
 		     bgscan_cfg_in->chan_list[chan_idx].chan_number;
 		     chan_idx++) {
-			temp_chan = chan_list_tlv->chan_scan_param + chan_idx;
+			temp_chan = &chan_list_tlv->chan_scan_param[chan_idx];
 
 			/* Increment the TLV header length by size appended */
 			le16_unaligned_add_cpu(&chan_list_tlv->header.len,
-					       sizeof(
-					       chan_list_tlv->chan_scan_param));
+					       sizeof(*chan_list_tlv->chan_scan_param));
 
 			temp_chan->chan_number =
 				bgscan_cfg_in->chan_list[chan_idx].chan_number;
@@ -2413,7 +2411,7 @@ int mwifiex_cmd_802_11_bg_scan_config(struct mwifiex_private *priv,
 							   chan_scan_param);
 		le16_unaligned_add_cpu(&chan_list_tlv->header.len,
 				       chan_num *
-			     sizeof(chan_list_tlv->chan_scan_param[0]));
+			     sizeof(*chan_list_tlv->chan_scan_param));
 	}
 
 	tlv_pos += (sizeof(chan_list_tlv->header)
-- 
2.34.1


