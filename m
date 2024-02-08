Return-Path: <linux-kernel+bounces-57381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6251784D7B3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59128B22F7F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4411D557;
	Thu,  8 Feb 2024 02:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ry4rv5Zd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6921CD25
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 02:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707357670; cv=none; b=g8sOwJZS4kolT8FKMKfrrlKUpYpbKDFVJB4Oo8uehQ9KjEi/dbmRvX0saJQiDwHZiLhIj/G2DsJ8p1obxclB3cVq9rEM5Eb2cJgH0esXJRZJ6vrshsvy1cg/houGwV8jJGvUFb5kVAU0rZRgzZprG3285veT0057d1PYTyjukgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707357670; c=relaxed/simple;
	bh=dwTLQzI/QIkNCUaRNzVuPjQwBg8dpqhsrkwPkL+Pg7g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=COvwQ0U9faWyYketnoJ4LbhNKaAO8lN2Azt74mHqvAt0ggZDWiIyv0Mf1eDZ172k/Bqdvil5imgYH55b/4q/GzRKv+ZrFNbJ3IUMi2nXe0QR75cPxfOScYrj6OqLZQnbH2ZdAIMUd5ld5ZHbMIcLHvvqHZgtBO7tu9sKTqGVTQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ry4rv5Zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D66AC433C7;
	Thu,  8 Feb 2024 02:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707357669;
	bh=dwTLQzI/QIkNCUaRNzVuPjQwBg8dpqhsrkwPkL+Pg7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ry4rv5ZdjcSuqtYio8CxxKNPfgBtQ5SZk14HB7hm+WwWdBn0VomqE2FLHV9pJojq9
	 7bphmEJCiWzntJPdMCabGqgE5OIjyDA+Asw8BlDH+VBUug0L21dFZB8Td+ftMMacMg
	 Rle8uVDEKFFELCeYg9jOthphVF05BW7aUP2lhqa8=
Date: Wed, 7 Feb 2024 18:01:08 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, mike.kravetz@oracle.com
Subject: Re: [PATCH v3] Hugetlb pages should not be reserved by shmat() if
 SHM_NORESERVE
Message-Id: <20240207180108.6a181d9fa5b404f78c0b4b22@linux-foundation.org>
In-Reply-To: <e59c8e4c-c416-4026-9ab9-ee55edafd4b3@linux.dev>
References: <1706040282-12388-1-git-send-email-prakash.sangappa@oracle.com>
	<e59c8e4c-c416-4026-9ab9-ee55edafd4b3@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 15:03:15 +0800 Muchun Song <muchun.song@linux.dev> wrote:

> > Fix is to ensure that hugetlb pages are not reserved for SHM_HUGETLB shared
> > memory in the shmat() call.
> > Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
> 
> BTW, it is better to add a Fixes tag to specify which commit
> that this commit aims to fix.

s/better/essential/

However this issue appears to pass the "been there forever" test, so
I'll send it to Linus as-is.


