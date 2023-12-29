Return-Path: <linux-kernel+bounces-13018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE10D81FE7D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56DC21F23112
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433E610A0A;
	Fri, 29 Dec 2023 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i+ebZHQb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893AE10A01;
	Fri, 29 Dec 2023 09:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A6FC433C8;
	Fri, 29 Dec 2023 09:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703841005;
	bh=ZgKa79LLzP6vIZslFUxfcIsAQWCsAAzIuqv/5/SkYOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i+ebZHQb8M2+duW8p5ZIVBk3J0HimypcUPVvOwh+5SnHbPOXEsqJoB1KsY8HCvzYa
	 QPBf/9sP00l702LU/dWOjP2dqPgflWJ8o+d/yvucSZDMeRX5Ql0AaN5h85BY5IxldX
	 WrRZIm5q9EtVeLVV/17l4uTbWe3/YL1qZiFNVdUg=
Date: Fri, 29 Dec 2023 09:10:02 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC: constantify the struct bus_type usage
Message-ID: <2023122918-tiring-isolating-3f4a@gregkh>
References: <2023121909-tribute-punctuate-4b22@gregkh>
 <20231228150003.GAZY2Nc38sAIa0bat/@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231228150003.GAZY2Nc38sAIa0bat/@fat_crate.local>

On Thu, Dec 28, 2023 at 04:00:03PM +0100, Borislav Petkov wrote:
> On Tue, Dec 19, 2023 at 02:13:10PM +0100, Greg Kroah-Hartman wrote:
> > In many places in the edac code, struct bus_type pointers are passed
> > around and then eventually sent to the driver core, which can handle a
> > constant pointer.  So constantify all of the edac usage of these as well
> > because the data in them is never modified by the edac code either.
> 
> "constantify", huh? Not enough words in the English language so let's do
> new ones?
> 
> :-)

Hey, we could be using German and then it would be something like
"Konstantifizierung" :)

> So what's the plan with this "constantification"?
> 
> Because:
> 
> drivers/edac/edac_module.c: In function ‘edac_subsys_init’:
> drivers/edac/edac_module.c:80:38: warning: passing argument 1 of ‘subsys_system_register’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>    80 |         err = subsys_system_register(&edac_subsys, NULL);
>       |                                      ^~~~~~~~~~~~
> In file included from ./include/linux/edac.h:16,
>                  from drivers/edac/edac_module.c:13:
> ./include/linux/device.h:75:45: note: expected ‘struct bus_type *’ but argument is of type ‘const struct bus_type *’
>    75 | int subsys_system_register(struct bus_type *subsys,
>       |

Ah, oops, that means this depends on a patch in my trees already that
fix this up.  You can wait until after 6.8-rc1 to get to this, or I can
take it in my tree if you want now, which ever is easiest for you.

thanks,

greg k-h

