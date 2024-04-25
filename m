Return-Path: <linux-kernel+bounces-158288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF738B1DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F1C283DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE681272A5;
	Thu, 25 Apr 2024 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sJiz1FsL"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60713126F0D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036922; cv=none; b=B5MpNGImu3B/iO8uhsRUmQjDN5IfC2DE4JYfpxnFVpDX7RcjtRYZiyhkzraZkrMERDU9kWfOKWqhakG6HTK9o5K0OKK6ZsWyIVnT/zWSoREfRiQvLz1/J4/83tVbIhoYXMH8/lewBUxm4Suk4oMXI7x4hokSYmkU4D3lM8ZjSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036922; c=relaxed/simple;
	bh=rJ0zvfsPYvJVDtR5UXVJTwFBGz4duPaxvhOstl9W85g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RGrb3nndHX8U1yOU8A3EKWoaqOOchBPWGxBOFtAu1+DJU37LLlUsx7w62neUSgyTmJxV8lOsuehb5HLe68KA54h6Xrs+B/6uEzprXopsl0eP+omRh9B99f6xRKTEp6nHM8arrA2L5TGVyguGqPiTol3LtyqzXcbcFI6e+B4UFYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sJiz1FsL; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714036918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3V/WaVqxde+LTBGA2AzYP6+sp0xSX/my+Roisp7pcg=;
	b=sJiz1FsLxfibRcIE8ykuqcWcyIUPYS1XGBVYtbgh6wsew0T3XM7N7IGIxzRUKlaUqIuQzz
	a9RugXwPma80R88cPFZwHj8qleiLG2jcP4YtII4OxItohMDvdNxia9rZwJq7omPBZZiqxA
	uQll5O7+4lbow527LhG137T2/4CQ1jE=
From: George Guo <dongtai.guo@linux.dev>
To: mark.rutland@arm.com
Cc: ardb@kernel.org,
	catalin.marinas@arm.com,
	dongtai.guo@linux.dev,
	guodongtai@kylinos.cn,
	jbaron@akamai.com,
	jpoimboe@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	will@kernel.org
Subject: [PATCH v2 0/1] cleanup arch_static_branch/_jump
Date: Thu, 25 Apr 2024 17:21:17 +0800
Message-Id: <20240425092118.2924369-1-dongtai.guo@linux.dev>
In-Reply-To: <ZiYs3itsmdOmuPq4@FVFF77S0Q05N>
References: <ZiYs3itsmdOmuPq4@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Sorry, this is a cleanup patch.

And I have tried to define macro with key and lable, it seems not clear and
makes things complicated.

So keep the patch and rewrite it's subject.

George Guo (1):
  arm64: simplify arch_static_branch/_jump function

 arch/arm64/include/asm/jump_label.h | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

-- 
2.34.1


