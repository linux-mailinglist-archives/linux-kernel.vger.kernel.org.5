Return-Path: <linux-kernel+bounces-33021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C64836355
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A199B29F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338783C694;
	Mon, 22 Jan 2024 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b="WUC9zpKi"
Received: from egress-ip43a.ess.de.barracuda.com (egress-ip43a.ess.de.barracuda.com [18.185.115.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A848C3A8C4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.185.115.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926895; cv=none; b=YlMTkDKzzS8S87NCJklvznmx5CFQHQfiW5pBcL7KL2L7sPpTv8X0k5KNI8wL91D3XdzVhuv7HP+qJJ1fcskePOHeRyS9UdXfRlhYY0QLPpkwZ1BLLbZl7uXRMcZTdPmh/NraJOQKQukX8SemAVQDZWiiGi73gLSwCgmnCy15cnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926895; c=relaxed/simple;
	bh=e5zx+uTDddh3y7dxA0VqdI6el6KqEPCpbzdUhR0CXVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dm4rMooZHvnwxWd9SZvbZygnrxdO3cVPxoFRTMSb+V+S2cA7nBgXALS3hBwUrck/SC4YVcr3Ik1buA5ljLBDx4/tOgF1cV+VbTaUOQn6FzOpOB6TmzlSEe7jNlckfCYFxxBTmzN0LtSkE9KEBy5YqbOM61Y38TYVTaI+8EnxoeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com; spf=pass smtp.mailfrom=mistralsolutions.com; dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b=WUC9zpKi; arc=none smtp.client-ip=18.185.115.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mistralsolutions.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199]) by mx-outbound46-154.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 22 Jan 2024 12:34:45 +0000
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1d5b60c929bso41085305ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1705926884; x=1706531684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H3qWdam+hsCI3eccozagY9AfL8sulDvAzxRxufeMmoQ=;
        b=WUC9zpKiaZyewg572Ue4mb5A8YMOIWk3BIqIA2DTDAEuv8NBQkZ+9gfA+kmLGYVq/X
         +OwRUkQD411Nb1jN6TnUbzyZrTT5Y2ifbm1VDZUGqtP8ul98+wvukABkfoK3H/Yuvl7N
         3Cl1YjPwlbsx/7s1wJkL2BiVRguM6uGCl0Gzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705926884; x=1706531684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3qWdam+hsCI3eccozagY9AfL8sulDvAzxRxufeMmoQ=;
        b=KSjHYtsAhbVUwkkFlw/SdzGDn1JRsTVsRc8FtfW90AOefe5Sj/MmV9t3L9O/s79XJn
         u4VUSOSgLGnTcsACg2Btc3W2/jfi6nh4KOFeLQczlALxHAK/eB+koguCxQZ7M9W6tUys
         bBtWXr+6VeBsL0eXCHd8OIB9YyDRSS/g/yNytH0hsqnVcg/SAIElqLVwP9rPNdJvEciT
         C0h5V3/URAzbLo1YwYq/msHgAhBUzTMB/FaqeoDUrLKM/agcNxlEauBoFrsxDV/4Pr0m
         VssV+fSCzbhpH+kOXNdp26I5FYsIe/IRzKnQMM7g+TPF1pDE1GXVx+rSzrIxMEv3lylB
         82PQ==
X-Gm-Message-State: AOJu0Yyp6aTSfGv/zHvY6nyBOY8+YwI5dDToJOslFi8X4qx6YH5Qxkms
	6MlT2lIagUnjZfEWF8Awh8jx+rfqYCGTF2RMdYE15gxQmYjdgxTIyjh+ee9/p9hHiI1yzee4vcO
	J+vKTrtZV5Hr39XN/pyrFTAz257tCkPi9k5sHX7ImRy9v3uzcwFHW6mAqW1CisSxcJN2eaD1jHx
	BYECMSJ/2d/ng5WSkfkmcXUcXL/dZf
X-Received: by 2002:a17:902:e88e:b0:1d4:4768:5f with SMTP id w14-20020a170902e88e00b001d44768005fmr5214310plg.37.1705926883958;
        Mon, 22 Jan 2024 04:34:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdd5V3vWMEtHrpIclq7URlksLY0yUvW6Fcegfd2zWN/WwBxCnNjkekl4WDNYBPO+x2keOavQ==
X-Received: by 2002:a17:902:e88e:b0:1d4:4768:5f with SMTP id w14-20020a170902e88e00b001d44768005fmr5214298plg.37.1705926883687;
        Mon, 22 Jan 2024 04:34:43 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902684f00b001d721386cc2sm5372148pln.84.2024.01.22.04.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 04:34:42 -0800 (PST)
From: Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH 0/2] Add QSPI and DCAN support for AM57x
Date: Mon, 22 Jan 2024 18:04:34 +0530
Message-Id: <20240122123436.11269-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1705926884-311930-12475-5382-1
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 209.85.214.199
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyNjYCMjKAYmlmpklm5qZmlq
	ZpFhbJSQbmxsbmyammRqamFhaWpolmSrWxALq8IeBAAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253679 [from 
	cloudscan8-87.eu-central-1a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

From: Sinthu Raja <sinthu.raja@ti.com>

Hi All,
This patch series add QSPI and DCAN support for AM57x driver


Sinthu Raja (2):
  arm: configs: omap5: Enable support for QSPI interface
  arm: configs: omap5: Enable support for DCAN devices

 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.36.1


