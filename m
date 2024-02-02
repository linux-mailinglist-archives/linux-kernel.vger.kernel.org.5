Return-Path: <linux-kernel+bounces-50562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B3E847AD5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA91B22CB8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACA580609;
	Fri,  2 Feb 2024 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgpKnRNL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF6915E5BA;
	Fri,  2 Feb 2024 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907456; cv=none; b=oLC+hFCLTzV10VRGRkponajd+atu3UUA68gTOAk3RllPXVGNXo+Y7zZFfT7jZ+CxY3Ml4lmA0yALtXvHQklDQxqYAsBJLW+/9CGooWt3u8HZzgaoPnaqdJbK74kmH1tKRbuHPWKS6wpgHrysODQkz6QMqWzFN7Fad8wl7NcGgag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907456; c=relaxed/simple;
	bh=G8E1Z2HAgk8gQyMeGBM30dUIzCw/VotbAsYiqJ9dYfI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udNsk62vlbx6sytGQs4+91LBHy77bPbUK9dgxcYln+RdX6yNi+d21Toy6pj8v1VMOYLDJSv0VpcXTMCldWIYTO8vgap9HFHEQPtWBDaMUQArwFqc+NC7ePI4WWVl6UUA2zkpxL7SfZJrZd7yOn3zh8cDkC1hkM/wMpJGMOwRsJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgpKnRNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14288C433C7;
	Fri,  2 Feb 2024 20:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706907455;
	bh=G8E1Z2HAgk8gQyMeGBM30dUIzCw/VotbAsYiqJ9dYfI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FgpKnRNLaBaru9nlNDJ63cEXUrO2WDEXa8MlvhCL270fDWNp/Mc+7wTNXXduw0Ibl
	 TQwyaJnGGwJis5pVpE0zcQXqixGV3FfXsMK1+M213tSCL+6MO0rDDt3zz3Vvad74Px
	 692KlSRUV+NV4zc/Tcxp9AA8t/IF/o/JXSTz91WKnGZ0ZBrDp4/SEyJCK1RjnJFE8L
	 7NhJcVbu4tayV/ZKAyFFZfqDy4gJ1tZsb5iRECrE/rzZr9xNqWq4TWMCPhlhZkbHg4
	 zRrgZ5duUD4+frB790aZJdBLLLLJqDDT8OUgJA9spz9aa71nBF0WMLTCmfxYVQCv29
	 rTP7iu+eQxJYQ==
From: Namhyung Kim <namhyung@kernel.org>
To: alexander.shishkin@linux.intel.com,
	acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	jolsa@kernel.org,
	peterz@infradead.org,
	adrian.hunter@intel.com,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	Yang Jihong <yangjihong1@huawei.com>,
	irogers@google.com
Subject: Re: [PATCH] perf evsel: Fix duplicate initialization of data->id in evsel__parse_sample()
Date: Fri,  2 Feb 2024 12:57:33 -0800
Message-ID: <170690725032.1264496.5196347115454509286.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240127025756.4041808-1-yangjihong1@huawei.com>
References: <20240127025756.4041808-1-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 27 Jan 2024 02:57:56 +0000, Yang Jihong wrote:
> data->id has been initialized at line 2362, remove duplicate initialization.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

