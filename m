Return-Path: <linux-kernel+bounces-117712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2290188AEB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF501FA16F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5101272DE;
	Mon, 25 Mar 2024 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TmxYlVsF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2486886AF4;
	Mon, 25 Mar 2024 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391444; cv=none; b=TiM5fTBjZ4aDDQge6k78ihren/ZpfzrRaIzO7YheexIJUoVtxAqp1+8IDtLaCHQ8YR53LQJsvL4Zk9+dsd18DyHmaeWswND77QZXUD0EH0ibWUkG+W8dNpzn9gnvzYnfg/wo/pYjuNSQR/YpKIGSzWAYNR8ntdI3ZRxAgW3ybXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391444; c=relaxed/simple;
	bh=EGgF+3FS8bxQUKE175ebdsH/1xhbp6Jcxmo2HYR1Fk0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Y4uWsTursIzEaTmCxdWAzAwgWXGLoWVgnShLD6nSTw5XI/bhCFUyBXtrGw5MqJR10zBWhCj7N7hKJZh5KG+cPaRvOYUc0JaHArxeax3sJGmm6JYaX6dtIm6/8C2IP1Tz/+GZ0l+hnX4que0BmAzNoXdO7BHh3NYy5I58sjuQmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TmxYlVsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C9EC433F1;
	Mon, 25 Mar 2024 18:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711391443;
	bh=EGgF+3FS8bxQUKE175ebdsH/1xhbp6Jcxmo2HYR1Fk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TmxYlVsFqiPkcmzRsgs+/5IiPeWn4F5SarrOmovXS/+fpq7K3Hw/BUjoxNpkZpQwv
	 qg4o4wOZLE5nFh4fScC2BLXp31ZaF7xW6HrYVJ2LmbnkgUE4I5kHaFZA6g8RoZ+1TY
	 yqwmdnQ/Q2J8RguNUaTh33CjL4S8cJMwotudlCKU=
Date: Mon, 25 Mar 2024 11:30:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Mike Rapoport
 <rppt@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, Lorenzo Stoakes
 <lstoakes@gmail.com>, xingwei lee <xrivendell7@gmail.com>, yue sun
 <samsun1006219@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
 stable@vger.kernel.org
Subject: Re: [PATCH v1 1/3] mm/secretmem: fix GUP-fast succeeding on
 secretmem folios
Message-Id: <20240325113043.4fb05ab324e5c21ec4c0c0d4@linux-foundation.org>
In-Reply-To: <20240325134114.257544-2-david@redhat.com>
References: <20240325134114.257544-1-david@redhat.com>
	<20240325134114.257544-2-david@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 14:41:12 +0100 David Hildenbrand <david@redhat.com> wrote:

> folio_is_secretmem() states that secretmem folios cannot be LRU folios:
> so we may only exit early if we find an LRU folio. Yet, we exit early if
> we find a folio that is not a secretmem folio.
> 
> ...
>
> Cc: <stable@vger.kernel.org>

Thanks, I split up this series.  Because this patch goes
mm-hotfixes-unstable -> mm-hotfixes-stable -> mainline whereas the
other two go mm-unstable -> mm-stable -> mainline at a later time.


