Return-Path: <linux-kernel+bounces-15604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F945822EBB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29316284D34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAD51A59F;
	Wed,  3 Jan 2024 13:38:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7DF1A59D;
	Wed,  3 Jan 2024 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-594cabe74f8so370838eaf.0;
        Wed, 03 Jan 2024 05:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704289118; x=1704893918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAn2nW/5MaBJuG//Cc3icnX/0rkkS5pmAQ07kArKsk8=;
        b=HQXK+h5zz1hJY6CYKiWJi7KaBUsa4SbZ49YjuHqGaE7g9HTssL7yxc7ALmvkGgC5SO
         InkRQgV5nIGtqyNwo8O3/ACOxUMXp5OuXOJSotXFh90s5/yRm3cBsecvKbIMFtjfKTf3
         +gQuLBfX6qK86FcFRaiC96EJDbKxLAILoUNobjEmd5NI+CvKHN411ccWOpLiiWcfW+t5
         s7Azi02GSDNhkSuxIQY8IfgokSkmkMl1pOPaOJLeH5R7V7PSMcE4oa62/8Nc8JsVQKyO
         nqCVphZGP4MOJmyEhXBw73cFnGLCJZ5kkZTgVIWIvgpCt69flrw/tGrcSwbYpim7F5bh
         NFZw==
X-Gm-Message-State: AOJu0YzRzxQdbTIv10cROgu6z9l5Kx+88NLDN/QhZHdja9BjL4fkz8rz
	hbIQwEASiaVMwG4iznVbJ2JM3t8NXk8wdLfBn30=
X-Google-Smtp-Source: AGHT+IH8thOEK2HNeOFjVdgy3io5k3YqU5+G5eTWfnS51H5767RC7XWAZu8POv3Q0Sj0t6fk0tm/tNjOp9NmZUBBiac=
X-Received: by 2002:a4a:e096:0:b0:595:6028:d8cb with SMTP id
 w22-20020a4ae096000000b005956028d8cbmr7273908oos.0.1704289117907; Wed, 03 Jan
 2024 05:38:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103041459.11113-1-ricardo.neri-calderon@linux.intel.com>
 <20240103041459.11113-5-ricardo.neri-calderon@linux.intel.com> <CAJZ5v0jSERoeMki9ZvWtTqiZidETeo1Xm_Qb0Oo2qRG0PMrSJQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jSERoeMki9ZvWtTqiZidETeo1Xm_Qb0Oo2qRG0PMrSJQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jan 2024 14:38:26 +0100
Message-ID: <CAJZ5v0inNopOHMJ85pjHNLXi0kRuJaLLA2aF=fZF3jWTbC7r=g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] thermal: intel: hfi: Add a suspend notifier
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, 
	Len Brown <len.brown@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Zhao Liu <zhao1.liu@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 2:34=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> The subject should say "add a PM notifier" to indicate that
> hibernation is covered too.
>
> On Wed, Jan 3, 2024 at 5:13=E2=80=AFAM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > The kernel gives the HFI hardware a memory region that the latter uses =
to
> > provide updates to the HFI table. The kernel allocates this memory regi=
on
> > at boot. It remains constant throughout runtime time.
> >
> > When resuming from suspend or hibernation, the restore kernel allocates=
 a
