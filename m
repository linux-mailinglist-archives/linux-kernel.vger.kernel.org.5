Return-Path: <linux-kernel+bounces-11113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C2381E170
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 16:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319A41F212BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 15:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F25A52F6D;
	Mon, 25 Dec 2023 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ArDZfHgm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC5E52F61
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=yfsKP9bIoO8NvpKIkLPbcIhRdzO+flqkLdSJDquLXy8=; b=ArDZfHgm9NpwhpmuBY0DyuZTCr
	WXWDp+yexk2QHiIYRKXyILgsMsnGit+sw+bIMtRbyxEuoUv49jtE9FI8HTlMcXOLx+QVMzSA/eYrb
	IvILvCEvaIYoS1NV5qR25qWofarizrqOydBNUAoLQkoMZ1T2AXJsk4tApgNxIaQFjboNLLNi6APj8
	PMBB60TdoW7qDQHpy5ptZsaF3T+eQXILKoJkkeZxSGt//3KNplRhujzEsEsjDqTESXOdfsKZed4xm
	EHo6GtVpwG5JXbDSNc0bfpYZ/DEQLo56+zdt2b96rjfDJeAyrt8WCDdos+FZCOCIHG3pYr72Hehu5
	jRA+h5lw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rHn5o-00GDb6-6W; Mon, 25 Dec 2023 15:42:12 +0000
Date: Mon, 25 Dec 2023 15:42:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 3/3] mm, lru_gen: try to prefetch next page when canning
 LRU
Message-ID: <ZYmi1GEH0ai/2iGo@casper.infradead.org>
References: <20231222102255.56993-1-ryncsn@gmail.com>
 <20231222102255.56993-4-ryncsn@gmail.com>
 <CAOUHufYrzw7dDbchNkrrXnSqpeYasnfPh6qFoMNgAmbK9GXNaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufYrzw7dDbchNkrrXnSqpeYasnfPh6qFoMNgAmbK9GXNaQ@mail.gmail.com>

On Sun, Dec 24, 2023 at 11:41:31PM -0700, Yu Zhao wrote:
> On Fri, Dec 22, 2023 at 3:24 AM Kairui Song <ryncsn@gmail.com> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Prefetch for inactive/active LRU have been long exiting, apply the same
> > optimization for MGLRU.
> 
> I seriously doubt that prefetch helps in this case.
> 
> Willy, any thoughts on this? Thanks.

It _might_ ... highly depends on microarchitecture.  My experience is
that it offers more benefit on AMD than on Intel, but that experience
is several generations out of date and it may just not be applicable to
modern AMD.

It's probably more effective on ARM Cortex A cores than on ARM Cortex X
cores ... maybe we can get someone from Android (Suren?) to do some
testing?

