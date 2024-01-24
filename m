Return-Path: <linux-kernel+bounces-36682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B5D83A4F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5724D28CB10
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A27617BD6;
	Wed, 24 Jan 2024 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OWjdUa2N"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6217BB5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087559; cv=none; b=ObWkbUt2m/uKGOCROjLKUGwlJTFv7Pz+Ed3SkbJsP5ElxxJqih6FTrjPH9GMbB5rZG0z3ulpAAhxDl9QHyw7U7U7ndm8X3mNZBF+94fi3z8+rS9ZO9DcoqcM4owW5iI+pi+30EllPx3Y+QItLv526Yw3twaOCCIv2oUw8Xu9xPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087559; c=relaxed/simple;
	bh=sg2x6RglKOa/ZHOjgcmXB6to1BOsPavab2cnbypTlek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmdXOSCVNzW3J4MMp1rEWPZ/UhElb12dN8fvOE/mS0MZiNRr3Uut4PX9ZNDSknL+0L7WZ0RYznAJWEBDTt8cmUP+bIOEEp5swna8+TyGEreTITlIPMCVI+ZHHCPgH9a9XtZQ+uE8pbcqI1n9FGmhk1MHvCqXFrgKBnK2bTNgbkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OWjdUa2N; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51008c86ecbso1790657e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706087555; x=1706692355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDGWWvngYrXMHFwGpStoErGRJgClfXa6zjwKTrnmtoY=;
        b=OWjdUa2NIhXeHySf7Qo3s8I5abVSICUB85/n9bqnTNODGNQGCSRu9LQUSfZxCuci9A
         +u6v4QLNnMzf2CvM2wLCx5E3LnIPHcf5bx2oQ2Hbo2PykI0/TYt8TEdwjvvyTAb1zGdM
         MYbJDI7IRElZf8UbDaAL4G4to9r8sfMg7nQMsmq7BsqHsgwx2fVjN9PulhSVOZuJtcqS
         bnRka8WonoiEE3K/Uu+aa99a/3qvJHnU9KrubvDQSFkY69q/w/cPkFxI9X/EBwPM1aTW
         BzGagcYs/yWELYCmbKG7ofY1Cewcyer9IMlK6Tyb/drzp8+Kbd6/l1XkSjxq37H+FDsa
         t2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706087555; x=1706692355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDGWWvngYrXMHFwGpStoErGRJgClfXa6zjwKTrnmtoY=;
        b=h5S+zAMJFpDnyY9BsEE4fOAYu6XLuzKb4OIjHKmS3B1oDhdBuJmaOGnbInQ+h/SHLI
         Z5PykSfWMQ6b0TWfkeBbpehUM9cteDKDnp4WN1WUdYUEzW2V8Y/Jp4cxf4gL8YbgdiLS
         w+b28ie5SsIfhLQU5igalmoTLmNkyUCTNsvlmwvi0k12cGDx5X2HicSBjram/KhDqbvC
         4U4edX08klgExTImfaKE5x1GweH6eH6FMruVF/HRr6oU+nsgcB7e4b+xjecfFvoORs32
         OcO9kqU8UROhrGUZt6hNnJ97BOsrGpbRoYE56R+V/AtEcr8DHLQ2bu3yETboW2waPzl2
         y84A==
X-Gm-Message-State: AOJu0Yx081xrEddHuxN4+USLvNEljJFUmfZ3UOrmGY8bDKftS+NmfILA
	aZE6kYVlThx634ry7/fGNe1xhXeucPbvkYmm/E+zAJmGeV/BSONqani2wRWcMDtKAu0P2LIX4z9
	hqo7luVcsA8TXIwctdlp6QD2e4UtmOIyKZjnX
X-Google-Smtp-Source: AGHT+IFfLbd/FARYk6hM3cTdPgBQ12QvsaQkut9PupCddCOicPnR9Oc8j2wvTSCWe9Y4/ZeUwERHZdpt7K9X51TdCA8=
X-Received: by 2002:ac2:5384:0:b0:50f:732:c4d5 with SMTP id
 g4-20020ac25384000000b0050f0732c4d5mr2849591lfh.64.1706087555324; Wed, 24 Jan
 2024 01:12:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401221624.cb53a8ca-oliver.sang@intel.com> <CAJD7tka0o+jn3UkXB+ZfZvRw1v+KysJbaGQvJdHcSmAhYC5TQA@mail.gmail.com>
 <Za9pB928KjSORPw+@xsang-OptiPlex-9020> <CAJD7tkYtKdLccKbFVoVo9DH8VtHHAXNMEz5D-Ww5jHhDy-QxbA@mail.gmail.com>
 <ZbDJsfsZt2ITyo61@xsang-OptiPlex-9020>
In-Reply-To: <ZbDJsfsZt2ITyo61@xsang-OptiPlex-9020>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 24 Jan 2024 01:11:59 -0800
Message-ID: <CAJD7tkYdvnOhj4a_mzx-w9Zzx8Eg8zFjQxi2+kxR0hD05b3GTg@mail.gmail.com>
Subject: Re: [linus:master] [mm] 8d59d2214c: vm-scalability.throughput -36.6% regression
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, Shakeel Butt <shakeelb@google.com>, 
	Chris Li <chrisl@kernel.org>, Greg Thelen <gthelen@google.com>, 
	Ivan Babrou <ivan@cloudflare.com>, Michal Hocko <mhocko@kernel.org>, 
	Michal Koutny <mkoutny@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Waiman Long <longman@redhat.com>, Wei Xu <weixugc@google.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, ying.huang@intel.com, feng.tang@intel.com, 
	fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 12:26=E2=80=AFAM Oliver Sang <oliver.sang@intel.com=
> wrote:
>
> hi, Yosry Ahmed,
>
> On Mon, Jan 22, 2024 at 11:42:04PM -0800, Yosry Ahmed wrote:
> > > > Oliver, would you be able to test if the attached patch helps? It's
> > > > based on 8d59d2214c236.
> > >
> > > the patch failed to compile:
> > >
> > > build_errors:
> > >   - "mm/memcontrol.c:731:38: error: 'x' undeclared (first use in this=
 function)"
> >
> > Apologizes, apparently I sent the patch with some pending diff in my
> > tree that I hadn't committed. Please find a fixed patch attached.
>
> the regression disappears after applying the patch.
>
> Tested-by: kernel test robot <oliver.sang@intel.com>

Awesome! Thanks for testing. I will formalize the patch and send it
out for review.

