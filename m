Return-Path: <linux-kernel+bounces-139600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C608A04F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A49285874
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7744BA33;
	Thu, 11 Apr 2024 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXSraXtO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119E58C15;
	Thu, 11 Apr 2024 00:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712796867; cv=none; b=Ql095zvWbJ7E6SMhqQCGzYgq8AFC+jg6c5PQ5T/nALUhZi2NrvoIOKvljLzpdsubL35fOC2rwSSuCvJ6u48kYvQi2KLG4uqZ2ppag0UFYz6ubkRp5fnGHezaTgLh44+Nd+4utKyNFoPR7mg0yW6OdVRMcOvu8LXnKmQAmr/04ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712796867; c=relaxed/simple;
	bh=SYtRUZQ8HVrb2vo/aMPFNkrKw9nzziCur41M5OjRIFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHyntyJWg2danNM0/zbrORmny8reu4lpp6pAy/pK+12lfj4KmCAEKhxrESP3IHjPOHncIrZ54CJlVcKKxBvT0EJGuXhVAnJ53y4aTfjNz3myP4GjL5h49XvQ9PA+1g2sH9B54/7jvMP4Y7r4VU/e13jANNa29A6AWJnshhlsR8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXSraXtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC26EC433F1;
	Thu, 11 Apr 2024 00:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712796866;
	bh=SYtRUZQ8HVrb2vo/aMPFNkrKw9nzziCur41M5OjRIFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CXSraXtOqsvQyZSd+AXa1otcaR5MSenMo/pQdW9z1SWim6a4vAur8xk1G9sgteJMN
	 QMLR+LUbOcryrmQHb+e//ScxPe0N4U8/buGO6/iUHBmZOa7KhwLhZGGbCZEE0ZuOXK
	 mScvtDuAU0GmXYOZQQe09vweUbLFkqhNp7wrwDMWwoQdivrNM4JTrOXTZddkAdbcNQ
	 lMpVE1u+ZA0hVHf4ClkF1E+arwFfHBRsr8ZTnI0IAJlKKQ9tJVa5AVRq2m/wXvsyAX
	 GBiUBncqqa6zuHbu//H47sRq+289Lz5dnuOga9tzZ7HLF/K6a0DGwNar5A0Qlp+YO5
	 x/rL7420g7omA==
Date: Wed, 10 Apr 2024 17:54:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Kees Cook <keescook@chromium.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexander Duyck <alexanderduyck@fb.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Christoph Lameter
 <cl@linux.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton
 <akpm@linux-foundation.org>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
 <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v9 7/9] libeth: add Rx buffer management
Message-ID: <20240410175424.7567d32d@kernel.org>
In-Reply-To: <91486cf6-c496-4459-8379-257383d031a1@intel.com>
References: <20240404154402.3581254-1-aleksander.lobakin@intel.com>
	<20240404154402.3581254-8-aleksander.lobakin@intel.com>
	<20240405212513.0d189968@kernel.org>
	<1dda8fd5-233b-4b26-95cc-f4eb339a7f88@intel.com>
	<755c17b2-0ec2-49dd-9352-63e5d2f1ba4c@intel.com>
	<202404090909.51BAC81A6@keescook>
	<91486cf6-c496-4459-8379-257383d031a1@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 15:36:13 +0200 Alexander Lobakin wrote:
> Which tree this should go through? Should I include this patch to this
> series with libeth or it's better to push this through kees/linux and
> then pull to net-next?

I think doc tree is a strong candidate, or at least we should not
merge without consulting Jon. Please post and we'll figure it out.

The question someone may ask, however, is whether it causes new
warnings to appear?

