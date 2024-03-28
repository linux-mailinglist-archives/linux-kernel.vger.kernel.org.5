Return-Path: <linux-kernel+bounces-122543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219CC88F936
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A123C1F29852
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F3A537E1;
	Thu, 28 Mar 2024 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OP4zsFD+"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32084F8BB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612466; cv=none; b=hqkftl/oyNFBv33uzmEjJM906wXushlXlr9XF+JBf6/5k+EQyqXHNIMNznT8rckTFAQOMTdNiAuVP5V7zo0aBPjkbrTjx+l689tFVNeMBmqAAZvmM2PWjfBvcMJkKl/wtgIlTcRM5o2xiqKZYuL+kIhl5npHm/MKSa2yWV8xSVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612466; c=relaxed/simple;
	bh=30bAraAl/KuCq2L2WJtfoMDiNEUxCBxMkCbL1xWURV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ir9K6NBRruWB24TikVwVVL1nTYj8/0fUFgJk4QvluZAmc/VustjmB0s2FsQ7VRZ9asqODEWa1+lF7Xxv41gr2vupI7JyBjQ/LsDiyi8tfrCa0Ya83Mn9yaF26zkDe9FyiAaSkG3fQk6PzQRwSuIpJAUNnxUUxwSUc9UTlFl1GHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OP4zsFD+; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-ddaad2aeab1so602466276.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 00:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711612463; x=1712217263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbC5cWd3WAP709PDHIqZn6WUv4KT91ju291e26yekHU=;
        b=OP4zsFD++hsxnDtvHGpqsBWTKrfOv9QV+KwmoG9KyYE+8CnKCKTK6y84GGlJEwPsJJ
         VZAKilGXaCAN13oekJ2q27isWSD09+x3jE9Yotn9OvnFYFQsgcTk+xjlNQgF1Gv9lcdL
         08J3wuAblXcZPE3vcSeKPmrkwBrXxD7P3owvsb1bZYfXlZ+FU+D7txyFvaHyUtPMq0Uy
         3r0Fpt/G8RnrIGdKsoU6HxvYQjNEATLyWGMR7PWvjIzOJC6BfFQ5RYsmXbMDZzGvac7N
         /upJ96npHAD5l3DnfuzPEb8eAJSdHhcIwhfuyJY0JJtjSRorwJfBVaI8Ro+Hjn2AUhzY
         gRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612463; x=1712217263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbC5cWd3WAP709PDHIqZn6WUv4KT91ju291e26yekHU=;
        b=Wby4NLkkoQGEIezODNwrO5kpjMLB0XPoqtqUId+p9+03V4HLC3MI604jAKOhbNjQP4
         ZuW3i39PEzUCFLPCQikBbYILub+DnSlVtB8fAI8wQkVpYDuYUj7zu0VkwPkV/k4txCws
         AEka50CCQ8pfIGq9g6PwUbtmOD98L8240raCXAYAjGgHSUHCEbRqCt+zRC2a9PP54P7d
         ftTDTwJik+Zsz1fZSPqe+pvB8XW2BE4r0OdWhWpFtX8DpaVkNpG7nf9lj3RQmpJxIVMw
         aZpReVK61TsxgyzYHfgC6CuM+SUKWwoNsaC2urfmmYo4nXdnyK0gw+aJhQYX+Zvcv7ly
         Oufg==
X-Forwarded-Encrypted: i=1; AJvYcCWfMkSR/MSSDJUluOVrYNVQUmhC3WXMXLFsKsNkLQcTAj7DoO5xSBMcLb3n6LIZtOPXxv0Jakkps9m1RpI6RllW6fPUmICIcW+kFaoK
X-Gm-Message-State: AOJu0YzsG8DI1qmiIfSNSn+ly3SDaumfbglPlo8+KU9ZD2MxEebN2q+N
	XVWAv4l/ndC9BOIXIEaGuz1npuhGE/9C9K5imNAxQgi0Dy600aFO+TZaREuZUrdUUzPcim6Xgoh
	odDo5eYizhvIBJD0c72DqcPs3pXaz8JQwYLQVtw==
X-Google-Smtp-Source: AGHT+IEdkLQhpRPn4k1IyjPDs5Vv2uuU8cYVmBxxxsVzJXO5QupQAGy5BtVXsboyybOzZeHVOtwZZhZHHoOjBTG7fIw=
X-Received: by 2002:a25:ab26:0:b0:dc6:a223:bb3b with SMTP id
 u35-20020a25ab26000000b00dc6a223bb3bmr2099954ybi.46.1711612463662; Thu, 28
 Mar 2024 00:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327072729.3381685-1-horenchuang@bytedance.com>
 <20240327072729.3381685-3-horenchuang@bytedance.com> <87v857kujp.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87v857kujp.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Thu, 28 Mar 2024 00:54:13 -0700
Message-ID: <CAKPbEqrhBLQ67ciUTukGTB0eC3G_JHcTEMfbiw_PtnGBSv=ksw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6 2/2] memory tier: create CPUless memory
 tiers after obtaining HMAT info
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com, mhocko@suse.com, 
	tj@kernel.org, john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	Alistair Popple <apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org, 
	Hao Xiang <hao.xiang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 6:37=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>
> [snip]
>
> > @@ -655,6 +672,34 @@ void mt_put_memory_types(struct list_head *memory_=
types)
> >  }
> >  EXPORT_SYMBOL_GPL(mt_put_memory_types);
> >
> > +/*
> > + * This is invoked via `late_initcall()` to initialize memory tiers fo=
r
> > + * CPU-less memory nodes after driver initialization, which is
> > + * expected to provide `adistance` algorithms.
> > + */
> > +static int __init memory_tier_late_init(void)
> > +{
> > +     int nid;
> > +
> > +     mutex_lock(&memory_tier_lock);
> > +     for_each_node_state(nid, N_MEMORY)
> > +             if (!node_state(nid, N_CPU) &&
> > +                     node_memory_types[nid].memtype =3D=3D NULL)
>
> Think about this again.  It seems that it is better to check
> "node_memory_types[nid].memtype =3D=3D NULL" only here.  Because for all
> node with N_CPU in memory_tier_init(), "node_memory_types[nid].memtype"
> will be !NULL.  And it's possible (in theory) that some nodes becomes
> "node_state(nid, N_CPU) =3D=3D true" between memory_tier_init() and
> memory_tier_late_init().
>
> Otherwise, Looks good to me.  Feel free to add
>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>
> in the future version.
>

Thank you Huang, Ying for your endorsement and
the feedback you've been giving!

> > +                     /*
> > +                      * Some device drivers may have initialized memor=
y tiers
> > +                      * between `memory_tier_init()` and `memory_tier_=
late_init()`,
> > +                      * potentially bringing online memory nodes and
> > +                      * configuring memory tiers. Exclude them here.
> > +                      */
> > +                     set_node_memory_tier(nid);
> > +
> > +     establish_demotion_targets();
> > +     mutex_unlock(&memory_tier_lock);
> > +
> > +     return 0;
> > +}
> > +late_initcall(memory_tier_late_init);
> > +
>
> [snip]
>
> --
> Best Regards,
> Huang, Ying



--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

