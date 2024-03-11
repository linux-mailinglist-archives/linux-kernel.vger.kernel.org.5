Return-Path: <linux-kernel+bounces-98682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C63877DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07B81F210E6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798E738DFB;
	Mon, 11 Mar 2024 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iEuDl0CX"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E0838DC0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151886; cv=none; b=IBW8a/HBTv+rKmyYcHv85fu8b+MKUtm34Gi9203nJpvKEl5LFK55XWhAa9koNMnm6qDx6Uo7fuCO5zpyLzk4S0wMOX+N+R1225s/qsyl0w35Z4Z57VjzNOXRx1ekVOgKmfmQcZnTbBQKexJwcfS64VrbSVJA7tE7ENt3ZsU3Sws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151886; c=relaxed/simple;
	bh=90wxFtc2yl7pC0/MOznw1zbBPujem0U2+kENHa16YIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0wYOlVdFrunvTddVwpvyEPITbQHeO39ucanEoXdIicu2ecKrJpqzbKEvTNIL3BGft32QwfwC+LmM50NQqgSaxHl1c4I+WSicA+z143f4JSpzaeGfg/CwIbsCthHF2jPO07E82wb1U9KeTkHSCqiMY3B0vRSj6P20V0ZsOYjyuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iEuDl0CX; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so4773625276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710151884; x=1710756684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OW00I9htwoAsj3xBJZrkbzrUKhGDr0/+mmT+snWwiXg=;
        b=iEuDl0CXWHzvdZYvg2Uqft91dUHE8s4S0nzX2JXi0jbuzaqbP/anhhfShGbtmAbj+6
         dFvbr3wwsVc1l/yaFnWxdW9auVjedAAueOsEYCtd/ModbkuJ87LhwWNhfyYT9XIHG8Rg
         NBXdgt4kfaL/thZyayXXcL5XztQ6r/VYqwHY+b0jAUMzWM+09I0c+AYDpX/iaZWoArCu
         ZDCuk9xxDBrx37I/nCyzCsUY1m8U0Sf/vNFHetvMnoOOowTWDaAIQHxZQGdLCeli+uPI
         QlfLzQ20Zjfb5+AatcjBlMjSEpCqglJQ28Sc25aQosThpL/N1kkhnSaA4YiQrxWazKkS
         WDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710151884; x=1710756684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OW00I9htwoAsj3xBJZrkbzrUKhGDr0/+mmT+snWwiXg=;
        b=I3pFq1VdsL0+hEdY+UCfTeVER+JOi6gs/2uxSbSG2aX0PU00SYO7Zdb7Yz96p/sjL2
         aWc1b/NAG4glmc1RruIFo7W/Mi0R0ssZa2WxX/hLGDKeA/szwcUlzWgpiKu5QRwBArVP
         n25QAI43WWGEW5PDq6lEJ747zF9cYBrmlvVWTHL2s80EWI8Ujl61oLFsKrsqx1kw9pme
         lELw+CSK4KRCarR8InIGqvopxkkhGB9srJJ10CEkHi4a/jTiEODKdJBxDUbBuyU7/nCc
         2LitUlcLxOl/QA9xnCg46f1HCwOzqu4A3LegUtR7B2Gk2KC8ouIWcPNuuwxcn0S5IgvX
         5FKA==
X-Forwarded-Encrypted: i=1; AJvYcCWLwlas2EJaV0UKPW8lBClJmUiaDaJEj2z0dDz37LWxOACI3PcYvOodQgDtuk3tyjdlXLzWkVw/6CKLAJU7pW310mxN90F5KtVHC9nO
X-Gm-Message-State: AOJu0Yx8bNWqvrdh1cu12tuhyJcQE2cpDy+OQ8jwIOXRg6FCXIjD91Uv
	hRLwb/Cr87MMPn906g7xSUC1jBXCZp0bAk2RfD2dUwJwubhUoE4dmFqmpxR/DXTUP6bgW65GtyX
	h0uIJzwYnjFNHafYuRMWNsYgUbrazYxHRZi5F
X-Google-Smtp-Source: AGHT+IHeMf2I6e7HKYzUshIicVdYM485nxp+wOAn6CZ5eXC/DS89xt9vl9QxYES8bm7T9Wf6yE9ct4Shlv7P6VhvUsU=
X-Received: by 2002:a25:28a:0:b0:dc6:ca3a:31da with SMTP id
 132-20020a25028a000000b00dc6ca3a31damr5135139ybc.16.1710151884041; Mon, 11
 Mar 2024 03:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311094947.3738200-1-howardyen@google.com> <Ze7W3o67JLTKlLzR@smile.fi.intel.com>
In-Reply-To: <Ze7W3o67JLTKlLzR@smile.fi.intel.com>
From: Howard Yen <howardyen@google.com>
Date: Mon, 11 Mar 2024 18:10:47 +0800
Message-ID: <CAJDAHvbRSm_UYgx0fE7o2dJqcBfBbcFR4DrnVydkwfxGo0O4Rg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add support for multiple coherent memory regions
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, mathias.nyman@intel.com, 
	hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	petr.tesarik.ext@huawei.com, broonie@kernel.org, james@equiv.tech, 
	james.clark@arm.com, masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 6:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Mar 11, 2024 at 09:49:45AM +0000, Howard Yen wrote:
> > In the system I'm working on, there is an always-on subsystem which
> > includes a small size memory, and several functions need to run and
> > occupy the memory from the small memory if they need to run on the
> > always-on subsystem. These functions must allocate the memory from the
> > small memory region, so that they can get benefit from the always-on
> > subsystem. So the small memory is split for multiple functions which ar=
e
> > satisfied with their generic use cases. But in specific use cases, like
> > USB3 devices which support the stream trasnsfer or multiple devices
> > connect to the host, they required more memory than their pre-allocated
> > memory region. I tried to implement it in a generic way and propose thi=
s
> > patch to give it the ability to get the memory from the other larger
> > memory to solve the issue.
>
> > Changelog
> > --------------------------------------------
> > Changes in v5:
> > - Fix build break.
> > - Use of_property_count_u32_elems() instead of
> >   of_property_count_elems_of_size().
>
> Have you tried to use --histogram diff algo?

Yes, I used the below command to create the patch v5.
`git format-patch --cover-letter --histogram -v5 51b70ff55`

>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Best Regards,

Howard

