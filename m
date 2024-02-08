Return-Path: <linux-kernel+bounces-58617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F97884E8E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7141F31A1E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8D2376E4;
	Thu,  8 Feb 2024 19:25:58 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57050374EB;
	Thu,  8 Feb 2024 19:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420357; cv=none; b=YU4wvRo/JxG5ZaTQJtAWLav+m/9KaZjoKbvqxu2bi91eYp9Th3QYqQuxDEOobECKNvBuFAi4tTpG8wxOLs7nhqlZjCvtqc/M40a/H+GAHUtM2X1z1sK1sRjCU4SyJpLfdPW0XQUTcvMWQMLjOWCV26PIJ8tSIpg3L+ffeQZQTYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420357; c=relaxed/simple;
	bh=+YxRwLnaWql45Og/uBWyYcb3+6fMBdrqBtTSrgZdyPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSOIKdcvFo0VBdVLPLnlzfIosKh8nuKgs4QqG5W6uoxzlpsC0zqeC9Azu5FGAID5Bs3pGDc9D3okhz8McQekGZ7dQYdpz+3ebyXAHkwNwYbCcQh2CXrcTGtG+rpnOPSu0FsipCXNLQoa2j5015UhbxqklEW8YmbbbP176BZ59Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e2be7b83b2so12068a34.1;
        Thu, 08 Feb 2024 11:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707420355; x=1708025155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tb13rhuW8544qF8dDhm649NVENoNwfXmctODywQIT9g=;
        b=EjvD5wFU+1SSJ94m0sfzv8grdOJCUQz6h+PYY+IIgc8sDbaD3p3VrWBJY4iFDMJ2ZH
         O16jIX5PJ1SzB+S2QEMgmqKuVbgUT/mop0SUSecJ3mbw50J571WKRPBn7g+GT6FG4CXi
         u0EnE+ZN2ZdJr9Bv+2u1XtBog33JkAKx4iU7HUGJKaOrzIHSr5E/WYUunmkmulMPQZly
         T0GG27iYqBkkknBzliBrIPO+Sw8WCipeZBx4l+3k/EKGguwGnp0vyUKKloHLiAhfL+Ah
         muOwW+7b62njpONr8kBdfvAl7qQqJUZZ5qMpbUOsKW3ydxtoqtuzCrkj7Bj1sP8ceSVi
         QoEA==
X-Forwarded-Encrypted: i=1; AJvYcCUb70/dXogFlTqZR74589E+KsK7FNC7Pf7q0UdiamPZCv9qCTf5NNJtilgeAkiDA6p2FLhVCt3MEPWYU61LG1rsH4vuaona3BVMgEhO5IGA6HgrrWCFOSu1aoiP+F4FQhpO0AkAvrPg9TGXMzuDzOLzxWo0pPgroWEqVpiQBoejtbCH
X-Gm-Message-State: AOJu0Yxuh1EM4+LZAi+nqIlQPgtot73NlCXxrEII2P8ryA+A/PvYH3N0
	94iJKmKj24Jrb2ceJIWdMM7El2q8yG+VlF7N/xJk1kUxNjOpSh6bcEDbU0pyKchroPpTGPBCmdd
	1jbZP0Yj3O0x/C/9Owp5ghJBAoYLDVFC7
X-Google-Smtp-Source: AGHT+IFc86hHi76bIJAGJOwHBORpUhjaiDBoTVniHGjNFTBpmS81Ejjw3qUL6lWrbyu/lSuj+y/tCssE7XkUmp6KBS4=
X-Received: by 2002:a05:6871:e40b:b0:21a:cf0:2478 with SMTP id
 py11-20020a056871e40b00b0021a0cf02478mr166961oac.4.1707420355197; Thu, 08 Feb
 2024 11:25:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2728491.mvXUDI8C0e@kreacher> <5762433.DvuYhMxLoT@kreacher> <ZcSPMRH34M5yG/IU@linux.intel.com>
In-Reply-To: <ZcSPMRH34M5yG/IU@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 Feb 2024 20:25:43 +0100
Message-ID: <CAJZ5v0jfUKFo-MDVU7i+yvfk=f_65Unat6715S6kuqvRX9eQLA@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] thermal: core: Store zone trips table in struct thermal_zone_device
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 9:22=E2=80=AFAM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Mon, Feb 05, 2024 at 10:14:31PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The current code requires thermal zone creators to pass a pointer to a
> > writable trips table to thermal_zone_device_register_with_trips() and
> > that trips table is then used by the thermal core going forward.
> >
> > Consequently, the callers of thermal_zone_device_register_with_trips()
> > are required to hold on to the trips table passed to it until the given
> > thermal zone is unregistered, at which point the trips table can be
> > freed, but at the same time they are not allowed to access the cells in
> > that table directly.  This is both error prone and confusing.
> >
> > To address it, turn the trips table pointer in struct thermal_zone_devi=
ce
> > into a flex array (counted by its num_trips field), allocate it during
> > thermal zone device allocation and copy the contents of the trips table
> > supplied by the zone creator (which can be const now) into it.
> >
> > This allows the callers of thermal_zone_device_register_with_trips() to
> > drop their trip tables right after the zone registration.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

Thanks a lot for all of the reviews, much appreciated, especially
regarding the Intel drivers changes.

Unfortunately, this patch series, and the first half of it in
particular, is somewhat premature, because a couple of thermal drivers
do unexpected things to their trip point tables and they need to be
modified to stop accessing the trip tables directly before the core
can start using internal copies of them.

I'm going to save the tags for the future, however.

