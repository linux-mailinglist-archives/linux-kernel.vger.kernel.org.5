Return-Path: <linux-kernel+bounces-60091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D4184FFB9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32DB1C2310A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6671F3D39B;
	Fri,  9 Feb 2024 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/5hfDGo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C75B3D0CF;
	Fri,  9 Feb 2024 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517032; cv=none; b=rRoLxhwXAUuXt4TW9sFKjbKLeO0ganF3XS/X5+xr3Zky9PhLy+jiIrKe29bMmYoct8HJrnZNtOtxWJvofjfnMwBR+KiZIuP0FeAOP5nw+y2ge9UoJXbgRy0CwNl7R8phFfcPZuiQet46fV4tMoTkFgTC6vY8rqhRMDO6wjyOQGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517032; c=relaxed/simple;
	bh=c6IuqT/3KzhMdjqabgBPLCyZ42MmIOWZIsSmelU0NV8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYZDNVOqA+pMoBXtqnSNoacszEIDMQvZtEO+wHuotGRgPZY0jS7sBIcDxNP/i1IW/vy/zSpzfjxk5/lLe9fXAfAb9Exc23ZWfTYcvOR5U05a1gtyqD9FausZ4Irur5MuBVBK/SKD2qMSp4+IJSlgMpDirl89sE20gkXzY32YKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/5hfDGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B303AC433F1;
	Fri,  9 Feb 2024 22:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707517032;
	bh=c6IuqT/3KzhMdjqabgBPLCyZ42MmIOWZIsSmelU0NV8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=c/5hfDGoRk0PIphjSpLonjGsa/V3tOZFRYGgwYHpxomuB0iNzt549Eo5iQ51rsVTj
	 G4eSNRO416MkFWtVY7Ap5wm2Z+fJtJbom0pU8lAul2uGRdegOZ4JZy0k7Ixr5Gyyns
	 DrIyoFK7Adf4sgxUj7vtiIn+jWqJHnlKUTjcYpyhfH4IpQLmWbtC6ChurbkxtGqYVT
	 udnXA476GHYLy1N+0vMSFA+q0o3soJI9qMwLWXnkzVxEe0AYzhw2SAlErTUHZD11a0
	 3+WRbK8CC88moHhTmkNHg5FP837Y75tVt0zri1dJR7HUwDfFf3X4G88KmUPk7BPU4q
	 eQY2GYhIfxstw==
From: Namhyung Kim <namhyung@kernel.org>
To: adrian.hunter@intel.com,
	mark.rutland@arm.com,
	irogers@google.com,
	jolsa@kernel.org,
	alexander.shishkin@linux.intel.com,
	acme@kernel.org,
	mingo@redhat.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	Yang Jihong <yangjihong1@huawei.com>
Subject: Re: [PATCH v2 0/5] perf sched: Minor optimizations for resource initialization
Date: Fri,  9 Feb 2024 14:17:09 -0800
Message-ID: <170751693775.1169242.10719709967267743164.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240206083228.172607-1-yangjihong1@huawei.com>
References: <20240206083228.172607-1-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 6 Feb 2024 08:32:23 +0000, Yang Jihong wrote:
> start_work_mutex, work_done_wait_mutex, curr_thread, curr_pid, and
> cpu_last_switched are initialized together in cmd_sched(),
> but for different perf sched subcommands, some actions are unnecessary,
> especially perf sched record.
> This series of patches initialize only required resources for different
> subcommands.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

