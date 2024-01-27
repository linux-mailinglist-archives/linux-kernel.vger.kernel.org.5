Return-Path: <linux-kernel+bounces-41352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5CE83EF6F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48993285422
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2232D629;
	Sat, 27 Jan 2024 18:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+qECXtT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81914200D4;
	Sat, 27 Jan 2024 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706379411; cv=none; b=VbhGFXWSnlt8kKLiLuV9/Ve5JjVEN8Jty8qaeCuHiXBGv3moKYKRls2TIrhVPvr53VI+zTZcyPn8rSHzoTFDy6CNPI3e/KFpbz8XfyZB1W1hCojCOmuohyJtYbrYPTUzVvMDGdqdMQ+G5y/DlLT+nEKPujSZXte2fOPHQ12QlMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706379411; c=relaxed/simple;
	bh=+1qi4MjbtS4pEJymhwXKOEn8nfKHKnTrO6/g0+h1qy8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQFJbUSWvDMQQeFvlOWSFwG8MYD1rv/dAGiSDnBjMS+LldUAP2wfAFZU9g665cC9faw5wK8dT4ArSn9BSuv9TTCVEqyR20R0c11jU1VYePtIS98Qvxtr3PZMVyc4u7zbcL4VFvRZNHYnl9URaDvqRmsnM7M2PnrfmsnR83lKNzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+qECXtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798F6C433C7;
	Sat, 27 Jan 2024 18:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706379411;
	bh=+1qi4MjbtS4pEJymhwXKOEn8nfKHKnTrO6/g0+h1qy8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=G+qECXtTL97hIGQi+49kC6uCKcMn9ZR9Y9PZG+NNcr2FueGnAVatJ1xRkVuIKoOnt
	 5cfSXUAtiVNXboAjeqW8HA5B+ro/3ouXabxEfQJSm/J5ZRZfgwv2wh6JzPySuPwZlj
	 exLoFTQizCOxOd3LYK3qdfEonsOPTikvySGBtX7EKzpnl+Xu/hGHJZo+GLDU7G8uAk
	 XH/OwPOuKq2I0GBlRrIUieTm3NgeTUDiOZJ+7z+iaCM0N7o5vEkTeJhiIbmyDBobhI
	 cmhs+ERtdFjX9S8fLUo6J5j8iRxPA+ZUxqev+h0qQeQbgjiwfLfr53QW+DpI51VudL
	 bzAFahrdgff8g==
From: Namhyung Kim <namhyung@kernel.org>
To: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Samantha Alt <samantha.alt@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Edward Baker <edward.baker@intel.com>,
	Perry Taylor <perry.taylor@intel.com>
Subject: Re: [PATCH v1] perf pmu: Treat the msr pmu as software
Date: Sat, 27 Jan 2024 10:16:47 -0800
Message-ID: <170637928210.816351.6189596994646336873.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240124234200.1510417-1-irogers@google.com>
References: <20240124234200.1510417-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 24 Jan 2024 15:42:00 -0800, Ian Rogers wrote:
> The msr PMU is a software one, meaning msr events may be grouped
> with events in a hardware context. As the msr PMU isn't marked as a
> software PMU by perf_pmu__is_software, groups with the msr PMU in
> are broken and the msr events placed in a different group. This
> may lead to multiplexing errors where a hardware event isn't
> counted while the msr event, such as tsc, is. Fix all of this by
> marking the msr PMU as software, which agrees with the driver.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

