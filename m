Return-Path: <linux-kernel+bounces-53412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD1D84A3E7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6311F245D9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0363C130AEA;
	Mon,  5 Feb 2024 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kmzsR4Zy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210EC12D170
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159813; cv=none; b=tWXz99nv1ARcF6+zCwoHzpT67eIyw+EpVmm1A27bRheRuWFRAHM37u1hpIsLTuufp5A7l6nlfiuzHMqArWlPuTqvLYVDG6RzkcY500iiplENujdn5UR2RnCU6oCsNhhOXUFzT72/0yomz7hgh0cVU4pbMJeNYVKk9wmFOtT6Jm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159813; c=relaxed/simple;
	bh=UaPeS5mSvUaoCPnWbEINPK01Kr+ZY3YUWtrlVXmWEkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVt4zczFqjStPQYIO5fF6zSl/1p6Ga/VvGQjv22wFYzsdqyjIiWCo0CEnZ3NkAfBNcwGiNvjGekf93EJLmJMZ3RgQLhY0+Ur4Rkpb3LiDMFHJ0dkMDkrM4nJRuzN1tPC/RCFBvNzQAdfRa9PuCjOQvib4O/xgfngyIIecyZ5Da8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kmzsR4Zy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8F7C43399;
	Mon,  5 Feb 2024 19:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159813;
	bh=UaPeS5mSvUaoCPnWbEINPK01Kr+ZY3YUWtrlVXmWEkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kmzsR4Zy+XtULK3+ROVpXQLtEE0QNO/w0C27TelaDnrCS6Hmi7gU9kMrU/jFy7NcL
	 TbVzdzlc1bdMsQryMhsVqnZbploOK3HJt+LyvYt9RisbVB24yOKLMawlscqDvfuKXS
	 B2JuckamRO2LPsnpRMChCKwIDPOp+qpR90wbSF/g=
Date: Mon, 5 Feb 2024 04:48:29 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Christian Gromm <christian.gromm@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] most: core: make mostbus const
Message-ID: <2024020525-playhouse-choking-7ed6@gregkh>
References: <20240204-bus_cleanup-most-v1-1-f5cd9a06e13f@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-most-v1-1-f5cd9a06e13f@marliere.net>

On Sun, Feb 04, 2024 at 05:13:16PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the mostbus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

