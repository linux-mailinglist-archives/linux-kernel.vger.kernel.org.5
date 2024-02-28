Return-Path: <linux-kernel+bounces-85812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1701986BB5D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB171C23C88
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1449F7D071;
	Wed, 28 Feb 2024 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RVg2hVA1"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AAF7292C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161043; cv=none; b=bBiPdyiDECkWgimyI9QM8x1g0wLSM8vZ8KzMck0vGGQWtqvLaRtDXtDoVqScHEFwRHecnLFNTs6kZ3Z8gVghdRU6y2TiBbN44WBCROjgF+DKuslvgkqXglAHuQiSTbpM76lCxsOHTKdWfzPV28xEq3zFvGmeV5kD2Y3zmpgsl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161043; c=relaxed/simple;
	bh=rFdeaF8OvHp8ycIMfjI32IqX3BMfkKmkCnOldjcHl/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNb9HAm6y90X/O56UjajWBZWHsuM4Xz2qU6HcM5iF/TY7rTkEFtxWtZUsgak1zUlBhWYgYlzhVgU47+kz6vqNu1BfNuLt7dX+4Fzs9qA9jNrY9SLzsYu7lxE8O3JZH1mF68zv9fuSbwOMlLUF6zjPhw9InTAzzryR1/1Gl8EDOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RVg2hVA1; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so482324a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709161039; x=1709765839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XmDUVGJ7uYNuJQyRX/NAFGYz0phL9n1ekfsCjXQN9T0=;
        b=RVg2hVA1htW9QrV231XmRu8rVE9dxV51l51q/PZmKI+VP0e7zdBrJXCL0nGQqa9K9C
         09+83yEVgQjs1xoJ9udWq6U/MWN7IG479Bsb37f36UhtGM52IpxZf9N5YyuA9SDdJAXd
         Nmd/L3ZsB9AoxeA3ynprcqaMgKBNcmkKqhWSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161039; x=1709765839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmDUVGJ7uYNuJQyRX/NAFGYz0phL9n1ekfsCjXQN9T0=;
        b=oFjLnT+o9NxX5ClXNVY5HCz9pIQr/zM/kUgxkUATVzyzK0n05v+Oh7MdSjgVoBqF84
         IgbfO5oFT+Kkn0mL4Q799MfoHGCAPMFcNfEijYUfHeHNmCLdvPFlIrY+NdFJZjYRMZV9
         beaHBdJzZgIghfEFf8Dsc+PhSbQ6oFf8M8TmeoUbsP9DxLSM8VT8oAYUe4qX5VO33GBN
         V6PAutGInofsHq0UkeLS25+e4Bby4zXy7AMvtbRR0ft36eHxp5AYcrOEPr3zrXdPxBol
         29eLVuueq3AHueHrfCSlywElY7348CeBCtLTtfVwyWRfNjef/k8lF9tlGhki+fvvLl0N
         aQvg==
X-Forwarded-Encrypted: i=1; AJvYcCX9bsGNVL1B4/4Fh6944EV1kcj04fOkBo0fUKWcMNy0+Lc96xvhQkL0NvoTdTJEJyUK4kV27ciqzzV3xgtSPR3jNS+b67L9qdxHrjR4
X-Gm-Message-State: AOJu0Yz/hMWwSguWwEJuBvwPdYoxWPPsn/mxDEivN6/xbMXHZQaaNjH8
	7nYjKQuDx4Pj4XbIsSyJknngY5yJ1lywDjH5o07yeS+tsr1Za+I2fJGEyAZ7FlLk8m8JjgqQ9BQ
	u4Y0ANg==
X-Google-Smtp-Source: AGHT+IEjwH5pp5pQLH9f0HInvpiye9Dj4+wl/OcjiZJkJ3ys2aehnpiNpoX6xxmVTtzBjidzk7D+5A==
X-Received: by 2002:a50:8d8d:0:b0:565:9f59:b3bf with SMTP id r13-20020a508d8d000000b005659f59b3bfmr222401edh.6.1709161039683;
        Wed, 28 Feb 2024 14:57:19 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id o23-20020a509b17000000b0056636a98652sm2170837edi.82.2024.02.28.14.57.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 14:57:18 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a26fa294e56so62359366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:57:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBuU2ZbkMJrx1IjM7cJMievjT44sLvkhMlG0pyViMdHEficJKg+btR5zZjCugm3G+AnXnq54yMDgc6cyNMk09MMivRYINQ3cJN8rJE
X-Received: by 2002:a17:906:b7d4:b0:a44:f89:8104 with SMTP id
 fy20-20020a170906b7d400b00a440f898104mr218606ejb.42.1709161037880; Wed, 28
 Feb 2024 14:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
In-Reply-To: <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Feb 2024 14:57:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
Message-ID: <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <christian@brauner.io>, David Laight <David.Laight@aculab.com>, 
	Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 13:21, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. If the copy doesn't succeed and make any progress at all, then
> the code in generic_perform_write() after the "goto again"
>
>                 //[4]
>                 if (unlikely(fault_in_iov_iter_readable(i, bytes) ==
>                               bytes)) {
>
> should break out of the loop.

Ahh. I see the problem. Or at least part of it.

The iter is an ITER_BVEC.

And fault_in_iov_iter_readable() "knows" that an ITER_BVEC cannot
fail. Because obviously it's a kernel address, so no user page fault.

But for the machine check case, ITER_BVEC very much can fail.

This should never have worked in the first place.

What a crock.

Do we need to make iterate_bvec() always succeed fully, and make
copy_mc_to_kernel() zero out the end?

                   Linus

