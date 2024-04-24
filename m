Return-Path: <linux-kernel+bounces-157759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E478B15B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72CCBB21841
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D819158A04;
	Wed, 24 Apr 2024 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ec4e+S8E"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB66158211
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996067; cv=none; b=GtzIV+Jl9SMPoMxn+sLgC8zkqcWrOjv3IhXNH7+beScFEQUtDYhn9Xgw2yHgob8RshlVtr7ebKiQ1ZuVUlLbFU7Kko/rUwjsLyR3f12JImaBBaqFWNmaCi2JWR8UWrko9tC4c/kzAVBCyvL/Zk1X4BUw0k2Hl0aLpt9cRqkoE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996067; c=relaxed/simple;
	bh=waLAn1oU6Dl+2buXX+0Cf1qjI968BHqs+nK0WlFL0+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aVFj65UIA5tCGaVDfKOFnfvPmm0kOHPryLygc4Vfb4jTNzV5u2/YT61zlHY5Rtrx1ZGyjJpYmZ1u0O48M4Dp7zNE3S5P4CjqYvVswM5/QG+NCQVCK0NmnZbeOnwEiEEhBCMLG7vhX+IpMDbOdNmaejAAD/npXXKY+FGslTWRrsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ec4e+S8E; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso411953b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713996065; x=1714600865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XS2AFiWkdDHUYi+lDUVnXX0MXLWYjT4idfLw+m+o3A=;
        b=Ec4e+S8E6n4ym/MHlENxHfNb2qxUTgWasN7SDwg14AlPZThmhjrY1QkiPXPIfYmlVN
         th4WNn06TB1BWBzEbO/zdjjKvlIFLo9DgnsXmUsefhTfVwhMCyDqoPj+e8mb9fqf+z6g
         J2Vf5U9jZWEThvRA36HZ10y68O/2P0PqVrnp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713996065; x=1714600865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XS2AFiWkdDHUYi+lDUVnXX0MXLWYjT4idfLw+m+o3A=;
        b=PWCg9kL34frNqmv9YEdUqd9vP3RKa4LFz7nHz3TU4gj8mYVYPMbHwETmXtJ3T8hPhK
         tXI1LAsCgWAmpR/pJDq1jCkYXWdh0YuTSWjM4qv0XT0eahUmP8Munf7nQiN0E4KV5VqV
         9jkwTn5cEvIWMrCZy1j1se7wHjZGBUzF+GPkrJNrhKpAkMWNVqRxeSdUogk6KZaUa8dU
         b+qBqjTCdcsVS+PdHg5/Lsk2Kn5/Y/Xfe/YoDAu/eI1MBQ4yvupG8iZbup0yeCgdnKkJ
         m4C12dxEtFL92rf/1EW2Fm0cvzldtSy4zIMa0J/C7/xUgvuWndWAUBUQXgaNDKy67auK
         BP3g==
X-Forwarded-Encrypted: i=1; AJvYcCXyg0KYtO9xAHbBZlQSt22cF7EbrPJPdayCGs3TvDb/m9vRqpjI08VGLYihzBBd8azwCZufWS2myebYnABf+BHJ1a4aXWI2pWma/B7a
X-Gm-Message-State: AOJu0Yw+LVicEYfTmu28ho795cR3Sy+qtOn43T86qzXDjGyAHMN7tdV8
	qXPCB0rEA3d08puOHhHmygkPHvomzYyVTOZjsPX7NpexHPQnx0xbRBCVtOcLVw==
X-Google-Smtp-Source: AGHT+IFMUnlkU6FVaZoF0o6oZfpmlht2NNx99MnGarXZG9dKHk5wWrfHzN2g4QEO7Yn+LdKEu4QaYw==
X-Received: by 2002:a05:6a20:9714:b0:1a7:5100:7559 with SMTP id hr20-20020a056a20971400b001a751007559mr4241899pzc.32.1713996064358;
        Wed, 24 Apr 2024 15:01:04 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s80-20020a632c53000000b005fe2f66f89fsm6705904pgs.75.2024.04.24.15.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 15:01:03 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <keescook@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: nl80211: Avoid address calculations via out of bounds array indexing
