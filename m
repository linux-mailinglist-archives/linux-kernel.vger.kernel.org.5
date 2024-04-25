Return-Path: <linux-kernel+bounces-157969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF1E8B1984
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A23ACB23D90
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435C822EE5;
	Thu, 25 Apr 2024 03:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihbdCygi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05898381B8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015671; cv=none; b=FUJjgsgUUCNoeWpwdDrZCe3CttHsMnJWLctbwdtggMXlwfA4a+RqIINw10PJ6yfmLseTqNFnaZgI3QQHeNiee/yeaj19asrnLtXGNTIWAmq3+pvHKXSrc4ZHtLFNKdam9f8CkPCdIVSSrG3lSVNPrK5c+A/tRyZj61yDcihh34E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015671; c=relaxed/simple;
	bh=bWSmUlxpy5chU36ujG9zh3zLE+Cbg/C6ozI8EtQmNdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d10fkIzmXi3DIUGV5pwrU17Dg2m7v52toDDeCglnLODrCuJPfu4gUoRyW8nztpjonS3K0wn875aZsXYIdBupF/r6qag82hBvx9+6MPWV3Iihd42rSUWCzaAKjmq6l0qUnouEb75VQ8mxTwP2f6j1VdQdx8sQ4QoAysx+3qj50Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ihbdCygi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714015668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWSmUlxpy5chU36ujG9zh3zLE+Cbg/C6ozI8EtQmNdo=;
	b=ihbdCygiSY0LyPg4qZynwCPGmnVVaIm+FVUAA56um/yj7vzd3+T6SZs9b9pfRd9SezSpew
	/Qj3R/Vf3AVJNta+arh8UDCa78WNUVJLQoKyOcL7Bivqy7/GLZnLsb1ExgWlNZLSIIxy2s
	5vhB3McU6Vd6fvBTTsE0hC8i3X5bmUk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146--XvIIJALOVaBCWLE2rEMvw-1; Wed, 24 Apr 2024 23:27:41 -0400
X-MC-Unique: -XvIIJALOVaBCWLE2rEMvw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a58bbfd44f7so1064066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714015660; x=1714620460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWSmUlxpy5chU36ujG9zh3zLE+Cbg/C6ozI8EtQmNdo=;
        b=WgJyJFlYkHeGbEVPGZK2h6ux7vXquYUq/KkEHnWpJT3gCzMbX0JF9hGm9SV8nQu0P5
         zSu9Bhm1AEbicvpStuTA2P4rlymY1HVMP3F5HWQREeMdX3pwoPx2WoLGgbm1Oj/AbLyJ
         UFJnWTGTjFfdXtiqZEzivoHo+4fBZ6jDAeS8eSMvnfwneqP00MNmtZMj8QOhYY8qaJNr
         ThPXIGKeMVuBIVgsDQHfBImdAVN9UnlesGFlJsQCEQIs0xchEazojW4aBZg0fwXZ3Xlh
         VwjXv75pcWTaRNp7fXabPkUJ0wOvgTT/6HALBp8Maa95vJp3mj/celQC9tNs9xGn5Pkn
         ay6g==
X-Forwarded-Encrypted: i=1; AJvYcCUClHGnREkCIM7zRRs6FtpjFWw0W5neOdfZ2LZCWi8lRZQBoH7erGzph/2E2mNLbewzrhhkGuqlMGSNe+B8kZNh0CGD9vqt+yEkUyQg
X-Gm-Message-State: AOJu0Yzs1zPAJ6qI9mDFzqPRWIyPC+sSGvU69PPnoktr3mnI4x2f0E5h
	YpGqVTGgXHi+NSJgMdvzIwRUjJ6UHw5ErUvZBcissrPxgwEfPkXBa26mAk+ssLA9fIotTAn6LLF
	IKXr0NTumo0EDq8oUArT/U0Krqq0krexARILwnYNbGXhD8yNHRVX/mnihjfROnl8WAxykY+wg6A
	aWVisL/N3GWNKhBgBEldwUvRQRTq962Z1QenEy
X-Received: by 2002:a17:906:480d:b0:a51:d204:d69e with SMTP id w13-20020a170906480d00b00a51d204d69emr2791128ejq.7.1714015660129;
        Wed, 24 Apr 2024 20:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPtP2jLSqClgtPj4M56kdlZeBO+5l40Gy1g8sabQb/6hAodyZM3zbt7TnPaVinyQrLiG6LY+/bY5NEzTPbikE=
X-Received: by 2002:a17:906:480d:b0:a51:d204:d69e with SMTP id
 w13-20020a170906480d00b00a51d204d69emr2791116ejq.7.1714015659871; Wed, 24 Apr
 2024 20:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
 <5d81d6d0-5afc-4d0e-8d2b-445d48921511@linux.dev> <CAO7dBbXLU5teiYm8VvES7e7m7dUzJQYV9HHLOFKperjwq-NJeA@mail.gmail.com>
 <b6c0bd81-3b8d-465d-a0eb-faa5323a6b05@amazon.com> <20240326153223.GF8419@ziepe.ca>
 <0e7dddff-d7f3-4617-83e6-f255449a282b@amazon.com> <20240403154414.GD1363414@ziepe.ca>
In-Reply-To: <20240403154414.GD1363414@ziepe.ca>
From: Tao Liu <ltao@redhat.com>
Date: Thu, 25 Apr 2024 11:27:03 +0800
Message-ID: <CAO7dBbX0ZBwSzvi=ftNHe73hPP6Ji2WWTsKKYmD2tZENMjH_bw@mail.gmail.com>
Subject: Re: Implementing .shutdown method for efa module
To: Jason Gunthorpe <jgg@ziepe.ca>, "Margolin, Michael" <mrgolin@amazon.com>
Cc: Gal Pressman <gal.pressman@linux.dev>, sleybo@amazon.com, leon@kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason & Michael,

Kindly ping... Any progress for the efa .shutdown implementing? Thanks
in advance!

Thanks,
Tao Liu


On Wed, Apr 3, 2024 at 11:44=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Apr 01, 2024 at 04:23:32PM +0300, Margolin, Michael wrote:
> > Jason
> >
> > Thanks for your response, efa_remove() is performing reset to the devic=
e
> > which should stop all DMA from the device.
> >
> > Except skipping cleanups that are unnecessary for shutdown flow are the=
re
> > any other reasons to prefer a separate function for shutdown?
>
> Yes you should skip "cleanups" like removing the IB device and
> otherwise as there is a risk of system hang/deadlock in a shutdown
> handler context.
>
> Jason
>


