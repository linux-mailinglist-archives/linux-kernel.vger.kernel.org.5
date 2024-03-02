Return-Path: <linux-kernel+bounces-89544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0462386F1D1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CB91F21C7E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AD13613B;
	Sat,  2 Mar 2024 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KK1s3AKS"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79912C69A
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709403127; cv=none; b=eNHRx/JOWrWNZqrVk5ws4IDpeRFfQ8mFkjNHzO6Es1IqyGYaFE/UqN09soUNpjG3ShuJzplxnRsaSEs+w5X9EueKyevhjr6mjOVsFLOBtNbdk+Eo2YkR9ubPrR/LFYVMDa6E+aywYybHlrd3CCUCwRVQxBxiFpnxfRq5ARf5qbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709403127; c=relaxed/simple;
	bh=UaTnZY8Awdcgt8ZW0ePFAWj+b5DkUlXvw9yVNGy7EKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRAvsAj+jafgjH7Y9kosl+ER7dStxyUAp8Oaj7vhMPYNXbHvR28L+LMkwVHWjX3qAdec66JQSrQKzSB9V7Xgl7najDsAVTodwD6xN+q3meXOWAbsXES+LcCwEIeCwyQ5LozZJQZQrvYdZSk43DgbapmIpdWHr0wuu1uZq9s97nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KK1s3AKS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5643ae47cd3so4551570a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 10:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709403124; x=1710007924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mpxtfMFdGHdZ3KBLFHI8lmN/KThAgx7c0/ntlIOIqzY=;
        b=KK1s3AKS9QI5zO1IM+w3Ch6ZpCoQI7Ipd/X5JmGtv/iVdozGaSoSvQwDJf3cgS44IH
         VY/1+kgJiiMNw/Td/Xi8N7sm5B1mmBFNEOYr8Ck964UUWpIGf8l0K5yZeXps7qC2aguF
         yL4QldbtYQFPnquyuaP877/tuSCkdc5K+BZ9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709403124; x=1710007924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpxtfMFdGHdZ3KBLFHI8lmN/KThAgx7c0/ntlIOIqzY=;
        b=U2CtreBg1dH0d5G8UOcE2kNSaoVIQUJt8+eQ+xri8fQjwsLOBE+7C+iMqSgdHtOAxV
         a3OL+6UBKjprdYmjBGd0NQy+a/lWPg8zuu0jzxAWxadwsEFHRfkoU4ppnJtwLwN1fZ+J
         toUG7hP3yzdlY4a6ZHdT8du302hbCFoQMJZvyajYRQvZrff2PFwbZdhiZgjRoJMP3Tvu
         Q1wAOg2DuAL7ajis9YetZKov9F4VTR+6bJ7/O1d212eEmJVxdxF/GervdioYcmFlIqGa
         F25pdB9FJWnzJU70KFQgAIxn9nCfvyWaZ4nDECkc3NvrYwrQ6cZxdHxaJxM/qQFo6BAX
         wD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZtJGni6Y8vGbh2m/czF/SVrgUCbJFDjHo8ca0V8Fa20anUuW7Oh+d9aGcOOYZ+Y+vm6QpU0zVtEPfZZMwCd+msmZql8du9BondpH1
X-Gm-Message-State: AOJu0YxfDXc9RaA9eM/x/79oqoIepQPW/0RHltYqBG8IJ9XOgi6Nedbk
	SIu7594nizFCXY1KMp/+HjfCCzeEw5gjcwJPb0ahJ7w8z0SxvR9v2sqlbgLO9iAB4tgvJTtA7Um
	3G6vDSg==
X-Google-Smtp-Source: AGHT+IHtre6vSHyORRGM9LkOhgu5uRFQz40FIkEWzkd8snwmHvEkgA4fPbXM7A99/tmGtJOfkjCihA==
X-Received: by 2002:a50:cc4d:0:b0:566:806c:690e with SMTP id n13-20020a50cc4d000000b00566806c690emr3222261edi.5.1709403123974;
        Sat, 02 Mar 2024 10:12:03 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id p8-20020a056402500800b005648d0eebdbsm2776259eda.96.2024.03.02.10.12.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 10:12:03 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so497278966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 10:12:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRw2TbF5S8rmfg8JGcmiDMDRGRLDaxxo/RBdAlhrUcXe3B5XasSyTkLYwNkkwg+p9iNqY/+0ey0FC9yVP9lhhPGkVu3TvBOFfmLJDl
X-Received: by 2002:a17:906:f190:b0:a44:2134:cba9 with SMTP id
 gs16-20020a170906f19000b00a442134cba9mr3296518ejb.69.1709403123040; Sat, 02
 Mar 2024 10:12:03 -0800 (PST)
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
 <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com>
 <f914a48b-741c-e3fe-c971-510a07eefb91@huawei.com> <CAHk-=whBw1EtCgfx0dS4u5piViXA3Q2fuGO64ZuGfC1eH_HNKg@mail.gmail.com>
In-Reply-To: <CAHk-=whBw1EtCgfx0dS4u5piViXA3Q2fuGO64ZuGfC1eH_HNKg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 2 Mar 2024 10:11:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvkP3P9+mAmkQTteRgeHOjxku4XEvZTSq6tAVPJSrOHg@mail.gmail.com>
Message-ID: <CAHk-=wjvkP3P9+mAmkQTteRgeHOjxku4XEvZTSq6tAVPJSrOHg@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Al Viro <viro@kernel.org>, David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Christian Brauner <christian@brauner.io>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Mar 2024 at 10:06, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In other words, it's the usual "Enterprise Hardware" situation. Looks
> fancy on paper, costs an arm and a leg, and the reality is just sad,
> sad, sad.

Don't get me wrong. I'm sure large companies are more than willing to
sell other large companies very expensive support contracts and have
engineers that they fly out to deal with the problems all these
enterprise solutions have.

The problem *will* get fixed somehow, it's just going to cost you. A lot.

Because THAT is what Enterprise Hardware is all about.

                  Linus

