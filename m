Return-Path: <linux-kernel+bounces-124201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CA48913CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 110D0B224C0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C313FE27;
	Fri, 29 Mar 2024 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YSWhuXv2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B27F3FB83;
	Fri, 29 Mar 2024 06:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694094; cv=none; b=MkSCaBtcmgsHI2oSjn1gSEyFSh+C4jQ+VlPF1FbVu9HYy3XW40i8MCFXbbMzHNkUI19YjtOOoCh194xxjZWk5u268Wol8QdHf1TBsIX3VdSz6xSrUjOIBYsqo7yl0FDQC3Ig051YjoscDnxZE9cSAL52MBfTKKafXjczY3LjLII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694094; c=relaxed/simple;
	bh=JZDd4vTOWg91ZZZdlKhj2Iuf8kbXcTkZgWQyBW9M9bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oG05Lt7UFFjvGGjjZCdd2A+iM3mxYOoPKNwfmKTphuai+jM+eSzUz4HvdtjG/J6P35fKOxeAFe76VGN3LhX2p6cLM+wn0jQyPNLoU+xWlu6xuAha+PSerTZcNk1xO18qIeQdw//K+j2baL2sWKpoRGMcct43CjESPO804KoJMI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YSWhuXv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA35C433C7;
	Fri, 29 Mar 2024 06:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711694094;
	bh=JZDd4vTOWg91ZZZdlKhj2Iuf8kbXcTkZgWQyBW9M9bA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YSWhuXv21YBYdVAQHEohit7APVPxdrYw1NjCJ/Q589Zmt9RI8JDhrsn28T0KOF+uL
	 1VKff0pavugkCoc6CwstGTCfET0pSJ8RJhbAVAXfLKjGhIwhXPVCcC1rU3iHJa2/nE
	 x08+MIDtIIBgVeRQekeRZRA5hvQI/KW4goeipNSs=
Date: Fri, 29 Mar 2024 07:34:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chenghai Huang <huangchenghai2@huawei.com>
Cc: zhangfei.gao@linaro.org, wangzhou1@hisilicon.com,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	fanghao11@huawei.com, shenyang39@huawei.com, liulongfang@huawei.com,
	qianweili@huawei.com
Subject: Re: [PATCH] misc: uacce - add the null check for the input pointer
 and its pointer members
Message-ID: <2024032946-supernova-unstaffed-63ec@gregkh>
References: <20240329062655.3055646-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329062655.3055646-1-huangchenghai2@huawei.com>

On Fri, Mar 29, 2024 at 02:26:55PM +0800, Chenghai Huang wrote:
> The uacce_alloc() is the member of the EXPORT_SYMBOL_GPL. Therefore, null
> pointer verification is added on the pointer type input parameter and its
> pointer members.

I do not understand, why does the export type matter?  Just fix any
callers to use this properly and send proper parameters.  What in-tree
caller needs this?

thanks,

greg k-h

