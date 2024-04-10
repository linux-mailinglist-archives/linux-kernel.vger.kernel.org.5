Return-Path: <linux-kernel+bounces-138115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBA389ECCB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB951C20F77
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690A313D517;
	Wed, 10 Apr 2024 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLw3FWQj"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA613D26E;
	Wed, 10 Apr 2024 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735796; cv=none; b=QhnMSDaPmfCTPf4kX8XvxZHf21I/sN9xrfhFGqCju1wDYa+/sWCGWJ6xZrL5OPmrK6JObf50qVBy28MZ2tRSATgM1mwEvUt/NUBgD5sE5ExFIDbthELpT+cjPrSsIyjRyhBboFxPjKKPUZKZVfIIQM/GnJ7uLTXIIAwz2raY8F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735796; c=relaxed/simple;
	bh=0WiWGzA/mgnWtiR5A6Bj5e+oidhura7hrLLltujdYYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bkrvGG/40BenQwYShITwCKpqwpOeTitJaPnud5WYxV8KpcKPHKcoaV07m1KA5qyul0Y5IdDkSPquCjRQqOcEir01pQsMsM3aCUVXqj2lVM/WKk2AE38YoUxJ1nSt/Ck2BjzM01Ge0GQH50bL3KJ5ni7FLx83XyBc5SkusbU9EKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLw3FWQj; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5aa318db8a0so2214736eaf.1;
        Wed, 10 Apr 2024 00:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712735794; x=1713340594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/axXi0hsXb8rl2kIh5NY2VLpwL5Ga/fG6EAxQSEyNXI=;
        b=YLw3FWQjDEZvjzJ+JjjgctUTVmG5Yo5ZNFU06zavJhZvUXBIClStjPJivuEx0+NmEY
         R7INp/kH/McoodqXlKfUpxDL182fdx9Xeuy03ngyasctVtrkUcGRW9wohJy6cYIrYfun
         S4e7yw52FKVbLyPPemjP8ajH4bIGD3Da6I+vn2ljMAipko4Syid8Kxd36EkhMV7+3cAZ
         vgz5QBGjPxP8EykYwbd89/rEEfpCgcOzeXCgKYbse9Tpz1JYd2hSHqWBFmgKVrVmuvxP
         1K3uo8FBZcKUqQA10K1pFjhM31S/CfmWuVBBA8AXQU66WUJVgH14D4FY4qXnIuMPxVK1
         0UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712735794; x=1713340594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/axXi0hsXb8rl2kIh5NY2VLpwL5Ga/fG6EAxQSEyNXI=;
        b=b6sgye5cwoMuLkjj1uVn0er8jg9N+HWUz1OLNbkPnbWZHawG6lNopsz9KG7zrVmrjW
         RWvFMr1RMrbKyqRPGpN/u98OqXegdKlIhAFUVkLsvhQXQNPSzB/06CxSSGqHE8nC60ii
         wIQecE0Rq7S00c3qiKh/ptUVD7Ics7u84aH+etnHFezxWG/lteLk233l27HHC1XH3ovX
         x5jq1+wDsAwc1mqTQ4EppLOkpJLDT9EhzeGSbCgo1HlLwCoJj1zAhqRGoRJ1fo1OP0Ik
         OijhDWtzNLDXaV09TFwL7BJxs+u5snLWkF+wRzuUgpPvjQ5z6vT+m7ISEg+VwYHuOmgX
         s9dw==
X-Forwarded-Encrypted: i=1; AJvYcCXnnbX1w66dxJnZ/Lorv1Cgu2GKUU0ZGPsGZXeRRKG/pbRprK4DpodiHpNt/F060GgkbT29/hpzjNGWwggRceoNy/KhaAQgiQiMUpXL
X-Gm-Message-State: AOJu0YxrWstJ28MuDuj/0KOSWgIg812E30F+NXd7WMw+kOswwZqvrKal
	iVuNmr8boeI6UW9Q+8Uqk59o3p6vh4cEzCE0ovTlfgvHMEHyRczRHlPylVBu
X-Google-Smtp-Source: AGHT+IFZvDJ/SKnT+xst9ukvui5AVAUmARDTHVPZ4etzb/5U+fPsS5cy4z27vEX5+GbE1CuFIX9qeg==
X-Received: by 2002:a05:6358:a053:b0:186:2990:adb6 with SMTP id f19-20020a056358a05300b001862990adb6mr2990931rwn.2.1712735794086;
        Wed, 10 Apr 2024 00:56:34 -0700 (PDT)
Received: from carrot.. (i220-108-140-44.s42.a014.ap.plala.or.jp. [220.108.140.44])
        by smtp.gmail.com with ESMTPSA id 3-20020a631843000000b005e485fbd455sm9438001pgy.45.2024.04.10.00.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:56:33 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs <linux-nilfs@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] nilfs2: fix missing kernel-doc comments
Date: Wed, 10 Apr 2024 16:56:26 +0900
Message-Id: <20240410075629.3441-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

please queue this series for the next merge cycle.

All of theses are to fill in missing kernel-doc comments or correct
missing argument descriptions.

Thanks,
Ryusuke Konishi

Yang Li (3):
  nilfs2: Add kernel-doc comments to nilfs_do_roll_forward()
  nilfs2: Add kernel-doc comments to nilfs_btree_convert_and_insert()
  nilfs2: Add kernel-doc comments to nilfs_remove_all_gcinodes()

 fs/nilfs2/btree.c    | 23 ++++++++++++++++-------
 fs/nilfs2/gcinode.c  |  1 +
 fs/nilfs2/recovery.c |  1 +
 3 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.34.1


