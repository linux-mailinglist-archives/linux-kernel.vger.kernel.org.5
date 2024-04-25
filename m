Return-Path: <linux-kernel+bounces-157901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2516E8B1862
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E521F23569
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC88CA7A;
	Thu, 25 Apr 2024 01:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fWZwQRki"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E09728F7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 01:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714007957; cv=none; b=DUvE1b2Fx99mN15p4QkRFp0R542dGCsneLoEKehxmPoR5y9N5YEVsemOm/rZVYfPDIsTFikOXPUemUujd4R7WQkyMQWTK6FMN1Izv2vzLLB0B+u2Qq+97J/s/thkjgImY5zjw07BAFjjoVDvcENGF7y5wZE9CkSds/B8aPFrIm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714007957; c=relaxed/simple;
	bh=uLT8FYB0z9hpMnlQW6hKjbJMmTUuyZlRXmjjQNhJGwU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jLInamnD1uF/umNT/AoXO5xHxAo0TzjJk0+TOxVLCm7zqOqIqCuuH6jNicE/tTRC3dO8PMeNLgg+Lj4MktU5pwRRvErAhpDJD+Ew7/XYyLVobTn7cFbr3AyakAwG2UuVPpYl+Lu3A6b/FGcLbqKnc0tS6aBGX1Oc2frwEnvI3iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fWZwQRki; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64f63d768so967287276.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714007955; x=1714612755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fhtSrAi+//xuc+I8DI7Sfszz5H0fgzv1dQ1F/lNIbLU=;
        b=fWZwQRkiXoY/CeWe6theD4Bl5iRjc0MB39xrBtIJEZ+eNmL3w6Wwr1rk6YqH6hcY05
         8NUVxTmo5x6TFqbdPeDTIR0TDYURb8b42kevm629CV81PSLRz1PGjpSiKBiWuMAPo9He
         QrBOUaJx5NWPnZpiqIlyO3vhX8csX+wFwEpsZcY6RAVYTHaY9U/6xN9wMqBQT/572cxD
         VsMUXWF+/dKUwRgynAcOOufqIJrIWy+3eUzNfHWTK5HJtyGqSEwRuxWodUXuKb4v1xdw
         Pu96x59JTEXsipO26B6Sm0j41e+LbcCDYuCTQN2Vhyz+UTywmbcPpHT8rQxRs97vzwej
         AGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714007955; x=1714612755;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fhtSrAi+//xuc+I8DI7Sfszz5H0fgzv1dQ1F/lNIbLU=;
        b=HsdpSCVEwWsUrznR9lC8o1Tb28+QLlxibsKADz7B/METeAvxFsHdJ7pxbjElzm/7Nw
         sJRJ6w4BXABvlIngcTAzYBFF9fODNsrJ8sywDyp/VnGjsM2jB0y0uIYrRNhTwbntt+A1
         l0+eVMRDNR91JKLSks9uqB78bRgH+xYa4jGZeqDh49a50t2XzPrf7l3V6Kpc4DnmnEFc
         sU3laRwPc8AH9D0u1NT4WUbK/oOJgT1C8lGQ+u6U0R6STSq8ryP8ezoXbzLto5py55pR
         lNISekLAr9YNcdjEEuuQjOO1y9TxiNDw/h3N+zkEI3wV1zAi/0kB+G8WW55CFHesaPRL
         xtRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXc8DvVH2TGMB5ie/wT4abpCDpmTqu8BgpJ5Od5Z0LoNWh+Tc7wKL6/xcbrIM8hL+UP05ripqGpje0yXb7B9B5DRmHeSs0oJ2PNgkR
X-Gm-Message-State: AOJu0YzA6e+soVuUs5qkwq5VOo4/q3lw6oSXbu44LqA5j+08GyQrFhAK
	NQGEbLuA/JU+zoEGas0e9hpW9Nk0NxaJDWYK+XYF43EIIuPtb6hEmF0qr258DO4ugKNrL/gy3HO
	ysEa7cE1KPxiEHYCscL8MbA==
