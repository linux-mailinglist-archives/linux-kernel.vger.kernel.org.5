Return-Path: <linux-kernel+bounces-50320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB64847759
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E86B1F2AB9C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6CB14D449;
	Fri,  2 Feb 2024 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fP2F9ZTm"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B4C149012
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898262; cv=none; b=nq7tvtScQhtRbXNJuDlTKxCan5F0V5xZW1qtBLFg1b15crZlgkkpguPv526rfl/3sUAK1EZK1smdZqgwkepR/ihadj80IU3LX/+JjxvasEPzlbpdr7E/I540uqwyMc6RNXdIrDBtT2yq+h8gdtQy4Vi76wKHL7vS37Q9RAN1yPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898262; c=relaxed/simple;
	bh=4FocGmwzec4qenV/twhUdPlIXyJK603gJxoCGO40e38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N+zy99lQ2tQRvoSwdIo7MvexArN85bh7goPJX2oz6KfrJdmqdf+ESMqdDifUBu6XvMFjdWL+4HKcVmdAw+legvvx/dKfKRjwUN8AtH64WnoWf5OK0ommmajr6QJo8XtcQ0hpBs1urtcuTYe50RzV3Bss3uDrUxpNzOjQ89yWZzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fP2F9ZTm; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cf5917f049so28150061fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706898258; x=1707503058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NxCq1DYLQWZImt4YJIkeYnEGmfUHZIuEhV7irT1KP4k=;
        b=fP2F9ZTmwFTjnHIp4tvlkA8Qt97rX3Owg4YuOt75B6JNVCBUFtL75P3sbgQ75NaQuX
         ekOnps6OlLEKaY4EGwfV8DagkwPcA8T2XfXvfeTeEy6Su9RICQirTeUX7AZT46ET2RLH
         nIWiBlXfhp0HBicqLzup8/XzuuCJ/2CeNYQbtWa0W+ERwyegoDgbleJyln0FOlRnRsZk
         bdz6NEzDbJLmpJe23D4VqF+j78HATijZsYZatFsRisar4ebw6iMXCG6Gee18XtdYTxIg
         FXpGieyxCk39BNxL4W0Ir5zPMDs8AQqc0xT/IIK1bO+n1GzX/LID83EUTgfyow9RuX8M
         3x/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706898258; x=1707503058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxCq1DYLQWZImt4YJIkeYnEGmfUHZIuEhV7irT1KP4k=;
        b=ZAHCn8FJ7QhrPOdmAUS8rxx59wtJk6gqYMcWYSGO9s6tEUtgdFP/96gNcZ3mBnkgMx
         dXBY0SS/fltv2q7tEHfAaxXoAM4+XIDCkMBNv/Yy6t5hhLhgyjkX9QqgD6+/0E/A+0/k
         p1yoa67IxTYkbWbFBjkqVpWzEZ65OdrIiXlMCdoAj+CNpYfTMg14RQzPwaWpyk6ZYJRn
         4/k/Lhqjajckr9i9VOs/ddmsNc73vA2ljsX0NnD2IW4kdhpjZj/OB2LuXroLUFgtJp+Q
         r+WS0kSdyhqy9OcDZSDkEx8CztJ7Kdalw85xPr2WFCLms6phHItDFO+UUKiUUvlMRs8N
         HNXA==
X-Gm-Message-State: AOJu0YwVJp+g8i3ZLAu73/NWfHZB3af3thn13A4ffeHWmohORPSCrDHl
	P0Ldydhv2vwrb+yd1AlSHUJOpaBWCmAhn36mc+b5X6EkdbSVcVn+
X-Google-Smtp-Source: AGHT+IGB8VmVqe5gw0vSUmo+4QR9D9miuTGaTkYrwu9sOBSn+UUeAZ0XfAaiYayX4AxkZ92jAVNdEQ==
X-Received: by 2002:a05:651c:556:b0:2d0:7f19:9141 with SMTP id q22-20020a05651c055600b002d07f199141mr3331878ljp.38.1706898257472;
        Fri, 02 Feb 2024 10:24:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX8BsMWmXmlLYuhzfqKw/PZ/WHJGCZAkrPHgnj7Pk/yMKqV9ihJ1hOlvCPshTDXRDCmmzySgBFz0bFYqMeLLwGTHUOHxvGFTGhnV4XdLL5fYcICuFvoHTIVomB6CsVnOfAXQGsZIrGI0pu2N9ybjhEqxeGBqVu6K1ux5QhtGFsyGdM1EFo=
Received: from tapuz24.cslcs.technion.ac.il ([132.68.206.47])
        by smtp.gmail.com with ESMTPSA id ch17-20020a0564021bd100b0055c8a30152bsm1002072edb.83.2024.02.02.10.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:24:17 -0800 (PST)
From: Nadav Amit <nadav.amit@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Nadav Amit <nadav.amit@gmail.com>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
Subject: [PATCH] vmw_balloon: change maintainership
Date: Fri,  2 Feb 2024 20:23:39 +0200
Message-Id: <20240202182339.1725466-1-nadav.amit@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jerrin will be the new maintainer of the VMware balloon driver following
Broadcom's acquisition and Nadav's departure.

Update accordingly:
1. Update the maintainer name and email.
2. Update the reviewer list to Broadcom's, which acquired VMware.
3. Add .mailmap entries for Nadav.

Cc: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
Signed-off-by: Nadav Amit <nadav.amit@gmail.com>
---
 .mailmap    | 2 ++
 MAINTAINERS | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 2643b7203a74..177f5b998a23 100644
--- a/.mailmap
+++ b/.mailmap
@@ -425,6 +425,8 @@ Mukesh Ojha <quic_mojha@quicinc.com> <mojha@codeaurora.org>
 Muna Sinada <quic_msinada@quicinc.com> <msinada@codeaurora.org>
 Murali Nalajala <quic_mnalajal@quicinc.com> <mnalajal@codeaurora.org>
 Mythri P K <mythripk@ti.com>
+Nadav Amit <nadav.amit@gmail.com> <namit@vmware.com>
+Nadav Amit <nadav.amit@gmail.com> <namit@cs.technion.ac.il>
 Nadia Yvette Chambers <nyc@holomorphy.com> William Lee Irwin III <wli@holomorphy.com>
 Nathan Chancellor <nathan@kernel.org> <natechancellor@gmail.com>
 Neeraj Upadhyay <quic_neeraju@quicinc.com> <neeraju@codeaurora.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 668d1e24452d..12a07a14fd43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23001,8 +23001,8 @@ F:	Documentation/driver-api/vme.rst
 F:	drivers/staging/vme_user/
 
 VMWARE BALLOON DRIVER
-M:	Nadav Amit <namit@vmware.com>
-R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
+M:	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
+R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	drivers/misc/vmw_balloon.c
-- 
2.34.1


