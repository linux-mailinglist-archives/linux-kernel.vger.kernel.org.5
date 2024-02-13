Return-Path: <linux-kernel+bounces-62856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9DF8526F1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4397EB27A54
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14457475;
	Tue, 13 Feb 2024 01:19:36 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95D86FB5
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 01:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707787176; cv=none; b=dyQ2QGKR231d0ppIQa2qzCuxhpLQ53e4J03dHOL+sw0ikTF3kj64z51hFushNjhUnLFH1CHas1oGhTKXaFYqMAG7f0bQtqDJ3mQuXjjtfcfVbzmUxr8aKqbnPM7AWEl+BLIpffOcYl29KgBcEG7RYl95/NXF2vim3K5B0Nw+1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707787176; c=relaxed/simple;
	bh=mFss4D680cCUxXGTFlhC9SCYicp7MiRQJezYyg6mG08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiuf6ZSsj5j24DnzMLf2HtXic+HVA8YY9jqc3MoMkkjDcoCE2tFcCZQK4LRFL611QJdeSw0kW1OCBvyoS3zW7QcS+KFHwNMp6rI5W+FxmX58xoeio/h3f9HpHVUXyGDbq13H/0K/bN5aqie5N5RIbtfCRSIbouXhrXRLP0w2b3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-38-65cac3a2ee15
Date: Tue, 13 Feb 2024 10:19:24 +0900
From: Byungchul Park <byungchul@sk.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, ying.huang@intel.com, namit@vmware.com,
	vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
	willy@infradead.org, david@redhat.com, peterz@infradead.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [RESEND PATCH v7 7/8] mm: Defer TLB flush by keeping both src
 and dst folios at migration
Message-ID: <20240213011924.GB4147@system.software.com>
References: <20240208062608.44351-1-byungchul@sk.com>
 <20240208062608.44351-8-byungchul@sk.com>
 <20240208125409.28d5aa60d88657405f5c8e1b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208125409.28d5aa60d88657405f5c8e1b@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsXC9ZZnoe6iw6dSDZpn8FnMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DHyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJebyb/5YtgD+KyyYl
	NSezLLVI3y6BK2PWo0XsBW+ZKo78Xs3ewDifqYuRk0NCwETi4tMmNhj7/Kc1QHEODhYBVYnX
	93RAwmwC6hI3bvxkBrFFBHQlVj3fBWRzcTALfGGSuHDrOFhCWCBD4nn7MxYQm1fAXOLHqoes
	IEVCAosYJR5+mQmVEJQ4OfMJmM0soCVx499LsGXMAtISy/9xgJicAt4Ss0+qglSICihLHNh2
	HOrMXewSe19LQNiSEgdX3GCZwCgwC8nQWUiGzkIYuoCReRWjUGZeWW5iZo6JXkZlXmaFXnJ+
	7iZGYGQuq/0TvYPx04XgQ4wCHIxKPLwJKqdShVgTy4orcw8xSnAwK4nwXppxIlWINyWxsiq1
	KD++qDQntfgQozQHi5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QDY4ixe97dhMp9N+v/W7tH
	Z6yOOMaysGJP/k651bYm/0JYNzzqZ5sjFnzoRMo75cKLBdNy81/rq+wXr94ntGfbQ6Xlk7bs
	6Jhr2Njup9A2k3WOQdeZFMGw1ik53tcPhx8Lyn7nyt/JfHrmXh3Lw3/E85o1VYPeykw3Wbh4
	X4OugmtAYqJyzJ0oJZbijERDLeai4kQAZSHmucgCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsXC5WfdrLvo8KlUg9MtzBZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoI6TsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPxiw9MHlt/2Xk0Tr3G5vF5k5zH
	u/lv2QIEorhsUlJzMstSi/TtErgyZj1axF7wlqniyO/V7A2M85m6GDk5JARMJM5/WgNkc3Cw
	CKhKvL6nAxJmE1CXuHHjJzOILSKgK7Hq+S4gm4uDWeALk8SFW8fBEsICGRLP25+xgNi8AuYS
	P1Y9ZAUpEhJYxCjx8MtMqISgxMmZT8BsZgEtiRv/XoItYxaQllj+jwPE5BTwlph9UhWkQlRA
	WeLAtuNMExh5ZyFpnoWkeRZC8wJG5lWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiBkbas9s/E
	HYxfLrsfYhTgYFTi4U1QOZUqxJpYVlyZe4hRgoNZSYT30owTqUK8KYmVValF+fFFpTmpxYcY
	pTlYlMR5vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2MRx0fWs+/7qupePW/VnGl6/Sl/1Wl5Bem
	NlxR9pkutPDUrVjBwAV2IrHhEp2yzpmr5YxW8U0TUv7x2cUr/u33vBPVW1dZyO/ewCZ6LM1+
	k07h/1P/xILPJ2hm/52xQ+1ZRP5JsY0iG+x7BM1kzqeZJ4jWHFINLf4yafPex/G6V1lTM64u
	M3FVYinOSDTUYi4qTgQA6QpBnrACAAA=
X-CFilter-Loop: Reflected

On Thu, Feb 08, 2024 at 12:54:09PM -0800, Andrew Morton wrote:
> On Thu,  8 Feb 2024 15:26:07 +0900 Byungchul Park <byungchul@sk.com> wrote:
> 
> > Implementation of MIGRC mechanism that stands for 'Migration Read Copy'.
> 
> Oh there is it.  Please put this in the [0/N] cover letter?

Sure. I should've put this in the cover letter. Thanks.

	Byungchul

