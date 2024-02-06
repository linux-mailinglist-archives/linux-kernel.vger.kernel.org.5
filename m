Return-Path: <linux-kernel+bounces-55462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE99584BCFF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCB71C2215E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E32134CA;
	Tue,  6 Feb 2024 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OM5MIO04"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714AD134BA
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244746; cv=none; b=S1URy/JNFF8+ZHmmuVvSfKMB2ivgfPAWVVkAdwu5dQ6waXAgRqWvYH+qzH9bIuvzg3hVjVa5tIcjOOOAjB9idDZ4PAKpZ73c9CV7/zEuacDy2OWYgM8+JYO/Rsyywxrg8OZXumdav4xJaAfDQjA+vxRQzVbXSEH1oj78usXwM9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244746; c=relaxed/simple;
	bh=gL6wUfzFxvfxPZGWpLEFqjtcbkxcIJZhE0UgHspyByg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sng4j5MEeJhlA88Od26NorvCLkxNr29ezbmxdrhZw4HHTko4HY22QdexIQVpUAxkzNYvwJa9WaCBSY/TCZvCng7VJ29c1gq++wuUABkRkKodwVAizbxi9EzGu5hv0c5rVKzZ5J14Rr3FoIplac48YvEo0xVxtf8vBnaZ5IiBe+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OM5MIO04; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-296dcd75be7so94990a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707244744; x=1707849544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wrFw6OcFw29oUU8H5EOEkRWU7rw58dDsUIlQVNcW+Pk=;
        b=OM5MIO04+DC3AcWgmmIjoLpKzRAW5TY9oD8ZLlU/KgGoRtIfPgR38T2t9vP14mg3eV
         8t2esO9xfuBB987eebVg8bsmoVW86avBnA91aJXcSB8dUavV6Zo+EVh7jOoV+wOlVHt8
         3mjmI+wXUrVT+/RghZGNkFArV3I7yJJ2nO744=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707244744; x=1707849544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrFw6OcFw29oUU8H5EOEkRWU7rw58dDsUIlQVNcW+Pk=;
        b=AL4VK47r0OmXsRfHRHX0ZwvZ2NaA1oV9D/8ifou/g+c52G+dRVGRX92lS0fMIeunov
         XXRXIIQvM0yx4qHmr0x9Eg6o1LrMULlW4s2klq0O9sVEn8ASz8tZuYCXEDI6NpjSchzT
         dWzylkkx4C//W7SjotQDQhGNWrCa/5lbm5lsI+wtmLEqUZQWxXMMRHG7olLRsblY+qaC
         95v/iySy2Jy/xQc9NWLzQbX5s9DuMOK8A6jttQuKYz+8Muk9w2gOA7I/o6sETW4VbOo6
         JZLNhOoY2Kk+R8p5smz5cslAyHJyvfAGzybAC99SirxRyRHdRFECkV8YMNiIWzJ9xADV
         shqA==
X-Gm-Message-State: AOJu0YyE2VQM9ilR57lmBYJPMs5OUXWr5Gid4EGKqs/raFIRVnw1FZqr
	xD16nceIlHDLkvpnxJpWVH1yg+8j9sV2iQxdKhKh9CjKHKKgLEgkpQoEZgVuclMFEwErwJNm2cU
	=
X-Google-Smtp-Source: AGHT+IFXExo/rfQDhE2G3o1tXJ+LATi7zds7yPCtX/Mt6GZhTF/DVi6VZTY8AdFTUrDn+55tECcrmg==
X-Received: by 2002:a17:90a:bc98:b0:296:37c7:3b6b with SMTP id x24-20020a17090abc9800b0029637c73b6bmr469394pjr.2.1707244743796;
        Tue, 06 Feb 2024 10:39:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUpUq+q16t/tO/bRMNwHTxBqH5erYfal6rQvDmcpuQoxhYJX81KaZ3lX6ykU3oInOIkkUM3aFk9Y7gkFYgN384cFlTJOmDkpKW2GbFh9GtdFN6UAM/AERw1T5/e26fbVXcWGy4H3vJioRHOxjbXii5LEp6/4rKSil/o7DKsMfbWONMGx0LuKPf3yjUnQoJi6NwUVII5CuLE0VXFnHo7E0S1TuAbT3+YH0KjoLCl35E4HTf+GYGy76QVBVSLfE5v3C7LRXuLMbkYPTG/lB7uozb934pCchu3ssSIlcN2/U4RgmM3Gzvq2LjzoAo9p4pM6aQwJCya9rx4HGjfiyXHOp/51j23VpZBhDdikhdPBrJ1h/3OglXxUohU9a79tDJaO/e3afjziqN8OBZGT37RC4H1Evy1ZZvBRH4HJssj5eOEQi8IERvyBMb71iw0xsfdPrWnu9fNcDjR25p25FKWDB3gCxxHDevU1r8oZ+IzR7UEVI/pVcJvyhf3a1bm4YLKr4Mr8IpeRY/fxOXsSnPOyHm2OujZsbo1EIcXJGr6MUEtVUlpg2JC6Zk=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b001d8d90d4f67sm2193828pll.249.2024.02.06.10.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 10:39:03 -0800 (PST)
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
	Dan Carpenter <error27@gmail.com>,
	Rafael Beims <rafael.beims@toradex.com>,
	David Lin <yu-hao.lin@nxp.com>,
	Lukas Wunner <lukas@wunner.de>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] wifi: mwifiex: Refactor 1-element array into flexible array in struct mwifiex_ie_types_chan_list_param_set
