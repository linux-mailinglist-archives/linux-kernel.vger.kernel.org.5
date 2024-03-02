Return-Path: <linux-kernel+bounces-89270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C98486ED9D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41496285216
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CFE5680;
	Sat,  2 Mar 2024 00:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="elo9Eaus"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C53110E3
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 00:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709340742; cv=none; b=QZtOLJFei/5b/NyHANHw/rSr3WO4pTjCCfS6ySIPkGlZ3c1in5Z78DARa6+GClzE63ERVzzd0IUwFOIclfzpX0MNejqNHyrDDWZ0Drh18/B95pfwxRvNuBJNjehdBNCHzZQlbtABwwOlx6e8tgh9bUUjUSfsJvQliqTa8bWcbaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709340742; c=relaxed/simple;
	bh=0C4Zm8OGD2wfa7rKSsJh/pDqxaTcLeGVRBWYQhY3gq4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cHPag65iMtRCymN0AoR+ZfpeTAbNEXJUuMFx1cVeuK2CRGSEjMcaL7h28oia+nYzergZ2otTjYO6tcMz7sq2L4rNguIxPXyWuWO6ZvQ1HysxMRgAK2UEbJZnEP0qfQZ7RYROMhMRCIbRWE0pf5AgjR7khCoJEO14Lj9fVR/ndcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=elo9Eaus; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412a14299a4so19842015e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 16:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709340739; x=1709945539; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a9sPafuVPRUfRRjJtneI0u4WaRjeYFBIK+DPgThslvo=;
        b=elo9EausOnn2W8q0h5yVNuOzbQB8GqUHoUKOyFjfdgl8+aw3JjKHkJYMR/X2FeZG+5
         PkIe703TcjtRCYQHs+NCk8s8fin2FYZW9X/M3jU5w+v1HMMg29A4pekCymaluWW5dfhU
         9vLnqKfwInaQnsDmRwloELc6wwbZwxLMPn0IwdBHbC/uigweMctUX0jDmrFcPP8jViPK
         DWMOEZSjxdKeNLLieyz157o/5B0Y4gbNptcxQLeYR+O7aXd2mrjyztkLwb1nxBMGuokU
         Arq2E3bBlVmHKbYImGf+7FnmBrYx9nYXae1HzH3ihUjou3/pklKXBtpF2RVuyJrCYxCY
         vC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709340739; x=1709945539;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9sPafuVPRUfRRjJtneI0u4WaRjeYFBIK+DPgThslvo=;
        b=Rjrg+5JrWGRpJtxeLFoVB1AVhpTbNn88fNSlPo44BpHamr62jfvENoMG2WvuTqG5nK
         GY0KFZb+YPXeWF0E0FXiMep46WZcRGhjQjNp+daXghRGOeUrOMeS73SaVoboBJnv1lFx
         nSEWHfOrzRhyA/9GfIcSGZvX7FtlQzNTnyRNlSuson7MhEoSAszQCsLpr+rEdn0WTdbI
         ZsGcRvxvBaXqz/FwVZr/bodWRSSVnEA4m0mkQSuYR/k0i5Hy9G4Grb2+3F6Wvi01uK3P
         dFD/JgTxrovtZBxHK3rlY54BX3J5r5FVcqff+VrJakwZpJuMT6wCo9AP1WpyImBRaPAg
         Ui8w==
X-Forwarded-Encrypted: i=1; AJvYcCX1k8qX3vZeLKmC3lTGRBjGcjPFDjR4NLV0XWQuLdpR8/jMmJa2z0a9YRFYfT4xD5iqUN4slGzcFDU9hqp1MX1mbJUKGdO++rO9+ti0
X-Gm-Message-State: AOJu0Yw9ImCT/0BrshP45hoyP6ABJOk+cmfjR9zKAswN7sYtePVnikVZ
	cpy+B+LrY2Spgk1gueISA5qfjtGPiUagl7uuaxKR9UVD0PXmYUcALm6jDpYxWeo=
X-Google-Smtp-Source: AGHT+IExhlzd1a3eeQt3bEx+BU8uO2oDv4HUyKfUsSEmcZ5/ICcYgs8bVYtR8fJONOUdojX4VxamaQ==
X-Received: by 2002:a5d:6252:0:b0:33d:3099:e67b with SMTP id m18-20020a5d6252000000b0033d3099e67bmr2184473wrv.63.1709340738969;
        Fri, 01 Mar 2024 16:52:18 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id f15-20020adffccf000000b0033dedd63382sm5865501wrs.101.2024.03.01.16.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 16:52:18 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/2] clk: Fix a core error path and missing qcom
 camcc-x1e80100 enum
Date: Sat, 02 Mar 2024 00:52:13 +0000
Message-Id: <20240302-linux-next-24-03-01-simple-clock-fixes-v1-0-25f348a5982b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD544mUC/x2M0QrCMAwAf2Xk2UCWVkR/RXyQNtNg7UajUhj79
 wUf7w5uBZOmYnAZVmjyU9O5OoyHAdLzXh+Cmp2BiSMFGrFo/Xas0j/IESmgO9P3UgRTmdMLJ+1
 imNPpGFk45DOBz5Ym/+Cv623bdgSXYDV4AAAA
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14-dev

