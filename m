Return-Path: <linux-kernel+bounces-92512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F6F872168
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B174D1C2299D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE3886642;
	Tue,  5 Mar 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Un4AFB2Y"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A586625
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648801; cv=none; b=ZHDr32XirDqibuKKpNbgSVEDS15tEB8hqr0cr4GSC+8YqMKZtGu4Sjric5E6OgYzseWoEId3shapeFNfaUW+3qa1taZAsJOZdDCVyYtzgOW8r3kjVej6hXC5b2pPEr+jNUkF8dK5hTfuUxCPTZNJKUSvyb1rF7v2nLJ77kvfu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648801; c=relaxed/simple;
	bh=ruqqX5qO4PFwwdwYGfmvAVa1H9eyuPYZRlafUStwf6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukf2bCk4LrOWHm7y5wZRIXf6AAz4sawqrTLtye/Rxsb0RUnWNodYUs/lBpd2udK4zq9TC40qejLlnyyV1E7/Xv3AAn0qSrZRd1RcE6L6LkTLHD04d0O7ZUXDZtdQLzJH/TV/qzOLuEsCbDf36xt8Iom4qcpXUBWE8YGbSBt/hLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Un4AFB2Y; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a441d7c6125so81633266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 06:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709648798; x=1710253598; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SNRQOholZ1nb17dk+3mdK/tk6Wz5FXAQ7vxevC3NaZU=;
        b=Un4AFB2YamB5LxK/Mbgglba/iZkVlri1AucJezXHouNw9PV4EIILwQrnFibLF85hPj
         2ut8XJc1A+SDJJIQIyMPqAI22QOV3WmWv/1Y9f78zwsnz9eguiKkyp82lR+5isbkAeFO
         d8bOPYPh54MSVi/kdZ4OgWFAaNXBLFAp7qGLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709648798; x=1710253598;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNRQOholZ1nb17dk+3mdK/tk6Wz5FXAQ7vxevC3NaZU=;
        b=igS/1MB37cLSB5bneKEQ1IVdMRPmK56lPRlQVunoz7TYn+KICUWwgNn4DfGzUAsRIa
         fUggMFf2O1fHIvgt7tRsXZCMAwou1+rN5Pi8B20yrmroVgaCW6TwJPPhrVM/LeKyh6LJ
         ASZqEo34eYhTOKjT0xN3GMXEzBRrUQHkgT2DYtXhtD+bxRHblYne+achWvseASjFWM1M
         FrhjEYjiktlcbJjtidvWOwT328vq/+NwMrq8J15EjXROUJJFMq+GsmqZfAio2K0OVhS8
         IglEvLQNpi5ojfpDIc5f2v8TfA5CgnbT0nj9MIkl0DQWrH6zrxNTo6dwcjxbxOCWYMiV
         B8XA==
X-Forwarded-Encrypted: i=1; AJvYcCWCaNrZy8LBK+UPpOqYvAE3PpdSEA4hrx7BfIR/kFKWuHUDgpPw0b0q7X7oL5HCBuy8/H3cCcr4MMlqI71dd3lVwfIsjKfK42EAt5Kp
X-Gm-Message-State: AOJu0YwkcSxUwMWKpKaE0YAPrkYP+GzI2pi1eNd5qtAkk6GJ9ZsBGwbm
	pQlJYjH60jo7ohl8ako6NCYpaxb3bgX+QDzJxFpF4c1MyUEJnkTTQ5llZ2gqEXYnnBgzVADN9gx
	S5g+VM/yeTok+lYnk3Q2dpv1MwJv2rCExecr0bw==
X-Google-Smtp-Source: AGHT+IHuyqTEJgnyqPan4wheohLar4swLZ64UBZctUdkezgVTSN0RNi2bvORob6BA4/dnKSg6dpA/SZJMZ8bnYgEkyI=
X-Received: by 2002:a17:906:688:b0:a45:16ec:66ef with SMTP id
 u8-20020a170906068800b00a4516ec66efmr4588337ejb.77.1709648798124; Tue, 05 Mar
 2024 06:26:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124070512.52207-1-jefflexu@linux.alibaba.com>
 <CAJfpegs10SdtzNXJfj3=vxoAZMhksT5A1u5W5L6nKL-P2UOuLQ@mail.gmail.com>
 <6e6bef3d-dd26-45ce-bc4a-c04a960dfb9c@linux.alibaba.com> <b4e6b930-ed06-4e0d-b17d-61d05381ac92@linux.alibaba.com>
 <27b34186-bc7c-4f3c-8818-ee73eb3f82ba@linux.alibaba.com>
