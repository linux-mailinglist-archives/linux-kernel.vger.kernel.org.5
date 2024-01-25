Return-Path: <linux-kernel+bounces-39330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBAB83CED1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7432528D525
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843A313AA53;
	Thu, 25 Jan 2024 21:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHWyoovJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02313AA3C;
	Thu, 25 Jan 2024 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219159; cv=none; b=LXF6cFB6CR80m+Q2eKIcxuWk7uDjsUrd6LjO9EbPQoQ0l+3+1xuYyp+uVqOOnbF3Din4RRAUdZvzd5/4g3twSC2L5D4Fb7A5dYamJKHUcQZXCT/0FmJcNu7ghvj7etcdKx1D7ICHXzmdVuY/0Uk37YEQ5PAZpOkHQyPIW5a6TOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219159; c=relaxed/simple;
	bh=IFFNb02CIOZlvTthWGiohsPa44vAfP61Zx+mAQ/Q3Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=soTpw597AUzuyl9Sy+RtFU5sgHUswV4ZkSeWRSxb2DjVfceJYOXF+Txb5bURmRft/Zgd0qiieR0beev0p6H+DQgEfBKMcvlJWY3eNO5xlOfIZjGj9nRSrtNp2fzD37UQcOqr27PxP+fXUKymJL54NcGOTW0pLFodj0cebj/pwHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHWyoovJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F72AC43390;
	Thu, 25 Jan 2024 21:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706219159;
	bh=IFFNb02CIOZlvTthWGiohsPa44vAfP61Zx+mAQ/Q3Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VHWyoovJbB4WWbnzrEkM/0gIJZ+yz7aO9Ip+LQp+4DDjsmcikdRs9+04iDyvnq5G/
	 bDKi7meln3pNVmA1mQZGLtqYSMUedrOlc8cn9P96DNwzQMBOAt3kDl9ZeEC32d/XMl
	 lIxrEByf/RB35voRX0joz/b4Q7Zrup4dvtJSy9NCfZinnrdI3lvHiRPmU0osO87OPS
	 Mc/CNjMhsGGzM5tuOPnnaK/Go5eTuqTZ3UouieXUCuQgvhUfXSYZFkrAfTx38PUpzV
	 z2tnGgnubqoApuvPj27LMJZqzdxNoj7KPj34CV0ys6AhkHfMdQlX4AaeIdopMF7vFq
	 EeCLf9kU3sCew==
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@arm.com>,
	linux-perf-users@vger.kernel.org,
	irogers@google.com
Cc: linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Yang Jihong <yangjihong1@huawei.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Changbin Du <changbin.du@huawei.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v4] perf evlist: Fix evlist__new_default() for > 1 core PMU
Date: Thu, 25 Jan 2024 13:45:56 -0800
Message-ID: <170621898551.3227482.15149421074374821246.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240124094358.489372-1-james.clark@arm.com>
References: <20240124094358.489372-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 24 Jan 2024 09:43:57 +0000, James Clark wrote:
> The 'Session topology' test currently fails with this message when
> evlist__new_default() opens more than one event:
> 
>   32: Session topology                                                :
>   --- start ---
>   templ file: /tmp/perf-test-vv5YzZ
>   Using CPUID 0x00000000410fd070
>   Opening: unknown-hardware:HG
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             0 (PERF_TYPE_HARDWARE)
>     config                           0xb00000000
>     disabled                         1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 4
>   Opening: unknown-hardware:HG
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             0 (PERF_TYPE_HARDWARE)
>     config                           0xa00000000
>     disabled                         1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 5
>   non matching sample_type
>   FAILED tests/topology.c:73 can't get session
>   ---- end ----
>   Session topology: FAILED!
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

