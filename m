Return-Path: <linux-kernel+bounces-132043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CAE898F0F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F29B21BFB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E19F134426;
	Thu,  4 Apr 2024 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJq9hjHK"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983C6133419;
	Thu,  4 Apr 2024 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259089; cv=none; b=R/kgGwxLEMrNIco8e5KJyua5LQ8rh+E08Jz144PzZvnV4laZ4xXiXCGF5x3Bm0opwlqvwXTiFAad9p+ch/h7UZWx7IcEqjDyyTOAJ5yR+HHqpkCODOTy6WbmAL2TZUzq2N3FsvM042UQaRAxUAXSQAhIHuvxnFYWMTwUYhj904E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259089; c=relaxed/simple;
	bh=iM3i25pNxk7MFpTNFrE9HeruXtREtfbbpD0ry393lEs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TkX9mZl/XVFqk+BVWlgqZB371HDUNJ26GnUmk09qxcIyi8ZmjR8edMhdYWpuziz+EzF3BPdN9mAYtRAkB2TdWZH1Pi2LJ2GIkBn7+s35vJ7EZ0j3uQL2CoAxxiwW3EBl7vvZ28wJKxngc/Wvrl+W5wYPx75jYNDR43LLmjzgnV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJq9hjHK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4162dd23df5so322915e9.2;
        Thu, 04 Apr 2024 12:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712259086; x=1712863886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eO1/J0Yje7Em+OMu/DeZk4R9Llsjy7pakAEzgykzDc=;
        b=IJq9hjHKKE58m+2UrYWNrZRxg/BlwXPpRw9gT/lKDXYPBFWVopvpw0FjPhzc/G9/TL
         aw8i4rq0Ir8h3ERzlEpHVBa4gtGj4KQe/ijqL4w/RYCa8NIpwvekdv6MTswHv0+7TGMZ
         c+IastDRFpaaubrq8Rp61UKPNKcnDwAeloavmhBa8fN3YWoQ9TRANqgkwdIHsYYOIZ07
         eLwSxRfIC9h1xHRSBksK38x4einVFEnbzIjqlmYRmWjdYNurVb0xcpNJGQMOil+g+peq
         6C0Tw4HgzrwXfXjaOPbIFXyBcgPEy/dFZS3H+LmEZyMKdvS//AEV8y8rnbn5rdB7DPH8
         wiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712259086; x=1712863886;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eO1/J0Yje7Em+OMu/DeZk4R9Llsjy7pakAEzgykzDc=;
        b=vmIW4ZAImkmNAPCRzJGG3OR+nwKUwztWxnaRCRtOHOV5OKYi/DmSwXGGa2Bw4xymI6
         es3ZLRP70VeMblyscXuTVLHageQm6kBZaY67ijRycrRhFTyt20V75uz1cTfARlj/rJU2
         KjwJSrun9fdFNGqGi6fkrxxosAVjSzaCtrMqfCWh/HqL/QGwd2o1+BDYPhEIlvztGKtY
         PBGSCUqIyfmQJkjHOhJelQ/KVTgUkGECg4OMZA+uX1bWWqNfhpgTVnMfsS/XL5vlDkEU
         YxJdjyIpnoOT8CT+vqURWQnomFXdt14RL1D7WBv4XyzQ/PR6UH205HniD9o2htpg5Pzg
         fESA==
X-Forwarded-Encrypted: i=1; AJvYcCVuXSZD7FsxPWqPD/heI3/CXnoQQpa1CBqYnSK/xtOMCURB+mZfMx+Tr5+ewOLfo28Zrm+V7mMvvOU8v41P5j+8mbQgC4AhTTdDKYHMgBFVAjPF0HrEDCC+qeON8W6boCBp3Yyk
X-Gm-Message-State: AOJu0YxNj8lgidje8vSdAf/BYeGzqYvmscVyXVc6ca2DOBIOLVw6ltyF
	e5TdI+ct7O/DMN0GUcQ3lLw8WBD+hCBNOPyRl+/z/okx5mnMZM4j
X-Google-Smtp-Source: AGHT+IG7ZVywsfTWEb2ciSoldrzNl+Vhiacwyn9iloTkli9hJk84kG0jPHbFyc5iaswHimiMzAyNZg==
X-Received: by 2002:a05:600c:252:b0:414:8c06:5c32 with SMTP id 18-20020a05600c025200b004148c065c32mr3219978wmj.14.1712259085798;
        Thu, 04 Apr 2024 12:31:25 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b004162d0676cdsm186098wmb.29.2024.04.04.12.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 12:31:25 -0700 (PDT)
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
References: <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG> <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184055.GP946323@nvidia.com>
 <83025203-fefb-d828-724d-259e5df7c1b2@gmail.com>
 <20240404183305.GM1723999@nvidia.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <1bb526d4-31ac-b25d-e494-ef5adbaef7ac@gmail.com>
Date: Thu, 4 Apr 2024 20:31:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240404183305.GM1723999@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

 disclaimer.sh

On 04/04/2024 19:33, Jason Gunthorpe wrote:
> Uh no, mlx5 already has an excellent in-tree driver, thank you very
> much.

I was referring to *mlx5ctl*, which is not currently in-tree, which
 is why this thread trying to add it exists in the first place.

> So, it is really some kind of extremism to say that allowing users to
> configure the device in their own system in a booted Linux OS instead

Um, nothing upstream does is stopping them installing an OOT mlx5ctl
 driver, *if* that's what they want to do.  Clearly some of them don't
 like that solution, otherwise we wouldn't be here.

> of in the factory looses the "implied engineering benefits of open
> source".

You're looking at the wrong point on the causal graph.
Whether you apply the hacks in the factory or at runtime, their hacky
 design is what prevents them from having the benefits of open source
 (because those benefits consist of a development process that weeds
 out hacks and bad design).
It is just that the latter case, if done through an intree driver,
 would appear to be (and might be marketed as) an open-source developed
 product, which users would naturally expect to have those benefits,
 when in fact it doesn't.

>> So because your engineers can't design clean, orthogonal APIs for
>>  toffee, you should be allowed to bypass review?  Sorry, but no.
> 
> Overreach. The job of the kernel maintainer is to review the driver
> software, not the device design.

Really? [1]
The kernel always has the choice to not support a given device, or a
 given feature of a device; and kernel maintainers are precisely the
 people with both the right and the duty to make that determination.

> If you had read the thread to understand the issue, you'd know this is
> because the distros have turned on module signing, secure boot and
> kernel lock down.

Funnily enough, I am aware of that.
And if your customers didn't want those things, they'd be quite capable
 of forking the distro to undo it.  Several hyperscalers already have
 their own in-house distros anyway.
They could add their own signing key to the kernel, and sign your ctl
 driver with it.
They could disable lockdown, or patch the kernel to allow your
 (hopefully signed and IMA-ed) userspace tool to do its PCI-over-sysfs
 crap even when lockdown blocks it for everything else.
But strangely, there are people out there who trust the upstream process
 to ensure quality/security/etc. more than they trust vendors and their
 "oh don't worry, the device will enforce security scopes on these raw
 commands from userspace" magic firmware blobs.

What you are asking for here is a special exemption to all those
 requirements and security measures because "just trust me bro".

-ed

[1]: https://wiki.linuxfoundation.org/networking/toe

