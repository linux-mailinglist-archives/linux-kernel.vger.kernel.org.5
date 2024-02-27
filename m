Return-Path: <linux-kernel+bounces-82865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E725F868AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2AD21C21127
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A9D77F2E;
	Tue, 27 Feb 2024 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="FDMdmr3K"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5741F77F28
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022702; cv=none; b=qifDbLeajEOmsqqda9MvrDPzduXv1POH7ankBBuVAQszHFe9hbWmeHpQxx6aINZjiP9Pd/ggCA/WnLfAIGlEKRyXXtJ3m3/AIzwnR5BlsycREF17VKGECoBmr48cGkSNdU/Msw2ivOjC3+zs1qB8XZwId8GmiRW3c4B5t068DH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022702; c=relaxed/simple;
	bh=jDcbjm051a2tWQp8mL4nW0pJ4OpF8SkO3jnpo60IyWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1hFY4Jsiyi8CmLbNvtUvT/k+KWWqpIBrxR/JoUbWiOy+qfC+coJDxybGGhR8Wg+bXw3uXuCivITRVOzMm72iAVfnidx/gE7n8C42T4lpXnYw8hrC1RX45Z0l13ryDhnOlKvXJopad6F14/JC4gXBmLyRDfv6Iv0oFzHhQ3tqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FDMdmr3K; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3e5d82ad86so552281566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709022699; x=1709627499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWWjdMDDlRbFnAQIhSeSTyA3KAYjkYko4A1TtZtt+H4=;
        b=FDMdmr3KSIObla6tr5cpWU8/WvK6jUhXBFd4fZ4PKjVrz7m7KR6REXxNEG2jm6r6ff
         h8q8NvTaxF7SERE8CMYtoE9FQxSRtIRSn40uAeBtZIqPjfhltezD+3/DQu2I4MqAlmw4
         J2ADb1hZT8SyrHVmtUnQHqjuORE7w+BgWvjQ0tOCGGjv3IdhVjJbGe5dO++mCJwH7yqG
         BpaWcN+WR/kx9V2yCg+EA7Fg8Tmlx9j/Ht2dM6jAWQ1AKxST99qPZHzPD/e9TJaCYE2n
         KRwHdw4NUAvTKM5dc3PtKYBHct8U4ob5tb49mJ3kkM2iZz/fchdarjVnTDsxGgYBJs4o
         PdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709022699; x=1709627499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWWjdMDDlRbFnAQIhSeSTyA3KAYjkYko4A1TtZtt+H4=;
        b=f4AFwbfWJ4jfKESrlTc3vshNgRtEO/JKZUBFFtDy3LRcA+jQgaQAtmfcoFvFkS54Bd
         J9GAAEe1UC3A5eHFiKReBgorOXK9LQwHvPEt3Jg9W1vrla1HBMTLDLWhQGWuNzsRJKSz
         vYm1LOEaYBBRDdNIbGLJzGk/5fCDxOGkkG9zqm6QH+StwzHbdRxv0VwGx4NS1ncpGpAv
         8556Ez3dU6Ii1pB9tKEkJe2MpTAp8srrBpsI+cStTtg4/bu2FbcYboQ+D2plgJ6S/4gw
         MEvvDQjeiagRKuAvZ37g++9Dd9kGFm+FeIQ4aU/aqpj0KvU1QjWRhhsBc8gmw+w9LiBE
         eaoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVroT64QP45hwBXEtFzMPiWQ/ArM92x7h5bfgZpQzqqiD4LbYchxwYALSpyN+LT2oSctz2qp+ApW8v+19UymbmvTLfSuKJf3vU7jN06
X-Gm-Message-State: AOJu0YzkO07GKUv1PUMcHvBYBNiCBMp0DLXFl6kI9IOgwteAPg+K9HNK
	iIJkqdbW6Vn8bkpUqh9x6f6s3jxBg5xr6VirDw3qN9yfdEa/4hLAvXA3gIUQF4KSOXprscfm1tZ
	VYKIUEVQRsU7NxXMrDJi2o0/WXJ3CAEjs4h9Z
