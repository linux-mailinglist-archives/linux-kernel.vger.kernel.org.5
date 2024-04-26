Return-Path: <linux-kernel+bounces-160288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AB28B3B76
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2801F223E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB237149007;
	Fri, 26 Apr 2024 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f0i9NmvH"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9901DFFC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145399; cv=none; b=JWi+ZMVQiwUQsOHfC9oKuUB/gjZvUeJMAHUh3ILeXuG/6AjDvGjj7lF4SmrlUyLy2804Ausc+wHQOgq8O1razeDvTQrWLRtAZSrjZyRSy/c0DIV0xWxdKebFN/sRgz+YTRsYKChhe+K0A5gOTEVAy9oB5XkPjSit/beJuEDMKF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145399; c=relaxed/simple;
	bh=IkqBB2wtliEK5GnGejTqTQe4Yfs6TKvgKFbT0UeTxrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ra6BlRZX4mPr3OJ79Bwqa3G3t7LRQfawig6smnYL9GfkD4Sk6fwTgGUtj3RhdceQ/nSUb+xTf8XFqcCTNHSNefhZhU1YHef/2qJqiVImGYQwrk+PYFZAMExSCahbfoO77HmYD0ZLKV2y7aET8celGbxsadBEq5IHjgzfaE9SHME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f0i9NmvH; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-518931f8d23so2464060e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714145395; x=1714750195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xUkLsSc4WA93wLtzN5OQsZNRMCNr0FDmpfgqlBr15OA=;
        b=f0i9NmvHZk9SAx2qle8Ot6CclLx594Q24s6Z0w++GpE/DgZvDQuv2sdSf51x6qUt1S
         2KoLia//d5Of+XRt5wmZXTz7b7OjMkmFSpIztiMG9ZAGkaMDZ8OU+VYWbFCSvnnqt2Ng
         4n2LApS0bsObfbhxaBlSC5+NU/9VWrKeeAWGsVObrXZVwHxrJGFTdUcpXTFYKaDGZOqV
         awFlaTKEIsHpBNcnWiNvIN9vjjEkgCjMgW6nY2iGjLpaJoWH5b8T4VICd0eYZJpFzaPJ
         bI/T2/3V5uWlS93oJ9ZW+HCt/R0thGxxpG4UvhMuTAuCGJteeQB/1I27yXtVC1j6BLdG
         LTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145395; x=1714750195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUkLsSc4WA93wLtzN5OQsZNRMCNr0FDmpfgqlBr15OA=;
        b=Y4AI45AuqAWlcI1uV4HMxAWK9zVB035cnMYYAHBEVogcExrdUVlkqhEmKiVZUNhRpE
         0uyeyz/JA/XFi2mLp+wclOf+ZZyF7yVyFeqQ5gTZ6xjW1nwwAP4H1ISW+XvMSGwI1fPR
         zras/7bQE+4EtcfETJ0WMQtfyb/Q9Dxv3MHhgbz47zOdfY85XG9CGEQT0Dr3poohCXsH
         noCM8TDnIHSOgs3GGu7tth0y3b6xa8ARlASg5+haaxH1s3BAyXZxiEFNNjblTW6dTGfa
         YtJA7hzXHRfPVXHP7v4jx5cUJ34Erwmk2AX3IDijEikPZWU4Zo5d7psDQAPmLBWjpDxq
         eUHw==
X-Forwarded-Encrypted: i=1; AJvYcCXmhKMM1Zlpz4LB8c9UgAgftSH0QFnV1z8CX+IKzbtZ7CGrK/cypcz54ctCm7gTFqIXDXRAWydKhjXHj9SouNP0/78XezEs9p26n937
X-Gm-Message-State: AOJu0YzEcpHJWWV7k8tStA6N+RqALDWA3jQeeJ8Jih5lDIOQw5LfaG0n
	28Rg8qr5+aPCdZ3q7M/ueQNoLf8xHEmmlwoGhs1w9kWit1oxfYkShqnkPPoizhS91Gw8OEPTE2k
	A
X-Google-Smtp-Source: AGHT+IFMxlBhWe1Oje3VzHCy05U8U/CCJEV92z6GmGIYTbHCedgsiCSp+J0MWzhqi0Ldz9xuDlW6Sw==
X-Received: by 2002:a19:ac0b:0:b0:51a:f255:ade3 with SMTP id g11-20020a19ac0b000000b0051af255ade3mr1761882lfc.20.1714145395077;
        Fri, 26 Apr 2024 08:29:55 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1926:f73e:8b99:1c0a])
        by smtp.googlemail.com with ESMTPSA id i13-20020a05600c354d00b00419fba938d8sm22628687wmq.27.2024.04.26.08.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:29:54 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH 0/4] ASoC: meson: tdm fixes
Date: Fri, 26 Apr 2024 17:29:37 +0200
Message-ID: <20240426152946.3078805-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

This patchset fixes 2 problems on TDM which both find a solution
by properly implementing the .trigger() callback for the TDM backend.

ATM, enabling the TDM formatters is done by the .prepare() callback
because handling the formatter is slow due to necessary calls to CCF.

The first problem affects the TDMIN. Because .prepare() is called on DPCM
backend first, the formatter are started before the FIFOs and this may
cause a random channel shifts if the TDMIN use multiple lanes with more
than 2 slots per lanes. Using trigger() allows to set the FE/BE order,
solving the problem.

There has already been an attempt to fix this 3y ago [1] and reverted [2]
It triggered a 'sleep in irq' error on the period IRQ. The solution is
to just use the bottom half of threaded IRQ. This is patch #1. Patch #2
and #3 remain mostly the same as 3y ago.

For TDMOUT, the problem is on pause. ATM pause only stops the FIFO and
the TDMOUT just starves. When it does, it will actually repeat the last
sample continuously. Depending on the platform, if there is no high-pass
filter on the analog path, this may translate to a constant position of
the speaker membrane. There is no audible glitch but it may damage the
speaker coil.

Properly stopping the TDMOUT in pause solves the problem. There is
behaviour change associated with that fix. Clocks used to be continuous
on pause because of the problem above. They will now be gated on pause by
default, as they should. The last change introduce the proper support for
continuous clocks, if needed.

[1]: https://lore.kernel.org/linux-amlogic/20211020114217.133153-1-jbrunet@baylibre.com
[2]: https://lore.kernel.org/linux-amlogic/20220421155725.2589089-1-narmstrong@baylibre.com

Jerome Brunet (4):
  ASoC: meson: axg-fifo: use threaded irq to check periods
  ASoC: meson: axg-card: make links nonatomic
  ASoC: meson: axg-tdm-interface: manage formatters in trigger
  ASoC: meson: axg-tdm: add continuous clock support

 sound/soc/meson/axg-card.c          |  1 +
 sound/soc/meson/axg-fifo.c          | 29 +++++++++++++--------
 sound/soc/meson/axg-tdm-formatter.c | 40 +++++++++++++++++++++++++++++
 sound/soc/meson/axg-tdm-interface.c | 38 +++++++++++++++++++--------
 sound/soc/meson/axg-tdm.h           |  5 ++++
 5 files changed, 93 insertions(+), 20 deletions(-)

-- 
2.43.0


