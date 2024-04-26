Return-Path: <linux-kernel+bounces-160162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F5E8B3A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B391C23E91
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CD813FD82;
	Fri, 26 Apr 2024 14:30:17 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A78E32BAF6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141816; cv=none; b=Mc5ta70JfrrydnGuc81t/87oGOO+aBBD0/yyef9J8YLWxwJbCq5JlXCZCprPFfU2Wv/2fgIMUau5zZczEJSLxzSYzzuxHTmVrlTSJEcr7sdVmcAWS95dOfzGXu+fJyXUefF2LgZRFY8uduYY2jxUmlOOgGW7MT6Ve2OZ5eVjGQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141816; c=relaxed/simple;
	bh=1YOGk2Fu8LkkiUHoAmC1Crgo6gi/S7xansJx6h+2kVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwHKP9RLYqPSv4DkcwZO6f4o3u0gqn4/w+jTtlA/rMZFRatvshFf7lDBCPfbyZeQngRK+UWYz9QxsC+RPOLXNLQUuf8H8uMiWDdoZlhB7jr5ao/IWMDFCyDbN3Hodah8vY5sCWFFylvd+50KS6u3MRRdjkL/ZLhWbbxc9ALvnpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 527438 invoked by uid 1000); 26 Apr 2024 10:30:07 -0400
Date: Fri, 26 Apr 2024 10:30:07 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
Cc: gregkh@linuxfoundation.org, corbet@lwn.net, linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH v5] usb-storage: Optimize scan delay more precisely
Message-ID: <6362de20-ed91-4856-ba0c-d0619585f0eb@rowland.harvard.edu>
References: <20240426080231.3062-1-Norihiko.Hama@alpsalpine.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426080231.3062-1-Norihiko.Hama@alpsalpine.com>

On Fri, Apr 26, 2024 at 05:02:31PM +0900, Norihiko Hama wrote:
> Current storage scan delay is reduced by the following old commit.
> 
> a4a47bc03fe5 ("Lower USB storage settling delay to something more reasonable")
> 
> It means that delay is at least 'one second', or zero with delay_use=0.
> 'one second' is still long delay especially for embedded system but
> when delay_use is set to 0 (no delay), still error observed on some USB drives.
> 
> So delay_use should not be set to 0 but 'one second' is quite long.
> Especially for embedded system, it's important for end user
> how quickly access to USB drive when it's connected.
> That's why we have a chance to minimize such a constant long delay.
> 
> This patch optimizes scan delay more precisely
> to minimize delay time but not to have any problems on USB drives
> by extending module parameter 'delay_use' in milliseconds internally.
> The parameter 'delay_use' is changed to be parsed as 3 decimal point value
> if it has digit values with '.'.
> It makes the range of value to 1 / 1000 in internal 32-bit value
> but it's still enough to set the delay time.
> By default, delay time is 'one second' for backward compatibility.
> 
> For example, it seems to be good by changing delay_use=0.1,
> that is 100 millisecond delay without issues for most USB pen drives.
> 
> Signed-off-by: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
> ---
> V4 -> V5: Simplify parser/formatter code and fix documentaion
> V3 -> V4: Separate parser functions from module parameter set/get
> V2 -> V3: Change to use kstrtouint only for parsing decimal point
> V1 -> V2: Extend existing module parameter 'delay_use' to support decimal points

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

