Return-Path: <linux-kernel+bounces-73927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F8285CDA7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EE2CB2314C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0CD79E2;
	Wed, 21 Feb 2024 02:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQ2GxswR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C474F747F;
	Wed, 21 Feb 2024 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708480815; cv=none; b=IzV9akzuiHrrFv9F2oroiy8QLStzzVViKv7L4UdrKQl+rTJawbpOI8n0p4Nv0ozb3tvqBAGiUfeXIHqJF3TEo/dmXAgE43yU7u89EEYfTesXstt3zOEtud+so925CPdehWYhTN+L7KVNBYYBT2Tg/BvJQkztsCGbIffXky+3ANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708480815; c=relaxed/simple;
	bh=CRfAO8B4DzGYtfLCTm5XleHv9ObeYH9Wo1VmI8sIwK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnsOwj11BX+O5RJarlRh2S5LqrZ9nFZnGv+XhccvUvLfAubihYTRvNPbZyY9xF4g/zLJrKGMmmSASaciLi5oMrlBoPWXwfZunUBJDlMRgTqVsmNIGZObWwB2lkbxnXQCBlJFJU26h1YmxP4o99h4At8oPRPetbIbnSvceFrxIJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQ2GxswR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEA3C433C7;
	Wed, 21 Feb 2024 02:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708480815;
	bh=CRfAO8B4DzGYtfLCTm5XleHv9ObeYH9Wo1VmI8sIwK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pQ2GxswRNmsF4vpZiqBWAFKvJZV9uVGIwbBspL2x8/x3wElIop3fv+XTQoWoISz5S
	 cH9LZ5Whqu0gWniZQN7E7ARein2vdPtMAkiH/S//D7IMesYVnF02oNvDBUfTEs7Ooq
	 9uh5zNHpaIePnxyqivtz+xfUb/DUoYzA+LRia7tNU6ERDRrDVa9550vPEHSMTZbnF5
	 EOMbd1VMvKEt40OCm3w73DN1Mf3MNrb+hHpn8YMPfDAaAbSqq5UXzAZWdmOWHdOnlO
	 6EbHUcc/8I+wKg1ywGNYZGCFt8ks0nyfTSH01sacKHKu0WciWloPH0NJLrq77WpEnI
	 HmrmCzIcWtS1Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Mike Leach <mike.leach@linaro.org>,
	Will Deacon <will@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Leo Yan <leo.yan@linux.dev>
Subject: Re: [PATCH] perf tools: Fixup module symbol end address properly
Date: Tue, 20 Feb 2024 18:00:13 -0800
Message-ID: <170848061727.1313505.8320377887775957635.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240212233322.1855161-1-namhyung@kernel.org>
References: <20240212233322.1855161-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 12 Feb 2024 15:33:22 -0800, Namhyung Kim wrote:
> I got a strange error on ARM to fail on processing FINISHED_ROUND
> record.  It turned out that it was failing in symbol__alloc_hist()
> because the symbol size is too big.
> 
> When a sample is captured on a specific BPF program, it failed.  I've
> added a debug code and found the end address of the symbol is from
> the next module which is placed far way.
> 
> [...]

Applied to perf-tools-next, thanks!

[1/1] perf tools: Fixup module symbol end address properly
      commit: bacefe0c7b77b7527a613e053b6d378412a8a779

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

