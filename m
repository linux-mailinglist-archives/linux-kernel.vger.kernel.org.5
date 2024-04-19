Return-Path: <linux-kernel+bounces-151869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F50D8AB50A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B181A1C21025
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71FC13BC3A;
	Fri, 19 Apr 2024 18:26:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561D413A267
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713551209; cv=none; b=jqfE29sjAXkWCJ0oFDf7WG4SmAcZd7NHlEgfVxE07kEl+HYAOCPA6TuD7X6XTUrOAVSZeezvvRUYV7ISNecrC8Qhg0L5kVjmZX2r48UQAsIWtVOs5qoB7rLDjumV7Bhm4sNvm8EmUVshWfEmUsJ8XDjRssIAa7Xn9QT8SR89N5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713551209; c=relaxed/simple;
	bh=JkzV/wPubppSmIDw/QRFXUAhqhxm/yzPldKOBFdXr6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AR+H5jf9erL7yJOoidhogs70jbdYSqftY3x7722FPo68r8L0tJbDMzcHWJVkvClGNKkvN5P+DtwppPcCPfi2H6+5RBl01xG5w1d3wzefI/H3hs8aQRP60IsKmHPRdQy4Me2xnsJE1YXsquwFDCpcu4etZJOIHrcoXIwDcXwxK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09F282F;
	Fri, 19 Apr 2024 11:27:15 -0700 (PDT)
Received: from bogus (unknown [10.57.84.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DF0D3F792;
	Fri, 19 Apr 2024 11:26:45 -0700 (PDT)
Date: Fri, 19 Apr 2024 19:26:42 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: vincenzo.mezzela@gmail.com, gregkh@linuxfoundation.org,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Julia Lawall <julia.lawall@inria.fr>, linux-kernel@vger.kernel.org,
	rafael@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] drivers: use __free attribute instead of of_node_put()
Message-ID: <20240419182642.b7li4mlnvryephhg@bogus>
References: <CAE8VWiLErhCkD9w+Rbh8mTnRQs-4iJDBrWdVXXFFFDQ3yeTaLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE8VWiLErhCkD9w+Rbh8mTnRQs-4iJDBrWdVXXFFFDQ3yeTaLg@mail.gmail.com>

On Fri, Apr 19, 2024 at 11:16:37PM +0530, Shresth Prasad wrote:
> > Please fix the subject line to be "backlight: <driver>: ...". I came
> > very close to deleting this patch without reading it ;-) .
> 
> Really sorry about that, I'll fix it.
> 
> > Do we need to get dev->of_node at all? The device, which we are
> > borrowing, already owns a reference to the node so I don't see
> > any point in this function taking an extra one.
> >
> > So why not simply make this:
> >
> >     struct device_node *np = dev->of_node;
> 
> Looking at it again, I'm not sure why the call to of_node_put is there in
> the first place. I think removing it would be fine.
> 
> I'll fix both of these issues and send a patch v2.

I assume you are using lore "Reply using the --to, --cc, and..." option
or something similar.

You seem to have mixed up 2 different message ID. I was not able to make
any sense of this email.

You have wrongly used [1] but you really want [2]. I think both have
very similar $subject and hence the confusion. Another reason
why getting subject right is very important on the mailing list.

--
Regards,
Sudeep

[1] 20240419131956.665769-1-vincenzo.mezzela@gmail.com
(https://lore.kernel.org/all/20240419131956.665769-1-vincenzo.mezzela@gmail.com/)
[2] 20240419111613.GA12884@aspen.lan
https://lore.kernel.org/all/20240419111613.GA12884@aspen.lan/

