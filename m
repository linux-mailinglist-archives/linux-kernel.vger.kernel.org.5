Return-Path: <linux-kernel+bounces-3565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA42816DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5038D1F22872
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A29349F7B;
	Mon, 18 Dec 2023 12:24:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B2442AAE;
	Mon, 18 Dec 2023 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5906cf5bfdfso620601eaf.1;
        Mon, 18 Dec 2023 04:24:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702902291; x=1703507091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHj6tkg0sVzp8V1MrAHaMYjwcXlXZG+bxHOBy//9PR8=;
        b=r7q1fx25BJht0SBPW8JwshxHpyYLzpoAke+/PrlmWG9rB057azcTcir2dBhic58gYz
         lAiQMIIEwVcb9PcsrKiKIH5y23pMBAchdaBnx7CoFIBDcSTrJzFuxz8ZxK1TfuGKsmPX
         yzw54c49B85VT5xtV2+Tp1/k9EwnufjIxsGwNWq8oA+1NfI7VF14LF18LRqK/jOrJs93
         gZvoGeNcozaU6S7ya034mfMCoNt0Eii6H1EOfZWb8OrOXhj7ygrrMhVMro69aXSNhDSc
         3UkGgFZw+buQnLje6OWWh8lty2q6DUi0HDSgy7o7YWZpzzETlVhwathRN2veyWD7vv7Z
         /dgg==
X-Gm-Message-State: AOJu0YwCcWF02MNRoLu00loFtUTd3r+eTf5HMmUFyCaynKHnZeRqbm5s
	nP27M2yCh78JBIX//WBgkmHx5J7bdADrXTn16cs=
X-Google-Smtp-Source: AGHT+IFywSgsHFeCpJEEg0Kwl4OU5AUla85mTTaGLo/VnG2OFG7l6i/IWrkVL9lu6pISHLjC+70QhXexZkCLSgI/wnI=
X-Received: by 2002:a05:6820:2484:b0:591:4861:6b02 with SMTP id
 cq4-20020a056820248400b0059148616b02mr16457528oob.1.1702902290636; Mon, 18
 Dec 2023 04:24:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12358058.O9o76ZdvQC@kreacher> <24090583-2882-4961-a238-c964b099ee55@redhat.com>
In-Reply-To: <24090583-2882-4961-a238-c964b099ee55@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Dec 2023 13:24:34 +0100
Message-ID: <CAJZ5v0hRB18fsa4aWS96fF0Sn0xjaY9Ho5wrrDnr-fK-dTyeoQ@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: utils: Introduce helper for _DEP list lookup
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 1:13=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 12/14/23 12:07, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The ACPI LPSS driver and the Surface platform driver code use almost th=
e
> > same code pattern for checking if one ACPI device is present in the lis=
t
> > returned by _DEP for another ACPI device.
> >
> > To reduce the resulting code duplication, introduce a helper for that
> > called acpi_device_dep() and invoke it from both places.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This depends on the following series sent last week:
> >
> > https://lore.kernel.org/linux-acpi/6008018.lOV4Wx5bFT@kreacher/
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> feel free to merge this through the linux-pm/ACPI tree.

Thank you!

