Return-Path: <linux-kernel+bounces-123460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C44D8908F0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF567B214D0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528136168C;
	Thu, 28 Mar 2024 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KvJB7SoZ"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3582B9A7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653313; cv=none; b=Ls+qPKUvFuoL3lKoNr5dj81YTxuqat6J217fKCfColZvMLhvpwpnpoxjQEI5R5D1F3TpnvI/impUvA3H/IeoKasdslfnlzBXqoG1dL0X4rlQ7i7PeQh0WNFEn1faP/RkhCKFbzSXvS6Ees1Si6xtF8pC0d7bCSVo81RRmz6ejJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653313; c=relaxed/simple;
	bh=zM7PQiHxWzOWOO4OCrDwshJ55wl6Sv3jEAqMenXlYfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJxQFLIx6J154FTbFhp8krfFxXLq2Sks1EWJccag20scJiZ8NBIF3evjbhQ5hUd103cHq+SStPtTswAJWo+ijif/q0kcd+dnvZt2TBfM4nc9+fYTOx36LKO8GKmTwTBwzo+8ZAHQXXvNvUuAUIfMLIYAGvosHGlkhFDLkE76VCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KvJB7SoZ; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 28 Mar 2024 15:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711653308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UiiYaB+fnO7Vb9P9+KhFx8SmJF7I5vpoUotl6zT2/zs=;
	b=KvJB7SoZJKVuzlqFVWM0vRr2iWIHkYGpJutBec/Y0CDeoRB3ZqbEZnoiYkOlkksKTFjkgc
	ZCl0V6MkQaKz+XlvCm77TLAL4XRYFaNjdlbdfH1ZqLGFKR/WklakWlabZ6DvLfZlpu8cMo
	T9CtcB9YVXDlDIj6D7xWNsnofVKorJA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, willy@infradead.org, 
	jack@suse.cz, bfoster@redhat.com, tj@kernel.org, dsterba@suse.com, 
	mjguzik@gmail.com, dhowells@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-ID: <kind5tn6ythzjca3r5wrshjyveawm7il7ng4n6zyfwctafmqwo@eldoiinbwtbn>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <20240327104010.73d1180fbabe586f9e3f7bd2@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327104010.73d1180fbabe586f9e3f7bd2@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 27, 2024 at 10:40:10AM -0700, Andrew Morton wrote:
> On Wed, 27 Mar 2024 23:57:45 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> 
> > This series tries to improve visilibity of writeback.
> 
> Well...  why?  Is anyone usefully using the existing instrumentation? 
> What is to be gained by expanding it further?  What is the case for
> adding this code?
> 
> I don't recall hearing of anyone using the existing debug
> instrumentation so perhaps we should remove it!

Remove debug instrumentation!? Surely you just?

I generally don't hear from users of my code when things are working, I
only expect to hear from people when it's not.

