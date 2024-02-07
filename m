Return-Path: <linux-kernel+bounces-56463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2091384CA7A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46D41F2C0B0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC395B67D;
	Wed,  7 Feb 2024 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bu2JbaTN"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35E95B68D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307675; cv=none; b=rMMCnPMeypXmC6XCx8l+xEM0ViL/1FKDLAkg/RujfedH267taxPInxoIZ6/9qrZ34D8V6TNxl+RdsOC/HVBv4qYSBZyklHMIT5oUYUHoQo2h4ZG5J2ieww0nxd8SBcYcQCCWfjtYTWKL6Mtk7tN0WVYeF8QH+HsxiG9tNEJG92U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307675; c=relaxed/simple;
	bh=SxlMICegmXdUBxQVVBm2FzksqEV77QNPyRMJh6d+Tbs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n2VjSo3CnE0VN1toljT93P1E1J3Ze0ZDt9Mo5PjkcFXN3QVr/gzp4bj3N0rYdV8Lgx8aUEBZwuTJ46W5Au+kqMLkI/0I8vDKXCE4FzMsuh8XaudX4gjRoibXlAAk5RW1SwEo0cLJy719e87TO5o1vPoAcnuOQsvaYOy0htwUdIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bu2JbaTN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33b2ee2d1d6so318010f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 04:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707307671; x=1707912471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cFc6eloGSwMPUDaRE6k+RTqrzneAql26eIJ4/C1a2lU=;
        b=bu2JbaTNXUCq6Nzbt+NZiWf69R8cNzBNPzVYnS6W+lDdtgNpc57eIrxD6t1K7fnSS+
         K93EGpajV6is81m0Q0jCATl5rc4fwgpRqoQbOa6Ivxec+ElK6FZuLOw7sAy0Jc8jFffD
         Iev1+o76mH+LGshekaDhVskMNAInvTeq0nlgsjsaaR5h6uB9iRr4DLBn9zIBzvOm7UOG
         QHQDTWr+dXWQzFSFrOwXxi5SzQ2jAkaMHm1nOmL0E3lvi2sEZ5unnG+K464832cDsAMD
         u5lrfZRluYydCngdt8xxHPOniS8881CB6VWyMC653lT9bIv1uSxlF778P2TxysjB/D8j
         f1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307671; x=1707912471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFc6eloGSwMPUDaRE6k+RTqrzneAql26eIJ4/C1a2lU=;
        b=rdu3rcq/HLeihbxlBvrBGBx96QiuTqruj19hz5N4y6qPq3cnyHdBMf/+ys6CWVMf2Q
         XITiH9RXCqRgNe+Txx2rarhEZnwyidjKnP19MyASNKIlIrvOKcLAXJRaP5AmXsPbHlhp
         eUMB/9MiyAtgwu+QBWD9SuZNMfy290EbNJ/WBs72lMC0bqC0Z74MzY0bSYzByDA5g3Md
         H/DFRe03X+2lxCR4LJxPXmQStis7QHa70fGp9xooAc5bkfg1aaonNag5P5543ns6gyNg
         rK9wPiFBmk+i0wu8bsm2nhrQnomSwt77u0C1+9o6T5OtxyLLZwrS0Ch1mbL+02HrT7X0
         Fkmw==
X-Gm-Message-State: AOJu0YwzQI5INSPc4kGvsAQNnxxq9SzLBwGYZ6gjJG9aiK50mPsZ31bA
	/vTWo3ZR4yINNukgLpToUEMSujFVpLV7yyK03SR1BSP6VXoxTgB7bMuihY3LbJE=
X-Google-Smtp-Source: AGHT+IHYuDU8bFZ0W1OL+/OOZDpOCn53HYr4vDa7Ay4yaE5N25fQ3SXc1BUZqSPmjMCtmirdIIrHug==
X-Received: by 2002:a5d:4e4e:0:b0:337:8f98:8ab4 with SMTP id r14-20020a5d4e4e000000b003378f988ab4mr2777700wrt.37.1707307670693;
        Wed, 07 Feb 2024 04:07:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWyoRwjcmsp0ARCl+kbxRwBCdodgYGIqvw/qeHxh0qsZdp9vtizAAKbHqV3jD4crNufEV63I8bBgb2UQvzYXkc4M/lCVDLqAWBcV5J7l5AyLjj0rKNlv5eUmHQ4GpCpCf95cjNa0SQoQe0bhJbRxxSWVPiwLmWx0tp0u9YqMGzlPhLpz/rbYwbls1Rwe4XOZ+2lTLTQzKrl9YNCbwVK93vzXTQrYcfp4DwRggzGERY9/tzmij9sfZvMUTZOYlXHYrRJIOnTMEyzMMX1FqTaWXL65Kj4XHvpXaNS+RPeajWel1mEXbqnBItWIHTUSjBsp26dcxVt3Wuj3y4=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.114])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b0033b4db744e5sm1363957wrt.12.2024.02.07.04.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:07:50 -0800 (PST)
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
Subject: [PATCH net-next 0/5] net: ravb: Add runtime PM support (part 2)
Date: Wed,  7 Feb 2024 14:07:28 +0200
Message-Id: <20240207120733.1746920-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes since [2]:
- patch 1/5 is new
- use pm_runtime_get_noresume() and pm_runtime_active() in patches
  3/5, 4/5
- fixed higlighted typos in patch 4/5

[1] https://lore.kernel.org/all/20240202084136.3426492-1-claudiu.beznea.uj@bp.renesas.com/
[2] https://lore.kernel.org/all/20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com/

Claudiu Beznea (5):
  net: ravb: Get rid of temporary variable irq
  net: ravb: Keep the reverse order of operations in ravb_close()
  net: ravb: Return cached statistics if the interface is down
  net: ravb: Do not apply RX checksum settings to hardware if the
    interface is down
  net: ravb: Add runtime PM support

 drivers/net/ethernet/renesas/ravb_main.c | 118 ++++++++++++++++++-----
 1 file changed, 94 insertions(+), 24 deletions(-)

-- 
2.39.2


