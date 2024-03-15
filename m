Return-Path: <linux-kernel+bounces-103989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E905687C784
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4E61C20DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AAE79DE;
	Fri, 15 Mar 2024 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+uvzB94"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF86FB1;
	Fri, 15 Mar 2024 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469858; cv=none; b=BwOdbTpT9bsNKHE7dK02LqHLlaT1+0+39OlDMoLUzHsc9WBztv6EG6OYwmzbSBdhvdqqW+YTNUf010xKpKdNGm01y7gICRb0w3HI9mvDj7HfZRGG83fNchIjx5Z0wQM8J9pdOWVFUB78k6Kl7qH9Z+UULCZNtzDmecDeTFhh/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469858; c=relaxed/simple;
	bh=dpVUTr5Plhl058/uH4Kri3LO8Jz2P9RHi3V4RJfMjhs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bmchRuuI+/mY/kMfP5Ke1J9Zag9qBrdsKW6aY8RlfiWtk8jEldgt6Mv60yM5CkvuVuT8sOZh9IKd8kzb+Gd5MI28SxBtn9iscSJMxJ2HaM48zSGKj6TBIb8h7KZzz4FeB7pXKYAV9KAnBrrMKNx2rhO+T3+Vxs1lwloKteoysZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+uvzB94; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6910c1f983bso9779006d6.0;
        Thu, 14 Mar 2024 19:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710469856; x=1711074656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ejYFjYDwJWT4LMREbSvJVA0/AZZXGt31sFPEUshDaM=;
        b=N+uvzB94ntlYXes0MCqinhl6lRJfxCXWT+GhdfAah4FAqgN4K8gCqcc1ShUcz0RF5z
         oaiMxmWco07J754LIv63ZcZMHd4Z4BV1b+GD/xRb9rwh0Ecl1XlUvz3V57pAza1xpaIY
         RaLBFSMpNquQNWMbtqTLfCv2WpffiiLly1zHUFJJ4pV43HUQH4A5/Bhfu7owQ/qOa5IM
         +3gswgEcoymFahrYEefZI3yyjZPFsehKBdFeWgqsmMUXzJD4zVEXZX/6JFILOfNq8WEQ
         Z8+nSQ7gIE2t0eIDf0FvMrFiW4RWqmnNxQJNlRXtdgc5gHPWGW22LQ0CqDR6mOjcQyHG
         gPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710469856; x=1711074656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ejYFjYDwJWT4LMREbSvJVA0/AZZXGt31sFPEUshDaM=;
        b=koFgU+OwqFHYGihrpy+ahu7TqTJDfu5mEIkqsboh5JIXq3zs6vbCW1I8GxS+IgN5W1
         GyZ019sqxPWrPhfiDQqYCU05fFqb/YVKBtobtxmRoEyP5hP4/PKmpgKuNruHCdaBFdsI
         KCExp8mDB5SZXLq370kyUe3K7umBpDXE1PvGWiKy1LULpra1oGUGI3YpCgpioykrzZlo
         8l2xG4zYjulQve7MM7LKFov8bm4nXIXFTufTndfWna6ixLQ4qFrVhtw4A63agps8A/LB
         tJdwymDoJgo5fv7FbtAhenVy/01ha8tZieahK7xXD0Pv0mmpCxY4ApWI48cAXILyPWQF
         8Eyw==
X-Forwarded-Encrypted: i=1; AJvYcCVr6h2A1JlgdZrO4bQau+Z3pK6U8JpJpxjyxnslXftkWdm1aK7mHRZVQ6IuKDwr/diqeBgIQ0PYOp+xU9/dm3PFNTqd8Y/8Yho1irz7l0idUun4CXDeaXw0Bh4fL2JRLRk26izwuBhg0oiB
X-Gm-Message-State: AOJu0YyS56wFRj41Pvn3tpuKdQ7nE6ibK0kXQNHewIIl23jyYLqxZUjM
	/oPbs234ycTtrDsy1CvqShdrduFLv8QIIgn0LmBklRyg+koplfGh
X-Google-Smtp-Source: AGHT+IGBD4YCat38Hgt0nDvoW+vYKiJwyKQRJNNvXlsrqMytJXWp8/MfZkqgJ7FC+uUYvVjKiFpA/A==
X-Received: by 2002:a0c:f8c9:0:b0:690:ad9f:e3dd with SMTP id h9-20020a0cf8c9000000b00690ad9fe3ddmr2540083qvo.63.1710469856213;
        Thu, 14 Mar 2024 19:30:56 -0700 (PDT)
Received: from Slackware.localdomain ([191.96.227.83])
        by smtp.gmail.com with ESMTPSA id im14-20020a056214246e00b0069049298fccsm1292579qvb.65.2024.03.14.19.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 19:30:55 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: masahiroy@kernel.org,
	nathan@kernel.org,
	nicolas@fjasle.eu,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] scripts: Improve source code readability by eliminating too many slashes
Date: Fri, 15 Mar 2024 08:00:38 +0530
Message-Id: <20240315023038.4320-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.35.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have tried to eliminate the convolution(visual) of forward slashes.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 scripts/mkcompile_h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
index 2596f78e52ef..d6a7b22d23e3 100755
--- a/scripts/mkcompile_h
+++ b/scripts/mkcompile_h
@@ -6,7 +6,7 @@ CC_VERSION="$2"
 LD=$3

 if test -z "$KBUILD_BUILD_USER"; then
-	LINUX_COMPILE_BY=$(whoami | sed 's/\\/\\\\/')
+	LINUX_COMPILE_BY=$(whoami | sed 's#\\#\\\\#')
 else
 	LINUX_COMPILE_BY=$KBUILD_BUILD_USER
 fi
--
2.35.8


