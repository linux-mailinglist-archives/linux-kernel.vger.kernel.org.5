Return-Path: <linux-kernel+bounces-50223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D81038475E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9305A2864E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1506C14AD07;
	Fri,  2 Feb 2024 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmzz4TUu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FA47E0E5;
	Fri,  2 Feb 2024 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894045; cv=none; b=a16BPKrKuimdhALrVzJn2sTgcsjp/rQeVI4/0ykAeyXaE6MnuvFwJwbHyBmD2htAfsb1aGHWPqXwVKAfhh9eKM2ZmH9VA4M4asrDtUUcB4QxRCkadxYaaRcHT0grIQaaZ2WKN37gSvJ7X7FjJEP7g9EP+vLgmSGi3F6lFLe+NAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894045; c=relaxed/simple;
	bh=CTr3UEtOevAFgGCu3DO+L25topN4UXf5ROEo1UZIWNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YYdM9zpbjqoUhh5px18eR9LiDFEPsL7Ulz5R5WDqjQ01q/YH/9eR+HRMO0zvRziKedb6k657Hkinee4t/7X6GYFX85rSqeBgY37z98pwbnQfG5VDFNbL70D+rrbYPT6WtquUqSy8idrIbgxgDE9DFBNn1RJH7aQ5leOnVwgo6EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmzz4TUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB76C433F1;
	Fri,  2 Feb 2024 17:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706894044;
	bh=CTr3UEtOevAFgGCu3DO+L25topN4UXf5ROEo1UZIWNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmzz4TUuhznYAD4P+RMLOFk6Ifhy1aPXO6AwFnJXtKIyEtdN6GlkWLPbUoYrcoZBV
	 dl216lb/hYo6ygy79ydOG6uhoLAO1w7gAakvrOql0CrbwpwLLIf4ty6mqeAx9MpSQA
	 wvwtj7hMnWMRYeLArSRFRfHsvGzO5xtWJuVZz/5N8jkAv8obOe2FgVOiZlJVu02CRv
	 dIr1xLUNMNTVaFAFiaJbcpsCSf6Tn9o7xfAoazABzpMGakcJnu7zxiKgRKZeni6qqT
	 AZu59nK9qaksPT7JdvcH5f3RQZapuzYFSqIi8+hOsX6FOtLBYcI7ZHKzvQ4IS+mO63
	 dO6U8LAybDl6w==
From: SeongJae Park <sj@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/dbgfs: fix bogus string length
Date: Fri,  2 Feb 2024 09:14:02 -0800
Message-Id: <20240202171402.46340-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202124339.892862-1-arnd@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Arnd,

On Fri,  2 Feb 2024 13:43:26 +0100 Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc correctly points out that using strnlen() on a fixed size array
> is nonsense with an overlong limit:
> 
> mm/damon/dbgfs.c: In function 'damon_dbgfs_deprecated_read':
> mm/damon/dbgfs.c:814:19: error: 'strnlen' specified bound 1024 exceeds source size 512 [-Werror=stringop-overread]
>   814 |         int len = strnlen(kbuf, 1024);
>       |                   ^~~~~~~~~~~~~~~~~~~
> mm/damon/dbgfs.c:813:14: note: source object allocated here
>   813 |         char kbuf[512] = DAMON_DBGFS_DEPRECATION_NOTICE;
>       |              ^~~~
> 
> In fact, neither of the arbitrary limits are needed here: The first
> one can just be a static const string and avoid wasting any more
> space then necessary, and the strnlen() can be either strlen() or
> sizeof(kbuf)-1, both of which the compiler turns into the same
> constant here.

Thank you for this fix!

> 
> Fixes: adf9047adfff ("mm/damon/dbgfs: implement deprecation notice file")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

