Return-Path: <linux-kernel+bounces-164220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86FF8B7AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88581C23799
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82602172BD6;
	Tue, 30 Apr 2024 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJE3Z4a2"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00E7710A;
	Tue, 30 Apr 2024 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489215; cv=none; b=OrFMVtsp3w0AJmJ6ENG8eMySR6JrC6Bm5YPTsm8DHbXKILGN49LxsPIudXlih9kzo21KR5MbHUt1sqxfoUY7BoPMpgQjQ5RzEsE28osb+udqKg9zo8azJZB8Hued41mB2+6SiGuzEZKchayS5yE7EPEg+pTgHe3RHxtdy6zvzqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489215; c=relaxed/simple;
	bh=CfSl9GtlAtHB+rcXJHozuQgrFboWGNOXnQ3OvS3lmTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NwjlAkyYQftkL5bJDuBC9dPrY/bRGrv14yyjrLZtIe4elYTx72nUsWE3Lpj54isLIiH9Hhcg88Np7UXFzZbtqdRQaq3JaR2yxT+IyR34ukzuogwogXaxA4DNGHEZJh+IR8UzseKFnJ3fmdLTAbR2OazIhMlZ4Nd1/rBrjGZ/nJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJE3Z4a2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2b27c660f91so709133a91.0;
        Tue, 30 Apr 2024 08:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714489214; x=1715094014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SkT2QLC8TQmVSP+rJF4kvPIyKIKgXzRowbjPH7GH+Ug=;
        b=EJE3Z4a2AeEPgj4cqL30xNXk4k6BB+oymLgYG9tu9Ra5am6JFA8uuvFD4OC9RSHBvw
         BCrXjCoYinx3hwJUmnuXo1PoKklWcw3Ta/nQjhz5OlRL71IUxqdIfYuQJXZn9dUqhn8E
         +DaEXBJFM9dA0lyFT7WPMLctUZHfHL2B3VTwaawEBBDtIR25KwxA0AnJ1n4T2brFObP2
         UOso9dD8NAB6kfP6K2qx42ns1fZZCWy7hvTwiwg0a5GnxCTXHYfplqZKpSKEmwaq8V0e
         wg0RKBDGm/kip1Tda0DThZbZnngCZTaBysbM3DEIdEUJ8l+Am0gwqXWHRP2MIXToB5FK
         FdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714489214; x=1715094014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SkT2QLC8TQmVSP+rJF4kvPIyKIKgXzRowbjPH7GH+Ug=;
        b=NmwY/dvg5yU75NIbkUQcQP00MyV8AVUBPdNFteEBfWOiUMQ8faVtmTAGw6e5LkhLCY
         ncRqO5VmSjaCcE2AN99JqoDUJ91CnNsgwVRkn+dvBrK/AX0hSBJBvoE3ofXpPWKrwu01
         sNFZiygRl/oxuO7Ky0a2N8K1+rECu26/WPDVB7FOWLOHZr+RKfCoSA+nr6HHg9QQyG67
         j5WQoLfI5drpqtyGgI1+aDO0CkqiXnekpUBQ/Gt6nkVKusJOGNcKpKtASAxqhQ60pKa8
         /TuRQzRsl48hpKa8l2lqI512AkrI4doS/EKLYy6X2uyrboLZ1QXCZadC9hKui8L0p9Rh
         qFLg==
X-Forwarded-Encrypted: i=1; AJvYcCVoTKqxXrGFCN22+0JsEimWWBUFWIwJEMNYaIZz+Nv411CEHKKaM6MEUYD7ipzYIQnJr2T6YRYkX19R79kv65EIZTk/8dcaP4HxJa3TlO24Qw1ERezQadNGrt72HG6nffgy6Zo8XWUOuqxlVKQoj3wNBsxn1r7auE2R0e3pBuNtxddnb+HUngN0Vs4=
X-Gm-Message-State: AOJu0YyTS32NI91QfdOPHS3GS3tBYmCLr/zz01PGSDTQa5DUYnbpc5Wl
	LiCLhhA5XcDUsw8NSWEfMyyphCNksxxGx9CN4BcKT4GZ6LGB4Yqm
X-Google-Smtp-Source: AGHT+IGAQ3aPK4tUlkrLyZpFr1uhaVhJVk+IDywxNHSn7gT4m3RnY2l3NP0GS3xjID/0W3CX1D2V3g==
X-Received: by 2002:a17:90b:128f:b0:2b2:ac4e:9221 with SMTP id fw15-20020a17090b128f00b002b2ac4e9221mr1520475pjb.4.1714489213036;
        Tue, 30 Apr 2024 08:00:13 -0700 (PDT)
Received: from prasmi.domain.name ([103.219.60.80])
        by smtp.gmail.com with ESMTPSA id r6-20020a17090a5c8600b002ade3490b4asm15428745pji.22.2024.04.30.08.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:00:12 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 0/3] Update compat strings for SD/MMC nodes on RZ/{G2L (family), G3S, V2M} SoCs
Date: Tue, 30 Apr 2024 15:59:34 +0100
Message-Id: <20240430145937.133643-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

- RZ/G2UL and RZ/Five ("r9a07g043")
- RZ/G2L(C) ("r9a07g044")
- RZ/V2L ("r9a07g054")
- RZ/G3S ("r9a08g045")
- RZ/V2M ("r9a09g011")

The SD/MMC Interface in the above listed SoCs is not identical to that of
R-Car Gen3. These SoCs have HS400 disabled and use fixed address mode.
Therefore, we need to apply fixed_addr_mode and hs400_disabled quirks.
'renesas,rzg2l-sdhi' is introduced as a generic compatible string for the
above SoCs where fixed_addr_mode and hs400_disabled quirks will be applied.

v2->v3
- Dropped items keyword
- Sorted strings alphabetically
- Collected Ack and RB tags 

v1->v2
- Updated commit messages for patch #1 and #2
- Dropped SoC DTSI changes as its a hard dependency
- Grouped single const value items into an enum list.
- For backward compatibility retained RZ/V2M compat string

v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (3):
  dt-bindings: mmc: renesas,sdhi: Group single const value items into an
    enum list
  dt-bindings: mmc: renesas,sdhi: Document RZ/G2L family compatibility
  mmc: renesas_sdhi: Add compatible string for RZ/G2L family, RZ/G3S,
    and RZ/V2M SoCs

 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 39 ++++++++-----------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  9 +++--
 2 files changed, 21 insertions(+), 27 deletions(-)

-- 
2.34.1