>
> The restore kernel is only used during resume from hibernation, so
> this particular problem is hibernation-specific.
>
> It is possible, at least in principle, that the address of the HFI
> table is "lost" by the processor during resume from "deep" suspend
> (ACPI S3), in which case it may not survive the firmware-driven part
> of the suspend-resume cycle.  It is thus prudent to disable HFI on
> suspend and re-enable it on resume for the boot CPU (under the
> assumption that the other CPUs will be taken care of by CPU offline),
> but for a somewhat different reason than in the hibernation case.
>
> > second memory buffer and reprograms the HFI hardware with the new locat=
ion
> > as part of a normal boot. The location of the second memory buffer may
> > differ from the one allocated by the image kernel. Subsequently, when t=
he
> > restore kernel transfers control to the image kernel, the second buffer
> > becomes invalid, potentially leading to memory corruption if the hardwa=
re
> > writes to it (hardware continues using the buffer from the restore kern=
el).
> >
> > Add a suspend notifier to disable all HFI instances before jumping to t=
he
> > image kernel and enable them once the image kernel has been restored. U=
se
> > the memory buffer that the image kernel allocated.
> >
> > For non-boot CPUs, rely on the CPU hotplug callbacks as CPUs are disabl=
ed
> > and enabled during suspend and resume, respectively.
> >
> > The CPU hotplug callbacks do not cover the boot CPU. Handle the HFI
> > instance of the boot CPU from the suspend notifier callback.
> >
> > Cc: Chen Yu <yu.c.chen@intel.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Zhao Liu <zhao1.liu@linux.intel.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: stable@vger.kernel.org    # 6.1
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > --
> > Changes since v1:
> >  * Moved registration of the suspend notifier towards the end of
> >    intel_hfi_init(). (Stan)
> >  * Renamed hfi_do_pm_[enable|disable]() to hfi_do_[enable|disable](). S=
tan
> >    will use these functions outside the suspend notifier. (Stan)
> >  * Added locking to calls to hfi_[enable|disable]() from the suspend
> >    notifier. (Rafael)
> > ---
> >  drivers/thermal/intel/intel_hfi.c | 62 +++++++++++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >
> > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/=
intel_hfi.c
> > index 22445403b520..8d6e4f8dc67a 100644
> > --- a/drivers/thermal/intel/intel_hfi.c
> > +++ b/drivers/thermal/intel/intel_hfi.c
> > @@ -30,11 +30,13 @@
> >  #include <linux/kernel.h>
> >  #include <linux/math.h>
> >  #include <linux/mutex.h>
> > +#include <linux/notifier.h>
> >  #include <linux/percpu-defs.h>
> >  #include <linux/printk.h>
> >  #include <linux/processor.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/suspend.h>
> >  #include <linux/string.h>
> >  #include <linux/topology.h>
> >  #include <linux/workqueue.h>
> > @@ -571,6 +573,60 @@ static __init int hfi_parse_features(void)
> >         return 0;
> >  }
> >
> > +static void hfi_do_enable(void *info)
> > +{
> > +       struct hfi_instance *hfi_instance =3D info;
> > +
> > +       hfi_set_hw_table(hfi_instance);
> > +       hfi_enable();
> > +}
> > +
> > +static void hfi_do_disable(void *info)
> > +{
> > +       hfi_disable();
> > +}
> > +
> > +static int hfi_pm_notify(struct notifier_block *nb,
> > +                        unsigned long mode, void *unused)
> > +{
> > +       struct hfi_cpu_info *info =3D &per_cpu(hfi_cpu_info, 0);
> > +       struct hfi_instance *hfi =3D info->hfi_instance;
> > +       int ret =3D 0;
> > +
> > +       /* HFI may not be in use. */
> > +       if (!hfi)
> > +               return ret;
> > +
> > +       mutex_lock(&hfi_instance_lock);
> > +       /*
> > +        * Only handle the HFI instance of the package of the boot CPU.=
 The
> > +        * instances of other packages are handled in the CPU hotplug c=
allbacks.
> > +        */
> > +       switch (mode) {
> > +       case PM_HIBERNATION_PREPARE:
> > +       case PM_SUSPEND_PREPARE:
> > +       case PM_RESTORE_PREPARE:
> > +               ret =3D smp_call_function_single(0, hfi_do_disable, NUL=
L, true);
> > +               break;
> > +
> > +       case PM_POST_RESTORE:
> > +       case PM_POST_HIBERNATION:
> > +       case PM_POST_SUSPEND:
> > +               ret =3D smp_call_function_single(0, hfi_do_enable, hfi,=
 true);
> > +               break;
>
> Because this handles the boot CPU only, one has to wonder if it should
> be a syscore op rather than a PM notifier.
>
> It does not sleep AFAICS, so it can run in that context, and it is
> guaranteed to run on the boot CPU then, so it is not necessary to
> force that.  Moreover, syscore ops are guaranteed to be
> non-concurrent, so locking is not needed.
>
> In addition, disabling HFI from a PM notifier is generally observable
> by user space, because PM notifiers run before user space is frozen,
> but doing it from a syscore op wouldn't be.

One more thing: PM notifiers run on all variants of system suspend and
resume, including suspend-to-idle in which case HFI need not be
disabled/enabled IIUC and syscore ops only run in hibernation and
"deep" suspend cycles, so they cover the cases in which the special
handling is really needed and don't add useless overhead otherwise.

