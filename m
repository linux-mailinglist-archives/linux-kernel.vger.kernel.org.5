Return-Path: <linux-kernel+bounces-6100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCCD81949E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E50F1C24C54
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D4B40BE8;
	Tue, 19 Dec 2023 23:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb6Xc77V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100B240BE0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE46C433CC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703028820;
	bh=YikHJNY6Xyl1KsptlwY/6FCi9bk4JHLVYa3jzibwyio=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Eb6Xc77VKh5nGrjsIFh7L0k74o1OH3+CggRFAGdPUoLEg12SWQqxgF/88GfTzUfQy
	 s5BZto742tnlpAZyPNiG03fH5CZF8Y19YtlVCy9cHDh7e+DWHVZ/gTyyqiXlRqEoC5
	 LD2vsrFJqWqc48DoaL67VR/dd7wu7gBuxElWZ5Y1eLCq/f0zz64+bQKUWoFz930Gz/
	 IvLv0PYj5tq5rVLmfND9tuHA0zXPg6CQgpCViiEVS9ovGGEPfGdJ2cEjxh48aVLQu5
	 uakOXaJflKl5ELtpizop623O2tEWI92YnToEFItTbYbJ/Y6YVfbNKsmfCXrYNJSmDn
	 bBOsNpmalVJQw==
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28bd423fa08so23998a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:33:40 -0800 (PST)
X-Gm-Message-State: AOJu0YwQlJgZLBMyxMVXKqK0aj6ZeX2RxbB5gjVeOSb4CmXJqxeefrkj
	hXVvgTaNVtfTkWY8sSNyE03Y5vRz6MqzLtfe5MgC7w==
X-Google-Smtp-Source: AGHT+IHS4nqFg9k9bAES9QBJu+B5coLgo8U2gKNwYQigIgOo6RCR61txnmqdaoBOGESziUtNZyA88x/0S84dcmykFzc=
X-Received: by 2002:a17:90b:1d0b:b0:28b:5c89:b378 with SMTP id
 on11-20020a17090b1d0b00b0028b5c89b378mr2648663pjb.12.1703028819864; Tue, 19
 Dec 2023 15:33:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
 <20231213-zswap-dstmem-v3-6-4eac09b94ece@bytedance.com> <CAF8kJuOv+k0TcKJhs8wEWi20=B84bomj5BvpUAHvj6k3A+WE5A@mail.gmail.com>
 <CAKEwX=P=frZmEXm26uTBN05gqLXoL-Shgk5P=EsMpYR16dW-sw@mail.gmail.com>
 <CAJD7tkb2gWz1uQ7C6NQ7mAB=QQgaKHSwDFr0XS9ZrGFPOP1tTQ@mail.gmail.com>
 <CAF8kJuPxCrJHE=7k0hBs7Caqhc=UvwyL0kh7Yk2e9Usboz1Vug@mail.gmail.com> <CAJD7tkaZDb_XwdCov1kpGbvY-VfR9_nMagOE_ajCs+bKxC8yQQ@mail.gmail.com>
In-Reply-To: <CAJD7tkaZDb_XwdCov1kpGbvY-VfR9_nMagOE_ajCs+bKxC8yQQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 19 Dec 2023 15:33:28 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMdNJTZrWsK-VkxWhCo_7=T0Cb5Cwg5nBtv-ex4M1Dhkw@mail.gmail.com>
Message-ID: <CAF8kJuMdNJTZrWsK-VkxWhCo_7=T0Cb5Cwg5nBtv-ex4M1Dhkw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mm/zswap: directly use percpu mutex and buffer in load/store
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Seth Jennings <sjenning@redhat.com>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Dan Streetman <ddstreet@ieee.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry,


On Tue, Dec 19, 2023 at 3:05=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:

> > The compression and decompression requires the buffer and mutex. The
> > mutex is not used other than compress and decompress, right?
> > In my mind, they are fine staying in the struct. I am not sure adding
> > an level acomp_ctx provides anything. It makes access structure
> > members deeper.
> >
> > If you care about separating out the crypto acomp,  how about just
> > remove acomp_ctx and make it an anonymous structure.
> > struct zswap_comp_ctx {
> >     struct /* cryto acomp context */ {
> >         struct crypto_acomp *acomp;
> >         struct acomp_req *req;
> >         struct crypto_wait wait;
> >      };
> >      u8 *dstmem;
> >      struct mutex *mutex;
> >  };
>
> I prefer naming the internal struct, but I am fine with an anonymous
> struct as well. I just think it's a semantically sound separation.

Ack.

>
> >
> > Then we remove other per_cpu_load as well.
> >
> > I also think the original struct name is fine, we don't need to change
> > the struct name.
>
> The original struct name makes it seems like the data in the struct is
> only used for the crypto acomp API, which is not the case.

The mutex and buffer are used associated with the crypto acomp API
that is why I think it is fine to stay within the struct as well.
Using the anonymous struct to separate it out is marginally better. I
think we are in agreement here.

Chris

