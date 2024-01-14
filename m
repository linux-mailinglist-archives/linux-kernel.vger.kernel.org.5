Return-Path: <linux-kernel+bounces-25417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C56AE82CFFA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 09:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E72BB217C5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 08:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC44187A;
	Sun, 14 Jan 2024 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=envs.net header.i=@envs.net header.b="KXdcKY8Q"
Received: from mail.envs.net (mail.envs.net [5.199.136.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EFA1860;
	Sun, 14 Jan 2024 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=envs.net
Received: from localhost (mail.envs.net [127.0.0.1])
	by mail.envs.net (Postfix) with ESMTP id 4DFA538A05BD;
	Sun, 14 Jan 2024 08:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
	t=1705220063; bh=I5flNeCSKcPZFS/QtrUpDSDNjkkZLU6sLiC2v1qqHV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KXdcKY8QOWYIpxUv9NgLafH556P8nWhL761rXSGK/lvb6Ym3sutcEfyboUXeqIUE9
	 Gec6Phe4fV8R0LSMjnu/lQGcEOX3PodCuKgw7YWGlAkt15zLiLD0k635zo5KzFTj2B
	 7Q+NzQjLfKQY9ylKrupVI1n6EopXJWuXN4vHWIWRE69O4zmhntoQpbWcqdsfaCrTxu
	 kom2s+N3e9GCZAfF0uZmAQvVX7GXDdk8idWB+D9FdCxNlw/9DYsh1VgquFeaPvpsGu
	 Z4bqsW0IUWm8PpPgVXoT8H/v6vQc0CoKh2NsWDPhSSBd0sgCaa4Pd/exb1Awb7J7F6
	 NXMdIrPeojfReekFYVnHLM6qgiYK5vfqGwryFHXwLtMs/9yzQ+2MovZQJGvv4dF7Jx
	 Je5bbl7Sv/ZNuk64Klr9VpIUcUKT62kEUn9+AFUyDrSGuxhct5bmPRGFfumgzagvTA
	 /EvxuBma+1/D/5kfBAYyA/ebTMjQEI8MSX+4UtCHhKUp/uEEPrled/oCOeL4vObrcC
	 2fyZbD1OjzcAWFkTMZqCHzgmSJDa0RgEfpYMfyTdH8naen36998HB4eA4yGS0iswjN
	 8wor9GnUhfOLLPNKAAFKj/l3qvS4faopi142x3Hrb5aHsa/dSnEIqdQ+52h6CSSLlQ
	 LIcU7h8UgyF+EaTicC6PiouI=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
	by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aAFymciOCuSc; Sun, 14 Jan 2024 08:14:20 +0000 (UTC)
Received: from xtexx.eu.org (unknown [120.230.214.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.envs.net (Postfix) with ESMTPSA;
	Sun, 14 Jan 2024 08:14:19 +0000 (UTC)
From: Zhang Bingwu <xtex@envs.net>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zhang Bingwu <xtexchooser@duck.com>
Subject: [PATCH v2 0/2] kbuild: find kernel/configs for merged fragments
Date: Sun, 14 Jan 2024 16:13:58 +0800
Message-ID: <20240114081400.12452-1-xtex@envs.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113001135.7781-1-xtex@envs.net>
References: <20240113001135.7781-1-xtex@envs.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Bingwu <xtexchooser@duck.com>

First patch changed usages of ARCH to SRCARCH.
For some ARCH values, such as i386 and x86_64, SRCARCH is different 
from ARCH and arch/$(ARCH) does not exist.

Config fragments merged by  merge_into_defconfig and 
merge_into_defconfig_override should also be searched for 
in kernel/configs/*.config.
When using 'make xxx_defconfig xxx.config' to merge fragments,
scripts/kconfig/Makefile also searches kernel/configs/*.config
for fragments. This behaviour should also be in merge_into_defconfig.

Changed in v2:
  - Split changes to two patches

Zhang Bingwu (2):
  kbuild: defconf: use SRCARCH to find merged configs
  kbuild: find kernel/configs/ for merged fragments

 scripts/Makefile.defconf | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.0


