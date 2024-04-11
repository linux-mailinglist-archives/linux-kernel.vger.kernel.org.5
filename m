Return-Path: <linux-kernel+bounces-140576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF438A165A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBDE32851D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A94E14D718;
	Thu, 11 Apr 2024 13:57:28 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5109C14D703;
	Thu, 11 Apr 2024 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843848; cv=none; b=lFUI3Xqmd9llZUsleuGzzwQAbWUGFWKBiZOMTiK8sAZVXuw94glzhQj1ubtPoNRHaYPjg3qC9vSWXMNuqa66VPyIuzEeXmESfF5ZOEYrfQsw1/xLgBowahZmdaLse8C/DPW1TGC7y02QjJBeeEdDEkOgALkRiNN0P/1odG6nUjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843848; c=relaxed/simple;
	bh=lge/MgUosyK8blHwHVZwkv4fT+9m3PjR3GTcEf/nH6U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rToaaz6zLSke1laskok/5A543DVCXlaW2v5p5GnoqDaYuAZyVSrXj4+kXbuahe5rp9XIgBdf33umHBcjm1lZzpKY7YakPaLDRg8C45+gKAKwAdDfLwORqmTkXJFHMdGMOKWm72eCtHix3uqPA/Nu//yZgGufz7lHhCCGjBoyuAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VFh345sKWz6K96M;
	Thu, 11 Apr 2024 21:52:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A0C7140B2F;
	Thu, 11 Apr 2024 21:57:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 11 Apr
 2024 14:57:21 +0100
Date: Thu, 11 Apr 2024 14:57:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Miguel Luis <miguel.luis@oracle.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Subject: Re: [RFC PATCH 3/4] ACPI: processor: refactor
 acpi_processor_get_info: isolate acpi_{map|unmap}_cpu under
 CONFIG_ACPI_HOTPLUG_CPU
Message-ID: <20240411145720.000056f6@Huawei.com>
In-Reply-To: <11AF41A3-05DD-4100-B327-295EF74FE7F6@oracle.com>
References: <20240409150536.9933-1-miguel.luis@oracle.com>
	<20240409150536.9933-4-miguel.luis@oracle.com>
	<20240410142359.00003dea@Huawei.com>
	<AC422669-2869-4C05-B8CD-4C94BDE24012@oracle.com>
	<20240410204415.00005597@Huawei.com>
	<11AF41A3-05DD-4100-B327-295EF74FE7F6@oracle.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 11 Apr 2024 10:52:13 +0000
Miguel Luis <miguel.luis@oracle.com> wrote:

> > On 10 Apr 2024, at 19:44, Jonathan Cameron <jonathan.cameron@huawei.com=
> wrote:
> >=20
> > On Wed, 10 Apr 2024 18:29:34 +0000
> > Miguel Luis <miguel.luis@oracle.com> wrote:
> >  =20
> >>> On 10 Apr 2024, at 13:23, Jonathan Cameron <Jonathan.Cameron@Huawei.c=
om> wrote:
> >>>=20
> >>> On Tue,  9 Apr 2024 15:05:32 +0000
> >>> Miguel Luis <miguel.luis@oracle.com> wrote:
> >>>  =20
> >>>> mapping and unmaping a cpu at the stage of extra cpu enumeration is
> >>>> architecture specific which depends on CONFIG_ACPI_HOTPLUG_CPU so le=
t's
> >>>> isolate that functionality from architecture independent one.   =20
> >>>=20
> >>> Should we consider renaming acpi_map_cpu() to arch_acpi_map_cpu()
> >>> to make the arch specific nature of that call more obvious?   =20
> >>=20
> >> Not sure about the pattern to use here but that seems fine to me. Curr=
ent usage
> >> is architectures export acpi_map_cpu from the acpi interface and do th=
eir
> >> thing.
> >>=20
> >> Question is what to do when there=E2=80=99s a use-case which dismisses=
 acpi_map_cpu and
> >> it gets called on the code path? =20
> >=20
> > I'm not sure what you mean by dismisses?
> >  =20
>=20
> I mean when acpi_map_cpu is not needed.
>=20
> > Is missing perhaps? =20
>=20
> Yes.
>=20
> >  If that is what you mean, I think it's a mistake to allow
> > that code to be called from a path that isn't dependent on
> > CONFIG_ACPI_HOTPLUG_CPU.
> > It makes no sense to do so and stubbing it out to give
> > the impression that the calling it does make sense (when looking at the=
 caller)
