Return-Path: <linux-kernel+bounces-57240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A33684D58D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B361F218F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57BC134CEB;
	Wed,  7 Feb 2024 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxL0GoOC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A32128839;
	Wed,  7 Feb 2024 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342459; cv=none; b=jAVjPEzRblPXA+kPViBHkRStU+I5TS8VJCLAcQ37dz90O3eJTlztDoNbeZR0GdMmmCAhajB6W1zVDH+2rGLJj6xk2cg0kuFDmPK9193/mzPSeGWIAXQmqHo+VSswa22qX5r88QACsDkefYRutvdySDqgskYgym+MLqi0D9lh1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342459; c=relaxed/simple;
	bh=B/hlIJ7K85wB/3PBEgSm6jFwUTWS70jBvDeVV2N69sA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYRwHXiRBbSp+GzkLdZmS5y1SZmvt8wIq+HJutPt67TPKLBgiqG7YNU9Q3/Ph8kd7ccLj7UXu4Q/JztRGWC0bEN8zbgBmvR5egomm1i3JHnmcrAfMylWtg72iWT0Q76dEHiDTs7shz/ifPfj4dSez8BnVY0WPvEJ/umhq79SKt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxL0GoOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA001C433F1;
	Wed,  7 Feb 2024 21:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707342458;
	bh=B/hlIJ7K85wB/3PBEgSm6jFwUTWS70jBvDeVV2N69sA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MxL0GoOCvBj3xAKeO/lPiW2K0F5c+8/2k6JnnZXnTs4LjjXCnUNrJysxUr8RbeKwc
	 QBQ5D+GEfPhjoDO/wcJIs6bYAIrOCSltq2yRbf/XLHvFl/H/ea9cFV0rffAhk0a22c
	 1ux9BpXIROd42eLaP3KuQJsWeer5h5pZUESzO7kVul8QXCo3rl90s8JLTDeWP7nsC+
	 nhiU0xKGN6PKTsjw9zqWu7QHjVIX/gM0lzvNhECPj2zTR3tgDApbsfAq9dRia8/YhD
	 yM/DRSXJ0PpaS4vrxclGpCAmDx0HNoUI9XNK8HLJzzsBDk/aMPH+JnHJzhDwOqkcRu
	 DceHS2EIad5PA==
From: Namhyung Kim <namhyung@kernel.org>
To: Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Leo Yan <leo.yan@linaro.org>,
	linux-kernel@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org,
	James Clark <james.clark@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	sfr@canb.auug.org.au,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v1] perf kvm powerpc: Fix build
Date: Wed,  7 Feb 2024 13:47:33 -0800
Message-ID: <170734243424.3472515.9977206326611492106.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240206235902.2917395-1-irogers@google.com>
References: <20240206235902.2917395-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 6 Feb 2024 15:59:02 -0800, Ian Rogers wrote:
> Updates to struct parse_events_error needed to be carried through to
> PowerPC specific event parsing.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

