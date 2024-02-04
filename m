Return-Path: <linux-kernel+bounces-51942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C24F8491AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0AB41F21468
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9326FC09;
	Sun,  4 Feb 2024 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="FxjbEnh4"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EF4C153
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 23:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707089424; cv=none; b=tdiSfkeZnHKIy7X2XsYt3mR293hU83SxgbXZpouF0NIG1mrHDUNlPToC8JATxJsWGmNsp+JVE0u9ey55nJWuaZVT0UxG0U7/cYKk1y7ZROfijNVUJX1Zr+7av0IytMPID7cq37br1T2CxfEN2nqPpKFYCaeFyr+E7Ytn/SZV8QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707089424; c=relaxed/simple;
	bh=K3bUn+GZczaYqZp1k8uytl2FDj/+fQ0WkGUZ6BZIAH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dea1zxsMZwgUXuzjP24pOqHaXd2TpArkGnQU9I8eZ+8xkSwKP3wDJ+oJkC02FY6t6bgXYFGIFhOBm6kjIOShKdchIBRcuUBEG5j6WBnSQ5jBpgJ4HhuJLslQ9cwkYwAl7VBfwUR0wX5QpBR6lBTwoGVFjSdJQ35MeV/Pb/olsiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=FxjbEnh4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fdc7c97efso1047265e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 15:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1707089419; x=1707694219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yEPb87LSwbm9jYroFks9JSGpfASa83NBo9G3kNUG/KE=;
        b=FxjbEnh4IIM7TeX/gehuQoHnfFWHxG5daQOU5H5tBGZee65PIvPQKLiZpUd43/wUcU
         V1fydOI5z2SUvgfTKiRt6hjFVE70wqG1BHMQzLUfVG9dBXI3J4CNyqw7HS0cG9/PXUpG
         6dhLf7ylgcIwS6jS6giIM/8mzXYfBZN03xjag9zw76A7jbiT4aFkd68SzTHiXmpRC208
         SV2oOOj05O2o9El/GRYpZ26ynUACMrZTMHFUpvQJdFxMy91ahDAGHJ8DBg7YaHXqYRop
         2b31Xky2QLuEQ1gpVQoWsrz6JXt4teL3UZSkGPvEz2I3vhpJVZA88Mv/3NEws/vswWZl
         0Rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707089419; x=1707694219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEPb87LSwbm9jYroFks9JSGpfASa83NBo9G3kNUG/KE=;
        b=uH3g3ibZofICRnnhCC6uGA1KQhlqNs0//DmoFuYUJ7WFRwzX6cRM1u1TVPKkHnGntd
         99tygqOi/2jGWsOL3gJyzGSrGM1gFMJvcFyojbWkoV2ZoWupnT+EdXtW1eXfmqkrWD9g
         DS42kdLUE56II68C3OAZHJG42AtPI0DRkyA4shwrqcGyoet78DaW/p+WZ0ITTDxb1uAS
         k6l2iFuhosd4+hX/5bKevROQ/S24cvQl8chaDSwAmZpoxHH9Da/rEG9MpbjlZlTWnxsJ
         rPEXf0nERiE+WPHvrcCsNRhSaKsFteXPy01XKPP9KLatAMWGICS1DJFkKTRq7FZyuuX8
         urOg==
X-Gm-Message-State: AOJu0YyMSN74KN4tgcjWby3sfyZVyLtdiaBTXxn1xWnsdS54y5d/GL7G
	vCnrB/hEPEPa3hdZcg66R3LbQiebGhxoZ1NaJG7LAY32BzVHyLyn/2pooXwi44U=
