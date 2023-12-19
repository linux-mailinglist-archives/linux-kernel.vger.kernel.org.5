Return-Path: <linux-kernel+bounces-6068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0785A8193D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85BD7B231DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9D140BE7;
	Tue, 19 Dec 2023 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMF8V40e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A440BE1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10D8C433CC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703026150;
	bh=EleRH5HdD7HIdp95MU4VpkTGtYuJwIDY/CqwNuAntrw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aMF8V40evMM3565e/M/7whPJcX5jDXmToks6Ms/6VawdbyTO4/ZpdzyM9hIhAsESE
	 SNQkGatc3IHEJkgrc+/itvGxe3qrhRqoOS1Vp9SO8SSHRKEHSCRcHCn6e0DXnWURL5
	 aJCvAVKh5uihpxX++DghnqCOCXohr/0XtQUySkSPf03/XGLdrzZq/czqMG/v6GvpFV
	 LXkMs3sZopcpPnS62ElB5sX+oepwgyZ17bZJolz8EGJI4v1I3ByawcbGJpYMRj+Yr+
	 Usf8EnpZsp5FkEMFqZpGkrL4cgrNK2OByWgugTqhacyvNgUed3uz0zFUCkYk9+2Vcr
	 Fltzv++asfFtA==
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-35f56f06142so38420115ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:49:10 -0800 (PST)
X-Gm-Message-State: AOJu0YwnCmBWZ4GJeJKTwgZa6s6b+jrDIkdRGbT/JDBxgfBbPMLsrCPq
	6/+klFxpH5yd7duQxaDauvx/ibdd/uj2UMTjFPhVpw==
X-Google-Smtp-Source: AGHT+IFAwras/5q0VvOZUk9UWGY3+BY3/wKRh1L8JwZ6ASI4z5GFzZVJNrivwyeVzgt8VVbE/bURl/p4KonsjXLC/aw=
X-Received: by 2002:a92:cd8d:0:b0:35f:b86c:cd27 with SMTP id
 r13-20020a92cd8d000000b0035fb86ccd27mr3009702ilb.0.1703026150019; Tue, 19 Dec
 2023 14:49:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
 <20231213-zswap-dstmem-v3-6-4eac09b94ece@bytedance.com> <CAF8kJuOv+k0TcKJhs8wEWi20=B84bomj5BvpUAHvj6k3A+WE5A@mail.gmail.com>
 <CAKEwX=P=frZmEXm26uTBN05gqLXoL-Shgk5P=EsMpYR16dW-sw@mail.gmail.com> <CAJD7tkb2gWz1uQ7C6NQ7mAB=QQgaKHSwDFr0XS9ZrGFPOP1tTQ@mail.gmail.com>
In-Reply-To: <CAJD7tkb2gWz1uQ7C6NQ7mAB=QQgaKHSwDFr0XS9ZrGFPOP1tTQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 19 Dec 2023 14:48:58 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPxCrJHE=7k0hBs7Caqhc=UvwyL0kh7Yk2e9Usboz1Vug@mail.gmail.com>
Message-ID: <CAF8kJuPxCrJHE=7k0hBs7Caqhc=UvwyL0kh7Yk2e9Usboz1Vug@mail.gmail.com>
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

On Tue, Dec 19, 2023 at 1:39=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> My main concern is that the struct name is specific for the crypto
> acomp stuff, but that buffer and mutex are not.
> How about we keep it in the struct, but refactor the struct as follows:

If it is the naming of the struct you are not happy about. We can
change the naming.

>
> struct zswap_ctx {
>     struct {
>         struct crypto_acomp *acomp;
>         struct acomp_req *req;
>         struct crypto_wait wait;
>     }  acomp_ctx;
>     u8 *dstmem;
>     struct mutex *mutex;
> };

The compression and decompression requires the buffer and mutex. The
mutex is not used other than compress and decompress, right?
In my mind, they are fine staying in the struct. I am not sure adding
an level acomp_ctx provides anything. It makes access structure
members deeper.

If you care about separating out the crypto acomp,  how about just
remove acomp_ctx and make it an anonymous structure.
struct zswap_comp_ctx {
    struct /* cryto acomp context */ {
        struct crypto_acomp *acomp;
        struct acomp_req *req;
        struct crypto_wait wait;
     };
     u8 *dstmem;
     struct mutex *mutex;
 };

Then we remove other per_cpu_load as well.

I also think the original struct name is fine, we don't need to change
the struct name.  The value/code_change ratio for renaming the struct
alone is low. On the other hand, if we can get rid of some per cpu
load, that value is high enough to justify the patch.

Chris

