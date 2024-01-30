Return-Path: <linux-kernel+bounces-45305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3809B842E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AFE21C24B96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64E871B5F;
	Tue, 30 Jan 2024 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="H6jT2K0w"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF106A00F;
	Tue, 30 Jan 2024 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648350; cv=none; b=R76CVF3SyHLH2c4de1wr0/9G+dxR8PwT+Yw1IuETvgYy1nhEzB0XbfGhEsS+kXePRh/Yb8/5hio1M5uQ2EuebPLbpm0wKJpXQZItitXxVFk8sXEXHwnDQ7bYovjdMamR/tCYXxYJmoAylk+4/SA2R3J5F9XGSjG+dEQBUV2L+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648350; c=relaxed/simple;
	bh=MJJXb4qG2owFQ8t6ZUQMC31iJNYtleq0l6H3DZgMq7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dtup2BUlmTBlld6EeTnf8w+g2FGUecPR39tHAvj/N5qWIn00IWoiNSNcAiGtEnP31qKKtPUESQeYAOM8fWwTiJ0KHCVO2HZqPE+KCn5GVC/8BEOGGmanGyiiBbx4H9wJi/pFFpEyiXSk6w70IxDiOQfeE7RZPETs+FfHPX3Vo0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=H6jT2K0w; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BAAAB41A47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706648347; bh=vRKu2O/0VPzoBZOtxNzJJj2/lV4jOxX7B02gcKXYkV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=H6jT2K0wd4Q1sbqGP0dO9KBXWHIMmBwpf1ZLGQbfFE0jLFDSam3yYaMKU9C4OFAlB
	 mTFTOSYbDUyHYSd7ERV+KYeCcY8/j0RbgkreeIe874YqiERc0/UWTXno2oLxBRCwD7
	 9Y5+RHU6QGPpencdsfLbRcAfM67F2XftD8SxFpm0U06JreMmMeWsj4xAmxIn6jsA7K
	 /SdaIqOU1K/YBAwbX9BN2d3heZ9GJP4mh+Vkw5dk+Yw7dScwdygEPm/EfauGuvYiQS
	 yBzhuncio/SVDkruYfLtlV7V5NtKGV/MOWb+MmLeYyqWqDo1IZX7EzsmjcnIoQR0tu
	 qba1bKL6JhGEg==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BAAAB41A47;
	Tue, 30 Jan 2024 20:59:07 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Leo Yan <leo.yan@linaro.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Ian Rogers <irogers@google.com>, Thomas Richter
 <tmricht@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Adrian
 Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Ingo
 Molnar <mingo@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v8] Documentation: userspace-api: Document perf ring
 buffer mechanism
In-Reply-To: <20240102085001.228815-1-leo.yan@linaro.org>
References: <20240102085001.228815-1-leo.yan@linaro.org>
Date: Tue, 30 Jan 2024 13:59:06 -0700
Message-ID: <87sf2ea679.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Leo Yan <leo.yan@linaro.org> writes:

> In the Linux perf tool, the ring buffer serves not only as a medium for
> transferring PMU event data but also as a vital mechanism for hardware
> tracing using technologies like Intel PT and Arm CoreSight, etc.
>
> Consequently, the ring buffer mechanism plays a crucial role by ensuring
> high throughput for data transfer between the kernel and user space
> while avoiding excessive overhead caused by the ring buffer itself.
>
> This commit documents the ring buffer mechanism in detail.  It explains
> the implementation of both the regular ring buffer and the AUX ring
> buffer.  Additionally, it covers how these ring buffers support various
> tracing modes and explains the synchronization with memory barriers.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---

Applied, thanks.

jon

