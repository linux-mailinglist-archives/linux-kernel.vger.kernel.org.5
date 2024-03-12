Return-Path: <linux-kernel+bounces-100748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE290879CA8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656D21F238A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8B8142903;
	Tue, 12 Mar 2024 20:11:03 +0000 (UTC)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8E23A6;
	Tue, 12 Mar 2024 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274263; cv=none; b=hWIdRXvojnNtnIc9Lt2DYql8/dF3CA9YCeWR2b0DXlsRnY9KWNPdxxyRNHlOvNCCkcgX+eZ6+LjWmCNb24tIKjD0Z7c5z6WhzvEPuOQAU/fDVO5o4VjtegejRykm4Irq9DRo6JN2u+20N669qwFYI1Z027A3Lat/Khdb9ANAGmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274263; c=relaxed/simple;
	bh=je5YC9U3ddF8ei/q29MpEPpcJqXyyP/xr4yGnd/FbS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEv8TL1bqQV6iyDOfGOKMAFYSaWQkl4sE05cpVcH0Zd2LWwqbfkWpqC8CuI5lSBk7qHe/m24nRrxGK0qsKqKoi9HUTcCjheEMtgAPpU7gfjzCxpMjUSsl/hrFLgV0lKlSlshdJR1eOMGuLysQ/HbzSV35Wtb2jMq3VDdO3+W758=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-221a1722824so387323fac.1;
        Tue, 12 Mar 2024 13:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710274261; x=1710879061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXxHWgg+0wOaWKRbDAdCzkozj0GWD5SuJOBuLOZermI=;
        b=UOg2ew+/c+tBYbPYpzGCyomgwfZvwRO5Ij5xiFqXkjg/T0fuoJPh6gyp+KRFefu8LP
         zVAJMl2R/QSlzp7L4hIYI63iTnW8jXdoLz8IoxAT/5RdhqovHnt8a5IA0GiF/IrFfsNi
         o9u8FJyHgUjP8NRSJ8XBwGHbaZNSqyUwxLLXzGWDmb6WS1g4rDlJqDzbfMJJmb79gBRE
         9rwAplD0ozdpgLfpYSy0hrVdS3q7XcyOtZm13oSZ2Ve1jR9KLnrWrWgzCiYbU4wVwaQx
         ifLLuh/sas/J6eHt0l7Gj4tgRK7k9Aef77YYiD/LNsNZ42iJY2xIeylVqtUjoiXMyvkr
         sMkA==
X-Forwarded-Encrypted: i=1; AJvYcCUe4evalMDFhqiGWVBwwFRiXgx0NW5UMsQ4I09H/NFXPysJlYtABOuwyarmXoZyML/dWG9hGVwO6veomACVz1Vl99msK31VrZy1susjudAfz6CsRXBG06JSwP0uDIXyvSuql6mkfHVoMw==
X-Gm-Message-State: AOJu0YyhEM49/SgPbkUrq8/H8HftFtYlvkxP927fhFSIaXjcYoGri6N1
	z0u64GztoBrY07Gm4DcUwj+QnyJav3Egpao7dK/gImnUgd8j9/z5/eMA+6H878nJf9ieufnd/6z
	cVcSkFGlAdIaamq9CZtyhyMZKaRs=
X-Google-Smtp-Source: AGHT+IH84zxGnZ+6HYPVQpIHxVZhMBEXHQoKKTB+hn81jpYlVGueuJF3ddHZcUPjfoJr3HSELgOW7w0JZKKwWVvgKaA=
X-Received: by 2002:a05:6870:1ce:b0:221:bc20:76e1 with SMTP id
 n14-20020a05687001ce00b00221bc2076e1mr11006554oad.0.1710274260979; Tue, 12
 Mar 2024 13:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309201310.7548-1-W_Armin@gmx.de>
In-Reply-To: <20240309201310.7548-1-W_Armin@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Mar 2024 21:10:49 +0100
Message-ID: <CAJZ5v0hKwThcAO4jMOzi7ySqSv_jHvs_+paBB212qVsaf7LZng@mail.gmail.com>
Subject: Re: [PATCH 0/5] ACPI: bus: _OSC fixes
To: Armin Wolf <W_Armin@gmx.de>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 9:13=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> This patch series fixes the handling of various ACPI features bits
> when evaluating _OSC.
>
> The first three patches fix the reporting of various features supported
> by the kernel, while the fourth patch corrects the feature bit used to
> indicate support for the "Generic Initiator Affinity" in SRAT.
>
> The last patch fixes the reporting of IRQ ResourceSource support. Unlike
> the other feature bits, the ACPI specification states that this feature
> bit might be used by the ACPI firmware to indicate whether or not it
> supports the usage of IRQ ResourceSource:
>
>         "If not set, the OS may choose to ignore the ResourceSource
>          parameter in the extended interrupt descriptor."
>
> Since the code responsible for parsing IRQ ResourceSource already checks
> if ResourceSource is present, i assumed that we can omit taking this
> into account.
>
> All patches where tested on a Asus Prime B650-Plus and a Dell Inspiron
> 3505.
>
> Armin Wolf (5):
>   ACPI: bus: Indicate support for _TFP thru _OSC
>   ACPI: bus: Indicate support for more than 16 p-states thru _OSC
>   ACPI: bus: Indicate support for the Generic Event Device thru _OSC
>   ACPI: Fix Generic Initiator Affinity _OSC bit
>   ACPI: bus: Indicate support for IRQ ResourceSource thru _OSC
>
>  drivers/acpi/bus.c   | 5 +++++
>  include/linux/acpi.h | 6 +++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> --

All of that looks reasonable to me, but do you know about systems in
the field where any of these patches actually fix functionality?

If not, I'd prefer to queue them up for 6.10 as they are likely to
change behavior, at least in corner cases.

Thanks!

