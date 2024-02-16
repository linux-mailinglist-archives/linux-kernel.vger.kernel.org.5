Return-Path: <linux-kernel+bounces-69282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EB0858699
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F921C216E0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70DF13957E;
	Fri, 16 Feb 2024 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FzaNeIUu"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846EC12FF60
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708114724; cv=none; b=iB3aG1Q8W+q7FlWC7oF+X0GLpLy5d17cXUZXgGzVVVGgD2o+LbejYfCELZRa+gTveVZqLHVWhu8c2JnAZo7Iv7xKxNeMZGXQ4QXhQRNbHZm/q6F9x2+S4AyS0GME9waF+b9yqxzI+n5zpltWEuxrN2T89QMRCeO+hnleVZlIh4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708114724; c=relaxed/simple;
	bh=NXpkbYiaH9JB2933j4B3xFyzMZvqRc2X98KlpqhTWVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKLxIb28X4u1bCMBueOH044lGvPhc3krjzYgbq+6f7AVeB93nKBb1Gm075PKRfQqH2Tb0Sayluthd67KZvlMxuaHMkVg9HCz5d/Fnii4Hx1puOu5QYFsv68mj6l0eE2U4Wm60UcNYXz3+lH4Ej8QBHnKcJo2jW6dmj3tE9ms81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FzaNeIUu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d89f0ab02bso19235ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708114722; x=1708719522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGidkPaApOit0v+6g6i4h6oGRDmLx70GjL/Y9I2txxY=;
        b=FzaNeIUufj78XfxZCXtbEhoOD2W9SNWbPimmQ+xRbiyAn1Hr5dgIbGVU7TOkCeqMrI
         xCOiuj7KxzCOCvlEpPoYUb3b820hs58qoTdHMePqhCNPwg720kRkfjH+6OFqZOx3tQHL
         QtcMqBi9SSwibBmlhFNyAla58stwXe4fXvDH9kgQxXkEoo/hE4ozcb1kGPd1Wg9/Vx5M
         0Bbi3nkGy172mzKPuhifZs35JJpE5K5jdC4YaNpVRiwevZdT7Utl17Bugn4PAHi7sYm2
         3G739yXeY7Hacw8gUGeKYSiw7OXQdao4eWcPphjdm3E1X1cibtLfWo8VZPYPrksG9cZ/
         vqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708114722; x=1708719522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGidkPaApOit0v+6g6i4h6oGRDmLx70GjL/Y9I2txxY=;
        b=R/CIGCYwvrE8smEYE7XSplh6BRLay+f/R4BYVI5Rq/bsBPpLBi92mQlP35dUGZ7DsM
         DJQHbdaA/WVjxbCfGopSyNOXGGMyKw1JvlEhn2kS0j44L6VLJc3KhkLl7hqE0EMNYGHc
         H3Lg/kFzyLDn+iAqH8CB9gqOpgN2Zc4GaYun/e/zA+cUCvL9ExzNgfNsJbQFfqS0G3XI
         b/2Xr1wxopIMKLjCXYr+uf5splDC8yianxgwxN87T2WrGJXiF8M09jxtbeCJH3ix4cXO
         GqoKLCJKN+8razVUpDMAYF5Gdlai3nu5zs+Y7tlCGJoD/dbo1XRCOYizrrPUSdnAVuw8
         r7yg==
X-Forwarded-Encrypted: i=1; AJvYcCXtvDsHmkC4RmPFVrcxNMKqfdSxo3yvET3vfr+ngtI+X2nvspTOnGmu1LMRAEUDmQQz/sHpHI90xsLf66EYysjZXywfK5x+6Ix1Azbw
X-Gm-Message-State: AOJu0YxMC382tXa5ppubj7nJZrcYs+HKcZNYkeehAJoQSAwbpgE9dGxS
	2dRGa4rvL48UDN6ZG38cp9pTLrKKI4svrC/q++duF5VclnYMNLeGNz+PEnQXQNuQ6mSkodhlxHE
	bIG6OVt5HDtyYKgOXXprwvxivTnjPRu/HZ+3F
X-Google-Smtp-Source: AGHT+IFAqKDFfQdydDYmxWaUSuiI8UQ1LH1oYoNNIqsDe8byRsas70TXreiKKFloHuY/81e2w4QpRkuE5XqrFRNg24Y=
X-Received: by 2002:a17:902:d543:b0:1db:7284:a766 with SMTP id
 z3-20020a170902d54300b001db7284a766mr20199plf.0.1708114721468; Fri, 16 Feb
 2024 12:18:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201005720.235639-1-babu.moger@amd.com> <cover.1705688538.git.babu.moger@amd.com>
 <7c26af23-fa1e-4e01-8088-8fbd9be3d6f3@intel.com> <431d6ac4-53cb-2f73-3cda-22616df2f96a@amd.com>
 <4bb63a78-0d0d-47bc-ad65-558af8bc5519@intel.com> <51c60991-eb10-40e8-b3ab-676b92b0c662@amd.com>