Using x1e80100-camcc on a recent kernel I discovered the following NULL
pointer dereference.

[    1.347567] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[    1.347569] Mem abort info:
[    1.347569]   ESR = 0x0000000096000004
[    1.347570]   EC = 0x25: DABT (current EL), IL = 32 bits
[    1.347572]   SET = 0, FnV = 0
[    1.347572]   EA = 0, S1PTW = 0
[    1.347573]   FSC = 0x04: level 0 translation fault
[    1.347574] Data abort info:
[    1.347575]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    1.347576]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    1.347576]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    1.347577] [0000000000000000] user address but active_mm is swapper
[    1.347579] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    1.347580] Modules linked in:
[    1.347583] CPU: 1 PID: 80 Comm: kworker/u49:1 Not tainted 6.8.0-rc6-next-20240228-00163-gbe6ae77b72b2 #26
[    1.347586] Hardware name: Qualcomm CRD, BIOS 6.0.230809.BOOT.MXF.2.4-00174-HAMOA-1 08/ 9/2023
[    1.347587] Workqueue: events_unbound deferred_probe_work_func
[    1.347595] pstate: 01400005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    1.347597] pc : clk_core_get+0xe0/0x110
[    1.347601] lr : clk_core_get+0x108/0x110
[    1.347603] sp : ffff800080353940
[    1.347604] x29: ffff8000803539a0 x28: 0000000000000000 x27: ffffb0aa57c4e2e0
[    1.347607] x26: ffffb0aa57c4e240 x25: ffff4cbd0511e4c8 x24: 0000000000000000
[    1.347609] x23: ffffb0aa583c3440 x22: 0000000000000000 x21: ffff4cc07e1d2ab8
[    1.347612] x20: 0000000000000000 x19: ffff4cbd00e28ac0 x18: 0000000000000001
[    1.347614] x17: 0000000000000018 x16: 0000000000000034 x15: 0000000000000002
[    1.347616] x14: ffffb0aa58fc6498 x13: ffffb0aa58293000 x12: 696669746f6e5f6b
[    1.347619] x11: 0000000ad6d076a3 x10: ffffb0aa58c600fb x9 : 0000000000000008
[    1.347621] x8 : 0101010101010101 x7 : 00000000736c6c65 x6 : 0080f0e8e16e646c
[    1.347624] x5 : ffff800080353958 x4 : 0000000000000000 x3 : ffff4cbd00d09100
[    1.347626] x2 : 0000000000000000 x1 : ffff4cbd00d09100 x0 : 0000000000000000
[    1.347628] Call trace:
[    1.347630]  clk_core_get+0xe0/0x110
[    1.347631]  clk_core_get_parent_by_index+0xc8/0xe0
[    1.347634]  __clk_register+0x1f0/0x864
[    1.347636]  devm_clk_hw_register+0x5c/0xd4
[    1.347639]  devm_clk_register_regmap+0x44/0x84
[    1.347642]  qcom_cc_really_probe+0x1b4/0x25c
[    1.347644]  cam_cc_x1e80100_probe+0x14c/0x1c8
[    1.347646]  platform_probe+0x68/0xc8
[    1.347649]  really_probe+0x148/0x2b0
[    1.347651]  __driver_probe_device+0x78/0x12c
[    1.347654]  driver_probe_device+0x40/0x118
[    1.347656]  __device_attach_driver+0xb8/0x134
[    1.347658]  bus_for_each_drv+0x88/0xe8
[    1.347661]  __device_attach+0xa0/0x190
[    1.347664]  device_initial_probe+0x14/0x20
[    1.347666]  bus_probe_device+0xac/0xb0
[    1.347668]  deferred_probe_work_func+0x88/0xc0
[    1.347670]  process_one_work+0x148/0x29c
[    1.347675]  worker_thread+0x2fc/0x40c
[    1.347678]  kthread+0x110/0x114
[    1.347681]  ret_from_fork+0x10/0x20
[    1.347684] Code: aa1303e0 97fff96f b140041f 54fffd08 (f9400000) 
[    1.347686] ---[ end trace 0000000000000000 ]---

The first patch fixes the NULL dereference by checking hw before returning
hw->core.

The second patch addresses the cause of the NULL pointer, which is the DT
implied indexing is not fully captured in camcc-x1e80100.c.

Obviously the above NULL deref wouldn't occur with the second patch applied
however reading the description of clk_core_get() it appears to want to
return NULL but currently cannot do so, so check for hw and return a NULL
if hw is NULL instead of dereferencing hw.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
Bryan O'Donoghue (2):
      clk: Fix clk_core_get NULL dereference
      clk: qcom: camcc-x1e80100: Fix missing DT_IFACE enum in x1e80100 camcc

 drivers/clk/clk.c                 | 3 +++
 drivers/clk/qcom/camcc-x1e80100.c | 1 +
 2 files changed, 4 insertions(+)
---
base-commit: 1870cdc0e8dee32e3c221704a2977898ba4c10e8
change-id: 20240301-linux-next-24-03-01-simple-clock-fixes-dc7542e23d90

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


