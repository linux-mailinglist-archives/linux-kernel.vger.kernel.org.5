Return-Path: <linux-kernel+bounces-163103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2477A8B65BD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1171F21DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB138194C68;
	Mon, 29 Apr 2024 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yVbb1y0k"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C072D1836CF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429803; cv=none; b=u9qvFKmXqwrApIJdL2RVPvkx2PPR927LpKcbZiVdwwqwIloFQLAZ6/V25BxiZvLjscrxpUK9vJIJugEIa3xAftNyNv5f1UMVUjR1IC4ucy6nx2BI+RiYFNazTPaFtnvSX5Ax7GyEjCR8OIk+MKAvlL7tziOmxeUaEgfHXy6HkcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429803; c=relaxed/simple;
	bh=fvClvK1leB3WxFOLHKqvaBOMT13Gn6BJXWn5UVbIdeY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FgdI1hXQyeNRO3ebPsfF9OzShBQQaw9vnjlSvt2LO/EcpVVMpZUtJb/vGMcqN0OVzkgkAF6LIDs6FixeNfBfkpxtZ3WUvygfKWapawuA69gNTNY8w7mmTaFfAVkOlzIw+DSjMvT5CfWUCkdT1hFgMlwP3JTTnJdv0qxqFI2MNuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yVbb1y0k; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so4875080b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714429801; x=1715034601; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RGmL3GuKmY1H42lgMEV/4/Oq9o75wu7J38VSJ3m+Rqw=;
        b=yVbb1y0kzgJTgABGRCE7dQUmDUTsnwc1IVByyK+pMP5N8wur+jEbRLzvVxr27dQ0FR
         QVWFISPJyEVZXL8pmsQse38A99klHVmzSKu0GjK9rAmroi+nyIS6DQM3zog7eLz8wJ08
         BoRUq/5Ri0FFiOmgcdGN1S1PiV3dR68dmP+JQZQx67EXr7aIFLVyLHQl29KTf1XJFMJy
         YzIrBbAj1sUyqpTJL5EXz40uKN6490+Dsf2hqgurrGYDwmPRtZ8AFkCsATP0UfogXTC/
         iAAe719eRT/f2pZ1NzIT6ogqOGkJNFoAk0r1B8yXI6D7sZcTgluLSK/j0Fjk180M9yvp
         o+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714429801; x=1715034601;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGmL3GuKmY1H42lgMEV/4/Oq9o75wu7J38VSJ3m+Rqw=;
        b=qI69rTwIkkxPZo83cplxJBJQ8MZwaqry5nRob5ejw80pdg5/qp7ZTJ3kxpU0zjwOFj
         TTM01q1B3Q7yOLbBPLfJmwe6STwbf10CrIeQbtb0+Wi+TlMkuCauH3aCFrL8ddr3LfXo
         1+WDBo1VkSyZdgSRcXNEcMexZGXHPSlsc/46FF4Rpt8JUs2QKO6nkJLh8zyT27nRoDFb
         FO008tOC3h21t/nBsZLUXQEAs1yXqTZ7BORjFtwUvnrtwo+ae+oylsVrEHH+KJEcFHuo
         HSW8bQxUyfWvrCnPHN/V0/v+BrxzvbvRRb6A8pvDDN6011azYQ4poJPkAQPKvn2hSzLZ
         Ys5g==
X-Forwarded-Encrypted: i=1; AJvYcCV8aDgbuf1nERlRgob1lctTxQWi7vf12QaYRWZ/oxCqQyZU6z7beCPyeNc/TMY6ApHNc8DFa6qp2M0H1yeuo81BmTW0EGNPnnhjOQAf
X-Gm-Message-State: AOJu0Yw4rIIpjr4hhNRWMoiVHcuhaFBc2Q3PJNOSenoPoor2yPzl0BUp
	ij9WvUNJQHgwK80GYhuFSqCjSkkS9oKN/+4Kf23kJakuGGAj+VzGq2R6jT6BVvA=
X-Google-Smtp-Source: AGHT+IEF8OlozRoQce0HwZQGpZ8kYidr5kizYc38QfjcOVCk2gTvkPg51in4Fx1/8xbTKpgZTRq8gA==
X-Received: by 2002:a05:6a20:244a:b0:1a9:c33f:224f with SMTP id t10-20020a056a20244a00b001a9c33f224fmr15161040pzc.16.1714429801055;
        Mon, 29 Apr 2024 15:30:01 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b001e0942da6c7sm20794013pls.284.2024.04.29.15.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 15:30:00 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v3 0/2] riscv: Extension parsing fixes
Date: Mon, 29 Apr 2024 15:29:50 -0700
Message-Id: <20240429-cpufeature_fixes-v3-0-6aa11dde513b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF8fMGYC/33NQQ6CMBAF0KuQWVtDp4WqK+9hjIEyyCykpIVGQ
 7i7hZUxxuX/k/9mhkCeKcApm8FT5MCuT0HtMrBd1d9JcJMyYI4616iFHaaWqnHydGv5SUEcZU1
 WN+aoyECaDZ62Q1pdril3HEbnX9uHKNf2DxalyEVxKMioBhHL+uw5usC93Vv3gNWL+GmUPwxMh
 lHGaI21VGi+jGVZ3mjYqqT3AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714429799; l=2034;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=fvClvK1leB3WxFOLHKqvaBOMT13Gn6BJXWn5UVbIdeY=;
 b=adaWLTF44UudJs4IA0A6KturrVGuVi+n/7nKiVF7xGWLglYddK/1JMAh4nS3mrBUTwSi4dYa5
 B7oyLe7zT1eDbCGy3153GncO7EaR6UDk4FgYK0ITxNtr8ZKxysr/YjJ
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
 arch/riscv/kernel/cpufeature.c | 12 +++++++++---
 3 files changed, 47 insertions(+), 7 deletions(-)
---
base-commit: ed30a4a51bb196781c8058073ea720133a65596f
change-id: 20240424-cpufeature_fixes-91bec4d793e7
-- 
- Charlie


