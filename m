Return-Path: <linux-kernel+bounces-56322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AE884C8AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5991C24FE2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E17A14266;
	Wed,  7 Feb 2024 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cWl4z5dK"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF1714A99
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301841; cv=none; b=pQhftTe3Y04IVK7XvB9WGw5rScIzh/0jNRlm8tCqySJYxXcnNNY/e7FUtXRydFHOYEy0BxiRVO8G4Cu9NK1wJxZ+W3tlCaCEQykwcfxfTIH53ySjcNYMazEa8f45wE+PEUJfR56albqm0sFpCl/2jTP0vyHlzKwPBVHoN4stAks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301841; c=relaxed/simple;
	bh=mfdJ2PPYgHEwxxjFZw/P5kJZNUzHOxQcboOo1LpZkw0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QtCuTkUVQZ85T60F8Xr90cqn6wSF1XkeXCly6u1Es46/Xv6RjCTv0H1U+dRDJR8Bqo0pYHf5pLBZcroaryRUXOL+MpcaHWvWO5yyimuHDJ3SO/nFNXQXZM5+rF2DtVzLV1W/zj+MILaxX9JzlIU7nWBGhGCqeBZ2xciRk/xqkoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cWl4z5dK; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e04ea51984so237534b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 02:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707301837; x=1707906637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VxFNaOu8p/9ubGE206OvvoWg6KWdTW3LtGWkxqDKC/I=;
        b=cWl4z5dKv1M2R7IsE4qy2GENb69Mt9FAvvOmACj0dhtOPO3k07ombiUmG3C07fV+1W
         hwJ5nf0+US/C0qZa3cfb+f+NN85kPucHMcvpVATAy586aH+uaokBBliGsz6a+K3M1T8w
         tu3GdE1pNIggPBadIFzbTjpL69yQDHRkS5fBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707301837; x=1707906637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxFNaOu8p/9ubGE206OvvoWg6KWdTW3LtGWkxqDKC/I=;
        b=kQDj6XdXWXQEdVrQuWtyQyvl4Rc96vh58SbEbucAvC+yelKSYUsaNt8b+xs53otFQT
         DL0h9sTdRO0ozefGwuUYdjZq+WMFTc9elLEyHs56nlOzqx+a3LTNTRaA7CBKFHRqTaVz
         nFZRBvEfvOUa1UvIuAhHNKpyyD4g9V7RgmjXYuJEMZBfTp9TemN9efbfRkjUnGL72hag
         ZGng5FvgShB/gvziJz4C3gnF3UcnB7TVnsD9o+2s3Rkvc0UqcS8bJr0f9rK2XdJ+wEwx
         NAGC2Y7wb6NrBkuA/zIjV4xpjNIQLcfa3NW2Ubr1/KfEwXWNZpjqqPWOWnKurVjIlSLN
         xYFQ==
X-Gm-Message-State: AOJu0Yy1H6ddXA8E1aWcg1qUx5RdKlruJ3NIK3pF+uZSlNxMxy4uyVC+
	k+s0W88K7gkA5QjCGlFNhCW3lSnP6lJI0kiW+M+LpKHTo+S4DCzVP0kEUnSbkQ==
X-Google-Smtp-Source: AGHT+IHmQZg2xWswwdLkZUM98lbm3vLfVgBAMhcWGbUTojrI4Zqbs6QzEf5x7bLF/EDsnFPI48iUWg==
X-Received: by 2002:a05:6a00:1d92:b0:6e0:4e7e:ef57 with SMTP id z18-20020a056a001d9200b006e04e7eef57mr3001935pfw.32.1707301836433;
        Wed, 07 Feb 2024 02:30:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWO4odlDrBis+DsohTTRvTsyebXfdWZVWI48lFGxK65fP3Fzg+ytlTwc1Weo883Su4sOfsmqLBFjIc5wXExyzQz6B6Xj6ZMzmeHmyUKGzdt2FEBNXStJnabo/KdmOoUKicma++b/GvtuEDClYEUjXXTLTvosf72kylcwn+iO8nLvADdM0oZa+iU4Y1L73/3YfuFFhK2ZkSvQj5MEbdk/mP8Tc2WftqzjPeWx7AczvzIlHv9iWmREAuoiRunc6BQdToPPot/MvYhj/rf6mqWjq979Ebu7NQ7lKzGNAwra75vu3M2AA9yt54Zer++gGJNEZ4IAZUYSPU+3BF88nn5PqoipVwXwBbObn1zLK5iX+aGeIXoKeo43ie+/SgIrsNAfD3BKxI3JD+5VWX0yEH29hquXIdFrKBC9CgJGgTOMkxM4cwTf5Cc0Uf11f9BykunCMT95olbHtMoHl4rnWzFV/oc8ZYs6v8CJ5brm8Ow3vsr4c81YL0DA+xZ3K7ZxQK7b+xXbXTR4C6svYuYuKPBa9yeFxkrcI/5CEV+c8FIicaIG8CvK9zWT3BYeL2zgQ==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z1-20020aa78881000000b006e069e7d337sm995882pfe.38.2024.02.07.02.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 02:30:35 -0800 (PST)
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
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	David Lin <yu-hao.lin@nxp.com>,
	Lukas Wunner <lukas@wunner.de>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3] wifi: mwifiex: Refactor 1-element array into flexible array in struct mwifiex_ie_types_chan_list_param_set
