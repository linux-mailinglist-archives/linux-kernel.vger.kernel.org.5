Return-Path: <linux-kernel+bounces-104316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D1C87CC1B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3382B21D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C491AADE;
	Fri, 15 Mar 2024 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DSR6Lkko"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF921B7E2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501389; cv=none; b=usCiEuaSRxbJJTU7FsgG4Rw0ipvStxLDzPqh2rcDdSiUq3MCTK+rf6lMgSO1inzNiFfrBmT0OTVZAb4ol5Z01h1HST+x/DbcI9GHMXfj37x480BHnDsOza56ItkKca/tUkCGm/ucWnJhu1I5SS4mmh6Tj1p8GQaOM5NcwS+wkos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501389; c=relaxed/simple;
	bh=RFtAB0IdanX6/2yYH8hYW+p9AP7BVygvCgvYrd2v3Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=te3iMcR2twzXj8VlprRezHKeRD9WYZpn4xAO9tP1tdXjRkwRD/rnGZA/+SyclS+CAbziPBiFbNQvG0k4fFNOTj6kHinegJMOE154+DljvmRU93Pa+Zgd/CnGwmy/+QROq1QtkPLZtpc1faDjS4+9Jxx1tsH7V0zzrrDBl8SPDJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DSR6Lkko; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6082eab17so1833379b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710501387; x=1711106187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0MYemMVXfcwym4dqzvAuTYbxf7jh51PQWqcbKiVUnPw=;
        b=DSR6Lkko371ncsU7k+hd8p41xRVFhvM+1XeSCRbn56WWTTWtfDJSyr6xVaCLwztT2R
         K06f0bVtx/70LEQMGlpczYqnxIb3m31c0lmJ2IZD/ND61nVhQBRBU2sN+5+9wB1Le4/C
         7bdpWUx06mpIiOMs0dyM7QRnhNJMCxySWTUn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710501387; x=1711106187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0MYemMVXfcwym4dqzvAuTYbxf7jh51PQWqcbKiVUnPw=;
        b=QJ2+B3/f4aGTYCVnkyeHSccZ26S22GPmav5gGNYFi26jd7wTqwbk0xoagIjmIYKYno
         iX6/rhBun6z2xgsuRjFN3hhGlPpW23DPQCSaZ6DmkR1oyPV242hzCVvtfhVnMZASBoFi
         gBZHVD5QlNx2Qitgm2NJfT2M6sRun0F7gF9qWhhbQKlEjc7YoUrzzZHeLwJMqkXFHxhs
         cNjPVBZSisRSKR7mNoPGvdzXgsEYc2bpQXQA+OUaTkBPDeMGchEMOng92XLcfxws713Z
         wtLSAf84HUKZ8uZNmiQh7mxEg5j3IHIbSCd+imbssBcUcdq/8HVIYDUS6S9AsLiv0z4u
         AwTA==
X-Forwarded-Encrypted: i=1; AJvYcCW1a8zZJSzMHyrCn7HKZNQOpr/RwtxIH1Q8J8l8m14IxDTEuACpHRxqbmq6PHXTdYSLJRzLMHRVHnpVDCk+nVH+QqJNIjEVwZ+cWzDy
X-Gm-Message-State: AOJu0Yw1FmtwRJczfU7NaEq2iEyTciSqz08GPVwOgoKZAWvTY1a+zMJG
	ZVootsE/xFHw8cQojgVf9nyKNOgpQm/CNXfKfl++oY7e4iXcYKkuhvElDkhI9cmQrmbIl/QHcsE
	=
X-Google-Smtp-Source: AGHT+IHkV6rWNk9VP1u+5Gar92wJ+6cA36TJ/sdDtyUb7G3JlBmUL/yk8qKG8iSNBDStFe511ywLaA==
X-Received: by 2002:a05:6a20:d387:b0:1a3:4a1d:10a3 with SMTP id iq7-20020a056a20d38700b001a34a1d10a3mr2847412pzb.35.1710501387166;
        Fri, 15 Mar 2024 04:16:27 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:2f9c:c00a:bf1f:e53c])
        by smtp.gmail.com with ESMTPSA id c11-20020a62e80b000000b006e6aee6807dsm3122683pfi.22.2024.03.15.04.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:16:26 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2 0/4] Update Vgpu minimum voltage for MT8183, MT8186, MT8192, MT8195
Date: Fri, 15 Mar 2024 19:16:01 +0800
Message-ID: <20240315111621.2263159-1-treapking@chromium.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the minimum voltage listed on the Vgpu regulator datasheets instead
of the minimum value on GPU OPP table. This is because the requested
voltage could be lower when the MTK Smart Voltage Scaling (SVS) driver
is enabled.

Also update the incorrect MT6315 regulator usages on MT8192 and MT8195.

Changes in v2:
- Update Vgpu min voltage for MT8183, MT8186, MT8195
- Fix other usages of MT6315 buck1/buck3

Pin-yen Lin (4):
  arm64: dts: mediatek: mt8192-asurada: Update min voltage constraint
    for MT6315
  arm64: dts: mediatek: mt8195-cherry: Update min voltage constraint for
    MT6315
  arm64: dts: mediatek: mt8183-kukui: Use default min voltage for MT6358
  arm64: dts: mediatek: mt8186-corsola: Update min voltage constraint
    for Vgpu

 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi   | 1 -
 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 2 +-
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 6 +++---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi  | 4 ++--
 4 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.44.0.291.gc1ea87d7ee-goog


