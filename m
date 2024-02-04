Return-Path: <linux-kernel+bounces-51564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05E7848C92
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845751F222DF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA3018EB8;
	Sun,  4 Feb 2024 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBFjMBl4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDBA18EAB;
	Sun,  4 Feb 2024 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707039891; cv=none; b=owWOyltnadFJMITFxxQaRbTHVuTFoix2QlTQUccTfvO+Wa4X2whynG8IGEqh+/ITfjelZA+nPqH5C2xKdrz/2LnbV4haJT6zV0ArjDZf7ZaxwT+UiUwxrNtq5MlJdIr3c/aMHBtbYSNC00Lj+CeKCW7F1OUZS+9e1tZiCJq2T04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707039891; c=relaxed/simple;
	bh=YCcPHerLjGDl0BbYD/mn0R8vtWeZaXPkp3y96favmLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/esD0Q8FE5M+PeCAEsRg/5CV9O8d0t9FVqOXySsnBA4EuvSFy+8D562jnPQPLqqBut0yGeQFERVq79LRGu45gNG+aYgBOCeA+W0peo9pQveMQYjREcAfT/74omuYuK/H0hNmfaJOGv2H+kkgasPl14NUb1dpuzFyiarWEGCE6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBFjMBl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A40C433F1;
	Sun,  4 Feb 2024 09:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707039890;
	bh=YCcPHerLjGDl0BbYD/mn0R8vtWeZaXPkp3y96favmLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KBFjMBl4HtwVlXCO71isBNBGQOTRuxDXEylxnhktNuTMSpz5Rx2c3aJNLCZUATCcM
	 68Q8OJ/AgdEJ3CzsQ47V53tOfJNWUB8cTsxnzXZZ7EPA4j+2emDMErwl0VgXBeTDfb
	 RK8r1J5g39GeqrXfE9EaiwqtCz+OHPzSt3k/edyL5s+f+cXQid4c5PmeJ42sl6fi+a
	 g7yHfTsEddOqd+EN8jpx2uDBnifcL9mi6zTGeZ8cX1+tIphOcVLoXgFGcDufMcu/X8
	 EoTnYymXMw93ib2FLsRe/SHH+Sfs0a/ZLAvuMFReoma2WB0Zu+0qJgfVq6x2O4077C
	 vSQPkXp3lLNNA==
Date: Sun, 4 Feb 2024 11:44:46 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: William Kucharski <william.kucharski@oracle.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/srpt: Do not register event handler until srpt
 device is fully setup
Message-ID: <20240204094446.GA5400@unreal>
References: <20240131062438.869370-1-william.kucharski@oracle.com>
 <20240131062438.869370-2-william.kucharski@oracle.com>
 <894db19d-5287-4ed8-a0d9-0211b365eafa@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <894db19d-5287-4ed8-a0d9-0211b365eafa@acm.org>

On Thu, Feb 01, 2024 at 06:48:34AM -0800, Bart Van Assche wrote:
> On 1/30/24 22:24, William Kucharski wrote:
> > Upon rare occasions, KASAN reports a use-after-free Write
> > in srpt_refresh_port().
> > 
> > This seems to be because an event handler is registered before the
> > srpt device is fully setup and a race condition upon error may leave a
> > partially setup event handler in place.
> > 
> > Instead, only register the event handler after srpt device initialization
> > is complete.
> 
> A Fixes: tag is missing. Otherwise this patch looks good to me. Hence:

I added this line:
Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")

> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks

