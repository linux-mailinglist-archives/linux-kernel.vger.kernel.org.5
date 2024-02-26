Return-Path: <linux-kernel+bounces-81658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F24E8678D2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3A31F2264C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4613113172A;
	Mon, 26 Feb 2024 14:35:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8719212BEB1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958130; cv=none; b=Ls2Tj6DNa1YQLoWDUE71Rov8sNqHrS3OQ7IYOKh8ciIpODaYfrImaxqJoauuZ8UvVhm5uPO1oEhlgtsDEvvQBO0WlI309FwUcjEpgO7JANxiKn8Bc4yn+lFPJj6YMzVf6qBAawNEw5kbpVbfzcE6sKS9HVorXkJa5MQV+hfot18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958130; c=relaxed/simple;
	bh=Fz41MqNPHXkjmlJi5LlMt1NTgGE6wC6Ek8w812V5lec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XuV69veg292xy3G3juMkMmIbTaqhLMbMEishrilTXnG0m18L2sA+IXG6PobWtNV0DaeNwHlwhHfibHWHUjurc26gYg1dVVaBl2BOp/bEXLwSOQwYfotsTULMqjJgbxgsA8AX0dxjLX1WRKLZGSPLTWrVRPeQgdADDpyjA+bHYuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41390DA7;
	Mon, 26 Feb 2024 06:36:06 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 463153F762;
	Mon, 26 Feb 2024 06:35:26 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: mathieu.poirier@linaro.org,
	Yang Jihong <yangjihong1@huawei.com>,
	alexander.shishkin@linux.intel.com,
	john.garry@huawei.com,
	jonathan.cameron@huawei.com,
	yangyicong@hisilicon.com,
	linux-kernel@vger.kernel.org
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	yangyicong@huawei.com,
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH v2] hwtracing: hisi_ptt: Move type check to the beginning of hisi_ptt_pmu_event_init()
Date: Mon, 26 Feb 2024 14:35:18 +0000
Message-Id: <170895806567.105951.9088649560811181589.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108121906.3514820-1-yangjihong1@huawei.com>
References: <20240108121906.3514820-1-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 8 Jan 2024 12:19:06 +0000, Yang Jihong wrote:
> When perf_init_event() calls perf_try_init_event() to init pmu driver,
> searches for the next pmu driver only when the return value is -ENOENT.
> Therefore, hisi_ptt_pmu_event_init() needs to check the type at the
> beginning of the function.
> Otherwise, in the case of perf-task mode, perf_try_init_event() returns
> -EOPNOTSUPP and skips subsequent pmu drivers, causes perf_init_event() to
> fail.
> 
> [...]

Applied, thanks!

[1/1] hwtracing: hisi_ptt: Move type check to the beginning of hisi_ptt_pmu_event_init()
      https://git.kernel.org/coresight/c/06226d120a28

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

