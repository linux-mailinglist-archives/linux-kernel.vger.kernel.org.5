Return-Path: <linux-kernel+bounces-112869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ADD887F43
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CDE1F21621
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2813F8D4;
	Sun, 24 Mar 2024 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II1FWGfm"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820A1CF9C;
	Sun, 24 Mar 2024 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711316661; cv=none; b=gH+a0SF2ygdQq3ocFk5hZEdKN0s1L6BS+sEg9hekITuaD+eEuxxWJ2Ob+OYA6e0Gxuf9LVQcpZvZucj23cDtSCB9MNtzL+6emtzqoMjQN+D2+jI38o/Qc4Do0etryZ25X/7nD4XCiNJfFYZSsjDxqYRyiGwhE654tZQ13nb8d1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711316661; c=relaxed/simple;
	bh=lTUfmfkvo1DQgIVDLHFSVcMBvnOKFE1gSLnTaETu1ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sknUaz+LRXQCKabKJteWtOl5WIztitkOijhP0qEkDGJhYbKgj900JN2fZc0ogJF1jgaG0gvUmGlvKABdp62IdeJPSxMhun/GVBbZah/fKbvG2jIn1wlQS5mOH0PyYg7ZWcFhkTS20YTaV7lcMUERzrESTRFnIUk8K+bF7pORPo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=II1FWGfm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56bc5a3aeb9so4845540a12.3;
        Sun, 24 Mar 2024 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711316658; x=1711921458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3aeaEyFTk8y/bEz0BsMP2ub4BmgnkPux+KegUEpkAY=;
        b=II1FWGfmNVLWEnOLdSiQDybyOi13wjM1MRLmiLf76hL1Ti0yKeQ+/tDymRfdUjr2g5
         jXJRVuIkpTktgn48IRQaocdZ0uKTc2SSm7XXY4jb143roT2HrCsw00l+USUvdoSek3WK
         hC9AyHn+md9e4cZFvwHkNfyGoTPb6Soa0Z1nUCCuFI6iemi20vB+LQygSRzkVWhfeeS/
         r8VZLXvdugyabdaSKZQLG0Xv8VLL49LQ0St6ouwCNvDtd8VJmT9IzKe9PiHev9+LXif9
         DpBUplbQpJZNX8Rw0PqYA1L3tt746AyLeO2DuLSVYNxNlV/oxs/zOJlXYCSC3eRUNGy4
         HaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711316658; x=1711921458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3aeaEyFTk8y/bEz0BsMP2ub4BmgnkPux+KegUEpkAY=;
        b=sz16A1z2qAWtmFgQ0Ou7HUWj1oOxZiGGTJJfN8yJ2TMd3gMUejtaGrGGD38b7cBSe1
         YTVrfTIgRedrh54u7TLE+bnMUB8MBZAQ+fVoJsVI7l3zSs2PUyMLKadK+3N6p1qKhEDy
         n0UYuIIlVWJmrxY7poVOCGbihalPrUvevUW8O0JglgfQEd/nFEPD8XyKFYCvWUR1yWJK
         KKAeuBzS4bkT0PnnrOefEjyxQvJ53RfMWuKCX5cr/GrHtMnOOd0K2wBzToPm5ObJ+OzC
         gWFRnknmGiq0Zboh24OZvEnXxvr1S+pKIJJE/GBnn/kfZEqIQ3hW/un63PBFZY97Qjsj
         Bkhw==
X-Forwarded-Encrypted: i=1; AJvYcCWFieUGnFPIsEFpUIFMQQ8hP2j40UB3PIzbqYIKcBFJvEK/TLcIothmh4o9mTx6GOJ2lLni4RlINd/coP4xZRasv6RPEhAIiNoeA4ZUGbLvbpihWN9XOcaVyiekUwP9HMISsVJHmBrC/fkf1AEyvqlZh04istSTYLuANkrTLSqGaf8uFkYv/8Fi7/v9x6cMEgEha2w6I9L7yAGTFgFSkNsGhg==
X-Gm-Message-State: AOJu0Yy/pbeqF9dQMWyeNMd79MbOepX/tSwALiY3M3u62Aqh+iAJyrLl
	dgOONq+O8Ow/ZRyf0rYVahghRlOcF8fEYncf9C+HgM7Wla6jw4zc
X-Google-Smtp-Source: AGHT+IFmdwvkvp9AANXkMdgZkzrB/iHyAMpv/UEzpJe44aFS4edZPbDoMDTVSIAQSe4EkiQ5h3r7dg==
X-Received: by 2002:a17:906:abc1:b0:a47:438e:c6f7 with SMTP id kq1-20020a170906abc100b00a47438ec6f7mr3193081ejb.63.1711316658567;
        Sun, 24 Mar 2024 14:44:18 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::2043])
        by smtp.googlemail.com with ESMTPSA id w17-20020a170906385100b00a46d8e5a031sm2327542ejc.209.2024.03.24.14.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 14:44:18 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: 
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chester Lin <chester62515@gmail.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Schenker <philippe.schenker@toradex.com>,
	Yannic Moog <y.moog@phytec.de>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v4 2/4] dt-bindings: serial: fsl-linflexuart: add compatible for S32G3
Date: Sun, 24 Mar 2024 22:43:24 +0100
Message-Id: <20240324214329.29988-3-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240324214329.29988-1-wafgo01@gmail.com>
References: <20240324214329.29988-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible string for the uart binding of NXP S32G3 platforms. Here
we use "s32v234-linflexuart" as fallback since the current linflexuart
driver can still work on S32G3.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 .../devicetree/bindings/serial/fsl,s32-linflexuart.yaml       | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
index 7a105551fa6a..4171f524a928 100644
--- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
@@ -23,7 +23,9 @@ properties:
     oneOf:
       - const: fsl,s32v234-linflexuart
       - items:
-          - const: nxp,s32g2-linflexuart
+          - enum:
+              - nxp,s32g2-linflexuart
+              - nxp,s32g3-linflexuart
           - const: fsl,s32v234-linflexuart
 
   reg:
-- 
2.25.1


