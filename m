Return-Path: <linux-kernel+bounces-40778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E7C83E589
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896331C231CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18977286BF;
	Fri, 26 Jan 2024 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SNuR4lcU"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28186026A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308318; cv=none; b=pjZWE3YCTzfRqDR6Yn3dRqeI/ajVtp6ZRyUe7nTtdJJZp0B6so75YVa/2WiFuxbTgplzCmClcZ7AiFXT9u6S6p3T17ZdU5npl0CQoH3jSsD5uLh8Ok21MTn5uXuAqFruhRN4RB1elL9SKVNqrX1N1KdBbFS/+hAapYuw6BSptOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308318; c=relaxed/simple;
	bh=rPkXTYFkEXl5V+Jd/DTvLkzH6fCDzYI0Hu4sIr2JZLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Db69mjQNJL+6+LFbSe0Mswxs45Irv7209LTeE4BzAOTnEmrqGNj2HjybRWNy0T9o3uO1WRZDUONJnc++jZ7Wt3dBHTcIf0G4yTLzLN2R9dbiKBR33W3Gu7onTrLbtj26Zut+9M0lvbVN50p9OPp6ptRxCXTXeXlXd485D8ZBfuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SNuR4lcU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d71b62fa87so13929725ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706308316; x=1706913116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iU2Wtc2AukuXqcfYq4BIdUdSO+0wlIbEGbfXdoUnxgE=;
        b=SNuR4lcUHxREP2CV2muFhaSVui06s5ZPzFVFFRln/mT5bdaryCL8VQFVErrO1ozimD
         U7FDwXE6xtYpFe6N+MYEqcYBKqk0xCFO1+fCA11PeZGKnoBwkBoyN9uKxCFzHv83h3+Q
         UANKgTx+CppOGeqAWJyjwj/kSA0bRGYRcZz6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308316; x=1706913116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iU2Wtc2AukuXqcfYq4BIdUdSO+0wlIbEGbfXdoUnxgE=;
        b=pDYibnz8wJ0dGXQ8TuRyhCB3oq7NalkWDYvvC40I5//ykXYKoZ7giYYeUtZMoTNQeZ
         A0oUPRDnYE2UQIlk/ch3UZ8EUxYN59AlCQ+Qn4I3uHli4jfwaw33ObS71PCopNOmMu0z
         Xx72XS34RrYbNXZd8wPriBAT2qDqQbkoDKmAf0ZELO9xT2fhFVSxau7AePJdhyvb3UQ8
         QKkL4e0vxQ37DPTnej6vHLFSiBUirUgfaQramC6JvRBDCTK1erTJAOhPfFHxnr3ogwVH
         mAUKTTVXVvy32tMTxiTt3iUxASWubVmjJknrLcDPC044+vXtrWS2nIOHYKR51/MSuOPY
         6tng==
X-Gm-Message-State: AOJu0YzjOaLUsxbAs7b5wjEu2WUupiWtbLxyoRmN7MBai9VlBWqH7bzA
	oULyQhB9ls76+9O5TiCQlTF4jpXNuOU6MS4Ou+bAjJXRfQpts81flQOC1TsQmg==
X-Google-Smtp-Source: AGHT+IEdcjuVt71xGs4RaBAcyX//r1TrZHWYWdyRc/uuLuFjWBS2APfbkQb4tv5rh/eFxdoFKxohow==
X-Received: by 2002:a17:903:24e:b0:1d7:1a90:65ba with SMTP id j14-20020a170903024e00b001d71a9065bamr524703plh.25.1706308316193;
        Fri, 26 Jan 2024 14:31:56 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b001d72f71e83bsm1393843plc.73.2024.01.26.14.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:55 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Arend van Spriel <aspriel@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Chi-hsien Lin <chi-hsien.lin@infineon.com>,
	Ian Lin <ian.lin@infineon.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Wright Feng <wright.feng@cypress.com>,
	Hector Martin <marcan@marcan.st>,
	linux-wireless@vger.kernel.org,
	brcm80211-dev-list.pdl@broadcom.com,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jisoo Jang <jisoo.jang@yonsei.ac.kr>,
	Hans de Goede <hdegoede@redhat.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	John Keeping <john@keeping.me.uk>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: brcmfmac: Adjust n_channels usage for __counted_by
