Return-Path: <linux-kernel+bounces-168430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4056B8BB87E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714421C232E7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98B384FB9;
	Fri,  3 May 2024 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b="F2DLZfUB"
Received: from smtp101.iad3b.emailsrvr.com (smtp101.iad3b.emailsrvr.com [146.20.161.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A1458ACC
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714780189; cv=none; b=Hcrd8oG/RWmJS37VkL07q8XhzqoK0pZqo3BKXSmIWs8sB/lFnzuUqF5emFD0f1taXLAgc1kF9xhEoBQQOiJUJrje5t2bVEfuzAVxAw2isO9XsZuD/LDeaUl4w7afnKu+s0CF52rWACyNUePEhI7MxXmRVVNjTQBTHMppcRbh6sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714780189; c=relaxed/simple;
	bh=sEjZ83Sw1Dl1XxIKn2KeQPWM4I5AmiVyc4bGvGyYSiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uorysKzqIloHDyCDDhA33ahqo9ifVtZseU2d6jrddpTO0jWw6wSDjBlL1xLVaTQLQ9iVGrem/buwXTM/Z77gulIY3mYbj/XnFnr91gvTQ2Uj+CfDdWvYMRPPzeKZpRPD8J8JNTRdiq67Xof/zLfVbKfKvGmVf27sRnWVFN0pYiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com; spf=pass smtp.mailfrom=oddbit.com; dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b=F2DLZfUB; arc=none smtp.client-ip=146.20.161.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oddbit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
	s=20180920-g2b7aziw; t=1714779633;
	bh=sEjZ83Sw1Dl1XxIKn2KeQPWM4I5AmiVyc4bGvGyYSiY=;
	h=Date:From:To:Subject:From;
	b=F2DLZfUBhQ3QPw4CMlMcCre1KISmfn2mRJBTkSTCQveEH9SLP/50vpjpGdc6vn5vF
	 pKS2H+SuKkBZZASLVkXqTPUlzkCAw1ce+Ffpt4OMkcP6u34+0P89j3riGjoceeRjiM
	 ElHe5zEs6MrrXXM4dd0OEqjhoge7O0Y80hbA1fjA=
X-Auth-ID: lars@oddbit.com
Received: by smtp13.relay.iad3b.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id F10F1602B0;
	Fri,  3 May 2024 19:40:32 -0400 (EDT)
Date: Fri, 3 May 2024 19:40:32 -0400
From: Lars Kellogg-Stedman <lars@oddbit.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Duoming Zhou <duoming@zju.edu.cn>, linux-hams@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org, 
	edumazet@google.com, davem@davemloft.net, jreuter@yaina.de
Subject: Re: [PATCH net] ax25: Fix refcount leak issues of ax25_dev
Message-ID: <ekgwuycs3hioz6vve57e6z7igovpls6s644rvdxpxqqr7v7is6@u5lqegkuwcex>
References: <20240501060218.32898-1-duoming@zju.edu.cn>
 <my4l7ljo35dnwxl33maqhyvw7666dmuwtduwtyhnzdlb6bbf5m@5sbp4tvg246f>
 <78ae8aa0-eac5-4ade-8e85-0479a22e98a3@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78ae8aa0-eac5-4ade-8e85-0479a22e98a3@moroto.mountain>
X-Classification-ID: ab5b3add-fbf9-4fe3-adb7-2c2d96a83c57-1-1

On Fri, May 03, 2024 at 11:36:37PM +0300, Dan Carpenter wrote:
> Could you test this diff?

With that diff applied, there is no kernel panic, but I see the same
refcount errors that I saw before the latest series of patches from
Duoming:

  refcount_t: decrement hit 0; leaking memory.
  refcount_t: underflow; use-after-free.

-- 
Lars Kellogg-Stedman <lars@oddbit.com> | larsks @ {irc,twitter,github}
http://blog.oddbit.com/                | N1LKS

