Return-Path: <linux-kernel+bounces-23553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D486E82AE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C77128798C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C156B15AE8;
	Thu, 11 Jan 2024 12:01:56 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251933FB10;
	Thu, 11 Jan 2024 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-598a2136259so236186eaf.1;
        Thu, 11 Jan 2024 04:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704974514; x=1705579314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XiuSCGwsd/t5Dgf3yHyqgsJ+VroL3UeTd33khGKhTI=;
        b=iC0NQjk9AZwojcWE425RB4I1KjYFiF4vzjGQ1YJxTXyc84IYVsMb1k2gQxf8rRBogv
         L8dfl+YcMM/UFEkwYOgPtMKPVvltVfL1RWyQN8c9vVhbptUVA9lgF+2qGIOwM2TfkfQI
         Yp3O71vBUDpK1FyWzQDxin3+HAjF/oVZ0PeTY0Nh5c5SR/Bmb2S6zAD4LjXQeDn1aR8d
         Q2wypfheVxjDlfHCN9RCxRm16XCeVlmAv0hLgDNODEcIWOBt7TYCNhmxO0evyVae38PT
         uddTxCTWJypPxxaNWfpzk+d1x9vPlgFgocBEF8fYUx/hrTgCO5gjy52+WIaXIUxWo5ER
         ThSQ==
X-Gm-Message-State: AOJu0YybguhzfwZKD+irY/xRT10AKW/2IjRa8/I0GmTYKf0Zm34hwKf+
	ugs4dLduPWAc+haNW6ZQAgDL77HDNqURFq+jzRCK2MXVxWM=
X-Google-Smtp-Source: AGHT+IHhHHKIsE/cgwIw4HBa+BLWUndW9IeqnPSgYbokaXzRacI+Izx7X4eXyAx32qnJ00ZldF0VsznpxRwazZE1RJw=
X-Received: by 2002:a4a:d08d:0:b0:598:81b7:4d25 with SMTP id
 i13-20020a4ad08d000000b0059881b74d25mr2025290oor.1.1704974513976; Thu, 11 Jan
 2024 04:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10423008.nUPlyArG6x@kreacher> <ZZ5zcBBEv7qupIdE@linux.intel.com>
 <CAJZ5v0gp6uETgLNHxDnSd4h_0ois7J2AC7soJJVv18B99GmxcQ@mail.gmail.com>
 <ZZ6kDVD3p4KdR9Cs@linux.intel.com> <ZZ+fiUZolz3jogcE@linux.intel.com>
In-Reply-To: <ZZ+fiUZolz3jogcE@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Jan 2024 13:01:41 +0100
Message-ID: <CAJZ5v0j4chSHHiJYaxPuCcH8qM_yRd8y2FwtEL-Yp77Uq5RU3w@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume optimization
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 8:58=E2=80=AFAM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Wed, Jan 10, 2024 at 03:05:07PM +0100, Stanislaw Gruszka wrote:
> > On Wed, Jan 10, 2024 at 01:33:07PM +0100, Rafael J. Wysocki wrote:
> > > > I would consider different naming just to make clear this
> > > > is regarding async call, in_progress looks too generic for me.
> > >
> > > OK, what about async_in_progress?
> > Sure, that better.
>
> Even better would be using_async IMO, because we don't know if
> async call is in progress or finish or before start.

Well, "in progress" applies to all of the processing of the async call
and I regard it as "in progress" once it is known that it will run
asynchronously eventually.

In any case, I've already applied the async_in_progress version, thanks!

