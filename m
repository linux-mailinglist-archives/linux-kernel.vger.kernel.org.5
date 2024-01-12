Return-Path: <linux-kernel+bounces-24744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 217EA82C1B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D1D286E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950196DCFD;
	Fri, 12 Jan 2024 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZpIMEOI"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8C1537E6;
	Fri, 12 Jan 2024 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d87df95ddso66977475e9.0;
        Fri, 12 Jan 2024 06:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705069587; x=1705674387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4K3qORjCWw+gkht7BR5kJjl56gwELapPIu5KXg30nNo=;
        b=dZpIMEOIpWBKLq1iyMn2j8hKYQNbWiIBV1pB8ex1ezlEmrNUhvcsVMwhRfdmJUwvPM
         KS76yk9KAHjcLyHcO3Ws5aXfcL+QD/kNcynfH3IozNHKwBqPXwcpcEI5yx3rkqrDf9AD
         zDXxVFHAxN9QFtbFJgTCOUa42/eFx6ufV24n0emM2SYVrjqPOtRRzPpJLQmccjFkL+IT
         aHutNdgeE7+FhnvFn9mZjX4He8xgmx+loPUdaL+Xarro4yNdEqjbwxUcslXJcH2sEYdj
         xWko3g0hEfhxHwF/V3vZhcIc0hUIwyhTUfG6H2aJ/nUvIF8DafrDNO+jzi+RQ5NMLZzp
         hTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705069587; x=1705674387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4K3qORjCWw+gkht7BR5kJjl56gwELapPIu5KXg30nNo=;
        b=Cjbon7g8E+uhGekWSqlybFPCZQI5++ZXam1dP9+HmKoAJgpnYdjUuKYBt3/sKi1YQP
         t6qlt8eTnfQFSzNrIDtZ6Zt0XuntKXZRqPR3dwT8b2ql2Sd81QKGq0MQOQcvWmKHssGX
         o+Met8nTZUob50x4XAL01vNeD2Tc0+ZsEXB8o0gDIA7Hgjoxe9G5u1d+dsj114hg0olo
         ZU9YJI0/lBQZ02HdCQ5HGQlb7FNS20zOd6jTnVZTB7/5I5G2t/tYKSJSMQqIA44yCbFb
         b8YD+jLJ/fJuZDCtQ2zBkDAeNfXLeDUYtv2n8oocAhcg7LpmEBnNnIMGDw5VJTDtiS7I
         900A==
X-Gm-Message-State: AOJu0YyLChlgu7bE/3DSPsjG5hUiEvHJ/w1eJuEo9HTmLwj8dHFs521M
	MJFQ2bHbAnFE9uWcqSU7NRvhtVmAssuRXA==
X-Google-Smtp-Source: AGHT+IHpajvBOFzp7zZrUTgb2u+zy2CCRsm5VcWjvelFGJ7z8i1+xpL84mVdNyt0hzeNAVRCV+krjg==
X-Received: by 2002:a05:600c:2202:b0:40e:66cc:46e6 with SMTP id z2-20020a05600c220200b0040e66cc46e6mr257214wml.181.1705069587239;
        Fri, 12 Jan 2024 06:26:27 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:494d:c489:3d96:1b15])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d4dc6000000b00336a2566aa2sm4021219wru.61.2024.01.12.06.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 06:26:26 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 0/4] Add missing port pins for RZ/Five SoC
Date: Fri, 12 Jan 2024 14:26:17 +0000
Message-Id: <20240112142621.13525-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series intends to incorporate the absent port pins P19 to P28,
which are exclusively available on the RZ/Five SoC.

Cheers,
Prabhakar

v3->v4:
* Rebased the changes on top Claudiu's patches
* patch 1/4 is new patch for using FIELD_PREP_CONST/FIELD_GET as
  suggested by Geert
* patch 2/4 adjusted the code again using FIELD_PREP_CONST/FIELD_GET
* patch 3/4 fixed rzg2l_pinctrl_get_variable_pin_cfg() as pointed by Geert
* patch 4/4 is unchanged
* patches 1-3 have been boot tested on g2l family

v2->v3:
* Fixed build warnings for m68k as reported by Kernel test robot.

RFC -> v2:
* Fixed review comments pointed by Geert & Biju

RFC:
Link: https://lore.kernel.org/lkml/20230630120433.49529-3-prabhakar.mahadev-lad.rj@bp.renesas.com/T/

Lad Prabhakar (4):
  pinctrl: renesas: rzg2l: Improve code for readability
  pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK()
    macro
  pinctrl: renesas: pinctrl-rzg2l: Add the missing port pins P19 to P28
  riscv: dts: renesas: r9a07g043f: Update gpio-ranges property

 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi |   4 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c     | 284 +++++++++++++++++---
 2 files changed, 248 insertions(+), 40 deletions(-)

-- 
2.34.1


