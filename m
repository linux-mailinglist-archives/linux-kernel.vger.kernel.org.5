Return-Path: <linux-kernel+bounces-49568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B34C846BE6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2911F2CF47
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4761377F2E;
	Fri,  2 Feb 2024 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ToryxPm4"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE047E76C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865778; cv=none; b=pczRNQZTnJTEPNNbLc+cS7KQl9Wna2Wu5Pnl1w7xoAM+Pbm1Oq6oC/ySv6i8EUl5n+GEApxXY2WLW5eLZxO1O7qrm6BpnkjzbjQ3dBoIemmv4XArdvyjztpyLiL4X+xIzCpyo76FdyMBmal2mi6Cr8qcElFElv8riRRiViUrYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865778; c=relaxed/simple;
	bh=DPOMrDg4rKNH1QTC6aQIG7HRKerQiIwxkdnyzWqM6hg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=ItigREMIXg7s5EDcqr2eeerIGn9ATfzqvhf3Fxu+GRHrfZyO4LCVCXL6SsWmwSquKlJ5VQ78odXm526U1g1HIYsQ38Um3+Yu1+RxFmL64furc3ghZzUA0/arJkiTJMhkYV8Dxi78KoVtFIEC8+crZVvE7NzpgHh82b7bloeNBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ToryxPm4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f38d676cecso35404257b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706865776; x=1707470576; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=in2Ntwtloha/e+ZMm1Ao4y84QzaZLhLUFFn+wIIPR3U=;
        b=ToryxPm4Rt/XKOypwzqHUc/65vVE2cnjQGHjnuz7VGkgKIliukjc6yfQHk01NpGQgA
         kvN8K1+F9oU4OVOWqB0P97ODKGHXWmLyGTqWpyrs8sVcm2vO0gtZgKo3MbroX/Q88ZTV
         at3KtoHsweeX6WovQWqhp+liTfNUd+BDdy3zTKHRn1TXoZ53fnAlKsjNEX/5se161Doq
         oxxRAP6eh41h6WuCdro5HXjdXaMUwJdRwjumPomSZCndbPZCYWR5rojVGzRDP5BWrlud
         /J2w8BJepDfsX+8XKC6adj9CipJvk5IIKhw5VPyigyfR3JUGfGVMPYPeAeV1rgiVkpJo
         Nktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706865776; x=1707470576;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=in2Ntwtloha/e+ZMm1Ao4y84QzaZLhLUFFn+wIIPR3U=;
        b=JplAT280aZS59M4GirGlIaTFIY2loP+yDvaX0ME2KTSmwsCIYKTtMykhTd1i4/+Cpg
         rd+qXRWv7hsPWomiLlrgAMrGuMTwPQ8HXLRrgtp3vn93aPW0nZge70m+b1p4IAoUTLdG
         m/wWdTEH5NV3N02ZSevp9565AhcRazfHILxTexclPDlv97p/R1m9DROoeZqitLaPl8ad
         QB79zL1q6b/pN01Q6Rwcjgwe+7vJHmZD7L81C1u9Yr/pJQz+jrOrcLF0skJf70tQi2tK
         UbMoU28Wc9t7GV7W52t40W8NtKab/TldOfidxiYIiJXW+P/hQSzjtlSlrjT5R6p7l3uJ
         /Vag==
X-Gm-Message-State: AOJu0Yy3BDauslqcxLIYltKTXKuBgxxZLJGMventBIH+3nuuSn8vj/Sw
	Y2AQulVPuIBqIWPOvIWfdtkoa7mdxLS/PoeAIV+wHIPwqBAsPnK+3CfsWCa0ewf90oTGmXcGG+6
	KfY/KAp4vUlb5FQ==
X-Google-Smtp-Source: AGHT+IEwj1X6GEgoqz6nmFGZy/UDIWH00xbAf8HN/Ko1knPBLnDOwyS/5Rfklz5px+eWUSWStwjYrJ9a/nlb/Ns=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6f0:da10:9cb3:5b3])
 (user=saravanak job=sendgmr) by 2002:a05:6902:2004:b0:dc2:51f6:9168 with SMTP
 id dh4-20020a056902200400b00dc251f69168mr457589ybb.2.1706865776158; Fri, 02
 Feb 2024 01:22:56 -0800 (PST)
Date: Fri,  2 Feb 2024 01:22:47 -0800
In-Reply-To: <20240202092250.786276-1-saravanak@google.com>
Message-Id: <20240202092250.786276-2-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202092250.786276-1-saravanak@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v1 1/3] driver core: Fix device_link_flag_is_sync_state_only()
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

device_link_flag_is_sync_state_only() correctly returns true on the flags
of an existing device link that only implements sync_state() functionality.
However, it incorrectly and confusingly returns false if it's called with
DL_FLAG_SYNC_STATE_ONLY.

This bug doesn't manifest in any of the existing calls to this function,
but fix this confusing behavior to avoid future bugs.

Fixes: 67cad5c67019 ("driver core: fw_devlink: Add DL_FLAG_CYCLE support to device links")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14d46af40f9a..52215c4c7209 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -284,10 +284,12 @@ static bool device_is_ancestor(struct device *dev, struct device *target)
 	return false;
 }
 
+#define DL_MARKER_FLAGS		(DL_FLAG_INFERRED | \
+				 DL_FLAG_CYCLE | \
+				 DL_FLAG_MANAGED)
 static inline bool device_link_flag_is_sync_state_only(u32 flags)
 {
-	return (flags & ~(DL_FLAG_INFERRED | DL_FLAG_CYCLE)) ==
-		(DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED);
+	return (flags & ~DL_MARKER_FLAGS) == DL_FLAG_SYNC_STATE_ONLY;
 }
 
 /**
-- 
2.43.0.594.gd9cf4e227d-goog


