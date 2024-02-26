Return-Path: <linux-kernel+bounces-81887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F92B867B98
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5A028A87D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B68912C7F1;
	Mon, 26 Feb 2024 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3trr8Zm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C6A12C55B;
	Mon, 26 Feb 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964428; cv=none; b=eadV7NaZARUL1NQrcnLoY/uzt85yKumTkU0CHosBwaER4e2lTSPVtxvLxejZwGKrnG4/Iy3+paG/1WvmOtPqzwLgp6+Z1M1VbyKGUvR9/In4TBZR65eDz/AaSvU6kgFNpFo4+ReKHq+4iIAz1Til1cj82JVIttQepcB02tTE1GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964428; c=relaxed/simple;
	bh=Py+EiuCHVOS32tKSo962ALIXuh08KKc75p5mmglk/ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+RoJCfBXTGazaa3Tlo+mMmbkGCEMmkSChBkZM94xc5lYqjSZs5wD+bcX7FWdr8FTQjNawPtrQyns8O7qup8DPkUi8jaoPLtB9QIU58Ya6J4J+qg3e323IH38Y8LtY0HcvnEJPMy8+r1bmlrjxsLREqILaO/5P4G27HHImzhbSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3trr8Zm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D31C43390;
	Mon, 26 Feb 2024 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708964427;
	bh=Py+EiuCHVOS32tKSo962ALIXuh08KKc75p5mmglk/ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3trr8Zm/qviZuukloOC43cIzB/tXqiH0CevHvbXXhgPcgvv+i2RH3PjPs8uslMCp
	 RfRPBFPaWVMaKnrJuUjfD+X2wyMshe8kfqMq57MvS6d/VoosUS6JsMO/6JYQDcsXqQ
	 ylLLVB4oZ7dGURlY/EHs5aJao5z/lNpxtgLvZiihmdU9T+Fnby5q0W1q8dEijazUyt
	 cXT9e12jj+YSfbDxBw5FH3NFEzAFCeSqX420h+rltyuSNMCLSu/FHE/CyP3KvB3cwp
	 ET3F5d7v5oRTkUaRZgUDcwWtWu1rQ55hgZJ+konXepmLwYNS3D34J2reXQ2fTuMeWK
	 XtkXfWdh0E2xg==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-perf-users@vger.kernel.org,
	leo.yan@linaro.org,
	suzuki.poulose@arm.com,
	acme@redhat.com,
	mike.leach@linaro.org,
	marcan@marcan.st,
	maz@kernel.org,
	john.g.garry@oracle.com,
	james.clark@arm.com,
	irogers@google.com,
	will@kernel.org,
	tmricht@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf print-events: make is_event_supported() more robust
Date: Mon, 26 Feb 2024 08:20:24 -0800
Message-ID: <170896440860.1919080.16667714946535783711.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240126145605.1005472-1-mark.rutland@arm.com>
References: <20240126145605.1005472-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 26 Jan 2024 14:56:05 +0000, Mark Rutland wrote:
> Currently the perf tool doesn't detect support for extended event types
> on Apple M1/M2 systems, and will not auto-expand plain PERF_EVENT_TYPE
> hardware events into per-PMU events. This is due to the detection of
> extended event types not handling mandatory filters required by the
> M1/M2 PMU driver.
> 
> PMU drivers and the core perf_events code can require that
> perf_event_attr::exclude_* filters are configured in a specific way and
> may reject certain configurations of filters, for example:
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

