Return-Path: <linux-kernel+bounces-91139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 039588709F7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2884A1C208E4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8679878B53;
	Mon,  4 Mar 2024 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3LJUGSR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E976216C;
	Mon,  4 Mar 2024 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578634; cv=none; b=NapJEUIlzTJowDcHb8phSDpKxVfMu1DVhsg/lHR9U48BRcj7jv+CCE+FBI/bHEDyVTt6a5JzcK4/0I1ykDfPeGsXcMoQ/eF2C3HUwkL3VhVcwwjs4UY4YZdKbPHFxBfwt0u2aVNOOqTl2hXoTk9XqFBVa2Vqdg8xOAZDK3OlP5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578634; c=relaxed/simple;
	bh=/EhQrRi+aF9jxKoHeK2K8/pKbZ1CywMZcwDYE9ciYwo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVlINvSfHFfDjBSt/RmSUDvvwFPu9NmAl0M5jG31/NACMqhULoO/XngbAhH80lJjOPdRqPvHCv4CegFbhBRG5d/OXjiU2nzK+Gk2IHlFN9g7K2ItaZfVfK/D0V7YWKTT3y3KFl+AfupuLhyBXbD8qWEwx4UtGZsykByMkDZNqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3LJUGSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC60AC433C7;
	Mon,  4 Mar 2024 18:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709578634;
	bh=/EhQrRi+aF9jxKoHeK2K8/pKbZ1CywMZcwDYE9ciYwo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=h3LJUGSRevjI1dYTdzrXwSaC+81ToZi62XnWvfbzvh/aOoC4KCMlDTdiDnoT5hven
	 3qRiwCAw/5ZV4QojsWWmUTeeB9vPmRMZdRhJB5ORGw3txm2KZ9fVlicQC8I2BSJv/1
	 ngqQCLM2t9uhHxssMcV5rpb71K8cRum3cL0AnrNZQ2WMO2gLae8CgIz5unuVA1LS+y
	 44dUB8ah2wns66cX3Cvra+axKpgKjfwDdoij4MXirAeJS6LRHXUtMSFpvRcIly20Qc
	 FNi6WVbWMVn7ux6AODKPm2EHV1V61g+6ntQWzrHa01fyo2U5K5zvyiEr7ZuTcBmWBi
	 doUoqzfEmxLuw==
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	linux-perf-users@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v4 0/7] Thread memory improvements and fixes
Date: Mon,  4 Mar 2024 10:57:12 -0800
Message-ID: <170957856865.1606352.14840215772677591593.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240301053646.1449657-1-irogers@google.com>
References: <20240301053646.1449657-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 29 Feb 2024 21:36:38 -0800, Ian Rogers wrote:
> The next 6 patches (now 7) from:
> https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
> now the initial maps fixes have landed:
> https://lore.kernel.org/all/20240210031746.4057262-1-irogers@google.com/
> 
> Separate out and reimplement threads to use a hashmap for lower memory
> consumption and faster look up. The fixes a regression in memory usage
> where reference count checking switched to using non-invasive tree
> nodes.  Reduce threads default size by 32 times and improve locking
> discipline. Also, fix regressions where tids had become unordered to
> make `perf report --tasks` and `perf trace --summary` output easier to
> read.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

