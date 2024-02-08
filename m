Return-Path: <linux-kernel+bounces-58686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF15984E9F3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0DD1F2822A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB43524D9;
	Thu,  8 Feb 2024 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Muo4DSdJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5588524C9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707425360; cv=none; b=twi3KLH0X9EMwYC6bCZ15pwefLCsJoJiRtnvssTZTB4LVkiDEEmF1rQjWL9jv4qsntZk4HmBOphFXxkBqgqM5AJh+FmacDqNuNmLj6qoqnhR+NPm9gnutdsbCw46YiuUuiSqMz4bqNKGVePBl+dRDiuPOW3e1SoLfSlAIBIjyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707425360; c=relaxed/simple;
	bh=XNy5bct25iKIwk3cOLUSYqT7AZnVWs8QzMt8bjh+KG8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MAG+gJ7oFtgKQHNIU9zkK4LMFdfzj7cGrbM3NT8FTWBek5I2I+6VH208pp+w0dyH8eK7VsvKZOkB1uPilbSC/gR6IOLhpaC1weyussSSWIKKZMvGH4jEsEbsimCkZVx2sdY8L5YBH7/6zAjvR2mKeYd64EhgBFoGNyGv5fVtac4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Muo4DSdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF510C433C7;
	Thu,  8 Feb 2024 20:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707425360;
	bh=XNy5bct25iKIwk3cOLUSYqT7AZnVWs8QzMt8bjh+KG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Muo4DSdJIQCwPOwHQuDdpeACnq24SRB85OZb8qYTGEKdx6qw/yyW4J0JEpxCAFWyV
	 J2ol6++kg3HPomXzL0+19loBiZlk08NG952wSGGsbEsx7A4rCAd3b0ptmSNfgvYZVf
	 btKyfOuyd6gEe2SDFMoxl5FxSkD0pUbE6oNsJu+s=
Date: Thu, 8 Feb 2024 12:49:19 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, ying.huang@intel.com, namit@vmware.com,
 vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
 willy@infradead.org, david@redhat.com, peterz@infradead.org,
 luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [RESEND PATCH v7 6/8] mm: Add APIs to free a folio directly to
 the buddy bypassing pcp
Message-Id: <20240208124919.a0e1707fefc29c2f4213e509@linux-foundation.org>
In-Reply-To: <20240208062608.44351-7-byungchul@sk.com>
References: <20240208062608.44351-1-byungchul@sk.com>
	<20240208062608.44351-7-byungchul@sk.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Feb 2024 15:26:06 +0900 Byungchul Park <byungchul@sk.com> wrote:

> This is a preparation for migrc mechanism that frees folios at a better

The term "migrc" appears in various places but I don't think we're told
what is actually means?

> time later, rather than the moment migrating folios. The folios freed by
> migrc are too old to keep in pcp.

How do we define "too old" and what causes you to believe this is the case?

