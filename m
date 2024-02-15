Return-Path: <linux-kernel+bounces-67865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8401A85721E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3117D280C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DCC145FF7;
	Thu, 15 Feb 2024 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ARjB6lGo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30157AE5E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708041359; cv=none; b=Nbj32DlZfXPc/nA7kZSQvoCcxzQBEUd9Q79anMf6CmR2/N8mNh+aTWaX3msTVbdxvfa36f7EJubcziVsu/dRp+fytG23uHdzfzeCFgdwp8AU2CDXqil5fWIyN7DLIAbvjlMUsJYTxDLZtLqI7bwxUyNBEjHQYd45jQLVoQ9q9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708041359; c=relaxed/simple;
	bh=+32/LIgsTmazR7DFb8Tgomviel8c8z5g+ukyJtBOrV0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UpdgOGqqp3J1wndW06AEJZI3pQyiH0rFezcZU0nMckcNguAeUKWKhQpUcki8NRX8kSfvbKtjOzRfMbLvGx70mP/rMpAQEY0lI93NbC3B2N0u/PgKuXTrp8k/zJxDW/OskwQd7sh9S1lBGEPcfhshEswMmwXx5u2fw62YAmpeGNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ARjB6lGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE900C433F1;
	Thu, 15 Feb 2024 23:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708041358;
	bh=+32/LIgsTmazR7DFb8Tgomviel8c8z5g+ukyJtBOrV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ARjB6lGonfAu0Rk38IH8t89nBWYjI3WfC2X2+Rs0xh8Fpv8dbOtxJ/5PENGx2mnli
	 cURmyUmJxM+hu+VGcsNL06CkPuSJy8k4COIslVXGus96sRDZOPfL1VE4s7mOvcbh1d
	 cEhW8YpDtWTr9ItDBH2/G9BQh5D4jCfTmagWo0h4=
Date: Thu, 15 Feb 2024 15:55:57 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Michal Hocko
 <mhocko@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Matthew
 Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] mm: document memalloc_noreclaim_save() and
 memalloc_pin_save()
Message-Id: <20240215155557.93b23f4a69c6062e7878ed14@linux-foundation.org>
In-Reply-To: <20240215095827.13756-2-vbabka@suse.cz>
References: <20240215095827.13756-2-vbabka@suse.cz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 10:58:28 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:
>
> ...
>
> v2: fix issues that Mike pointed out

Cool.

> sending as replacement instead of fixup because I've used the wrong
> address for Kent and it became part of Cc: tag in the mm tree.

akpm has editor ;)

> + * This function marks the beginning of the __GFP_MEMALLOC allocation scope.
> ...
>
> + * This function marks the beginning of the ~__GFP_MOVABLE allocation scope.

pet peeves.  We can assume that the reader knows that this is a
function!  Perhaps we should teach checkpatch to whine.

Like "the function foo" and "the function foo()" in changelogs. 
"foo()" is enough!


