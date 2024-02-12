Return-Path: <linux-kernel+bounces-62260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B59C851DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4C31C217C1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20FF47A74;
	Mon, 12 Feb 2024 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsSsA6Vg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D5647779;
	Mon, 12 Feb 2024 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765114; cv=none; b=qHE1XSd9lCie90PRoUm6ToxDpdcer4WShFY6KuutuDQPLcQN3reMLTgTBlCPD9Q90uPpgoNQlZIaoKXZgE78ENs+Iq+0D7cdjc86cLbcK2xZ40EybiN7My0byIkvIR8yuNUGAVpEfb7AwPbw+uILpQSA/wYKl2TYTIQG36k8ee4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765114; c=relaxed/simple;
	bh=QNO5lfS3LKOrsPQYo3VzoWDJViGZD1S5lJ1NNbq7H/E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVPjYP26N5ZxyNgQh2qwsQayevz6wUhOKN0LMYLVpWGLekrPJyYqd44K1CZnCphORo84PDRFlwWE6xAp5PMUreITGTqANe7XR/jYUm7ofclj0kOV3G8bcrQDRXrKS0e1p94M20Wm7f6R46f73BxXlUVj3xON+BealgSwzBi1QTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsSsA6Vg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFED5C433C7;
	Mon, 12 Feb 2024 19:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707765113;
	bh=QNO5lfS3LKOrsPQYo3VzoWDJViGZD1S5lJ1NNbq7H/E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QsSsA6VgQwwadd3WcHVJXeqewmu158F9ocJ6hs4kWs4tebZ/rp4H/xihDt6UiaWx+
	 +lXrqNMB3d4GkbEBI8ieluJQ3mMu48FLtlQSFOL+dgWB9z6WIPow17873nsVFt6rgj
	 3kOQ0DTAyHLfphI8LKlgZFS4E8kjPusd+OdV5AjhX8ALSAOBArkdidyBEaz0NrLdwY
	 2KdX9GoamFaeLSTg8ZZ7rnO3rLpCMIzHv+Gowhm7wNYyOLGCDJCwsIcwh+aI8DV9hY
	 ixgafg6IEtFjEB94KeIKi/UV5kmPCGrraljO1of2xEmHIADLxyg0l6ZZwjGpOVBPGT
	 MGLHUO5ZPeTOg==
From: Namhyung Kim <namhyung@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	llvm@lists.linux.dev,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Tom Rix <trix@redhat.com>,
	James Clark <james.clark@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 8/9] perf srcline: Add missed addr2line closes
Date: Mon, 12 Feb 2024 11:11:51 -0800
Message-ID: <170776504998.3461281.1826440393211565265.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240201001504.1348511-8-irogers@google.com>
References: <20240201001504.1348511-1-irogers@google.com> <20240201001504.1348511-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 31 Jan 2024 16:15:02 -0800, Ian Rogers wrote:
> The child_process for addr2line sets in and out to -1 so that pipes
> get created. It is the caller's responsibility to close the pipes,
> finish_command doesn't do it. Add the missed closes.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

