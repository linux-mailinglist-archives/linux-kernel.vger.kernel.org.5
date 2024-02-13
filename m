Return-Path: <linux-kernel+bounces-63246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD74F852CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739ED28C01A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D33A3E496;
	Tue, 13 Feb 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bca2RsRB"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DEB38DCD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817306; cv=none; b=uzqdn7NDG2UYTvNCU1cF+neLflPJvalvdDMiH29n492LUz0f80qAS6APz2J4Z8kaVtQ9bLufUQ3M26Q5pg5prQ/4VK2qVgYog443gZZhJ1FrI5AlJdSbiT1DFTxmfJTEg7G0IA+A+Sy1H3eS4o9h5RQ0Oaksc5lDIdEM+MHjt1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817306; c=relaxed/simple;
	bh=gmGM8eW45sg8d5Ilw8QNcbDabj3qEg/cJxPSWRi2kdk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LWERorCvkBm9neZGwAsHpPLeIl8DsXgzZHr+e/3dUxPZFioeskW+dqZAQP3/TdFHBsCvWflqm77ZfW14LyC+cI2txqw7Qv1YuJYRhQPnAgUNKYUJTveqZOTSHnUnytIEPnBJbtg0ng78yxnIM8fw6VlHETPYrV/+V7Dms1fS5GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bca2RsRB; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0aabed735so53926121fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 01:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707817301; x=1708422101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=76ifjGL6b6XqCMtg1uu81osGatDMANposy+h2xVPYsg=;
        b=bca2RsRB01dg8vcclUQAiH+eaoko6ENeLfYMs+aA+uGyajGrpWPixOb/pFajFqcMsE
         MksaM30X3d5z9Y630aOa43tvcNMbjeQkJmWyLK+2sE0oajWWg8H90Twn/OoXVKPX8Nq5
         i0lMXfgTtAWXeMiEkgP4C8kdWW7BOSWRCbWJpO/4wOIV4niOfK5twp4gu1WuAdktMXLL
         rIQI1pmdC4/A0Najo9fg15OKDwMH8PYlMK5ulicZT/WCHlg8c3TWQyGbmfUMZwjrD+6/
         GAl1hM7MfLmnu0sCgjNBrE99TkKg/+qwYUh805vAMeyFtlf5K2T8MHivGIhkyHLXX+PM
         qYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707817301; x=1708422101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76ifjGL6b6XqCMtg1uu81osGatDMANposy+h2xVPYsg=;
        b=No9qY/cpFG9xlvNkhMifvYj5ZtCC+Rk5o7wDo1yiiLUj3zbdpc2bAODTMtjcsTbYm7
         wmT/xRrQWOD4FbueDfpxlpzpxLYWHk3Bnq6hTbX/qgT4FF5ZDD+4VWwf+8E1Zn3tSOSo
         0kbq32J2XQhUKIbkjzhl2HX6ABYaFPAv91kJNXciOTGGfXMmeEFNlFAi+5HVzOYrE5QZ
         OXWiLoVMFrMNb4BvCJuI7LakkOPXox3KlHm+gYRmj+B6VU/lB2cpp+ErqWvn6+m4AXBK
         A4FlUCb0M/ywunweqrgsKfC14HmA28uWK6ojNBbEv1rkUPRUnO2UTxFTDBPJJU/6Cb+z
         WLcw==
X-Forwarded-Encrypted: i=1; AJvYcCUD548iuWkaV7/V1OJkLwcaAyMMGLBdY8JYEWtOdt+sOV2TrrTr1tU1w0160VFPOqlNNg/TpSGnFD1ZNSeKxH0Fm5kXGaYaYaCSmJNe
X-Gm-Message-State: AOJu0YzyZCfltnlU2Tgmgwr4L+h9wqgCaM707HQoy15vb+uSogUeuCGA
	0v7ZPn27WnDCU/ok+72938xRpmA9RsN/u/iH17cfAJxNHo6/ySPgKXaY0eiwdL0=
X-Google-Smtp-Source: AGHT+IE+PTpuc8a0yDPrJaQP0fOBYKm9f1Mj/0cNYVH5PJ2VipKGZZ1JuqTF4NAJPEzTpGipNuCdqQ==
X-Received: by 2002:a2e:8682:0:b0:2d1:ca1:760b with SMTP id l2-20020a2e8682000000b002d10ca1760bmr641871lji.30.1707817300836;
        Tue, 13 Feb 2024 01:41:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWiK3W3MUpsnpX2f0LS0ydRSEhS/0hHYb7tUBAdaxnsW5ZzLBiZO+dAW8enoQ4bHRyK8KlwxMyjiFFrCssAJzJ9cp+ko7ClMbz5GweNIBNAhVfPmcDdZqX9zm+7zu5FmsSukX0qv4VA/9QXqcJyCYtmbpry9MiJee+MZB7cPFToJUKOxDxdR3lyhXqwIabkQrtp1KD41sT0vvE4qkNjtKvukkUifCdnMsgV5DGPbntLTpb2JX2Q8X4l9f8++8JPm6OPzSup1V4Zq+CtPDwS+qf7jMOnfjUFsBLHW+u1MHNV32MXt4spS6Yee3yM5nGLBbxypZsWg4cfKmCU/XxoVDDlX3+I58Q2dB3+pxuK9PQxL0hZwePn
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id fs20-20020a05600c3f9400b00410232ffb2csm11207446wmb.25.2024.02.13.01.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:41:40 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	biju.das.jz@bp.renesas.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v3 0/6] net: ravb: Add runtime PM support (part 2)
Date: Tue, 13 Feb 2024 11:41:04 +0200
Message-Id: <20240213094110.853155-1-claudiu.beznea.uj@bp.renesas.com>
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

Series adds runtime PM support for the ravb driver. This is a continuation
of [1].

There are 5 more preparation patches (patches 1-5) and patch 6
adds runtime PM support.

Patches in this series were part of [2].

Changes in v3:
- fixed typos
- added patch "net: ravb: Move the update of ndev->features to
  ravb_set_features()"
- changes title of patch "net: ravb: Do not apply RX checksum
  settings to hardware if the interface is down" from v2 into
  "net: ravb: Do not apply features to hardware if the interface
  is down", changed patch description and updated the patch
- collected tags

Changes in v2:
- address review comments
- in patch 4/5 take into account the latest changes introduced
  in ravb_set_features_gbeth()

Changes since [2]:
- patch 1/5 is new
- use pm_runtime_get_noresume() and pm_runtime_active() in patches
  3/5, 4/5
- fixed higlighted typos in patch 4/5

[1] https://lore.kernel.org/all/20240202084136.3426492-1-claudiu.beznea.uj@bp.renesas.com/
[2] https://lore.kernel.org/all/20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com/

Claudiu Beznea (6):
  net: ravb: Get rid of the temporary variable irq
  net: ravb: Keep the reverse order of operations in ravb_close()
  net: ravb: Return cached statistics if the interface is down
  net: ravb: Move the update of ndev->features to ravb_set_features()
  net: ravb: Do not apply features to hardware if the interface is down
  net: ravb: Add runtime PM support

 drivers/net/ethernet/renesas/ravb_main.c | 135 ++++++++++++++++++-----
 1 file changed, 105 insertions(+), 30 deletions(-)

-- 
2.39.2


