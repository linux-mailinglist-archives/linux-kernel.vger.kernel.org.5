Return-Path: <linux-kernel+bounces-149006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB418A8A64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5721C21A74
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A159172795;
	Wed, 17 Apr 2024 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hxoaAbws"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0416D39877
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375934; cv=none; b=HGanCAgv5ltUqf9vsu6lCkaUA4cc8O2i3jgRgV0Rb9GSXclILThs2UTo04wumOjn/WdkYAALe8+WEDFAgOAog1gt7YtH89xJurRVPASkNfJ5ry/+7Iv1sVYGF7C3lIZX88ZJUG8t0u/JcvLCoR0jqbtzBWsP0tYTjkyblCRJpcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375934; c=relaxed/simple;
	bh=maMZb372ZQs3STpkH2cMuTPxXNpNoFe8ca5Q9K7gIaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOfRf3o4FRFFpYnJciIypO7COVJOMwGkrTpsDHhdNjrR88Rq7p9eHc6eS1Hjw8cW3blki7mz9N0a4rc988/su3Ri1tXlPmLjops0NJPM5VytjmgUOhJNgOxRHZ13BLDMd8FmvUH1X0A3ZH14UWsEAHM+Z2eg+/m1uo6DsUpB1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hxoaAbws; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-436ed871225so21161cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713375930; x=1713980730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHONZyWOGLLYRCmpb/mAXFtTsD+qJwFcV2cygwx1nxo=;
        b=hxoaAbwsxQoBlEkKPRdDpL/HlEkZSR4iheOXnjIvKN/vSriC6pHy/eiKSDHReuGZY0
         jmkbKswsNSMOFzNgqNXGxkN8LoaSFW6MpaKR3BG7eq95kX25gq7xFSg7wLMM0pAhQsQy
         C+7jqjYegyQY2UBnMCFekAwtPQIQyzqqUHTibZ0WxX4WqFBJJ3A279qB1HnCx756ELcr
         tUPYqHY73mX9oU58PpwJZ9yrNcJN2WT71ADW/8bBh9UtP7zgzoaFwn2OkDU7KwDuJmoG
         koogqRWCty+5g4DFNQ6KP9i49xRkFxggW1GIwglkAFLX7l+x8SKzz7CLHeaQo0vReEis
         f4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713375930; x=1713980730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHONZyWOGLLYRCmpb/mAXFtTsD+qJwFcV2cygwx1nxo=;
        b=fxl5EuEecylM//2m00xtxMB8l+5FQy5wHmUaf+c2nXLbK5MCCpp4ssniZ/Gun5vmzT
         G2ExsNpHalFlVwYw5FGoQdyjzMOCczbIeDPc748RbJQRgUk0+eonUWYAbfsOTFBAohDg
         az9aPicvh0PJwRhuBl3I9wZd5XaJ8Do2wfi3CgRAz5csvRQlCfXECiBSeS/BskBX5b9O
         DJbozKJDEOyjOcD4yqa8cEL1es7WJmFR1eonfNsiONHRvIKQ9vPEshxb4kX2rsFWj1Mi
         9tIXlPQkxZjRMuySLU2StmVLJza1HpbRD1OTdDr8EBQijIUmRjYSVp/CWM366YHVNVqr
         aZ7w==
X-Forwarded-Encrypted: i=1; AJvYcCUeK4zMGKqi4mEXlC7G2Qcaj9/rCt2DO3LhvTblj2ZwUIx52cB2GsRgXZmSyJiK/rofvmtefEe5n4oiMOsqcKAjatdbR7Uu/8y1Z8/R
X-Gm-Message-State: AOJu0YxiWbqnUfUGGlbpfzN/z0RQ/GcbkepJLmyQe+rbyqJm7Kv+FHpf
	stDfLWyServAt7wSsMuKtDFd+mvFg54XCuTWTvJN04DwDBLbVaY38lXU0h7jaHoNBuch5wVnPRM
	8BDn1ckAsEJ5HZ4cd77yR0PFE0c9nVH/Zi7A6