Date: Wed, 24 Apr 2024 15:01:01 -0700
Message-Id: <20240424220057.work.819-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2212; i=keescook@chromium.org;
 h=from:subject:message-id; bh=waLAn1oU6Dl+2buXX+0Cf1qjI968BHqs+nK0WlFL0+k=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKYEcGRd/NCbnia73KALIWqr9Xdn0xKPvk2IDg
 sZ+kbxaAWuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZimBHAAKCRCJcvTf3G3A
 Jgl6D/sE+uKc6xZceXhHihXJHkcePsJVuhgwr7dKlPZMuFQwxhFMONW4l1jvB75ZZOOEHWK2SiT
 bjAv30r5kIeB9IIiN9xYvRhMc5OmThRriaNKUEWLKBJFIq4ifOYSlhkmV59bwpgbsHdSHf9cMcn
 i3D0oCGMp5tuCntEZdJknOlPPyfOHpFogpECCCeZ3rx0DaK0HZgxH4/8BuH+zygO2WQF2nMGLIa
 rMUoU7iOGLm2F9VBKaCZlIliIh5asQfSQf3xG8vhyNB4e+8Ln2NTYC3CDWdrmzQ0tqaWrOLaOmM
 IpBKbf9f5kKvKDqxlDsotpoovA1H0bHx8xhVhIK2jBeW6zyAeCM202g+n9fTtOVgtN6jp1RjqGt
 bfy9b7t/2sbrv6A20wG0Xmc73nZenBnbGUX0ALnXTsAMmtnUu4MtEq+wTNtAnLy17CnfHShiHMG
 aCud8tlty5gc6YeDXdBdAPTXXmOw/qJ0VldaIg1GeCDtxGPhrdPd+72R0n09Dlt6WvRkEbPJnCi
 UyKCMU3wHTxz1kjMycrI7IJW6h39YPxS4fpX6YR7BOd3M+9IbxPciQMjLecb+zmbJpW3GUaOywn
 N0ZZw4YHMVNqrwt569MVc/BLAzLda52Usw7rv1JQXNFQk3/WpJqdfiPMepFkEbEq7lBNhnPflh3
 HQSxXOf KpyuyZkQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Before request->channels[] can be used, request->n_channels must be set.
Additionally, address calculations for memory after the "channels" array
need to be calculated from the allocation base ("request") rather than
via the first "out of bounds" index of "channels", otherwise run-time
bounds checking will throw a warning.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 net/wireless/nl80211.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f391b4055944..f1ed0981147e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9163,6 +9163,7 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	struct wiphy *wiphy;
 	int err, tmp, n_ssids = 0, n_channels, i;
 	size_t ie_len, size;
+	size_t ssids_offset, ie_offset;
 
 	wiphy = &rdev->wiphy;
 
@@ -9208,21 +9209,20 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	size = struct_size(request, channels, n_channels);
+	ssids_offset = size;
 	size = size_add(size, array_size(sizeof(*request->ssids), n_ssids));
+	ie_offset = size;
 	size = size_add(size, ie_len);
 	request = kzalloc(size, GFP_KERNEL);
 	if (!request)
 		return -ENOMEM;
+	request->n_channels = n_channels;
 
 	if (n_ssids)
-		request->ssids = (void *)&request->channels[n_channels];
+		request->ssids = (void *)request + ssids_offset;
 	request->n_ssids = n_ssids;
-	if (ie_len) {
-		if (n_ssids)
-			request->ie = (void *)(request->ssids + n_ssids);
-		else
-			request->ie = (void *)(request->channels + n_channels);
-	}
+	if (ie_len)
+		request->ie = (void *)request + ie_offset;
 
 	i = 0;
 	if (scan_freqs) {
-- 
2.34.1


