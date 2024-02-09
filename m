Return-Path: <linux-kernel+bounces-58995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5252E84EFA3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1AD1F274BE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E0753A9;
	Fri,  9 Feb 2024 04:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ur+OLccj"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942DA5673
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 04:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707453331; cv=none; b=rijYJojBNcxa3C+4zLJv4xVqx61GxrpkaPFdd1HYToltKDSaX6qGquiVtnxmHXbjBvUSWsRP5HOGGl6LezhZdK5eWCtwtgko2LXv2/elelzFnDSF4rej5kwq3zNprKWA/mLI0khLPXkELh97SVUnBaKkH+w28c/rXFuJocKT/d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707453331; c=relaxed/simple;
	bh=hTYAUXCmIabUW5HKsILrnw6rDD9lUI/Srw4C705HR5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBRxB6B8bO1l5+EgDuDDwD7ZvpHZ5IOU4XfJ+YVG82mni7WCW5CS/jkRx26O7vGV8Pale+eblIkeTCByqXtx4+Hln39jTJ8odPzYSP4wYgnfjMKHV+sC8zP2sqo0lhi8WvPNyAdVpvsFORo2GokfUzghDSIFIdEX87ieLYE4ii0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ur+OLccj; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc755832968so293276.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 20:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707453328; x=1708058128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jF0LVyKfW9zrsYG7qAJeA0jKroE+BQWSh2P7D/n91V4=;
        b=Ur+OLccj8/+CUb8GKtf/xsBNddRAUmejqr0s4j+DYSIiexHyuCrygDNErtqMig6oxA
         y/UgbbrEXKzd0pXGiTe1FftGMyFRI7Sj1ZF5juO2lS76k8mJZG/vQPW8ckjssJRSOapY
         YsKDj6fvhV6c8jp7roKkhO6zCSDenPIW7SxnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707453328; x=1708058128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jF0LVyKfW9zrsYG7qAJeA0jKroE+BQWSh2P7D/n91V4=;
        b=mFfMA+nL2tyeL1wAghlkBQaOFm34xNqoTiHgxhRu6uA7OWZgjdSo5mjM4ZUc9VAFR2
         MY+XmghLZWcNGDEu7P9hsgcke+N/id2QuV1KpriF4wXxj5P7EKTcZgpT5OLh2cRLw2Lw
         Ls3nthXeLO3gaij6u/R7ZtvLq9xam8G/fa94jv1CzOb3Pss52apjuFMDdFY/PG5giAAj
         qBL7lRBLIYsKP+TaJSq6iG1kGDemDcz0UuUoqmDK+jOYffaigCLWhu0BxPMqD+v+Xux2
         XA4/NgnT6Fw3yfY0IEmGEX02bHK/xqupFimpkpJoYZ4hTGwYmYe3+yRQPM+gTMyzhcCC
         iLoA==
X-Forwarded-Encrypted: i=1; AJvYcCXW+S2J6XO2ByipJ0pP3OisKg4ooFqVH0e7TAwYvlyLSOkvL6YgPK3k+Phn8cxpsVKBlPgeJh9cs7Lc9KzV1DziKa7uXmg4WIQe9YdE
X-Gm-Message-State: AOJu0YyI8FThuuMmhmsLcpS4mJwCNXzmOGmg7PkuU+Y72IG4EgZiPzbh
	iMDJg1TqR0NdAdaYJvKbkuw3RCzB5BtW6mJIIpz2cGSOuK8gd66ewQcGIRCBJOaH0Ful70ORdtN
	EynkpxzGUvwOIc3wR6L7+77VRpJb6YaPaR3xs
X-Google-Smtp-Source: AGHT+IGXu2IH3GWDKxukCv+Zi1peMLvcDM/JtXX9yIQavVOTxcNTQbsTSh7G8Y6+SqIc+ST/ZSD8ldlQhnv+PWjXkGE=
X-Received: by 2002:a25:3607:0:b0:dc6:4e33:10bb with SMTP id
 d7-20020a253607000000b00dc64e3310bbmr382362yba.58.1707453328472; Thu, 08 Feb
 2024 20:35:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125004456.575891-1-abhishekpandit@google.com>
 <20240124164443.v2.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid> <CAMFSARfCPbbDviaVoZMvftp1PdXFHKv9ouzG==XnCP9Wrzuv-Q@mail.gmail.com>
In-Reply-To: <CAMFSARfCPbbDviaVoZMvftp1PdXFHKv9ouzG==XnCP9Wrzuv-Q@mail.gmail.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Thu, 8 Feb 2024 20:35:17 -0800
Message-ID: <CANFp7mWz1cs3jwCHqf6Ku_RcQ6HmC9QHazoie=xxz8E6Rj2_QQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] usb: typec: ucsi: Update connector cap and status
To: Jameson Thies <jthies@google.com>
Cc: Abhishek Pandit-Subedi <abhishekpandit@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org, 
	pmalani@chromium.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Rajaram Regupathy <rajaram.regupathy@intel.com>, Saranya Gopal <saranya.gopal@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 11:48=E2=80=AFAM Jameson Thies <jthies@google.com> w=
rote:
>
> Hi Abhishek,
>
> > +#define UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(_f_) \
> > +       (UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV(_f_) << 8)
>
> Can you replace this with a common HEADER_REV_AS_BCD macro that can be
> used for both GET_CONNECTOR_CAPABILTY and GET_CABLE_PROPERTY?
> Also, the USB PD major revision value in the message header is one less t=
han the
> revision (PD Spec section 6.2.1.1.5). So, we need to add 1 before shiftin=
g.

Jameson and I talked briefly and I discovered that PD assigns the
following values for the major rev:
* 00 =3D 1
* 01 =3D 2
* 10 =3D 3
* 11 =3D Reserved/Invalid

From PD 3 onwards, there's a new Get_Revision message that can be
queried from UCSI using GET_PD_MESSAGE. In future patches adding
support for Discover Identity (also using GET_PD_MESSAGE), we will
need to check this major revision to see whether we should also query
Get Revision.

Since this code is incorrect, I will send up a PATCH v4 with the
correct BCD version as Jameson suggested. I'll also fix up some of the
minor nits in that patch series.

>
> Thanks,
> Jameson

