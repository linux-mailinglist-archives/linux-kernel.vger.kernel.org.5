Return-Path: <linux-kernel+bounces-40428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD26283DFF9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCD81C21E9C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4601EB5C;
	Fri, 26 Jan 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilOd2Iny"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23C91CD1F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289943; cv=none; b=GWuz6YsDgDI01sy/P3R7hZhDshApvLJpIH2Sr+ewNL2E4PacOtdqupQrVnkqZoX2RBWHODKgWBNsrJ5IO/A4W/tcSfUjFxEeekcz7fIeYd5QucEjGUilcMl9N1eVuEUkKJoXUHSeA1vR+xrv0UubthDXGXskBG9Pu4CjdxVy9Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289943; c=relaxed/simple;
	bh=xPjbeHM+/HDx6jxzmLz9AOl/bNVzYYu0ALYtamVcz+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZYsxlLefdkyNduRd5+ZLWMgTrBg406LajV+kvyp1Dk5LudY+GF0gY1CUlfmD3JNvR4CpmTxJvEnqv4sYjECOlhAuszkK6isIRAsevIOxHniIFsNYMHXwznAsHHDt4s8T2TP+fce9LzdAvMKn2cV8roiUawn3FuYss3FonGGhjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilOd2Iny; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28a6cef709so61239466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706289940; x=1706894740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFbZbkLrOwRZ5J3+sJIG4KgFkS5YNa71i5ZmLkZajBw=;
        b=ilOd2InyarsOAr6GbMLhDcYymHpDsxE9fZbQDMoq3UcGb+73lMQrUjHA0bMlMHX4o7
         qLX+bCb9VJlO/XcZ9RMYk+PZekV2pcP00YE9xXfYxVfdRRvmxLY0EqOvzaVjuvD34HxO
         VQSJfV5EANyRzTSpC5unp0+DmLvB0Z5c0qYuJZMD6brMXqoTnwKybJ0JQGFAAzFpD6dz
         OEbGnSoD8ZjRWMll5g7pZKhzDhLiucXj6qt9KOy7CaMuGk0agvR/Zn6LLvJFCnGQ3Pdl
         Em5w8lFyf/KENXVPRcPfabjVmUHcWirO7l3M7sQmpvaGn0ToczfB6QNqwXrR808+M6hT
         JCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289940; x=1706894740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFbZbkLrOwRZ5J3+sJIG4KgFkS5YNa71i5ZmLkZajBw=;
        b=gS7xXXPCiRWkHXRjk7aL2gSNzfbuWDIQilhg+QruwJGu/MUXKd4YaN7g/HJETFrxvV
         pMooWvQh+T2dMCaoJXrfXwZma3v7SqBEjpJPqQH/0/uuCNWR5V3SphOiVmXKfLmqL3Uq
         ZwCkLK4tdQ2DH/npP+WgpHourbpfwpa3PAIyELcr4+RBTwwBZaGh3wCeuMJFJyAxwhTB
         lCf/KlSuC2ej3f8BD5t1usoou5jdXpcr0EoiPlS+VPD/1thD5X48pnT74PuvYCIIXcHp
         bW1iI1NYLHbEiABSxyz8YZy1zTCJXWNzvNEIKhweyR06KPWEsPrdzbhrIfFV/PzP4tIq
         Uxjg==
X-Gm-Message-State: AOJu0Yx2vxTnLbZm3fS13SlGLh1/zJPbiUQR9Y+1OL8LFieEVGRvvb/X
	YCqTWO2pIn1YkPS+tSKfXbtSNIs3X4AhQP9ZF3msmOlUkXSIaO4OHAoGdlIKl+jOfFddtSjioMt
	Tbi74fSWtjMBCfcjfKTpyB8bLFAs=
X-Google-Smtp-Source: AGHT+IEgTwvsqU6ZxyJilkEVxiWKWu4BRSw+FjFGu3xyrnVnI9q6JSKu7vmLiKKd/JlPJwiMzQP7l+6LkgrCLM2StXo=
X-Received: by 2002:a17:906:cec7:b0:a28:ab53:eda1 with SMTP id
 si7-20020a170906cec700b00a28ab53eda1mr1074405ejb.34.1706289939576; Fri, 26
 Jan 2024 09:25:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401260626.nE6j5ZwR-lkp@intel.com>
In-Reply-To: <202401260626.nE6j5ZwR-lkp@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 26 Jan 2024 19:25:27 +0200
Message-ID: <CAOQ4uxg0a64FBhKbDiEfDvAqgCR-5bMo+Cq9bDAAtFRs7BQT4g@mail.gmail.com>
Subject: Re: WARNING: modpost: vmlinux: section mismatch in reference:
 vega20_enable_dpm_tasks.part.0+0x2cc (section: .text) -> (unknown) (section: .init.text)
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 12:52=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
> commit: dff745c1221a402b4921d54f292288373cff500c fs: move cleanup from in=
it_file() into its callers
> date:   7 months ago
> config: riscv-randconfig-r026-20230716 (https://download.01.org/0day-ci/a=
rchive/20240126/202401260626.nE6j5ZwR-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240126/202401260626.nE6j5ZwR-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401260626.nE6j5ZwR-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> WARNING: modpost: vmlinux: section mismatch in reference: vega10_populate=
_single_gfx_level+0x164 (section: .text) -> set_reset_devices (section: .in=
it.text)
> WARNING: modpost: vmlinux: section mismatch in reference: vega10_populate=
_single_gfx_level+0x168 (section: .text) -> set_reset_devices (section: .in=
it.text)
> WARNING: modpost: vmlinux: section mismatch in reference: vega10_populate=
_single_gfx_level+0x170 (section: .text) -> set_reset_devices (section: .in=
it.text)
> WARNING: modpost: vmlinux: section mismatch in reference: vega10_populate=
_single_soc_level+0x4e (section: .text) -> set_reset_devices (section: .ini=
t.text)
> WARNING: modpost: vmlinux: section mismatch in reference: vega10_populate=
_single_soc_level+0x5a (section: .text) -> set_reset_devices (section: .ini=
t.text)

Sorry, I have no idea what these warnings are and why they are related to t=
he
mentioned commit.

Maybe someone cares to explain?

Thanks,
Amir.

