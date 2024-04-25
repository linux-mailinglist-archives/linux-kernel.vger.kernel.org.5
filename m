Return-Path: <linux-kernel+bounces-159305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F638B2CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E02281077
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E36C17F392;
	Thu, 25 Apr 2024 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9cw9/CY"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFCD17AD7F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082837; cv=none; b=LXi47qVDb6C/ada0lcZZBoVdF3ODYoxLJnPmWEV4bFDgkM/WUFrPMD4PAPDWE4mQYL+Gj5UWOIH9isDzN04jRjYG85Vc35rU1IjEOZF1/EirXuZesNvRuFp5D23DPKFJyf0338Fj7HGLSiK0GHZFN3Jr0XGmzmwgItffjmCNENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082837; c=relaxed/simple;
	bh=u5YCPBbfU1mP1ZcMWk36sIHt5zaVaIMvB2Iu7ja/E7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UzPs0lNhhbUzwAkbX9m4NUXOJkyLMfhCn1sEK0qgs9j3XQ+HxQJHcv5UAS8BJ6IOLBTTtdlloI0J3H2X3FyLryVhSaLq71GuRhsBtiBF/L+0NH6MAcTkI6neV/v1Wmmu577/rlx06HP+4fndixxMXvboAfRCCXSbSLV86q/cBOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9cw9/CY; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-69b5a87505cso7952596d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714082835; x=1714687635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l4ObHrHeCFN64wSM7NzDkDxv31XoYnyH95XTbkMwAw0=;
        b=e9cw9/CY6i0xlBJP6qFWPjOsypShBrWsjbCWApNc87snjya5wPbF0Tdy+H9fVk2QB8
         /DA6rj00GQRNAnm0ZZVg/P45kyXwGynCvlukfhyiIf5nIeqM+PT2v+EFutsbZpeZmCNF
         sVHZv2yXkk4qTlVik81Wc4oYtAOXhja1VeLxcYdjoB8JIrsZ0T9UZQA+xAolZKs7Q7fd
         s2P2YXYHSsyk3aw0DD/ktLrCE778W80zJdK1H23l2ldExrl8+UYusMCMibz6Aa7puivD
         xuXYOIrfy9ECM4cFtQXX0Atsbg9Giy0HPte828xNsqEJCfCTUmZo8d8jOghsJLi99Gxw
         Vmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082835; x=1714687635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4ObHrHeCFN64wSM7NzDkDxv31XoYnyH95XTbkMwAw0=;
        b=ulmIcBzLvDUUu2KLAGKn0jshqko9EqR0DZ/0SLDoodS7GIjp5Z9N/Jv3aTti/9k53o
         vUxnA3BEY0J70M14Mc4VMdP8OpOVDiYeYBTFGzJ+npgijX1qAldzlbHzPzy6HeOkK9O6
         ROaKltGsWmEoAadEU4KEmtvvwYwo5icPSCKFT1vKiM3My8xWmI+FNMbw/GNBU848Pv0r
         ZzmGEO+GFn7pcv4/p2VVQrPZJQtQEL3Lm5sVd0HoHETeQvdFmio22rQTz0/2KqJfFwHi
         c9OToUspx3FtT3dDWunHl9Jwm8bkkH/lMh8ke5dwHS9VOFsgt+GMDlYSiaH2flkLMi6E
         HeGg==
X-Forwarded-Encrypted: i=1; AJvYcCUDV3fin+58jJsXYb6nntZXoUOs1LB6RahB013TDvJITS5GZWqdRiT2p9HguqfZgJc7abPvIK4e1U4kKc/ffDk+XMcTvzmF5QjPYDtN
X-Gm-Message-State: AOJu0YyOo9hARK3b91xgs3Vgi+ROEpdNPP8S44FLouYyeuAcFcfrUFtG
	ISEsJAThi6TgSfBaC0w7tLeKLerK7rSnAK4pT0hzxHAfNeA6QeKI
X-Google-Smtp-Source: AGHT+IGqJk481KilBvF8wWSKLr3U6m+erKzHSeB5ufvUpq0IUcSwAObTcUjGEwOO70aZiiVWjvTnJg==
X-Received: by 2002:ad4:5dcb:0:b0:6a0:9493:a053 with SMTP id m11-20020ad45dcb000000b006a09493a053mr1196354qvh.59.1714082835071;
        Thu, 25 Apr 2024 15:07:15 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q2-20020a0c9a42000000b006a044503615sm4692891qvd.72.2024.04.25.15.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:07:14 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.or,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH 0/3] net: bcmgenet: protect contended accesses
Date: Thu, 25 Apr 2024 15:06:47 -0700
Message-Id: <20240425220650.2138801-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some registers may be modified by parallel execution contexts and
require protections to prevent corruption.

A review of the driver revealed the need for these additional
protections.

Doug Berger (3):
  net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
  net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
  net: bcmgenet: synchronize UMAC_CMD access

 drivers/net/ethernet/broadcom/genet/bcmgenet.c   | 16 ++++++++++++++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.h   |  4 +++-
 .../net/ethernet/broadcom/genet/bcmgenet_wol.c   |  8 +++++++-
 drivers/net/ethernet/broadcom/genet/bcmmii.c     |  6 +++++-
 4 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.34.1


