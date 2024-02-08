Return-Path: <linux-kernel+bounces-58272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F62084E3C8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327731C2420F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC42768F7;
	Thu,  8 Feb 2024 15:15:18 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A36469300;
	Thu,  8 Feb 2024 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707405318; cv=none; b=oYweHivszzG3ft5HGjaTpIV/4CJDa2V5qP9Z4HsQ3taekGxh1t2iplcLkT2LRAL53ljckYdfzyCeAPVID6/mji0OTBRTbsy8RJJp+Ya0aIMXjbHdvvVIGO2F1wa4o0jTBqd0NmcHgwMmWEeuZ4ZqKhxJEYTs0pMOAiLkDdfp7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707405318; c=relaxed/simple;
	bh=uaXPCE0UgqDohZoTiXMgDSzZPVSzV0gUYHhEAYwOJkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVsw0zI8+GOkKpuvZ7lzrla9oY7FT2Q/sJxcrNMYlhfXXLK5oe+tnONnc7xuVOHLci1z7I/cGoxLpQKrvpnvDTosZ0GsJDkBq12J7s4aVgPr03sfW7XVcLVF3pT9MBixL4hdeY1wMhJjDTiqrCjKvx1GrfzeC+jZLURRjG56MZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5958d3f2d8aso496513eaf.1;
        Thu, 08 Feb 2024 07:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707405316; x=1708010116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOO4/50C1vYVxO/b6f/4WzooRVWOvKCt8xgmYbMBsB8=;
        b=KVyzl3DMUutA1d6n/HXB00Vvh94qcz3Zi/L/80FHq36S14OmeyLvQuCLNLHkgwh+o9
         LY0HnBCTU2U+xZnWjjFBNH6Cd0yPy5106yRUUS2OiqgJW40lyBg8Kz7UraLIVXa4yA2h
         6VnhT/4VJRvdVylXC53HdSC6Yj6WGmbTug6pC9m3bHtS9qW7jpTWFQu/O70d41tWpC5k
         UDO91tuN8qKYwI0SHG1I4ATSzdIV5x+gW48xepfXQkKF1oUkOo70uXnFUdJYAviEOBZj
         qLFSlDDbCi+nolXbCbqEmKlJCXtfLTWIeqw4Sgp1OMtavpYpChtPWvJAjdUm+bsPpgkM
         GdJw==
X-Forwarded-Encrypted: i=1; AJvYcCWz2Stfh+u2KDB7j2bXATncBjZ7De66eQGdcm5SrmAtzBSlyV0j+yIQ0+1C9a4zE4Tqoh4s2ceADr5epAqgkWbFh0QellNZLde9r89pBXa4sMqkrKDBLeOM66mrJxt0HLUvmpZe8M8=
X-Gm-Message-State: AOJu0YzjcQvq2ck/qbj/MaDUlazsX5dgrjK/zesy8Di9HwEAdGKP/uBu
	sAs/9RThJEY0jiRWhZD64qHcemUBZHMwAGYNoz2XR2/nSeVASNfdvng6TxaoXtkd9emIzL86R5D
	ZGMjWAaut0JKihnhi8pLP6bA5Udk=
X-Google-Smtp-Source: AGHT+IEQ6eBeCI4dBXCUyb542uh7dJ9HxBxDQC2ZcBtufy22j6lIJ93ZRx0g29QQA0p152YGwoDv9hRP429eQZ6LK5U=
X-Received: by 2002:a4a:cb8b:0:b0:59c:e48e:50fc with SMTP id
 y11-20020a4acb8b000000b0059ce48e50fcmr8223006ooq.1.1707405315991; Thu, 08 Feb
 2024 07:15:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2731410.mvXUDI8C0e@kreacher> <b068b36a-9964-4d32-bb00-227893f9e47e@linaro.org>
In-Reply-To: <b068b36a-9964-4d32-bb00-227893f9e47e@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 Feb 2024 16:15:04 +0100
Message-ID: <CAJZ5v0jPiHkxL1a7DFU6Km9694PQCwnnk7sRm=mmz1uxhdoNVg@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: sysfs: Make trip hysteresis writable along
 with trip temperature
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 3:42=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 31/01/2024 19:44, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Trip point temperature can be modified via sysfs if
> > CONFIG_THERMAL_WRITABLE_TRIPS is enabled and the thermal
> > zone creator requested that the given trip be writable
> > in the writable trips mask passed to the registration
> > function.
> >
> > However, trip point hysteresis is treated differently - it is only
> > writable if the thermal zone has a .set_trip_hyst() operation defined
> > and neither CONFIG_THERMAL_WRITABLE_TRIPS, nor the writable trips mask
> > supplied by the zone creator has any bearing on this.  That is
> > inconsistent and confusing, and it generally does not meet user
> > expectations.
> >
> > For this reason, modify create_trip_attrs() to handle trip point
> > hysteresis in the same way as trip point temperature, so they both
> > are writable at the same time regardless of what trip point operations
> > are defined for the thermal zone.
> >
> > Link: https://lore.kernel.org/linux-pm/20240106191502.29126-1-quic_mana=
fm@quicinc.com
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks, but I need to withdraw this one, because there are drivers
that actively don't want their trip points' hysteresis to be adjusted
via sysfs, so I'm now working on a patch series that will tackle this
in a more systematic way.

