Return-Path: <linux-kernel+bounces-80167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C2C862B4C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF241F215F3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500AC1758E;
	Sun, 25 Feb 2024 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2E+HvhU"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C8914276;
	Sun, 25 Feb 2024 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708875969; cv=none; b=H+Y4issQ5fY6V5YI7FskvZTSHG3W2fLIUxqo2RUp7Au9jixp6WXJ/Uii4XGUCzCBUiR4vDUnlE0HbGd2U3XsFvOoYDWyH0V9wVwDQg5VnuEn8NzmVzKdwhcoRRrDwmVUTgBAho6MrQOB0h7nkPYBu3b8FYbRh0A0Dcagh1S2RhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708875969; c=relaxed/simple;
	bh=t9F39Ikr4dVm3edibCROfCU2YuulRER1E6uwGvflmoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UvhaT4L30rwCExmvGuiTsJg/QGjrXjUCJvWN2DLdFU8h+z7PKCGYJidf9utTnCt8MHWomtJ9MyREqOPqEVwUWgsSJ1jZxA8lGD6LnGtx+cygz7LBlDjte5P4BkiMhbpONBGnkKplEQw1MRxrAdAUXdlSmX4iPCi3H1P/87dCE9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2E+HvhU; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-58e256505f7so2419007eaf.3;
        Sun, 25 Feb 2024 07:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708875967; x=1709480767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ie9GBSxINBIsyz8X4p5mFdB/eNwrXZ+fsuhlbACghM=;
        b=F2E+HvhUprOU0YyJsYG3NBVPRAbh7YHtS9xxQZQ+zAmGZl0jCk/xJKtWP6PjuvSWxK
         NQG8iE0ivfEWsRm22D/2BcwEjSeE98W2LjoOJUdNhoNEJzqO4ttbQ2KZXpYLiQqfPB7i
         3hFtsZNWZ/5r1ZnrhJ0Xx++foU+rUK4Iat+aJoCwaA/9FnQYyJYEUuSYt5NxpuXQ2pgy
         nOOXSMiE0MWfXyifHJlh9M+hnjXam6V+2MdkRlTkT0svHxuU/NLzHGDUEufFEgqfQBkV
         DveFwhljOrztVadXDGUlieO9T890I3FJ1bVcDZxywU3DwX/RemgS63eflnzEMMNprIHV
         q9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708875967; x=1709480767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Ie9GBSxINBIsyz8X4p5mFdB/eNwrXZ+fsuhlbACghM=;
        b=FaghQzoAZRdhMsE6JdlLJQSIWuS6IHJQVEZNlXkhRMaGdRD+m7mZzsktg/Jjwn/pv9
         fe0RLrmLFlUuFiwDNmXCiGDUp5YfU2gwtWfzQpQMf4T6lPqgqiZSUS9uS6q/Rwj7MAih
         NJuq20FAssExd+OxuYyeMsIISGWgjr9vWELbh1UxlJA9uHxBW0aLL5jdoDkRqUT61qZF
         W++TRC59dlYfuvYLkodDk5mBI/YYnhQYzmDErcvvFkNecaehXZxvY0AnCoRJHbmlCZ5T
         W+A7qXToY8Ij0FzngLooHnCcUfsxI/6L9xOK1vmQs82nyK2Yj7DOoVWsm4RyvnW/2Ytc
         iBJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKidxCdxGXTkxYT3T0tLfEd3FCgU3LsCGUgERTcomqYObU3WKqKejvGnKDjYgDOp7QnTtmS0mZLyicec/xSkuF73nHd4bGhMCnQjMfeEhZ2xD0wQriaHN9Ie4SAQMI1qqTH5KxdbGSUkdNG+BXLOy5EC+W8pfyX0+bLtFk7JanC0o=
X-Gm-Message-State: AOJu0Yw+D1e3LNjXN0iRZl7IhTcTsc80vu/o4DFIPi3HIcM+1pNaLS2j
	tFBZbqp4/qddGwP1s0KtL0rE/EtKFPWfMFvxnacLoFrfLsGWNGg/
X-Google-Smtp-Source: AGHT+IFWhLZfdDmqeXxHV2Hz5s5QMMfN88PxbrSK4NtiVrje2/QYuuUDVC/eIo94JaLTYSpskqYCow==
X-Received: by 2002:a05:6358:6386:b0:17b:57fd:ec5d with SMTP id k6-20020a056358638600b0017b57fdec5dmr7714634rwh.24.1708875967244;
        Sun, 25 Feb 2024 07:46:07 -0800 (PST)
Received: from localhost.localdomain (123-193-217-197.dynamic.kbronet.com.tw. [123.193.217.197])
        by smtp.gmail.com with ESMTPSA id h18-20020a056a00219200b006e468cd0a5asm2541701pfi.178.2024.02.25.07.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 07:46:06 -0800 (PST)
From: Yiwei Lin <s921975628@gmail.com>
To: rafael@kernel.org
Cc: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	s921975628@gmail.com
Subject: [PATCH] Documentation: PM: Fix runtime_pm.rst markdown syntax
Date: Sun, 25 Feb 2024 21:00:57 +0800
Message-Id: <20240225130057.42633-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The '7. Generic subsystem callbacks' should be
a section title, but the markdown syntax now is wrong to show
this as expected. Fix it so we can to link the chapter
at docs.kernel.org correctly.

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
 Documentation/power/runtime_pm.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 65b86e487..82bc76d3d 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -730,6 +730,7 @@ out the following operations:
     for it, respectively.
 
 7. Generic subsystem callbacks
+==============================
 
 Subsystems may wish to conserve code space by using the set of generic power
 management callbacks provided by the PM core, defined in
-- 
2.34.1


