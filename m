Return-Path: <linux-kernel+bounces-83719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 810FE869DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2134D1F21E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288F714EFC8;
	Tue, 27 Feb 2024 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ov2zixir"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607CE14E2CD;
	Tue, 27 Feb 2024 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054801; cv=none; b=HZvZq1jaUS7nOapDYeB7FkZD7g4NArgiYzK5ZiepFlw6xHdT18FWZkVGR042OAkYXVD7J9+YNKjHYA6iGDwJIm2I+zEWIT1ATYd/JTYHo3kS9j2LYApywKXatmuoucNJtdrIkOxaR7+tddy/OXkCRq5gb9UxBWMLVwYYEqJKUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054801; c=relaxed/simple;
	bh=ouPMAhLoOctS4gogkt4FxAcqliZ0vW6BKsZD92ALIzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7RE3+58ysgyobz5d4uUYaWLbSWXmKwHEH5GstQHRICg4LEIKarwdT1NFinQ5ugiMVFsGSMqPLiOOUuQakVbIn0injIhx6XdSeQpUHpMcwBvLN8Rg+/AMKlsiSqjuMHzorum1JBpAD+sRlCViSojI5FtqZHZ2m3qbZGkwl5x9Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ov2zixir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846F5C433C7;
	Tue, 27 Feb 2024 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709054801;
	bh=ouPMAhLoOctS4gogkt4FxAcqliZ0vW6BKsZD92ALIzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ov2zixirrR8BKHoP3qJyfyE2KKdqC+ylLK50ztDAbObiUUw1f2kcFId9Bf1cctxlH
	 UTWcDoiq3f4gAwexs8eYKhpnprNcRQ/gQlh4v8CzMeOUo+Y/Z6hAvIv/GXBhOMhpOq
	 LxNC6bXClttStT+J/ACvLgZekTlXNRXLhQp7VoQ+q48BhSbztR/US5TU0R8VBTWtRl
	 CcKJdKNsPif9Si5/nYq8myuKSptGSTSieuB14FBuUJIooFd4dOMNITUyg9ieeaINuC
	 tNURGVzP7YR2+fFLAWKNsaZoea+dLvjg2X2PLFrP9KJhE8Euoze5zY5ZpqL8dsHdFA
	 Uic53ab5rGn6g==
From: Namhyung Kim <namhyung@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] perf pmu: Fix a potential memory leak in perf_pmu__lookup()
Date: Tue, 27 Feb 2024 09:26:38 -0800
Message-ID: <170905469229.501091.5601373719556598823.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <9538b2b634894c33168dfe9d848d4df31fd4d801.1693085544.git.christophe.jaillet@wanadoo.fr>
References: <9538b2b634894c33168dfe9d848d4df31fd4d801.1693085544.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 26 Aug 2023 23:32:45 +0200, Christophe JAILLET wrote:
> The commit in Fixes has reordered some code, but missed an error handling
> path.
> 
> 'goto err' now, in order to avoid a memory leak in case of error.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

