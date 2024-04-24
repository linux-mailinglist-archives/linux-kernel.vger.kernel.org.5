Return-Path: <linux-kernel+bounces-157599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0C78B1371
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7BD5B221D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB68484E07;
	Wed, 24 Apr 2024 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IYRsND8u"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1BD77A03
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986265; cv=none; b=MI0zDGEKYa0eMdr1l5nNzRTtTbAfwHnT7bPlrF3kwA+fAJ5yyFP43UcpSU/eHkjA8SD9ws4lEhx88/O3aAYhXWngkXBjPV4H4soHVhbf3TjQbqGSRHAsmE+I2hD8ZkIatyJQWT0MePsm0R6i+RJWP8TpE5lkVmD6MUcj/3TlueA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986265; c=relaxed/simple;
	bh=thTGd+hT/FhiSvmm/b+nzZnBJHdZOOvS+xvizd9J118=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V/zeQJFH8tBlAVeQoBcWgV7KLLJmwATOd43+HL/Qfpb5HgX3ZSW19uKjcC5Y0SEOMfbSpaO/oIXFJ6dGjl0Bd5aRGqolNID9HW5vAHN07Mj0vl92EeHrX77fhtM7VHEE0TOi5I2L3oJy1X+PfsIYMFWh1Op4q4BtPg3XqCbIs9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IYRsND8u; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ecec796323so284194b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713986263; x=1714591063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lK6fStXdfyST1TlQT33JqKtHmOFdPx874FRFgnYIMq0=;
        b=IYRsND8uQ96L1jlx7gNztx15PlfSOZxdGMQnXuWVc7/687Pj6VHBBlNwL2kN+4CKIZ
         uPS/q/DcSnIVHMgUYJj+JbEOwvH23RKAnxXnsakI9Ui/mhHMcQgCj7Gpum/KxJqEoWWx
         lak2LNuFSU8TuLFE2hdPq5yk+k7/2csP6zYw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713986263; x=1714591063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lK6fStXdfyST1TlQT33JqKtHmOFdPx874FRFgnYIMq0=;
        b=mAUKH4Q0mq7uVV6ATVHW7tfDRF/+14pxWBYZ/6Uk+YS1yhjugHZ690EkBGec3tASnh
         roiFDO7i19XD64kN5kQLy7jq2IJ6Z/yEjSK1SEcDhA7MFQAbNWNz9IpbleTVSScQY/m0
         mH1pw8tLX8rSPmqvhUOLibabwyBJ7b1nxfBomKk4V3WvX76DV4+X9bfjuon4hPvUnDe0
         E1kxwTagYK3GH1u8dYSOZcnTJxSJjhxN+RWeTnxu8fx2TqmbybDRCcpKNmMtwpFOwjNv
         oE+I4spyBr3cmPxkS9LtEGCwzzX9N61OHOXBpuo2aEFNTgk8hEvdR6HKcn5RYtfUHzzE
         pfrg==
X-Forwarded-Encrypted: i=1; AJvYcCUZnT08pVmEgZ0iTZk3on5UDK65juVx1pnmaMpF4pAi42f4lvAYNICB1QIuO/GKKEzdUEojgdh+PtjMpbmWAmL7fBiJpESMouttOuSG
X-Gm-Message-State: AOJu0YzhoeKF/yfMX6ruD/w5xzL6rfL6tNGQ3yWlBMLj1A+cHmqn/E/j
	UVlI0iRMJTE3h7+tzWSUh1myAa+Ss+jDSMetoRXFP56dEaegFjFx8W8xLe3CLg==
X-Google-Smtp-Source: AGHT+IGJLxaAQi7YYyI9XbiHvHbGRPs5if1SJBeA9ajOFNVl3JLCYaCGsqMFSmevBkhPO0HvlcVaaQ==
X-Received: by 2002:a05:6a20:3c94:b0:1ac:e379:5548 with SMTP id b20-20020a056a203c9400b001ace3795548mr3896074pzj.45.1713986263198;
        Wed, 24 Apr 2024 12:17:43 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id km18-20020a056a003c5200b006efbc365de9sm11772738pfb.121.2024.04.24.12.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 12:17:40 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/4] Annotate atomics for signed integer wrap-around
