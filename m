Return-Path: <linux-kernel+bounces-120447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D164588D799
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884171F29A49
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0666932C92;
	Wed, 27 Mar 2024 07:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CIv7bUYu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8682E84F;
	Wed, 27 Mar 2024 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525493; cv=none; b=j8RxJZheyB0+8mnaQ2/hcHIaTv4wyTd98GEJsIGi0X1AM2kzDumSZm6P4D7GDIIOFc6O4fwdcRkB0KgUSsRh5cKaqfZiFz2JL7AmjMRAaOcbkZTaC6ddjf6W+7YePVTQvMaiqrflMoCk/gl9+EYy+pz5cNNC7Mpy8naad/ibRAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525493; c=relaxed/simple;
	bh=Vo4tpCBhH8KPWILqOFDHjrb/brtS1Awao540EB/KPuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csuwJwZRFNTtPxp8ZNN1o7g1KElVy+LwEWdSo1YkU56rnY+UQEXq7Uo2Qk5+YqsUEYFund9R2L8ksEkqzyH8kkxH42knb2yFs1bHFL3Md7+POGZZMEXy3B4tS/S7+uRUzOjH7c8ng0qRazUyLPfUuJtP1BEW2r7MSerTDOm15gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CIv7bUYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F61C433F1;
	Wed, 27 Mar 2024 07:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711525492;
	bh=Vo4tpCBhH8KPWILqOFDHjrb/brtS1Awao540EB/KPuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIv7bUYuMv9e1s3cMH9nfYHCAYTvSpkFc9yT8AtQgxaRr1c3NzUjWn/t7SrqhP5bZ
	 LtKGtCJccNCaO6Rqqqa6T1FXB/zyPTFk1Q/XMC8uNNqzhwcdpY9AFMUJqyYyBNNJNW
	 dhruLWIm6Albrld8kCIJy3il66qOYPjTA0bvsfdI=
Date: Wed, 27 Mar 2024 08:44:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Norihiko Hama <norihiko.hama@alpsalpine.com>
Cc: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"usb-storage@lists.one-eyed-alien.net" <usb-storage@lists.one-eyed-alien.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb-storage: Optimize scan delay more precisely
Message-ID: <2024032745-transfer-dazzler-2e15@gregkh>
References: <20240327055130.43206-1-Norihiko.Hama@alpsalpine.com>
 <2024032757-surcharge-grime-d3dd@gregkh>
 <TYVPR01MB107814D7A583CB986884AD4B290342@TYVPR01MB10781.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYVPR01MB107814D7A583CB986884AD4B290342@TYVPR01MB10781.jpnprd01.prod.outlook.com>

On Wed, Mar 27, 2024 at 07:39:55AM +0000, Norihiko Hama wrote:
> > Sorry, but module parameters are from the 1990's, we will not go back to that if at all possible as it's not easy to maintain and will not work properly for multiple devices.
> >
> > I can understand wanting something between 1 and 0 seconds, but adding yet-another-option isn't probably the best way, sorry.
> 1 second does not meet with performance requirement.

Who is requiring such a performance requirement?  The USB specification?
Or something else?

> I have no good idea except module parameter so that we can maintain backward compatibility but be configurable out of module.
> Do you have any other better solution?

How long do you exactly need to wait?  Why not figure out how long the
device takes and if it fails, slowly back off until the full time delay
happens and then you can abort?

thanks,

greg k-h

