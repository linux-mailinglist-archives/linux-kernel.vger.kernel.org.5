Return-Path: <linux-kernel+bounces-95342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8904874C7B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5A01F23A42
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803EA8562E;
	Thu,  7 Mar 2024 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GORjDS90"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFA784FD3;
	Thu,  7 Mar 2024 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807735; cv=none; b=WmNP+JX1sY8oaNssNR0OfZ1ceYASlnQD6drjp8RfdGufmhF4ZjnfMtNM9CriGyOzXtq4WiVdG3oDK22xIdSKWxc0+AcxxDFEBiFFE8+MIGCIojYaszUiKM/i8521/yz/0WoCzlCoox/01ulAvN+biOegjz8W42njh1R+aB3V99I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807735; c=relaxed/simple;
	bh=/TeQvUKlWImP1Pf7JVs9M4/raK0rsygDoJ49zfJikGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWeWCARI7xpm5qVPs3uuTL6c5kdrQIBe9Zng5c2M1GNaOfSc+rhA8w8lBzrFwpz1Xl3rTAkVUPBeiutc2ASqxfTUQReE4/kwic7RP9nwf67J+T3+sElHxbH7CJfpf5prHxSleQtrOc/aSQQsKwoPH1o0AMYPyfpZgqi4fPFBr8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GORjDS90; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a293f2280c7so123165266b.1;
        Thu, 07 Mar 2024 02:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709807732; x=1710412532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LktdwCr7E2g4+9C9lRYb0fZ1kq1OEB07GM3xOk1omb4=;
        b=GORjDS90G2Z4/9veb1PddSshLS77camuyKsvg1pFmISNd0F7CmOMVMDQMgsSaIQ5Hp
         B9gcbCN8PjZ1Sggj9HPs/dU9AlzUb5DSdM8zvJMrXkJyO3wf+lurcL6/UuQ/8dCPItgm
         UDA0u/5Ev5d+HqjufsUG6VAuIkeyPSd/dP8RXlp/sOz300whpVLg+Me/OcFOqwAGsbSa
         H/2zMbEqa0vHOZPHHsVjRQxvJPSzBMr++6js6vQr/jRPsOyZ46JWMHRgWLyE9ESYXXWi
         p8ne9fJrpTC+ivp7YmfDnJ/YJDLtFlX3tZ4ZER51CPrj3PRMuqut8oGeGIQ8G3qLG/ng
         muUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709807732; x=1710412532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LktdwCr7E2g4+9C9lRYb0fZ1kq1OEB07GM3xOk1omb4=;
        b=MAXmdF8R5bbjBUvIXVGhR1pbyjcE4lIf2BB9Bov1ZAO0Q72s/IUBMCkIoe6QbT9r4a
         DeHjHnENlt8SV1H7eq58p3977WQVMgUYhr2BqJeUMIkyM5aHDEN1d9XXlcjpzJGBktf2
         IGqDsopLDv8AAkXpyH8YnSCztmY6SNE64vD7/A1u76OwoLZCxBy40xMIMPb0Ixdt2IVF
         GfLEehMKi+BtbcrAqaQyBOt8OfeG6gOuz9nXjlFlxlOkCk7RghIwmjFBR1/dwQzQr9GC
         K7LqeoDofU9ZNforx/td0fOWyuy8Yv/OwQnIAMqnMbIUJHCyqbkdR2xXj2pkYgPmSDtF
         7IqA==
X-Forwarded-Encrypted: i=1; AJvYcCW4KpD8H27cximGVO/rqWEhGubVfVuHAQx3hS/TvSd3MEyZDUdriCH8r6eutMj75QlDLk6rSJtJ6aeeGLJoy/4MzmL8KgQoxz7J857wDYsH+ZNLfvhvRCfc/v7XZysim1RXP8XCNqauSQ==
X-Gm-Message-State: AOJu0Yx+DMpXIcEdw8RuNBpTmiug0GuI8o56zEweZG9zeVH5H+eR9CCg
	2hD2yKkmnamP+NS9/fFI7ubcIgSl0kziY8h5RsxJf0ktOWvHcAevaRiC+x1tL5KpDQRKMBVo29k
	ETDDebYnNceSHCZefhCkjm9txxljqikjCQbw=
X-Google-Smtp-Source: AGHT+IG7MolBiSHVr/INkdjHQrA8QhTieyub8IO8rqNdLDpucjeMceusqvRWtjt+QmkAY6qqVrGrYIH/KY4d3qBfxhQ=
X-Received: by 2002:a17:906:b2cf:b0:a45:b273:17c2 with SMTP id
 cf15-20020a170906b2cf00b00a45b27317c2mr2858740ejb.2.1709807731966; Thu, 07
 Mar 2024 02:35:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307024034.1548605-1-gnstark@salutedevices.com> <20240307024034.1548605-3-gnstark@salutedevices.com>
In-Reply-To: <20240307024034.1548605-3-gnstark@salutedevices.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Mar 2024 12:34:55 +0200
Message-ID: <CAHp75VfkTxRtMc_SpXoyoVjiWxm=c6_1VjeiRFUo4C7kH4HmUA@mail.gmail.com>
Subject: Re: [PATCH v5 02/10] locking/mutex: introduce devm_mutex_init
To: George Stark <gnstark@salutedevices.com>
Cc: pavel@ucw.cz, lee@kernel.org, vadimp@nvidia.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, hdegoede@redhat.com, 
	mazziesaccount@gmail.com, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com, 
	nikitos.tr@gmail.com, kabel@kernel.org, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kernel@salutedevices.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 4:40=E2=80=AFAM George Stark <gnstark@salutedevices.=
com> wrote:
>
> Using of devm API leads to a certain order of releasing resources.
> So all dependent resources which are not devm-wrapped should be deleted
> with respect to devm-release order. Mutex is one of such objects that
> often is bound to other resources and has no own devm wrapping.
> Since mutex_destroy() actually does nothing in non-debug builds
> frequently calling mutex_destroy() is just ignored which is safe for now
> but wrong formally and can lead to a problem if mutex_destroy() will be
> extended so introduce devm_mutex_init()
>
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

>  Hello Christophe. Hope you don't mind I put you SoB tag because you help=
ed alot
>  to make this patch happen.

You also need to figure out who should be the author of the patch and
probably add a (missing) Co-developed-by. After all you should also
follow the correct order of SoBs.

--=20
With Best Regards,
Andy Shevchenko

