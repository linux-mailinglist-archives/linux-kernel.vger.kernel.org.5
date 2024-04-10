Return-Path: <linux-kernel+bounces-139270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B178A00C8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EB12834BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C25A18133A;
	Wed, 10 Apr 2024 19:44:21 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FA828FD;
	Wed, 10 Apr 2024 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778261; cv=none; b=E35909tQr3VDE50px4fSekRuI71TRX2GB+3TNHJmJcVnoOfuTcMdJoE6095/7DX5t5KocxMP1WrB6d9IpNaqLF/UF3CqGqphqjJZ+OLXzeko/JamXZwWBdZW8Aj3imgvIsZR5u/Ix+gKKjZCgUKPgLggLf3YFUT1aRkxAx+zNsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778261; c=relaxed/simple;
	bh=bvn3HeBV5B1H5EW3+9oYTS8376zM5l0GlHFhqMk/U4U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ua1abeVAhShbzCV8S6lIlcnVij6ineXvC69VaN2h6ttItGRekMCaTup9YA/6LiQid4SNIeFBiPedCpRta7xu14i2Jjgz5BPhp10aHDvFuzjbrGxgkQD8xtt/KRUyxtN0bH2wFazqomHd2SziInp2ITaIcZEoUOdZADu6SMXnUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VFCnr464Qz6K9Pl;
	Thu, 11 Apr 2024 03:39:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 53E9C1402C7;
	Thu, 11 Apr 2024 03:44:16 +0800 (CST)
Received: from localhost (10.48.150.216) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 20:44:15 +0100
Date: Wed, 10 Apr 2024 20:44:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Miguel Luis <miguel.luis@oracle.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Subject: Re: [RFC PATCH 3/4] ACPI: processor: refactor
 acpi_processor_get_info: isolate acpi_{map|unmap}_cpu under
 CONFIG_ACPI_HOTPLUG_CPU
Message-ID: <20240410204415.00005597@Huawei.com>
In-Reply-To: <AC422669-2869-4C05-B8CD-4C94BDE24012@oracle.com>
References: <20240409150536.9933-1-miguel.luis@oracle.com>
	<20240409150536.9933-4-miguel.luis@oracle.com>
	<20240410142359.00003dea@Huawei.com>
	<AC422669-2869-4C05-B8CD-4C94BDE24012@oracle.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 10 Apr 2024 18:29:34 +0000
Miguel Luis <miguel.luis@oracle.com> wrote:

> > On 10 Apr 2024, at 13:23, Jonathan Cameron <Jonathan.Cameron@Huawei.com=
> wrote:
> >=20
> > On Tue,  9 Apr 2024 15:05:32 +0000
> > Miguel Luis <miguel.luis@oracle.com> wrote:
> >  =20
> >> mapping and unmaping a cpu at the stage of extra cpu enumeration is
> >> architecture specific which depends on CONFIG_ACPI_HOTPLUG_CPU so let's
> >> isolate that functionality from architecture independent one. =20
> >=20
> > Should we consider renaming acpi_map_cpu() to arch_acpi_map_cpu()
> > to make the arch specific nature of that call more obvious? =20
>=20
> Not sure about the pattern to use here but that seems fine to me. Current=
 usage
> is architectures export acpi_map_cpu from the acpi interface and do their
> thing.
>=20
> Question is what to do when there=E2=80=99s a use-case which dismisses ac=
pi_map_cpu and
> it gets called on the code path?

I'm not sure what you mean by dismisses?

Is missing perhaps?  If that is what you mean, I think it's a mistake to al=
low
that code to be called from a path that isn't dependent on
CONFIG_ACPI_HOTPLUG_CPU. It makes no sense to do so and stubbing it out to =
give
the impression that the calling it does make sense (when looking at the cal=
ler)
is misleading.

Jonathan


>=20
> 1) export it and do nothing - it would be creating unnecessary dependency.
>=20
> 2) evaluate whether calling it is exclusive to the CPU HP path and keep i=
t wrapped
> into CONFIG_ACPI_HOTPLUG_CPU.
>=20
> Option (2) is the current approach on this RFC. IIUC acpi_map_cpu is sole=
ly
> used for CPU HP and the same applies to acpi_unmap_cpu.
>=20
> > I think that has caused more confusion in the discussion than
> > whether it is hotplug specific or not. =20
>=20
> Indeed. Within the CPU HP path there are these arch specific intricacies.
>=20
> >=20
> > As mentioned in patch 2, fairly sure this needs to go before that
> > patch. =20
>=20
> 2 and 3 depend on each to be self-contained as CPU HP wouldn=E2=80=99t wo=
rk without late
> CPU initialisation I think.
>=20
> Miguel
>=20
> >=20
> > Jonathan
> >  =20
> >>=20
> >> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> >> ---
> >> drivers/acpi/acpi_processor.c | 17 +++++++++++++++--
> >> 1 file changed, 15 insertions(+), 2 deletions(-)
> >>=20
> >> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_process=
or.c
> >> index 9ea58b61d741..c6e2f64a056b 100644
> >> --- a/drivers/acpi/acpi_processor.c
> >> +++ b/drivers/acpi/acpi_processor.c
> >> @@ -194,8 +194,21 @@ static void acpi_processor_hotplug_delay_init(str=
uct acpi_processor *pr)
> >> pr_info("CPU%d has been hot-added\n", pr->id);
> >> pr->flags.need_hotplug_init =3D 1;
> >> }
> >> +static int acpi_processor_hotplug_map_cpu(struct acpi_processor *pr)
> >> +{
> >> + return acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->id);
> >> +}
> >> +static void acpi_processor_hotplug_unmap_cpu(struct acpi_processor *p=
r)
> >> +{
> >> + acpi_unmap_cpu(pr->id);
> >> +}
> >> #else
> >> static void acpi_processor_hotplug_delay_init(struct acpi_processor *p=
r) {}
> >> +static int acpi_processor_hotplug_map_cpu(struct acpi_processor *pr)
> >> +{
> >> + return 0;
> >> +}
> >> +static void acpi_processor_hotplug_unmap_cpu(struct acpi_processor *p=
r) {}
> >> #endif /* CONFIG_ACPI_HOTPLUG_CPU */
> >>=20
> >> /* Enumerate extra CPUs */
> >> @@ -215,13 +228,13 @@ static int acpi_processor_enumerate_extra(struct=
 acpi_processor *pr)
> >> cpu_maps_update_begin();
> >> cpus_write_lock();
> >>=20
> >> - ret =3D acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->id);
> >> + ret =3D acpi_processor_hotplug_map_cpu(pr);
> >> if (ret)
> >> goto out;
> >>=20
> >> ret =3D arch_register_cpu(pr->id);
> >> if (ret) {
> >> - acpi_unmap_cpu(pr->id);
> >> + acpi_processor_hotplug_unmap_cpu(pr);
> >> goto out;
> >> }
> >>  =20
> >  =20
>=20


