Return-Path: <linux-kernel+bounces-31600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEE683309D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09661C21FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD8258AA7;
	Fri, 19 Jan 2024 22:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zaamc4vn"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FEB5821B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705701931; cv=none; b=VRrq8TMGssaPUKHsGEyvYWDD0Tg2nTuFO+G6fX5joN4ejUuDdJkSCzsp4deWTYR6aqBbpjquas5XZDFQgXfHE6HSRxdo60/rR9r0LCtIS26lFmcpe7CGCGr0uuye7KYhRpOmrZWkBOO06AiDLbyQuTrA16d22WrJ7XLH8Dp3pM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705701931; c=relaxed/simple;
	bh=UQXwQGL/HDuBjtd5amb957DXoIZhwnRlQ/ng0lHg8No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlAczvS4N2iVlavlU0mGc98sU4sFUKZUHfBTm/e68weNtUbANt0dWEfrQ6PPRdbmFsi7K97TFaGtpXSNyzhWOFEibzzXNNgO3rkiXmN+mYVcTQdFWIyrzlZvlBdA272rilfZO/EuQ/80cpg2M/+OemJ0IBcS+bEu+yOyIUKYXmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zaamc4vn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d72d240c69so9775ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705701929; x=1706306729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcqiSEcoYgqBFy3M3rxFDqHUdxfZAYfETLPVBl9KYqg=;
        b=zaamc4vnm2vlnPBNbkysvrxneSusrUURhWRqEe8isHTx1/fyBdjwUd6dUZdNiNEIsF
         DP7RDD12DWbzzqeaFhTwXFqoQbC3t1G6VeIthTkGHORJEOtpnfn11acdTqZleV7mmwi7
         DDm8dMUrjNgXGxqRC8UQ2PL6+o49Be/AtkzMiqjdF4sZc5JpyC/3wlpO/YJk7Uqp/Men
         7pvwyJ9mvWhBKMWhy1cRFIj/vyn8dZq+1ERhlk8QSJWKpDxwWARfKN7ByCp79EALwFNE
         MzVr+1wYwZVmShun0k1EAOaz1DkWpyx97wVAPHFFRmFg5chZBe96kX4NGF01C1z1sBoD
         SYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705701929; x=1706306729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcqiSEcoYgqBFy3M3rxFDqHUdxfZAYfETLPVBl9KYqg=;
        b=NHR7GTKub2W6w1GWEQtap8Su+Rmz7mWDdJh9nBbFEvpBqKbEVYL0+X/p+dE8xuTGHQ
         Y9LYnQR6fzuwZJTGVJBXeEDDVjDQBXQe2HhHQyWbZwUswo8Lqpo+57Ul2GNF+cuO8VJ+
         BabgF9HfdCxNxCbj4LTMjtKtPCFwNtIIH0yKuEVGxctfEzvNr07uBQBTphbZ+pu2B30u
         y3bpBrtTYiVJITf30/Zy3LzX3vdkwwkVICJQ5lgEhnTnDgjasLgzinI0+dL1WrTiHkvK
         exvzlxdVNIEpco6p8zD/7e3Cw9GnSV6Y5MLGQvoRcZP/M5GxpQcgWm6jc2k7HdGS6R+4
         r9KA==
X-Gm-Message-State: AOJu0YyKMiseYn5LCQ/TGTuSByJZl3bPIAI0o8xDOQLx+muq3l8Xte93
	/zhf55/OjQdkzWc/XqFNGgxeSEYELqJM6eaw3n5t6z990hlIvv2+8757MG89+yrVCSgsyxD04nJ
	Zh19P+Yr6RZXyc6dZC5lV50rJcnE5YlAPPzor
X-Google-Smtp-Source: AGHT+IGwHpdwosv3/8JaV7etGUTT6zcdFVNwyg/24pFXqCS4kE4EcgUVWe2AFXQNr/egbD+GyROdR9a0g1EqNtTcn2Y=
X-Received: by 2002:a17:902:854a:b0:1d4:c058:6450 with SMTP id
 d10-20020a170902854a00b001d4c0586450mr23378plo.29.1705701928906; Fri, 19 Jan
 2024 14:05:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117141405.3063506-1-amitsinght@marvell.com>
 <20240117141405.3063506-14-amitsinght@marvell.com> <CALPaoCjf_A5SOr8L+0WMePW02Pzj9nnPT0JLZ_+232vvfEzGCQ@mail.gmail.com>
 <MW4PR18MB508449310648615886A8113BC6702@MW4PR18MB5084.namprd18.prod.outlook.com>
