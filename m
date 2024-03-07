Return-Path: <linux-kernel+bounces-96165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A288757F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEA88B25DA6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E8A130AC1;
	Thu,  7 Mar 2024 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SdNPdVcq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F79137C52
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842274; cv=none; b=kJF1fUiIDD0QIvz7rn/lv9KajSEt8fAqfMV3q5RGheW8eW5RE+YJCkkt0hOctohGeWU9aGt1pG63lwEcZHTeF/5Mic7K4wyL5ZZJdk6zUpFsgYUzXoiPN0OPRPQZLSW2hOuNHoCcKbtfMJCkckX4NEat8hMi/NOExszFsq70pQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842274; c=relaxed/simple;
	bh=B6mfEbg7m6R6+7MIeFP+NGCTEGpLaAV/oieLgTsxJJg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lJuh+SB6JdpifNOWOjNlsuEVAhnfjY2y8GQTgUPQUTSJnySIuhVU6uSpE5+s8cXiacuzVbNNmDj5P6shYKYpYm/vERlfl0N8wt3mn6qPdgeEP8EEn0kmSIw9shLry+2uqg22k5YwLTnTcUN81ezDxKrilmyljTmgDeXAnAoa1gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SdNPdVcq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7751C433C7;
	Thu,  7 Mar 2024 20:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1709842274;
	bh=B6mfEbg7m6R6+7MIeFP+NGCTEGpLaAV/oieLgTsxJJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SdNPdVcqPXz6WFeB8AcTxbuot3VsDMqNuXo9pWXMDBY+e7UjrNYXofmz6G33eO8js
	 0vmqVGIwlHF7Q752/q21DZhsgjO5e5uEJnuYRxDJ0clsrt2Hflx4VhGX4mscTvLgEF
	 hLL3jWHamjjmzSJyz4rLUtusAUEN7GmKHklWX6Ls=
Date: Thu, 7 Mar 2024 12:11:13 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: rulinhuang <rulin.huang@intel.com>
Cc: urezki@gmail.com, bhe@redhat.com, colin.king@intel.com,
 hch@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lstoakes@gmail.com, tianyou.li@intel.com, tim.c.chen@intel.com,
 wangyang.guo@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH v8] mm/vmalloc: Eliminated the lock contention from
 twice to once
Message-Id: <20240307121113.16cc480515195f1fe945bbac@linux-foundation.org>
In-Reply-To: <20240307021440.64967-1-rulin.huang@intel.com>
References: <20240307021440.64967-1-rulin.huang@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Mar 2024 21:14:40 -0500 rulinhuang <rulin.huang@intel.com> wrote:

> When allocating a new memory area where the mapping address range is
> known, it is observed that the vmap_node->busy.lock is acquired twice.
> 
> The first acquisition occurs in the alloc_vmap_area() function when
> inserting the vm area into the vm mapping red-black tree. The second
> acquisition occurs in the setup_vmalloc_vm() function when updating the
> properties of the vm, such as flags and address, etc.
> 
> Combine these two operations together in alloc_vmap_area(), which
> improves scalability when the vmap_node->busy.lock is contended.
> By doing so, the need to acquire the lock twice can also be eliminated
> to once.
> 
> With the above change, tested on intel sapphire rapids
> platform(224 vcpu), a 4% performance improvement is
> gained on stress-ng/pthread(https://github.com/ColinIanKing/stress-ng),
> which is the stress test of thread creations.
> 

Thanks.  We're late in -rc7 so I'll queue this up for merging in the
next merge window.