Date: Wed, 24 Apr 2024 12:17:33 -0700
Message-Id: <20240424191225.work.780-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1984; i=keescook@chromium.org;
 h=from:subject:message-id; bh=thTGd+hT/FhiSvmm/b+nzZnBJHdZOOvS+xvizd9J118=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKVrQ9CtzJNlSzJGvLo6MaPqAU2ghmpei4/WPg
 q/q196TYOWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZila0AAKCRCJcvTf3G3A
 Jk/MD/9b08KF50tco7aDBOr3+0y32I2X/aj83XHW9qi8joeu8U8WCW+0yQp0s09qE1TvMVnDUsS
 EmaaBlYOva9kFzL63LQCuJl4n83UUm5u/bZNye8GJpH/NDD6lIpip+WZC53FIZx55YclzxrknXa
 7mu4138bls6ycciUIlHSFTrGcjphUCaw//r6fzm2MX78GftZKNCtURzKpPKCYivqGDAHaVKwego
 wHYUvRSi5QJCtIheikvkR2OTaScKZeZCAaWCokTIBhfJW5y+HZEpIBm9g23TIIb3AlQR7zO/SBg
 EMSdjJXPqeqfNVfWyP6QZo8ljWyXUh1ZcF68EriCKbaBWpd6Dwe7cwUwLeYuQr05KBTeJxqJ/4E
 A4VDBN+MQ+H5y68uRWT32gvAenZHYoIy84wLnukKJHtl55cBw7em3LxDyzApDUFoO0A7luGMnvf
 XLZ7RFzf7vX2Tjz4qQk0WfmujcwpCgiLtkrKY7pa97e2k9Be230TyBG9mhHnVgiZnnce3hAvzMc
 g100s4qtOfFkQub38z8Rb5f7Khr1uUDKdzDAnGpFG2nPDs5BmqNBL3dJW5hw1Or8MP6E08bQhdu
 7RpghTVeiCyYB1WgF7c691itQEBxSBTDz3jZ959PdEaIVu77HU5Xf6kIoWBJVWjiKW1LcaILhIm
 5OE1koy Q41ty9nA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

As part of enabling the signed integer overflow sanitizer for production
use, we have to annotated the atomics which expect to use wrapping signed
values. Do this for x86, arm64, and the fallbacks. Additionally annotate
the first place anyone will trip over signed integer wrap-around: ipv4,
which has traditionally included the comment hint about how to debug
sanitizer issues.

Since this touches 2 architectures and netdev, I think it might be
easiest if I carry this in the hardening tree, or maybe via the netdev
tree. Thoughts?

Thanks!

-Kees

Kees Cook (4):
  locking/atomic/x86: Silence intentional wrapping addition
  arm64: atomics: lse: Silence intentional wrapping addition
  locking/atomic: Annotate generic atomics with wrapping
  ipv4: Silence intentional wrapping addition

 arch/arm64/include/asm/atomic_lse.h          | 10 ++++++----
 arch/x86/include/asm/atomic.h                |  3 ++-
 arch/x86/include/asm/atomic64_32.h           |  2 +-
 arch/x86/include/asm/atomic64_64.h           |  2 +-
 include/asm-generic/atomic.h                 |  6 +++---
 include/asm-generic/atomic64.h               |  6 +++---
 include/linux/atomic/atomic-arch-fallback.h  | 19 ++++++++++---------
 include/linux/atomic/atomic-instrumented.h   |  3 ++-
 include/linux/atomic/atomic-long.h           |  3 ++-
 include/net/ip.h                             |  4 ++--
 lib/atomic64.c                               | 10 +++++-----
 net/ipv4/route.c                             | 10 +++++-----
 scripts/atomic/fallbacks/dec_if_positive     |  2 +-
 scripts/atomic/fallbacks/dec_unless_positive |  2 +-
 scripts/atomic/fallbacks/fetch_add_unless    |  2 +-
 scripts/atomic/fallbacks/inc_unless_negative |  2 +-
 scripts/atomic/gen-atomic-fallback.sh        |  1 +
 scripts/atomic/gen-atomic-instrumented.sh    |  1 +
 scripts/atomic/gen-atomic-long.sh            |  1 +
 19 files changed, 49 insertions(+), 40 deletions(-)

-- 
2.34.1


