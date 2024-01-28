Return-Path: <linux-kernel+bounces-41924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A9D83F9A1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDCD1F23EA4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0752C3C460;
	Sun, 28 Jan 2024 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HLbacQqc"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD844C3A9
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706471991; cv=none; b=SLMcgqhzb7Eq7aytSYcEty9SsRlj8l2Mvi9Uj5H9zwauHwV16PkXuUrX3lEcIfuZnra0b3NL61iWuS5DBGnJWXy+OHTO6ZsYCOXyX/4p6o4bENe9mqkda/vTxV9lFrWvcpqGkXFu87jlhTFG+9RGdIiBEe202YbsAFtoyIaSZcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706471991; c=relaxed/simple;
	bh=RQPBgjqLxVYa9z7DAN4AMZv6aMuk7G/qW9fdGyDL5MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nP97WNbhafldrAV6zFf6XkgmEsKJUo0zXFIKG2iUvexYR2MNuaaQOWgFLhccgC74GVhz3MZ8rw8WXy42edESQ52B3QzDPcGkFfWqc67iUQdY0kXCN3Nqmv8nxSKD8Y3X5MvQORfzbc/4INJW1jI34J1r+MnDLNF9irCWTfmqhgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HLbacQqc; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-510f37d673aso819725e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 11:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706471987; x=1707076787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jvgl07qLmO97AnDOonOYaDY55AuzJRLfRUuCExUHbJw=;
        b=HLbacQqcZ10CSzcNoAQ72MHpzZ8XS+RKCzZCY0k1uvjX4dMlOAAtiq8bBaGjJ3myvZ
         Ae7OoytbX0x9shmBgYS0M0+eUvd5VhZwS+Y6nJeh0UE35ciQiouWptiORbIJ4b3JE+fM
         tceLZ7v3lg3u3vDzHODtdrEJz5lZ0d+BqpZd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706471987; x=1707076787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jvgl07qLmO97AnDOonOYaDY55AuzJRLfRUuCExUHbJw=;
        b=pJ7GIV1l3RKLrJUSKdmRcigsqbQp73mHv6euRislNxclBunNCvAEFoG+OnsyBtf0Fv
         IU+N3V4WEpgmvontIVd1P+UvHcER64caqNX7FuHYkABYo53Qd/RL8xTMYTXOH+jFKW8N
         EzogX8uaJEYE5qS19wh8Umlp4neTD1LShzgpST9WSgi0NTgtU6P7LncUPJW7YQwJeCud
         Y6X3jk46n8tjO1ugVj1QafxhgoYu2XYlyfY2DKGY6hyTl/nBjnJF9nOWkm1+dspi6apt
         bZGG3kY6dlFouDsCx7ZsHETndjZggTKWzpRjjHoanNo4SCbtJYqRatvF+aOi7lHvqjM9
         1dfg==
X-Gm-Message-State: AOJu0Yxk16V40cohd6ycZzDPtApnMUNSr+c9/xnNK+z/g4bw8NWeQGut
	ujNBhMIfxsbwnxqFi2arvepG3q/Q/pMcI7EJSpj+xqAxdQa0hM0I473LGRD1hJj4SK6V1kVOd1f
	JSAk=
X-Google-Smtp-Source: AGHT+IHd1t7cl2RpN8+D99HFK+NcCSdRAcR5tAEEBCH/USRr77K8SjzTKizTr6e32bwvgw9704Rnfg==
X-Received: by 2002:a19:7003:0:b0:510:c63:5621 with SMTP id h3-20020a197003000000b005100c635621mr3297572lfc.17.1706471986939;
        Sun, 28 Jan 2024 11:59:46 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id m12-20020a056512114c00b005101bd871e9sm887599lfg.154.2024.01.28.11.59.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 11:59:46 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cf588c4dbcso12617231fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 11:59:45 -0800 (PST)
X-Received: by 2002:a2e:994e:0:b0:2cf:1a11:ea87 with SMTP id
 r14-20020a2e994e000000b002cf1a11ea87mr3234050ljj.39.1706471985664; Sun, 28
 Jan 2024 11:59:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0ca26166dd2a4ff5a674b84704ff1517@AcuMS.aculab.com> <b564df3f987e4371a445840df1f70561@AcuMS.aculab.com>
In-Reply-To: <b564df3f987e4371a445840df1f70561@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 11:59:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxYjLFhjov39N67ePb3qmCmxrhbVXEtydeadfao53P+A@mail.gmail.com>
Message-ID: <CAHk-=whxYjLFhjov39N67ePb3qmCmxrhbVXEtydeadfao53P+A@mail.gmail.com>
Subject: Re: [PATCH next 10/11] block: Use a boolean expression instead of
 max() on booleans
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Christoph Hellwig <hch@infradead.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, "David S . Miller" <davem@davemloft.net>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 28 Jan 2024 at 11:36, David Laight <David.Laight@aculab.com> wrote:
>
> However it generates:
> error: comparison of constant =C3=A2=E2=82=AC=CB=9C0=C3=A2=E2=82=AC=E2=84=
=A2 with boolean expression is always true [-Werror=3Dbool-compare]
> inside the signedness check that max() does unless a '+ 0' is added.

Please fix your locale. You have random garbage characters there,
presumably because you have some incorrect locale setting somewhere in
your toolchain.

           Linus

