Return-Path: <linux-kernel+bounces-53457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3608C84A43F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68CB71C24D95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B09C131E23;
	Mon,  5 Feb 2024 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fStOtEwm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4655B134CE0
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159820; cv=none; b=qsVE1vAWDnQwbswEOhLMEJ7+twgEOCQQwdBYsgtCYnFLyDKzqFaJYJQon0WxwmWMFXL28sraJi4RvHx71NsURT0NkutsSo2UK2qti05jms+iRexPeBltLHZYrnEuBurqR5OtvCrPlN4jF4VNkLXS0a1yUqHcpxbVDHZpMpp+2O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159820; c=relaxed/simple;
	bh=mAFr7rgIiDDs3owlqHD04xWyLOAFyYWies7SJEVVNg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfZzXsLim2bLhsjoa/Lp0R1lUb5ny6RadBSk0y9jhE+JmJE3oeERDqBk094ZvBfQb/7GwTpmaDxMGXIIgng6/uO1teSZUWdBrk/9OvKNZ6De6aXmyYeE9Srg9Ls1PUEEuoimJLo0UGeNI+vVT542W0d5qB9NPyq52rA+l3hoNxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fStOtEwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD6EC433A6;
	Mon,  5 Feb 2024 19:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159820;
	bh=mAFr7rgIiDDs3owlqHD04xWyLOAFyYWies7SJEVVNg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fStOtEwmq/3vtDXWgGTswIZccLKGPAheWYpbNTwz05q5e8R+AERwgiw2O1H1Q+973
	 xrZqccko8sJiBxcBx6U5WIecMAC6sKNG9hpzf5MYgWCImG0qtQRjsCUblKHUHukazw
	 rU9HM+7Hx9cOuMu5XkvdGNg+EOBqGnZDxcd403lY=
Date: Mon, 5 Feb 2024 04:48:58 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Johannes Thumshirn <morbidrsa@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mcb: make mcb_bus_type const
Message-ID: <2024020553-overtly-overreact-ed57@gregkh>
References: <20240204-bus_cleanup-mcb-v1-1-d84b2ef51a0b@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-mcb-v1-1-d84b2ef51a0b@marliere.net>

On Sun, Feb 04, 2024 at 05:03:10PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the mcb_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

