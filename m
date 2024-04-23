Return-Path: <linux-kernel+bounces-155718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2948AF61D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27851F242CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EA1143C67;
	Tue, 23 Apr 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmEfkHaj"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C10143863;
	Tue, 23 Apr 2024 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895170; cv=none; b=ADdopi7VONSQLSvEufkv7EP5QCSSwokBN6FhTRB5WxhPo2O2xGhlYeZ9dWyn5rMbdp6dd7CjhuNDmQwd1NsKmXGXGVQotfR6VhirGcCJn+h06sELb2jt8/nYuUcPnlODcJdv7398A2HSisjUfbZM5SbqsPwMf1FDzc5bpaZnr38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895170; c=relaxed/simple;
	bh=STU5CQpoNfY02usuPMTXrlizywFUdoAEy4M2VaJzvd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AFNy9MmEmpHG6yMWU8Wgji3TAzqXRepv2h2eqZLIZz8J9xUIQwNUV3xuanjbkNskiFZrP0jnMLBQNLIF6mSBi2l7y/0gnL2yozjm1MyGkpo7RKx9h3bg08oG3yDvOqGwxyqLhMX7l9bCHaqpJbs0woX6G/LfOBn+r8CzfCFY0zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmEfkHaj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41a72f3a1edso18625905e9.2;
        Tue, 23 Apr 2024 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713895168; x=1714499968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YP2hHXwuCZ6+4FXdVWlwcP9W+FvxPjHrC0SRjRAJvHg=;
        b=DmEfkHaj3aD4LEPoyGmhTk3DnrRvVhhI8jPOek72K0q//Y1Z52eGTuP62x78wiAw/H
         TUCwhdD7nRabv81DPOLvLbWK2NvCbdLzF4w3q4zYizzFBQ+zUiu4dChalUlTF8VZxQDn
         tWDp39EV90zujKnr5kO7/eyi5pC4F76r3AVu3FoM+Ywu78Qls7z6P2lI1b8tdbqcqgAu
         AsAyWfuh4v5AlBXVLhoHH9I2D6Y+JPfdTiW9dbIwi3Z/r49gbEA5fnfPz++g8w7qhJHb
         v/LMnMhQWQ/5/UeCtwgD/axuSu12Zvj10UfjXpgdDIBAomw7kwNTzq8u1ZN9ZySX/S3q
         2zVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895168; x=1714499968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YP2hHXwuCZ6+4FXdVWlwcP9W+FvxPjHrC0SRjRAJvHg=;
        b=FScs5PSBg+T6ovVNsNulSpXiqHwNWrAdgUzhSBfgGS/Owbq3bpVmCghBmnXkOFwE6I
         h/qDtwP25rs/SW/QOeOmSNjSmvxLW10d1jEFJewJb+MFFw9WDL/5yatOkf9lwg5NExyW
         geYxiPUyBus2CL1pLsaQtCbgdwUqbYLMPqc28GyLFRbtidzTrRq+sszhpHlJ0YAU697p
         H63+pe7q1mkkH9uZbN34YUkwGiKEjMs6rO6ZklqEoLmDtIDaVCRY6jtYaJUIB/solUQz
         lJj6RiQR0TacF6ZWxENu2EnYsE8qIgTj7IpXRRoAniWefD/wSnEOr0ZSCD7rNdMdegpM
         Mk3A==
X-Forwarded-Encrypted: i=1; AJvYcCX8MJuK2Eh2dHRsc3GieP3JhkR4u9Cx9WJcwmrLBSp6cDyswBraAyJYrm4Tn2p7G7pNIc2UNmxBl27KrK+sq8//r3iV7Ok98nDn0vhIJTQSKsYhbLt18p7Jyg/k7LkuG5J9gQ3wxFQXI6cd1vSgzL92DQPpdD/RjhvKXopY00tiH7f+Dp3t+I3YgiZ3
X-Gm-Message-State: AOJu0YzG2Ib3IvSnG8/ktBhfUqAIxzC53YAU9cbAjZNU7E8ey4iXmi5p
	ModQXGTBr58k5MCe6DbV8UnNJBTgAwRlpDYwzO9T6Djnfy6EL5P2
X-Google-Smtp-Source: AGHT+IGs32Ia9+aBEgbpCcygR11byEhaWYgNe4QNUH2rpEhu6tcbCXCbTdC8jGZ2vRLRQIY4kK41/Q==
X-Received: by 2002:a5d:540f:0:b0:343:efb7:8748 with SMTP id g15-20020a5d540f000000b00343efb78748mr8915699wrv.66.1713895167723;
        Tue, 23 Apr 2024 10:59:27 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:cef0:9ed3:1428:f85f])
        by smtp.gmail.com with ESMTPSA id fl5-20020a05600c0b8500b0041abeaaf7f0sm2808145wmb.28.2024.04.23.10.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:59:26 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 11/13] pinctrl: renesas: pinctrl-rzg2l: Pass pincontrol device pointer to pinconf_generic_parse_dt_config()
Date: Tue, 23 Apr 2024 18:58:58 +0100
Message-Id: <20240423175900.702640-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Pass pincontrol device pointer to pinconf_generic_parse_dt_config() in
prepration for passing custom params.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC->v2
- No change
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index c144bf43522b..f3c5e8982623 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -612,7 +612,7 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 	}
 
-	ret = pinconf_generic_parse_dt_config(np, NULL, &configs, &num_configs);
+	ret = pinconf_generic_parse_dt_config(np, pctldev, &configs, &num_configs);
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1


