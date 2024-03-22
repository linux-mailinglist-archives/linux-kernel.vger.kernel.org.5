Return-Path: <linux-kernel+bounces-111741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A64CC887030
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC341F23EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C402959177;
	Fri, 22 Mar 2024 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqcIEBaI"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842BE59176;
	Fri, 22 Mar 2024 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123342; cv=none; b=l0vkPbK8cW/ss8xszssYgtOGk7G8H8O4xyEuBC11aGnBxwRX08ezEcRuzgusV5ptXGenQQGunaeb2vcklzbj9bQMUomhtJ3q/cLc05+npohu0XyBVLwx0I/gftiziqVRBt+lFbo8cUn45G7+iL4/mmFEwvgd3Quy77o7z6YYm+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123342; c=relaxed/simple;
	bh=Fh1WVlXUCaDzE+2uvloKq2wmWpHmUcExpGG+lPA3Nz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlG8RZK11FJXZ4+q7e2FxfJ70uzKd+KAuu7NhgGMfERwgO9CuuP1wjGEY2lyid9l5ZRHOstUjrptUbDv2SSwH0c1Ah27wqFlU4Kxdlkuo5LKRWukpKgGdhuwBtuFyTBgovt6yY78xUdK7//BDIdtgshkBkcTKmC2TyshtnVJAPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqcIEBaI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46f97b8a1bso308978766b.0;
        Fri, 22 Mar 2024 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711123339; x=1711728139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPqoca3+E6LNWJ9WbqjZz0KE97nzXeTI6WO+9c+3l6A=;
        b=OqcIEBaIGZMzKwinb4pCyYvxnGviIpvc9qV9ukjKfDSDE9qUPGWrBah8B0i1SdYZ1j
         yTgzru1IDqPoxatyPTbWW8c0M/oXXSkKEP4MBx1V9bgkn2GSjgA3KufhAU259yfvkIl7
         pas3E4iJhAfYn2D+v6e4UqgKUkY2PqUAEkVtixrqn33UiZH1N19GwusAmfwhTzFrK15n
         qUGVVrbQv/yx2SCSsLmrT4LKBiRRMmHYiPR+gpAH3VfLaXylR+NPmVoTBnjkHj21cNjq
         /jvl1nNFEi+gH4HNpIJio06LgU9L4sJdxpA1DsT7Cv9uV8fgHOZK5lc9BAhs3bHUk4Zc
         X6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711123339; x=1711728139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPqoca3+E6LNWJ9WbqjZz0KE97nzXeTI6WO+9c+3l6A=;
        b=Hf9CcldVi852Uv7Y6Fax7Fi680uQkhxcU3lJ0ynxxgcg9nVAphFQ9GeCP/tU7k/hxq
         7Vfa0uxK7pOZMRyHsD/k8JwWRJhbc+UfNfQarmlb7TIVX9Mv2PqMUlkJNGU45rbBfdaz
         6L2/scevu3/fSIjFSgrm1g2f07c4tvXFOhGhoq3LNmb+d6+iWHsc1mUtvU+3TXdQ60rd
         oh2H0dToEpK3r2Sai8p7vHu9FVd0/8ALCwyOpVw7RPKEIVXGfAGLboS/vAaKt/2voMft
         VoEHOn50tmMdxMrMk6qSCxYeuYVeqKiyb+NZlJ2LQVXawF85posseEz5OeOlJ5cl0dIG
         q7pw==
X-Forwarded-Encrypted: i=1; AJvYcCWbyEL6/YNt2acXKH6YkFsVgrD5Bon1C7M3cL7ZjFAzGRFvtT+Uhvxysn7G0EaJ5XN8r6mrcD1AZthgdRoU7UhS1F0czRN6cjt0wkVNcRs4ZriOH3nQLllTpYJUAHIw7W2Lkbc5RpUq5GwmVSAWqxhmhuwuP8R69nTsz0Xt8FrtFmsRfKqAUZ7dUaB87LE=
X-Gm-Message-State: AOJu0YzzWXYlc1TCllg4DwOABwuBoYGan4cJVONOFkEAvTiUbNcSQbFJ
	r3ao1N/wxeYVNQ0hxbPspQE0RiUWdO7lnDiWvOomH77YVFfYCEn53vmYiigxH/CMccJODrvBu6f
	129cXtU8vVa4N8Vq5u6NzWBhAAq/TPtC84KE=
X-Google-Smtp-Source: AGHT+IHrqPd014UhVB5COl0nfeju4prpHRPxz6aAstoqTW/frcw+zEFJRprsD9GE7c4ZfoZuZEXUC0gYmH0ur9J/ccM=
X-Received: by 2002:a17:906:a3d6:b0:a46:fc33:9f3a with SMTP id
 ca22-20020a170906a3d600b00a46fc339f3amr113539ejb.26.1711123338499; Fri, 22
 Mar 2024 09:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306025801.8814-1-hpa@redhat.com> <20240306025801.8814-3-hpa@redhat.com>
 <Ze-N_y5Tbjc93aRp@surfacebook.localdomain> <CAEth8oEdzomdn5avXf44HXpoMFDfGpOjjxPFtaGkh0EhfZsPMQ@mail.gmail.com>
In-Reply-To: <CAEth8oEdzomdn5avXf44HXpoMFDfGpOjjxPFtaGkh0EhfZsPMQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 22 Mar 2024 18:01:42 +0200
Message-ID: <CAHp75VeoZ7p=7e9CgZftT5hThf-uMaUrqZBv=+tNYiUOevUOnw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] leds: rgb: leds-ktd202x: Get device properties
 through fwnode to support ACPI
To: Kate Hsuan <hpa@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 7:45=E2=80=AFAM Kate Hsuan <hpa@redhat.com> wrote:
> On Tue, Mar 12, 2024 at 7:04=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

..

> > > +     chip->num_leds =3D (unsigned long)i2c_get_match_data(client);
> >
> > No warnings during compilation?
> Yes, the compiler doesn't complain about it.

And for 32-bit mode as well?

..

P.S. You have commented only on the two comments. What about the rest?

--=20
With Best Regards,
Andy Shevchenko

