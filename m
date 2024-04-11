Return-Path: <linux-kernel+bounces-140563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B9F8A1637
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566531C22E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1843914E2F5;
	Thu, 11 Apr 2024 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGB5cvde"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE8414E2C8;
	Thu, 11 Apr 2024 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843143; cv=none; b=quKGkPwwVU+jsLlp+QpHTMopBxtVtr6T/achREMxTPeLB3Yu3sWqRkck2TvpmlIbOermlIGXlBKq7rgzKBEaErTNGAYjiLtQCBKW7eZmSddRWNl4tXroNyhFNId3bc7RZ9xMBEmWaGNC96ZKr4sEOIjQKZ06hBi8Z2VOVTURaqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843143; c=relaxed/simple;
	bh=Tr3v9IwXT/xEwkY/R/VsTmiz604534gdFf1SN3vftzI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gkOzy1/ZZYPbWNptf/xXUefIWJuOH47Kh4aZLnqypnyjLtkQgmsVNz5yfNo3mUBhDB+iiaZu+eNFfQy1FwE2dYaR+y9iQ5rdn7Srhv9sYfit8FJAwDTl5EFZrdIq4cefKNGqDGmkMGnfsBTisn25xRahJfpEp+q07A2WrLscYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGB5cvde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1681FC072AA;
	Thu, 11 Apr 2024 13:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712843142;
	bh=Tr3v9IwXT/xEwkY/R/VsTmiz604534gdFf1SN3vftzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UGB5cvdeQh4Eq+B66uxOXvftKKE2Wd+1+rKoLwD9h1fANbqcYmep56Sdyq2lj3fyp
	 dA/0xTzxMmrVDh5jKLiCgt4oD3lA74PnWe7y0j1DqpFna9TjkJXfwGvdfvEdQoeFqu
	 V6doZHyhAEio4aNe4j7RJTur2+qOHVUTRt6VqOd6gzpkorXrQ+mQuWz1izKno1aXzt
	 bQtXCIZBdyh2gLwxGZ2ITCbCw3ET3L6Qe6NDPwGWQOR23tXzYKh6rmVrKZjhyzb6w7
	 P0NM3+PJms0BLiVZ7lrIP1rga67kVkVaCOaMK5eSt75Qb3fUZytYVe4KuWKbm9jgaC
	 0DwnnZ1jV/43Q==
Date: Thu, 11 Apr 2024 06:45:41 -0700
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
Message-ID: <20240411064541.7106be9a@kernel.org>
In-Reply-To: <d28896e5-32cd-4376-bb1e-44c9dbfea172@intel.com>
References: <20240404154402.3581254-1-aleksander.lobakin@intel.com>
	<20240404154402.3581254-8-aleksander.lobakin@intel.com>
	<20240405212513.0d189968@kernel.org>
	<1dda8fd5-233b-4b26-95cc-f4eb339a7f88@intel.com>
	<755c17b2-0ec2-49dd-9352-63e5d2f1ba4c@intel.com>
	<202404090909.51BAC81A6@keescook>
	<91486cf6-c496-4459-8379-257383d031a1@intel.com>
	<20240410175424.7567d32d@kernel.org>
	<d28896e5-32cd-4376-bb1e-44c9dbfea172@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 11:07:24 +0200 Alexander Lobakin wrote:
> > I think doc tree is a strong candidate, or at least we should not
> > merge without consulting Jon. Please post and we'll figure it out.  
> 
> Can this series go simultaneously or it needs to wait for the fix first?

You can send both maybe just mention under the --- that "this one will
generate a known kdoc warning, I'll be fixing kdoc script separately".

> > The question someone may ask, however, is whether it causes new
> > warnings to appear?  
> 
> I tested `make W=12 KDOCFLAGS=-Wall all` yesterday and haven't noticed
> any new issues, although expected them.

Surprising but nice.

