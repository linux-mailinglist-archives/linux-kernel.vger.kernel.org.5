Return-Path: <linux-kernel+bounces-136056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E743C89CF8E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB8D0B22B30
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4802F3B;
	Tue,  9 Apr 2024 00:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QIt39QWc"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76741A934
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 00:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712623618; cv=none; b=mucwIoSQRZnq2PT7vRFk1v4fCmTJUAkG+AS7Rk8heLeIn7Wq9yIGz78iUBUHkZ/9RcoFLZH4k6/i3GENWE+4X77GU42wTMSb+MPUsSELXI2tY33SVvAcFSLEJzAxlaexCl2NdxDURb3XjFwx8e7s6hQ9xRyvUAd3lz+1ytRn9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712623618; c=relaxed/simple;
	bh=kYHCxsBP2vuDTar4fjz9a47pwunjrRYe1uOFuXyMrX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMLUUXuuwjZoPHazlYV+JYJaTz5BlbXmKuenPRKE0odghiRoC5r9KyEWBSGmprS1Aj0TYoCNELnXRhBmEFjtSgrHpHAell9fHofpO2PX5qU24346gbeHdhPMIlcaz3wKvgYC+tzLURZ+ktmOc6XwkTciL3V9sx3d5eEuvHVICrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QIt39QWc; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso1708581a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 17:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712623615; x=1713228415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAaOrnh08gDDN4c+q0l1+Xwj6sb8iH6us+XtwUqPkIo=;
        b=QIt39QWcJQWCcbPLAwJAhCqsfgpuCNRof7Jk0m50sxl3dSWRBaM2B9C4NZGZiIjWzy
         JIM+IM7b3RnZbKBhtvySShO4nye9a7qVxhemKkzUUVEwwCFRXUZtHOP1RktqTaGqLN17
         5d+mSjREPNcUhCkDxgK1IK/CB6w/i0rUpmsq7FYDEYSdhZs0aYwmA2VwcspjMsMuLUcp
         LKCyl8FG59HOLunCavSRxjqo+RLYkh51WHU1co1YVKplDKC2aftnExYFkEE8QguGTUfW
         yNv+USglhaPSPNRMJf0rsQzY2jvhx0RGuTtr2bcsCUSG4GgOwT/XqITftfMoAQTQU43V
         DNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712623615; x=1713228415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAaOrnh08gDDN4c+q0l1+Xwj6sb8iH6us+XtwUqPkIo=;
        b=dX98ZeaIbYWOMJCFz2QAjTv57s+U/7ecwVIfM4OF1tDHcoWX0M/Z2rECfMeqQUlOwh
         nbUtuG5JPjP7sgdoI49dxjbdJTkb/oMk3RnuA/F+RSy0oYV8ogmbkzH920jL3U9i3RMM
         Qdw5Iaa3waLVmO8IdG9lKkP4KaGcdsv8bsInUoQpuItWZ8yX69/xaH6ZQYuB60ZqDXJm
         cugRkghnYKyW3BRf8VqQIf3RDQwSNPfLEhP7ndctJ9RKekDPKBTlBE/woQ6P13gClB7d
         hcnVtU3jviLtxLVLLhxeBbWcyvm7COloIUvhEBWn9+BpvbT1dSpvvNPnBe3xFKXv5oAi
         2oaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIBZTB0PSLnwYruAi7kYOEzSWu2BQUtEO0Go2QHNOO0SdedSQcQiDdtSVyILzrKtbpjViXVYxu91yfK2vEQs/IbYdYPbqtM4Yf+AQD
X-Gm-Message-State: AOJu0Ywh7LEqVmbP6lXSa1hLs1K3Hme7SXWZRjlSrcL2MPNfW5MsiOjJ
	MMIl01TZP9ZqKTvdxwkEWlWfCRVYjpYKQ7RK9bdiEVoU5xJ+LSQWN+fJnDD91JkqWrlM77Y5Abz
	/pI82456aQYeZdDpzZl7GJX8emIc9praR7k3b
X-Google-Smtp-Source: AGHT+IGc0lj+fiC2sXIjuliZLsfp/BjTYjGSVXvVjzrsIb1sivcbJfZxakLmiUfgp5f/pckL+Y6vnZ7DHo+6jCgBIfk=
X-Received: by 2002:a50:d796:0:b0:56e:2ebc:5c4 with SMTP id
 w22-20020a50d796000000b0056e2ebc05c4mr7572527edi.20.1712623614748; Mon, 08
 Apr 2024 17:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405-strncpy-kernel-debug-kdb-kdb_io-c-v2-1-d0bf595ab301@google.com>
 <20240405095144.GB2890893@aspen.lan>
In-Reply-To: <20240405095144.GB2890893@aspen.lan>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 8 Apr 2024 17:46:42 -0700
Message-ID: <CAFhGd8q99emm1SFJSs=L7Pn0A79vCtDHtTD5XUbVCNh=DDadaQ@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: replace deprecated strncpy
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, Douglas Anderson <dianders@chromium.org>, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 2:51=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> >                       len_tmp =3D strlen(p_tmp);
> > -                     strncpy(cp, p_tmp+len, len_tmp-len + 1);
> > +                     strscpy(cp, p_tmp+len, len_tmp-len + 1);
>
> Again, I really don't think the third argument provides the number of
> characters in the destination buffer.
>

Right, the third argument is the length of the "remaining" characters
from the completion point.

if you type "tes" and press tab then kallsyms_symbol_complete() will
populate p_tmp with "test". Prior to rendering to the user, @cp points
to "s", we need to catch the user up and print the rest of the symbol
name since they've already typed "tes" we only need to print out "t".

len_tmp is the length of the entire symbol part as returned by
kallsyms_symbol_complete() and len is the length of only the
user-typed symbol. Therefore, the amount of remaining characters to
print is given by len_tmp-len (and +1 for a NUL-byte).

So, yeah, you're right. This isn't the length of the destination but I
don't see why we can't use memcpy() (or strscpy()) and have this not
be considered "broken". The pointer arithmetic checks out.

I tested out strcat and other alternatives and they all seem less readable.

>
> Daniel.

