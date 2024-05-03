Return-Path: <linux-kernel+bounces-167249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2A18BA66A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EBA282A3D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB2E139580;
	Fri,  3 May 2024 04:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Cg+lB8xK"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F6139587
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 04:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714711855; cv=none; b=FnqkFvUIwUS5IzaSfbaT7kzGLp2uHsgTNCWpKAMVmWnRQxcVM+XsZECSwWUW5WMbbg7nIC7MdVTwDBQWTfrOnyLAY5zKqGnJSq5oewhK4WmNMmXDWCRTk6ZskQIXLRtndydDUHmGDRkVjUq8Ps1Or5lbDFSxvknOrl6rTPrLbAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714711855; c=relaxed/simple;
	bh=Dxpzzy/z93hXB1aHpi749r74tSlAAuPK148cUOanOFs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MIq9caLlikpjpOa5kidH2Y4ux+s33GH14cVffCQn4y2cSdcip9hyG6Psva9rM4uLpzPZQyz/EXBGwryDkMsPX8NrHfSkQ8/GjgjptnTHZBxm+luGESSVWJSnY9rcQBP6Mic4QWQisyCGL3Glwi9rVvTwH9vBpkoSYiQ90lC5kUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Cg+lB8xK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso15593535ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 21:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714711854; x=1715316654; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P1pri5vJc6a6erBHblT+G/90vMaXtH4w+W1SfMwHWew=;
        b=Cg+lB8xKyyG8CMM/pOuVWD9VDiI86sE5+JPwkaDANWLTY1a/3XEHQUkZWbEU4tAbeM
         PJzx0LAvQrHKfY7RxfttncNRFCTp7TK/eIbTbzIyaWU/rMw7106HYqdzkKXTHnGV+5Ze
         iiSqpO0QG3gwhO/e1nsADl6smqvAPKaOWkCdi5KK2zcq+iOoLfntPd5eRslvyPM+7VHV
         Z0q+nZGyTK6YjVSXjc1aGyy0ltg0Fy1plF6Sn8HVrHJHx95Sufbc6sVg5u147E4SiZn5
         lrjmfdbeiaeYZkOSPFQRgwHRQDtuVO0muNinnB9dN9kGXfUVbWTGhBkF42Ct5YT2OKGk
         Q+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714711854; x=1715316654;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1pri5vJc6a6erBHblT+G/90vMaXtH4w+W1SfMwHWew=;
        b=Xi0aGZEz1dWYRGx1bJf2dtTFdoiXGiBezj+IeK7i5omXBtyNonGO2sqCylBgTAQ03S
         8KvZc9mj9/TPuyj9TpxG3w98sDhOteNvlGXLH1g4IKWUogLzyoarR9tDxdLO4O7DjUU9
         isBpPOESuwKyPq7WLzw9IZuSOBEKHqfR2DbpHvoRk6tnyQ25+MDmtGy1Wx4GIMqkWSmQ
         Tvxv0sSlTGJSQEmkoKEIHUQECuBvzAoa3Y2Sa+rnobVBhjP2ec5O1xyllBOIUkX2VbTh
         f+k8lMys5WBAkbHxGwUakeu/k4kPMHWNL3TukIRlEf6yypK0IohnYorlr76h0bWloJaS
         J//w==
X-Forwarded-Encrypted: i=1; AJvYcCXJ4X4VMHKfU79ZP278DYWFWoQsGHkndq4GmmQWQQ8GIjEEJgtORrS4Piz61wS1ClZ2F3W1YifW6MPGEmv/5fkgcHWH5rejDm7rHlUc
X-Gm-Message-State: AOJu0Yxhf6K291vk2d4W2DwtVW3YyGRbkzqfzMcqN6UENt92/esDdpZa
	V3n1gv/grgFbeqHlVPRs3kPDB/nrfL9qCIKS1+pz3Bb5xqHLYk1J7qogbFUNcCA=
