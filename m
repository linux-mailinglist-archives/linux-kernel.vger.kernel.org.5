Return-Path: <linux-kernel+bounces-151676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 260348AB1E9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70F328327D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83D512FB3C;
	Fri, 19 Apr 2024 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1qmu3f6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0422512F5AF;
	Fri, 19 Apr 2024 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540804; cv=none; b=XGo7TSAMf2AGwC9KFAi0C98ZdmOC0Qtghf+2u5kpfCcPmaYc6nVtdbLfUP9n7qevxTPLC0tYJOfn3lEg8ZN1ccEpyiELW2Q0vGCsNtnTOB2Zt5iGpWRYvBoyrbyah3h9nwxB8vKqo1++JtCbZ3WeVDuBBd6R6BZEqcohe75GYfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540804; c=relaxed/simple;
	bh=PF5nOun/ElSeyjH30Yzba7W8+NsxRZxYagsm6bk3ugw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdxk7WmmYWIT+k+vbTpeMgqQNLQVHa20dRwP9fosjHHPFd1pF2yX6yFNWphFXUXbXsVRYGBmYYMMs6nHxv5Ha31RoU4l2/+fdeN6Y3h3PFgshP7uL/bDrr3Cd1/zk1ErzUlUnoT+UIpoo2b/kzwgn4HMvwLX6yayqUvQRTz3MoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1qmu3f6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9E4C32782;
	Fri, 19 Apr 2024 15:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713540803;
	bh=PF5nOun/ElSeyjH30Yzba7W8+NsxRZxYagsm6bk3ugw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j1qmu3f64YE+H5EhqFyjEzn3adDOYPJxZmMpa9qJKZ8XuyxHDIe2eLp8Gi/8NJoWd
	 C3PgU9lnWeoBmNhVHg/nsV9QRf6nYnpjzHQKtFHbRGuKD64r93HOB8MmjymptFgN50
	 RIul54GmRK/tadpJ8XPKvIJyOOj92+WmtwkTa+DJ1d7E+/yCCM5CxQKfmvodBrUuMQ
	 DKsBSiDF1UsvUvX0BzxZrTsrKp0QaQwZVKNY0WFzWijjr9h2PGGDZohw4yOBMrMHZk
	 jy/yyBUUlHAsY215Ja+svoFh+ezFM0+IG28dWIEWK+v1nJk4yb+H5TvKfQJ5FHlltq
	 /1yMdfrKf029Q==
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	gregkh@linuxfoundation.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linuxarm@huawei.com,
	Shaokun Zhang <zhangshaokun@hisilicon.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Atish Patra <atishp@atishpatra.org>,
	Anup Patel <anup@brainfault.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Frank Li <Frank.li@nxp.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Liang Kan <kan.liang@linux.intel.com>
Subject: Re: [PATCH v2 00/30] Add parents to struct pmu -> dev
Date: Fri, 19 Apr 2024 16:33:00 +0100
Message-Id: <171353877337.24595.9649607787666856891.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240412161057.14099-1-Jonathan.Cameron@huawei.com>
References: <20240412161057.14099-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 12 Apr 2024 17:10:27 +0100, Jonathan Cameron wrote:
> Robin posted a patch for the cmn and that reminded me that I never
> sent a v2.
> 
> v2: Drop first patch that added a parent to struct pmu as that has been
>     upstream for a year.
>     Drop the arm-cmn change as Robin has dealt with that one.
>     Gathered tags.
> 
> [...]

Applied drivers/perf parts to will (for-next/perf), thanks!

[01/30] perf/hisi-pcie: Assign parent for event_source device
        https://git.kernel.org/will/c/1fb8950417a4
[02/30] Documentation: hisi-pmu: Drop reference to /sys/devices path
        https://git.kernel.org/will/c/d0412b6ecb4e
[03/30] perf/hisi-uncore: Assign parents for event_source devices
        https://git.kernel.org/will/c/16d417f6c45b
[04/30] Documentation: hns-pmu: Use /sys/bus/event_source/devices paths
        https://git.kernel.org/will/c/eff6af531335
[05/30] perf/hisi-hns3: Assign parents for event_source device
        https://git.kernel.org/will/c/3d957de12c65
[06/30] perf/amlogic: Assign parents for event_source devices
        https://git.kernel.org/will/c/1b7718fcc3f2
[07/30] perf/arm_cspmu: Assign parents for event_source devices
        https://git.kernel.org/will/c/3a1bb75ebc1b
[08/30] Documentation: xgene-pmu: Use /sys/bus/event_source/devices paths
        https://git.kernel.org/will/c/867ba6d204f1
[09/30] perf/xgene: Assign parents for event_source devices
        https://git.kernel.org/will/c/89e34f8bee6c
[10/30] Documentation: thunderx2-pmu: Use /sys/bus/event_source/devices paths
        https://git.kernel.org/will/c/90b4a1a927ee
[11/30] perf/thunderx2: Assign parents for event_source devices
        https://git.kernel.org/will/c/ecb79c21c189
[12/30] perf/riscv: Assign parents for event_source devices
        https://git.kernel.org/will/c/50650e5f3186
[13/30] Documentation: qcom-pmu: Use /sys/bus/event_source/devices paths
        https://git.kernel.org/will/c/556da1343452
[14/30] perf/qcom: Assign parents for event_source devices
        https://git.kernel.org/will/c/6148865dd57c
[15/30] perf/imx_ddr: Assign parents for event_source devices
        https://git.kernel.org/will/c/1d194ab8571b
[16/30] perf/arm_pmu: Assign parents for event_source devices
        https://git.kernel.org/will/c/7bf75431a9ba
[17/30] perf/alibaba_uncore: Assign parents for event_source device
        https://git.kernel.org/will/c/1919bd8e0be0
[18/30] perf/arm-cci: Assign parents for event_source device
        https://git.kernel.org/will/c/e7ec4791f903
[19/30] perf/arm-ccn: Assign parents for event_source device
        https://git.kernel.org/will/c/f4144be05a60
[20/30] perf/arm-dmc620: Assign parents for event_source device
        https://git.kernel.org/will/c/46bed4c740d5
[21/30] perf/arm-dsu: Assign parents for event_source device
        https://git.kernel.org/will/c/bc81ae2efbb3
[22/30] perf/arm-smmuv3: Assign parents for event_source device
        https://git.kernel.org/will/c/a8889fbf16bc
[23/30] perf/arm-spe: Assign parents for event_source device
        https://git.kernel.org/will/c/4052ce07d5d7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

