Return-Path: <linux-kernel+bounces-136008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3372689CEDD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCFF286D7F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3D2149E04;
	Mon,  8 Apr 2024 23:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z3Oz7TZg"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0124914C5B5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618278; cv=none; b=iGWN539OA/I5KCSIBH4FNIYYRNuFYNUtEdJG1XyrFxiGGaL4QlMrU8NFg6gBQVKy1lNfXhVOTJJdiQGqdeOgcKevBFVioK2qB1r8qo7sIAEE1F62sJ+KkOiJbRVnXa+DJC0plK8qyUMBunVlr51GzWebCBQMqEwKpAYYAT33FnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618278; c=relaxed/simple;
	bh=mtWNzTX8JC05NtIfESIPbCi1nt0AgwSam4TBmjq+4EU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZkRTRLqWDt1eMplOT8HIMo3lEcQmKECgJkofqBWkRuSM/haa+lQuB36GNJlO9dz0zaMMN4QDgYiypbcImCVeWdScVDFZ3+BfIpzZOvzNI2i+fLcRxURoNxksD1yhtm1ZCppv9mykBl6AlZslKh616edF10z2IMqObpQJI8nn50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z3Oz7TZg; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43477091797so53221cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 16:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712618276; x=1713223076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtWNzTX8JC05NtIfESIPbCi1nt0AgwSam4TBmjq+4EU=;
        b=Z3Oz7TZgxpYC8iELsZdhYl/NjuApKV06wqQQqzCJ1gF6yZcVBx4lpzPrmHRmlA9HWf
         UScU0Y+iwJGhEE7ksBg5w1B1f3brLUuyGN/0xin08wL9hbaRR1WzDQHqGcO+mn5dTL1z
         UtUq7De16C/N6vNh+xxCEZiateQTiE6RtHfc9TywFIEIs8aRfIFC0BbpPRAG+fZmP9PA
         weWmdR3HEj74WWInWHHvxPrgA2QYs5HL/83D63NIlB3jVuYIrJNwOWA2bBCzCNVhiIMb
         Lm7CnepHN0TRlwQXvYPqtYvPZPaDs8PsJdUBFdlfcPYAF0WLD4jPH3YKx9AGbBE9VvpP
         EATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712618276; x=1713223076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtWNzTX8JC05NtIfESIPbCi1nt0AgwSam4TBmjq+4EU=;
        b=GbIIQy08RXE0gyE4iJJsN9lVXmrAmbP8rfUbi4JRSnCnMYVKBwB+/kZxzk5DBnxYXd
         CFhxfuPbVXLD+UWbln71Ou5qny8/lCeQgkUIDY7Lnt6prJKsPJB2TVrqenhlIF7F2UD5
         wDb2b2dbkgStGwdNul+kq8C+0GL9RWWNHq1v7zOKXCLAgiMFd2azG4bgGpymyDjvvJg6
         XjsHRWpW4AL9dkMpAlTA4VCGycS1PxzVIf/O0o/A72aSuftP1k0qRKzQIDj/9JuIKVo3
         VVb2erT8FJf6I6W/s9Vw+HwwYsGE2CACjWWzwKNkOcgKqZLAIfZB44y2iYHUr679IGqh
         MNcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYBwEZoXl2VlPyPNnU907pp9d0v0A70/mM+Wqu00QBg6M7+mEareYht44Hxjg1nOZzDrXwhm2iT1zwHBCIBa5YsiYVSuMjVNI/TPCy
X-Gm-Message-State: AOJu0Yy1GjQHYqoFrk8sivHw+lKpDnyvOOnC+qZlLCeHRDRSCVSQ6BVq
	aiyaqlTEX96R3YaXvjYqeDJ8W/iVWdO1FPYyQr3tXrYfWb0DAZsyOWvJk46+QcBk8wK8rfQpas3
	wnzAl7hLSOHuZqNvSUluxtXHW+VBXopz5Mt2O
X-Google-Smtp-Source: AGHT+IHeKvaMXc+mckFW4oy6yakcfNZsNKxWqCqjei+Bv6D20mcyMc+btA/+lz9WX79mr7qsbWUULg5iyVQ2vvvzm38=
X-Received: by 2002:a05:622a:428d:b0:434:bab1:3df8 with SMTP id
 cr13-20020a05622a428d00b00434bab13df8mr74017qtb.20.1712618275692; Mon, 08 Apr
 2024 16:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220111044.133776-1-herve.codina@bootlin.com>
 <20240220111044.133776-3-herve.codina@bootlin.com> <CAGETcx_xkVJn1NvCmztAv13N-7ZGqZ+KfkFg-Xn__skEBiYtHw@mail.gmail.com>
 <20240221095137.616d2aaa@bootlin.com> <CAGETcx9eFuqwJTSrGz9Or8nfHCN3=kNO5KpXwdUxQ4Z7FxHZug@mail.gmail.com>
 <20240321125904.3ed99eb5@bootlin.com> <CAGETcx-oMbjtgW-sqzP6GPuM9BwgQrYJawpui3QMf1A-ETHpvg@mail.gmail.com>
 <20240408164021.6f13bf66@bootlin.com>
In-Reply-To: <20240408164021.6f13bf66@bootlin.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 8 Apr 2024 16:17:16 -0700
Message-ID: <CAGETcx_YjRzA0joyESsgk=XJKBqqFD7YZeSwKu1a1deo-EyeKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: property: fw_devlink: Fix links to supplier when
 created from phandles
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 7:40=E2=80=AFAM Herve Codina <herve.codina@bootlin.c=
om> wrote:
>
> Hi Sarava,
>
> On Fri, 22 Mar 2024 19:00:03 -0700
> Saravana Kannan <saravanak@google.com> wrote:
>
> > On Thu, Mar 21, 2024 at 4:59=E2=80=AFAM Herve Codina <herve.codina@boot=
lin.com> wrote:
> > >
> > > Hi Saravana,
> > >
> > > On Mon, 4 Mar 2024 23:14:13 -0800
> > > Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > ...
> > > >
> > > > Thanks for the example. Let me think about this a bit on how we cou=
ld
> > > > fix this and get back to you.
> > > >
> > > > Please do ping me if I don't get back in a week or two.
> > > >
> > >
> > > This is my ping.
> > > Do you move forward ?
> >
> > Thanks for the ping. I thought about it a bit. I think the right fix
> > it to undo the overlay fix I had suggested to Geert and then make the
> > overlay code call __fw_devlink_pickup_dangling_consumers() on the
> > parent device of the top level overlay nodes that get added that don't
> > have a device created for them.
> >
> > I'll try to wrap up a patch for this on Monday. But if you want to
> > take a shot at this, that's ok too.
> >
>
> I didn't see anything on this topic. Maybe I missed the related modificat=
ions.
> Did you move forward on that patch ?

Give this a shot and let me know please.
https://lore.kernel.org/lkml/20240408231310.325451-1-saravanak@google.com/T=
/#m40e641cb2b1c0cf5ad1af1021f2daca63faeb427

-Saravana

