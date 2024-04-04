Return-Path: <linux-kernel+bounces-131892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5169C898D4B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEE61F2BEC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB35612F387;
	Thu,  4 Apr 2024 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmhzb0Au"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AAD12C7FB;
	Thu,  4 Apr 2024 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252110; cv=none; b=Sl6Abl5tbvcLxTq354kPG1Q4q6sYyQ5MI0JNtIAJatNBjblDjn72UDX1+cLjy90Fy/GzonhrK2FXrJXgQ17V6u3+MR/pja68oGG5qotcjdmjvMWHzsFZ/9NRb4/a8wDekhHn4CWES6Pd7AjvByG6drjxkckUG6GfoQOaTM2B790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252110; c=relaxed/simple;
	bh=rhsuIjyygBYjXcTcQ9p1bgKNsKZKY3pivftvx6uGje4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FWg/hyKpa60ATOnC8ex6g+EudjF5IiuAF5dJ+MmAhtATWXsDFSiGO5awgcP3MNHePEZja3QRuMCTSVs3pHEb8ZnoghXMhAuQvvtYltEV0e2wH+xT30p/4+pwgLQdbXEFfgtRaTkqBD8CBo+4TWoAebRQLrqI2IIXWGgrwGVnAEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmhzb0Au; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-343b92e54f5so670304f8f.0;
        Thu, 04 Apr 2024 10:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712252106; x=1712856906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkEZmzUX1kGDhrBjq33VrBewg3EmM3UDb6YkmRJyPlo=;
        b=bmhzb0AuxcPFOtKzEpBziys6BT//vNrHDl8FU/0XQ8nh5HVtKsrs7pkERN5mNt3Epy
         5M5QDEDmuEsuPAQlfGT77btkMuxM0dIkNSsVjpJoeL0OTek7cHQV/bmdbliMUEhuxtJ9
         pfH3zWQq9gJWif0x6CCfkyeQ9MkRrOp6oJDwq43wqNMXQ/P+c39hfyPBfeZcGcd8B9sO
         P5jXStRLGxZRY/rAq1NsN+N3McDIk3BS7SETtZvHDo8NCJfe8hsxFCg2Lf0dQNnsgXCy
         oldnHarSHDUR6wlbQiTLtdXGD6tDSNCC+HBflVf5wtQW31rjlbqSZ27B+DTtQojI3CaZ
         GtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712252106; x=1712856906;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vkEZmzUX1kGDhrBjq33VrBewg3EmM3UDb6YkmRJyPlo=;
        b=SXqPnUnAAmHEwbypww4Ky/Z5X85dp8oBEo8EXL62ANDbLfHp+j74VtAb+Cos+hNP0u
         kKbCiktV5cj0W0vJ6hvnLbCsZbhKT689JpOCO5EmUzliNgZXxqFcLkwfkT6DT4jjX3uF
         Cu4Sl2w6fMi3IumMbFE+PWZGnAr4BRx7tH4Z7y2Ce0a557hbQAra3DAR5Mio2uHXQ0bB
         +wu8WglTB3GGG4wUgAd2z7dJ9TUSVivoqF7uUi4okw52DSeQzGnWvAyoZ0s3RnJUC7NB
         YK8eDtdzXeLZ78avDY6dnTyEESxjj6jXqAgWUaHiDWcLlctfVVJgZ1bpe4zkYGX4f+Wx
         aBHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVF5CCySfusB3eiX4gi9p+J8YMs4xEkvf4mKaMQVVJjJqtOvf9z+GyoX1t5CyPaCaNgXPRcfteJuBmecnrYTVaZge6GArWLpGhIWZfvLEml/PQbkRZ1P/NR8Yx0kxIMvbOs3Yp
X-Gm-Message-State: AOJu0YwK4DwO4/jkC+mDHi8PwVv3rczT+DT9pybSWK4Jjm8RhBU08NBN
	jVWAfxRWasgbWTF/KdoysnrCcXhiWh1m9EHhz4k/kMbxiaEI4DIT
