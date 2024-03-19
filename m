Return-Path: <linux-kernel+bounces-107188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E710487F8D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24ED71C2189E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C30A53805;
	Tue, 19 Mar 2024 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E/EBz4TP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EF5537E4;
	Tue, 19 Mar 2024 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835436; cv=none; b=lLpbG/r1KlsBsRl8GF3HScK+D1iPjvCktQUwbeEt3xGhci9Z4GiRJApUSzrzBR9yfKp6/aTyYGYnWhsJHYlRRFc2m9B7UOUZi0k4bnu+aVbbMOpvlRV7QalhPjWpnCWkBAGp3lqrncdNmj+hbVy67hscHAOfWmxNLctAi0orumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835436; c=relaxed/simple;
	bh=5pMIwSL+oFaceFU0q+VQ+fxw61PUaymJCTKh5tTE8EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufFmRhevwMl345ve92GFkt44CTxKQhkK+Df6Z1Xc709zjsfcOgOLH/XrmBy43z+hd4uXVdScxnk8EZrRY3XbjI1NeJ7YcgtkXF4pISzcWbTIUPRo2rmofEeM8YdnNxYL2uGt1HpJK+fkQJoZh6XBwPQdgR0it3ohyO6a6Q84Ktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E/EBz4TP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AADC433F1;
	Tue, 19 Mar 2024 08:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1710835436;
	bh=5pMIwSL+oFaceFU0q+VQ+fxw61PUaymJCTKh5tTE8EM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/EBz4TP05UV76e4ihRit4qedT8ItYeorbvPeugThFfi2vX7De3TcITjKglIRY95g
	 pJ/Y5enNynI/uF0nTfb6yYOtekimQnUsV0TOLka5xF7KbGrOFd/ntpt2LkEtbaosGG
	 Hdwbs8A4i7UQhNFQgQVinlNIVhnyLYoMgbvlwD6o=
Date: Tue, 19 Mar 2024 09:01:32 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Marco Pagani <marpagan@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Alan Tull <atull@opensource.altera.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: Re: [PATCH v6] fpga: manager: add owner module and take its refcount
Message-ID: <2024031906-radish-handbrake-93b4@gregkh>
References: <20240305192926.84886-1-marpagan@redhat.com>
 <ZfkOvXslEjgU+fc1@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfkOvXslEjgU+fc1@yilunxu-OptiPlex-7050>

On Tue, Mar 19, 2024 at 12:04:13PM +0800, Xu Yilun wrote:
> On Tue, Mar 05, 2024 at 08:29:26PM +0100, Marco Pagani wrote:
> > The current implementation of the fpga manager assumes that the low-level
> > module registers a driver for the parent device and uses its owner pointer
> > to take the module's refcount. This approach is problematic since it can
> > lead to a null pointer dereference while attempting to get the manager if
> > the parent device does not have a driver.
> > 
> > To address this problem, add a module owner pointer to the fpga_manager
> > struct and use it to take the module's refcount. Modify the functions for
> > registering the manager to take an additional owner module parameter and
> > rename them to avoid conflicts. Use the old function names for helper
> > macros that automatically set the module that registers the manager as the
> > owner. This ensures compatibility with existing low-level control modules
> > and reduces the chances of registering a manager without setting the owner.
> > 
> > Also, update the documentation to keep it consistent with the new interface
> > for registering an fpga manager.
> > 
> > Other changes: opportunistically move put_device() from __fpga_mgr_get() to
> > fpga_mgr_get() and of_fpga_mgr_get() to improve code clarity since the
> > manager device is taken in these functions.
> > 
> > Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Marco Pagani <marpagan@redhat.com>
> 
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> 
> Will apply to v6.9-rc1

It is way too late for -rc1, sorry, this needs to wait for the next
release.

thanks,

greg k-h

