Return-Path: <linux-kernel+bounces-78141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 728A5860F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D3D285DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051CD633E9;
	Fri, 23 Feb 2024 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQNsh2OK"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13F05DF25
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684605; cv=none; b=GZNNd8jclOcW4jfYF3aUwXol8nTM1EZ9KQaqSegly9yIuYzGnlKVOEaEIfR6p+EUe5B6buaZnV660N7V70FvyQw221Wr10r3SBcRkuhEX/lUmEXGVwQIqMK/IwBrJOhkRTkU7oOBFH+EbKoAPUx0CyCbJEv+NllBmxTBld11SCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684605; c=relaxed/simple;
	bh=oGa9d8hXuiijz2WQcWWqfhlvaB3jirIqqRv0WuyyLd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cg2Y11WXy3zVfbEikqiXab/9cO1Rv6K4XbRCh0mt4tWLdYd9ZLBgf4KJG3Xt1d9R1GZM+tYqSzNrafMTvLFtkHGbfOVN1yBlzRu/V7ishVLCj4LRqREdNR2cu+IVSfjAC/Vi7GC1WlYDrLumZaZEQCtwJudI9S9jBlWAhAOyMwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQNsh2OK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-564fc495d83so701095a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 02:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708684602; x=1709289402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGa9d8hXuiijz2WQcWWqfhlvaB3jirIqqRv0WuyyLd8=;
        b=fQNsh2OKUBgnb5FP0MIFgb3d/zuraki6pSWU1EC+QQzscEskxBX3+AG1e1a1QPvd0B
         hr/r6dLshp+BvzTAYA2Zau6LG+yrD8YznsM50ToHcnWOfQcNaY9/0pQ+1sOsQ9hIPIb3
         cI5ElA0W+w2DcgFUWmUZCfLsut0jK5w/aP4hZReuZfHZxjdoA6SheufDCCIZed/IBOW7
         hNoFAXmZeNUx3BBXomv2gsuXv/zaL0sbxRvAKc31q97AlDRCy7ZA0tMDcHoAxCB6t3HZ
         4cJKO8Huez7q3DtnQADWBGxNp4krR7xcO7/qs4/Vl2/mvjr9hUj4qmz6g3yZ4dGESN0b
         1trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708684602; x=1709289402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGa9d8hXuiijz2WQcWWqfhlvaB3jirIqqRv0WuyyLd8=;
        b=j/HafsW90PNQ+ac+CZmnINY7j/DLAwwRZZhca8llseMQE895dXOtA9fhcvO/O4LAjd
         +Xuslq1dVC7LQ+6TxwY7+CtYtXqlOH7aUYhaBpoEw+zndAysQ5zre6nhjMv5ZMMr6C87
         RXG+gvLwJEXlcEZYDiY6r0E7t4JltdmeoW72GsVUAQAgrZ/AyxJERvdAKZgTUL8ubT58
         tNVChT6C4/xaDA2Ul6ziizIhqfwy5TYX84Pej4auXofzzBgzNmWkoy+EHRpxO/yNLkeb
         /ovOV3acxttYrriN8rahOsLmFQojybGRY2YfBIiPczClG1JBeyRGEtMqSIC5YqO5KHvz
         1Nhw==
X-Forwarded-Encrypted: i=1; AJvYcCWR2EIq2Rmwqz43/4ZB0lGFBrpSLI70O8Aw5+9A1WFWz2L0gbdomnoEwztfssvfPgOVlDrdsAWVBvzTtuUJpEwz098qy7zucvSVCvdN
X-Gm-Message-State: AOJu0YwoHQCOoKGE7XzKcqm32pwXaQLFVJLWAo26rb3TJRFkAvQK0dty
	0jnSWIyyf8OaMmhvU2dOmdhlcVAD28rME7+UgixAgGKNn5Cy9mt8V6hnllPVw22tp/09QRJrDt6
	U6hFS1HNM4pwvX8elByXXnuR+G3oqiCIPd9ul
X-Google-Smtp-Source: AGHT+IHUav3spNKZz8TuROOuLqr44AG4XeF8yBOYDiOk8XKBPI8yc/QGOy9I7fCdiFaLDT3fTvD/WiTk7Gr2b1xnDxE=
X-Received: by 2002:aa7:d50a:0:b0:565:6424:6ad1 with SMTP id
 y10-20020aa7d50a000000b0056564246ad1mr843919edq.14.1708684601764; Fri, 23 Feb
 2024 02:36:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220081205.135063-1-raychi@google.com> <2024022024-trout-kennel-6d14@gregkh>
 <4d62d4d0-3f28-486b-8132-4cc571b6f721@quicinc.com> <CAPBYUsD=3ux8RXgRcroVsmpqNs0D+2NeLhqPHh3TBB_oq=ziXA@mail.gmail.com>
 <2024022033-broom-anime-6dd5@gregkh>
In-Reply-To: <2024022033-broom-anime-6dd5@gregkh>
From: Ray Chi <raychi@google.com>
Date: Fri, 23 Feb 2024 18:36:04 +0800
Message-ID: <CAPBYUsAapQin9ioDggDk_ZE2dGxBRFwSUcf8JGt4eRqrYd9m6w@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: gadget: remove warning during kernel boot
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>, Thinh.Nguyen@synopsys.com, 
	quic_uaggarwa@quicinc.com, albertccwang@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 9:56=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Feb 20, 2024 at 05:42:56PM +0800, Ray Chi wrote:
> > Hi Krishna,
> >
> > I verified the Thinh's patch and the warning could be
> > fixed. Thanks for the information.
>
> Can you provide a tested-by for that one?

Since the solution has been merged, do I still need to provide tested-by?
If tested-by is required, should I reply to the email thread for the
merged patch or the reported patch?

> And please do not top post :(

Thanks for the tips and your patience.

Regards,
Ray

