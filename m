Return-Path: <linux-kernel+bounces-69116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 055138584CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384C91C21B00
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30B8134CFB;
	Fri, 16 Feb 2024 18:04:29 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4DF1339B8
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106669; cv=none; b=u08fU9wCAho+Yzj6csZHuaLmM4eiUU20TYBPDpd7c1wgVJvSL2uPbpz06pI956+5f6EwXHBZogCpdR0pDbWewieKuxNMsgSLlmAvRFgmugDzbqu6VeR0LVp+MV9KE4wybCF2Ul+H5t3CSG7MEgZS8hOwOzwr97bSjMjm53g5ER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106669; c=relaxed/simple;
	bh=pfeu5/o6oT0IxRmmQX2ZamkPfVQr6RJIXSIDyXMOsuE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bKQQEr0HxwiLfloer7SXpB2tQu0maRoz30qg7YNxie6G/LD5/g/UXf9/c4C6ioaV3icxjk5CxNqkVOs8kPuVjWlFqVeOzwD0aL/yu92BsjlnRvYWX2KnI9SranBAZjdeeJdnO0e0JpXwzc07xcKfDZiWG2sOO6PnGVWvErw0YlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 46727140384;
	Fri, 16 Feb 2024 18:04:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 037A72E;
	Fri, 16 Feb 2024 18:04:16 +0000 (UTC)
Message-ID: <ae2d03441a1b4ab62c9982e006bb21f6006ad713.camel@perches.com>
Subject: Re: [PATCH v2] mm: document memalloc_noreclaim_save() and
 memalloc_pin_save()
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka
 <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Michal Hocko
 <mhocko@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Matthew
 Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, Kent Overstreet
 <kent.overstreet@linux.dev>,  Michal Hocko <mhocko@suse.com>
Date: Fri, 16 Feb 2024 10:04:16 -0800
In-Reply-To: <20240215155557.93b23f4a69c6062e7878ed14@linux-foundation.org>
References: <20240215095827.13756-2-vbabka@suse.cz>
	 <20240215155557.93b23f4a69c6062e7878ed14@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 037A72E
X-Rspamd-Server: rspamout02
X-Stat-Signature: uaru84unyne7cso9hze6374w411qy7sy
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+wtkNzcOB/1WKKBtCElicsJyKKLDKd3hA=
X-HE-Tag: 1708106656-416423
X-HE-Meta: U2FsdGVkX1+FiGm4mZ12FSCruZ5Iaz7enFXCASYoTcEyCtTXf1RxwhuRsrl/MmkjORqcdTSP/M5gxsakBwbEbonMV70LxsHr81vL49Wwu06KxXK4fedoeqtNDZeu/wfCRS04UB4Vdh3ulGRryqZgrICnyM1TM2ojZWyn+aU1sFpdABJMmcrVRbnMytV6cG7NkXqCcwRMIg27E210dh8wI68ZSGw+74lRHKFjlu+wZHy3bD9ISqRvHtWl4EpQJ/okaK24t3Uug68p7OtewOQSFwfnE94BpiBwmghVJBC5vUQZufYDKoDUUU0QtBYYvz22

On Thu, 2024-02-15 at 15:55 -0800, Andrew Morton wrote:
> + * This function marks the beginning of the __GFP_MEMALLOC allocation sc=
ope.
> > ...
> >=20
> > + * This function marks the beginning of the ~__GFP_MOVABLE allocation =
scope.
>=20
> pet peeves.  We can assume that the reader knows that this is a
> function!  Perhaps we should teach checkpatch to whine.
>=20
> Like "the function foo" and "the function foo()" in changelogs.=20
> "foo()" is enough!

IMO: checkpatch should not be a grammar checker.

It's stupid enough as is let alone trying to get
it to analyze sentence structure.