X-Google-Smtp-Source: AGHT+IEORFLsgu03dCb67137W9/Puz9LTNMIUDTKupfQs2TVKEvgT1NFtqJrCUNXu0iFi8qln7RGqA==
X-Received: by 2002:a17:902:ecc5:b0:1ec:c6ba:de3e with SMTP id a5-20020a170902ecc500b001ecc6bade3emr1582135plh.57.1714711853907;
        Thu, 02 May 2024 21:50:53 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id li11-20020a170903294b00b001e3c77db2aesm2276384plb.88.2024.05.02.21.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 21:50:52 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v4 0/2] riscv: Extension parsing fixes
Date: Thu, 02 May 2024 21:50:49 -0700
Message-Id: <20240502-cpufeature_fixes-v4-0-b3d1a088722d@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACltNGYC/33OwQ6CMAwG4FcxOzvDusHEk+9hjIGtSA8yssGiI
 by7gxMxxOPf5v/aiQX0hIFdDhPzGCmQ61JQxwMzbdU9kZNNmUEGKlOguOnHBqth9Pho6I2Bl6J
 Go6wuJWqWar3HdZFat3vKLYXB+c96IYpl+geLgmc8P+eopQWAor56ii5QZ07GvdjiRdgaxY4By
 dBSa6WgFhL0jiG3RrljyGQUVSWEtZgL+fvHPM9fBoKo8TsBAAA=
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Evan Green <evan@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Andrew Jones <ajones@ventanamicro.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714711851; l=2166;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=Dxpzzy/z93hXB1aHpi749r74tSlAAuPK148cUOanOFs=;
 b=be228u4Ild/sEBi/+uvBsPWy7IukprxcPHtzBJD7A9ck+Fsnxq/xVWLZ8cCYLRex03loQOBw9
 c4LOUEkw6KWAkoFoVflv5PTwjn2PCqF1oKiEx823WLkTQfRcXjRYWFa
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

This series contains two minor fixes for the extension parsing in
cpufeature.c.

Some T-Head boards without vector 1.0 support report "v" in the isa
string in their DT which will cause the kernel to run vector code. The
code to blacklist "v" from these boards was doing so by using
riscv_cached_mvendorid() which has not been populated at the time of
extension parsing. This fix instead greedily reads the mvendorid CSR of
the boot hart to determine if the cpu is from T-Head.

The other fix is for an incorrect indexing bug. riscv extensions
sometimes imply other extensions. When adding these "subset" extensions
to the hardware capabilities array, they need to be checked if they are
valid. The current code only checks if the extension that is including
other extensions is valid and not the subset extensions.  

These patches were previously included in:
https://lore.kernel.org/lkml/20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com/

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v4:
- Delete comment
- Link to v3: https://lore.kernel.org/r/20240429-cpufeature_fixes-v3-0-6aa11dde513b@rivosinc.com

Changes in v3:
- Change comment about assuming all harts have the same vendorid/archid,
  to just state that only the boot hart is probed.
- Link to v2: https://lore.kernel.org/r/20240426-cpufeature_fixes-v2-0-7377442b1327@rivosinc.com

Changes in v2:
- Move comment about assuming all harts to have the same vendorid/archid
  to apply specifically to the code that expects that (Drew)
- Link to v1: https://lore.kernel.org/r/20240424-cpufeature_fixes-v1-0-585e73d2226b@rivosinc.com

---
Charlie Jenkins (2):
      riscv: cpufeature: Fix thead vector hwcap removal
      riscv: cpufeature: Fix extension subset checking

 arch/riscv/include/asm/sbi.h   |  2 ++
 arch/riscv/kernel/cpu.c        | 40 ++++++++++++++++++++++++++++++++++++----
 arch/riscv/kernel/cpufeature.c | 10 +++++++---
 3 files changed, 45 insertions(+), 7 deletions(-)
---
base-commit: ed30a4a51bb196781c8058073ea720133a65596f
change-id: 20240424-cpufeature_fixes-91bec4d793e7
-- 
- Charlie


