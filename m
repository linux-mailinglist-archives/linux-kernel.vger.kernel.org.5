Return-Path: <linux-kernel+bounces-59804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B4084FBE3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DFF28A3CB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A2F1272AA;
	Fri,  9 Feb 2024 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwctSo9K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A9D1272A4;
	Fri,  9 Feb 2024 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503501; cv=none; b=SMYjFtkLNdbJa+iU9v+oOJdh0f/tbiUBqUxao0JEh9dgroVIa/nkkWp4b7eY0Dtt+HuKX6qdRv6tgU/3xRPY0dkbDru+sy/oOAVB8sMwnqAhJfTu3McyBwS6kIQZA+u8PICJFm4v2offFsGhS8EfsmE2/hTaA+dAvzXq5pnDBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503501; c=relaxed/simple;
	bh=2IlRMX/ieZtxo3cdQw6/VrlKIfCnRzjHLu40pTVewHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lk4H/AoxJbdH6vs9dSkBuQsajLrPzfDvma9OOAv1PTEzH9oZN0sZIK7ytbyG4Qa/ultIYFjnWLr3JOd/XjWhZA3m4LQLE180IlM0LrH8YRhqIgY3io0zNuq0Orv5JOrmGaBujjBEWsbwCc5Dkxre28deIyyQX3x8K4mC7BSVzX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwctSo9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A52C43394;
	Fri,  9 Feb 2024 18:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707503500;
	bh=2IlRMX/ieZtxo3cdQw6/VrlKIfCnRzjHLu40pTVewHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwctSo9KPwrHWOplC+5/FYlnyyjRlGoxxhTeJNxK4sYB8TBw/HJprLy4bYSHDriOo
	 H1PUEmhNIlkZV4L85E5/8hOzjGc8MzoGd8wb4YwckaBc1nJ/00Kiez0QDL8KHpa4S0
	 WJ8FZLTBBO6p4apt6VI1GjFAU2f4Cnf2fBYmQ2kK4LLjh78Honq2VDmFJkiZWe5a+h
	 PS35cl4ywVzlFSXZqJspacolT1aswK3+W61ctNtSfvOR2npoyr4NWX3+kAB5hoW5AS
	 Tu+dkU8L3bpKs+HTY2SjolAR1CIICdNgZDQebquy6x4/nFpHXkLrlw2MJwELBxS0Pc
	 DIiJZEDgSBy3A==
From: Will Deacon <will@kernel.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Frank Li <Frank.li@nxp.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	NXP Linux Team <linux-imx@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 00/18] perf: Convert to platform remove callback returning void
Date: Fri,  9 Feb 2024 18:31:13 +0000
Message-Id: <170749437153.2624333.6691453190868131616.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1702648124.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702648124.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 15 Dec 2023 14:59:00 +0100, Uwe Kleine-König wrote:
> this series converts all drivers below drivers/perf to use
> .remove_new(). See commit 5c5a7680e67b ("platform: Provide a remove
> callback that returns no value") for an extended explanation and the
> eventual goal. The TL;DR; is to make it harder for driver authors to
> leak resources without noticing.
> 
> I based the patches on today's next, I had to revert commits
> 3115ee021bfb ("arm64: perf: Include threshold control fields in
> PMEVTYPER mask") and 816c26754447 ("arm64: perf: Add support for event
> counting threshold") to compile test on ARCH=arm (this is a problem in
> next, not in my patch series).
> 
> [...]

Applied to will (for-next/perf), thanks!

[01/18] perf: alibaba_uncore_drw: Convert to platform remove callback returning void
        https://git.kernel.org/will/c/3bc9d71775ee
[02/18] perf: amlogic: Convert to platform remove callback returning void
        https://git.kernel.org/will/c/94843f269abd
[03/18] perf: arm-cci: Convert to platform remove callback returning void
        https://git.kernel.org/will/c/4df3bddf8707
[04/18] perf: arm-ccn: Convert to platform remove callback returning void
        https://git.kernel.org/will/c/0767f1a48532
[05/18] perf: arm-cmn: Convert to platform remove callback returning void
        https://git.kernel.org/will/c/3909cb3b5f8d
[06/18] perf: arm_cspmu: Convert to platform remove callback returning void
        https://git.kernel.org/will/c/79dc1570b322
[07/18] perf: arm_dmc620: Convert to platform remove callback returning void
        https://git.kernel.org/will/c/ca1e01c8d34a
[08/18] perf: arm_dsu: Convert to platform remove callback returning void
        https://git.kernel.org/will/c/02d77ac1ac7e
[09/18] perf: arm_smmuv3: Convert to platform remove callback returning void
        https://git.kernel.org/will/c/d67c3a61f063
[10/18] perf: arm_spe: Convert to platform remove callback returning void
        https://git.kernel.org/will/c/e63b3aef186b
[11/18] perf: fsl_imx8_ddr: Convert to platform remove callback returning void
        https://git.kernel.org/will/c/1bb639382d3f
[12/18] perf: fsl_imx9_ddr: Convert to platform remove callback returning void
        https://git.kernel.org/will/c/78da2a93b55b
[13/18] perf: hisilicon: Convert to platform remove callback returning void
        https://git.kernel.org/will/c/e07486a832bb
[14/18] perf: marvell_cn10k_ddr: Convert to platform remove callback returning void
        https://git.kernel.org/will/c/c802bd9e354f
[15/18] perf: marvell_cn10k_tad: Convert to platform remove callback returning void
        https://git.kernel.org/will/c/86e8963f9dba
[16/18] perf: qcom_l2: Convert to platform remove callback returning void
        https://git.kernel.org/will/c/8a2e438e710c
[17/18] perf: thunderx2: Convert to platform remove callback returning void
        https://git.kernel.org/will/c/d4c5cef73b25
[18/18] perf: xgene: Convert to platform remove callback returning void
        https://git.kernel.org/will/c/b07ebe8f1428

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

