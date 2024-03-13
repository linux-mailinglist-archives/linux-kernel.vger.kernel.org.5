Return-Path: <linux-kernel+bounces-102405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1F087B1A3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BED11C29EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44164605BD;
	Wed, 13 Mar 2024 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="R15hv2mC"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EFE604C5;
	Wed, 13 Mar 2024 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357130; cv=none; b=rGOhxDibwM3HSs3gpvuR6m/rLgOv/yeJagRUV/iFNhMLD1mvjGGPp+L7msqVf8wr4kwFsjicDoj7Fi032tYIKJbO3VSL5j4SH1/CWYgr2YIKCdDUCzM0wkI3oaFHcXuMJp+YO4KPGymyLL0hGcS5nNae1AOYOrKh/U+idfHtcno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357130; c=relaxed/simple;
	bh=i1sWYvJRR67mPoxsHtNcMGdTsNgujrMd6hvVpbLYz74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sff3nckbcLZ7YbWoOY7bNEYwYIjUFVUAIoxy/Jg8kXUDDpDNRChEO2Smno5cvxnmMdB0lwfv2h/AEmvhoHTqi6VYre7aaNepQjBuMp307z/pHJfgt7V07JfzoygnR8ATv5m8iUHraujz9Sy79IYDHwqhyiiNeSP3gnOUR0EA1nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=R15hv2mC; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Tw0W63ZzRz6ClSr9;
	Wed, 13 Mar 2024 19:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1710357113; x=1712949114; bh=35L+R0W2D8tp7YUdieD0FUY/
	PiWMGSyPa2r6p64YId4=; b=R15hv2mCgKMSf2HTayPe5hejHC4E5N8a4yM4M9YX
	IqB/0xusf+mTSKDES3Me+Qqt0pQr27rGGsQwTTn2j6ikk643vmT9p90RgDufN+Jv
	wvkShwKwsLO6eHYn+6ZJVrZOGsdJS7zok9Sp8Hl7DrqL2WhwtmZa7pznVWcy+72q
	/9u7F9ba0WuCL302Fo5wB7JHlq3dC+hgi6JEHdGj2GGqXVIHA19TIXccNuJBWB1E
	zJ6M71FDuWoy+5cBD64C5kl56EZ7qBsIijZ+YvJZSXatHaCXbpWMpYG3iHlpQ4EZ
	3Qf7YUZS0mB49aNU9Di3vqqcP0wyvuOGHui//WTUvXwifA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SCYItGCkl88g; Wed, 13 Mar 2024 19:11:53 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Tw0Vt6PD8z6ClTNc;
	Wed, 13 Mar 2024 19:11:50 +0000 (UTC)
Message-ID: <2212ce5f-940c-48aa-966d-2b4fa4a5ad8c@acm.org>
Date: Wed, 13 Mar 2024 12:11:48 -0700
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
To: Andreas Hindborg <nmi@metaspace.dk>, Boqun Feng <boqun.feng@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Hannes Reinecke <hare@suse.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Greg KH <gregkh@linuxfoundation.org>,
 Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>,
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
 <ZfHu48NGktOx_uhG@boqun-archlinux> <87r0get0no.fsf@metaspace.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <87r0get0no.fsf@metaspace.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/13/24 12:03, Andreas Hindborg wrote:
> I think it is great that people are starting to realize that bringing
> memory safety to other systems languages is a good idea.

Totally agree :-)

> But from one person blogging about it to things being ready for
> production is a long journey.
In case you wouldn't be aware of this, Herb Sutter is not a random 
blogger - he is the chair of the ISO C++ standards committee since 2002.

Thanks,

Bart.


