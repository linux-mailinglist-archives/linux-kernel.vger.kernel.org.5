Return-Path: <linux-kernel+bounces-89200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D760186EBE5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B39B22483
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964F75E09E;
	Fri,  1 Mar 2024 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsHsVdBB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE58958AC5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709332431; cv=none; b=HBDXaGMjNXHjDf2wkuWWf2zXiIFnqCaQ9pCBLPxkuWDDsNKj//Y8yI9UQFA8T0unxf6yIFouUJeBqaQ3LQeVgGTHCr5YQLpgFn4B1TAHksQHzzx+dP3N0r8OEls0wcIaNPu9sZCRNwvLP7e1I9ANxMgUJF7JJo67rYC9Qj+iuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709332431; c=relaxed/simple;
	bh=Xmq8TeQQrb8mpdPSk45UUwi4Ba5qix3gX7GUStmGdD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXLu+ROh4Sj+zrauqsj3japSak6LBka1eDVHTdcYBhHwdFMbXLoackBObhllame6joQyjOaSBtvO0kNRMHdDkNRNoANZd0WnnhxYCWTA1snHaL9NqW9p5JUdsbD5oKpv3/aXZSjMfZDgsJcTUQykUW76jtLHqKP/X0gnwNw/SmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsHsVdBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79477C433A6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 22:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709332430;
	bh=Xmq8TeQQrb8mpdPSk45UUwi4Ba5qix3gX7GUStmGdD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rsHsVdBBlQePLwaK8JhC86Um7jNpfuGJ0aFzucCLgVuuzLbFzbSqnvg5wBFvV9qBa
	 oFhvn6WGLIC3rFWIwld3UwyNISGhZokVFOFGWdIKQFTddF0Ne+kXSKKwbAiCtQFVi/
	 MvRbvbd13f5jLOjsirvyiurlKzgyxacg1v93KelEIUr+5hfyM8TFLiNNmeUuxAYSca
	 37imKfBF9pzTO8W9316eizPpehHytkta7ka7C2JnzeNoh8eXyDRI8+T11jkv4T1S0a
	 U2AepUxfM2BM7CCumno7v7uLMqyNVzmME8UX63mgBjopeM0+H8w80D5CI8oE4EzJfB
	 MeIYh65Pt8trw==
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-365c9d37995so8797515ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 14:33:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBLlrUwHtfNKNu8wGRQEkLWR3vOKHXdJbFh1zoPqUshuEVMpgy56udL2Y5enWtCt8vv/16AwivtJD20CnfLV/FOEKqocfcVmScdRHO
X-Gm-Message-State: AOJu0Yzg/CxiQo0vTSgbhPvCGgQSXk+5vWS/sLVlVB2rMhNr5VBfSQNd
	VkNzXXuEacU7NJIdgSwXtvI3gPgerNTrnUDv2yfEkpI4UQqQ/jN5KHopkPGwvQdbO0cLVy0JIw5
	3gF5F2uHIs8Ual1QyB7LFZr6GxblW/uDpQHIy
X-Google-Smtp-Source: AGHT+IEp7Eia7BibydsJRMbMSfpoGmwaXHbtJEgO/watVl06PukEq7ZaStOqgB1P4nkv5ko+6O085mwoiptlhFNfnII=
X-Received: by 2002:a05:6e02:154d:b0:365:bff:adfa with SMTP id
 j13-20020a056e02154d00b003650bffadfamr4172675ilu.17.1709332429778; Fri, 01
 Mar 2024 14:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-zswap-xarray-v2-1-e50284dfcdb1@kernel.org> <26e77602326d4e169a9484314cac2465@AcuMS.aculab.com>
In-Reply-To: <26e77602326d4e169a9484314cac2465@AcuMS.aculab.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 1 Mar 2024 14:33:37 -0800
X-Gmail-Original-Message-ID: <CAF8kJuP1=n_U4VsPh9eezmta1gYKEt0vqAJSLFnxBFBV1DzHcA@mail.gmail.com>
Message-ID: <CAF8kJuP1=n_U4VsPh9eezmta1gYKEt0vqAJSLFnxBFBV1DzHcA@mail.gmail.com>
Subject: Re: [PATCH v2] zswap: replace RB tree with xarray
To: David Laight <David.Laight@aculab.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 1:58=E2=80=AFPM David Laight <David.Laight@aculab.co=
m> wrote:
>
> From: Chris Li
> > Sent: 29 February 2024 08:46
> >
> > Very deep RB tree requires rebalance at times. That
> > contributes to the zswap fault latencies. Xarray does not
> > need to perform tree rebalance. Replacing RB tree to xarray
> > can have some small performance gain.
> >
> > One small difference is that xarray insert might fail with
> > ENOMEM, while RB tree insert does not allocate additional
> > memory.
>
> What is the difference in kernel memory use?
> IIRC someone pointed out (in the rosebush thread) that xarray
> uses a lot of kernel memory if the items are randomly distributed.

Do you have any suggestions on what script I can run to collect that
information for you?

If the swapfile is fully utilized, then every 1G of swapfile space
will save about 4M of memory using xarray compared to RB tree. Every
swap entry saves about 2 pointers (ignoring the intermedia xarray
node)
Every 1G of swapfile, fully populated xarray pointer uses about 2M of
memory. The RB tree node (left pointer, right pointer, color) will use
about 6M of memory.
In the worst case, you are wasting at most 2M of memory on xarray for
every 1G of swapfile.
Hope that calculation helps.

Keep in mind that the swap cache is already using xarray, using the
same swap entry offset as index. So whatever memory waste caused by
the sparse distribution of the swap entry, you are already getting
that in the current swap cache.

Chris

