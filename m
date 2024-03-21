Return-Path: <linux-kernel+bounces-109705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D9C881C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5BC1F21760
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFD04D10A;
	Thu, 21 Mar 2024 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kNq2h+D5"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2968B41E4E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711003725; cv=none; b=WYw/h+dxAxo6ZBpVhDBGK84KiGrXmv5UAYgLKFqV8JbYKxOrbaQ+vEwWb+gYKXCzCbAQnxAvnj7/mLd0goXHpeNOuynublVJBdfjEkxi+SllEujsn9J7L4ntBnjAyw9VAkZykFiWAj1nssBnxZ3SQZHo82seUB1bhE0425fZAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711003725; c=relaxed/simple;
	bh=IgovOM9KUeWENwA/mJE5Ljvl53JZKmY38SkL4KVY3lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dm0N9AChBPDnrd+JymeqYVjelq90zcApj9jPR5ygKTCMmLsoLMorZ+cxfFhAfHKj2t7dcqymZTSTBgaTZSpMJLYbFLYRlufE2h4752+4z3bMjPT4NatN4zMGzp4CT30BWct/FXhvGYpusUu054FTZKG5U9+/B/QiWnY8HknLZXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kNq2h+D5; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6962a97752eso5111776d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711003723; x=1711608523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XtvNQiaw+2/IaxnmzdGoLxqPTPX+iJkSvUz6nFXt6OU=;
        b=kNq2h+D5pU/x+HKQkFXMruHAdEi60RdaLJgIsqkA1OoAEE9wf+pt8SABbzYtFN7oLy
         6Ggo+4fJzWQpvYbJS3vhZ5iJh0PdwGIl70qV9TW1onpdctfH0VYc/y8jiUpAdihUq2Kr
         7uvtmsvFEZp9Dps0RQ/n+UeFg2pCARgVMSmPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711003723; x=1711608523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XtvNQiaw+2/IaxnmzdGoLxqPTPX+iJkSvUz6nFXt6OU=;
        b=ZOUgEQjFLp2PZ3Vjl/fVt4uII11l/McXWUKM7mf3xIGgzcGcRdxWgPVmb1XFvfgwcD
         gz3HKiSueOd9uWxvAbymKRrzlwhiK53LPD7SmkL2FkbjAy0CTcrvW7GVjIM4N2qNV7Rs
         nPCH/2QL4f+v7HGml+BIJAj1IBHrmOv2/1nV49kGyyH8OUAiC7L48I43xaQ6VVier4bw
         KlekJiq2wzwH/nPV3FtNRtlksGke6QZmr/B8IrocLVdxqxTZkKynfGm4jmk1iMwKJxJw
         5SZvCq9lKhoHJX6czSMcK/0hA4HnU5IfAc1r96wMo/myV/P3ZEort+277PJlcP2hJqXL
         FRyg==
X-Forwarded-Encrypted: i=1; AJvYcCWk6baLkQ3yHY1SUHdVDkEfhD7HSsVygn9mPWJUeUS6s46517QgxLFFtSEo2jdYO8HxHQ542Mv0+SHPjWmyTNaILcsK5ZFdmePVKpFP
X-Gm-Message-State: AOJu0YyntU81ky77fqFFlD5/UjMrt4kM3Y0RditsZznM9biwtwq3NuMR
	jXVU4PHlc0wZwkomRJGXA6N2P94Szf+ZdEnQZSnPBser26brkIXvP0HvGqCcH3cK8//5MLeNubQ
	=
X-Google-Smtp-Source: AGHT+IHWd5hWPmT05m/dMO6abQe1VIjaPIiKOk2TwZu/GsKoXdSkfitV4XwZzfzNFOrPnEs3/o8wrg==
X-Received: by 2002:a05:6a20:4907:b0:1a3:4469:5967 with SMTP id ft7-20020a056a20490700b001a344695967mr7091773pzb.57.1711003407287;
        Wed, 20 Mar 2024 23:43:27 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:c1ff:a4cf:ac35:8df6])
        by smtp.gmail.com with ESMTPSA id lb3-20020a056a004f0300b006e664031f10sm12874938pfb.51.2024.03.20.23.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 23:43:26 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Daniel Kurtz <djkurtz@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH 0/2] Fixes NULL pointer access in spi-mt65xx.c
Date: Thu, 21 Mar 2024 14:41:00 +0800
Message-ID: <20240321064313.1385316-1-fshao@chromium.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series contains two patches for spi-mt65xx.c, both focusing on its
interrupt handler mtk_spi_interrupt().

The first patch is to fix a NULL pointer access in the interrupt
handler, which is first found on a MT8186 Chromebook device when the
system tries to establish host communication with its embedded
controller.

The second one is a decorative clean-up when I'm working on the first
patch, which simply renames a variable to better follow the rest of the
code.
I put this after the first fix because I think that will make
maintainers and users slightly easier to only backport the fix if
needed.

Looking forward to any feedback, thank you.

Regards,
Fei


Fei Shao (2):
  spi: spi-mt65xx: Fix NULL pointer access in interrupt handler
  spi: spi-mt65xx: Rename a variable in interrupt handler

 drivers/spi/spi-mt65xx.c | 47 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

-- 
2.44.0.396.g6e790dbe36-goog