In-Reply-To: <27b34186-bc7c-4f3c-8818-ee73eb3f82ba@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Mar 2024 15:26:26 +0100
Message-ID: <CAJfpegvLUrqkCkVc=yTXcjZyNNQEG4Z4c6TONEZHGGmjiQ5X2g@mail.gmail.com>
Subject: Re: [PATCH] fuse: increase FUSE_MAX_MAX_PAGES limit
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangjiachen.jaycee@bytedance.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Feb 2024 at 05:00, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>
> Hi Miklos,
>
> On 1/26/24 2:29 PM, Jingbo Xu wrote:
> >
> >
> > On 1/24/24 8:47 PM, Jingbo Xu wrote:
> >>
> >>
> >> On 1/24/24 8:23 PM, Miklos Szeredi wrote:
> >>> On Wed, 24 Jan 2024 at 08:05, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> >>>>
> >>>> From: Xu Ji <laoji.jx@alibaba-inc.com>
> >>>>
> >>>> Increase FUSE_MAX_MAX_PAGES limit, so that the maximum data size of a
> >>>> single request is increased.
> >>>
> >>> The only worry is about where this memory is getting accounted to.
> >>> This needs to be thought through, since the we are increasing the
> >>> possible memory that an unprivileged user is allowed to pin.
> >
> > Apart from the request size, the maximum number of background requests,
> > i.e. max_background (12 by default, and configurable by the fuse
> > daemon), also limits the size of the memory that an unprivileged user
> > can pin.  But yes, it indeed increases the number proportionally by
> > increasing the maximum request size.
> >
> >
> >>
> >>>
> >>>
> >>>
> >>>>
> >>>> This optimizes the write performance especially when the optimal IO size
> >>>> of the backend store at the fuse daemon side is greater than the original
> >>>> maximum request size (i.e. 1MB with 256 FUSE_MAX_MAX_PAGES and
> >>>> 4096 PAGE_SIZE).
> >>>>
> >>>> Be noted that this only increases the upper limit of the maximum request
> >>>> size, while the real maximum request size relies on the FUSE_INIT
> >>>> negotiation with the fuse daemon.
> >>>>
> >>>> Signed-off-by: Xu Ji <laoji.jx@alibaba-inc.com>
> >>>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> >>>> ---
> >>>> I'm not sure if 1024 is adequate for FUSE_MAX_MAX_PAGES, as the
> >>>> Bytedance floks seems to had increased the maximum request size to 8M
> >>>> and saw a ~20% performance boost.
> >>>
> >>> The 20% is against the 256 pages, I guess.
> >>
> >> Yeah I guess so.
> >>
> >>
> >>> It would be interesting to
> >>> see the how the number of pages per request affects performance and
> >>> why.
> >>
> >> To be honest, I'm not sure the root cause of the performance boost in
> >> bytedance's case.
> >>
> >> While in our internal use scenario, the optimal IO size of the backend
> >> store at the fuse server side is, e.g. 4MB, and thus if the maximum
> >> throughput can not be achieved with current 256 pages per request. IOW
> >> the backend store, e.g. a distributed parallel filesystem, get optimal
> >> performance when the data is aligned at 4MB boundary.  I can ask my folk
> >> who implements the fuse server to give more background info and the
> >> exact performance statistics.
> >
> > Here are more details about our internal use case:
> >
> > We have a fuse server used in our internal cloud scenarios, while the
> > backend store is actually a distributed filesystem.  That is, the fuse
> > server actually plays as the client of the remote distributed
> > filesystem.  The fuse server forwards the fuse requests to the remote
> > backing store through network, while the remote distributed filesystem
> > handles the IO requests, e.g. process the data from/to the persistent store.
> >
> > Then it comes the details of the remote distributed filesystem when it
> > process the requested data with the persistent store.
> >
> > [1] The remote distributed filesystem uses, e.g. a 8+3 mode, EC
> > (ErasureCode), where each fixed sized user data is split and stored as 8
> > data blocks plus 3 extra parity blocks. For example, with 512 bytes
> > block size, for each 4MB user data, it's split and stored as 8 (512
> > bytes) data blocks with 3 (512 bytes) parity blocks.
> >
> > It also utilize the stripe technology to boost the performance, for
> > example, there are 8 data disks and 3 parity disks in the above 8+3 mode
> > example, in which each stripe consists of 8 data blocks and 3 parity
> > blocks.
> >
> > [2] To avoid data corruption on power off, the remote distributed
> > filesystem commit a O_SYNC write right away once a write (fuse) request
> > received.  Since the EC described above, when the write fuse request is
> > not aligned on 4MB (the stripe size) boundary, say it's 1MB in size, the
> > other 3MB is read from the persistent store first, then compute the
> > extra 3 parity blocks with the complete 4MB stripe, and finally write
> > the 8 data blocks and 3 parity blocks down.
> >
> >
> > Thus the write amplification is un-neglectable and is the performance
> > bottleneck when the fuse request size is less than the stripe size.
> >
> > Here are some simple performance statistics with varying request size.
> > With 4MB stripe size, there's ~3x bandwidth improvement when the maximum
> > request size is increased from 256KB to 3.9MB, and another ~20%
> > improvement when the request size is increased to 4MB from 3.9MB.

I sort of understand the issue, although my guess is that this could
be worked around in the client by coalescing writes.  This could be
done by adding a small delay before sending a write request off to the
network.

Would that work in your case?

Thanks,
Miklos

