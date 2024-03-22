Return-Path: <linux-kernel+bounces-111639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B8C886EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72E4CB23BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D764EB24;
	Fri, 22 Mar 2024 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dvx8+kPh"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFA64D5AA;
	Fri, 22 Mar 2024 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118705; cv=none; b=Q/jHiueriGjt8unWxekkweB7NeYM0NbOIrOe0pPu3y+7c3I0epwAbIyqIxJkH8jjKWTfaLr3DwIuzb14Pf/RWPckhnDTJWb2rh8cde6iPIQIFnugqohfF6uiZX3ujYgp8NHbqb34dB8iXC1BtKKBHCBg5qAAF1XTqQFn6Mddliw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118705; c=relaxed/simple;
	bh=iLjxTmMNTTTSbPcgr+dDzIp1jE1//QBqqla9qhWektU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W5Rx2FsJ9/fPXO1PtQLosKTC1z0ACEUKgpSHFXrllY63SydFPHFt4zCUl2/RYP10dAqoo43delxA4Hptt9h91gcsv17of+ykKALzGXGZCtlskBWksWQ7pGpC/Wb6KWsBFfGdqOAIo+m9W4sR7Vk6TfaDCFWWJQ9S8lTaM+RgDqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dvx8+kPh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4146562a839so15371805e9.1;
        Fri, 22 Mar 2024 07:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711118702; x=1711723502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0V7Mhe0ArfXSjrT95vTJ+hE4SWzfgGrhDLu3sLUJno=;
        b=Dvx8+kPhskkvyly1QghHrzFwX5GbOZaQlyQPxE6Cv1VIDX2tjFvvT6LTfIuK5MG+oz
         PgXpEnkGnIDj7+w9iuNw0kuQsa10sG9gLg9ZomEcvMBL68MpAmxmVzCsycx5oBJQo91y
         KZyFlGRT3BUfhQhabZKZp426zl9JKKRQrSUojcE4KO75NyINJQHDxI1d30XBXeUfAYVT
         /W7kmzeYyn436hCD2Vlzy96ew7yBZkx2Clh2FANMoV+a1uNoK9L3nGR7P8a96yxhhgj5
         RPZQeaoaxlhAvn/8UUHkvhnFNHg5QX68YZT2fq7hmC2X/Cs3eA5oNtOnN5gGkYVQmWdI
         ZfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711118702; x=1711723502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0V7Mhe0ArfXSjrT95vTJ+hE4SWzfgGrhDLu3sLUJno=;
        b=S8S3iF/XWkGHp30utIv30N+e4O7bzK5aQ9pRFuT41DTUAeQmJIT/d50jRZ3n3XY+xx
         ISThuXnUtJzEUs9I/odgSJAmrsfeFxfQBCjxdpOzhNMcbO3aNCfQkRUKE6RrHZxUDAgS
         N0S/vj+Bfo6LgRRyDkH40nzssEYhHR1dEXyr9+KfvMIwXyiQRzLLdopimzIaoiLpc3r+
         F1ROiIOMX6S6lIcQLAkI7iABfT7L2eLvs3FGbOKBhXcHiQjOKPV368w9xAItS9aT8e2G
         /ZkuoARQcbntSOzfPTakEoSvAOrYaHUHv0g04AD/9xcGvj6OA4xb6EQ3fVXBw6k82T5C
         Cj2w==
X-Forwarded-Encrypted: i=1; AJvYcCUEe2k4O4QwSaDr/c+BrTzcN6pY6Vg99QRQSNBUbNhB32LJeTadcbwSrUJ0iV8ie16lSEgXofOOw25uFHMa9N1VZwe3SaMb06I8gXLLFiuBXC8vrxR6/AaDA4+PJNrgvYFYhqjfrJV0XItxFARDKKITABtPA7v8GqOsNw/ikfL9aQcQWb30wgokeLoW
X-Gm-Message-State: AOJu0YzUnSqzd/GEQilkbGdiP44lFLskapNcklKz4BwAslAXRQ0sgI5b
	Z/E3M/drBidw8jCIXfob71xEKbB080QdkIT6JAvhJ4t2kIOXT/fe
X-Google-Smtp-Source: AGHT+IG9rnTvKoOPeTbMKqJIRqYfbGywkmROQyv1XpETaAIHcwN8T5J7t/JVSoylUGPCNE56cr6jQg==
X-Received: by 2002:a05:600c:35cf:b0:414:255:c6a7 with SMTP id r15-20020a05600c35cf00b004140255c6a7mr1768259wmq.32.1711118701431;
        Fri, 22 Mar 2024 07:45:01 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:7b89:721b:d6b0:d7e8])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c45cf00b0041466e03e55sm3911117wmo.0.2024.03.22.07.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:45:00 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 0/5] Add SCIF support for Renesas RZ/V2H(P) SoC
Date: Fri, 22 Mar 2024 14:43:50 +0000
Message-Id: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

This patch series updates DT binding doc and scif driver to add support
for the Renesas RZ/V2H(P) SoC. RZ/V2H(P) SoC supports one channel SCIF
interface.

v3->v4
- patch 2/4 reverted back to version 2
- new patch 3/5 added
- Added new reg type for RZ/V2H

v2->v3
- Included DT validation patches
- Added a new compat string for RZ/V2H(P) SoC
- Added driver changes for RZ/V2H(P) SoC
- Listed interrupts and interrupt-names for every SoC in if check

Cheers,
Prabhakar

Lad Prabhakar (5):
  dt-bindings: serial: renesas,scif: Move ref for serial.yaml at the end
  dt-bindings: serial: renesas,scif: Validate 'interrupts' and
    'interrupt-names'
  dt-bindings: serial: renesas,scif: Make 'interrupt-names' property as
    required
  dt-bindings: serial: Add documentation for Renesas RZ/V2H(P)
    (R9A09G057) SCIF support
  serial: sh-sci: Add support for RZ/V2H(P) SoC

 .../bindings/serial/renesas,scif.yaml         | 136 +++++++++++++-----
 drivers/tty/serial/sh-sci.c                   |  55 ++++++-
 include/linux/serial_sci.h                    |   1 +
 3 files changed, 154 insertions(+), 38 deletions(-)

-- 
2.34.1


