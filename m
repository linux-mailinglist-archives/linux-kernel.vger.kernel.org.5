Return-Path: <linux-kernel+bounces-88463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3816E86E1F1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB921B21235
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1FC6D1D7;
	Fri,  1 Mar 2024 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+Q2+3Fy"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445AD69E15
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299554; cv=none; b=QhH5mI7B3a5ZJhH1ExB5VgbfydCS42gmC32a9/E8oQNM52mLXGvZFakWp/BYhjh65fXQ3fdOzoKlZMQhyN7gWeovups3tD1p3dib16oswmzGB1IfsMNCjW7fyIFPLoMYtNjI+8575ctmE0kWd/QxOYHzLibUJRtvYTuEg6A1kqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299554; c=relaxed/simple;
	bh=JHWldWA6nNHKcTRlr05zV/nwVzVNIlbYVSMFB9iJlos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uq59DvWIVT7b/fG/vE5IpTZoiM1qbjDo76u69zXNipWG2TA1nNK+4KJ58qQQ0gBA4Aiozbj/+Y8mOiodTmCXG1tTpuk6fe1fB4Ep3Wof2wqTLuzR9BrGbJdN0YScrCCyn0kKtgrExe6SgdNsNuessdk+w2yfjjXUDo5Hb/ehmvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+Q2+3Fy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso10595a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 05:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709299552; x=1709904352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1teAiWc1jVGCssi6rgN3jeMMtmC7N9NmiOj97TQSRI=;
        b=B+Q2+3FyhzzHOF8F2GLt2wkZhMidxgsedxhsBtInm8nvf198JXT1DWUuF0u/356Wxn
         bHie3f4Uu/XHdrg+Vfa953FWhqx8oTkSxkHOqiW2KnCzAx7R4cD2NPj2TsXquakIjDcE
         76UQQglv9A6OGSz2uwzZkR8KRPH8tPj4ZZe2hogP5p7bxSCh5+f3aUvhHjuq5MZHp8P7
         7M2KrYJhNfbtyRCQP89PQJ/FD9VfpkinyagzG8V2v+DAKiZ7P84LOwrPvC5bXiBAILiy
         Ra0kWb1lgODBF7kJQfvGMA3m9OzYX4TpQbrPd4MRKf2eJIzvsx2D4eOV8BvrxHB8P7Su
         094A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709299552; x=1709904352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1teAiWc1jVGCssi6rgN3jeMMtmC7N9NmiOj97TQSRI=;
        b=GfQi5gzmYuTpUiEEB4j2+nY/eKOi0/q9wrTuo5tSJSxMDDK84iXVjUYVf4GU0NQ2uZ
         8pFFBFa4Stkpjx1fsVOWRJLYdtVNTinzRl7CpOVSkLumGRXBSPQE7YfeG+dWo6FnQSMq
         LTSHTgjlUhREK8NHfGrZsMAZZ5zkfD9fe7i3kEWxOgfKrnoaaRVx/bKlZQ3MchcCsgxW
         eAhyAfAgtmKeTIrCQO+BMR+JJKn1W6AxyTTrFYAcNZhcjS5AEWItkucMRc7pKMCKdO8P
         2WpkH0le/0zenY8SCTup50uGTpHroJMKzW5u1OIcYM9BeSZlGNLNPKqxa3LLP819TsBa
         tDnA==
X-Forwarded-Encrypted: i=1; AJvYcCUAzYVln4lFjjM0cNj7QwXGBHZb1tgyAXzz91f6Ils5xu37XYACaQiKIfyFnAJXBjYCBkpJrG9etHo2It6R5ld4q2iTrtc9sOcqK2Bf
X-Gm-Message-State: AOJu0YyvDj/tQyMzXi5bkwm0acvSNhEsToH+a60bj1jbQZw2Qishs+/P
	BOyb2bdo3xyM5Y2tunFSDNJEST9GyEHhB480R3wKZS81btgzIZFSU8hCEitL7la8f5n5k2l+Yt5
	jenr50KPvbcmdzLgNG8bhMSkupuLKsNM7gkGf
X-Google-Smtp-Source: AGHT+IHAr/zt6nB351plwUC26OzlBDCvnjhX4XuWJqRSF9vysrKL8/mndZ7DIMKjrKSevJ2zGGPoqI2B9cbCF0OdxRw=
X-Received: by 2002:a05:6402:350e:b0:563:f48a:aa03 with SMTP id
 b14-20020a056402350e00b00563f48aaa03mr141224edd.2.1709299551406; Fri, 01 Mar
 2024 05:25:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229213018.work.556-kees@kernel.org> <20240229225910.79e224cf@kernel.org>
 <CANn89iKeJGvhY0K=kLhhR39NVbaizP2UBk0Vk0r_XCe2XMBZHg@mail.gmail.com> <9050bdec-b34a-4133-8ba5-021dfd4b1c75@intel.com>
In-Reply-To: <9050bdec-b34a-4133-8ba5-021dfd4b1c75@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 14:25:37 +0100
Message-ID: <CANn89iLSLPn5PyXNQcA2HO0e5jGYvHKhTh_9_EMmfbTJKZPfbg@mail.gmail.com>
Subject: Re: [PATCH] netdev: Use flexible array for trailing private bytes
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Kees Cook <keescook@chromium.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, netdev@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, Coco Li <lixiaoyan@google.com>, 
	Amritha Nambiar <amritha.nambiar@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 1:59=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Fri, 1 Mar 2024 09:03:55 +0100
>
> > On Fri, Mar 1, 2024 at 7:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >>
> >> On Thu, 29 Feb 2024 13:30:22 -0800 Kees Cook wrote:
>
> Re WARN_ONCE() in netdev_priv(): netdev_priv() is VERY hot, I'm not sure
> we want to add checks there. Maybe under CONFIG_DEBUG_NET?
>
> >
> >>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> >>> index 118c40258d07..b476809d0bae 100644
> >>> --- a/include/linux/netdevice.h
> >>> +++ b/include/linux/netdevice.h
> >>> @@ -1815,6 +1815,8 @@ enum netdev_stat_type {
> >>>       NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
> >>>  };
> >>>
> >>> +#define      NETDEV_ALIGN            32
> >>
> >> Unless someone knows what this is for it should go.
> >> Align priv to cacheline size.
> >
> > +2
> >
>
> Maybe
>
> > #define NETDEV_ALIGN    L1_CACHE_BYTES
>
> #define NETDEV_ALIGN    max(SMP_CACHE_BYTES, 32)

Why would we care if some arches have a very small SMP_CACHE_BYTES ?
Bet it !

IMO nothing in networking mandates this minimal 32 byte alignment.

>
> ?
>
> (or even max(1 << INTERNODE_CACHE_SHIFT, 32))

I do not think so.

INTERNODE_CACHE_SHIFT is a bit extreme on allyesconfig on x86 :/
(with CONFIG_X86_VSMP=3Dy)


>
> >
> > or a general replacement of NETDEV_ALIGN....
> >
> >
>
> + I'd align both struct net_device AND its private space to
> %NETDEV_ALIGN and remove this weird PTR_ALIGN. {k,v}malloc ensures
> natural alignment of allocations for at least a couple years already
> (IOW if struct net_device is aligned to 64, {k,v}malloc will *always*
> return a 64-byte aligned address).

I think that with SLAB or SLOB in the past with some DEBUG options
there was no such guarantee.

But this is probably no longer the case, and heavy DEBUG options these
days (KASAN, KFENCE...)
do not expect fast networking anyway.