In-Reply-To: <MW4PR18MB508449310648615886A8113BC6702@MW4PR18MB5084.namprd18.prod.outlook.com>
From: Peter Newman <peternewman@google.com>
Date: Fri, 19 Jan 2024 14:05:17 -0800
Message-ID: <CALPaoCi1xABN+7LL4Xyi4Se87f8PM8769KiyZkzTESurZSyDqg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v1 13/14] arm_mpam: Handle resource instances
 mapped to different controls
To: Amit Singh Tomar <amitsinght@marvell.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"fenghua.yu@intel.com" <fenghua.yu@intel.com>, 
	"reinette.chatre@intel.com" <reinette.chatre@intel.com>, "james.morse@arm.com" <james.morse@arm.com>, 
	George Cherian <gcherian@marvell.com>, "robh@kernel.org" <robh@kernel.org>, 
	"dfustini@baylibre.com" <dfustini@baylibre.com>, 
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[CC Tony Luck]

Hi Amit,

On Fri, Jan 19, 2024 at 5:01=E2=80=AFAM Amit Singh Tomar <amitsinght@marvel=
l.com> wrote:
>
> Hi Peter,
>
> Thanks for having a look.
>
> -----Original Message-----
> From: Peter Newman <peternewman@google.com>
> Sent: Wednesday, January 17, 2024 11:33 PM
> To: Amit Singh Tomar <amitsinght@marvell.com>
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; f=
enghua.yu@intel.com; reinette.chatre@intel.com; james.morse@arm.com; George=
 Cherian <gcherian@marvell.com>; robh@kernel.org; dfustini@baylibre.com; jo=
nathan.cameron@huawei.com
> Subject: [EXT] Re: [PATCH v1 13/14] arm_mpam: Handle resource instances m=
apped to different controls
>
> External Email
>
> ----------------------------------------------------------------------
> Hi Amit,
>
> On Wed, Jan 17, 2024 at 6:15=E2=80=AFAM Amit Singh Tomar <amitsinght@marv=
ell.com> wrote:
>
> >
> > +/* Club different resource properties under a class that resctrl
> > +uses,
> > + * for instance, L3 cache that supports both CPOR, and DSPRI need to
> > +have
> > + * knowledge of both cpbm_wd and dspri_wd. This is needed when two
> > +controls
> > + * are enumerated under differnt RIS Index.
> > + */
> > +static void mpam_enable_club_class_features(struct mpam_class *class,
> > +                                           struct mpam_msc_ris *ris)
>
> It looks like "club" is used as a synonym to "class" here to evade the bi=
gger issue that mpam_classes are not defined correctly as DSPRI resources s=
hould not be in the same mpam_class as the L3 CPOR and CSU features.
>
> This hardware makes it clear that the definition of mpam_class as all res=
ources in a (level x {memory,cache}) needs to be revised.
>
> On Marvell platform, DSPRI control register (MPAMCFG_PRI_NS), and Identif=
ication Register (MPAMF_PRI_IDR_NS)  are implemented within the LLC MPAM bl=
ock (the address range contains control and identification registers for CP=
OR, and DSPRI), and therefore we treat DSPRI as one of the L3 resource. How=
ever, suppose we approach it as totally different standalone resource type =
(PRI) other than Cache storage resource type (CPOR, and CCAP), and define a=
 new MPAM class type for it, there is no standard way to discover this new =
resource type (PRI) from ACPI tables.
>
> I'm concerned about accessing DSPRI related registers, if we are going to=
 tide it to new MPAM class (as we discover whole L3 MPAM block using firmwa=
re tables, and tide it's resources to L3 MPAM class).

This is becoming more of a discussion of MPAM (and resctrl) in
general, so I hope James can participate. Also I should point out that
when discussing MPAM, "resource" refers to a non-RIS MSC or a single
RIS-index on a RIS-enabled MSC, while the "mpam_class" structure in
the code is the counterpart to what RDT (and resctrl) call a resource.

From my reading of the code, the consequence of (RIS) resources being
in the same mpam_class is that they can be programmed uniformly
through a single schema line in the schemata file, so
__resource_props_mismatch() goes to work on eliminating any resources
(and extra control granularity) which are not programmed exactly the
same way. This function seems more geared toward big.LITTLE systems
where the cache controls on one cluster are dissimilar from those on
the peer cluster and would need to be normalized (James, can you
confirm?). But in this situation, it seems like a better idea to
present a separate schema for one cluster's controls from the others.
For example, "L2P" and "L2E", with non-overlapping domains.

In the case of an MSC implementing RIS, the controls are independent
by definition, so I can't see why the work done in
__resource_props_mismatch() would be applicable.

-Peter

