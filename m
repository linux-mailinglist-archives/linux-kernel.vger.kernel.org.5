Return-Path: <linux-kernel+bounces-111565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E34E7886DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835881F21246
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8173645BFC;
	Fri, 22 Mar 2024 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IVexsGSj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEDF3B2AD;
	Fri, 22 Mar 2024 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115227; cv=none; b=iYcUBosjpB1Y1rF/fCLhWUtTwxEN7ocSi6nwEs7+tvBf1za6eqgza1N34WG+yeGb9UDha96VQ3RVxgS60SfxyO04QXhJILvEJDYk+tuJsMP4TNZD9x+Hjd8QBxX3bxK58Yc/X8Y6GlCu6FWO//JNM6yZb0BkSxGNF9msmxwtnNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115227; c=relaxed/simple;
	bh=s3azQ8hw9tbONDOE3SHRMvTzgqDXLaEClwuAjV8vnZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulbN86QmhuFEiaIteXRvtFv352sxSb02UzWtG9J/xLjsiR7IYHONhcck4KaGlrarbtrS8UtoqWSyiSt1S2dKKbhsn5KsVEe77EUllwKqGUcyNFB4vGf+Yv86T81gyC8nOB7taR1BOTqGI/MZHxfK9F9PEgBDmbKukPLbhYaH/Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IVexsGSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838CBC433C7;
	Fri, 22 Mar 2024 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711115227;
	bh=s3azQ8hw9tbONDOE3SHRMvTzgqDXLaEClwuAjV8vnZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IVexsGSje2RXC0xRat8lqPLOX9S0ZFGeT6dF1V+6QH1rtqCDW+uNwpQBVok1r26yD
	 7wEmS1Otg+YNp+pjfOVh+ZpAI1tD81+IUz9ntpA4jzJWOUhle99drUtrY5wgcqtrJn
	 YoZYrgA7Y2s+zUYwB3UsQ6yMWYdBMluby9K5Iazk=
Date: Fri, 22 Mar 2024 14:47:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-modules@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: silence warning about unused 'no_warn' variable
Message-ID: <2024032224-equator-calm-5f3a@gregkh>
References: <20240322132014.906097-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322132014.906097-1-arnd@kernel.org>

On Fri, Mar 22, 2024 at 02:20:05PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The sysfs_create_link() return code is marked as __must_check, but the
> module_add_driver() function tries hard to not care, by assigning the
> return code to a variable. When building with 'make W=1', gcc still
> warns because this variable is only assigned but not used:
> 
> drivers/base/module.c: In function 'module_add_driver':
> drivers/base/module.c:36:6: warning: variable 'no_warn' set but not used [-Wunused-but-set-variable]
> 
> Add an explicit cast to void to prevent this check as well.
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Fixes: e17e0f51aeea ("Driver core: show drivers in /sys/module/")
> See-also: 4a7fb6363f2d ("add __must_check to device management code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'm not entirely sure what bug the __must_check on sysfs_create_link()
> is trying to prevent, or why the module loader code is allowed to
> ignore this. It would be nice to have an Ack from the sysfs maintainers
> on this.

No, let's fix this properly and unwind if we can't create the link.  You
are pointing at something from 2006, so I guess we always thought "this
can not fail" and never did anything about it since then.

thanks,

greg k-h

