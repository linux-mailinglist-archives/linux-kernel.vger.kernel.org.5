Return-Path: <linux-kernel+bounces-81087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B85C867000
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521571F22100
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA18361673;
	Mon, 26 Feb 2024 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R1VtCByz"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E8C612ED
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940752; cv=none; b=k9aib/CAtYbkEIk1impkQ+PC39F1wgU3khRleA7d5HMKQ8mUfN2Ysi5nbpoxP5bQdtF96aDsG2h5fuq6QsxM637EvIr6Ek4w+33jGjO0+xWd3XoItyBCPHGc+Ljcxi0ltciGzUPrF0bbn91lt5wvGfvpYdSgXHVVsQjodbHsR5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940752; c=relaxed/simple;
	bh=uJT54+Njg4WM6tIO47QUf0ooA5zNNfMnXfBEFJz87qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P72Nfnr8+zcs0DikRY3MN73HQeHwnfaMXQPo70WGRutaZ0M/ccpIbj0aMJkHsON3hLJ5hSTLS4jzs31RrSxG1UZsP/SVtiww8sGpZV9hpE8956BbJEjMp4jcRbMJ+0NCKNV3oue9UhOErnh8yw+T21ggp50Qsv/Y8LNfZWGnpU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R1VtCByz; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso11769a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708940749; x=1709545549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZT3jK5Gj1aIKjYSj7Fjltcf1HIECW9YIZ/DXJQ0Ddc=;
        b=R1VtCByz7ztvNaxHc7Z1C72vh+nm4OhBO6QLuN5znmYYd7p5LJPUpznHapy2TG2lDZ
         NX3Kjiso4YNd4AXrd1yurCu+SjIHmkO5fmLrBWRWu8y+dttfLq7JP4NscXpYk0tOHhub
         UBwUPQjGPaEfanuY+I0QyG7/rX8ydEMrUsg2x6AjHkPWdAQ8oPmIcpl0BG8GRUVuPN6C
         IUYwVBrNtZi9P+8TphdJLLSELA/ZQzXd7OFzADy7BJHGDei/roX3tAK0Epqe+vLCoyyG
         OYbrMhj/u4GrjE4NxGXVIJukPI86Wqn/SkydtQp7X5/fVf+lWscKuPkf6XGu/jKfwFqi
         ++EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940749; x=1709545549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZT3jK5Gj1aIKjYSj7Fjltcf1HIECW9YIZ/DXJQ0Ddc=;
        b=HvIRJgrHKO58fL+huQvQd6IUDCnhVMv3sQ/bcNjX/t6gWkrCVt8aYEX0ZeTZE8L6pe
         ZadvOLNa2+ITAF1FRVB4bgS6+Al/N1WsFaAXDptr3+mLH3tBR/797i0IVUhb5pNBb59I
         BaGBnsqrbD6XbO/w2nzVgG+2zWyJDfXRDPse3i0JUUQ7Zs1OMbcIdeY64Q7oWwvl2wV6
         3gjkRKGBOdZ0d2IP5J/DiUyJp02LADhWgBjfa+Xv5o/FCN1U5zgljzeAU8MnQn2Hmcku
         YwwLy//F0XAhV96YpfareKkyd17Ndwk+vwJ+viu4GX3y5xr19mc8Gk1D837mcM9lB67f
         fSyw==
X-Forwarded-Encrypted: i=1; AJvYcCUyAv6QvpBNg9hKjVHleBUvwrQ7Jnrzq/fyC0Z3rjOVnbtliOTaukxovFidCl7YW/QJGHTrXtp5wqXlXFcZhTIwKTFWurrQDx2kfe2P
X-Gm-Message-State: AOJu0Yy3Tj7Zms8ebNQXsekq6B9WTvaP+2sCeQYRJZqcGPTNCzXc6/1E
	4dpS4w3LkxizkFZvWh/khF4gRR/9uTcgpNynPTHbp2NtnT7YU+M1TeIXdk4c/h0r6FEOtWnst/H
	AHnCaS5vtvw1cbGiznRxBmsKu9U9+eGMTcQPC
X-Google-Smtp-Source: AGHT+IGw7zA63B11yii8IK4JQCFm9+V9/xg0w78cK7iNkrNIe8WNKE/5M0T7SENyqjOzsmxXUWuOc4+TZu0jmTSQldE=
X-Received: by 2002:a50:9f28:0:b0:562:9d2:8857 with SMTP id
 b37-20020a509f28000000b0056209d28857mr268773edf.6.1708940748588; Mon, 26 Feb
 2024 01:45:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223143833.1509961-1-guanyulin@google.com> <CAJZ5v0gM=0rU6a1A6Bh2Ed=4=1AtQ3p5aDJVCOioA6qxGv1jtQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gM=0rU6a1A6Bh2Ed=4=1AtQ3p5aDJVCOioA6qxGv1jtQ@mail.gmail.com>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Mon, 26 Feb 2024 17:45:00 +0800
Message-ID: <CAOuDEK1NdFSZgy8_ebO_zSxbU-gLJHsCzjd6JSr2cckQAFgaTg@mail.gmail.com>
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org, 
	andriy.shevchenko@linux.intel.com, petr.tesarik.ext@huawei.com, 
	rdunlap@infradead.org, james@equiv.tech, broonie@kernel.org, 
	james.clark@arm.com, masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 1:44=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Feb 23, 2024 at 3:38=E2=80=AFPM Guan-Yu Lin <guanyulin@google.com=
> wrote:
> >
> > In systems with a main processor and a co-processor, asynchronous
> > controller management can lead to conflicts.  One example is the main
> > processor attempting to suspend a device while the co-processor is
> > actively using it. To address this, we introduce a new sysfs entry
> > called "conditional_skip". This entry allows the system to selectively
> > skip certain device power management state transitions. To use this
> > feature, set the value in "conditional_skip" to indicate the type of
> > state transition you want to avoid.  Please review /Documentation/ABI/
> > testing/sysfs-devices-power for more detailed information.
> >
> > Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
>
> Please explain how this is intended to work.  That is, what exactly
> you expect to happen when the new attribute is set.

The sysfs entry 'conditional_skip' for a device indicates which power
transitions (e.g. PM_EVENT_SUSPEND) are omitted within the system
power management flow. During the processing of an identified power
transition, the device's power.entry will not be added to the
dpm_prepared_list, preventing the device from undergoing that
transition. As 'conditional_skip' is modifiable at runtime, a device's
participation in system power management can be dynamically enabled or
disabled.

