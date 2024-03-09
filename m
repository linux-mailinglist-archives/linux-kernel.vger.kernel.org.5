Return-Path: <linux-kernel+bounces-97702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A86BE876E0E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 01:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E373C1C221B9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51A41102;
	Sat,  9 Mar 2024 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coSJ4iJM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ECB37A;
	Sat,  9 Mar 2024 00:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709942932; cv=none; b=h0UWjxImUTTE5/cKE5DNNs76w1fQsudb7F8VHtVjpF0Fw99uLlyH/K0lI4bDI3sHOE028Fo7psIrjx8DSXH7PYSN3AlCu1HpC9HZAPcvwjf+uAcUCOqofldj89BrXGp5V7TGCah11lBwdrKMkS30zDQUpPJ+5OZJn9rErl6bD5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709942932; c=relaxed/simple;
	bh=/5HXstw1PxKqE3qL1W1y4XpmqL7UyT7EmokD9lrIuY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXGNMMTxrLvesKpJG798o3ib66k3cGPIZ0WsL9fk4bOlOicVYen99tywcMaho7Z/6HMGaOLbKRRYCYJLxKTZTmVOPmUUySVpw19G5rpJyWeiufepArFkvUEOO+hufDvXipI/caoyxkvMLjXpuM+X6WHwo4Sy6cvp+cYlCLhtkdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coSJ4iJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C158C433F1;
	Sat,  9 Mar 2024 00:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709942931;
	bh=/5HXstw1PxKqE3qL1W1y4XpmqL7UyT7EmokD9lrIuY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=coSJ4iJMTK9Rw0GH05VG9+EqxDTQ+jfOLDgSvcdmf2kPSREX0NWLxlOBJpftZzoHi
	 y5rAvV6Ju+nDrm+WFYp1zIgS6ZJ9RgKxkvSOVbgb2WC+rlnEPpPPU3UVBCihr6q1eu
	 /N2rflDkGAu2FGyDfztUUQv4jLty4JSX0UJt2FVSOLOy6qgxECNsiOPrdElU524vzL
	 TERhI9DBgNHmuAGg76ropcVQBFZsC4TTiOLv/zU/qXYkl91v77LSMHGy5mQuXZC5SR
	 Hclcncgwul9lcyugObo3lDheiR7KHpTaBONBrMKSDISyqPVshdVqWJWZV8g86Fo3Al
	 t+iD0undEtEYA==
Date: Fri, 8 Mar 2024 16:08:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH net-next v1] net: page_pool: factor out page_pool
 recycle check
Message-ID: <20240308160850.1cfc16b8@kernel.org>
In-Reply-To: <CAHS8izOm18Rv7QJfpKmquEgf74PvqZeY4zBnyG73BVFDbCvWmw@mail.gmail.com>
References: <20240308204500.1112858-1-almasrymina@google.com>
	<8adb69f3-b0c0-42bf-b386-51b2be76cbb4@davidwei.uk>
	<CAHS8izOm18Rv7QJfpKmquEgf74PvqZeY4zBnyG73BVFDbCvWmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 16:04:14 -0800 Mina Almasry wrote:
> > Could this be made inline?
> >  
> 
> Looking at the rest of the static functions in this file, they don't
> specify inline, just static. I guess the compiler is smart enough to
> inline static functions in .c files when it makes sense (and does not
> when it doesn't)?
> 
> But this doesn't seem to be a kernel wide thing. net/core/dev.c does
> have static inline functions in it, only page_pool.c doesn't do it. I
> guess if there are no objections I can make it static inline to ask
> the compiler to inline it. Likely after the merge window reopens if it
> closes today.

It's all good. We have a policy in netdev of "no inline unless you can
prove it makes a difference". It will not make a difference here and it
will mute the "unused function" warning.

