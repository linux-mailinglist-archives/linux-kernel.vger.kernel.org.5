Return-Path: <linux-kernel+bounces-46501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECC384409C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE97281B21
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2080D7E573;
	Wed, 31 Jan 2024 13:31:45 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468FC7E77B;
	Wed, 31 Jan 2024 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707904; cv=none; b=Cl27fLToVqRxonsMd5M+w8K+6fw6Oygr3evrE6ac3kV3sSOh6xG9fr/glUGlmgdqJL5/cirwEZXV39cnv5AugNw554UfrV0VhSSoF55d6ivxYikrYjbD1Pe2tzAPKQ6RBe+uPPb736z6S+oTTI5612DoFcWYkCb7W/WFaIfrzyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707904; c=relaxed/simple;
	bh=5Rp35yucMfxQZlQkNOie1bDDjBWu83sZduF/xIjHchc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lz23Sowafkb0Kd8Z6jUjC5ITMQjLzowRLY817u1q9Wtl5RyJo29t8xsiqegC6AesqLtBSaacchQxBswa/MiQWLsvtFy1NE+PTg+Gwe4XvOJiTosJNvTMEsQLQkTXGJUdhFo1PkpY8Kcksvk+fDW9/onWpEpdXL74SqJJR3v4Dh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59a47232667so291974eaf.0;
        Wed, 31 Jan 2024 05:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707902; x=1707312702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Rp35yucMfxQZlQkNOie1bDDjBWu83sZduF/xIjHchc=;
        b=UhWkLhAGqOWGdyLgCVAXquAOHVsOhf5Y3mJ8VYSTfecjSk8GCL7V7nFDtU+xqLPhyv
         Njd4T6qDR+rh1o8yg7hO7kWIVX/kHb00mn00XYfEuZunSPjyDc079eiR1aYs881T84KH
         u6DZaCx9aIODhkrhQlW52T8pdeUbFE/uoLER//LDpV4Y0M7RH6WuiCaOYMQZeQUV7NdU
         50Tuqxxj5jqfogmRpvJCy8Gnm7AEGQbXHfE2NjDU6H1n4RA+XwyR37k0kHxz1GObIbrJ
         M2gZbT6ro/vksttVjEYSbsBz93jcgGNgG1CyJEClM8YUcgVb+ff2hgkBWM7cmnMo9GQ0
         cTLg==
X-Forwarded-Encrypted: i=0; AJvYcCXtOtYEqLXktr70Z41AcmE51bjkh2pN+IhJWH4RDq/k0HTrDor4kWi1tBdPG2C1U8t5BwVpXacW46+wEMzCljmaUfPkrpXjMlqBSJbsIqLrfxkQ27ty0GFVy3ttoRSLcsr+jQp9IXw=
X-Gm-Message-State: AOJu0Yy4F6mk7KCh4Cd/PKB9XHcAEEuHR9168oKOX8F/UvNsaloHVNW9
	ewA1NjhHQ5v7Lyd5pQmX5mQlNv2ph9Zu5IlY47olbjQw0QoS067E0W1o9JQ0a+tow0q1UsgPXuW
	dq2cHX3iQgtnivJGrUzpIiQ7q7hoCq9JQ
X-Google-Smtp-Source: AGHT+IF4wBkYQaG7sUHxuYJAkI1d27TzU7iHoaStAgcpZumIByGQtzUhrYvyNfExpw5f8fZo0u4Gbj85k2bIAur/Dhk=
X-Received: by 2002:a05:6820:139:b0:599:9e03:68da with SMTP id
 i25-20020a056820013900b005999e0368damr1539564ood.0.1706707902036; Wed, 31 Jan
 2024 05:31:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5770175.DvuYhMxLoT@kreacher> <CAPDyKFqpS0jwuxUe=NLA_Lvf2zdo+98ne3iar9Uqu6P=DFNFDg@mail.gmail.com>
In-Reply-To: <CAPDyKFqpS0jwuxUe=NLA_Lvf2zdo+98ne3iar9Uqu6P=DFNFDg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 31 Jan 2024 14:31:31 +0100
Message-ID: <CAJZ5v0g5tiWzazXwsr2jL1KOxWACX4afkJdD5B44+V3TA+22fQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] PM: sleep: Fix up suspend stats handling and
 clean up core suspend code
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 1:43=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Mon, 29 Jan 2024 at 17:32, Rafael J. Wysocki <rjw@rjwysocki.net> wrote=
:
> >
> > Hi Everyone,
> >
> > This is a v2 of
> >
> > https://lore.kernel.org/linux-pm/5760158.DvuYhMxLoT@kreacher
> >
> > except for the first two patches that have been queued up for 6.9
> > already.
> >
> > The original series description still applies:
> >
> > > This series of patches modifies the core system-wide suspend resume o=
f
> > > devices to get it more internally consistent (between the suspend and
> > > resume parts) and fixes up the handling of suspend statistics in it.
> > >
> > > The functional changes made by it are expected to be limited to the
> > > statistics handling part.
> >
> > and the differences from the v1 are minor.
> >
> > Please refer to individual patch changelogs for details.
> >
> > Thanks!
>
> I have looked through the series and it looks very nice to me!
>
> Feel free to add:
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thank you!

