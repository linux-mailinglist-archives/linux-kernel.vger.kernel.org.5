Return-Path: <linux-kernel+bounces-18385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC254825C49
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48FA1C232AE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C906A35EFC;
	Fri,  5 Jan 2024 21:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wEuAkuCq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A797635890
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1d4966f020dso107245ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 13:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704491852; x=1705096652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wy2yi2gimcuSc6GrBAAHilPzT2ihHUfw/mmGd4g5UU0=;
        b=wEuAkuCqxc+80xrt+UFygtvXium1SWpsePU/wdldP3Taz4QvjPittGBA+vhhEpHKxa
         NBefTiKh7MnE64GCkYj1FiJzTua5Yoz8WpvMT9fveezmtFfQW73/8jtNtvCuMPlECpJY
         bmUTUIBqEOPXNLEm6F6mkwcoOZbAPvc3s4dYzStKhAaorFvrM4TARyBvfJF2ELh1FtUM
         1xk32su0rTrE0wU9YOR9msgh1fteCThlbMIMTA2iWE0WlBPLFfa2CJ3D9YwnIneiprTM
         xoR21cwL//Ks9wJgihuTch6wV+7UR/CwlJzT5pFl0Hgi/KFujR863nsQkZvNN53RzRtV
         I+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704491852; x=1705096652;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wy2yi2gimcuSc6GrBAAHilPzT2ihHUfw/mmGd4g5UU0=;
        b=q/BIjuJuDogLApGCiJdmwUNguhLW6Rj8Nx86N3xcowmMU4gdwXgDrv7NO8LN9OSlNI
         P9QyWzYMUSknasVQNy98YF6sMUqsndG5Xpb3/uRseVL+reRxBJ5g4Iqmj06vZtdpPgmN
         pnEASHkrFhodhIht7Cdkl60oZDrCu1b9ImYwk+/s+u0SAiBDCXKDdgVk3BattKgQP3cO
         ES4ul0ndPHXGbag3qFPjj8x3Yv/BcSQ8vcdoqXSL2tX7Oo6Y/y1oEy7QMTsel4NLEWDS
         wyHhdRCaB6vgl5nanZvgvPqQVgpcTk2XYnnLl1SatHHOE0Trt/72E3hKrQJSdST4yp7d
         sqdA==
X-Gm-Message-State: AOJu0Ywi3o+CfVR2qbKTfBz1P1FCi8kYj7nMjABFBKspLk6DMLLAQLr/
	E1D6J62NKeh6JbkzFlQIDNktQhOv7aCwIX4WpLY=
X-Google-Smtp-Source: AGHT+IHS4IJlegooOGGgX1PYR4GVZGYMXxe41ADRHyxvb+c1MPzObGq98lN5YQP/O2NFXcxuIEKyc89lh9Ir
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a17:903:2301:b0:1d3:f016:b0f6 with SMTP id
 d1-20020a170903230100b001d3f016b0f6mr654plh.5.1704491851874; Fri, 05 Jan 2024
 13:57:31 -0800 (PST)
Date: Fri, 05 Jan 2024 21:57:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEd7mGUC/3WMQQqDMBBFryKzbkoSEsSueo/SRZyMOqCmJJK2i
 HdvdFdol+/z31shUWRKcKlWiJQ5cZgL6FMFOLi5J8G+MGipjVTSipmeNDkeBaI3zvq2ltJDuT8
 idfw6Urd74YHTEuL7KGe1rz8iWQkl0JBsncYalbr2IfQjnTFMsFey/mfqYloyviNvG0fNl7lt2 wcgY5k22wAAAA==
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704491850; l=1119;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=qI7JOl8tQZllecbQdXm9volvhu0nqYHMDjKlnLhIikE=; b=cPvBxzCrXsnmhMIeul0iM41ZoyAklnEajfk58wpGMp8OpeSUeOZ+uwJZwmYBNsT0YXDV8QW4A
 j06yuC8El5xA3IT56MOUj3CV1Ibzy6TYHWDhD0qYd4g+oKS3B6H4aE1
X-Mailer: b4 0.12.4
Message-ID: <20240105-newemail-v2-1-a7fdeaa0abdc@google.com>
Subject: [PATCH v2] mailmap: Switch email for Tanzir Hasan
From: Tanzir Hasan <tanzirh@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>, 
	Tanzir Hasan <tanzhasanwork@gmail.com>
Content-Type: text/plain; charset="utf-8"

From: Tanzir Hasan <tanzhasanwork@gmail.com>

Access to the tanzirh@google.com email will be revoked upon the end of
the internship.

Reviewed-by: Nick Desaulniers <nnn@google.com>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
Changes in v2:
- Fixed alphabetical ordering
- Link to v1: https://lore.kernel.org/r/20240105-newemail-v1-1-c4e0ba2c7c11@google.com
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 9a9069235f0d..36d5bd3fdc8e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -578,6 +578,7 @@ Surabhi Vishnoi <quic_svishnoi@quicinc.com> <svishnoi@codeaurora.org>
 Takashi YOSHII <takashi.yoshii.zj@renesas.com>
 Tamizh Chelvam Raja <quic_tamizhr@quicinc.com> <tamizhr@codeaurora.org>
 Taniya Das <quic_tdas@quicinc.com> <tdas@codeaurora.org>
+Tanzir Hasan <tanzhasanwork@gmail.com> <tanzirh@google.com>
 Tejun Heo <htejun@gmail.com>
 Tomeu Vizoso <tomeu@tomeuvizoso.net> <tomeu.vizoso@collabora.com>
 Thomas Graf <tgraf@suug.ch>

---
base-commit: ac865f00af293d081356bec56eea90815094a60e
change-id: 20240105-newemail-ccd4a5db700d

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