X-Google-Smtp-Source: AGHT+IERCgUD6S8tICPLfqwYk0IObRcmvsVwXEjz9tYMS5SaR/gEB0Px5yk2IcRDaMmJGFFJaR2N9A==
X-Received: by 2002:a05:600c:1d91:b0:40e:d425:85a with SMTP id p17-20020a05600c1d9100b0040ed425085amr3551319wms.17.1707089419436;
        Sun, 04 Feb 2024 15:30:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX8lAa40j9Rf5TGlJvkrHev7zFKoJgkpWjLouHpg6XufKbRLABz6HodyDHWHPXxtx9i6kpvPoV5WEh4WJGYeXNGqlgDVWEA2hd8YrBppBhJPuRTomCMhKW+OJvn36PW8QR/hkN3Vnu12RNmdVXRqdlJ4Kxhr46cVDl7DSW9qnIFK74oo7dbj7WmS6o8Y/Z2ODb6uyp8QNOLbU1VufhZg4oiVUBsKktgx8fxxVxan3cSDJZ0rU9ksWHwL2LNsgGgcPOxOf5TzdjniFaqVt3No+uNBlIC1VCSi2Bq1/L9x+eMCQbiW113tIlCQ/UjkC4CW+rvClpktYvaPIpxAdTst4Ono323fkgXgpw4Ri+HsBp27bHShXGrIvfQSKWR0c4BsVw8xTaOUUYFmV3+tF8US9IVZ7cnlO2abGT3EHOwLxMwVqPAAix4DKbBSZD+NjTaXxPmnbFA4SD7rnAV4A/GiCtGJ4Pqws4B5eMbLdqllg16azQxxIaLuCe43I6fpIheG6JJwhmtavBE1chUcrJUnRp2cxcFBki0o4OiskaEm1SHwHKxKmPG4Od7LyUpCzxYJDh5+rOoGpD8sce8rPc2TFJ+QfJDESSksYOfLAJHlhemOPghYYVWpp9xRA1i7QtPHFm+0kIJj8FVJY4g1vewqfoLxgI4WsWAyQFWRJJ2bFuVpoWocqej1AV0v239PpKdTq30Ekt7NNtU4AodG7+Z8TUVbt1TIGUK1vV8VAHKlt+mH5g/42hwwMBgHphSB4egeAbvMlKLRaR56V9eCpSA3sLlT5ithvs=
Received: from P-ASN-ECS-830T8C3.local ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d588d000000b0033ae9e7f6b6sm6822576wrf.111.2024.02.04.15.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:30:19 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	x86@kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>,
	Darren Hart <dvhart@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH v3 0/2] printk: CONFIG_BASE_SMALL fix for LOG_CPU_MAX_BUF_SHIFT and removal
Date: Mon,  5 Feb 2024 00:29:43 +0100
Message-Id: <20240204232945.1576403-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series focuses on CONFIG_BASE_SMALL.
The first patch fixes LOG_CPU_MAX_BUF_SHIFT when CONFIG_BASE_SMALL is
used.
The second patch globally replace CONFIG_BASE_SMALL usages by the
equivalent !CONFIG_BASE_FULL.

Patch history:
v2 -> v3: Applied Luis Chamberlain's comments (Thanks!):
* Split the single commit in two : one functional fix, one global
  removal.

v2 patch was named "printk: Remove redundant CONFIG_BASE_SMALL"
https://lore.kernel.org/all/20240127220026.1722399-1-yoann.congal@smile.fr/
* Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
* Reviewed-by: John Ogness <john.ogness@linutronix.de>

v1 -> v2: Applied Masahiro Yamada's comments (Thanks!):
* Changed from "Change CONFIG_BASE_SMALL to type bool" to
  "Remove it and switch usage to !CONFIG_BASE_FULL"
* Fixed "Fixes:" tag and reference to the mailing list thread.
* Added a note about CONFIG_LOG_CPU_MAX_BUF_SHIFT changing.

v1 patch was named "treewide: Change CONFIG_BASE_SMALL to bool type"
https://lore.kernel.org/all/20240126163032.1613731-1-yoann.congal@smile.fr/

Yoann Congal (2):
  printk: Fix LOG_CPU_MAX_BUF_SHIFT when BASE_SMALL is enabled
  printk: Remove redundant CONFIG_BASE_SMALL

 arch/x86/include/asm/mpspec.h | 2 +-
 drivers/tty/vt/vc_screen.c    | 2 +-
 include/linux/threads.h       | 6 +++---
 include/linux/udp.h           | 2 +-
 include/linux/xarray.h        | 2 +-
 init/Kconfig                  | 9 ++-------
 kernel/futex/core.c           | 6 +++---
 kernel/user.c                 | 2 +-
 8 files changed, 13 insertions(+), 18 deletions(-)

-- 
2.39.2


