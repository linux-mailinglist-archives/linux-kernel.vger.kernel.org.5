Return-Path: <linux-kernel+bounces-53283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 664D384A30C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BEA287FFF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889B14F88D;
	Mon,  5 Feb 2024 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZrZtegeB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21C74F5EC;
	Mon,  5 Feb 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159774; cv=none; b=Bmo4FdBqRb3SjjKH+D0Dq4f7iutPa5N7Be+DTPWHEcf+AKJYX8yjelBsrlCN+ppEU85LxJwUdsN13KX26lq9zLybP1dQD71TvZiRPHdsJJ4NPr92HLXZxfBFL94mAsmJcWUcPntHLmpJ2EscPfWO2bdjANRBZ106tuBSAeuRO4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159774; c=relaxed/simple;
	bh=ahF3cXBPBvE5YZU15bdesla+Jh6D/oIfrgvYM6Qeb0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isD/rcrYaZ4GROUnDvlU//2hzuBvI1pampqCJAdxFadLZ9P9iaEjLkiU5GVG0QDJDZWanoSNLFO+Ae+L/wCLQBASw7f8SxjpFOttBZULeZ3OS+kkCmUaymxtnaGPE6bJtZFRrZcT8W8gvRnkMDsZ5Lh0B/Xwa1k8ZDpxgVi7e38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZrZtegeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C3AC43390;
	Mon,  5 Feb 2024 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159774;
	bh=ahF3cXBPBvE5YZU15bdesla+Jh6D/oIfrgvYM6Qeb0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrZtegeBayuKkF0bB0DxpdnHBuUK5zGgzGoIb6Mt3pBKch+121QLo9D7o4H5CPP/W
	 VhAhLuX5WWtR5WOQ5kk2dJ2MgpY3oecsqYCNFeGOskL5kNO9U4F93yQ4gpZmSwYfn/
	 dZj/3y0WcAmjMWGfDgCXwHGiPOQRCoi0BfcH5NaY=
Date: Mon, 5 Feb 2024 04:45:59 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcma: make bcma_bus_type const
Message-ID: <2024020554-caption-elite-ba36@gregkh>
References: <20240204-bus_cleanup-bcma-v1-1-0d881c793190@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-bcma-v1-1-0d881c793190@marliere.net>

On Sun, Feb 04, 2024 at 05:57:23PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the bcma_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

