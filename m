Return-Path: <linux-kernel+bounces-133528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B24889A4E5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD9E1C21488
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DAB172BD6;
	Fri,  5 Apr 2024 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIRKBuv5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9442F171E66;
	Fri,  5 Apr 2024 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712345244; cv=none; b=OLgT9e1t6dDmgCX2j6dxROmpH1u8iZXAUfCYHXDaqVcXnb5FIeENh2PqXS97/VXXSbqXq5Y4pVRTgUtGwB23CzjUjYMunYvInvx/txfv6G6NIhJINszCcIfowqvTyEouIEGVT+Z5p72bm2+qQnVERG/iVLmOmzNIGZ/h0BwtWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712345244; c=relaxed/simple;
	bh=3iULADqOeKH3CjdALOPv/AVx23i/t1mNEvfguYPv3eE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TwZW+0O/hdsuDLjcvBQiVsxmjZkEOLo0rnWjEO1L5ORJtwCuXr+dNyw16OakxoIHEGXLUtMqsGETVNqVbgnFyKwGcEFj5ceA6uyG8ECxE5lg3KbJ5wbFY5YBNlcbm6YbLtHnESyKAZub1WpU21nXPpufkAmI0nDG3jLvj/OprxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIRKBuv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87205C433F1;
	Fri,  5 Apr 2024 19:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712345244;
	bh=3iULADqOeKH3CjdALOPv/AVx23i/t1mNEvfguYPv3eE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vIRKBuv5WBqU/qqpKjUdme0w+YS2LEgfmsgCK4Lc+5SDX+FXkkxf7rbr/MvTtWaPD
	 EmvkcBNxKHYQhhc6HcwtrzP9bbULRIYLnG4qfL4qO04ygp+l8TjL+YhutTPAEUojPE
	 j2oQ+fs1gDvMh5xOZQjfsHtnxb7BXrU2JT16NIt1FTlIZI73JJ9gxY71ym/FoFuNOk
	 1j9BnICgGGLcdSFED7u00pI4vIhAp+R6j7RFIwPcO1O5PTexJjfX0vmcTQu81TC/zw
	 wXqc1TfEKeZ802eXczzzOZPdTflSuQH25kw4hjBIfNTz2aJnELyeBMfrnu2LJMILXk
	 cr1yt31/6f3Bg==
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
Subject: Re: [RFC PATCH v3 7/7] mm/damon: Add "damon_migrate_{hot,cold}" vmstat
Date: Fri,  5 Apr 2024 12:27:21 -0700
Message-Id: <20240405192721.67119-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240405060858.2818-8-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  5 Apr 2024 15:08:56 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> This patch adds "damon_migrate_{hot,cold}" under node specific vmstat
> counters at the following location.
> 
>   /sys/devices/system/node/node*/vmstat
> 
> The counted values are accumulcated to the global vmstat so it also
> introduces the same counter at /proc/vmstat as well.

DAMON provides its own DAMOS stats via DAMON sysfs interface.  Do we really
need this change?


Thanks,
SJ

[...]