X-Google-Smtp-Source: AGHT+IGjyJXrIQ/HPFqodscDOz8YvnLkg3hYnAsGcpKNSDsZzEE8YFhfmdMCjhCj4C6Cs8vE34OjReb+sQ9JNy71xw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:2b05:b0:dc6:d233:ffdd with
 SMTP id fi5-20020a0569022b0500b00dc6d233ffddmr1437183ybb.0.1714007955020;
 Wed, 24 Apr 2024 18:19:15 -0700 (PDT)
Date: Thu, 25 Apr 2024 01:19:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJGvKWYC/53NwW5CIRCF4VcxrB0DM0Cxq75H4wJhvJIoGLghN
 ea+u2jSReOm7fKcxfffROOauIn31U1U7qmlksfQ65UIR58nhhTHFiiRlJQG2lxzuFwh1tS5Nsg
 8Q2weTj5vSRKEUhkCWHLWGccmIIqBXSof0tcz9Lkb+5jaXOr12e3q8f450RUoMN7aYMgp/cYfU ynTiTehnMWj0fF/Lg73wHtt0BvCuH9x6dvVUkv3a5eGKwMpslsd0fx0l2W5Ax9tpi2NAQAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714007954; l=2356;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=uLT8FYB0z9hpMnlQW6hKjbJMmTUuyZlRXmjjQNhJGwU=; b=CRkKkJ86IKr54dqqwbv7Lx0P+RGq3++z6F1qmKPSqj6SJ3t9Okv6f+h2SHOs+EFklHCfanqqy
 FLsGsHXWMXvCrfYcSeRJ0xUvYgFHj4oPOrqUanyaT2k/vnHJ8Y2ovY3
X-Mailer: b4 0.12.3
Message-ID: <20240425-strncpy-drivers-net-dsa-lan9303-core-c-v4-1-9fafd419d7bb@google.com>
Subject: [PATCH v4] net: dsa: lan9303: use ethtool_puts() for lan9303_get_strings()
From: Justin Stitt <justinstitt@google.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

This pattern of strncpy with some pointer arithmetic setting fixed-sized
intervals with string literal data is a bit weird so let's use
ethtool_puts() as this has more obvious behavior and is less-error
prone.

Nicely, we also get to drop a usage of the now deprecated strncpy() [1].

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v4:
- drop unnecessary { } (thanks Alexander L.)
- carry Kees' RB because of trivial change
- Link to v3: https://lore.kernel.org/r/20240408-strncpy-drivers-net-dsa-lan9303-core-c-v3-1-0c313694d25b@google.com

Changes in v3:
- use ethtool_puts over ethtool_sprintf
- Link to v2: https://lore.kernel.org/r/20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com

Changes in v2:
- use ethtool_sprintf (thanks Alexander)
- Link to v1: https://lore.kernel.org/r/20231005-strncpy-drivers-net-dsa-lan9303-core-c-v1-1-5a66c538147e@google.com
---
 drivers/net/dsa/lan9303-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index fcb20eac332a..f3b50adae865 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1007,15 +1007,14 @@ static const struct lan9303_mib_desc lan9303_mib[] = {
 static void lan9303_get_strings(struct dsa_switch *ds, int port,
 				u32 stringset, uint8_t *data)
 {
+	u8 *buf = data;
 	unsigned int u;
 
 	if (stringset != ETH_SS_STATS)
 		return;
 
-	for (u = 0; u < ARRAY_SIZE(lan9303_mib); u++) {
-		strncpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
-			ETH_GSTRING_LEN);
-	}
+	for (u = 0; u < ARRAY_SIZE(lan9303_mib); u++)
+		ethtool_puts(&buf, lan9303_mib[u].name);
 }
 
 static void lan9303_get_ethtool_stats(struct dsa_switch *ds, int port,

---
base-commit: c85af715cac0a951eea97393378e84bb49384734
change-id: 20231005-strncpy-drivers-net-dsa-lan9303-core-c-6386858e5c22

Best regards,
--
Justin Stitt <justinstitt@google.com>


