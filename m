Return-Path: <linux-kernel+bounces-90810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 778B3870549
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07669B29BA7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5034C4EB31;
	Mon,  4 Mar 2024 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXMoett4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F4F4E1B5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565487; cv=none; b=HDMLIts1fVLDNKBTQQdv0KdE9Trq71AIdw3olWHjr6YnIfadKEJdkfo4DM6g6wxPU+xnLQoOwzxss5zR2yFVowny7XfgRlZoYhYkeQ4NqlDYVR7Fs0+skL11OBs6WmpKV2I/BDBXeUrVm8MHvOZ26nJaBXTEtQG3zBGnp82PdkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565487; c=relaxed/simple;
	bh=qdhRIpJjJcHov+iHMqLEx0gJF+9Z4dZSl6Vdkwe23yw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JS3tYt8I+6cWCfURLec3NLfDGgaNkwNu3MNg547P0lhW0k5ukce+r0u8mO5H3HNNfQ3BjJV9ioYr+U3i09GbHfXF2wAiaNOAjIf/1U65rJG/kj6gzI+5+bFdYUd0YA2aXqXRcAHln/w6jc2YWW1wwo6V6Fz2IXKQOGeWRnApE4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXMoett4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DE5C43390;
	Mon,  4 Mar 2024 15:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709565487;
	bh=qdhRIpJjJcHov+iHMqLEx0gJF+9Z4dZSl6Vdkwe23yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXMoett4ZRK7uD/MUGyPFVKzWJSRplSB7I1MdYTwpj9CUiDpXnhewP+itWEFg7SyL
	 SgSAPNMaMGSF0DoDyIFszcoZ71xLuf3GLO3QDI5a+4VD2c82fCXu721+mGyD2PDgDJ
	 OnTC+qK/e9sX22PDoUMn84yRUpDeJdXgV4ON6q3u4xIK2XqSK7OxD3WxovSfMHdJFs
	 Ia3X6bMjWbzxGLTq8VCWvH1K0wMYjOz/iC9LhJZ0XET119zCSVYmvoSP+XRY9HiG/5
	 XrsexP7YZmUiFRPJa/kt2KGZmYTK0pduOU0fLuxS+W4c3j6bwh8ZwJROl821EQBeKl
	 DLcjVQ5JHLNCA==
From: Will Deacon <will@kernel.org>
To: jonathan.cameron@huawei.com,
	mark.rutland@arm.com,
	hejunhao3@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yicong Yang <yangyicong@huawei.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	yangyicong@hisilicon.com,
	linuxarm@huawei.com,
	prime.zeng@hisilicon.com,
	fanghao11@huawei.com
Subject: Re: [PATCH v2 0/8] drivers/perf: hisi_pcie: Several updates for HiSilicon PCIe PMU driver
Date: Mon,  4 Mar 2024 15:17:54 +0000
Message-Id: <170956190997.3268113.11075039105730599713.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240223103359.18669-1-yangyicong@huawei.com>
References: <20240223103359.18669-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 23 Feb 2024 18:33:51 +0800, Yicong Yang wrote:
> This series mainly fix and optimize the several usage of the driver:
> - Add more events to complement the TLP bandwidth counting
> - Fix the wrong counting on using the event group
> - Properly check the target filter to avoid invalid filter value
> - Optimize the handling of related events which are not in an event group
> - Update the docs
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/8] drivers/perf: hisi_pcie: Rename hisi_pcie_pmu_{config,clear}_filter()
      https://git.kernel.org/will/c/54a9e47eebb9
[2/8] drivers/perf: hisi_pcie: Introduce hisi_pcie_pmu_get_event_ctrl_val()
      https://git.kernel.org/will/c/4d473461e094
[3/8] drivers/perf: hisi_pcie: Fix incorrect counting under metric mode
      https://git.kernel.org/will/c/b6693ad68e27
[4/8] drivers/perf: hisi_pcie: Add more events for counting TLP bandwidth
      https://git.kernel.org/will/c/00ca69b856ba
[5/8] drivers/perf: hisi_pcie: Check the target filter properly
      https://git.kernel.org/will/c/2f864fee0851
[6/8] drivers/perf: hisi_pcie: Relax the check on related events
      https://git.kernel.org/will/c/2fbf96ed883a
[7/8] drivers/perf: hisi_pcie: Merge find_related_event() and get_event_idx()
      https://git.kernel.org/will/c/7da377059ee6
[8/8] docs: perf: Update usage for target filter of hisi-pcie-pmu
      https://git.kernel.org/will/c/89a032923d4b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