Date: Fri, 26 Jan 2024 14:31:53 -0800
Message-Id: <20240126223150.work.548-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2264; i=keescook@chromium.org;
 h=from:subject:message-id; bh=rPkXTYFkEXl5V+Jd/DTvLkzH6fCDzYI0Hu4sIr2JZLw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBltDLZh4vPxZxe6NQZX8zlgNerfj/phD+H1Ha2N
 cQmUuitlgOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbQy2QAKCRCJcvTf3G3A
 JtEVEACrslEiVziNzo1uYwZtisz+U3jKRB4W/CDxbqJsoXwjo/mvP1b0zYQdr81jwPkfRwJn+vf
 MWandtFqacMULVgDY6wwKWOPMW8a3QBMa4RnnWkjJaR9ZA5I7jSWN2AP/sDci2NeA2RgfwBnP9c
 6UM7UQBPAX10TMBCKcW9Pqui2xwEyDyOlMBCjNhOSmwumyU1ddU04+HPMw79bOqVIpzq52Y9nda
 04btQl7VIHWXaMqR3hfjzdtrFk6AG+VvqdRXHxWSh8CQ02WoMFx+x5UuWGNgE7ofBXIuQefTkeY
 pGuVyaKTk7nKGrPQF+434Sj3nm41C+8CcZWw6VaSxW7W5FgZD5G0Xrts/oxOSkibaPKAojlqg2v
 2lyvkcLm5uGKUP1pWijmeEbA3+zqL8j2+Ok4TurGi9NgTu2dF339TQh0q4vQey1Ofx7mCdXuOnD
 Rl2F6dEMABMXGrijocbNXbzGyYL++Hb3rpaZYWKveVFLrOgdsbDiY73WCvFsfUCAgf6PSZ6WUQy
 VSO5msytsN3qpfu/4PFc11nTR5FslBUGjLFaLkVHugDRrRx43e6Ela9bBK6YULN7sAJl4F+hRac
 jMhYLmvXsBtCh2lR1ckf/Bef7vr8KVgqW4JWIbFgOA9KpvOaE5DrBn220v1kPmW42GyZv/LKdHq
 nkKsHXV i3vN9orA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

After commit e3eac9f32ec0 ("wifi: cfg80211: Annotate struct
cfg80211_scan_request with __counted_by"), the compiler may enforce
dynamic array indexing of req->channels to stay below n_channels. As a
result, n_channels needs to be increased _before_ accessing the newly
added array index. Increment it first, then use "i" for the prior index.
Solves this warning in the coming GCC that has __counted_by support:

./drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: In function 'brcmf_internal_escan_add_info':
./drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3783:46: warning: operation on 'req->
n_channels' may be undefined [-Wsequence-point]
 3783 |                 req->channels[req->n_channels++] = chan;
      |                               ~~~~~~~~~~~~~~~^~

Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by")
Cc: Arend van Spriel <aspriel@gmail.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Chi-hsien Lin <chi-hsien.lin@infineon.com>
Cc: Ian Lin <ian.lin@infineon.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Wright Feng <wright.feng@cypress.com>
Cc: Hector Martin <marcan@marcan.st>
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 133c5ea6429c..28d6a30cc010 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3779,8 +3779,10 @@ static int brcmf_internal_escan_add_info(struct cfg80211_scan_request *req,
 		if (req->channels[i] == chan)
 			break;
 	}
-	if (i == req->n_channels)
-		req->channels[req->n_channels++] = chan;
+	if (i == req->n_channels) {
+		req->n_channels++;
+		req->channels[i] = chan;
+	}
 
 	for (i = 0; i < req->n_ssids; i++) {
 		if (req->ssids[i].ssid_len == ssid_len &&
-- 
2.34.1


