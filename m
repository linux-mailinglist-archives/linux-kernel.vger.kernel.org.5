Return-Path: <linux-kernel+bounces-128737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13462895ED5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44AB71C208ED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CB615E7F1;
	Tue,  2 Apr 2024 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYPk/mFO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC4A5BAE4;
	Tue,  2 Apr 2024 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093853; cv=none; b=YJob8j+TF/l+d4E2rsZFhHoKhprSa5vOaky6Uja8E772imD/bu1AC9DbSfWN1ZwzHbDgmSajPNpIucNXoa0trBjNTwrM7mwWGxdFzjNUnm3LFhlB2GaUtqqT4+yHNQUQggOimXAIkhz0EZtoBidXapAPaUWnzTnK5a7PdKceEds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093853; c=relaxed/simple;
	bh=sIBx7RwB2qvqQW6tyO38tW+0CwyoH7iyM/+YOWV6j2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEH0lFwD90JMJXM9i12lfrb6O25jwKhiB9wMdDuI6pRuHrFW7+dyAblROotwPL1RY6kdi0kTrbTgGUeVmE5YVrjq3/nb22lBLXQE/Uyfg8UHncAeP4JunvHGvRXyZtsaqVJHh7CcZZwyle1/dkNDXnXRu0VrhnV08rsuHAkzK0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYPk/mFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC9EC433F1;
	Tue,  2 Apr 2024 21:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712093852;
	bh=sIBx7RwB2qvqQW6tyO38tW+0CwyoH7iyM/+YOWV6j2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYPk/mFOIrLBeqSqXApAw9JLachGsiZgh4M8lzDFqhtSb/lMqDGerEkJSM+8n3wYm
	 QAUOAh5E3q0PZ7QqPjm4l1MsWAmAREDtzDac/Hp/Vgm666MKBzzKe7t0MmLalkmhai
	 p68d6fGuW0sSlV9OsBuP/aqQ0UaRwiAN+RywlAov6Ujv06nbWvZjUlMXScUQpa+znk
	 VqtFyZtFSJ+cYkyrWgKDEKs72YdcQkAOLwtsCX2eJgLkRx7jmqaUJcaZbYL6dWcopE
	 gBqtgZCOuj4BZryf4rIdeHSuT+hzxtZLFOvWFFmp7WMK1BcFxBujmMe5ugdQUJtREi
	 hfqDfSYNCYI5A==
Date: Tue, 2 Apr 2024 18:37:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH] perf lock contention: Add a missing NULL check
Message-ID: <Zgx6mMda_X4pcAj6@x1>
References: <20240402184543.898923-1-namhyung@kernel.org>
 <ZgxgRJdFlwfESwKF@x1>
 <CAM9d7ci7a2dbn1cz-OBkYF7P1fFA3yoBMuTzXRx=KP-yEnyfnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ci7a2dbn1cz-OBkYF7P1fFA3yoBMuTzXRx=KP-yEnyfnQ@mail.gmail.com>

On Tue, Apr 02, 2024 at 01:42:05PM -0700, Namhyung Kim wrote:
> On Tue, Apr 2, 2024 at 12:45 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

> > Are you going to have this merged into perf-tools?

> > A Fixes: tag isn't perhaps needed as it worked in the past?
 
> Fixes: 1811e82767dcc ("perf lock contention: Track and show siglock
> with address")
 
> It was introduced in v6.4 and it should be fine to have this
> even without the error.  I'll queue it to perf-tools.

ok, better, people trying the tool with a recent kernel will experience
this, so its the right thing to get it thru perf-tools.

Thanks!

- Arnaldo

