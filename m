Return-Path: <linux-kernel+bounces-25195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFB882C95F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 05:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7181C2280F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 04:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B9FF4FC;
	Sat, 13 Jan 2024 04:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UjMqfJdV"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8D2EAF5
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 04:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bd4f062aa2so1212932b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 20:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705121524; x=1705726324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRzVjE/60hfoJmBpHx7JmI7NVqzyKuJ6EGRYVVIYHyE=;
        b=UjMqfJdV8x7S+D4gIOJebINqm1UTCTvejoRiAJ1qA3bqWpGcYb2IRBxK0GNdDJvvVV
         N2QHNk/UqxXbzcfkRkeJoKB1yRgKapI9IaWA9tD6ROo3ZY9716wDJK4Q/PKXvjvbAov6
         OnY35t8wVpCfzOxQq/XjC88dBDXwp0+xNw4WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705121524; x=1705726324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRzVjE/60hfoJmBpHx7JmI7NVqzyKuJ6EGRYVVIYHyE=;
        b=sffqZP/c/gjQSgR4khW47zNgSzYWNaJhLZFOXImdTB8Ru/Mr8jPzz45KfRQ0yQDAWW
         B+L7Lx21t4lwKiZpTu0RMrw5U707/APLx5SgTLs9Ao2G/B7fpaoN5i+70x/7r3THBz1X
         uqiea0eB4qpSBQ1QJ9r1kUJiywgypi5RHpKwKuHEQN7o/jBtO1ll9GzcAQ4EcM7PpulO
         E2yprZZ+/K6qD4wC3ZBM5gH45ltIj2wAwrzvN41Hx5oWsqL4qeDBMUkZQZO9PiKgZFNO
         7z27ZTmv/RXefJd4LTGTtJM0DQ8CydqXvfoi+jbkDlQJnfx0qYvsMcM0KrYjnTulW8o9
         mkNw==
X-Gm-Message-State: AOJu0YxapH3H1hnE8pnFUva+0g9adpz4FanXf/FKeArvByHok1zqXNdA
	gMkxy1fUqrjU8qHQmpu9n2pzQ0zlHiAHfowHq2SuYCdG6iIg
X-Google-Smtp-Source: AGHT+IEdaiJcCRLapVikT9wJgN0tDnSDzzD4ce1+B39OTXVVa6pay9HsBvUgQn35yTvGDp6kcRfdFxzZi0JF2T7blZk=
X-Received: by 2002:a05:6808:2092:b0:3bd:646d:4366 with SMTP id
 s18-20020a056808209200b003bd646d4366mr816782oiw.19.1705121524684; Fri, 12 Jan
 2024 20:52:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111234142.2944934-1-jeffxu@chromium.org> <20240111234142.2944934-5-jeffxu@chromium.org>
 <8cb16dfe-993e-4c41-b1fe-63bc7ac97609@infradead.org>
In-Reply-To: <8cb16dfe-993e-4c41-b1fe-63bc7ac97609@infradead.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 12 Jan 2024 20:51:53 -0800
Message-ID: <CABi2SkWdp5UpKmrWV5Y-v_XTVWJvhxq0nSXmK9jV2UDUXLWFyA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] mseal:add documentation
To: Randy Dunlap <rdunlap@infradead.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 5:10=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi Jeff,
>
>
> On 1/11/24 15:41, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add documentation for mseal().
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  Documentation/userspace-api/mseal.rst | 181 ++++++++++++++++++++++++++
> >  1 file changed, 181 insertions(+)
> >  create mode 100644 Documentation/userspace-api/mseal.rst
> >
>
> To prevent the following documentation build warning:
>
> linux-next-20240112/Documentation/userspace-api/mseal.rst: WARNING: docum=
ent isn't included in any toctree
>
> please add the following to your patch 4/4:
>
OK. will do.


> diff -- a/Documentation/userspace-api/index.rst b/Documentation/userspace=
-api/index.rst
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -23,6 +23,7 @@ place where this information is gathered
>     ebpf/index
>     ELF
>     ioctl/index
> +   mseal
>     iommu
>     iommufd
>     media/index
>
> --
> #Randy

