Return-Path: <linux-kernel+bounces-102331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAF487B0CE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35AF91F25B28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBA669948;
	Wed, 13 Mar 2024 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="PvwJJZIj"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE78D6027E;
	Wed, 13 Mar 2024 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352962; cv=none; b=CK6vWpQhbetw6EJ12Du5Vo41haG1Vd/XVUKbeZuOXznaWMW2UvPI7bsE4hP6WCkTBS08DAF7rfb497w8ljZ6orSq8pvc7oEUEwMLfn1TB7LablZjK2HZXnCgtPMo1WdkNc9ew/Yqghsl9hVLu3LeZG0wrHbhenp1WR1FEz7DNB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352962; c=relaxed/simple;
	bh=3Tg8fUT5dEkstMBRfJXr2xPDXXckp1lHdj52ARSGdMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RT9g6kTs5seCOJNZ8Ur5ecQBYWq49nx6tfSqKLXKrqKp8OxOQzBr1Dp9s/woXrkLgsYjzcRw6OeXRgBchFViTyBzRvWPLhARJRwAVmFmMRlOCOLOV9kHI6iBEmEPJnaYwIaWp+2dPu9n+fTzzXIJ9C8GC2QtjKk5Z8H3MwbPjp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=PvwJJZIj; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Tvyz361VHzlgVnY;
	Wed, 13 Mar 2024 18:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1710352950; x=1712944951; bh=3Tg8fUT5dEkstMBRfJXr2xPD
	XXckp1lHdj52ARSGdMU=; b=PvwJJZIjCvMkq/ewCWjgMLmM8HhIyK4gdS4/cdCf
	TOmaaL1p1SxJMi/2QaLRBwgD1nEswS3j9YYxyjAeNQ3OVpwQG3zGC1jo1NHBherD
	iPwxY/gkZsNl4R20j24tzd4466em3P/kjbPAkNBBtwkStXDYWIQ0Vj/qLjRXB8F5
	AU0bBOd+4juYj/jE4mRgkl/uDpiRjrBONjajJXd8GoesjO6rgHnE8xKuQADKj6CL
	nBngxXvTo9UkOI7gmxIzAXXnpy8igDjcxnnqwbt8I+bhWcyEx9bmJtCSscwS36Hy
	B9KuAGZif1Of4GVff0o/1MkJJ+mnzUnEt6lVCTgDyevobg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ZsLKpM7Fp7Kn; Wed, 13 Mar 2024 18:02:30 +0000 (UTC)
Received: from [100.125.77.66] (unknown [104.132.0.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Tvyyp60GSzlgVnW;
	Wed, 13 Mar 2024 18:02:26 +0000 (UTC)
Message-ID: <855a006d-5afc-4f70-90a9-ec94c0414d4f@acm.org>
Date: Wed, 13 Mar 2024 11:02:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] Rust block device driver API and null block
 driver
Content-Language: en-US
To: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Hannes Reinecke <hare@suse.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Greg KH <gregkh@linuxfoundation.org>,
 Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>,
 =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
 Joel Granados <j.granados@samsung.com>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Daniel Gomez <da.gomez@samsung.com>, open list
 <linux-kernel@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>
References: <20240313110515.70088-1-nmi@metaspace.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240313110515.70088-1-nmi@metaspace.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/24 04:05, Andreas Hindborg wrote:
> This is the second version of the Rust block device driver API and the Rust null
> block driver. The context and motivation can be seen in cover letter of the RFC
> v1 [1]. If more context is required, a talk about this effort was recorded at
> LPC [2]. I hope to be able to discuss this series at LSF this year [3].

Memory safety may land in C++ in the near future (see also
https://herbsutter.com/2024/03/). If memory-safe C++ or memory-safe C
would be adopted in the kernel, it would allow writing memory-safe
drivers without having to add complicated bindings between existing C
code and new Rust code. Please do not take this as personal criticism -
I appreciate the effort that has been spent on coming up with great
Rust bindings for the Linux kernel block layer.

Thanks,

Bart.


