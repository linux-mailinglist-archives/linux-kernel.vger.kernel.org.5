Return-Path: <linux-kernel+bounces-120086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E34F88D15C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0B8321390
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7634513D881;
	Tue, 26 Mar 2024 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICJtMX3p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6225813E028;
	Tue, 26 Mar 2024 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492874; cv=none; b=isajWuSbmGMVvJV25wyB6vdZJX/Hi537+VyQKcrTgEhpHNKDQnqbFr2JCR04BIpzrHHDMBb3/j2tqwrcqxJ9xSwndyKqpYC8l568QoFm/b+7tqQVn/OTUtZqfdy83kTmcl0Ck1Azi/A8+YpR1ghOXaNTXra7kD78dShwaxA2DsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492874; c=relaxed/simple;
	bh=fE8YQ0ldH4jAPvC8YbW24he4IxhcXj1g5OmwhFjAj+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLOPxDeMUFjWS4XdW8RmxFtfGyNbL1W0DQ/BjOh7ffpdJ2IZ9z2y8brxPXZGEX+SGkVym8WYKmg8TCPTaDqt9gFTg3mP4gx55xg+wjc0xam1gLKPQcwyfXesG/UQEhtM1bND5JQ2cH7R2NwKPwpsQTVH96JdHmtU9M2mZEB1MhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICJtMX3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A94DC433F1;
	Tue, 26 Mar 2024 22:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711492873;
	bh=fE8YQ0ldH4jAPvC8YbW24he4IxhcXj1g5OmwhFjAj+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ICJtMX3pCuiusynEfe3bAP6Lspz0zcyuLbBOka+EOsCaOFZME4FZ4QIKrK/MZdJmq
	 Ctvnh5OIwUz+4zf2REjGVM2wdtuYwLoVkURryHKORb15fiwpv0FTQMJtESTGs4TGQ9
	 M95cMSdR9qm2j/ow8DdkaA96bSW6B+j3pXIETUi2N1JbBiGG6nS+FatuULN7WX9ApY
	 OEQW8S0LDu+tihl3F/LXp4MYlPtjNGctBOW8AUwWSRImiBVjqWYm1AiepC0fk/OF4a
	 ICeRLsN9MuXhJv/PBCigSpwkmoq065lOs3WVMt19zKcKFsi3X/clDOsIaByQv9Gr8K
	 a1f7cxjjNEj7Q==
From: Arnd Bergmann <arnd@kernel.org>
To: llvm@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dawei Li <set_pte_at@outlook.com>,
	linuxppc-dev@lists.ozlabs.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] ALSA: aoa: avoid false-positive format truncation warning
Date: Tue, 26 Mar 2024 23:38:07 +0100
Message-Id: <20240326223825.4084412-9-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326223825.4084412-1-arnd@kernel.org>
References: <20240326223825.4084412-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang warns about what it interprets as a truncated snprintf:

sound/aoa/soundbus/i2sbus/core.c:171:6: error: 'snprintf' will always be truncated; specified size is 6, but format string expands to at least 7 [-Werror,-Wformat-truncation-non-kprintf]

The actual problem here is that it does not understand the special
%pOFn format string and assumes that it is a pointer followed by
the string "OFn", which would indeed not fit.

Slightly increasing the size of the buffer to its natural alignment
avoids the warning, as it is now long enough for the correct and
the incorrect interprations.

Fixes: b917d58dcfaa ("ALSA: aoa: Convert to using %pOFn instead of device_node.name")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/aoa/soundbus/i2sbus/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index b8ff5cccd0c8..5431d2c49421 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -158,7 +158,7 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 	struct device_node *child, *sound = NULL;
 	struct resource *r;
 	int i, layout = 0, rlen, ok = force;
-	char node_name[6];
+	char node_name[8];
 	static const char *rnames[] = { "i2sbus: %pOFn (control)",
 					"i2sbus: %pOFn (tx)",
 					"i2sbus: %pOFn (rx)" };
-- 
2.39.2


