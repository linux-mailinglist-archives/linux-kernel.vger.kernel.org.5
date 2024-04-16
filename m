Return-Path: <linux-kernel+bounces-146241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7FE8A6299
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D6E28500A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228DC381B8;
	Tue, 16 Apr 2024 04:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TSIOHs1T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B991642B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713242988; cv=none; b=gOVI8Q8SOMSBULBgsumpmPYYlat54DbyPNk453o5J+Zm1AokghUcSzH3h755kerGSL2ttVCP+4GcAgR27FO7zCXSQtFLBYTMXuoqUsvCmq4HJc69qJA3YMArDt/qXqNKaZHW9OPwQL0w6IPy3IAipUvnv2qKW/8uhmsnF29twb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713242988; c=relaxed/simple;
	bh=aHDljlWTmUinNNo0sb6wTvxH2kECa12PPEoAt9mZth0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbDIYKJyj6Zg/S5zDwa00/Mnf6pmHx6kxoyqer0071RZJ1PpYCZ2p+hDHk6fuS17mymKvoMH4bswLNvr/SvDTReKI+s6Ul8A4lG0wr1Yp7+v9XxaMM/7K9RwS4eT579oXVl6exIi1w7oDT3UFdlnjT3rBo0L/NOCdEis2Qom0j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TSIOHs1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789F6C113CE;
	Tue, 16 Apr 2024 04:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713242988;
	bh=aHDljlWTmUinNNo0sb6wTvxH2kECa12PPEoAt9mZth0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TSIOHs1Tb3oLK0FC+dgPNoBUMjt45XzbszoTX1iqwX7dSALlE1T/PSBsHVx3+Mov9
	 QJiL1veeM0fnyNKIGBM5NbwrCjmoAmdgvpBoDypBx01wiRzLQu8qxgPq4nZOZJP0Tu
	 CtWmSeXNIfsK/iV7J7V+Byj/spCAfz7j+oU+llRg=
Date: Tue, 16 Apr 2024 06:49:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: sicong <congei42@163.com>
Cc: johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
	linux-kernel@vger.kernel.org
Subject: Re: Bug report: greybus/interface.c: use-after-free bug in
 gb_interface_release due to race condition
Message-ID: <2024041624-oxford-sabbath-9f6a@gregkh>
References: <280ee5e5.4936.18ee4d93bae.Coremail.congei42@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <280ee5e5.4936.18ee4d93bae.Coremail.congei42@163.com>

On Tue, Apr 16, 2024 at 11:00:25AM +0800, sicong wrote:
> greybus/interface.c: use-after-free bug in gb_interface_release due to
> race condition.
> 
> In gb_interface_create, &intf->mode_switch_completion is bound with 
> gb_interface_mode_switch_work. Then it will be started by 
> gb_interface_request_mode_switch. Here is the code.
> if (!queue_work(system_long_wq, &intf->mode_switch_work)) {
> 	...
> }
> 
> If we call gb_interface_release to make cleanup, there may be an 
> unfinished work. This function will call kfree to free the object 
> "intf". However, if gb_interface_mode_switch_work is scheduled to 
> run after kfree, it may cause use-after-free error as 
> gb_interface_mode_switch_work will use the object "intf". 
> The possible execution flow that may lead to the issue is as follows:
> 
> CPU0                            CPU1
> 
>                             |   gb_interface_create
>                             |   gb_interface_request_mode_switch
> gb_interface_release        |
> kfree(intf) (free)          |
>                             |   gb_interface_mode_switch_work
>                             |   mutex_lock(&intf->mutex) (use)   
> 
> This bug may be fixed by adding the following code before kfree.
> cancel_work_sync(&intf->mode_switch_work);

Wonderful, please submit a patch with this information and we will be
glad to review it.

thanks,

greg k-h

