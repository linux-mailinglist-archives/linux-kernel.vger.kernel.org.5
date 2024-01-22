Return-Path: <linux-kernel+bounces-32939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D23836235
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3E92895CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E793D0AF;
	Mon, 22 Jan 2024 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fny94JHp"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411993A1A2;
	Mon, 22 Jan 2024 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923421; cv=none; b=JFil9ybvhFW6KgB1z++e48S0B9Cr3OXaDYpoUjTMsj0y7TwUbwgO0KTsVnyYK3lZY24mdSHvk1dYRaufs91vJ7uNFJnFdZha7LSIgeh3qu5gtvW+DtQsDDnWALTe15oBs80ziP1ImF9hMbc+amHve+WLxhbNjA+4WnG0sH5wPZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923421; c=relaxed/simple;
	bh=vlRBYdNiixxTaILLeh6MxcF3ZKQkhQilWesTZt+ciJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iyGjFgqeISGYC+awZWrT4akxmNja53YZIgZ4YVByn1prO6MY/qvuaES9WMHnkhc/yk3sepDSz8lPzE9mwB4SD9chBltITu4EHj8rV403N2gwQb+uOFYwfjUqRwFzPzkEkv3rz0rc7y0kiiZJUk1h3hBHfZI8RUEhYEl39Lb3fv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fny94JHp; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-361ae51a4d9so9631155ab.1;
        Mon, 22 Jan 2024 03:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705923419; x=1706528219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M63RrCQAuLU2mfBJIoBlvu0cGr4uAclNR33OskO7lIQ=;
        b=fny94JHpJmtse1c8/SKhKO3MCc5ZbebZZ+S8BXsim2xA8q6G77SK+NOpOM+B0c3mqI
         ifbwTe5CPFK3NFXnTKgDc22Z+JUqVNOVguFr+xAp9B00mVdSFas5vKl+1oabSZsjX44g
         8ioxGKwWPPntGMd9MywuBXeb7TLMYNaYX6uLs2Zspb5mZwsc9gq/R9fxNbbTFax/Y/V4
         ByR3ai0DojCL8pOPvLUzzdhP5++OM+h57/RIpynI2kZAPQwq8shHS5IwrPw7M+wZ29Mo
         mA3kZhWzA/F7APpfq2QACM/bMEdDPf3JPbnbii1oBem2CO5SbarBIFKLy4XHo7WSwlSO
         PDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705923419; x=1706528219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M63RrCQAuLU2mfBJIoBlvu0cGr4uAclNR33OskO7lIQ=;
        b=PX2pB38UsNrZvS8viZ57uqaMAzxkRBbZVdY9R19XMdfEVOgDYUZ/xxVvzh86rXhHB7
         ar3FtDClu1eI0qo2YDx9EO/h1SduqdVpTy9W8TgQbq/CW6Ynqf/dUyWKSTEtKYlUfzdd
         /ZoAeBeoA/zmriOPXqVIfNhavitunoa+d8Tc1f08y/6hEEyzu7b3d2vgrOs7JgShgdQH
         D9Md+QENey6Ck7L4+tqJwCHAOarrxnSF3rsTJOh00U/Tjtd3VnnjNst58Fm7L064B8ri
         +/tzLsux5iFkDSEKrbgxmnK03D/xZlGlDiNIllGEigLsPO5Lh+h0DAGVWvdgxSSqsINC
         Fpfg==
X-Gm-Message-State: AOJu0Yyui5Yb+m4OS8QP89fgREdBAIxWC3LOjdwg8Nv73Idh2AZAfDX9
	5aoL4VRdPicfgyGppXsLMAxyMUj/L9pL6HKJUrMmxOaZKLyTW1bvgFDo9gty
X-Google-Smtp-Source: AGHT+IHv0bOfcxBB9d49Mq8AXm1lpOFB86klKQEurZ4/U7A6hkBvEDw449booFlFuzB05GsdCQVn5A==
X-Received: by 2002:a92:d05:0:b0:35f:97ca:14e6 with SMTP id 5-20020a920d05000000b0035f97ca14e6mr6486398iln.49.1705923419248;
        Mon, 22 Jan 2024 03:36:59 -0800 (PST)
Received: from rigel.home.arpa ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id l198-20020a633ecf000000b005cda4d88933sm8216412pga.43.2024.01.22.03.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 03:36:58 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH] MAINTAINERS: add Documentation/userspace-api/gpio/ to GPIO UAPI section
Date: Mon, 22 Jan 2024 19:36:40 +0800
Message-Id: <20240122113640.93162-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Documentation/userspace-api/gpio/ to the GPIO UAPI section.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---

Now that the UAPI split out has reached gpio/for-next it can be updated to
include the new userspace-api documentation.

"No capes!" - Edna Mode.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..2d0bc0e128bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9148,6 +9148,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
 F:	Documentation/ABI/obsolete/sysfs-gpio
 F:	Documentation/ABI/testing/gpio-cdev
+F:	Documentation/userspace-api/gpio/
 F:	drivers/gpio/gpiolib-cdev.c
 F:	include/uapi/linux/gpio.h
 F:	tools/gpio/
--
2.39.2


