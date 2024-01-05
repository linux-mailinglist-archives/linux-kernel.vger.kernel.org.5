Return-Path: <linux-kernel+bounces-17802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F278252ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4E91C231D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4DA2C84F;
	Fri,  5 Jan 2024 11:32:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003F02C680;
	Fri,  5 Jan 2024 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0ACEC15;
	Fri,  5 Jan 2024 03:33:18 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.86.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BB6A3F7A6;
	Fri,  5 Jan 2024 03:32:30 -0800 (PST)
Date: Fri, 5 Jan 2024 11:32:27 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com, acme@kernel.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	namhyung@kernel.org, netdev@vger.kernel.org, peterz@infradead.org,
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Subject: Re: [PATCH] perf: fix WARNING in perf_event_open
Message-ID: <ZZfoy7KACsvEFdhr@FVFF77S0Q05N>
References: <0000000000005b23dc060d58ee7a@google.com>
 <tencent_7FC26D7C2FA56EF89584E89EEE52CD20790A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7FC26D7C2FA56EF89584E89EEE52CD20790A@qq.com>

On Tue, Dec 26, 2023 at 03:25:15PM +0800, Edward Adam Davis wrote:
> The new version of __perf_event_read_size() only has a read action and does not
> require a mutex, so the mutex assertion in the original loop is removed.
> 
> Fixes: 382c27f4ed28 ("perf: Fix perf_event_validate_size()")
> Reported-and-tested-by: syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  kernel/events/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Thanks for the patch; this should be fixed by:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.7-rc6&id=7e2c1e4b34f07d9aa8937fab88359d4a0fce468e

... which is in v6.7-rc6.

Mark.

> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 9efd0d7775e7..e71e61b46416 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1924,6 +1924,10 @@ static void perf_event__id_header_size(struct perf_event *event)
>  	event->id_header_size = size;
>  }
>  
> +#define read_for_each_sibling_event(sibling, event)		\
> +	if ((event)->group_leader == (event))			\
> +		list_for_each_entry((sibling), &(event)->sibling_list, sibling_list)
> +
>  /*
>   * Check that adding an event to the group does not result in anybody
>   * overflowing the 64k event limit imposed by the output buffer.
> @@ -1957,7 +1961,7 @@ static bool perf_event_validate_size(struct perf_event *event)
>  	if (event == group_leader)
>  		return true;
>  
> -	for_each_sibling_event(sibling, group_leader) {
> +	read_for_each_sibling_event(sibling, group_leader) {
>  		if (__perf_event_read_size(sibling->attr.read_format,
>  					   group_leader->nr_siblings + 1) > 16*1024)
>  			return false;
> -- 
> 2.43.0
> 

