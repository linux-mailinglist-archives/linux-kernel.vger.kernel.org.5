Return-Path: <linux-kernel+bounces-43448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A085F8413FF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4121F2709B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9FC7602C;
	Mon, 29 Jan 2024 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AuBxLeZ8"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E4848790
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558661; cv=none; b=FrOVFhZWa40zpjRIjpVX3zcqX9JyFT6DsPJ1zHpStaz/OCh3DVGcFCTkp1m/PkairG9v/dRqnINeJMNCtdYYGlVJQEl6XC6+2kex3Df0aLlZizt/oHH75ooQ9tW+ob12RomPNWTOORk/sg50GuF/xAv9PybG/wVqSjd7jgTrUZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558661; c=relaxed/simple;
	bh=fd/qjfLx6iU/pSx9JHZgN/tL5A0heNVFIf8b81miVuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiwOz90+dS1bjNIE7fgR1LPHE4J14V5uUQCepjfZ/F4VqpgVD7wo8SJ3eZY+JDiuGlIaNvySqhJkIBSqIVx5EdhGL+NPA7eASxyX/Wi7nf1fie76ekwAEgFHLKgyoxf7fR5PAvtuMJEfuG8IMmiisGyqNge4ARyhzs01qs3+Sqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AuBxLeZ8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso2990a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706558656; x=1707163456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaYgJLuIoNwNaSuSpAOFqvEvpx5dM8Qf5vGWYvclTtA=;
        b=AuBxLeZ8juqJk9GEIKi2701U839Fj27OIBlplF4xjJXTguRaTDvw8AxgnfmEhkZm4K
         4Q2FsxuSoelfq14Hx9z4c8F3ej2+v7JHxa6Cqi9oZ74ypKE0WloBFBHctkWOQzVHxsI0
         rxJQLHlNU75r4NocEjXLPTQXZgys6lFHonvQcivrGRcCeExS1VWppNR0lXi/jMPliBjm
         xwVBUtQzudDIUdwPuRj45JHANu+4cprLTpj9OJdGctOWXsp0C+FhXhLbEHPNcZmBIERp
         TA3s6uwZekLeSHINQELUid3zsBVdSqTXzeJF0PcJGuOYGcSa9nTMeZyBIDAjUIJ9x5eu
         s2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706558656; x=1707163456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaYgJLuIoNwNaSuSpAOFqvEvpx5dM8Qf5vGWYvclTtA=;
        b=tBjbZO9PBATg7PmgZzOcvvnIj9oWEcAf8LoiOYd6/HETDr0pCWLmfbtNbyzHeA/PLR
         ilUMkdBSZLigL110QMb8J2xLCxzzA7k2+GuVK1Zu2xc8BLAxYl+THSEHWm1ZWTy3PiaH
         SutEWdipuTaIYwJFCH6JTeD9c04YURQ7/gtEe1vdIHbT8o8io3XZQ7+PSQCzRWVPVfYF
         5gkiSZsFp90iKXLSPJGfy3DC53bZ/kVv/WRspp07W/KXtWpmeAQ+VdDFL8NbtsIM6bUw
         +KZV6bBLe342ZDsbISGXArXKk/dzv0rzbkRPi8k7LUsoYpem2Iv7JtMpSdumGNxrfB0d
         ruQQ==
X-Gm-Message-State: AOJu0YzoOqYWXjtfySEdBfxOJelsNCnKCOk8IQx8dCUEdpFdtlHg+H5d
	KgBOSDbnKdgqptW6vcoFE93gJMVUx5C0bwJpQ0tj96Lm/lVOCEBpQ6UrraTRyq57TwEdclVrmzy
	ww44gYcN9lCF5L4rieJp5yDkANCHmajA383m2
X-Google-Smtp-Source: AGHT+IGAvq8YqlVp/Z/ft50UQ+sHhLFy67Tmn+dDEiNAGaNkXGnkad1+cGZR3c/145T7/UjmALFK0UYmYX4nA3/aVcI=
X-Received: by 2002:a05:6402:2288:b0:55f:ecf:11d6 with SMTP id
 cw8-20020a056402228800b0055f0ecf11d6mr30536edb.4.1706558656214; Mon, 29 Jan
 2024 12:04:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706307364.git.thomas.lendacky@amd.com> <10637f104d1ed7f21e281a4890f2c549d1e85985.1706307364.git.thomas.lendacky@amd.com>
 <CAAH4kHbjZY5J=EQsyXxvthTbpge-W9PTJc4WD-O2JaWZyZFPgA@mail.gmail.com> <3fca61f2-6fe0-4431-818e-9c7b96c6a391@amd.com>
