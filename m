Return-Path: <linux-kernel+bounces-67063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0326285659B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F62281843
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466BA130ADA;
	Thu, 15 Feb 2024 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cdCVBnDZ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51487130E40
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006423; cv=none; b=HOEDrQppKbabReuSIK5aARtu78s+OqVGDEx5vlmoH+q/NkbwqtvC55G2nUssjF/dZwRC6eXxUd0DeJH6QNitIbJIK6gKAkikl0xexNuAcwe903mKbr5QN4sELGTOm54CRBvBrvj54MelZ2ye8Rc22w/gcr2I58wA+p/uX6fS4W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006423; c=relaxed/simple;
	bh=Y6qeuARksgU+rEgbZqHNJm3BXr+2VBnjsm2duHdLWIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sMnEuya+u864Qy/eOwDB0sSIZR6r0YPvr0wAHIg3sbpgR8IIPuhow0V1ERSh9LAR/gWedyvQJAIgfee4XYwveSiEd4WqX18SY5UTPpkY1METxrtnuJnPlPjZPSe3qmZzzwW3Q7PyVD5QKEYUvO6oddaHJt3lRkSkRFtjeawY4yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cdCVBnDZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so117672066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708006419; x=1708611219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qZLd9NX3ymKq7wMa9QaV0cpLQd+CyTlNqfrZR5Cx3Qk=;
        b=cdCVBnDZffml7fx5wZG0IJJ9LetSwIKOOQy7Zay4w9XW+nog88Ia5Q9G/RMVBlgYPn
         mjyyrNx0YHUWlpcoTW+VSLgP12+WpoZT2tw/5PHRub6x185I871lJj8rpBauMKabPh0y
         SPuyUSsMm63M+yEELILU45siOPiZleS3AMK3bqh0AUTVHYhcjcZhKh8gIMZGWqHWoonx
         2rO5xHBTm5j/RI6/+VMSy735CtO2OX0HJTlO+aDnctz/OW+rJ+4ccFQGpeKsdqCeWKcw
         Z+PIPnl2IYlz8pUgNI/gGuNIrSi49JMYEmAr8Cr23fkTdJwIeayn/TigL6DU2Qm67bik
         hOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708006419; x=1708611219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZLd9NX3ymKq7wMa9QaV0cpLQd+CyTlNqfrZR5Cx3Qk=;
        b=Q5ydNNSrOUZrxxt+7TliIhozYW0OZmTogoyVMxikA36Dk83GU+MuDt6oXLHzUP2HDS
         IoOKY1Xz23KCK68Q+YQfEjxd7m6ka2ahwmxTDPM45HSXS8Ie0OyUBY6R+LPuBdOSEesa
         hv/udKgMFf4UYHyZFjzhfPL1/jx/YS+bEzWD65Bgfv9xB5je2lIfW+PDiUID4lFs6hNX
         PY6Hq0BrGhGppFNdGdhJEMhXaskh4Be0v/YhbL0ZfMsfpoGtJLX1Mwpo+lF0v6m4/kY/
         xkc7pYhAsYgtGYEwT4SLGXENy2pdn8W46KHNOnkx8WzYNWK4V0HVOyLyj8xyvcccXEIX
         oA7g==
X-Forwarded-Encrypted: i=1; AJvYcCXxA/MywKI6Q9Bv8/4RmSidduZSobHGkQm37TE3+yoyGntIw2CIZ31vw5TTTLok/6nJcMvVNHAI8PdpAuO71tlCYoZRK0I1HpkHRXFM
X-Gm-Message-State: AOJu0Ywsvb/QXqUthaF+/x7gDTqQ6UQTaRimBTXzbl266CMkSFanbgR7
	Y2Em6rqwWTazsE3pSRMPKm3mCqqTdA4N9PHjgFg7iF9k4e7j3IJDAjO4rxfC8J9xbjC31BC5+aU
	R
X-Google-Smtp-Source: AGHT+IHmjoDEsfh6SH1SQF7H9GfynfhHdXsJTtUo7vetxOSexyYXzCfklwZRaLSMAQLoh20x9Vvu3A==
X-Received: by 2002:a17:906:3ca:b0:a3d:b60a:3701 with SMTP id c10-20020a17090603ca00b00a3db60a3701mr330019eja.41.1708006419575;
        Thu, 15 Feb 2024 06:13:39 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id gs36-20020a1709072d2400b00a3d0a094574sm585985ejc.66.2024.02.15.06.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:13:39 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: masahiroy@kernel.org,
	nathan@kernel.org,
	nicolas@fjasle.eu,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] scripts/mod/modpost: fix null pointer dereference
Date: Thu, 15 Feb 2024 15:13:21 +0100
Message-Id: <20240215141321.899675-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the find_fromsym() call fails and returns NULL, the warn() call
will dereference this NULL pointer and cause the program to crash.

This happened when I tried to build with "test_user_copy" module.
With this fix, it prints lots of warnings like this:

 WARNING: modpost: lib/test_user_copy: section mismatch in reference: (unknown)+0x4 (section: .text.fixup) -> (unknown) (section: .init.text)

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 scripts/mod/modpost.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index bf7c4b4b5ff4..6b37039c9e92 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1050,7 +1050,9 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	sec_mismatch_count++;
 
 	warn("%s: section mismatch in reference: %s+0x%x (section: %s) -> %s (section: %s)\n",
-	     modname, fromsym, (unsigned int)(faddr - from->st_value), fromsec, tosym, tosec);
+	     modname, fromsym,
+	     (unsigned int)(faddr - (from ? from->st_value : 0)),
+	     fromsec, tosym, tosec);
 
 	if (mismatch->mismatch == EXTABLE_TO_NON_TEXT) {
 		if (match(tosec, mismatch->bad_tosec))
-- 
2.39.2


