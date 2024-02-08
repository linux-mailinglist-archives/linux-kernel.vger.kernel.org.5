Return-Path: <linux-kernel+bounces-58051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA1784E0A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C1ACB25B07
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0B874E16;
	Thu,  8 Feb 2024 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e3hP35XR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D2371B42;
	Thu,  8 Feb 2024 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707395139; cv=none; b=CSeseeEWsWTU50TU4e0YDOGvHVrr2cZAzFlWd5smrIHSz0sEQhryD98NOlBBrz+2lDSmRmaJrjBr02iVvd32E02lniI7hEvxkcyAh//I6kaLUXnGp205mWtFt4X8bsxcoABwX9UEUDQiVvg71d8byt6XWPJOqoCM6jxgB88hUJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707395139; c=relaxed/simple;
	bh=9H5mP1XCA6qgfYEa2Bn2GqxzNqk7qjsmd87V5rZipKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRtZAFL7svqIDgOrka1+pnXJ9t43TwPYv6iRxXiJExbb7Or02pZ8OD+6sxO4og1SHNE+jNYyakohm5GSDZhWkxZn6RPoTVx6JiSh+4UkU2gKH2a6pI/mNkam2ZQheZNhr5mND0xxbKUmVe8JgV/kgmtFb4T0aLZI2YCA4GhOAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e3hP35XR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D129DC433C7;
	Thu,  8 Feb 2024 12:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707395138;
	bh=9H5mP1XCA6qgfYEa2Bn2GqxzNqk7qjsmd87V5rZipKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e3hP35XRPLlwc0fCAT1TBNIYTSgfTyYQTozdlJ+CtQIP7hIDiEL5igTfp6Zjc57kG
	 t5Ordj785+adToLTKVVcWaSIT/xfbtRZGmxJJpNNiV3WNqrUmR8zRUD59vLHVQl/Zy
	 3dvKAp5rYB+M83Qv6HLVTEDjwuKrx2mMdSlMQxeE=
Date: Thu, 8 Feb 2024 12:25:35 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, rafael@kernel.org,
	syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH riscv64] kobject: fix WARNING in input_register_device
Message-ID: <2024020821-quintet-survival-54f4@gregkh>
References: <2024020812-snowbound-version-6bfa@gregkh>
 <tencent_6C6ACF8878B26D482FE56F649498E90EEF0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6C6ACF8878B26D482FE56F649498E90EEF0A@qq.com>

On Thu, Feb 08, 2024 at 07:37:56PM +0800, Edward Adam Davis wrote:
> On Thu, 8 Feb 2024 10:56:00, Greg KH wrote:
> > > The input_add_uevent_modalias_var()->input_print_modalias() will add 1684 bytes
> > > of data to env, which will result in insufficient memory allocated to the buf
> > > members of env.
> > 
> > What is "env"?  And can you wrap your lines at 72 columns please?
> env is an instance of struct kobj_uevent_env.

Also, why is "risc64" in the subject line?

confused,

greg k-h