In-Reply-To: <3fca61f2-6fe0-4431-818e-9c7b96c6a391@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Mon, 29 Jan 2024 12:04:04 -0800
Message-ID: <CAAH4kHaw7Cpq713sPW2-+TTzmy41O8qHRKYsG2MO06vF1eSJaQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] x86/sev: Extend the config-fs attestation support
 for an SVSM
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dan Williams <dan.j.williams@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 7:02=E2=80=AFAM Tom Lendacky <thomas.lendacky@amd.c=
om> wrote:
>
> On 1/26/24 19:27, Dionna Amalie Glaze wrote:
> > On Fri, Jan 26, 2024 at 2:19=E2=80=AFPM Tom Lendacky <thomas.lendacky@a=
md.com> wrote:
> >>
> >> When an SVSM is present, the guest can also request attestation report=
s
> >> from the SVSM. These SVSM attestation reports can be used to attest th=
e
> >> SVSM and any services running within the SVSM.
> >>
> >> Extend the config-fs attestation support to allow for an SVSM attestat=
ion
> >> report. This involves creating four (4) new config-fs attributes:
> >>
> >>    - 'svsm' (input)
> >>      This attribute is used to determine whether the attestation reque=
st
> >>      should be sent to the SVSM or to the SEV firmware.
> >
> > This is where I'm torn. If there's an SVSM, it's there to provide
> > paravirtualization for unenlightened guests /or/ it's there to protect
>
> An SVSM is for enlightened guests. A para-visor would be for unenlightene=
d
> guests.
>
> > runtime measurement registers. I don't see there being any particular
> > value in bifurcating the attestation report space by adding this
> > option. If there's an SVSM present, the configfs-tsm report should
> > return the full SVSM attestation only.
>
> I don't necessarily agree with that. The guest should still be able to
> request a traditional attestation report.
>
> Maybe I can remove the SVSM attribute and direct the call based on
> requested VMPL level. If VMPL0 is requested, it goes through the SVSM.
> If VMPL1+ is requested, it goes to the ASP.
>
> That would mean that the privlevel_floor would need to stay at zero.
>
> >
> >>
> >>    - 'service_guid' (input)
> >>      Used for requesting the attestation of a single service within th=
e
> >>      SVSM. A null GUID implies that the SVSM_ATTEST_SERVICES call shou=
ld
> >>      be used to request the attestation report. A non-null GUID implie=
s
> >>      that the SVSM_ATTEST_SINGLE_SERVICE call should be used.
> >>
> >>    - 'service_version' (input)
> >>      Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service versio=
n
> >>      represents a specific service manifest version be used for the
> >>      attestation report.
> >
> > I know that this is specified for the SVSM, but I still don't know
> > what the intended use case is such that we wouldn't simply always
> > return the full service manifest.
> > I can see an argument for an evidence requester not being ready for a
> > new manifest version and wanting the older version until they can
> > bridge the gap. I don't see that as needing configuration from the
> > user space. We can either require new service GUIDs for new versions,
> > require manifest ABIs to be internally versioned to be additive-only
> > to not break verifiers that understand up to manifest byte X, or we
> > allow breaking version changes through control plane configuration
> > that's passed directly to the SVSM.
> >
> > New versions get new GUIDs allows for gradual deprecation at the
> > expense of size. I think that is a reasonable trade-off to keep from
> > making tsm/report vendor-specific.
>
> This was requested and discussed during the SVSM spec review and there
> were no objections raised. See the this thread where this was discussed:
>
> https://lore.kernel.org/linux-coco/09819cb3-1938-fe86-b948-28aaffbe584e@a=
md.com/
>

We also hadn't had the configfs-tsm unification point, so I think it's
worth folding in that discussion.
In terms of querying specific services, would you help me with a
concrete example of where the evidence collector ought to query a
specific version instead of the service enumeration?

> The changes you're requesting would require a new version of the spec
> and updates to the protocol.
>

I think the changes I'm requesting are to just limit the exposure of
the protocol to linux. What specifically about what I wrote requires a
change to the spec? Is it the lack of plural handling of 'its GUID
value' in "Each service will document its GUID value and the format of
its manifest content."?

> >
> >>
> >>    - 'manifestblob' (output)
> >>      Used to return the service manifest associated with the attestati=
on
> >>      report.
> >
> > Given the above, I think we can just append the manifest to the report
> > since the report size is known a priori.
>
> We could have theoretically done the same thing with the auxblob (certs
> data), but that is separate. I prefer the idea of having an individual
> entry per piece of data being returned.

Fair enough, another RO blob seems okay enough.

