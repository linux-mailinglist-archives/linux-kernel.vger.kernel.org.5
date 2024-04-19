Return-Path: <linux-kernel+bounces-151036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CCA8AA834
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703A6282051
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA304C2C6;
	Fri, 19 Apr 2024 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z/smkLaD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C8B666;
	Fri, 19 Apr 2024 06:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506805; cv=none; b=ak6dOIv/cL8H1SUtkXI+Y0G/lTLhz0gzw418abTizLrvgh3+hqCjeEFlsIzt7Df29kn91ruS5XMH6CGqJAojSH3YdHMtBgPbKNKbGGUCS5jYzkklNFfo2X2PgXTNvhJx5L2qTsK92RXUsgrWwV22+mxaR5Rdv1WtprJ2wiz/7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506805; c=relaxed/simple;
	bh=7tvuNUi++6C8Vch6H2igX6msqCQ6YI1Wy+cuKDRDr9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Soowe5ay7kp7nzaS7w3AlVskr7XaFhV2yqqTFRQl+8nf/mCFHNx/LMIfsYmg895oZhqgUB1cn3GVaQsnPW2pt8/kVXSvXo3cP3t2aBBS4FRIUStWABAyprtcKvNa8m317H+PFyyu99tPxztH1sUAjThfVCLZQ0WaeL4EHpkhz5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z/smkLaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F55C072AA;
	Fri, 19 Apr 2024 06:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713506805;
	bh=7tvuNUi++6C8Vch6H2igX6msqCQ6YI1Wy+cuKDRDr9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z/smkLaDcQznvq3tn+/PNN/5ghdG+wSUfweoTSNE4CB6M4uWMIr3nAQ9Bch01gn5P
	 87DyFHEZyTaq/cSkPwM9327vo1kYTp2ohKFDy1z6GHpYuLzTT/PFAwj4XuQmNQZncZ
	 RXtp+q2gR3REq6MBYMMaPNLNSuFvLVh4nHi/+L4E=
Date: Fri, 19 Apr 2024 08:06:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Liuye <liu.yeC@h3c.com>
Cc: "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
	"dianders@chromium.org" <dianders@chromium.org>,
	"jason.wessel@windriver.com" <jason.wessel@windriver.com>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
Subject: Re: Re: =?utf-8?B?UmXvvJpbUEFUQw==?= =?utf-8?Q?H?= V11] kdb: Fix the
 deadlock issue in KDB debugging.
Message-ID: <2024041915-flinch-cinema-9c22@gregkh>
References: <ac27269989394d8dac859763bc7578d6@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac27269989394d8dac859763bc7578d6@h3c.com>

On Fri, Apr 19, 2024 at 05:54:58AM +0000, Liuye wrote:
> @Greg KH
> 
> This issue still needs to be resolved, but I don't know how to do it. 
> Please tell me an effective strategy. How should feedback be given to make it effective for you? 
> There is already an approval process for external emails in the current company. 
> And a review mechanism has been added within the team. And internal training is provided.
> The previous mentioned has been completed. What else needs to be done?

What would you want to see if you were in my position here?

Some sort of "proof" that this really is the case?  A discussion with
your company legal group about this?  A discussion with your legal group
and the open source legal community about how they have structured all
of this so that it will not happen again and a discussion about how this
did happen (i.e. a blameless post-mortum)?  A signed-off-by on your next
patch from a lawyer in that group?

In other words, what does your legal group think would be sufficient
here?

thanks,

greg k-h

