Return-Path: <linux-kernel+bounces-34122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 017FD8373E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010141C231F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D64E47F44;
	Mon, 22 Jan 2024 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlbHeWJg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BEB47A74;
	Mon, 22 Jan 2024 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955801; cv=none; b=c5iJqBuHhyqv5M8mfQkVhYCoBq0X8gRG2L8q09aYV/F+RjKDvda//xBMQFW/ZiaCz7tqaN3/HzA5YPgKGSI+JfqqPEqNfXqrl6o+p5yFPvNvZK+ywA3INIAnWfKrB05v4aMk1UBXajrLPwboc4iQw1fwGzd8dk3olgS8geYmrUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955801; c=relaxed/simple;
	bh=V7aPcu4hMxjz3kpTAdgkkBzbU5wD3Uw1gZMJ/eSZog0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPu2lob2yJ1pZAz/Ob+XgWqD7DReizrXYaCOmCP4X3beLokU0UlWTeApgYzuJ2YnehOLaaoRXQ4Trn5MGeX7c/5j3diavJvmxZ2ZohLAczpjJyIRBducsv2/pcwifI6e7Z2xs3UvuxyMS0rj5XB5e1dwUrx/tAV1/VSifqOi+/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlbHeWJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7C4C433F1;
	Mon, 22 Jan 2024 20:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705955801;
	bh=V7aPcu4hMxjz3kpTAdgkkBzbU5wD3Uw1gZMJ/eSZog0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DlbHeWJgnVbaON1TUSeezUgY+Kv4h+x7cj9WVkEKEIK3VDdYBdzI3SQlnzdkM2yAp
	 6uK+BXLgQPnvDqc4bXm2yD20L56Ssc7fWPZnmqpSCGCvQJ3RuPEYiq6MA8flEIEryR
	 LJ0W0HWxhwNTV/sMjXnZegTlRRo+qM+Zb0hYWGKDqQCym2wqUBSLWBod3q6MxkYc1j
	 UlJZ3aCTxgOIZFqYt8lw7vCEBddu5Rx6JMeFWElP40IDl6QsKfPa/gYsj0C/zA1SlN
	 FjOz1qygcJ2BjWF2A4ZVS9P45p96o545ad+q51xU7eY4dgitEumQXTCC3pitTnBc1W
	 QBSCoLPzJhK5g==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	Yang Jihong <yangjihong1@huawei.com>,
	adrian.hunter@intel.com,
	acme@kernel.org
Subject: Re: [PATCH] perf build: Check whether pkg-config is installed when libtraceevent is linked
Date: Mon, 22 Jan 2024 12:36:36 -0800
Message-ID: <170595558511.377262.16675125413548801604.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240112034019.3558584-1-yangjihong1@huawei.com>
References: <20240112034019.3558584-1-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 12 Jan 2024 03:40:19 +0000, Yang Jihong wrote:
> If pkg-config is not installed when libtraceevent is linked, the build fails.
> 
> The error information is as follows:
> 
>   $ make
>   <SNIP>
>   In file included from /home/yjh/projects_linux/perf-tool-next/linux/tools/perf/util/evsel.c:43:
>   /home/yjh/projects_linux/perf-tool-next/linux/tools/perf/util/trace-event.h:149:62: error: operator '&&' has no right operand
>     149 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>         |                                                              ^~
>   error: command '/usr/bin/gcc' failed with exit code 1
>   cp: cannot stat 'python_ext_build/lib/perf*.so': No such file or directory
>   make[2]: *** [Makefile.perf:668: python/perf.cpython-310-x86_64-linux-gnu.so] Error 1
>   make[2]: *** Waiting for unfinished jobs....
> 
> [...]

Applied to perf-tools-next, thanks!

Thanks,
Namhyung