X-Google-Smtp-Source: AGHT+IF7TlF/nitcAQ7c+Bqgfsso4XEHoUnk8wB+pQJYBQIqAJBVm2VJi/g5YIi8fbJaXJGqH2ZnJbdV0OYlCl5WF/Y=
X-Received: by 2002:a05:622a:248:b0:434:ec62:970c with SMTP id
 c8-20020a05622a024800b00434ec62970cmr9203qtx.12.1713375929698; Wed, 17 Apr
 2024 10:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711674410.git.babu.moger@amd.com> <f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com>
In-Reply-To: <f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Wed, 17 Apr 2024 10:45:18 -0700
Message-ID: <CALPaoCihU+mat2A-wNtTm=qbpya8ZqhDURsfZfjuHitch0WrLA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 17/17] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com, 
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com, 
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com, kai.huang@intel.com, 
	kan.liang@linux.intel.com, daniel.sneddon@linux.intel.com, 
	pbonzini@redhat.com, sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com, 
	maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Babu,

On Thu, Mar 28, 2024 at 6:10=E2=80=AFPM Babu Moger <babu.moger@amd.com> wro=
te:
>
> Introduce rdtgroup_mbm_assign_control_write to assign mbm events.
> Assignment state can be updated by writing to this interface.
> Assignment states are applied on all the domains. Assignment on one
> domain applied on all the domains. User can pass one valid domain and
> assignment will be updated on all the available domains.

It sounds like you said the same thing 3 times in a row.


> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/=
resctrl.rst
> index 2d96565501ab..64ec70637c66 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -328,6 +328,77 @@ with the following files:
>          None of events are assigned on this mon group. This is a child
>          monitor group of the non default control mon group.
>
> +       Assignment state can be updated by writing to this interface.
> +
> +       NOTE: Assignment on one domain applied on all the domains. User c=
an
> +       pass one valid domain and assignment will be updated on all the
> +       available domains.

How would different assignments to different domains work? If the
allocations are global, then the allocated monitor ID is available to
all domains whether they use it or not.


> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu=
/resctrl/rdtgroup.c
> index 9fd37b6c3b24..7f8b1386287a 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1011,6 +1035,215 @@ static int rdtgroup_mbm_assign_control_show(struc=
t kernfs_open_file *of,
>         return 0;
>  }
>
> +static struct rdtgroup *resctrl_get_rdtgroup(enum rdt_group_type rtype, =
char *p_grp, char *c_grp)
> +{
> +       struct rdtgroup *rdtg, *crg;
> +
> +       if (rtype =3D=3D RDTCTRL_GROUP && *p_grp =3D=3D '\0') {
> +               return &rdtgroup_default;
> +       } else if (rtype =3D=3D RDTCTRL_GROUP) {
> +               list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list)
> +                       if (!strcmp(p_grp, rdtg->kn->name))
> +                               return rdtg;
> +       } else if (rtype =3D=3D RDTMON_GROUP) {
> +               list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list)=
 {
> +                       if (!strcmp(p_grp, rdtg->kn->name)) {
> +                               list_for_each_entry(crg, &rdtg->mon.crdtg=
rp_list,
> +                                                   mon.crdtgrp_list) {
> +                                       if (!strcmp(c_grp, crg->kn->name)=
)
> +                                               return crg;
> +                               }
> +                       }
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
> +static int resctrl_process_flags(enum rdt_group_type rtype, char *p_grp,=
 char *c_grp, char *tok)
> +{
> +       struct rdt_resource *r =3D &rdt_resources_all[RDT_RESOURCE_L3].r_=
resctrl;
> +       int op, mon_state, assign_state, unassign_state;
> +       char *dom_str, *id_str, *op_str;
> +       struct rdtgroup *rdt_grp;
> +       struct rdt_domain *d;
> +       unsigned long dom_id;
> +       int ret, found =3D 0;
> +
> +       rdt_grp =3D resctrl_get_rdtgroup(rtype, p_grp, c_grp);
> +
> +       if (!rdt_grp) {
> +               rdt_last_cmd_puts("Not a valid resctrl group\n");
> +               return -EINVAL;
> +       }
> +
> +next:
> +       if (!tok || tok[0] =3D=3D '\0')
> +               return 0;
> +
> +       /* Start processing the strings for each domain */
> +       dom_str =3D strim(strsep(&tok, ";"));
> +
> +       op_str =3D strpbrk(dom_str, "=3D+-_");
> +
> +       if (op_str) {
> +               op =3D *op_str;
> +       } else {
> +               rdt_last_cmd_puts("Missing operation =3D, +, -, _ charact=
er\n");
> +               return -EINVAL;
> +       }
> +
> +       id_str =3D strsep(&dom_str, "=3D+-_");
> +
> +       if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
> +               rdt_last_cmd_puts("Missing domain id\n");
> +               return -EINVAL;
> +       }
> +
> +       /* Verify if the dom_id is valid */
> +       list_for_each_entry(d, &r->domains, list) {
> +               if (d->id =3D=3D dom_id) {
> +                       found =3D 1;
> +                       break;
> +               }
> +       }
> +       if (!found) {
> +               rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
> +               return -EINVAL;
> +       }
> +
> +       if (op !=3D '_')
> +               mon_state =3D str_to_mon_state(dom_str);
> +
> +       assign_state =3D 0;
> +       unassign_state =3D 0;
> +
> +       switch (op) {
> +       case '+':
> +               assign_state =3D mon_state;
> +               break;
> +       case '-':
> +               unassign_state =3D mon_state;
> +               break;
> +       case '=3D':
> +               assign_state =3D mon_state;
> +               unassign_state =3D (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assig=
n_state;
> +               break;
> +       case '_':
> +               unassign_state =3D ASSIGN_TOTAL | ASSIGN_LOCAL;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       if (assign_state & ASSIGN_TOTAL)
> +               ret =3D rdtgroup_assign_abmc(rdt_grp, QOS_L3_MBM_TOTAL_EV=
ENT_ID,
> +                                          ASSIGN_TOTAL);

Related to my comments yesterday[1], it seems redundant for an
interface to need two names for the same event.


> +       if (ret)
> +               goto out_fail;
> +
> +       if (assign_state & ASSIGN_LOCAL)
> +               ret =3D rdtgroup_assign_abmc(rdt_grp, QOS_L3_MBM_LOCAL_EV=
ENT_ID,
> +                                          ASSIGN_LOCAL);
> +
> +       if (ret)
> +               goto out_fail;
> +
> +       if (unassign_state & ASSIGN_TOTAL)
> +               ret =3D rdtgroup_unassign_abmc(rdt_grp, QOS_L3_MBM_TOTAL_=
EVENT_ID,
> +                                            ASSIGN_TOTAL);
> +       if (ret)
> +               goto out_fail;
> +
> +       if (unassign_state & ASSIGN_LOCAL)
> +               ret =3D rdtgroup_unassign_abmc(rdt_grp, QOS_L3_MBM_LOCAL_=
EVENT_ID,
> +                                            ASSIGN_LOCAL);
> +       if (ret)
> +               goto out_fail;
> +
> +       goto next;

I saw that each call to rdtgroup_assign_abmc() allocates a counter.
Does that mean assigning to multiple domains (in the same or multiple
commands) allocates a new counter (or pair of counters) in every
domain?

Thanks!
-Peter

[1] https://lore.kernel.org/lkml/CALPaoCj_yb_muT78jFQ5gL0wkifohSAVwxMDTm2FX=
_2YVpANdw@mail.gmail.com/

