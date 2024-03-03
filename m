Return-Path: <linux-kernel+bounces-89886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BB086F6E3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4B02821F5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3897679DB0;
	Sun,  3 Mar 2024 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc7e5Ae9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5785379DA4;
	Sun,  3 Mar 2024 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709495424; cv=none; b=O5XHCLujlPOjl+OevetQtOy/hwOzhm6OgHXVEBFieGrPV1ISzzqUU5lBn6QrFn5O86D2BOjwrTIA6g+6eOCVbRr9VxDBex4Mj9m3Gk0bAhXGDSydkxE0nKh8ztIzdm/AVelcXDaqQcJKS/eHSdkKvsPM2ho+VtHGen9iXE0XU64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709495424; c=relaxed/simple;
	bh=ognP/Lk8RO+kTR63eX/JZnn/1V4hiuaop88vpZ83+KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gv6pqQkhbpF9g5ymvR6uQwyiwIWqXDMMV4hQEOPgDtcADLGC/Dge43Bd9ajMcNhRhIfE8jkFVm2lO0yyMCeJepRG1JxFjCEIeSaD+6GnVB1Awkr2TozgLj46vuVPuVYF7TPgNvY8Zr0GJzMnqVz3X3+cGoYcVJvqyANvTRfzzvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc7e5Ae9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135D9C433F1;
	Sun,  3 Mar 2024 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709495423;
	bh=ognP/Lk8RO+kTR63eX/JZnn/1V4hiuaop88vpZ83+KI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bc7e5Ae9A4pd0gbpXPlek+0sT+0v8eXFsg1gQQGIyxv/LD7K8fYWKya53lyzxE6Da
	 0kxzKed2VAjIzOpi9q6woRh9S8JtgI+COK/GvD5S4VR4IU5W4Uzj/2ts10dLb2d9kW
	 /GTy/EwY65In0Qj8W/70hTlv2iVAyecy1BUV7DwmUSWdyCgO8kzh52mXb6qUFTld63
	 bORnTfkYCO/VZ8ImRUcHC+BCrRjSAfCj5lQiAbX4cSKf/bwj6MCuD74M2UzLaKZ/Nv
	 NGBvyMQPDVgkW76H5bv449vX4+NZ3wQ3upV2ifrAFML7SeHmnSamZ3p9cXAURS4Xjf
	 d8IS7YvztJCag==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] clk: Fix a core error path and missing qcom camcc-x1e80100 enum
Date: Sun,  3 Mar 2024 13:50:18 -0600
Message-ID: <170949540962.78121.17990412445829225751.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302-linux-next-24-03-01-simple-clock-fixes-v1-0-25f348a5982b@linaro.org>
References: <20240302-linux-next-24-03-01-simple-clock-fixes-v1-0-25f348a5982b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 02 Mar 2024 00:52:13 +0000, Bryan O'Donoghue wrote:
> Using x1e80100-camcc on a recent kernel I discovered the following NULL
> pointer dereference.
> 
> [    1.347567] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [    1.347569] Mem abort info:
> [    1.347569]   ESR = 0x0000000096000004
> [    1.347570]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    1.347572]   SET = 0, FnV = 0
> [    1.347572]   EA = 0, S1PTW = 0
> [    1.347573]   FSC = 0x04: level 0 translation fault
> [    1.347574] Data abort info:
> [    1.347575]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    1.347576]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    1.347576]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    1.347577] [0000000000000000] user address but active_mm is swapper
> [    1.347579] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [    1.347580] Modules linked in:
> [    1.347583] CPU: 1 PID: 80 Comm: kworker/u49:1 Not tainted 6.8.0-rc6-next-20240228-00163-gbe6ae77b72b2 #26
> [    1.347586] Hardware name: Qualcomm CRD, BIOS 6.0.230809.BOOT.MXF.2.4-00174-HAMOA-1 08/ 9/2023
> [    1.347587] Workqueue: events_unbound deferred_probe_work_func
> [    1.347595] pstate: 01400005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [    1.347597] pc : clk_core_get+0xe0/0x110
> [    1.347601] lr : clk_core_get+0x108/0x110
> [    1.347603] sp : ffff800080353940
> [    1.347604] x29: ffff8000803539a0 x28: 0000000000000000 x27: ffffb0aa57c4e2e0
> [    1.347607] x26: ffffb0aa57c4e240 x25: ffff4cbd0511e4c8 x24: 0000000000000000
> [    1.347609] x23: ffffb0aa583c3440 x22: 0000000000000000 x21: ffff4cc07e1d2ab8
> [    1.347612] x20: 0000000000000000 x19: ffff4cbd00e28ac0 x18: 0000000000000001
> [    1.347614] x17: 0000000000000018 x16: 0000000000000034 x15: 0000000000000002
> [    1.347616] x14: ffffb0aa58fc6498 x13: ffffb0aa58293000 x12: 696669746f6e5f6b
> [    1.347619] x11: 0000000ad6d076a3 x10: ffffb0aa58c600fb x9 : 0000000000000008
> [    1.347621] x8 : 0101010101010101 x7 : 00000000736c6c65 x6 : 0080f0e8e16e646c
> [    1.347624] x5 : ffff800080353958 x4 : 0000000000000000 x3 : ffff4cbd00d09100
> [    1.347626] x2 : 0000000000000000 x1 : ffff4cbd00d09100 x0 : 0000000000000000
> [    1.347628] Call trace:
> [    1.347630]  clk_core_get+0xe0/0x110
> [    1.347631]  clk_core_get_parent_by_index+0xc8/0xe0
> [    1.347634]  __clk_register+0x1f0/0x864
> [    1.347636]  devm_clk_hw_register+0x5c/0xd4
> [    1.347639]  devm_clk_register_regmap+0x44/0x84
> [    1.347642]  qcom_cc_really_probe+0x1b4/0x25c
> [    1.347644]  cam_cc_x1e80100_probe+0x14c/0x1c8
> [    1.347646]  platform_probe+0x68/0xc8
> [    1.347649]  really_probe+0x148/0x2b0
> [    1.347651]  __driver_probe_device+0x78/0x12c
> [    1.347654]  driver_probe_device+0x40/0x118
> [    1.347656]  __device_attach_driver+0xb8/0x134
> [    1.347658]  bus_for_each_drv+0x88/0xe8
> [    1.347661]  __device_attach+0xa0/0x190
> [    1.347664]  device_initial_probe+0x14/0x20
> [    1.347666]  bus_probe_device+0xac/0xb0
> [    1.347668]  deferred_probe_work_func+0x88/0xc0
> [    1.347670]  process_one_work+0x148/0x29c
> [    1.347675]  worker_thread+0x2fc/0x40c
> [    1.347678]  kthread+0x110/0x114
> [    1.347681]  ret_from_fork+0x10/0x20
> [    1.347684] Code: aa1303e0 97fff96f b140041f 54fffd08 (f9400000)
> [    1.347686] ---[ end trace 0000000000000000 ]---
> 
> [...]

Applied, thanks!

[2/2] clk: qcom: camcc-x1e80100: Fix missing DT_IFACE enum in x1e80100 camcc
      commit: 9dd7b0d351f0c6af9b69d969919a2a8b04bbfd6e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

