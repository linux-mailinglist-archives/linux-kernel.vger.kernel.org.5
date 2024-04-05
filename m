Return-Path: <linux-kernel+bounces-133520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4123089A4CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721691C2110F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B627172BBD;
	Fri,  5 Apr 2024 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S729f+TJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB32171E5C;
	Fri,  5 Apr 2024 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344854; cv=none; b=WJdZe1eAh+TGCrO4xRK510bXoS05OrtC1aePrplbTmP65EuQshE5rDBAViJuqdR5daA4/NasmFS6hct5u7H0jsdFkVd9wphr7QrSiQrKJw588ZcBsSzfAWr4T9FPFM3HxWYqOExjlNMHRlj1NEAtn4AVfX3A+qu7uvc+zU2p44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344854; c=relaxed/simple;
	bh=CROgP0s5DI0tfS4IzN69vvUsq4Gejtoitw/jzseDbjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+K7GDhqavYyIUYgHHjLJ9H4ibf3I/8VvZfU3YDAHzOks3gL/LZqgtvhnUl5zOsNgQqnrAUK3ojZSx72wANapA2utqUgu7gsobhENfDRIaxnqIoLc3WHVRMLC/RUJSjKkaC2eEKLDL3ojHrK8oYkW2iyFaOI2FbePIJyn+InnZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S729f+TJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCD6C433C7;
	Fri,  5 Apr 2024 19:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712344854;
	bh=CROgP0s5DI0tfS4IzN69vvUsq4Gejtoitw/jzseDbjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S729f+TJukRdYO/XPzACBWcTgXMrka1eX7klcXBRVvQDC3EOCm8IYe7il0MJy18rE
	 AyW5QG+WEI9Katybkr5NDj1oaAIBIj7s6OzeVwB5sG23Z5QBaYmgnPCieC42X2RQDy
	 k4Qzqz+oISIcOk7+dyFoI9NrQ8M3FDcw0oKHalJzf96hGdytBYk+iDz6OXoO7xpL0y
	 zlkpvwc9e66jH21hLwJjvq650+NeU+2uxtN579eWaTdj/c/5WBUiw4FIdeXw0HcOvv
	 4DSg4kKv0Wp6sl2PbRIcwyTrXz3r1MMm+jgJCMJB7ykE0FzGWzvlYIRJG33HFQc5K5
	 zxFAZdIs7hwTw==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com
Subject: Re: [RFC PATCH v3 4/7] mm/migrate: add MR_DAMON to migrate_reason
Date: Fri,  5 Apr 2024 12:20:51 -0700
Message-Id: <20240405192051.67009-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240405060858.2818-5-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  5 Apr 2024 15:08:53 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> The current patch series introduces DAMON based migration across NUMA
> nodes so it'd be better to have a new migrate_reason in trace events.
> 
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  include/linux/migrate_mode.h   | 1 +
>  include/trace/events/migrate.h | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/migrate_mode.h b/include/linux/migrate_mode.h
> index f37cc03f9369..cec36b7e7ced 100644
> --- a/include/linux/migrate_mode.h
> +++ b/include/linux/migrate_mode.h
> @@ -29,6 +29,7 @@ enum migrate_reason {
>  	MR_CONTIG_RANGE,
>  	MR_LONGTERM_PIN,
>  	MR_DEMOTION,
> +	MR_DAMON,
>  	MR_TYPES
>  };
>  
> diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
> index 0190ef725b43..cd01dd7b3640 100644
> --- a/include/trace/events/migrate.h
> +++ b/include/trace/events/migrate.h
> @@ -22,7 +22,8 @@
>  	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
>  	EM( MR_CONTIG_RANGE,	"contig_range")			\
>  	EM( MR_LONGTERM_PIN,	"longterm_pin")			\
> -	EMe(MR_DEMOTION,	"demotion")
> +	EM( MR_DEMOTION,	"demotion")			\
> +	EMe(MR_DAMON,		"damon")
>  
>  /*
>   * First define the enums in the above macros to be exported to userspace
> -- 
> 2.34.1
> 
> 

