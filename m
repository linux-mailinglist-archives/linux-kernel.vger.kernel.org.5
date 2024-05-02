Return-Path: <linux-kernel+bounces-166384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBA28B99E4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09AA91C21E08
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E6E78276;
	Thu,  2 May 2024 11:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="UBCxu639"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC4669959
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714648590; cv=none; b=aGBPunSN4WpXhmHkbTK99+tVS+EM9gju8FGmP6B5RIIP4UqWfAqGvZ+SWSoerRVA+tj+WTQUROfVQWOqJBQIDLsP78hz2CIaZlenSO7EkY8CaczBkyf2xl4dVmnULaVMVkTnDs9B9CSJyFSMvS1NcKdVgzRxM0uQBn/4MxWwcLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714648590; c=relaxed/simple;
	bh=YBmIuvux2Nz3WQf1dIIQ6Ld9PE8PDzjfaHfR7DKWMGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRyaq+pXhVNLO6KpvhDxqXgPD591PWejbohZlqJhwv8a28R40hIZBbDprPjPfDvXpYGr7762t+adY3DoMRMTZQgoNkXkMm3IJQAl4MvmUYxlTXyjiRxRLEuF49wA6r41TcjUlSi0zfDwJ758KE1h40NtgV2G0RJOqQzlIUOshhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=UBCxu639; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1352A3FE6D
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 11:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714648585;
	bh=alIA34WXYkmJHYDf9JzzyaPI80jtTP1Uaq24imH+xTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=UBCxu639vQImDUVx8mVJ+0buLHcnoIlizToRJF6V+F3NGQqODsY+JS2MTHkdXffh7
	 5pEjooilSH7SoCD+0rW4nCFrtS1xv4HHSwtaZJRS60Ow8gp5N6M/GoiWvZ3WneZcAD
	 fJu+w12nCormA2hCgWnwAx3uEhMFCgG5P1vrpsDE/rjH8cNV57jCXlHt7EEfQbv/R+
	 Y2J1stqLvtGkHHsrcklkAzPCey4uEDG0wqM6OdPWHcCCnhFWKep37wA2qW0IsmABnt
	 ss9arEIPpKga/RqVw53VxxWRmaHAUvg+gKab/1SXY/5oDRlWqsgENX5SuG8a/FFP5E
	 MYzxD/C6KwbAQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a558739aaf4so467131766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 04:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714648579; x=1715253379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alIA34WXYkmJHYDf9JzzyaPI80jtTP1Uaq24imH+xTg=;
        b=uKS41Po78JLl2FB++tXWW1cVwjC8FOjwAwCZ8jvlS5sQY7wRLI6I2cp1n90DDSotWy
         OUIhXXNJ6Ku98MdYXMQGWuDQrDUW8qTlSqhCDxbNH/mATqOpTtLiYc8nIQPvj6dFBt6l
         W4CibKL7fhr34oJ2lVEWpi7oJJY6dTLj6Z36rRHFz46KYTjxy9KXkkumrQJ0MwELzKg+
         CYwXNlURqm3OL2Mo+64I2LSua0O04MPdV9cCZCB7UQsnTuJhtYDRPDAoXczvTJ0SGSBO
         IxlSgQsXvXVCjMTkIoqEGa6CxNWeyn+GIH+RS/sYbJNTVIm7GCgVceeT05yH97Hupnd2
         SUeA==
X-Forwarded-Encrypted: i=1; AJvYcCVlCCxKodgItWPa8Q82zp8Z77egp547Gc8J2Cg5HmcFBw53oRXNbhms6jDrWloADQSJWWqLv+OEWK5g79xducMjxwRW5am7sX4hXYGr
X-Gm-Message-State: AOJu0YzF36ojcKgsj5n3PcXozDtC4ennut/35fpmhYILnw7tGRn974TV
	4WovrEEfxscmY+Y1k8tSS75aRQmG8mMGWfv/SB3UPwcuwVzWYimCfkDuUBPIdHS51mSueQkgR6X
	qiIurqMBUh+i9jMEisl3bvSMMt1MWanW7jBbrZ9Lb/m9rs5wJHG6sACGR4m2QhASDgF2Q+Vt+x2
	rmSQ==
X-Received: by 2002:a17:906:11db:b0:a52:351f:5694 with SMTP id o27-20020a17090611db00b00a52351f5694mr1517621eja.14.1714648578861;
        Thu, 02 May 2024 04:16:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG86D9hK+ydkPVXUK/QjxllUq0XEakTYgairpW0wG9EVGdit8WtuOux1Y7bI6aIK7GFaVI/kg==
X-Received: by 2002:a17:906:11db:b0:a52:351f:5694 with SMTP id o27-20020a17090611db00b00a52351f5694mr1517596eja.14.1714648578551;
        Thu, 02 May 2024 04:16:18 -0700 (PDT)
Received: from stitch.. ([80.71.142.166])
        by smtp.gmail.com with ESMTPSA id gs23-20020a170906f19700b00a4739efd7cesm437278ejb.60.2024.05.02.04.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 04:16:18 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nick Terrell <terrelln@fb.com>
Subject: [PATCH v1 3/3] kbuild: buildtar: install riscv compressed images as vmlinuz
Date: Thu,  2 May 2024 13:16:08 +0200
Message-ID: <20240502111613.1380453-4-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240502111613.1380453-1-emil.renner.berthing@canonical.com>
References: <20240502111613.1380453-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the KBUILD_IMAGE variable to determine the right kernel image to
install and install compressed images to /boot/vmlinuz-$version like the
'make install' target already does.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
This patch depends on Masahiro's patch at
https://lore.kernel.org/r/20240414174139.3001175-1-masahiroy@kernel.org
---
 scripts/package/buildtar | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index ed8d9b496305..fa9bd0795d22 100755
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -54,9 +54,8 @@ cp -v -- "${objtree}/vmlinux" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
 # Install arch-specific kernel image(s)
 #
 # Note:
-#   mips, arm64, and riscv copy the first image found. This may not produce
-#   the desired outcome because it may pick up a stale file remaining in the
-#   build tree.
+#   mips and arm64 copy the first image found. This may not produce the desired
+#   outcome because it may pick up a stale file remaining in the build tree.
 #
 case "${ARCH}" in
 	x86|i386|x86_64)
@@ -101,13 +100,12 @@ case "${ARCH}" in
 		done
 		;;
 	riscv)
-		# Please note the following code may copy a stale file.
-		for i in Image.bz2 Image.gz Image; do
-			if [ -f "${objtree}/arch/riscv/boot/${i}" ] ; then
-				cp -v -- "${objtree}/arch/riscv/boot/${i}" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
-				break
-			fi
-		done
+		case "${KBUILD_IMAGE##*/}" in
+			Image.*|vmlinuz.efi)
+				cp -v -- "$KBUILD_IMAGE" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}";;
+			*)
+				cp -v -- "$KBUILD_IMAGE" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}";;
+		esac
 		;;
 	*)
 		cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
-- 
2.43.0


