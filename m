Return-Path: <linux-kernel+bounces-54123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEF884AB10
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3EB1C23EBC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6DA802;
	Tue,  6 Feb 2024 00:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBja+R3h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5903C440C;
	Tue,  6 Feb 2024 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707178742; cv=none; b=DaoEl/6Qurf0isM28CEhuT0PZxSuxkiVBLVMkW4WO7HfmTACwEfY9HymJkRhCRVGi3354V8y+EqlqYqjjqoIY49lflxDZDtNWOl6//O0I5zx60ufQ6XMtudna9s6JHluUg30KcQDi4gpATHkRfzevR6Jw4o08iuKZwUhWyJgx9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707178742; c=relaxed/simple;
	bh=AizJX3HR4Cujw1uwQ6p18WyvnXA1KEApkP/gg5RoHLA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rM7VLfWKdISoGCfAoEDRszOeXhmu3yUnLMDx3hit9QRV7e8QArIYRw/vdlqgrj2nB2wb5roaW1FrzXIT/HYyhTHkqyHjuo26eNIwi/ysHCkHtpOom+GcGbD7+dXNrCkiJXu83erssG2johAW7EDtczFrlE9SHIWFYySEyNICP9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBja+R3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F46C433C7;
	Tue,  6 Feb 2024 00:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707178741;
	bh=AizJX3HR4Cujw1uwQ6p18WyvnXA1KEApkP/gg5RoHLA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LBja+R3hHEz1hxMk+JFXe7qq0VaPheS+7FFmmaF1jNnqEjEVTYZaVcSKTA12MMVVg
	 HRmCuNdZqGhXWyqB3Z61U3hwO5EKIVeiHHhoPEbQXvf+46nmR0DfhHvBVX5gRqEhSG
	 vnWPYXS6wCsOzGhU+l4v2z4bGOdHSXhOcvyer26biRNLWixk5zOGM3uD7uBn0Y4Tn5
	 rl8SArCD/nIKZVTuVoXzyiwpmPBugILTToSPTbcezLO1kDpFbC+gagbhdkLBIf2sEn
	 5vpFPCITj5O8h1tyCKqEEPm8bGjRsFwl789jXkvCIleIS6euwkZZuOR+iV1voTtVVh
	 e+TdvL/dF5Ycw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Michael Petlan <mpetlan@redhat.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Perry Taylor <perry.taylor@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	John Garry <john.g.garry@oracle.com>,
	linux-perf-users@vger.kernel.org,
	Edward Baker <edward.baker@intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1] perf jevents: Drop or simplify small integer values
Date: Mon,  5 Feb 2024 16:18:59 -0800
Message-ID: <170717858571.1700937.8565679107024428144.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240131201429.792138-1-irogers@google.com>
References: <20240131201429.792138-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 31 Jan 2024 12:14:29 -0800, Ian Rogers wrote:
> Prior to this patch '0' would be dropped as the config values default
> to 0. Some json values are hex and the string '0' wouldn't match '0x0'
> as zero. Add a more robust is_zero test to drop these event terms.
> 
> When encoding numbers as hex, if the number is between 0 and 9
> inclusive then don't add a 0x prefix.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