Date: Tue,  6 Feb 2024 10:39:01 -0800
Message-Id: <20240206183857.it.362-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4690; i=keescook@chromium.org;
 h=from:subject:message-id; bh=gL6wUfzFxvfxPZGWpLEFqjtcbkxcIJZhE0UgHspyByg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwnzFBS+naesqyOm+jex8E2ol2qfR7ZhNVcLSc
 EVqqdvSjMSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcJ8xQAKCRCJcvTf3G3A
 JtOID/961P5ahoXgEYzbPIg9qA1VYdOIpn+AfICYE0+zz+ShW4FNrY5PN8DRqE8dGyMtZCZpljq
 Kx8difB+vOQMH85q8vakcnKwqME7FJuikUnbCf5hS9AIRJeCvcsCmoPH44uDqXAuSksLUNCQRdz
 /4jgremvQrOUpWSsqJGrceZoUlgFkByd/q7VMJK3nUZX6Ax2tQdDR6+FkPhZ6McoPxGxjRHr4CZ
 PLC6xpPpXPS3suwJzv2idN+BNfVTWm+JWG/RAE1nF27OzQsLLWVzLOZsmtWx4bKtcjySVAL4BhE
 UjIKW/evDyiGqzJXslMEizzjM5q0Qb8qmBc2qAMQYLxKvVYaEatiIhKeVKdyiH/P82W+K3GW8tt
 BkUNXCm8OpduBeLtmhHxGdiey5H9JVirXw9LY2wTXAynqG6APStIUUJtJqzurKZvDsTfzq3GcMp
 a9FdNDMIkXIJ1xL9bdVeBtzTCHYAQsiE7ibKBE7PQxnozS9SMEmM0K29fDF/pikFu/v6bFH80Ii
 h8wzAPropTG+qdRT1wYtf4nGPOwuCoL+YayD3QEBgvTiaH6UsoggT7W2grT2OoAPoSHyJtPTfof
 BusWwjDqSFCbPKlYp/OZc12rVbduQP+r70PrXsF8LsBYp55kJMMu8WtxqfhYnHlauzKdhh1p/TS
 G/XRLMV qRw5DXSQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

struct mwifiex_ie_types_chan_list_param_set::chan_scan_param is treated
as a flexible array, so convert it into one so that it doesn't trip the
array bounds sanitizer[1]. Only once place was using sizeof() on the
whole struct (in 11n.c), so adjust it to follow the calculation pattern
used by scan.c to avoid including the trailing single element.

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
 drivers/net/wireless/marvell/mwifiex/11n.c  |  8 +++-----
 drivers/net/wireless/marvell/mwifiex/fw.h   |  2 +-
 drivers/net/wireless/marvell/mwifiex/scan.c | 14 ++++++--------
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
index 90e401100898..9ed90da4dfcf 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n.c
@@ -392,12 +392,10 @@ mwifiex_cmd_append_11n_tlv(struct mwifiex_private *priv,
 
 		chan_list =
 			(struct mwifiex_ie_types_chan_list_param_set *) *buffer;
-		memset(chan_list, 0,
-		       sizeof(struct mwifiex_ie_types_chan_list_param_set));
+		memset(chan_list, 0, struct_size(chan_list, chan_scan_param, 1));
 		chan_list->header.type = cpu_to_le16(TLV_TYPE_CHANLIST);
-		chan_list->header.len = cpu_to_le16(
-			sizeof(struct mwifiex_ie_types_chan_list_param_set) -
-			sizeof(struct mwifiex_ie_types_header));
+		chan_list->header.len =
+			cpu_to_le16(sizeof(struct mwifiex_chan_scan_param_set));
 		chan_list->chan_scan_param[0].chan_number =
 			bss_desc->bcn_ht_oper->primary_chan;
 		chan_list->chan_scan_param[0].radio_type =
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 62f3c9a52a1d..3adc447b715f 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -770,7 +770,7 @@ struct mwifiex_chan_scan_param_set {
 
 struct mwifiex_ie_types_chan_list_param_set {
 	struct mwifiex_ie_types_header header;
-	struct mwifiex_chan_scan_param_set chan_scan_param[1];
+	struct mwifiex_chan_scan_param_set chan_scan_param[];
 } __packed;
 
 struct mwifiex_ie_types_rxba_sync {
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


