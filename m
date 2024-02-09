Return-Path: <linux-kernel+bounces-59695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE67984FA8A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86746288E08
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF997EF03;
	Fri,  9 Feb 2024 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HxXB6Jlf"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAB67BB02
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498311; cv=none; b=HQz3tvBRuR72n6D4ouCoGQ189VIYmNY1/a44XB5urlnNJmMoVlxTERXgZEsaU+fxKThzWHUGXeYJPwknRVJYB/kZSgzJj+Y15KVf1C5OrhRpJ3cSzRAA8cve6m/Znn1p93sNSkEw3Np57q294MeHlDDxr1KTa73lbiZEa6tsL+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498311; c=relaxed/simple;
	bh=FzJWFoU7zdZZZkzvlOH3kBhfsl0b/pYObCN5y6EvCbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FkWxO8x7/gBZxq/YTxGHWbrZgVhMPhqo4Jyps9FtpgYLAY5muhfWs78afsl/b6B7VWqLeJA+ZVWLHSD8+Yr7jKmO1bfohN3qpKnFk/wHMFLDGm8x0WUB1NtgzbC6MzpH8p5zoeOVCLgXk0mzldwDeRl6nSEgVSwSQ6/Qkm6kM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=HxXB6Jlf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41059577f26so11113675e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 09:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707498307; x=1708103107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vr7W7Vbk1JHnh/Amjbi1K2t4Yc2oCSHciSTOdbwzBpk=;
        b=HxXB6JlfDFSU+QoLmW6TEbgOl2IZHGgR7jkuein0gZCS8fIc634JtXSL6W1FUMHfOf
         oX2aMTZTTwVJgwu9TrBdIkJYBQeJL2bfeTtt7BQ6Z9FTPe8hQ4cdbaXKolcZpfCmNchi
         W/khXOOcPammAPAJbgZeWeCwEsithBTOHP6zwTAfcQYMi0KgY1QXLWecUw7Iozn1SsVz
         Ql1ITwAT9fUWKeKwWi3Gq4wKV9U4QjMUHAQmiFOp3gTujj1tuXcJEWTOLglJTk4XV3BD
         ka6vo3sgvBcugfyTAFjMTyPJgUcuWlQWeoIwFbctDDZgpj2NVpAGxnJV2M4dcbQErg5Y
         x4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498307; x=1708103107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vr7W7Vbk1JHnh/Amjbi1K2t4Yc2oCSHciSTOdbwzBpk=;
        b=MGutwJ+JxcUT5rH0Tpwl3Kjv6u+I33rhEXVP8c/KBTLuuZozBdcBdMvFDryqHW9R6h
         DDtID/LKYW2zITCItOzMSAE421ZLDJnWpd6va3B4t7AysGpFtvEj6CTg+Eqjz31/C8HN
         85lQ6civlPhMtBOJSUvzKQkVp2VqSd3kjYMbkytKiZDLB7IxGeZpXeCoTJgmOk10nCVH
         9Vm1D5JvaffOWv5fEobSOaASKdxAjav0d/uy6a3rdUd1h+e0EhmLQMOAsmCdCFHAEryR
         08ag4nlf/pDHcB/uAhI5j+ZShjdzVEqUyszNTySylS5CGPfZtB9Pc8uz4Ig8C3d6TS6g
         SJtg==
X-Forwarded-Encrypted: i=1; AJvYcCVX0I3Iq+FGJZwxvYWlv8eP5JTq2knn+x+FKdDEqGhLmksmanPMZUbBsj/gqzajiIRet3J6A1tURV3Hr5OdHuOmIl5ns8BAQIj6F2rX
X-Gm-Message-State: AOJu0YyKPXB126ljmMkqHD/g/L9kf0+hjlKqu9JKu/QRsWVhzZLV5YdE
	N99sHIKwlch43c696I5K6MFzhacvbN3qb3ird1ZxNkVy8wdfvXBIArVCZSQTUgI=
X-Google-Smtp-Source: AGHT+IFs7ynCqsfokHQAYan78I5+JGfROe4sGXWOaKqkcfTgS1zKMZXR1Q+gaeGAhVV+J9NdW64tWQ==
X-Received: by 2002:adf:f3c8:0:b0:33b:2633:b527 with SMTP id g8-20020adff3c8000000b0033b2633b527mr1760721wrp.20.1707498306679;
        Fri, 09 Feb 2024 09:05:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVd2/rt5Ozv2csLhdMVfneFPmbti00GZZaBnvyagESkdrWMK03Vz/7l9U1RQqMmdPo/2YlxezeIU/+UgqkA/Gi0shkDrDq3FDdK1oJeF3vuhUQa7u188/yufwfftrBb2MnbhCTO8NceCYDWVOuM/ZrqGS5GjiV/CypH7O/egTU2FWnEAL99PgyGMRdvwrhdI7iGu01dHu5mwERSz5W37LvkRYprLRrOvAZl2IBSX/hW/AQcXJSk+fciL5vxEdy92TbhVi/tEgUWwxrsEFIlLd4OOj8cFuqdKjyXnb9zA2WF6Knoc4+9pilc4N1FuDTTkwVeYUmX6Z/GXY4=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id j18-20020a056000125200b0033afe816977sm2254998wrx.66.2024.02.09.09.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 09:05:06 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v2 0/5] net: ravb: Add runtime PM support (part 2)
Date: Fri,  9 Feb 2024 19:04:54 +0200
Message-Id: <20240209170459.4143861-1-claudiu.beznea.uj@bp.renesas.com>
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

There are 4 more preparation patches (patches 1-4) and patch 5
adds runtime PM support.

Patches in this series were part of [2].

Change in v2:
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

Claudiu Beznea (5):
  net: ravb: Get rid of the temporary variable irq
  net: ravb: Keep the reverse order of operations in ravb_close()
  net: ravb: Return cached statistics if the interface is down
  net: ravb: Do not apply RX checksum settings to hardware if the
    interface is down
  net: ravb: Add runtime PM support

 drivers/net/ethernet/renesas/ravb_main.c | 131 ++++++++++++++++++-----
 1 file changed, 105 insertions(+), 26 deletions(-)

-- 
2.39.2