>
> Thanks,
> Tom
>
> >
> >>
> >> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> >> ---
> >>   Documentation/ABI/testing/configfs-tsm  |  55 ++++++++++
> >>   arch/x86/include/asm/sev.h              |  31 +++++-
> >>   arch/x86/kernel/sev.c                   |  50 +++++++++
> >>   drivers/virt/coco/sev-guest/sev-guest.c | 137 ++++++++++++++++++++++=
++
> >>   drivers/virt/coco/tsm.c                 |  95 +++++++++++++++-
> >>   include/linux/tsm.h                     |  11 ++
> >>   6 files changed, 376 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/AB=
I/testing/configfs-tsm
> >> index dd24202b5ba5..c5423987d323 100644
> >> --- a/Documentation/ABI/testing/configfs-tsm
> >> +++ b/Documentation/ABI/testing/configfs-tsm
> >> @@ -31,6 +31,21 @@ Description:
> >>                  Standardization v2.03 Section 4.1.8.1 MSG_REPORT_REQ.
> >>                  https://www.amd.com/content/dam/amd/en/documents/epyc=
-technical-docs/specifications/56421.pdf
> >>
> >> +What:          /sys/kernel/config/tsm/report/$name/manifestblob
> >> +Date:          January, 2024
> >> +KernelVersion: v6.9
> >> +Contact:       linux-coco@lists.linux.dev
> >> +Description:
> >> +               (RO) Optional supplemental data that a TSM may emit, v=
isibility
> >> +               of this attribute depends on TSM, and may be empty if =
no
> >> +               manifest data is available.
> >> +
> >> +               When @provider is "sev_guest" and the "svsm" attribute=
 is set
> >> +               this file contains the service manifest used for the S=
VSM
> >> +               attestation report from Secure VM Service Module for S=
EV-SNP
> >> +               Guests v1.00 Section 7.
> >> +               https://www.amd.com/content/dam/amd/en/documents/epyc-=
technical-docs/specifications/58019.pdf
> >> +
> >>   What:          /sys/kernel/config/tsm/report/$name/provider
> >>   Date:          September, 2023
> >>   KernelVersion: v6.7
> >> @@ -80,3 +95,43 @@ Contact:     linux-coco@lists.linux.dev
> >>   Description:
> >>                  (RO) Indicates the minimum permissible value that can=
 be written
> >>                  to @privlevel.
> >> +
> >> +What:          /sys/kernel/config/tsm/report/$name/svsm
> >> +Date:          January, 2024
> >> +KernelVersion: v6.9
> >> +Contact:       linux-coco@lists.linux.dev
> >> +Description:
> >> +               (WO) Attribute is visible if a TSM implementation prov=
ider
> >> +               supports the concept of attestation reports for TVMs r=
unning
> >> +               under an SVSM, like SEV-SNP. Specifying any non-zero v=
alue
> >> +               implies that the attestation report should come from t=
he SVSM.
> >> +               Secure VM Service Module for SEV-SNP Guests v1.00 Sect=
ion 7.
> >> +               https://www.amd.com/content/dam/amd/en/documents/epyc-=
technical-docs/specifications/58019.pdf
> >> +
> >> +What:          /sys/kernel/config/tsm/report/$name/service_guid
> >> +Date:          January, 2024
> >> +KernelVersion: v6.9
> >> +Contact:       linux-coco@lists.linux.dev
> >> +Description:
> >> +               (WO) Attribute is visible if a TSM implementation prov=
ider
> >> +               supports the concept of attestation reports for TVMs r=
unning
> >> +               under an SVSM, like SEV-SNP. Specifying a empty or nul=
l GUID
> >> +               (00000000-0000-0000-0000-000000) requests all active s=
ervices
> >> +               within the SVSM be part of the attestation report. Spe=
cifying
> >> +               a non-null GUID requests an attestation report of just=
 the
> >> +               specified service using the manifest form specified by=
 the
