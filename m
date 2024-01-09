Return-Path: <linux-kernel+bounces-20839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370D68285FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5FEFB239FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B224381CB;
	Tue,  9 Jan 2024 12:24:07 +0000 (UTC)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D31381B4;
	Tue,  9 Jan 2024 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-20475bf35a2so577271fac.1;
        Tue, 09 Jan 2024 04:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704803045; x=1705407845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rc967UiV3NAANd8cc+rYqIM+zZqI5KamtLFvxcveXnE=;
        b=lhlFEiD0BEU3goZuwrB4IljaOhuvWQ0m/+8prq5DpvOx87ENJ1uKTOLpnn6nVUVcrR
         Vvqkt3vJ7sUF2RXNN+edgBhrXD8TvyjR2vxFGekZ+++vY2EICz7PIOo5Cf7eMiNLP4hh
         TbYUhRcm45OA3quTmuDVSQCOGnI8BX1AXoa/hvAlpKjD3o45wuUFAItEKhhTlNMGca2Q
         95hD5YJN0FXYXKLb6UO1sVG3TJz2sIv9lAzk7XulEmZgPX+4Muw/dVkTEQuC1n0Bq5PL
         ufvBLvpoEqR3wTXmnCZ1qQv1lZ4IbhZ0kM/eaDUzc3SfeEG28qGijhXl+QnxsQ0rKfQn
         c91w==
X-Gm-Message-State: AOJu0YxYR/F+5WomocbiADykpNZZwE0CxhKdFIvfwbdZWtqhDIsOOBoC
	86LV/CbfMRQiwEe/4xVoIWdp/VBxcK1ECPfowMo=
X-Google-Smtp-Source: AGHT+IHX44BcsmtTStBgy6MuZ3oAaQRStQesSSIwI/88TrcHx06U05nNsrSYs4sTTczDkv6YImoNk8k/XLi0CXkiWck=
X-Received: by 2002:a05:6820:388:b0:598:6f59:3 with SMTP id
 r8-20020a056820038800b005986f590003mr3123570ooj.0.1704803044983; Tue, 09 Jan
 2024 04:24:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4556052.LvFx2qVVIh@kreacher> <7628882.EvYhyI6sBW@kreacher> <13835e24-1042-41e4-9a3c-dd0adf3462ca@linaro.org>
In-Reply-To: <13835e24-1042-41e4-9a3c-dd0adf3462ca@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jan 2024 13:23:52 +0100
Message-ID: <CAJZ5v0hvafw6_N4M6mwecwS0C9VuXq07RU0DtsB4CDOhjkS8Wg@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] thermal: netlink: Rework cdev-related notify API
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 12:36=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 15/12/2023 21:02, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The only actually used thermal netlink notification routine related
> > to cooling devices is thermal_notify_cdev_state_update().  The other
> > two, thermal_notify_cdev_add() and thermal_notify_cdev_delete(), are
> > never used.
>
> I think it is an oversight. These should be called in
> thermal_cooling_device_[un]register()

OK, so for now I'll just change them to take a (const) pointer to the
cdev as the argument - the rest they can get from there.

A patch adding them to thermal_cooling_device_[un]register() would be
separate, for the next cycle.  Where should they be called in there?
Under thermal_list_lock I suppose?

I'll send a replacement for the $subject patch later and I'll queue up
the rest of the series.

Thanks for the reviews!

