Return-Path: <linux-kernel+bounces-89027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F7486E9A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F0B1C22ED5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069913C070;
	Fri,  1 Mar 2024 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk5hXyYF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F14A3BB33;
	Fri,  1 Mar 2024 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321466; cv=none; b=h5sRWAwtQJMRcegCvVRQhXnKiLKjDjIxFEOl0RWFV8W34LisG17uWl2fbLJR1Iy9pgEqdMKqy59tx6/XuM4P/okO+MBdzfgNd8lrbuCFeFkJdgQEntWBKF4UU+BVjJ4Ta6oRMEj6ibwYoEFAn/VUxaKsJ9ZpcGA2Btahkr2CTOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321466; c=relaxed/simple;
	bh=1j330yDM6ih/n5/m7OopTz5N1oaxJgBPFmBVaGTdJ0I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lmf/P290tgj8vSbOCaaMFku2FO41KGuUB3i9eQ7MwIwBd8wZfRlyvR5YSgFyxfYV1d2l6XM+RTFgweROZZl0mFpLRJHug1fwzrfevHdWSXWqX8ShsfLtl2RSWh7nKpFZWJRYx5cjmx9pid9wxxuv6rk8no42pta6rqrvdsNbMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk5hXyYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBA7C433F1;
	Fri,  1 Mar 2024 19:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709321465;
	bh=1j330yDM6ih/n5/m7OopTz5N1oaxJgBPFmBVaGTdJ0I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kk5hXyYFtecORLWgLAAJ+SR66EAN7LH5ruEcoOyjgpnjhMEToU7VLiGs4yJWWSY+3
	 LQtstXoB1eYynKVidT7qhvXbM13//t19mYMc/xX/sH5QP5vA8IUubORQS5v6DEgwOY
	 HHIbMzntZuTosLe+xNrbbyZKHIaU7tHvwsgftrnskoWCbwy5rXHzCUPcmmQAjFo/dx
	 Ip++r4N0T0/e0knrJ2IY389NfHupXmvBGH6yPCFFtRPbooefP+senx3J5Xb3W8DGWI
	 3h/j6XfiK5g8M3iRc4IyvdMiBrSAAxxhk0Z3Ue/Au70mrUKucMiJXXXlPCDanF84Tb
	 Y2ximfRKocXig==
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v1] perf map: Fix map reference count issues
Date: Fri,  1 Mar 2024 11:31:03 -0800
Message-ID: <170932136989.3731358.9865039406207626905.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240229062048.558799-1-irogers@google.com>
References: <20240229062048.558799-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 28 Feb 2024 22:20:48 -0800, Ian Rogers wrote:
> The find will get the map, ensure puts are done on all paths.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

