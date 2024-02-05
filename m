Return-Path: <linux-kernel+bounces-53626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B09FA84A5F1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE3D1F24DC1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D53718797B;
	Mon,  5 Feb 2024 19:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qbq1KBKh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0D7155F25;
	Mon,  5 Feb 2024 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159842; cv=none; b=S4E46labXn8gOzCAZgPhTjygG/Q9qrZ4AaB3NTWE3F/yzMvb/Yd+kYHhHlV8p/wKQ4H7i8fOgJqMV/RXo5a70E9IS6zaqA4BlyZfw2enZlZ8bpWWLVWb15cHQ5h2dgyzoxd5DW/QHvDU/6pYUGoU0ElFkKIFjFW35dxVLsec2Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159842; c=relaxed/simple;
	bh=ySecDCyg8vuEud4f7aCMlAWM0dO7bI/xCzLq61pslLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGWIpDrXZZL02a5rpzqIbK0KwKiMPTq/g4tV3++w32zd0mUBmv7JDglqPgWhG16uWH9YhPgeH31tUsPalF87mxTzJuM4osPa7Y2ZqBwb5NrbZhbRmdiGp+r23qlfqLDR9wyDsZXZ3Mcf2/yUvyb1zyOMPjmAlWgzGesQlMe13s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (0-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qbq1KBKh reason="key not found in DNS"; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9695AC433C7;
	Mon,  5 Feb 2024 19:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159841;
	bh=ySecDCyg8vuEud4f7aCMlAWM0dO7bI/xCzLq61pslLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qbq1KBKhfDqmCf7jFw+9VxicbynaSh57h1WN1CT3dM0TWLndcLwC1Sy9IUx56Dope
	 /LdU23L9aveVIB5b1drnrl2KzM4pq0OWOBDTzZsUg9wV2SCZX9pj/KLNN+WSo5DIXw
	 VS7gOUmjXZl4KQC5NMrcIVdjtE1mXIWFY5V6tiwQ=
Date: Mon, 5 Feb 2024 04:50:38 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device-dax: make dax_bus_type const
Message-ID: <2024020534-stoic-swooned-0985@gregkh>
References: <20240204-bus_cleanup-dax-v1-1-69a6e4a8553b@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-dax-v1-1-69a6e4a8553b@marliere.net>

On Sun, Feb 04, 2024 at 01:07:11PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the dax_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

