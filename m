Return-Path: <linux-kernel+bounces-143166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A43D8A354C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5533C1C22022
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF48614EC44;
	Fri, 12 Apr 2024 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9fBnjYO"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A688F14D2B7;
	Fri, 12 Apr 2024 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945045; cv=none; b=In3WIEv9jX0N3lRqMYsc3ih+DKnU9TYDvQ/lX6//sEug+qU/WaUGsAfjhUG/bLjQY+BXn8b9mvMMBqiCfk4c9AiFsvw4D0BHB+czPd3wgbeKE13XQj1LAmqEmlR7eC+ylzx7ZWICx1CJ5TVQvqJpSitURHsEt55cQQeHrKOjKkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945045; c=relaxed/simple;
	bh=pL8DEPrlq502m1lqM9mSVBGYPc5Ax5zq2wRmPF1el9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvZownwZqhohE8TIfYUhrD53RFKyOot5CSdz55vS5Q8QV3dBjgZA/ZlqBmtX62PauEUo4EvzUPddXseyhWLlR9dwj7Yag3gZz2qSi10r0Vhuua2jzNw+zsSrwDQHe2biG3quSle1Ll2QaEGGhGtrC6bZzZJKycwJ0rfY2+BoPa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9fBnjYO; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-518a3e0d2e4so44470e87.0;
        Fri, 12 Apr 2024 11:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712945042; x=1713549842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CocCrXTkILxb+H292FlYFL20d7nBS8XixYwTUqYokkU=;
        b=C9fBnjYO7Y9Z6XQnUKLVTG5VEbr4FZw8kf7lqt5NMtTgKRBiaDyt86kECrHhwfmNmM
         6c5iNJUK7v8WH566u9Nyfo7L/mwHi1BBpaN3HkJGxNfyKKHf+aMDCj4fMSW0iJMTmbyR
         1wK9Tft1GpMJmROclHY3yUY1ehWrkMvq3ucJWSR7nAMxc+vv1n6gZmFGstGJPRuWVy71
         1FFESmfbBAArhJMdALDNDimKiCgnKo+v8ozR30KPxMX8xcvfqehvpm8iOOvkqhgWxup9
         rZVB9QmVq6MosUWMdS31lBrQWoK9/ioFUIqOQMF64M0H4p2DCpJVpaznxQJ3EzmJP05T
         jFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712945042; x=1713549842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CocCrXTkILxb+H292FlYFL20d7nBS8XixYwTUqYokkU=;
        b=F1XWe/9kfdtKbDWiMeH3fGyw1STg+cS6IPi2YJev9JQzZz4i1NcjCUi9bfZ8pQz1Na
         RvKt2CWr/grVE7xquqF/fgVMX3lp/JEu9z2MxR8V1z5OSWWtIzZeJqNoHvD0g6+FlOuA
         LWrXJ6w7Gt3Hy0Z2ubG4hzYEd+MTb7/p/YEKD4IZIln7dojSMyKVG8xV/PUWy/+21+Pf
         XHGEyZnxvzcQ1d22hMWprQjUBJErFBbvZAU/M8UgGs3OeX9XdFn03F9DEJjQvfIm2v/d
         V7/9/eZrqq0sR50n1/SowRob51Yol0duCMIHW+l7AbGpnMwNjBxcU6hi+F2qxYG8wpFU
         9SeA==
X-Forwarded-Encrypted: i=1; AJvYcCUaG2H/qLnF7Myk2S4zqbxHIWvUFElp/ueQUUFh189cBBxqpcPlxuo8znJBCkwVkhwTuXS3ornjqhJmUK11iwIB/VPggQCIe5YG/q8ytgliZd9uHOeH/W83XrtzAH5PkEuNMeDn
X-Gm-Message-State: AOJu0YwjxyOcFyAy6ATEeos0/tFlXm/kbl14um37KxOSDlb5pvommryX
	/xWmTktqd0zky0GDxJbGTJqAy6KAaatJUbrQXNlXf8PI+CL7iTeg
X-Google-Smtp-Source: AGHT+IE+YdnghDsV0obcJRUikyE+vRG7Z625VF2VfIjNL7bgReRC31FSjtwU16I1XuF0ATXWLD1vaw==
X-Received: by 2002:ac2:52a9:0:b0:515:c0cb:3ca2 with SMTP id r9-20020ac252a9000000b00515c0cb3ca2mr1979670lfm.16.1712945041542;
        Fri, 12 Apr 2024 11:04:01 -0700 (PDT)
Received: from localhost ([95.79.241.172])
        by smtp.gmail.com with ESMTPSA id s23-20020a197717000000b00516a25e9ce1sm576691lfc.294.2024.04.12.11.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:04:01 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Yanteng Si <siyanteng@loongson.cn>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/4] net: stmmac: Fix MAC-capabilities procedure
Date: Fri, 12 Apr 2024 21:03:13 +0300
Message-ID: <20240412180340.7965-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series got born as a result of the discussions around the recent
Yanteng' series adding the Loongson LS7A1000, LS2K1000, LS7A2000, LS2K2000
MACs support:
Link: https://lore.kernel.org/netdev/fu3f6uoakylnb6eijllakeu5i4okcyqq7sfafhp5efaocbsrwe@w74xe7gb6x7p

In particular the Yanteng' patchset needed to implement the Loongson
MAC-specific constraints applied to the link speed and link duplex mode.
As a result of the discussion with Russel the next preliminary patch was
born:
Link: https://lore.kernel.org/netdev/df31e8bcf74b3b4ddb7ddf5a1c371390f16a2ad5.1712917541.git.siyanteng@loongson.cn

The patch above was a temporal solution utilized by Yanteng for further
developments and to move on with the on-going review. This patchset is a
refactored version of that single patch with formatting required for the
fixes patches.

In particular the series starts with fixing the half-duplex-less
constraint currently applied for all IP-cores. In fact it's specific for
the DW QoS Eth only (DW GMAC v4.x/v5.x).

The next patch fixes the MAC-capabilities setting up during the active
Tx/Rx queues re-initialization procedure. Particularly the procedure
missed the max-speed limit thus possibly activating speeds prohibited on
the respective platforms.

Third patch fixes the incorrect MAC-capabilities initialization for DW
MAC100, DW XGMAC and DW XLGMAC devices by moving the correct
initialization to the IP-core specific setup() methods.

Final patch is just a cleanup moving the MAC-capabilities init/re-init to
the phylink MAC-capabilities getter.

That's it for now. Thanks for review and testing in advance.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

Serge Semin (4):
  net: stmmac: Apply half-duplex-less constraint for DW QoS Eth only
  net: stmmac: Fix max-speed being ignored on queue re-init
  net: stmmac: Fix IP-cores specific MAC capabilities
  net: stmmac: Move MAC caps init to phylink MAC caps getter

 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  2 +
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  |  2 +
 .../ethernet/stmicro/stmmac/dwmac100_core.c   |  2 +
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  7 ++-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 18 ++++----
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 43 ++++++++-----------
 7 files changed, 38 insertions(+), 37 deletions(-)

-- 
2.43.0


