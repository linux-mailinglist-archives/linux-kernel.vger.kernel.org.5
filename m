Return-Path: <linux-kernel+bounces-34487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B452A837D79
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0732DB2A9F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9D615AADD;
	Tue, 23 Jan 2024 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BNfM3xs+"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BA3159594
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969750; cv=none; b=tOm7NiRIsaQbcppOgTVfNq9I5+9A3S6eFArdynp+gCGcTG1s1Cg0P388IVb1VXGlCahtYBvkaXvBiQHRLvgo+tWfbSoyo59ACb5ghvgN4khwM+vNxXLLj/MbPbosOI4wDzDnTNiaoGiAPEDDwLPQCEMA+MXVYwh71fHP/scYzKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969750; c=relaxed/simple;
	bh=e7A6lhz1YTrc42RiVqJvDHkNtpFxlmtLyS2WOTvLsQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k8J2zeziCKf64iztdn7qR5LOqmPVzfdNW0xPXj/ffz/XmCDiBWVzHkdlqM78JRrQSHi24NgrvW5ZFS45ejHbHXt+gcslYrH+b9eYYj+q5SAAwa1rQWMFp6aZWriM4dnXkUvBE+C7YcvC5WHuUQLd3W+VSCCwGn5/eKQE6yqDKGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BNfM3xs+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d41bb4da91so19667575ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969744; x=1706574544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VCA4MiUm4hxtqb/2/ihwHQ4ffY15Cbnf0o55fNjhH8=;
        b=BNfM3xs+1yPOeKCdNABC7X502Zx3m74aSHmWYKpm3ntrrpPT4KTb9LShxaMCkOcBTZ
         jmP22vkgP4+b07DIGsPuBbyc7f04j2J1mo86pltd4yljNThSlMQVeTfiW7uwVm/iEHt0
         iN8mbVXnOJzqfqBVXlG5SFAi4/p2eW1zCYS1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969744; x=1706574544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VCA4MiUm4hxtqb/2/ihwHQ4ffY15Cbnf0o55fNjhH8=;
        b=XfaPwk7QYvqocHia3S0rl7TfgFoh47BYWdtNAIK0rpAWIrdLo9j8Ba4evQRgdJM7S1
         ZRW3b4AzoDP5OYia7JyBLVVx01TqWXj74VmHuwMQsEeeWbQy3jHF1k5xlHggmOAO2UCL
         8j18Ymq/Gmyhe9uefLSYmLafq9vOpwbgt5dQMeMPkxPwTxtx6+BC8yRUW3I2IBZujERV
         LxL5Yt3gArpC6+w2x1Fm0Wh8lKhBWUyY2V/HDrIe7965HjZX8a7ALncRCigQpCtpuw0n
         w1NeZ1lNxQ4+MD8la7QPoHBeYFIc1uzOyOglTk2BUcrGcHLw95oKsintUevxSB6bh+iy
         rJ4A==
X-Gm-Message-State: AOJu0YyX+iED5wGjGWTc67kpHHERF8vn47cjj1iqN5HuWKF3adeQgabF
	rEcNOZWV0r8nkhvbe4ThmOzCBBDN1F94N6/VMRgxwiyMl6LgkIiPIwQ21WYatw==
X-Google-Smtp-Source: AGHT+IHkoc29tLvtCHNJqiIhDN5o0+Ip7IYWQLpp6GJH3AJ1YZPTOMPreFRrlPzqUZzxKRAp47Hy2Q==
X-Received: by 2002:a17:903:22c4:b0:1d7:601f:a093 with SMTP id y4-20020a17090322c400b001d7601fa093mr1304472plg.96.1705969744416;
        Mon, 22 Jan 2024 16:29:04 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902d05100b001d5e34b3285sm7806408pll.16.2024.01.22.16.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:52 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Max Chen <mxchen@codeaurora.org>,
	Yang Shen <shenyang39@huawei.com>,
	linux-wireless@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 41/82] wil6210: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:16 -0800
Message-Id: <20240123002814.1396804-41-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2027; i=keescook@chromium.org;
 h=from:subject; bh=e7A6lhz1YTrc42RiVqJvDHkNtpFxlmtLyS2WOTvLsQ0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgIQmyCTrW1bahod8KxHdvoHy58y6yL+ETvY
 BiEiuMJbS6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICAAKCRCJcvTf3G3A
 JiRmD/9zhsD2mE1miG7SGjJBAYcdyMqu0B11enBzCr3b8d5xqV58q4aN1ZngsnmNjttQaMFFr1T
 9Gh/s9u56ltYlqudIxPMUSZSrUHU2C35m4gtJ4TVkt8qtfF3folCHfMmbV4i9KMdE1IgEESn2G3
 ogHxJ2XbUbwxx78z6StXZHHDfv5VPBwzr9kupbCeVGteX2t9bmMldyxqif+YKl45puapBWNQ8Ib
 cMeONqZ1xuDyp0U/qIu9iXWQJJuzn/IvIutdDznavIBE1ZLOPgsHof0dVXEQjpsQ5oSNU05iKIy
 RCwhvKkR8cxQTqAQX5If0192u8p1TEX99NSo9gLaza1jNIdOd3aMy1J1x2Opk8hxzJLbpIOuzj1
 CTLFFWDkPJHVyQi+TjyQoxZYjoi4jpnAv3piOF3Qyc/Ftx+LToOJ5NZQIgUKQCEtNf33XjtQa6a
 UhBSAs1HZAXgKJZmFa+Pj8Pa78PFbLKWQSpTG4JE6qcecARMPZCyokWGe0WhhJzVf/hUAC2ogd8
 RJhNW+Yolg1sqIWb4Ywf08WqhPZzOgqnSxV7Wm1OaMy0cDOWgX/20YYlkZJXEe3jj840ChWrQDt
 6bAIZMUBgi1USCdj4y617A+WtpZFjXDgWs9Q7XoNPEbOQ9ovO/3v9cThNhMGw/rkG372enD2SYp VY+mP6vYO8kr7tw==
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
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Max Chen <mxchen@codeaurora.org>
Cc: Yang Shen <shenyang39@huawei.com>
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/ath/wil6210/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 6fdb77d4c59e..3b3c991f77e9 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -286,7 +286,7 @@ void __iomem *wmi_buffer_block(struct wil6210_priv *wil, __le32 ptr_, u32 size)
 	off = HOSTADDR(ptr);
 	if (off > wil->bar_size - 4)
 		return NULL;
-	if (size && ((off + size > wil->bar_size) || (off + size < off)))
+	if (size && ((off + size > wil->bar_size) || (add_would_overflow(off, size))))
 		return NULL;
 
 	return wil->csr + off;
-- 
2.34.1