X-Google-Smtp-Source: AGHT+IEuxzvBhx/5efmijXtpPh+SbCTmqjT8On9tK8tgF6MMoQLabA4/c5R6q1yvPFOjsdzrn2OMCg==
X-Received: by 2002:adf:fc02:0:b0:33e:ca29:5a3 with SMTP id i2-20020adffc02000000b0033eca2905a3mr221895wrr.23.1712252106393;
        Thu, 04 Apr 2024 10:35:06 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id t12-20020adfe10c000000b0033e9d9f891csm20599056wrz.58.2024.04.04.10.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 10:35:06 -0700 (PDT)
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leonro@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
 Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Aron Silverton <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <20240304160237.GA2909161@nvidia.com>
 <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
 <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG> <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184055.GP946323@nvidia.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <83025203-fefb-d828-724d-259e5df7c1b2@gmail.com>
Date: Thu, 4 Apr 2024 18:35:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240402184055.GP946323@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

[ Again, I had better disassociate my employer from the vitriol below,
  for which I alone am responsible. ]

On 02/04/2024 19:40, Jason Gunthorpe wrote:
> Uh no. Alot of this configuration stuff is to serve niche customer
> interests where the customers have no interest in publishing and
> commonizing their method of operating because it would give away their
> own operator secrets. The vendor's created it because their big
> customers demanded it.
> 
> eg there are configurables in mlx5 that exist *soley* to accomodate
> certain customer's pre-existing SW.

So it's a single-user hack, why do you want support for it in upstream?
Oh right, because you want to be able to ship single-user hacks to all
 your customers while still getting the _cachet_ of being An Intree
 Driver with the implied engineering benefits of open source — despite
 the actual feature implementations being obscured in firmware that's
 not subject to the review process and thus doesn't actually carry
 those benefits.

> There are something like 600-800 configurables in mlx5

So because your engineers can't design clean, orthogonal APIs for
 toffee, you should be allowed to bypass review?  Sorry, but no.
The right approach is to find generic mechanisms that cover multiple
 customer configurations by allowing each customer to specify a policy
 — which is better not just for the kernel but also for your customers
 (they can experiment more easily with new policies) and even for you
 (you don't have to spend engineer time on implementing hundreds of
 single-purpose configuration switches, and can instead focus on
 making better products).  And of course the customer's policy, with
 their 'valuable' operator secrets, stays in-house.

This is not some revolutionary new idea or blue-sky architecture
 astronaut thinking; this is the way the Unix engineering tradition
 has worked for half a century.

And it's not like we don't give you the tools to do it!
BPF demonstrates that the kernel is perfectly willing to expose highly
 complex configuration primitives to userspace, *as long as* the
 interface is well-defined and cross-vendor.
Of course, without knowing what your several hundred knobs are for, I
 can't tell you even in the broadest sense what shape a clean config
 system to replace them would look like.  But 800 magic flags isn't it.

> Where is the screaming?  Where has keeping blessed support out of
> the kernel got us?

Well, clearly *someone* wants you to supply them an in-tree driver,
 else you wouldn't be trying to upstream this.  Now maybe they really
 do just have a psychological aversion to TAINT_OOT_MODULE, but it's
 more likely that the underlying reason is the improved reliability,
 maintainability, and portability that come from the upstreaming
 process.  And that in turn only happens because the kernel does not
 "bless" crap.

> The actual benefit of common names for the individual configuration
> values is pretty tiny.

In case I still need to make it clearer: the purpose of requiring
 your configurables to go through review is not so you can have
 "common names" for 800 magic flags.  It's so that you are forced to
 come up with configurables that actually have a sensible design and
 meaningful semantics that you can define in a way that gives you
 something to *put* in the name and the commit message that's not
 just "magic behaviour tweak #42 for $BigCustomer".

> a second argument about who gets to have power in our community.

As I understand it, power in Linux is entirely social and informal.
If you think Kuba doesn't have standing to object, there's nothing
 *technical* stopping you from applying the patches with his
 Nacked-by tag included in the commit messages, then sending the
 resulting PR to Linus.
And if you think that Linus would reject the PR in that case, then
 you're implicitly conceding that Kuba *does* have standing.