> > is misleading. =20
>=20
> OK, that would be what not to do.
>=20
> acpi_processor_enumerate_extra could deal with make_present and make_enab=
led while
> a stub would still be needed for make_present since it depends on
> CONFIG_ACPI_HOTPLUG_CPU?

Sure, you could make it do that with a bunch of checks on the
config being enabled, but currently I don't see the overlap in
shared code as being sufficient for that to make sense.

The discussion before was assuming that things like the acpi_map_cpu
calls might do stuff that is wanted in the make_enabled() case.

Given they don't do anything that we want there I don't see sharing
the code as useful.

I am however in favor of renaming those hotplug only calls to something
more meaningful so no one 'thinks' they may be relevant in the
enabling only case!

Jonathan

p.s. I'm smashing the outputs of the thread with Rafael into a coherent
patch set at the moment, perhaps seeing that will make it clearer what
is going on.  I got distracted by fixing numa node handling this morning
but that's now pushed out for a follow on series.


>=20
> Miguel
>=20
> >=20
> > Jonathan
> >=20
> >  =20
> >>=20
> >> 1) export it and do nothing - it would be creating unnecessary depende=
ncy.
> >>=20
> >> 2) evaluate whether calling it is exclusive to the CPU HP path and kee=
p it wrapped
> >> into CONFIG_ACPI_HOTPLUG_CPU.
> >>=20
> >> Option (2) is the current approach on this RFC. IIUC acpi_map_cpu is s=
olely
> >> used for CPU HP and the same applies to acpi_unmap_cpu.
> >>  =20
> >>> I think that has caused more confusion in the discussion than
> >>> whether it is hotplug specific or not.   =20
> >>=20
> >> Indeed. Within the CPU HP path there are these arch specific intricaci=
es.
> >>  =20
> >>>=20
> >>> As mentioned in patch 2, fairly sure this needs to go before that
> >>> patch.   =20
> >>=20
> >> 2 and 3 depend on each to be self-contained as CPU HP wouldn=E2=80=99t=
 work without late
> >> CPU initialisation I think.
> >>=20
> >> Miguel
> >>  =20
> >>>=20
> >>> Jonathan
> >>>  =20
> >>>>=20
> >>>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> >>>> ---
> >>>> drivers/acpi/acpi_processor.c | 17 +++++++++++++++--
> >>>> 1 file changed, 15 insertions(+), 2 deletions(-)
> >>>>=20
> >>>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_proce=
ssor.c
> >>>> index 9ea58b61d741..c6e2f64a056b 100644
> >>>> --- a/drivers/acpi/acpi_processor.c
> >>>> +++ b/drivers/acpi/acpi_processor.c
> >>>> @@ -194,8 +194,21 @@ static void acpi_processor_hotplug_delay_init(s=
truct acpi_processor *pr)
> >>>> pr_info("CPU%d has been hot-added\n", pr->id);
> >>>> pr->flags.need_hotplug_init =3D 1;
> >>>> }
> >>>> +static int acpi_processor_hotplug_map_cpu(struct acpi_processor *pr)
> >>>> +{
> >>>> + return acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->id);
> >>>> +}
> >>>> +static void acpi_processor_hotplug_unmap_cpu(struct acpi_processor =
*pr)
> >>>> +{
> >>>> + acpi_unmap_cpu(pr->id);
> >>>> +}
> >>>> #else
> >>>> static void acpi_processor_hotplug_delay_init(struct acpi_processor =
*pr) {}
> >>>> +static int acpi_processor_hotplug_map_cpu(struct acpi_processor *pr)
> >>>> +{
> >>>> + return 0;
> >>>> +}
> >>>> +static void acpi_processor_hotplug_unmap_cpu(struct acpi_processor =
*pr) {}
> >>>> #endif /* CONFIG_ACPI_HOTPLUG_CPU */
> >>>>=20
> >>>> /* Enumerate extra CPUs */
> >>>> @@ -215,13 +228,13 @@ static int acpi_processor_enumerate_extra(stru=
ct acpi_processor *pr)
> >>>> cpu_maps_update_begin();
> >>>> cpus_write_lock();
> >>>>=20
> >>>> - ret =3D acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->id=
);
> >>>> + ret =3D acpi_processor_hotplug_map_cpu(pr);
> >>>> if (ret)
> >>>> goto out;
> >>>>=20
> >>>> ret =3D arch_register_cpu(pr->id);
> >>>> if (ret) {
> >>>> - acpi_unmap_cpu(pr->id);
> >>>> + acpi_processor_hotplug_unmap_cpu(pr);
> >>>> goto out;
> >>>> }
> >>>>  =20
> >>>  =20
> >>  =20
> >  =20
>=20


