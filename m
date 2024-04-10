Return-Path: <linux-kernel+bounces-139269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF48D8A00C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3781C23749
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23870181337;
	Wed, 10 Apr 2024 19:40:11 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9ED15DBB7;
	Wed, 10 Apr 2024 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778010; cv=none; b=sTLMyJv2SM/qzZWUs3TvA92Q9yQ2y5mkkomyQjr+VpjMoIhd27CTuJQSHCGL/9Kz/OXcES1ZfFwUAebQazK3ILwGX1WicdsWpfS8WPxqNHJ7UYcDRMoq6Mq5iSO/rMt1Rhl9s964LNbovk0haZe6c2eZI3f7/GZABk87fYf5xsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778010; c=relaxed/simple;
	bh=zlC8Rjkw8j7sTtblL3UUVoXVx3v7nrKzUOV52YTEhF4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzU+2OZTubUkTXRxHC1Agbh4hYAa0t76GuUytQlf7vULO5xHVJLx8SZ8FRqjLw0Mztxu9bIsPClDe21AzQX1vp8hf1XPnRYp9MLVAPDPyEARVlFvXMFEH3ZOXjh5DbYL87JiCE99coFXXFoR7ttaaet71vk6BNvl4ngrZ1pfOTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VFCmd4h01z67Zdq;
	Thu, 11 Apr 2024 03:38:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 488F51408F9;
	Thu, 11 Apr 2024 03:40:04 +0800 (CST)
Received: from localhost (10.48.150.216) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 20:40:03 +0100
Date: Wed, 10 Apr 2024 20:40:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Miguel Luis <miguel.luis@oracle.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Subject: Re: [RFC PATCH 2/4] ACPI: processor: refactor
 acpi_processor_get_info: isolate cpu hotpug init delay
Message-ID: <20240410204002.00000ce9@Huawei.com>
In-Reply-To: <BEF140E0-C419-4A27-B2B2-6EB24F48B3C1@oracle.com>
References: <20240409150536.9933-1-miguel.luis@oracle.com>
	<20240409150536.9933-3-miguel.luis@oracle.com>
	<20240410142031.00007036@Huawei.com>
	<BEF140E0-C419-4A27-B2B2-6EB24F48B3C1@oracle.com>
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

On Wed, 10 Apr 2024 17:20:01 +0000
Miguel Luis <miguel.luis@oracle.com> wrote:

> > On 10 Apr 2024, at 13:20, Jonathan Cameron <Jonathan.Cameron@Huawei.com=
> wrote:
> >=20
> > On Tue,  9 Apr 2024 15:05:31 +0000
> > Miguel Luis <miguel.luis@oracle.com> wrote:
> >  =20
> >> Delaying a hotplugged CPU initialization depends on
> >> CONFIG_ACPI_HOTPLUG_CPU. Isolate that.
> >>=20
> >> Signed-off-by: Miguel Luis <miguel.luis@oracle.com> =20
> >=20
> > Again, needs more explanation. =20
>=20
> In agreement.
>=20
> > Post the full set with the v4 vCPU
> > HP patches on top of this so we can see how it is used.
> >  =20
>=20
> I=E2=80=99ll get a link to a repo for the next version besides would like=
 primarily to
> establish acpi_processor_{get_info|remove} first since these changes
> would need to live with and without vCPU HP.

Great.

>=20
> > I guess the aim here is to share the bulk of this code between
> > the present and enabled paths? Whilst I think they should look
> > more similar actual code sharing seems like a bad idea for a
> > couple of reasons. =20
>=20
> That would be my understanding from comments on v4. Both present and
> enabled paths do have common procedures up to certain point. IIUC, from .1
> and .2 from comments [1] and [2] while .3 would be architecture specific =
code.
>=20
> [1]: https://lore.kernel.org/linux-arm-kernel/CAJZ5v0iiJpUWq5GMSnKFWQTzn_=
bdwoQz9m=3DhDaXNg4Lj_ePF4g@mail.gmail.com/
> [2]: https://lore.kernel.org/linux-arm-kernel/20240322185327.00002416@Hua=
wei.com/

3 is not just architecture specific code, it's architecture and action spec=
ific.
i.e. What is done in there should not happen in the present path.

=46rom what is in [2] I became much less convinced much code should be shared=
.
Lightly editing where that thread went today, there is some shared code in
the make_present / make_enabled path, but not that much.
As per that discussion, cpu_maps_update* is harmless, but also pointless
and potentially misleading in the enable case.

static int acpi_processor_make_present(struct acpi_processor *pr)
{
        unsigned long long sta;
        acpi_status status;
        int ret;

        if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_CPU)) {
                pr_err_once("Changing CPU present bit is not supported\n");
                return -ENODEV;
        }

// The _STA check here is needed still or we need to push it into
// arch_register_cpu() on x86 similarly to proposal on arm64.

	status =3D acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
        if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT))
                return -ENODEV;

        if (invalid_phys_cpuid(pr->phys_id))
                return -ENODEV;
        cpu_maps_update_begin();
        cpus_write_lock();

        ret =3D acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->id);
        if (ret)
                goto out;

        ret =3D arch_register_cpu(pr->id);
        if (ret) {
                acpi_unmap_cpu(pr->id);
                goto out;
        }

        /* =20
	* CPU got hot-added, but cpu_data is not initialized yet.  Set a flag
	* to delay cpu_idle/throttling initialization and do it when the CPU
	* gets online for the first time.
	*/
        pr_info("CPU%d has been hot-added\n", pr->id);
        pr->flags.need_hotplug_init =3D 1;

