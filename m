Return-Path: <linux-kernel+bounces-108799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C36A88102A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03C11F23A76
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B113A1C5;
	Wed, 20 Mar 2024 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Up8pId5g"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8D381AC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931413; cv=none; b=FvIZjl4qm5w3DKTJ60U9j/nyHLveXRju+4uL5irveg0HsNIviF4Rg2VA7UE+VNxFL5XHrdlZ43UiBDtfkMDauxzOQqxk3u0n+WCIMFwYwI+3+DpLSs7edBa0VWZu5WsqZzbL+N0HmoTUyb55NXebCotxZO6XvSTDqVwRuToOlCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931413; c=relaxed/simple;
	bh=nq2wKNNpeo2285g0qZC3Hza2dTO9nFQmoZ1P4qfdFx0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=covQ20izuKpNnBzfSd5EPAYFDdiaDJXtW/piU0vLqIIQG2jAKMeXCJncddV9P6t14atUQAQVkf6PTPnsey5NiVXxB/P2fJWnsAebX+3Ln42RtZHJso1zeHNL5Db27PXsplFxRsEWbE9CPiVkbdTxbwC6ESqSsuyfi05Z8RddWfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Up8pId5g; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46f0da1b4fso81845166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1710931409; x=1711536209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y7YCcW0F6Lrt8JcoNOIMWwfvsSbg5Iix+K6rhgXUVTA=;
        b=Up8pId5g9gHg7yqNhNkSZBxi6B+nIwj4EMyhmy/LyddFTVOdCLjDtqiNEizarkPG8Q
         rPJzTDLIQujxc8HyftQ6KrMJeRzUKpeD3537E535ddBUiI4bc0PKuMpFO7FHidakLops
         dUonoIGpO9n2AtbWW77Vm1Zlqst++PJef8SZOIi2GMTK8kUNvFd+15h9X9Ejoc0qAJBW
         Eux+tDnqPXXMRsuSW4IqZ+GtyXnIB4eDjYtL28aY0Z3BdtqMXoreHCiP8id5TNwFHTUi
         x0NGt96etxuvPGHCOQUKZ2+81krzzMEbyY3qgjyrqCYNbsN4ZBBLTAXW3vR4YA2+uXBk
         5iTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710931409; x=1711536209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7YCcW0F6Lrt8JcoNOIMWwfvsSbg5Iix+K6rhgXUVTA=;
        b=X8c4p8f/kyP9johJ0Pw3CGrnLNAIf+kKCWSHFsmQAL8ebTmmfMvT0cgyHZZm7iqwzl
         yFBNsfR9Gq55sgGQrh464S7jqhO0OrcjOUGZt56WF3KIol/QnciMW57EWowncCd9vZd+
         vj/CLvhvq2HZFDdL5Ma15YzUulF09g1x8CbSWf9WurDfpbFL7iVmQE9+kDT4jzLzw/Mp
         WodMENu3syF/OS+17qrHA1Xkj/t0vTAjB8ytISZDYT18QTgBy4Folw28Fvtlhl+0iAm8
         6ysS4YdAeaxr+q/vY0Td2YibWpTuzRBiRxPKKlzyCT7n0ZwTsbZhymxQ48I4u728CbSQ
         Dx4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDZe+j5HMP9HKne+jt6HoX3QMgvwVVeyvzfy6uLNt2fVZ644Zx9LEaWy6qvNKykZuQTTKla40P8k6IcHyaG8HmGfm4VzJ0WnaoDMMt
X-Gm-Message-State: AOJu0YyRge0uCAmcgVH7UOBjZmq7Ln3iOVvq9LzFD4QQUmZhWGfP2yPP
	WyO4aXxy5EWJvIoK36BqXlJOjB2TGdjNSLBDMZKrkZMzLSp5O1l0yKvlmM4hP3w=
X-Google-Smtp-Source: AGHT+IE07FfjL+kP7sHe9nti7Psa4p1ib+32l0yhChQlqn2xgLf69hil2T/W79Ix4Q3NmFccWuYlkw==
X-Received: by 2002:a17:907:208a:b0:a46:636a:2c23 with SMTP id pv10-20020a170907208a00b00a46636a2c23mr11284694ejb.34.1710931408673;
        Wed, 20 Mar 2024 03:43:28 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id o20-20020a170906289400b00a45ffe583acsm7092081ejd.187.2024.03.20.03.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 03:43:28 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	linus.walleij@linaro.org,
	tglx@linutronix.de,
	biju.das.jz@bp.renesas.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 0/2] pinctrl: renesas: rzg2l: fixes for pinctrl driver
Date: Wed, 20 Mar 2024 12:42:28 +0200
Message-Id: <20240320104230.446400-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds 2 fixes for pinctrl driver.

Thank you,
Claudiu Beznea

Changes in v3:
- collected tag on patch 1/2
- added patch 2/2 in this series

Claudiu Beznea (2):
  pinctrl: renesas: rzg2l: Execute atomically the interrupt
    configuration
  pinctrl: renesas: rzg2l: Configure the interrupt type on resume

 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.39.2


