Return-Path: <linux-kernel+bounces-93521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF908730F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310091F29DD4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5437DD53F;
	Wed,  6 Mar 2024 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E/3Gm9bQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702185D72D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714464; cv=none; b=PMkGNmuTYCn8slX1WUEbICucHRPK/EIvmFpnRUvNf08+ZqMHJMP6/uPWXtMIEdsKDZLnoKQvoWdpJLXjIABdTYvT0jhwymWcTmcovYXi+gFmCJB7eJvbgux20rtBkVgYYTe6XYqLZUh0WHWFRogv9YrH4WLYtR5tJT2WpJ8xRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714464; c=relaxed/simple;
	bh=zofiWR39A2Rv4tdjSThweKpRQzqgl0O7TlAw/Xr+5zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUEc6EyQT2Y8TjGFb/5iE8JahqO2urKnTvGgcr8UIFNfa7qdl6cKdAySKdYiIUFcW/Op3U2NcdUgpyirPh4jZ1Q5ZRdpJxwuSvSDLgCdGlV5gnUP27eCo+dRF4/7q5O3qrHLVrXi6ESTK8AeEwXrDHzvBEpl0qnOHihhQxXUwRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E/3Gm9bQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2306C433C7;
	Wed,  6 Mar 2024 08:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709714464;
	bh=zofiWR39A2Rv4tdjSThweKpRQzqgl0O7TlAw/Xr+5zM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/3Gm9bQxqOBeEjpp1xGXapSDG413XuzH3NCgG59XxKNQ2mbASgfGYLvLyjM+WsQc
	 xI7nTB2bcxk59/da+EM0apnVqej2PRKZI4LYna+iMJcTvh3oECQc+A8yAZn81KY4p4
	 RVZQOZNYhRTBZMkxvsyxiqmDtx6h9AFRQd5/kCaA=
Date: Wed, 6 Mar 2024 08:41:01 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2021-47090: mm/hwpoison: clear MF_COUNT_INCREASED before
 retrying get_any_page()
Message-ID: <2024030629-evoke-imply-db5c@gregkh>
References: <2024030413-CVE-2021-47090-a429@gregkh>
 <ZedoMIyhF8d_XLIV@tiehlicka>
 <2024030541-unhappily-staff-8662@gregkh>
 <ZegkEqtGcC1p_7Xb@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZegkEqtGcC1p_7Xb@tiehlicka>

On Wed, Mar 06, 2024 at 09:06:42AM +0100, Michal Hocko wrote:
> If you insist this still qualifies as a vulnaribility/weakness fix then
> I would propose a new category pig-with-a-lipstick-CVE.

We don't get to pick "categories" for CVEs, that's what other people do,
and I wish them the best of luck!  :)

thanks,

greg k-h