out:
        cpus_write_unlock();
        cpu_maps_update_done();
        return ret;
}

static int acpi_processor_make_enabled(struct acpi_processor *pr)
{
        unsigned long long sta;
        acpi_status status;
        bool present, enabled;
        int ret;

        if (invalid_phys_cpuid(pr->phys_id))
                return -ENODEV;

        cpus_write_lock();
        ret =3D arch_register_cpu(pr->id);
        cpus_write_unlock();

        return ret;
}

>=20
> >=20
> > Imagine an arch that supports both present and enabled setting (so vCPU=
 HP and
> > CPU HP) on that this function will be defined but will not be the right
> > thing to do for vCPU HP.  Note that in theory this is true of x86 but n=
o one
> > has added support for the 'online capable bit' yet. =20
>=20
> =E2=80=A6 I agree with the above. It reinforces refactoring acpi_processo=
r_get_info
> so it clearly decouples present and enabled paths.
>=20
> >=20
> > The impression for the _present() path will be that acpi_process_hotplu=
g_delay_init()
> > should be called, and that's not true.  That should be obvious in the c=
ode
> > not hidden behind a stubbed out function. =20
>=20
> Ack. Need to check how we=E2=80=99re differentiating both paths.

I haven't looked as much at the remove path recently but for the enable path
the code that should run in the enable path is much less than in the presen=
t path.

>=20
> >=20
> > Finally, you've pulled acpi_process_enumearte_extra out of the CONFIG_A=
CPI_HOTPLUG_CPU
> > block and I'm fairly sure it still has acpi_map_cpu() calls which aren't
> > defined yet for now ACPI_HOTPLUG_CPU configs. =20
>=20
> Yep, it still has. Unless you squash the next patch into this one, which I
> didn=E2=80=99t so one could see these changes progressively rather than
> self-contained.
>=20
I think that makes it non bisectable, so you can't do this.  Either don't m=
ove
that code until after the next patch, or squash the 2 together.

Less important in an RFC though,

Jonathan


> Miguel
>=20
> >=20
> > Jonathan
> >  =20
> >> ---
> >> drivers/acpi/acpi_processor.c | 34 ++++++++++++++++++----------------
> >> 1 file changed, 18 insertions(+), 16 deletions(-)
> >>=20
> >> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_process=
or.c
> >> index 37e8b69113dd..9ea58b61d741 100644
> >> --- a/drivers/acpi/acpi_processor.c
> >> +++ b/drivers/acpi/acpi_processor.c
> >> @@ -184,7 +184,22 @@ static void __init acpi_pcc_cpufreq_init(void) {}
> >>=20
> >> /* Initialization */
> >> #ifdef CONFIG_ACPI_HOTPLUG_CPU
> >> -static int acpi_processor_hotadd_init(struct acpi_processor *pr)
> >> +static void acpi_processor_hotplug_delay_init(struct acpi_processor *=
pr)
> >> +{
> >> + /*
> >> + * CPU got hot-added, but cpu_data is not initialized yet.  Set a flag
> >> + * to delay cpu_idle/throttling initialization and do it when the CPU
> >> + * gets online for the first time.
> >> + */
> >> + pr_info("CPU%d has been hot-added\n", pr->id);
> >> + pr->flags.need_hotplug_init =3D 1;
> >> +}
> >> +#else
> >> +static void acpi_processor_hotplug_delay_init(struct acpi_processor *=
pr) {}
> >> +#endif /* CONFIG_ACPI_HOTPLUG_CPU */
> >> +
> >> +/* Enumerate extra CPUs */
> >> +static int acpi_processor_enumerate_extra(struct acpi_processor *pr)
> >> {
> >> unsigned long long sta;
> >> acpi_status status;
> >> @@ -210,25 +225,12 @@ static int acpi_processor_hotadd_init(struct acp=
i_processor *pr)
> >> goto out;
> >> }
> >>=20
> >> - /*
> >> - * CPU got hot-added, but cpu_data is not initialized yet.  Set a flag
> >> - * to delay cpu_idle/throttling initialization and do it when the CPU
> >> - * gets online for the first time.
> >> - */
> >> - pr_info("CPU%d has been hot-added\n", pr->id);
> >> - pr->flags.need_hotplug_init =3D 1;
> >> -
> >> + acpi_processor_hotplug_delay_init(pr);
> >> out:
> >> cpus_write_unlock();
> >> cpu_maps_update_done();
> >> return ret;
> >> }
> >> -#else
> >> -static inline int acpi_processor_hotadd_init(struct acpi_processor *p=
r)
> >> -{
> >> - return -ENODEV;
> >> -}
> >> -#endif /* CONFIG_ACPI_HOTPLUG_CPU */
> >>=20
> >> static int acpi_evaluate_processor(struct acpi_device *device,
> >>   struct acpi_processor *pr,
> >> @@ -347,7 +349,7 @@ static int acpi_processor_get_info(struct acpi_dev=
ice *device)
> >> *  because cpuid <-> apicid mapping is persistent now.
> >> */
> >> if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> >> - int ret =3D acpi_processor_hotadd_init(pr);
> >> + int ret =3D acpi_processor_enumerate_extra(pr);
> >>=20
> >> if (ret)
> >> return ret; =20
> >  =20
>=20


