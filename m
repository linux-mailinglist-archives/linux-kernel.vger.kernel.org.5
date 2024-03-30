Return-Path: <linux-kernel+bounces-125610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398E689299C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 08:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A46283288
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 07:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BF179D8;
	Sat, 30 Mar 2024 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hsmzPOv9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E9C15C9;
	Sat, 30 Mar 2024 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711782122; cv=none; b=aYEnm2lRH7GefgRv9/vGa7UdE4oimmT18SjFkzzIVuuNdfqxSvJ+1pLXixAmaptRwvI43JgQKDkzBhtCMsnoJr2tPULpx99DIsRWwbu2dg/geRy0p2pE0ov7eFEo29VlUTuH643Pqfnor/1aknBDx7o+6oZRkNzKjrc24EirpuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711782122; c=relaxed/simple;
	bh=O4wckmnDJN6tmHm/co3JNjiGRyBlU/oyI7RcHQ5Ak6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0+L1WxEOspsHuos912Zl1KYlOZlRrerg8Y4m/olYU2JB1u+bePzP8gDvxTBPHBYnPKqe9wpyqLzEYcrg6I/2hmjVBNM4oe3xgfAS2NULkJ80IiZ71BZR70ICTuyWkLrUv9uxcETI22QdFkfTxzQasa66tqvQv2SHkgNHLegQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hsmzPOv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A319C433C7;
	Sat, 30 Mar 2024 07:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711782121;
	bh=O4wckmnDJN6tmHm/co3JNjiGRyBlU/oyI7RcHQ5Ak6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hsmzPOv9su16zl407BXCQi1S18XVGnKG4dLtikfKI7oobxpHk13sQDub3szzO7sk1
	 A6wGiHkn+y/lcOVXTWjFNjz6P5mlcE2VVbxhu4LrxpxDL6nT3tlsJhh35K8HdezNJk
	 28V8JsVegoWOGlBpnEqHX32F3CLXFyIFqHcydH9A=
Date: Sat, 30 Mar 2024 08:01:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: huangchenghai <huangchenghai2@huawei.com>
Cc: zhangfei.gao@linaro.org, wangzhou1@hisilicon.com,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	fanghao11@huawei.com, shenyang39@huawei.com, liulongfang@huawei.com,
	qianweili@huawei.com
Subject: Re: [PATCH] misc: uacce - add the null check for the input pointer
 and its pointer members
Message-ID: <2024033032-catalyze-clip-cc53@gregkh>
References: <20240329062655.3055646-1-huangchenghai2@huawei.com>
 <2024032946-supernova-unstaffed-63ec@gregkh>
 <d6890b98-2f75-4077-b7bc-e995e9901574@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6890b98-2f75-4077-b7bc-e995e9901574@huawei.com>

On Sat, Mar 30, 2024 at 11:34:24AM +0800, huangchenghai wrote:
> 
> On Fri, Mar 29, 2024 at2:34PM, Greg KH wrote:
> 
> > On Fri, Mar 29, 2024 at 02:26:55PM +0800, Chenghai Huang wrote:
> > > The uacce_alloc() is the member of the EXPORT_SYMBOL_GPL. Therefore, null
> > > pointer verification is added on the pointer type input parameter and its
> > > pointer members.
> > I do not understand, why does the export type matter?  Just fix any
> > callers to use this properly and send proper parameters.  What in-tree
> > caller needs this?
> > 
> > thanks,
> > 
> > greg k-h
> 
> The interface defined by the export type seems important and the input
> parameters need to be verified.

The export type does not matter at all.

> But I understand from your mail that this is the job of the caller.

Exactly.

> By the way, I still have a confusion. Interfaces like ioctrl, debugfs, read,
> or write require parameter validation. so what kind of kernel interfaces require
> parameter validation? Is there a definition?

Some do, some do not, it depends on the situation.  If data comes from
an untrusted source (i.e. outside the kernel), then it MUST be validated
(remember "all input is evil"), but if it's from within the kernel,
usually it does not.

thanks,

greg k-h

