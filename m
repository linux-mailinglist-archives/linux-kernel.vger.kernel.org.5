Return-Path: <linux-kernel+bounces-72347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB2185B248
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D058E1C22283
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0A757307;
	Tue, 20 Feb 2024 05:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lSqx05cC"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6011E56B7A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407153; cv=none; b=MmQ6M6iyeZripptow7zSqA6iRI+nvuiIyHUeFAkON+75YOQa2ybgB7BaWpqbA7VwaJCzl5skYwqnux5u9XApLkwHhaA+SnwoGO+LrDU1foI1O6sSPQfcX2jA50HsmiX93IyRSbEHiCZETG+lDMj1I7qWicV6lsftbql18qdxA9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407153; c=relaxed/simple;
	bh=pPHyangQzCJjkuuFPVNawzn4jxC6YKYTBAaLQLQKe0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HP/UiOJ5wj33rFgrjgXoO5NsTCZnQ5pjQnVZA8V1t36rVUWtki1DHZP3rkwxJfOimwU/3a1BK229D9h/Gci3dSNy1K3hLu1SlimcEhg5UOiQPEjgp26fdfH08ChY2R9pu94ZlDX00v25890kE9dd5O+Kie1WUqNpM+pPgCIaQog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lSqx05cC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563dd5bd382so23196a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 21:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708407149; x=1709011949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3+XfROI6UN39rRUotWgXtf+nheeE0Tx9oupQKB8Px8=;
        b=lSqx05cCZZ/1yDRVeOkLyRQTLxTuf7nupp2TLOfTQKpPrSRBi98ZeLr+DQT9+uijha
         6mjUG3pTTfCjfngF8q7eEsTFNYPb4tpbBTnae9FQ0H4UzIrUVmlvOdK0LFoHFOkA2R/y
         Nd7LGZRBsUCuguKgA3pGo+xXSs4FCwXvt/CxR05S+GWgj0xXjDggFLPyGKeqlJNozkRv
         w8fOsi6FWRtAOZBEtg+EHPeZ5CmoA+GAEPfZIscRcZd6ahZlJoHhQDUODQg4iXVe67nC
         2+6mXSXY3zAdTWuGthQi3prG0bmQLW/LfX+lzCSvsYFmSL585DaaxsX74bsOzZimf3o9
         EvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708407149; x=1709011949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3+XfROI6UN39rRUotWgXtf+nheeE0Tx9oupQKB8Px8=;
        b=OZMCyO2hMn2xv3U8xKX4YmTUJSry6KMHR+zzN1DdNHxj8UoYHurqdjS3M/jafhv+jy
         bmDVRUGSIq+YtA/PiXCOfOWAHas0ecF3sdjDiAZeCpb7eP+Oi/DCzkVh6cdHQQeLzoMk
         Hr1VArrOpv8P4KDoSzB4TDm+nzjX0H8L7vjyactpi8dD1ltelnMUW0mVsxkoNvr0SXtl
         n11gugrEKyWBgNbEXGNkTm0tPuHcItNO36gWElbizwxybotBQhLemONTK2BsUlOoclqZ
         TSYytDr4dVoxaACBYXL8YUJ7yFdrbs6Yya+RuXDHcYSZzJkE27DUNk02omcAHX5eZcgg
         vZHw==
X-Forwarded-Encrypted: i=1; AJvYcCUw/05OUfuRQgFxNEd1QJOTbdEQrfJB4vxTsLL/whVVF3zdClIxFHmBpPenLMIoSNTeuuk72ZT+pymVPta54t159+N6+uuxDFT/02/b
X-Gm-Message-State: AOJu0YyZN8kyTKflZVYopVoqkyCprckquLne5qfyohUkIl54Cugml6nz
	6Wly97fwfvPnVxf8Uc4rqwp10D/q1lT3HM4bDtHGEd9XMZQYNnuFDdhf5RKCoVXrVnga2uZvXa5
	O1mcJfDk13Mux/RH+e9Jbo7ob48weC4gMBO7p
X-Google-Smtp-Source: AGHT+IHWMys5PT/uTDQr26DhAulCFOmCycvpdp6mCZ3KVNl6GWqbqFr8UJrKPplZ89ESB5vmph8bk/x4zOxTMOHTgEQ=
X-Received: by 2002:a50:aa91:0:b0:561:a93:49af with SMTP id
 q17-20020a50aa91000000b005610a9349afmr361020edc.7.1708407148864; Mon, 19 Feb
 2024 21:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220021804.9541-1-shijie@os.amperecomputing.com>
In-Reply-To: <20240220021804.9541-1-shijie@os.amperecomputing.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Feb 2024 06:32:15 +0100
Message-ID: <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com>
Subject: Re: [PATCH] net: skbuff: allocate the fclone in the current NUMA node
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: kuba@kernel.org, patches@amperecomputing.com, davem@davemloft.net, 
	horms@kernel.org, ast@kernel.org, dhowells@redhat.com, linyunsheng@huawei.com, 
	aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, cl@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 3:18=E2=80=AFAM Huang Shijie
<shijie@os.amperecomputing.com> wrote:
>
> The current code passes NUMA_NO_NODE to __alloc_skb(), we found
> it may creates fclone SKB in remote NUMA node.

This is intended (WAI)

What about the NUMA policies of the current thread ?

Has NUMA_NO_NODE behavior changed recently?

What means : "it may creates" ? Please be more specific.

>
> So use numa_node_id() to limit the allocation to current NUMA node.

We prefer the allocation to succeed, instead of failing if the current
NUMA node has no available memory.

Please check:

grep . /sys/devices/system/node/node*/numastat

Are you going to change ~700 uses of  NUMA_NO_NODE in the kernel ?

Just curious.

>
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  include/linux/skbuff.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 2dde34c29203..ebc42b2604ad 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1343,7 +1343,7 @@ static inline bool skb_fclone_busy(const struct soc=
k *sk,
>  static inline struct sk_buff *alloc_skb_fclone(unsigned int size,
>                                                gfp_t priority)
>  {
> -       return __alloc_skb(size, priority, SKB_ALLOC_FCLONE, NUMA_NO_NODE=
);
> +       return __alloc_skb(size, priority, SKB_ALLOC_FCLONE, numa_node_id=
());
>  }
>
>  struct sk_buff *skb_morph(struct sk_buff *dst, struct sk_buff *src);
> --
> 2.40.1
>