> >> +               service_version attribute.
> >> +               Secure VM Service Module for SEV-SNP Guests v1.00 Sect=
ion 7.
> >> +               https://www.amd.com/content/dam/amd/en/documents/epyc-=
technical-docs/specifications/58019.pdf
> >> +
> >> +What:          /sys/kernel/config/tsm/report/$name/service_version
> >> +Date:          January, 2024
> >> +KernelVersion: v6.9
> >> +Contact:       linux-coco@lists.linux.dev
> >> +Description:
> >> +               (WO) Attribute is visible if a TSM implementation prov=
ider
> >> +               supports the concept of attestation reports for TVMs r=
unning
> >> +               under an SVSM, like SEV-SNP. Indicates the service man=
ifest
> >> +               version requested for the attestation report.
> >> +               Secure VM Service Module for SEV-SNP Guests v1.00 Sect=
ion 7.
> >> +               https://www.amd.com/content/dam/amd/en/documents/epyc-=
technical-docs/specifications/58019.pdf
> >> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> >> index b126e50a1358..4cafa92d1d3e 100644
> >> --- a/arch/x86/include/asm/sev.h
> >> +++ b/arch/x86/include/asm/sev.h
> >> @@ -194,6 +194,27 @@ struct svsm_pvalidate_call {
> >>          struct svsm_pvalidate_entry entry[];
> >>   };
> >>
> >> +/*
> >> + * The SVSM Attestation related structures
> >> + */
> >> +struct svsm_location_entry {
> >> +       u64 pa;
> >> +       u32 len;
> >> +       u8 rsvd[4];
> >> +};
> >> +
> >> +struct svsm_attestation_call {
> >> +       struct svsm_location_entry report_buffer;
> >> +       struct svsm_location_entry nonce;
> >> +       struct svsm_location_entry manifest_buffer;
> >> +       struct svsm_location_entry certificates_buffer;
> >> +
> >> +       /* For attesting a single service */
> >> +       u8 service_guid[16];
> >> +       u32 service_version;
> >> +       u8 rsvd[4];
> >> +};
> >> +
> >>   /*
> >>    * SVSM protocol structure
> >>    */
> >> @@ -217,6 +238,10 @@ struct svsm_call {
> >>   #define SVSM_CORE_CREATE_VCPU          2
> >>   #define SVSM_CORE_DELETE_VCPU          3
> >>
> >> +#define SVSM_ATTEST_CALL(x)            ((1ULL << 32) | (x))
> >> +#define SVSM_ATTEST_SERVICES           0
> >> +#define SVSM_ATTEST_SINGLE_SERVICE     1
> >> +
> >>   #ifdef CONFIG_AMD_MEM_ENCRYPT
> >>   extern void __sev_es_ist_enter(struct pt_regs *regs);
> >>   extern void __sev_es_ist_exit(void);
> >> @@ -287,6 +312,7 @@ void snp_set_wakeup_secondary_cpu(void);
> >>   bool snp_init(struct boot_params *bp);
> >>   void __init __noreturn snp_abort(void);
> >>   int snp_issue_guest_request(u64 exit_code, struct snp_req_data *inpu=
t, struct snp_guest_request_ioctl *rio);
> >> +int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attes=
tation_call *input);
> >>   void snp_accept_memory(phys_addr_t start, phys_addr_t end);
> >>   u64 snp_get_unsupported_features(u64 status);
> >>   u64 sev_get_status(void);
> >> @@ -316,7 +342,10 @@ static inline int snp_issue_guest_request(u64 exi=
t_code, struct snp_req_data *in
> >>   {
> >>          return -ENOTTY;
> >>   }
> >> -
> >> +static inline int snp_issue_svsm_attestation_request(u64 call_id, str=
uct svsm_attestation_call *input)
> >> +{
> >> +       return -ENOTTY;
> >> +}
> >>   static inline void snp_accept_memory(phys_addr_t start, phys_addr_t =
end) { }
> >>   static inline u64 snp_get_unsupported_features(u64 status) { return =
0; }
> >>   static inline u64 sev_get_status(void) { return 0; }
> >> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> >> index 849df3aae4e1..83bc5efa8fcf 100644
> >> --- a/arch/x86/kernel/sev.c
> >> +++ b/arch/x86/kernel/sev.c
> >> @@ -2378,6 +2378,56 @@ static int __init init_sev_config(char *str)
> >>   }
> >>   __setup("sev=3D", init_sev_config);
> >>
> >> +static void update_attestation_input(struct svsm_call *call, struct s=
vsm_attestation_call *input)
> >> +{
> >> +       /* If (new) lengths have been returned, propograte them up */
> >> +       if (call->rcx_out !=3D call->rcx)
> >> +               input->manifest_buffer.len =3D call->rcx_out;
> >> +
> >> +       if (call->rdx_out !=3D call->rdx)
> >> +               input->certificates_buffer.len =3D call->rdx_out;
> >> +
> >> +       if (call->r8_out !=3D call->r8)
> >> +               input->report_buffer.len =3D call->r8_out;
> >> +}
> >> +
> >> +int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attes=
tation_call *input)
> >> +{
> >> +       struct svsm_attestation_call *attest_call;
> >> +       struct svsm_call call =3D {};
> >> +       unsigned long flags;
> >> +       u64 attest_call_pa;
> >> +       int ret;
> >> +
> >> +       if (!vmpl)
> >> +               return -EINVAL;
> >> +
> >> +       local_irq_save(flags);
> >> +
> >> +       call.caa =3D __svsm_get_caa();
> >> +
> >> +       attest_call =3D (struct svsm_attestation_call *)call.caa->svsm=
_buffer;
> >> +       attest_call_pa =3D __svsm_get_caa_pa() + offsetof(struct svsm_=
ca, svsm_buffer);
> >> +
> >> +       memcpy(attest_call, input, sizeof(*attest_call));
> >> +
> >> +       /*
> >> +        * Set input registers for the request and set RDX and R8 to k=
nown
> >> +        * values in order to detect length values being returned in t=
hem.
> >> +        */
> >> +       call.rax =3D call_id;
> >> +       call.rcx =3D attest_call_pa;
> >> +       call.rdx =3D -1;
> >> +       call.r8 =3D -1;
> >> +       ret =3D svsm_protocol(&call);
> >> +       update_attestation_input(&call, input);
> >> +
> >> +       local_irq_restore(flags);
> >> +
> >> +       return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(snp_issue_svsm_attestation_request);
> >> +
> >>   int snp_issue_guest_request(u64 exit_code, struct snp_req_data *inpu=
t, struct snp_guest_request_ioctl *rio)
> >>   {
> >>          struct ghcb_state state;
> >> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/co=
co/sev-guest/sev-guest.c
> >> index 1ff897913bf4..3693373c4227 100644
> >> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> >> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> >> @@ -783,6 +783,140 @@ struct snp_msg_cert_entry {
> >>          u32 length;
> >>   };
> >>
> >> +static int sev_svsm_report_new(struct tsm_report *report, void *data)
> >> +{
> >> +       unsigned int report_len, manifest_len, certificates_len;
> >> +       void *report_blob, *manifest_blob, *certificates_blob;
> >> +       struct svsm_attestation_call attest_call =3D {};
> >> +       struct tsm_desc *desc =3D &report->desc;
> >> +       unsigned int size;
> >> +       bool try_again;
> >> +       void *buffer;
> >> +       u64 call_id;
> >> +       int ret;
> >> +
> >> +       /*
> >> +        * Allocate pages for the request:
> >> +        * - Report blob (4K)
> >> +        * - Manifest blob (4K)
> >> +        * - Certificate blob (16K)
> >> +        *
> >> +        * Above addresses must be 4K aligned
> >> +        */
> >> +       report_len =3D SZ_4K;
> >> +       manifest_len =3D SZ_4K;
> >> +       certificates_len =3D SEV_FW_BLOB_MAX_SIZE;
> >> +
> >> +retry:
> >> +       size =3D report_len + manifest_len + certificates_len;
> >> +       buffer =3D alloc_pages_exact(size, __GFP_ZERO);
> >> +       if (!buffer)
> >> +               return -ENOMEM;
> >> +
> >> +       report_blob =3D buffer;
> >> +       attest_call.report_buffer.pa =3D __pa(report_blob);
> >> +       attest_call.report_buffer.len =3D report_len;
> >> +
> >> +       manifest_blob =3D report_blob + report_len;
> >> +       attest_call.manifest_buffer.pa =3D __pa(manifest_blob);
> >> +       attest_call.manifest_buffer.len =3D manifest_len;
> >> +
> >> +       certificates_blob =3D manifest_blob + manifest_len;
> >> +       attest_call.certificates_buffer.pa =3D __pa(certificates_blob)=
;
> >> +       attest_call.certificates_buffer.len =3D certificates_len;
> >> +
> >> +       attest_call.nonce.pa =3D __pa(desc->inblob);
> >> +       attest_call.nonce.len =3D desc->inblob_len;
> >> +
> >> +       if (guid_is_null(&desc->service_guid)) {
> >> +               call_id =3D SVSM_ATTEST_CALL(SVSM_ATTEST_SERVICES);
> >> +       } else {
> >> +               export_guid(attest_call.service_guid, &desc->service_g=
uid);
> >> +               attest_call.service_version =3D desc->service_version;
> >> +
> >> +               call_id =3D SVSM_ATTEST_CALL(SVSM_ATTEST_SINGLE_SERVIC=
E);
> >> +       }
> >> +
> >> +       ret =3D snp_issue_svsm_attestation_request(call_id, &attest_ca=
ll);
> >> +       switch (ret) {
> >> +       case SVSM_SUCCESS:
> >> +               break;
> >> +       case SVSM_ERR_INVALID_PARAMETER:
> >> +               try_again =3D false;
> >> +
> >> +               if (attest_call.report_buffer.len > report_len) {
> >> +                       report_len =3D PAGE_ALIGN(attest_call.report_b=
uffer.len);
> >> +                       try_again =3D true;
> >> +               }
> >> +
> >> +               if (attest_call.manifest_buffer.len > manifest_len) {
> >> +                       manifest_len =3D PAGE_ALIGN(attest_call.manife=
st_buffer.len);
> >> +                       try_again =3D true;
> >> +               }
> >> +
> >> +               if (attest_call.certificates_buffer.len > certificates=
_len) {
> >> +                       certificates_len =3D PAGE_ALIGN(attest_call.ce=
rtificates_buffer.len);
> >> +                       try_again =3D true;
> >> +               }
> >> +
> >> +               /* If one of the buffers wasn't large enough, retry th=
e request */
> >> +               if (try_again) {
> >> +                       free_pages_exact(buffer, size);
> >> +                       goto retry;
> >> +               }
> >> +
> >> +               ret =3D -EINVAL;
> >> +               goto error;
> >> +       case SVSM_ERR_BUSY:
> >> +               ret =3D -EAGAIN;
> >> +               goto error;
> >> +       default:
> >> +               pr_err_ratelimited("SVSM attestation request failed (%=
#x)\n", ret);
> >> +               ret =3D -EINVAL;
> >> +               goto error;
> >> +       }
> >> +
> >> +       ret =3D -ENOMEM;
> >> +
> >> +       report_len =3D attest_call.report_buffer.len;
> >> +       void *rbuf __free(kvfree) =3D kvzalloc(report_len, GFP_KERNEL)=
;
> >> +       if (!rbuf)
> >> +               goto error;
> >> +
> >> +       memcpy(rbuf, report_blob, report_len);
> >> +       report->outblob =3D no_free_ptr(rbuf);
> >> +       report->outblob_len =3D report_len;
> >> +
> >> +       manifest_len =3D attest_call.manifest_buffer.len;
> >> +       void *mbuf __free(kvfree) =3D kvzalloc(manifest_len, GFP_KERNE=
L);
> >> +       if (!mbuf)
> >> +               goto error;
> >> +
> >> +       memcpy(mbuf, manifest_blob, manifest_len);
> >> +       report->manifestblob =3D no_free_ptr(mbuf);
> >> +       report->manifestblob_len =3D manifest_len;
> >> +
> >> +       certificates_len =3D attest_call.certificates_buffer.len;
> >> +       if (!certificates_len)
> >> +               goto success;
> >> +
> >> +       void *cbuf __free(kvfree) =3D kvzalloc(certificates_len, GFP_K=
ERNEL);
> >> +       if (!cbuf)
> >> +               goto error;
> >> +
> >> +       memcpy(cbuf, certificates_blob, certificates_len);
> >> +       report->auxblob =3D no_free_ptr(cbuf);
> >> +       report->auxblob_len =3D certificates_len;
> >> +
> >> +success:
> >> +       ret =3D 0;
> >> +
> >> +error:
> >> +       free_pages_exact(buffer, size);
> >> +
> >> +       return ret;
> >> +}
> >> +
> >>   static int sev_report_new(struct tsm_report *report, void *data)
> >>   {
> >>          struct snp_msg_cert_entry *cert_table;
> >> @@ -797,6 +931,9 @@ static int sev_report_new(struct tsm_report *repor=
t, void *data)
> >>          if (desc->inblob_len !=3D SNP_REPORT_USER_DATA_SIZE)
> >>                  return -EINVAL;
> >>
> >> +       if (desc->svsm)
> >> +               return sev_svsm_report_new(report, data);
> >> +
> >>          void *buf __free(kvfree) =3D kvzalloc(size, GFP_KERNEL);
> >>          if (!buf)
> >>                  return -ENOMEM;
> >> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> >> index d1c2db83a8ca..33fa26406bc6 100644
> >> --- a/drivers/virt/coco/tsm.c
> >> +++ b/drivers/virt/coco/tsm.c
> >> @@ -35,7 +35,7 @@ static DECLARE_RWSEM(tsm_rwsem);
> >>    * The attestation report format is TSM provider specific, when / if=
 a standard
> >>    * materializes that can be published instead of the vendor layout. =
Until then
> >>    * the 'provider' attribute indicates the format of 'outblob', and o=
ptionally
> >> - * 'auxblob'.
> >> + * 'auxblob' and 'manifestblob'.
> >>    */
> >>
> >>   struct tsm_report_state {
> >> @@ -48,6 +48,7 @@ struct tsm_report_state {
> >>   enum tsm_data_select {
> >>          TSM_REPORT,
> >>          TSM_CERTS,
> >> +       TSM_MANIFEST,
> >>   };
> >>
> >>   static struct tsm_report *to_tsm_report(struct config_item *cfg)
> >> @@ -119,6 +120,77 @@ static ssize_t tsm_report_privlevel_floor_show(st=
ruct config_item *cfg,
> >>   }
> >>   CONFIGFS_ATTR_RO(tsm_report_, privlevel_floor);
> >>
> >> +static ssize_t tsm_report_svsm_store(struct config_item *cfg,
> >> +                                    const char *buf, size_t len)
> >> +{
> >> +       struct tsm_report *report =3D to_tsm_report(cfg);
> >> +       unsigned int val;
> >> +       int rc;
> >> +
> >> +       rc =3D kstrtouint(buf, 0, &val);
> >> +       if (rc)
> >> +               return rc;
> >> +
> >> +       guard(rwsem_write)(&tsm_rwsem);
> >> +       rc =3D try_advance_write_generation(report);
> >> +       if (rc)
> >> +               return rc;
> >> +       report->desc.svsm =3D !!val;
> >> +
> >> +       return len;
> >> +}
> >> +CONFIGFS_ATTR_WO(tsm_report_, svsm);
> >> +
> >> +static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
> >> +                                            const char *buf, size_t l=
en)
> >> +{
> >> +       struct tsm_report *report =3D to_tsm_report(cfg);
> >> +       size_t guid_len;
> >> +       int rc;
> >> +
> >> +       guard(rwsem_write)(&tsm_rwsem);
> >> +       rc =3D try_advance_write_generation(report);
> >> +       if (rc)
> >> +               return rc;
> >> +
> >> +       /* Obtain the GUID string length */
> >> +       guid_len =3D (len && buf[len - 1] =3D=3D '\n') ? len - 1 : len=
;
> >> +       if (guid_len && guid_len !=3D UUID_STRING_LEN)
> >> +               return -EINVAL;
> >> +
> >> +       if (guid_len =3D=3D UUID_STRING_LEN) {
> >> +               rc =3D guid_parse(buf, &report->desc.service_guid);
> >> +               if (rc)
> >> +                       return rc;
> >> +       } else {
> >> +               report->desc.service_guid =3D guid_null;
> >> +       }
> >> +
> >> +       return len;
> >> +}
> >> +CONFIGFS_ATTR_WO(tsm_report_, service_guid);
> >> +
> >> +static ssize_t tsm_report_service_version_store(struct config_item *c=
fg,
> >> +                                               const char *buf, size_=
t len)
> >> +{
> >> +       struct tsm_report *report =3D to_tsm_report(cfg);
> >> +       unsigned int val;
> >> +       int rc;
> >> +
> >> +       rc =3D kstrtouint(buf, 0, &val);
> >> +       if (rc)
> >> +               return rc;
> >> +
> >> +       guard(rwsem_write)(&tsm_rwsem);
> >> +       rc =3D try_advance_write_generation(report);
> >> +       if (rc)
> >> +               return rc;
> >> +       report->desc.service_version =3D val;
> >> +
> >> +       return len;
> >> +}
> >> +CONFIGFS_ATTR_WO(tsm_report_, service_version);
> >> +
> >>   static ssize_t tsm_report_inblob_write(struct config_item *cfg,
> >>                                         const void *buf, size_t count)
> >>   {
> >> @@ -163,6 +235,9 @@ static ssize_t __read_report(struct tsm_report *re=
port, void *buf, size_t count,
> >>          if (select =3D=3D TSM_REPORT) {
> >>                  out =3D report->outblob;
> >>                  len =3D report->outblob_len;
> >> +       } else if (select =3D=3D TSM_MANIFEST) {
> >> +               out =3D report->manifestblob;
> >> +               len =3D report->manifestblob_len;
> >>          } else {
> >>                  out =3D report->auxblob;
> >>                  len =3D report->auxblob_len;
> >> @@ -188,7 +263,7 @@ static ssize_t read_cached_report(struct tsm_repor=
t *report, void *buf,
> >>
> >>          /*
> >>           * A given TSM backend always fills in ->outblob regardless o=
f
> >> -        * whether the report includes an auxblob or not.
> >> +        * whether the report includes an auxblob/manifestblob or not.
> >>           */
> >>          if (!report->outblob ||
> >>              state->read_generation !=3D state->write_generation)
> >> @@ -224,8 +299,10 @@ static ssize_t tsm_report_read(struct tsm_report =
*report, void *buf,
> >>
> >>          kvfree(report->outblob);
> >>          kvfree(report->auxblob);
> >> +       kvfree(report->manifestblob);
> >>          report->outblob =3D NULL;
> >>          report->auxblob =3D NULL;
> >> +       report->manifestblob =3D NULL;
> >>          rc =3D ops->report_new(report, provider.data);
> >>          if (rc < 0)
> >>                  return rc;
> >> @@ -252,6 +329,15 @@ static ssize_t tsm_report_auxblob_read(struct con=
fig_item *cfg, void *buf,
> >>   }
> >>   CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_OUTBLOB_MAX);
> >>
> >> +static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, =
void *buf,
> >> +                                           size_t count)
> >> +{
> >> +       struct tsm_report *report =3D to_tsm_report(cfg);
> >> +
> >> +       return tsm_report_read(report, buf, count, TSM_MANIFEST);
> >> +}
> >> +CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX=
);
> >> +
> >>   #define TSM_DEFAULT_ATTRS() \
> >>          &tsm_report_attr_generation, \
> >>          &tsm_report_attr_provider
> >> @@ -265,6 +351,9 @@ static struct configfs_attribute *tsm_report_extra=
_attrs[] =3D {
> >>          TSM_DEFAULT_ATTRS(),
> >>          &tsm_report_attr_privlevel,
> >>          &tsm_report_attr_privlevel_floor,
> >> +       &tsm_report_attr_svsm,
> >> +       &tsm_report_attr_service_guid,
> >> +       &tsm_report_attr_service_version,
> >>          NULL,
> >>   };
> >>
> >> @@ -280,6 +369,7 @@ static struct configfs_bin_attribute *tsm_report_b=
in_attrs[] =3D {
> >>   static struct configfs_bin_attribute *tsm_report_bin_extra_attrs[] =
=3D {
> >>          TSM_DEFAULT_BIN_ATTRS(),
> >>          &tsm_report_attr_auxblob,
> >> +       &tsm_report_attr_manifestblob,
> >>          NULL,
> >>   };
> >>
> >> @@ -288,6 +378,7 @@ static void tsm_report_item_release(struct config_=
item *cfg)
> >>          struct tsm_report *report =3D to_tsm_report(cfg);
> >>          struct tsm_report_state *state =3D to_state(report);
> >>
> >> +       kvfree(report->manifestblob);
> >>          kvfree(report->auxblob);
> >>          kvfree(report->outblob);
> >>          kfree(state);
> >> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> >> index de8324a2223c..7c36b8448b4f 100644
> >> --- a/include/linux/tsm.h
> >> +++ b/include/linux/tsm.h
> >> @@ -4,6 +4,7 @@
> >>
> >>   #include <linux/sizes.h>
> >>   #include <linux/types.h>
> >> +#include <linux/uuid.h>
> >>
> >>   #define TSM_INBLOB_MAX 64
> >>   #define TSM_OUTBLOB_MAX SZ_32K
> >> @@ -19,11 +20,17 @@
> >>    * @privlevel: optional privilege level to associate with @outblob
> >>    * @inblob_len: sizeof @inblob
> >>    * @inblob: arbitrary input data
> >> + * @svsm: optional indicator of where to obtain the tsm report blob
> >> + * @service_guid: optional SVSM service guid to attest
> >> + * @service_version: optional SVSM service manifest version requested
> >>    */
> >>   struct tsm_desc {
> >>          unsigned int privlevel;
> >>          size_t inblob_len;
> >>          u8 inblob[TSM_INBLOB_MAX];
> >> +       bool svsm;
> >> +       guid_t service_guid;
> >> +       unsigned int service_version;
> >>   };
> >>
> >>   /**
> >> @@ -33,6 +40,8 @@ struct tsm_desc {
> >>    * @outblob: generated evidence to provider to the attestation agent
> >>    * @auxblob_len: sizeof(@auxblob)
> >>    * @auxblob: (optional) auxiliary data to the report (e.g. certifica=
te data)
> >> + * @manifestblob_len: sizeof(@manifestblob)
> >> + * @manifestblob: (optional) manifest data associated with the report
> >>    */
> >>   struct tsm_report {
> >>          struct tsm_desc desc;
> >> @@ -40,6 +49,8 @@ struct tsm_report {
> >>          u8 *outblob;
> >>          size_t auxblob_len;
> >>          u8 *auxblob;
> >> +       size_t manifestblob_len;
> >> +       u8 *manifestblob;
> >>   };
> >>
> >>   /**
> >> --
> >> 2.42.0
> >>
> >>
> >
> >



--=20
-Dionna Glaze, PhD (she/her)

