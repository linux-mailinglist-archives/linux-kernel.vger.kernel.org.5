Return-Path: <linux-kernel+bounces-125312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AAE8923E4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3193A1C214EA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9DC86130;
	Fri, 29 Mar 2024 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cysaH0ZA"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2842B58127
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739548; cv=none; b=rplYgVbPYFqF3H45JAc1R84hsiH9er7aDUbhxWsKVrm+07LnsSYWzucQDZAo4ENo79ofnoyhwyMtJ5kiQEqeLKXSaTIl/Y1TgQ8wSFX5x0zgCNJDH/Z8rufjWhRXs58gZYFQFq4jBO27xcFmkBu5arim+3SEx5mEoiU85UBKG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739548; c=relaxed/simple;
	bh=AKvtFqmJH4ZOM6+yzO+8vG0/T8jZKT9K8FySji2Vvss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kuiP+qFBhTWs+SYZm0adUDJkUXipX2mFkUmDEixLIz8cjY7Woq46matPiT0hnm6Znl5YgmMFGGbUKM8yPMw5YYo0/5MEtfsFYtEM0iW+4845EClGJwkuUcbSLTPhck11VHHaVCvXMhfxL4ufUUWdjX5l6gBLkxG0lT1xIUZ10aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cysaH0ZA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e8f765146fso1910533b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711739545; x=1712344345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=scdxeJwXUHBDaV04a23nwEkYWMwKWnbfowekmqNHaec=;
        b=cysaH0ZARUctsKax8vvExBJt9dL7FAd26PNloL/5i6HhjLV+ORuRYAmUDfK7XhkkLF
         E5FTN7MnpGfMYBXvemz8lLnag3NIWniKzTotShfiSRB6OLXvrDrJNDu8HT/78cTg2UI4
         pDlOLnegmedYvwIDJzSxC6D9YrthXn9UbnBzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711739545; x=1712344345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scdxeJwXUHBDaV04a23nwEkYWMwKWnbfowekmqNHaec=;
        b=CHTGv4WNH0tqjbd6UIemcRmihxBwt5uEeAgcFc5n0Wa6MztgP6PAaQRkRFFCvXT1AA
         jnb4rd5Un6MTla5QTez2KZTKKTCxPOk2b9x2SC34y89jUhoJfB93Sde/5vgsUi0mPoPr
         4yyAE1tjNQC2kKMriEpzL0Q0GAa690qEAOVpcAPKpyQo9oriqsUFxsJh4HfMwe/j+e38
         d3b4Ls2X2M/2DcUNNNJfduORU0dr45FFgpOK3oGt+NZJ0iAL++VexRBzNjG3d/gMPnZU
         RsU7uG0NIJssPF0132r8uE/O1bbmRDq8JYq1+A2J6zCNdFylPtY5AmRJn383lfGFQLrj
         /NxA==
X-Forwarded-Encrypted: i=1; AJvYcCUyt5mWCKOY79QfphXKkikHGV0qY1W1l5cYXhiV3cnBtbDsXZ433ZDJfpsCFT7fZGL2uRI6wi6UvvvCxv4N+QbrTUiRWnKo12H2qRlj
X-Gm-Message-State: AOJu0YwjP6593HiZe80+6294Ta943xvFpGZn0ByUp25JBlE19OYnIYg2
	geZlauDQqkHXcPudHOp1oUUD8WdAqNHyZZ93YMcdXQkn8+6oqZ3kXIUQL7yHqA==
X-Google-Smtp-Source: AGHT+IEwjpEQv+LpV3KuKQ0fkXK/nEXbm5c2Qxf1IlRblY8ca0unVY5+k2YpXHSooflCb+JQub2eIA==
X-Received: by 2002:a05:6a21:318b:b0:1a6:ff14:a6a3 with SMTP id za11-20020a056a21318b00b001a6ff14a6a3mr1547146pzb.25.1711739545219;
        Fri, 29 Mar 2024 12:12:25 -0700 (PDT)
Received: from ubuntu-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id a17-20020a62e211000000b006e6c3753786sm1317471pfi.41.2024.03.29.12.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 12:12:24 -0700 (PDT)
From: Kuntal Nayak <kuntal.nayak@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: jslaby@suse.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Yangxi Xiang <xyangxi5@gmail.com>,
	stable <stable@kernel.org>,
	Kuntal Nayak <kuntal.nayak@broadcom.com>
Subject: [PATCH v4.19-v5.4] vt: fix memory overlapping when deleting chars in the buffer
Date: Fri, 29 Mar 2024 12:12:08 -0700
Message-Id: <20240329191208.88821-1-kuntal.nayak@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yangxi Xiang <xyangxi5@gmail.com>

[ upstream commit 39cdb68c64d8 ]

A memory overlapping copy occurs when deleting a long line. This memory
overlapping copy can cause data corruption when scr_memcpyw is optimized
to memcpy because memcpy does not ensure its behavior if the destination
buffer overlaps with the source buffer. The line buffer is not always
broken, because the memcpy utilizes the hardware acceleration, whose
result is not deterministic.

Fix this problem by using replacing the scr_memcpyw with scr_memmovew.

Fixes: 81732c3b2fed ("tty vt: Fix line garbage in virtual console on command line edition")
Cc: stable <stable@kernel.org>
Signed-off-by: Yangxi Xiang <xyangxi5@gmail.com>
Link: https://lore.kernel.org/r/20220628093322.5688-1-xyangxi5@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ KN: vc_state is not a separate structure in LTS v4.19, v5.4. Adjusted the patch
  accordingly by using vc_x instead of state.x for backport. ]
Signed-off-by: Kuntal Nayak <kuntal.nayak@broadcom.com>
---
 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index c9083d853..a351e264d 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -855,7 +855,7 @@ static void delete_char(struct vc_data *vc, unsigned int nr)
 	unsigned short *p = (unsigned short *) vc->vc_pos;
 
 	vc_uniscr_delete(vc, nr);
-	scr_memcpyw(p, p + nr, (vc->vc_cols - vc->vc_x - nr) * 2);
+	scr_memmovew(p, p + nr, (vc->vc_cols - vc->vc_x - nr) * 2);
 	scr_memsetw(p + vc->vc_cols - vc->vc_x - nr, vc->vc_video_erase_char,
 			nr * 2);
 	vc->vc_need_wrap = 0;
-- 
2.39.0


