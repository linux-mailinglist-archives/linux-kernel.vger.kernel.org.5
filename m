Return-Path: <linux-kernel+bounces-162678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D06E8B5EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E5D2B230BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F4C84D35;
	Mon, 29 Apr 2024 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LrKzQntE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B76A824AE;
	Mon, 29 Apr 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407790; cv=none; b=QAJTSnf90cF6Dm624geBugwYANxWKliKjHmJtdbyqNOzAQZ6rU/WIfJUwr7n0XiOVNsKDE9GhpD+1i/l6S9j8BgAakIkMBJQW2zwYsfNxEJWWFqwwgg3FeJ52dX15yYwL0QoFmmuwwzYXDB7fbwNbSirvTolcuVs2NAD16pSkfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407790; c=relaxed/simple;
	bh=leIF1FkkaAIGefMANabaMQGP376d/EtqqslqBj0skp4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qLecB1ibSUXinbYa201SAy/MgURGwfl/YT4PkfTrIkpm1Wt7gwD17J9e8rlBqi7yg7Uly/g035zgDDIBQChSMW6nuXLcvKtCzo5QhCYXO8jadavjSvrWQl0I0gwwPSeoNhDCWZ8NSmwAncwVMmsPj3kHN7WBCUPLQNlZ8b9LeDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LrKzQntE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B2FC113CD;
	Mon, 29 Apr 2024 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1714407789;
	bh=leIF1FkkaAIGefMANabaMQGP376d/EtqqslqBj0skp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LrKzQntEeZj2BfgfUv6nBmFwPfgwHh0sru4q3QdBSe8rnwxUpw/sH2YaoWBJqsi1G
	 46aNixPeM47BJAbqbRQPFcSOBRXjr3JJObNiK1TSFoRp9nlnMo50clkx0wOXSS65F8
	 uJyH9w7LEd7Y8cA/y9koOTgq/+WCXzpbUnWO+FtE=
Date: Mon, 29 Apr 2024 09:23:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: ziy@nvidia.com, linux-mm@kvack.org, fstests@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, hare@suse.de, john.g.garry@oracle.com,
 p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH 1/2] mm/huge_memory: skip invalid debugfs file entry for
 folio split
Message-Id: <20240429092307.37bf51c79f70bad4922f6277@linux-foundation.org>
In-Reply-To: <Zi8cYrtxyO7Uw-Mc@bombadil.infradead.org>
References: <20240424225449.1498244-1-mcgrof@kernel.org>
	<20240424225449.1498244-2-mcgrof@kernel.org>
	<20240425140126.2a62a5ec686813ee7deea658@linux-foundation.org>
	<Zi8cYrtxyO7Uw-Mc@bombadil.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Apr 2024 21:04:50 -0700 Luis Chamberlain <mcgrof@kernel.org> wrote:

> On Thu, Apr 25, 2024 at 02:01:26PM -0700, Andrew Morton wrote:
> > On Wed, 24 Apr 2024 15:54:48 -0700 Luis Chamberlain <mcgrof@kernel.org> wrote:
> > 
> > > If the file entry is too long we may easily end up going out of bounds
> > > and crash after strsep() on sscanf(). 
> > > 
> > 
> > Can you explain why?  I'm not seeing it.
> 
> I couldn't see it either but I just looked at the crash below and
> its the only thing I could think of. So I think its when userspace
> somehow abuses MAX_INPUT_BUF_SZ a lot somehow.

This isn't a good basis for making kernel changes :(

Can you investigate a little further please?  What actually is present
at *buf when your new checks succeed?  Could we be seeing 0xNNN,0xNNN
and leaving new_order unaltered?  Or something.

