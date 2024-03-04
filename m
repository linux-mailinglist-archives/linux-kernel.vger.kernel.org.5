Return-Path: <linux-kernel+bounces-91103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DF08709B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43373B2AE5D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAB878B49;
	Mon,  4 Mar 2024 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HFcAOfEt"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1443C1E4AA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577166; cv=none; b=Y3PtQXO2PjmeHEVpqL9K+iQkxZtniW4w+eHO/Ya1+c3guuw7L0XcHLFhsv4iTkOM6+D8hIIsBSuy4Ga0xi0y/UCnJ1GyISg6BpmH09xNJx9YTlNBZlvB6TmZft6rjuZGTnkewar2ZasCr6O6SgkLXm8OrxwIx9nyN9kHS3UQ/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577166; c=relaxed/simple;
	bh=KtfWqAbL60dmDmNJlm82ls0DTRmdSK6fujqZ9REQ7jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/JfVU8w3z9EGWCmKbuQDeJJQvQf8S2psB8zc8swWS24TO5KmkiGGeKNk+2U6iKN42dECP92OfAWS3hTwVG1K9GxWM+59K57j77Km4WiMRhQsRuH2lYmTztjCKI4wPm+DAjFTvv04cLcfWX8UvWx8g57o+6AYF4/tgxSfrtj1ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HFcAOfEt; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56682b85220so7755046a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709577162; x=1710181962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LczxhZqLEWu5Pcwo59Oo1yTNgbAQRYyUzuwaCxJZY78=;
        b=HFcAOfEt9/FvsD6j1u4pv0r8VsphGwkpmz/ti4TcDLPwbiXdGjlexLVnYI916Ijcvo
         3dDvKGZPcIVlYskuXO+IQGx+lImvNF0RaprjSgxB1zFElh1O62jlx6e+f1S9q0LqfXcn
         7R5MckTa8gpdXygeCXDYGK2Q1k+eUy8USQTd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577162; x=1710181962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LczxhZqLEWu5Pcwo59Oo1yTNgbAQRYyUzuwaCxJZY78=;
        b=YuirDY4ij3bK5FH9OGw9tSzOk+Xi97zgOlGPL+tuzfRimkMe9aX8fkJjaj5RG5FXp8
         WEGn5noppbOvydoeIDRZUviD9GFXwI0Jl+YfreqBcAFPOwKe3KiC4OlQp0VqUmulkcsm
         EscK+r/ULrYZOEbSSD/sqitu/Bw9Ecgav81ddg1pdAJ/S20YZAJK2ZSDvGZbORqj7jRz
         8rkuw62pv2kXzWI2ZjPaEEYKB8KKxZJMyN8ZE4Sd7Gq5qF3RQCbVlPjHQEbHFVPFnT74
         J9sEIfQyNDWrypPlfxz2HBVJVmBLUKlhZlENcZuNUmpVWTsOZtQLtvLKhSuoEAD+2Rxq
         fmfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqaqWNUazezGqWVS+gMte2JIt4ukjL2sywFonFUXWrIWqZRsJoE+3UZPwwnx7XvYTG6UhY0lH8IdAFyRVa1siS4OqXYoa+FKXuxPkN
X-Gm-Message-State: AOJu0YxI0qvl4C1K1mH2lugdTLqaBJCeuCIxka2i2axQJiZvHKxQj02R
	81ydXEWHynzAkp9ryriVLr1hZZcf+aJxiURPBfNlaT27bAZQieOFM2zgfe1VXq6ISfgfdP/HfMv
	gHao=
X-Google-Smtp-Source: AGHT+IGv57o2k+gGEAIGzYHaZia8U3yGd7kifKuVnOWjakcrg6I91e2IJNcofTsU/+2i3pR9ndJmnw==
X-Received: by 2002:a05:6402:1249:b0:567:4441:89ad with SMTP id l9-20020a056402124900b00567444189admr2840583edw.15.1709577162482;
        Mon, 04 Mar 2024 10:32:42 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id u17-20020a056402111100b0056729e902f7sm2176942edv.56.2024.03.04.10.32.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 10:32:42 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4467d570cdso487013566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:32:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMGxhIPQvG1HMOQjL+MBshEMtdIadH3tVA03vIUvxJCvAkxxCh7GYrE7bG1jKFTPkkuHiBidRCpzBTouCFgXBkayl5ksDUHwWkc2ko
X-Received: by 2002:a17:906:8da:b0:a3f:ab4d:f7e3 with SMTP id
 o26-20020a17090608da00b00a3fab4df7e3mr7570338eje.0.1709577161818; Mon, 04 Mar
 2024 10:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
 <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
 <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com> <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
 <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com> <769021.1709553367@warthog.procyon.org.uk>
In-Reply-To: <769021.1709553367@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 4 Mar 2024 10:32:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgrmt875HJNUY9a-ti0M6M1m6jHEGvCSjcOfXy_E7_X_w@mail.gmail.com>
Message-ID: <CAHk-=wgrmt875HJNUY9a-ti0M6M1m6jHEGvCSjcOfXy_E7_X_w@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: David Howells <dhowells@redhat.com>
Cc: Tong Tiangen <tongtiangen@huawei.com>, Al Viro <viro@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Christian Brauner <christian@brauner.io>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 03:56, David Howells <dhowells@redhat.com> wrote:
>
> That said, I wonder if:
>
>         #ifdef copy_mc_to_kernel
>
> should be:
>
>         #ifdef CONFIG_ARCH_HAS_COPY_MC

Hmm. Maybe. We do have that

  #ifdef copy_mc_to_kernel

pattern already in <linux/uaccess.h>, so clearly we've done it both ways.

I personally like the "just test for the thing you are using" model,
which is then why I did it that way, but I don't have hugely strong
opinions on it.

> and whether it's possible to find out dynamically if MCEs can occur at all.

I really wanted to do something like that, and look at the source page
to decide "is this a pmem page that can cause machine checks", but I
didn't find any obvious way to do that.

Improvement suggestions more than welcome.

               Linus

