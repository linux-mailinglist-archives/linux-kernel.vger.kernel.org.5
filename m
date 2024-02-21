Return-Path: <linux-kernel+bounces-73928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF17385CDA8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85EAE285F33
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FCB5666;
	Wed, 21 Feb 2024 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saiAvZgj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C80B5244;
	Wed, 21 Feb 2024 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708480834; cv=none; b=ScLUlMmA0ZgL8hKU4UYCkipfsDA5fuT/U8FsQ5/Wkp6wC7qyEi0sdW/o+LhNl52mtqus6zHAXuENxFll2X31A20Gh7JkF5lFvswfTXL4DN4lcL+nIB2BhdYS839Rdmy1SGhu4eoy0D5er72PF2h4/ApE5PDGNOHgsXhR4mwGN/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708480834; c=relaxed/simple;
	bh=D7SPParGr2pOGQ297TzEPMmROpuwGPtFCrJd63j3rE4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nou24abDmyCL+1t8SYPa2bUSOXmakOzuoK/KgC1nSQs8ckyeNwfB16sx7tPrBaXumU7A1zYr+pSGLwRvZhZ1k90GHigEQ9mK0TpNcgD4NYCYsZMZXQDxU9fmjtdAvlPJXy4vAOTWJlzotADS6fNVdzYYrsG9PIiV+74aBpB2qa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saiAvZgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C44C433C7;
	Wed, 21 Feb 2024 02:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708480833;
	bh=D7SPParGr2pOGQ297TzEPMmROpuwGPtFCrJd63j3rE4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=saiAvZgjfDK8Sitle31NkY0SwcTBYdIsXDz29BXyPfZjPxPA0iaFF2GKnwr2zuj4I
	 ZUUUvaSHsIZNunRb6KCTG3JqA669AOB2u0njUdssjS965hyVahk87Lazw7AoMNLpSE
	 jSh0K6KSjLkZ1Zw5W2kFE+nReGY+3TTWcaw9F4PmLDKl75Fpw1cxy0eliieaIvH7lM
	 visH9stHdqkm8Eu9PAt0swu7PgurS8n3YAplFxViSrzPBMuVzONJieuhskcBOYTMoc
	 GkYuuWY7qfv68uGdhB8nZ1r8aLYtBCiZXmn18nGDvq/HGb1GerdtqxUvWp6k5urTl+
	 mkk/e5bpk9hJQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2] perf list: For metricgroup only list include description
Date: Tue, 20 Feb 2024 18:00:31 -0800
Message-ID: <170848061727.1313505.6444211875650629468.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240216192044.119897-1-irogers@google.com>
References: <20240216192044.119897-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 16 Feb 2024 11:20:44 -0800, Ian Rogers wrote:
> If perf list is invoked with 'metricgroups' include the description
> unless it is invoked with flags to exclude it. Make the description of
> metricgroup dumping dependent on the desc flag in print_state as with
> metrics.
> 
> Before:
> ```
> $ perf list metricgroups
> List of pre-defined events (to be used in -e or -M):
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

