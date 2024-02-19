Return-Path: <linux-kernel+bounces-71134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D0A85A127
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDE41F21118
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7852528DBD;
	Mon, 19 Feb 2024 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YFDtC3cW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3CE1C10;
	Mon, 19 Feb 2024 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339204; cv=none; b=EBt0CO1IGIjZnWE6aJnNURJoKLVax2ao+vYY41g3ma7T1Scvb0Oqrw9vrIrxSqQ/mWnVo0WnuaC2bEHtsXFKAKswTNFYpVdOUEL38dwKgQoRe7ZX3aDFGm7k7vPXj1bRotWuXNHBtTc4qennpdyy8Y0b+Wn599kcNU3qTIeQxw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339204; c=relaxed/simple;
	bh=b8qQHtXahwTH+tFwQtqQqu+gs5fjfDrer18Sd7jkXq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSi1yhk2VEwc55XXPFkNxHQ8Ca/ERDJzzab2HhLLo5AjyzIwUYh7/SabTdv9IOMlLhKHjv/qM2lpFNjoRgJRLWfHZPifjZ691iuYE7QKhX3plMhY0Py/xMUy3yYBXpCB7hbad7aoD2RQS1cpKDuJIH9hOkFZGm3+y5/bmeOrr+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YFDtC3cW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F94C433F1;
	Mon, 19 Feb 2024 10:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708339204;
	bh=b8qQHtXahwTH+tFwQtqQqu+gs5fjfDrer18Sd7jkXq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YFDtC3cWbF+BHdNFqkcR+JDlYMrJoUyeuT3H8nkXtoe6LqUK437lujhTqdoQgKRkp
	 n4dEGThWJ2sZPFwyX+aTHr0VCyIcDlpILuXMaE5UfIB09Yn2WMCinJmJFqwaP0rRnI
	 6i/wY7SLGuf4Jf/vJM8vqJzlDs4n9auUdYrPvBT0=
Date: Mon, 19 Feb 2024 11:40:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [char-misc-next] mei: gsc_proxy: match component when GSC is on
 different bus
Message-ID: <2024021927-study-schilling-9dfa@gregkh>
References: <20240211130408.3478-1-tomas.winkler@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211130408.3478-1-tomas.winkler@intel.com>

On Sun, Feb 11, 2024 at 03:04:08PM +0200, Tomas Winkler wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
> 
> On Arrow Lake S systems, MEI is no longer strictly connected to bus 0,
> while graphics remain exclusively on bus 0. Adapt the component
> matching logic to accommodate this change:
> 
> Original behavior: Required both MEI and graphics to be on the same
> bus 0.
> 
> New behavior: Only enforces graphics to be on bus 0 (integrated),
> allowing MEI to reside on any bus.
> This ensures compatibility with Arrow Lake S and maintains functionality
> for the legacy systems.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

What commit id does this fix?  How far back in stable kernels should it
go?

thanks,

greg k-h