Date: Wed,  7 Feb 2024 02:30:33 -0800
Message-Id: <20240207103024.make.423-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5569; i=keescook@chromium.org;
 h=from:subject:message-id; bh=mfdJ2PPYgHEwxxjFZw/P5kJZNUzHOxQcboOo1LpZkw0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlw1vJ+lZwuNYUZVoTHKCld+XDfk61MmQ4AJtWx
 yuRoj6FEbGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcNbyQAKCRCJcvTf3G3A
 JkvZD/4mFK7LLEbhJ+ACpF2DOwd6n5FovIkQqSygp7YBUe5qLC1D7jASrg3rHgr+sqR462EWon1
 3KxxDedRFIsoyAkdCNXntjHBdsKfgZ1QBRTLd2pIZXIAheggn5paCnhuVTX4TZ1fY61QLs8ebBL
 RomkYhtasbfaGsweE6hgmE1zrbWa95puAiHAIzeHs2yUiMqx7M+atEyJmpVmFkFqLVrgj8To+Ip
 K8NORi12jx3V1gXHB5QdYcF4dG0JN0L0g9sXoUKYYWJSM16znpZaIrsHm4zE907D+De/nt9YfsR
 +4LkPAnculMO6rYWo0AYbJhsA1q3+3tHRfEU177vkvlFIyTjbk61+nYiShw+WXbKUDTcOcMGxqL
 w2ayqHOII87gFd2xJeBaSbar8NKDlgBGS61Nt3vVrEVVZ2WXYpn94B2NMNmIs92AYTRMnh79BhX
 WHpS8maUKFrwMyKQjFvsnl/gqZEyc7F4feJGREH9Tpd55DN5pMxZvqMeJsofq/dOGgyxLdaX3XH
 UE0kas8PDTZX0Wo62Aw6PjzhlCW4UWAD/+aL35wT1ojW314fjoJHlVQciicz1v4oVdYRe69FP8c
 Sr5uNzwUJ9CNG903kAPNwCHNt6JUlFZbgM9BPWCosKM5y1vYkCOGfCBES+OotDoSPY5ofTdR/R3
 K1spiwV rMYOllJA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

struct mwifiex_ie_types_chan_list_param_set::chan_scan_param is treated
as a flexible array, so convert it into one so that it doesn't trip
the array bounds sanitizer[1]. Only a few places were using sizeof()
on the whole struct, so adjust those to follow the calculation pattern
to avoid including the trailing single element.

Examining binary output differences doesn't appear to show any literal
size values changing, though it is obfuscated a bit by the compiler
adjusting register usage and stack spill slots, etc.

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
v3: catch two more cases of changed sizeof (gustavo)
v2: https://lore.kernel.org/linux-hardening/20240206183857.it.362-kees@kernel.org/
v1: https://lore.kernel.org/linux-hardening/20240206163501.work.158-kees@kernel.org/
---
 drivers/net/wireless/marvell/mwifiex/11n.c  | 12 +++++-------
 drivers/net/wireless/marvell/mwifiex/fw.h   |  2 +-
 drivers/net/wireless/marvell/mwifiex/scan.c | 14 ++++++--------
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
index 90e401100898..c0c635e74bc5 100644
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
@@ -411,8 +409,8 @@ mwifiex_cmd_append_11n_tlv(struct mwifiex_private *priv,
 					  (bss_desc->bcn_ht_oper->ht_param &
 					  IEEE80211_HT_PARAM_CHA_SEC_OFFSET));
 
-		*buffer += sizeof(struct mwifiex_ie_types_chan_list_param_set);
-		ret_len += sizeof(struct mwifiex_ie_types_chan_list_param_set);
+		*buffer += struct_size(chan_list, chan_scan_param, 1);
+		ret_len += struct_size(chan_list, chan_scan_param, 1);
 	}
 
 	if (bss_desc->bcn_bss_co_2040) {
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


