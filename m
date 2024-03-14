Return-Path: <linux-kernel+bounces-103601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC69887C1C5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198431C20DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5C97443B;
	Thu, 14 Mar 2024 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="erQ/OAUZ"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152BA18E20;
	Thu, 14 Mar 2024 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435836; cv=none; b=fTmAZmuIixJft8GsPuVwk0shdZ9nvMvuxarn36BbR1tPxa7xJil88sw4WKJwPTD2P0IFBrjB0h0g1h6ghd74qma/NX5WDSUug6ndxt8MCde9H0d+2eIWnaZwrb6eTqRm5pzg62ryA3YYnn3+sTLGKIVTiwiaBFfZl9+4/qPbRpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435836; c=relaxed/simple;
	bh=ltX9xyzVbNiJ0K+V1nTTJSIWdXTIXSSXqkHz5bWJy3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwrmEHC/eqXLt+6gNWIjLLNtFGG8PvHMkLcA070D09jTa9UqILI70+dV2i5256EZdL+EQL5TgyvOE+bqhy0bEHNKxl6iMcJl7E2+bil1VBTigHNNbGYbILnU8EmNmwR2AEkc1MqQ5+47711nolDC0yS1EM9Uy2ovlBMACiyEn8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=erQ/OAUZ; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4TwYcf5hDBzlgVnf;
	Thu, 14 Mar 2024 17:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1710435812; x=1713027813; bh=ltX9xyzVbNiJ0K+V1nTTJSIW
	dXTIXSSXqkHz5bWJy3w=; b=erQ/OAUZfLhmU0b7rda2YD9kDXmunQi3lfbHtWvE
	O3sFvjsc2tu91iMPQbM9M94H0xdORfp0ZUZUV9ky/jHeQVfXASFRxFQIoRxaEygU
	NzwUB6V9qQYAID9XZwSyzHA+msPTv5oY1CB62ST+hXEbJaEB6+pnyZb1kemrYp3E
	9qjGFnSfrLHHWUN5bT14wmjwHjPXM7pGwtLIe5h56eEdV0AxAxNcFIuDiNbHf5l6
	52SYczVy6np6jxqPQZVKCVFTr58CGfm1VmEFVHdHRJjeoQSKrbzasTFnOEjxSIqe
	NNC4bmTyrh6je0O2u7n1brxnpf4KeO+XwFVNYYvkybhjAQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DUbUGxRl-_3F; Thu, 14 Mar 2024 17:03:32 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4TwYcK3CclzlgVnW;
	Thu, 14 Mar 2024 17:03:29 +0000 (UTC)
Message-ID: <5f502f91-0450-454d-ae8f-36223920532e@acm.org>
Date: Thu, 14 Mar 2024 10:03:28 -0700
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
To: Philipp Stanner <pstanner@redhat.com>, Andreas Hindborg
 <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
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
 <855a006d-5afc-4f70-90a9-ec94c0414d4f@acm.org>
 <c38358c418d4db11221093d7c38c080e4c2d737f.camel@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c38358c418d4db11221093d7c38c080e4c2d737f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 3/14/24 05:14, Philipp Stanner wrote:
> On Wed, 2024-03-13 at 11:02 -0700, Bart Van Assche wrote:
>> On 3/13/24 04:05, Andreas Hindborg wrote:
>>> This is the second version of the Rust block device driver API and
>>> the Rust null
>>> block driver. The context and motivation can be seen in cover
>>> letter of the RFC
>>> v1 [1]. If more context is required, a talk about this effort was
>>> recorded at
>>> LPC [2]. I hope to be able to discuss this series at LSF this year
>>> [3].
>>
>> Memory safety may land in C++ in the near future (see also
>> https://herbsutter.com/2024/03/). If memory-safe C++ or memory-safe C
>> would be adopted in the kernel, it would allow writing memory-safe
>> drivers without having to add complicated bindings between existing C
>> code and new Rust code.
>=20
> Correct, but it would also most likely allow to just arbitrarily ignore
> the "modern, memory safe C" (or C++) and write it the old way.

Linux kernel developers have the choice today between memory-unsafe C
and memory-safe Rust so they already have the freedom to ignore memory
safety by choosing for C. In my opinion a compiler option should be
introduced once memory-safe C or C++ is available that can be set per
source file and that makes the build fail for source files that
unintentionally do not follow the memory-safety rules.

> The Kernel's C already has more memory safety than standardized C:
> There's devres, and since last year there's the __cleanup attribute.
> =E2=80=93 but the thing is, you can just ignore it and do it the old wa=
y.

devres is controversial - see also Laurent Pinchart, "Why is
devm_kzalloc() harmful and what can we do about it", LPC, 2022
(https://lpc.events/event/16/contributions/1227/).

> One of the stronger arguments behind the push for Rust is that the
> language by design forces you to obey, because otherwise the compiler
> will just reject building.

Rust has a very significant disadvantage that memory-safe C/C++ won't
have: supporting Rust means adding Rust bindings for all C functions
called from Rust code. This forces everyone who wants to change an
interface to also change the Rust bindings and hence will make it
harder to maintain the Linux kernel in its entirety.

Thanks,

Bart.



