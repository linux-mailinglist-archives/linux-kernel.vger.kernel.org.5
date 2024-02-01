Return-Path: <linux-kernel+bounces-48463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01BA845CC0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40A78B31C40
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C0215DBDE;
	Thu,  1 Feb 2024 15:58:50 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A660115DBB4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803129; cv=none; b=HCHBHCCyOx8+fk9IfPTj5ZVx0bFVklpkiWV5RvDDnO6sniOqEGyf0WyweVVifRejYNm4YChhcHVSfeRjha3Ii/oEpBLMgjFgwWHuqbQeMXp+r3Mn9lK5khQVYAFIP1KEyzjUiTKTfhiVv23tZyyboiylh/S/HFmFxzTctPKciSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803129; c=relaxed/simple;
	bh=mwOcRWgGn7pvLTdeSW94wTXGzJVXrzRA1ONPp9U5uGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PSbwYdcOuNmUFko4Q+d7KONHaWosHcU5iRldaiHWKNh9q6AZrhwg+Yyx+sY0M9nkahewy/NvMBh1rCt+KKVKqyT11lmokNgn6U5xoXrsLWUKQjCGFcFPtr3RSfj4tiZrA/U4ynQNW9qw9LNnYE2S4k7+Bw3ifkSklfo9OXznheI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:4392:e888:3d14:1bdc])
	by xavier.telenet-ops.be with bizsmtp
	id hryk2B0062BHJxj01ryk6G; Thu, 01 Feb 2024 16:58:45 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rVZRn-00GvjX-2p;
	Thu, 01 Feb 2024 16:58:44 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rVZSe-00AbuX-1b;
	Thu, 01 Feb 2024 16:58:44 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] regulator: gpio: Miscellaneous state fixes
Date: Thu,  1 Feb 2024 16:58:40 +0100
Message-Id: <cover.1706802756.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series contains two fixes related to gpio-regulator states in
DTS.

Thanks for your comments!

Geert Uytterhoeven (2):
  regulator: dt-bindings: gpio-regulator: Fix {gpios-,}states limits
  [RFC] regulator: gpio: Correct default GPIO state to LOW

 .../devicetree/bindings/regulator/gpio-regulator.yaml         | 4 +++-
 drivers/regulator/gpio-regulator.c                            | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

