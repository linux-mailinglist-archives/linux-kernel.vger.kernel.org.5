Return-Path: <linux-kernel+bounces-59228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB7984F379
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6381F21976
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E842562C;
	Fri,  9 Feb 2024 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uWygYwpa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8A02555B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474722; cv=none; b=FcHXbi42T7zv6D3/b5JEIvO30KUsfTbrobOQEn/Q6ydhrRVPuNeUl4Tiyrq2NMy/ZFeV6BYppRRtOZAvBGu/S4Yq1p4/EDKhmOfAcPn2dR32sGD7ut5a+pIp+53HiXw0FqOBbTDiLgq049Fi0emfiLZbFTWWU3Qr1VqWIaL5/9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474722; c=relaxed/simple;
	bh=YGV84fbxGcSfZljmOuf067yhtk1mp0qRWbqf7FbgX8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNKh1zUyvmFbSr+UyM4zsb8lXTqZL0RCD/oPmArcEoWUYX9aq3KFuWME7iVAkbVLo1OG0SjFRJFm3DjSuWYx2/8WnzAiqPmlo0bdlzCadRjGzxh5K/hAyiuJlxh09HzwH7Pv+P6wTxQ5wUIfpFfYtzwJrGkDxnMoPx0MZX8/vh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uWygYwpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2871C433F1;
	Fri,  9 Feb 2024 10:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707474722;
	bh=YGV84fbxGcSfZljmOuf067yhtk1mp0qRWbqf7FbgX8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uWygYwpaHf8hfT//1gHqaoHa+UJJ5Y4XMscp+4WsilVxnlc2lIF5YzXr01yk5j4Ra
	 rBW2B5NYIa2GzmiwzbStZk/Dq0XVRT9xqZY46N4f6aJ/iSmvyQZFafAWq2WDBIiwVm
	 l5rhd/g6q1G7tw1JKdsQdSjAE1Yg6xRNd5KcYhSs=
Date: Fri, 9 Feb 2024 10:31:59 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
	Alistar Popple <alistair@popple.id.au>,
	Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsi: core: make fsi_bus_type const
Message-ID: <2024020948-xerox-exhaust-fb35@gregkh>
References: <20240208-bus_cleanup-fsi-v1-1-0f13d4a4f920@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-bus_cleanup-fsi-v1-1-0f13d4a4f920@marliere.net>

On Thu, Feb 08, 2024 at 05:05:29PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the fsi_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

