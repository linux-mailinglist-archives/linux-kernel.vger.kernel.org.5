Return-Path: <linux-kernel+bounces-133555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9927889A57E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55692283053
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBAB173356;
	Fri,  5 Apr 2024 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XOymsCX4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187635D905
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347902; cv=none; b=iwKzJQqQJ2k6WKFOikJKO6mLCT7x1JTpw/AJ8iiCDj7fSIbLku1EIG6GuVNWxBRMnwu8vLGxUXjZsgXHyEUUxqReBMUUshZjvt8+SvzYN+oAJpi58aimsfoQ1sOR2ONqkX4HJyBU3mNAl9+RMdxEIE2GvSvoqoTA2Y29TZXMmfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347902; c=relaxed/simple;
	bh=hmlWxYWC8MXpNU1eZeGMi1xVSHnJJyvp2R6BKCE2ocQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rxh+4TU+yfcERoLS2IGZYjPwqKLUtsQOXBH09YET3TD6XYxsGV+CROpZXo9baGoYUEbwY2GDGSBLncX9coBIPrn0O415/hBH/RbZ4nDUrhs8sIv6eXNRpnybwNkpRBf4iDEpZkStb81EIy1wwXtXUKxelsXI1Avjqc9mz20Cy+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XOymsCX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EF6C433C7;
	Fri,  5 Apr 2024 20:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712347901;
	bh=hmlWxYWC8MXpNU1eZeGMi1xVSHnJJyvp2R6BKCE2ocQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XOymsCX4r/qKORJi45Mr8d9xXPTQBelgyYC4+PjxL5iQDXueYUqxWu0LTByCt0+fV
	 hFSUw9ODOfn9Hkrq5QZIFOf/cIaIZIkQlIxBeux5yIqzwgwNrKK6tfkKA0cdz9FJwr
	 folJ1AMVoXvjOptwx6rZPjkZ8wM6V7xep9AXTGJ4=
Date: Fri, 5 Apr 2024 13:11:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: david@redhat.com, linux-mm@kvack.org, ryan.roberts@arm.com,
 cerasuolodomenico@gmail.com, chrisl@kernel.org, kasong@tencent.com,
 peterx@redhat.com, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, yosryahmed@google.com, yuzhao@google.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] mm: add per-order mTHP alloc and swpout counters
Message-Id: <20240405131140.8881aae1af0d877dc70c8ea9@linux-foundation.org>
In-Reply-To: <20240405102704.77559-1-21cnbao@gmail.com>
References: <20240405102704.77559-1-21cnbao@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Apr 2024 23:27:02 +1300 Barry Song <21cnbao@gmail.com> wrote:

> The patchset introduces a framework to facilitate mTHP counters, starting
> with the allocation and swap-out counters. Currently, only four new nodes
> are appended to the stats directory for each mTHP size.
> 
> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
> 	anon_alloc
> 	anon_alloc_fallback
> 	anon_swpout
> 	anon_swpout_fallback

Please let's get these documented? 
Documentation/admin-guide/mm/transhuge.rst seems to be the place, and
under Documentation/ABI.  