X-Google-Smtp-Source: AGHT+IEywMFCEF6R2EVKftvTDUWpnQPHNLoR6/60VpqwpXfH1fWVVUY+TrWJGh0aKLi+cUFG+WVi9V07kMYmfjg2/r8=
X-Received: by 2002:a17:906:7243:b0:a43:a628:ff31 with SMTP id
 n3-20020a170906724300b00a43a628ff31mr909690ejk.26.1709022698526; Tue, 27 Feb
 2024 00:31:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206042408.224138-1-joychakr@google.com> <2024020647-submarine-lucid-ea7b@gregkh>
 <CAOSNQF3jk+85-P+NB-1w=nQwJr1BBO9OQuLbm6s8PiXrFMQdjg@mail.gmail.com>
 <2024020637-handpick-pamphlet-bacb@gregkh> <CAOSNQF2_qy51Z01DKO1MB-d+K4EaXGDkof1T4pHNO10U_Hm0WQ@mail.gmail.com>
 <2024020734-curliness-licking-44c1@gregkh> <CAOSNQF2WKang6DpGoVztybkEbtL=Uhc5J-WLvyfRhT3MGWgiaA@mail.gmail.com>
 <CAOSNQF2d27vYTtWwoDY8ALHWo3+eTeBz7e=koNodphVVmeThMQ@mail.gmail.com> <2024022737-haiku-rental-5e7b@gregkh>
In-Reply-To: <2024022737-haiku-rental-5e7b@gregkh>
From: Joy Chakraborty <joychakr@google.com>
Date: Tue, 27 Feb 2024 14:01:25 +0530
Message-ID: <CAOSNQF1_7p61pgGBcb0QWmCLCBfNAk2-gQ4qFybfbbxON3n5pw@mail.gmail.com>
Subject: Re: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh@kernel.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, linux-kernel@vger.kernel.org, manugautam@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 1:02=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 27, 2024 at 12:27:09PM +0530, Joy Chakraborty wrote:
> > On Wed, Feb 7, 2024 at 8:33=E2=80=AFPM Joy Chakraborty <joychakr@google=
com> wrote:
> > >
> > > On Wed, Feb 7, 2024 at 3:04=E2=80=AFPM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Feb 06, 2024 at 05:22:15PM +0530, Joy Chakraborty wrote:
> > > > > > > Userspace will see a false error with nvmem cell reads from
> > > > > > > nvmem_cell_attr_read() in current code, which should be fixed=
 on
> > > > > > > returning 0 for success.
> > > > > >
> > > > > > So maybe fix this all up to allow the read to return the actual=
 amount
> > > > > > read?  That feels more "correct" to me.
> > > > > >
> > > > >
> > > > > If I change the behavior of the nvmem_reg_read_t callback to nega=
tive
> > > > > for error and number of bytes actually read for success then, oth=
er
> > > > > than the core driver I would also have to change all the
> > > > > nvmem-provider drivers.
> > > > > Is it okay to do so ?
> > > >
> > > > Sure, why not?  That seems like the correct fix to me, right?
> > >
> > > Sure, I can do that.
> > >
> > > Is it okay to change the if checks on the return code to "if (rc < 0)=
"
> > > instead of "if (rc)" as a fix for the immediate issue with how return
> > > value from rmem is handled which can be applied to older kernels.
> > > In a separate patch I can change the definition of nvmem_reg_read_t()
> > > to return ssize_t instead of int and make corresponding changes to
> > > nvmem-provider drivers.
> > >
> > > Does that sound okay ?
> >
> > Hi Greg,
> >
> > Sent a patch https://lore.kernel.org/all/20240219113149.2437990-2-joych=
akr@google.com/
> > to change the return type for read/write callbacks.
> > Do I mark that with the "Fixes:" tag as well ?
>
> Is it actually fixing a bug?  Or just evolving the api to be more
> correct over time?  I think the latter.

It is more of the latter i.e. evolving the API to be correct but
indirectly it ends up fixing this bug where positive value returned by
this rmem driver is treated as an error in nvmem core.

>
> > It affects a lot of files so might not be able to easily pick to an
> > older kernel when needed.
>
> What is it fixing that older kernels need?

It is fixing the handling of a positive value returned by this rmem
driver which will be treated as an error in older kernels as the nvmem
core expects 0 on success without changing API behavior.

>
> And do not worry about stable kernels while doing development, only
> take that into consideration after your changes are accepted.

Got it, thank you for your input .

>
> thanks,
>
> greg k-h

Thanks
Joy

