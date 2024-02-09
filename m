Return-Path: <linux-kernel+bounces-60082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D22B84FFA6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF32284B7F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004B33A1B9;
	Fri,  9 Feb 2024 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e10Jisck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1483A1AE;
	Fri,  9 Feb 2024 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516974; cv=none; b=HIfkJ5n8oJ/D5oNY70pHKK8lveSdV5MDdtg5XraaEwehG/LVATfV7ScFnYbGUPesx+Lgrtx1vRHjC3qrmomYVZQtPX8KgKzQlhB0tQvSXqvLZ1/EcWr0S6tHXXvRy7JSFdAIxauxfZPS6Kqdtw8JiGwmtZqabVDopuXTpn++QZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516974; c=relaxed/simple;
	bh=dx0uTAcPvK5EaAlFfSoV6xr64M9844uNyE8l2N+7hGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SgHt9qf5YUkEmrr96p86pCmg9ku6kNNhyLOFXqSFu9iQ1gVE2ipwvrPu70QOeWBHOWwHxq4Z2Y/ODB+Thpd3YdKa/sJoRiXZ42sUtW0jU2Z4BDaFL30t0jh+NbfK3IUTKT0nqZn/j3vNem6Xqk17+QUZ2osyPQoEdgNiZlyiN2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e10Jisck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7441DC43330;
	Fri,  9 Feb 2024 22:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707516973;
	bh=dx0uTAcPvK5EaAlFfSoV6xr64M9844uNyE8l2N+7hGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e10Jisck0cSj/BUd92CiHK4hUvmXZfUjeGWSN2kn8kE2LtM+fmXbmxJ8wD4wvlP+S
	 4Orqd/ATY19ywgWM0s045GK84GPRqdJ/jBhVp8YMXEuMkGP+UHWnA43csVZuJ715p5
	 10waB5SKR2n46AX5XtHjiZQShDhSfUL0tk6TT0Lq0XNqZywv1IC04nV8E1LcIH1q6E
	 TLq1irZb1DvmyAEKo5/3+C0yDqZ7XBEQOgKxG/Ftc2FnnqzjXxBbJw3t/I/7KqzROu
	 lNAaDg3lreRlu11t5nFPV9KI80/e1UAwxAymFg22MPdtD117VdEtpYMNe31yfQV1mc
	 213+gO9cbM81g==
From: Namhyung Kim <namhyung@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Like Xu <like.xu.linux@gmail.com>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 0/2] perf symbols: Slightly improve module file executable section mappings
Date: Fri,  9 Feb 2024 14:16:10 -0800
Message-ID: <170751693770.1169242.13110612989281667030.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240208085326.13432-1-adrian.hunter@intel.com>
References: <20240208085326.13432-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 8 Feb 2024 10:53:24 +0200, Adrian Hunter wrote:
> Currently perf does not record module section addresses except for
> the .text section. In general that means perf cannot get module section
> mappings correct (except for .text) when loading symbols from a kernel
> module file. (Note using --kcore does not have this issue)
> 
> Here are a couple of patches to help shed light upon and slightly improve
> the situation.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

