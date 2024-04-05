Return-Path: <linux-kernel+bounces-132454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D9C899510
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153051C229A1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCA855E55;
	Fri,  5 Apr 2024 06:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2DxURgT2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47978288D7;
	Fri,  5 Apr 2024 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297356; cv=none; b=V/BQXtHjfOgUvhKgDM+ZpZBYndkpCL0jNKB5OkeW4yA19eyXm/QLHYqZOfsSZUpnCpfm4iIezMefkn7BdybdmTbAMJmGZWr1XK8RlDqqvAHkmNJFZmjgLUnssfQ/jLL6na0x+T1qAmRd8BicGKnOccvasATqardg4C3YI4qRVCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297356; c=relaxed/simple;
	bh=Ax4sJ6lM/7okBNB/kwtUl/CrqrB9SAf0EvUEBFTadgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bc9RgnpYlJ1XnfPmK5osm2ysBKujQBcEwqTq4sdfQn860v20gBT+xcuNxtIFynvEgP3wYfuUTVtqlv3TkDN+7c+iTAs5uAHHsrn8lLFtuX1rWw/Wrkzf89rd9UCs5xvhxdIbYmGQj4QGsJbB4NIcrA2HiVEzWxAgO5Ui26+2jMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2DxURgT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FED3C43394;
	Fri,  5 Apr 2024 06:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712297356;
	bh=Ax4sJ6lM/7okBNB/kwtUl/CrqrB9SAf0EvUEBFTadgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2DxURgT2rBCom3wbTDMzwKzGgTgPDVe5D2b7G7NxfCNQQ3fCaK6mmf/X+xy9oAt6Q
	 zk+Y0PoCPYdVT8g2/0OfOHrQE8nseBbcmIF8jZrLDcRI/hnOkO6zd+HHMZ74fx9xe+
	 SrkaI5YuK6qAH1itk0CtCTT4h9U9RcxVzLw73V/4=
Date: Fri, 5 Apr 2024 08:09:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	linux-modules@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] module: don't ignore sysfs_create_link() failures
Message-ID: <2024040558-animation-express-1ae1@gregkh>
References: <20240326145733.3413024-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326145733.3413024-1-arnd@kernel.org>

On Tue, Mar 26, 2024 at 03:57:18PM +0100, Arnd Bergmann wrote:
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
> Rework the code to properly unwind and return the error code to the
> caller. My reading of the original code was that it tries to
> not fail when the links already exist, so keep ignoring -EEXIST
> errors.
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Fixes: e17e0f51aeea ("Driver core: show drivers in /sys/module/")
> See-also: 4a7fb6363f2d ("add __must_check to device management code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v3: make error handling stricter, add unwinding,
>      fix build fail with CONFIG_MODULES=n
> v2: rework to actually handle the error. I have not tested the
>     error handling beyond build testing, so please review carefully.
> ---
>  drivers/base/base.h   |  9 ++++++---
>  drivers/base/bus.c    |  9 ++++++++-
>  drivers/base/module.c | 42 +++++++++++++++++++++++++++++++-----------
>  3 files changed, 45 insertions(+), 15 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