In-Reply-To: <51c60991-eb10-40e8-b3ab-676b92b0c662@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Fri, 16 Feb 2024 12:18:30 -0800
Message-ID: <CALPaoChhKJiMAueFtgCTc7ffO++S5DJCySmxqf9ZDmhR9RQapw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: babu.moger@amd.com
Cc: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net, fenghua.yu@intel.com, 
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
	linux-kernel@vger.kernel.org, eranian@google.com, 
	"james.morse@arm.com" <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Babu,

On Thu, Feb 8, 2024 at 9:29=E2=80=AFAM Moger, Babu <babu.moger@amd.com> wro=
te:
> On 2/5/24 16:38, Reinette Chatre wrote:
> > This could be improved beyond a binary "enable"/"disable" interface to =
user space.
> > For example, the hardware can discover which "mbm counter assign" relat=
ed feature
> > (I'm counting the "soft RMID" here as one of the "mbm counter assign" r=
elated
> > features) is supported on the platform and it can be presented to the u=
ser like:
> >
> > # cat /sys/fs/resctrl/info/L3_MON/mbm_assign
> > [feature_1] feature_2 feature_3
>
> How about this?
> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>  ABMC:Capable
>  SOFT-RMID:Capable
>
> To enable ABMC
> # echo ABMC:enable > /sys/fs/resctrl/info/L3_MON/mbm_assign
>
> When ABMC is enabled:
> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>  ABMC:Enable
>  SOFT-RMID:Capable

There would be no need to use soft RMIDs on a system that supports
ABMC, so I can't think of a reason why the underlying implementation
would matter to our users. The user should only have to request the
interface where monitors must be assigned manually. The mount would
succeed if the system has a way to support the interface.


> > You have made it clear on several occasions that you do not intend to s=
upport
> > domain level assignment. That may be ok but the interface you create sh=
ould
> > not prevent future support of domain level assignment.
> >
> > If my point is not clear, could you please share how this interface is =
able to
> > support domain level assignment in the future?
> >
> > I am starting to think that we need a file similar to the schemata file
> > for group and domain level monitor configurations.
>
> Something like this?
>
> By default
> #cat /sys/fs/resctrl/monitor_state
> default:0=3Dtotal=3Dassign,local=3Dassign;1=3Dtotal=3Dassign,local=3Dassi=
gn
>
> With ABMC,
> #cat /sys/fs/resctrl/monitor_state
> ABMC:0=3Dtotal=3Dunassign,local=3Dunassign;1=3Dtotal=3Dunassign,local=3Du=
nassign

The benefit from all the string parsing in this interface is only
halving the number of monitor_state sysfs writes we'd need compared to
creating a separate file for mbm_local and mbm_total. Given that our
use case is to assign the 32 assignable counters to read the bandwidth
of ~256 monitoring groups, this isn't a substantial gain to help us. I
think you should just focus on providing the necessary control
granularity without trying to consolidate writes in this interface. I
will propose an additional interface below to optimize our use case.

Whether mbm_total and mbm_local are combined in the group directories
or not, I don't see why you wouldn't just repeat the same file
interface in the domain directories for a user needing finer-grained
controls.


> >> Peter, James,
> >>
> >> Please comment on what you want achieve in "assignment" based on the f=
eatures you are working on.

I prototyped and tested the following additional interface for the
large-scale, batch use case that we're primarily concerned about:

info/L3_MON/mbm_{local,total}_bytes_assigned

Writing a whitespace-delimited list of mongroup directory paths does
the following:
1. unassign all monitors for the given counter
2. assigns a monitor to each mongroup referenced in the write
3. batches per-domain register updates resulting from the assignments
into a single IPI for each domain

This interface allows us to do less sysfs writes and IPIs on systems
with more assignable monitoring resources, rather than doing more.

The reference to a mongroup when reading/writing the above node is the
resctrl-root-relative path to the monitoring group. There is probably
a more concise way to refer to the groups, but my prototype used
kernfs_walk_and_get() to locate each rdtgroup struct.

I would also like to add that in the software-ABMC prototype I made,
because it's based on assignment of a small number of RMIDs,
assignment results in all counters being assigned at once. On
implementations where per-counter assignments aren't possible,
assignment through such a resource would be allowed to assign more
resources than explicitly requested.

This would allow an implementation only capable of global assignment
to assign resources to all groups when a non-empty string is written
to the proposed file nodes, and all resources to be unassigned when an
empty string is written. Reading back from the file nodes would tell
the user how much was actually assigned.

Thanks!
-Peter

