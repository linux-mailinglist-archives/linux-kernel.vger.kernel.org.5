Return-Path: <linux-kernel+bounces-31928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A93833682
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DE21F21740
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AD314A9C;
	Sat, 20 Jan 2024 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TQuh7LV/"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15A414A85
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 21:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705786442; cv=none; b=oEqDgpjThADAcKmDgch6Q/POFf/eGdRnnCxkoeaQdRBEZy/Z81rJgJzzHnjOu5IvZVj14MMStWMaanGuPIMMIJs5NykbstZMARz0kTbXFYFWVhIsm/S/TvFQz9iFuomCDbgvlrMYfA6Sxbv93nEwjqWy/zD6KC2qqLTTBKUp5h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705786442; c=relaxed/simple;
	bh=NarUDJ4tJwqbJmce0ccZJ9bOR2MW+PWmGoMFcPd6dcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lb4x6G54rT8UvBk1YSwYLAhWEbzrY6y3I1I/W3u7/zNNGmM7FlJ1NhOJUJbYk8VHSMSahZs/xpEx5YwBuK/BYmPAFZFraDnw6AW54r74sd3OMcb4jMVcQ+0QJjxYNpLc1Ss7aKblpwNeRstjmFf0fzNpTApgKnIJ97nY3dvJtRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TQuh7LV/; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50eaabc36bcso2111458e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 13:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705786437; x=1706391237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sN+R63MxRKJ46kffVezEFHdryW46yFIp21fCeYYUqvY=;
        b=TQuh7LV/cKP9dFy9UPNMj36PiHSSIvIKihYuxexfejXva5yG6bHxIunglsjBRZXmB+
         xkCg9VZPbI72gwXSWlkFoKQ2QdnTtggZjiQB/zslEfeQTopc+if8GUV77S+3UCDoutCn
         vLf86MQ7E22TX9wirIglV8hezrMUjDH5PzJ9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705786437; x=1706391237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sN+R63MxRKJ46kffVezEFHdryW46yFIp21fCeYYUqvY=;
        b=GWi8pEGDcMKbD4j7OndaS7fiVyd3hHqEYSXb5nBTYZOKx6Fjy2Y48G1AZqzffjws2Z
         mlxVS1AG+5e5J+/88TbU7fWcOBZEJR7Ggzj/Qx5mITD89xDL4PUmTVUqGb/Js+70g2Ws
         EB2xxmHedvTSqNCPWh6TkUrx7fh7XKWZY/D+CaDlvvDpvZhajUOsyHHjIB9zaxtloRuX
         ZFau1aH5vnokGZhDitykOu0Osm1JBQSzekxxZIkG+53/0rInIDnaGO5ao7ErWcuxXy9i
         u57yZ3heuC5eaw2XdWRsX1Q2p5f+Wf+2kKCtiXHjUdHO4Ia1OhnZwujimZD4BVEn3RX0
         J5Rw==
X-Gm-Message-State: AOJu0YwA0uRttyrT0IgA8C1n0zWCkCOS8zLQP0SeeanblRJpX/B1Uo47
	qSH9Ao9fZHzCUFOD2Erm+XyB4Zi08IFuuhUO0ffvPt+CBCfy5uyQiKxaNSPwHXm2NK2x9kwlk5/
	jW9Scqg==
X-Google-Smtp-Source: AGHT+IHPtBu6kqbkOP992XgwDczjl+jKSkSk8kcQFFBb9jXZJJ1zkTIUm3+AixdfidAgLsiDjNWaFw==
X-Received: by 2002:a05:6512:1191:b0:50e:3377:a199 with SMTP id g17-20020a056512119100b0050e3377a199mr1035254lfr.81.1705786436762;
        Sat, 20 Jan 2024 13:33:56 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id j15-20020a1709066dcf00b00a2a6e8f693esm11789662ejt.152.2024.01.20.13.33.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 13:33:55 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55a45a453eeso2314051a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 13:33:55 -0800 (PST)
X-Received: by 2002:a05:6402:1495:b0:559:b870:e868 with SMTP id
 e21-20020a056402149500b00559b870e868mr873233edv.12.1705786434795; Sat, 20 Jan
 2024 13:33:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com> <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
 <CAHk-=wjE1eLMtkKqTt0XqNSnKAeDagV=WQU+vxHL_wsLuO8Gag@mail.gmail.com>
 <CAHk-=whkGHOmpM_1kNgzX1UDAs10+UuALcpeEWN29EE0m-my=w@mail.gmail.com>
 <20240110171739.2e2d9de0@canb.auug.org.au> <CAHk-=wj1uqgU7hS=WqDSwEvc6=CwuWYBUmjSJAT6zx86CF=QBQ@mail.gmail.com>
 <ad3a9cf720cd4e1ebe942cdc84a6a670@AcuMS.aculab.com>
In-Reply-To: <ad3a9cf720cd4e1ebe942cdc84a6a670@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 20 Jan 2024 13:33:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=whKAaFmqNBEnY=n8Twnh6AEegHh7OL0YFkNS8b3xVQ-3w@mail.gmail.com>
Message-ID: <CAHk-=whKAaFmqNBEnY=n8Twnh6AEegHh7OL0YFkNS8b3xVQ-3w@mail.gmail.com>
Subject: Re: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
To: David Laight <David.Laight@aculab.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Jiri Slaby <jirislaby@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Christoph Hellwig <hch@infradead.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

[ Going through some pending issues now that I've mostly emptied my pull queue ]

On Wed, 10 Jan 2024 at 14:58, David Laight <David.Laight@aculab.com> wrote:
>
> The first check in __types_ok() can go, the second one (with the '+ 0')
> (added to promote char to int) includes the first one.

That turns out to not be true. An expression like

  min(u8, unsigned int)

is fine because the underlying types are compatible.

But the promotion to 'int' makes the first argument be a signed
integer, and is no longer compatible with the second argument.

             Linus

