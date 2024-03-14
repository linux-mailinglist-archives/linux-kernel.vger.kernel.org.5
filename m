Return-Path: <linux-kernel+bounces-102740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1E687B6C4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E8A1C21907
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E0C523C;
	Thu, 14 Mar 2024 03:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u4eZFYqP"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9624696;
	Thu, 14 Mar 2024 03:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710386223; cv=none; b=WzTdb1We6fDsDIp+z2L4mry/XnwKmSS299Zu5LN5hYEFgC6ZpT7f7rU2ahhc8BMtmLm9tQqRNqDqguRyhMXIEFkPNE+XWofqFuBp7KGTPyXiq5gJh7hiJClaj5Yfn9LMs+cL7hDewVuTMVDxtUvWP7QmyYimf7j9lOdypKti4DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710386223; c=relaxed/simple;
	bh=2RUoR0XMlC0ukB2bDbtp4kG2XgPkgjcgNCItE8TpMIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2GD/K3mplowWhQF+FXprxjGoK53wTRrGcweIE67gTQ3KnqQXqr8MwNsojqe/VF/EmIrjQf6GH8iyaQq+C4g0m3G4fgNa3LPIaT6UoN++MHMI7SOkQ6TiZJOvoi7MnJT1HVh5WkeIhMSta+UQGkr8vLQ3SayLjVcEKB9G2qB34Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u4eZFYqP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kxI3PC1lCYf7lGzHYrEtRXfRT6nj6eYre9CeqNN6v0Q=; b=u4eZFYqP5qA3mh07q4/0qd8O9l
	NhgN/gjtMEfqEHaeH3XNbj4GtIhPU3B0JbOW7syfBZ62PsWvu9L+WpS6sjB01l40Vpd6DDwT/1lkf
	2TXgwVwKerLfQemomJNf370Q6rnwnf0TT66UpjVE32Ql8AUU6r7sPxJarAzMax4N+TMs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rkbb3-00AHd5-3z; Thu, 14 Mar 2024 04:17:33 +0100
Date: Thu, 14 Mar 2024 04:17:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: isdn@linux-pingi.de, ricardo@marliere.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] CAPI: return -ENOMEM when kmalloc failed
Message-ID: <022e6eb0-2fc7-4115-b5b8-046084d845fe@lunn.ch>
References: <20240314020103.54049-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314020103.54049-1-jiapeng.chong@linux.alibaba.com>

On Thu, Mar 14, 2024 at 10:01:03AM +0800, Jiapeng Chong wrote:
> The driver is using -1 instead of the -ENOMEM defined macro to specify
> that a buffer allocation failed.
> 
> drivers/isdn/capi/capi.c:154 capiminor_add_ack() warn: returning -1 instead of -ENOMEM is sloppy.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8522
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

The patch itself looks reasonable. The caller only cares about is the
return code negative or not. So returning -ENOMEM or -1 makes no
difference.

Please take a look at:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You need to specify a tree you want this merged via.

If you consider this a fix, you need to add a Fixes: tag. However, i
don't see this patch meeting stable requirements.

If this is just normal development, net-next is closed at the moment
for the merge window. Please repost in two weeks time.

    Andrew

