Return-Path: <linux-kernel+bounces-24064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81E582B64D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BC0286602
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C41C58118;
	Thu, 11 Jan 2024 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QDyobU/z"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49DA58110
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3ea8d0f9dso2465ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705006606; x=1705611406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSeHssvYv9blP8TVGxyPovH+u6pLNEPHwtrNmzKb4J8=;
        b=QDyobU/z28h9ThH92Pp8o6xlnxDOqmCIg2/KTav4RItBTLmGgATaJ/dcYxQZJla/Ns
         81WC5YBWyCNAZylZXb5EGXQuOXUsdekBYv8ezXgYfv4+dkEWY/I6c+MtQ/OD4MK2H6TI
         720YKexvbjB4/QcI8cVYzpayutlXgs1j64oFpFv3CkT18ZYp2uVY12mIb0UNRFd933Eq
         pNzeYKRcPXdMepAHzL47i8BHCJzG2Zh0cxFNgTs/T3dEuKCz9GGJ2bqxYjKwTgGWgtZf
         9d6oRVFZ94w4nrH/aQ+kMk8b6ZPQc5JjxiM1wkxOvvctHBiMHXBSQ11rheJCMWMDvq0S
         JhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705006606; x=1705611406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSeHssvYv9blP8TVGxyPovH+u6pLNEPHwtrNmzKb4J8=;
        b=hMay6Zb8EUpHzmV0gXvXtnjFuy1EJ+X+uLe29I4tWS9Wh+MuH+xrRp1kqCCfNaT5Y1
         yFT60LhHSLkdM8eG3/ryeg4qHX1Y/zip9xZ1h043zA8cI/khfSTiha11dzIubMZmdm3X
         20HGjsL6USFQjLwfSEiT1FqmQx++LCYwpx57Gse4dgyiSrElpRQBnWEMY5P1vDbwQ3Nx
         1qpFTOC55V0t3YNfz24oY6TYrY2+HH0tKcleqEUNN9vdB0LUv6d8qC0+boV0kVM5zAkr
         0ZP8fV6t9lWDTXw1a5zN2+wG0xT1cLnrrV+OdIqLTp9dBziia42NmlEsG3kf+RF3YLES
         26zQ==
X-Gm-Message-State: AOJu0YxmReBUHOR7hPm2XX4NVM2e6b1/VbJglN1WhDoj5daqmd5XnasF
	VTRnV2qowjsZ7Kup+/in1V2rc3kSejmpvvPAR/86qcLGXt7I
X-Google-Smtp-Source: AGHT+IEfsy83FW6TuDayfjzdD3Al9IHLAtufV6lR/ZTHNTIHZ1yaX972WZYlfsLHwvL6UOSkTZ0cwR0DTnXeIbyTj0w=
X-Received: by 2002:a17:903:22ce:b0:1d5:4b66:81e8 with SMTP id
 y14-20020a17090322ce00b001d54b6681e8mr227140plg.4.1705006605713; Thu, 11 Jan
 2024 12:56:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230815152712.1760046-1-amitsinght@marvell.com>
 <f0e10f31-8571-baf6-6665-b077af067777@intel.com> <MW4PR18MB5084D5EEBC450BD66E8063E3C61FA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <6114c8d0-97a1-be54-3e43-30348be38683@intel.com> <MW4PR18MB50847032F3ACFDBDBCA6D57AC61CA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <be51596e-2e62-2fb9-4176-b0b2a2abb1d3@intel.com> <MW4PR18MB5084EB7DBE4985D981FE84F2C61DA@MW4PR18MB5084.namprd18.prod.outlook.com>
In-Reply-To: <MW4PR18MB5084EB7DBE4985D981FE84F2C61DA@MW4PR18MB5084.namprd18.prod.outlook.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 11 Jan 2024 12:56:34 -0800
Message-ID: <CALPaoCgjFKtTtgrh2UwEsX0DsVnmRF2+8LS4CUdSLjMPmLVgMA@mail.gmail.com>
Subject: Re: [EXT] Re: [RFC 00/12] ARM: MPAM: add support for priority
 partitioning control
To: Amit Singh Tomar <amitsinght@marvell.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"fenghua.yu@intel.com" <fenghua.yu@intel.com>, "james.morse@arm.com" <james.morse@arm.com>, 
	George Cherian <gcherian@marvell.com>, "robh@kernel.org" <robh@kernel.org>, 
	"Luck, Tony" <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amit,

On Thu, Aug 24, 2023 at 1:52=E2=80=AFAM Amit Singh Tomar <amitsinght@marvel=
l.com> wrote:

> 2) Second approach that we discussed internally is to have schemata for C=
POR, and PPART separated by new line as mentioned/suggested by Peter, But i=
t may require to tweak
>    the ARM MPAM device driver a bit. It was kind of toss-up between 2nd a=
nd 3nd approach :), and we went with the 3rd one.
>
>    L3:0=3DXXXX
>    L3:0=3DPPART=3DX
>
>    Will look into it again.

I've been looking into the structure of the MPAM driver to understand
the difficulties here.

It seems the challenge with DSPRI is trying to stuff two different
control schema (partitioning, prioritization) into the L3
rdt_resource. The rdt_resource is still a mix of a hardware component
and user interface (schema line), which leads to  the
__resource_props_mismatch() function[1], which makes an arbitrary
choice (driven by resource index order) of which feature should be the
single control presented for each of the rdt_resources, the properties
of which the fields of its rdt_resource entry should describe.

It only seemed to work out for CDP emulation because the properties of
the two schema (L3CODE, L3DATA) for the L3 resource have the same CBM
properties.

My opinion is that the rdt_resource needs to be removed from
fs/resctrl and replaced with a structure to represent a control schema
and another to represent a monitor so that we don't find ourselves
unable to enumerate controls or monitors because a control or monitor
from the same hardware component has already been enumerated.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/dr=
ivers/platform/mpam/mpam_devices.c?h=3Dmpam/snapshot/v6.7-rc2#n1810

-Peter

