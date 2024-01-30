Return-Path: <linux-kernel+bounces-45001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF11842A32
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C061F260EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE35128385;
	Tue, 30 Jan 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ITxhwscC"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A31272AE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633772; cv=none; b=RVWuC3seQtRbKEry3lFrQUFkAPoZU280KmAB6FnPqBhh9V7aepy5sJLk3SmYMDK9OkXKMaYhunmtsO6fCeP2zMiDJ58iI003NY79JZ6TNjSavdcVqBIxNeFVUDnvkVNRR0CGNSN/T0CVWJxLvEwbyVwLJFP1/RR43Cin/g6ouX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633772; c=relaxed/simple;
	bh=ypmOqj/q+NNTyaOgW1vO3SUeOqeEi21Zhohn4esARF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNhm28LTxPBzPnf29SbHhauJP0/JOf/3EJKpztn7/Y8YKn52729aykFG/x57fXUH7pXjTt+eSnRlpqMk+tug0mem0tpcp9Y2WoZe1hw1fsatxW4YepPDhKtra7X6Vxe2iT9K2plVRvbBP9DW4MzNJ1/7lDRj+dIMpMpswHgaFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ITxhwscC; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cf1288097aso55989911fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706633768; x=1707238568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LAAKLjZaHiiD7rj2ZPOdCI2v+5OE83poGDSWqAYQSrc=;
        b=ITxhwscCw1PO/+9hvmk8jTOXUIsM87fE++zbJeCTcL81Fx72qSmUYWN9LxVv61AO6K
         0WfPZwT4hQ05rh1Z2IcRurN0XNuUtCpuQSujaxRTyamsOTY8oOa8x6WJYNbj5qwPvsJt
         TDHKsJcWQG/KbqRZGXk9Ha44shgx03QWKxizA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706633768; x=1707238568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAAKLjZaHiiD7rj2ZPOdCI2v+5OE83poGDSWqAYQSrc=;
        b=b0BzbpJOfbAnxebM/OiU/Efl1p5DugNoZ1iY9GKvKCrv055SYsr3UieHg+amBb6NNx
         UrPdLhkSK0i9zvZ+osvePbhfCFT/hBpgEvKTJOJnNEabXwqSBuZmUjd69VKY4y26TEm7
         Th8m2pWnAeWoKzTCAE6Ymlgl6+FhWp5fp0LWCfEG8r7Jh16xJv9gAo+zf5KlpZ3Eeasb
         BhshW4XIx/edwGRbu0Ski2HCd1Jnxx5SB5UZzFKCxo+ElTao1jMrPjAQGa2rB/7YYUka
         wjGFHMQimeU0E4z5kO5b8X59Pnp9XF51w3d4gEervYS1DDHFtYa0iyNdG2ZhgWsIWWvL
         3Q7A==
X-Gm-Message-State: AOJu0YzYj2gnp6rRecZvOaerCsP1HPYQqO30pLVX5fQKBjzfMKgxUtP4
	p87IhisYHVmomp8DvA9WoQ+AW1uXnXNOSV7/tORd65h+8zuyFTcr/5dT6Ss4LZABSD5mHew+yuY
	IwfaxDw==
X-Google-Smtp-Source: AGHT+IFxhdwrHfolYd4w7ATscDwDaUOueNY+DcLZL/RhL567qdSEP8SZy/7P610FUMS5+Lbqysdc4A==
X-Received: by 2002:a2e:3218:0:b0:2d0:5925:83 with SMTP id y24-20020a2e3218000000b002d059250083mr1606792ljy.19.1706633768669;
        Tue, 30 Jan 2024 08:56:08 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id y1-20020a2e95c1000000b002cd7a4a2611sm1602675ljh.35.2024.01.30.08.56.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 08:56:07 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cf33035d1dso44028871fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:56:07 -0800 (PST)
X-Received: by 2002:a2e:b8d1:0:b0:2cf:334f:a7f9 with SMTP id
 s17-20020a2eb8d1000000b002cf334fa7f9mr8159344ljp.27.1706633767505; Tue, 30
 Jan 2024 08:56:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
 <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
 <20240129152600.7587d1aa@gandalf.local.home> <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
 <20240129172200.1725f01b@gandalf.local.home> <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
 <CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
 <20240129174950.5a17a86c@gandalf.local.home> <CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
 <20240129193549.265f32c8@gandalf.local.home> <CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
 <CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
 <CAHk-=wi6m7d-nivx10Lo=aGhbdk2qg-8SzjtDd9XW01LxGgAMA@mail.gmail.com>
 <CAHk-=wi+WbXZcc2Sx1i-MGV2DfG4eS4Ci+mrqi-PBSLSnww6qA@mail.gmail.com>
 <20240130093942.56206ff1@gandalf.local.home> <20240130114947.5bc856b0@gandalf.local.home>
In-Reply-To: <20240130114947.5bc856b0@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 08:55:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiNY3W1QKveFnH=dJtRNW7kA1Nbn6Ua49EbM6AC+Rx8wg@mail.gmail.com>
Message-ID: <CAHk-=wiNY3W1QKveFnH=dJtRNW7kA1Nbn6Ua49EbM6AC+Rx8wg@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 08:49, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> - On removal, I got rid of the SRCU callback and the work queue.
>   Instead, I find the dentry of the current eventfs_inode that is being
>   deleted by walking the ei->parent until I find the events inode that has
>   a dentry. I then use that to do a lookup walking back down to the
>   eventfs_inode I want to delete. This gives me the dentry that I can call
>   d_invalidate() on.

Yes, that works.

However, I have a patch that is *much* smaller and simpler, and
doesn't need that walk.

The VFS layer already has a good interface for "should I still use
this dentry", which is needed for various network filesystems etc that
want to time out caches (or check explicitly whether the file still
exists etc): it's the dentry d_revalidate() check.

Let me just reboot into it to test that I got all the cases.

It makes the code even more obvious, and avoids all the complexity.

           Linus

