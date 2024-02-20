Return-Path: <linux-kernel+bounces-72733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380B385B81C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C091F219A2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8756773D;
	Tue, 20 Feb 2024 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeBqHjf4"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D56774E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422352; cv=none; b=ldM+58xKBD+WbcB6nm2nYFMVEtZA0zXMTpI9K2oXz+PxNfl/qgu5OqMzqPHrr7vw19gm8TV7Z+kyR4xhzEhArzu0SOCsLOITowHSpEvBQHWiZgTF0wcUwvp4XoCx/sXZi73Y805WJeeermdRcC4D9bDkvmWi7OQvzg8zdrbxpwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422352; c=relaxed/simple;
	bh=jm0SHe88cAJSq1CGFZHc3TOVj/G24rDIuiTnAF/JZto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpLL97PyxmF3dEHlxLng/fid05HPQFdg6w/tuXv4+hnFOvMUMNIuWnzZF+w65C/SzofwCfIeg3f2UB8i/vva4oEXNzlpLURjfMCtUCYwvpokspm3+BzC5tciI5aWY9qN4QtU6n0TD38JfYyKSd8624HYAAHuzUa9RCXbqQYJ7VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeBqHjf4; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512be87a0f3so1508618e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708422349; x=1709027149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHyj07uLVXJcBsbcgmGTKkOhm7lqfKjgr9KR/k4BgLc=;
        b=IeBqHjf4DtQz+WytM2BIas3K8ctfy9EUHm5psIVzYivt5NGlgA2cOBZwgoAp3LcwnK
         3OlaOPdyK7S0hWnTyMqPbId2uOggEq12XSFR0fUESffiCZ4yBHDRHHBcu7z/ihj0YaYE
         9VErHL0awy9IrAoMojHbq+c5Wqa+FAogcqG0t+UokkDFTfhiTsoy3NSceKwf92gR4QwK
         YcPvr6AcbeF0C+HuCJlc+R3iIcwOtbsDXnVbn00MN7lt5zsQd2pbEE85ph9X7uSM39Jb
         k93lnzOx5TMzn2ZaPgQh9CTFJNIN2mmTj/bvp6E38ZHHa9pPMrGEfpvHviUKQ65iK5nv
         OgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708422349; x=1709027149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHyj07uLVXJcBsbcgmGTKkOhm7lqfKjgr9KR/k4BgLc=;
        b=SyKMhDVaQEhdDA4A8WkTOkYEKPN9Iq2NZ5+Gpr2WvhaMM3eAFaaRZomNgnI6mN+fNY
         fBXnmOa9OHv8CGUI5R6ZiiVsPnrUAzRpMwKTAi10Re73n7G+/8Oa59/64aW8x3z8qBZF
         3qTMMb7GXoGIwULm9W+c/ySQi1Dkgc83VnXjWNzr4OwiWjIgOUJTACmEFMawFNJ6zHA8
         Q1lgNi9FPhstlzLYgJ65HF1i4jxlS9XezhEFd6JC6EQD8sCSdOYKg8GgueZ53xtbk+Mw
         pbkDVAbv1hCO8cqr0DtSi2aw7ytGzmAQ7wfGD+0DhPQbXh5dvz99lr6hKDHYkEgMZnuD
         eBQA==
X-Forwarded-Encrypted: i=1; AJvYcCWppKSUTXv2Ldht+62rwl7J3DsKzw3YruAK+KUOqY6tlV3CzBBuMFdp7BOjEEtsNj6VPBoyh12MJyTpr5hCcn5zWE9TjYxBjNflcjq5
X-Gm-Message-State: AOJu0YyZQzBJolBk0X57DusSS5c4IP4VXikWuKphdw5NJrQqn3f2Omwx
	Fuok73ozWATdjdfKAgAFx8ipQMCl/YFyfrwWvmIG3Q0pgawkSRhzgwrYBpIZIzCklFkf5+M06E4
	YJs0pfA4N0rNqaw1V1TO1oEsPFA==
X-Google-Smtp-Source: AGHT+IHl4ezSlLgTZQs5G2nw2vQKKtig2O/6ZkTZZp3VSK8CfuOTB+Xb9h8iRXkVtYqOSdN+f+5Lmpd0MaiReG88BDE=
X-Received: by 2002:a05:6512:3f1e:b0:512:c8e0:5a27 with SMTP id
 y30-20020a0565123f1e00b00512c8e05a27mr841605lfa.39.1708422348495; Tue, 20 Feb
 2024 01:45:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219031911.10372-1-fangzheng.zhang@unisoc.com>
 <20240219031911.10372-3-fangzheng.zhang@unisoc.com> <ZdLX51r1mOEZKUje@casper.infradead.org>
 <CA+kNDJ+C2b520afauSWbfNK=S1XiNHR_zF32_K-3Rf7R6m3n5Q@mail.gmail.com>
 <4591b2b3-398f-402e-b21d-55b244f05a2e@suse.cz> <CA+kNDJLCEdeQsaaLggxbUzF4mAqk_ZLKe=o3cnRkZO8_EKhoSQ@mail.gmail.com>
 <60edefec-0a78-4c23-bfb6-17ebf326c61a@suse.cz>
In-Reply-To: <60edefec-0a78-4c23-bfb6-17ebf326c61a@suse.cz>
From: zhang fangzheng <fangzheng.zhang1003@gmail.com>
Date: Tue, 20 Feb 2024 17:45:36 +0800
Message-ID: <CA+kNDJKVz18zm4F8fBVjDveLAdP49ZZUrBrAosq5ng1wYHaFgQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] Documentation: filesystems: introduce
 proc/slabinfo to users
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, Fangzheng Zhang <fangzheng.zhang@unisoc.com>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, tkjos@google.com, 
	Yuming Han <yuming.han@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 5:21=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/20/24 09:49, zhang fangzheng wrote:
> > On Mon, Feb 19, 2024 at 4:09=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 2/19/24 07:23, zhang fangzheng wrote:
> >> > On Mon, Feb 19, 2024 at 12:24=E2=80=AFPM Matthew Wilcox <willy@infra=
dead.org> wrote:
> >> >>
> >> >> On Mon, Feb 19, 2024 at 11:19:11AM +0800, Fangzheng Zhang wrote:
> >> >> > +Note, <slabreclaim> comes from the collected results in the file
> >> >> > +/sys/kernel/slab/$cache/reclaim_account. Next, we will mark /pro=
c/slabinfo
> >> >> > +as deprecated and recommend the use of either sysfs directly or
> >> >> > +use of the "slabinfo" tool that we have been providing in linux/=
tools/mm.
> >> >>
> >> >> Wait, so you're going to all of the trouble of changing the format =
of
> >> >> slabinfo (with the associated costs of updating every tool that cur=
rently
> >> >> parses it), only to recommend that we stop using it and start using
> >> >> tools/mm/slabinfo instead?
> >> >>
> >>
> >> Hi,
> >>
> >> > The initial purpose was to obtain the type of each slab through
> >> > a simple command 'cat proc/slabinfo'. So here, my intention is not t=
o
> >> > update all slabinfo-related tools for the time being, but to modify
> >> > the version number of proc/slabinfo and further display the results
> >> > of using the command.
> >>
> >> I'm not sure you understand the concern. There are existing consumers =
of
> >> /proc/slabinfo, that might become broken by patch 1/2. We don't even k=
now
> >> them all, they might not be all opensource etc. So we can't even make =
sure
> >> all of them are updated. What can happen after patch 1/2:
> >> - they keep working and ignore the new column (good)
> >> - they include a version check and notice a new unsupported version an=
d
> >> refuse to work
> >> - confused by the new column they start throwing error, or report wron=
g
> >> stats (that's worse)
> >>
> > I generally understand your concerns about modifying patch 1/2.
> >
> > But judging from my modifications, this worry does not seem to be valid=
.
> > Because the =E2=80=9C/proc/slabinfo=E2=80=9D is not used in related sla=
binfo debugging tools
> > (such as tools/mm/slabinfo),
>
> Hi,
>
> we are not concerned about slabinfo debugging tools that are part of kern=
el
> source tree, but about those outside, including those created privately a=
nd
> we don't even know they exist.
>
For your concerns, I think the supplementary introduction that new
output results
of slabinfo v2.2  in patch 2/2 will be necessary. This can help them
optimize their tools
more quickly to adapt to proc/slabinfo. Is this more friendly?

> > but "/sys/kernel/slab/<slab_name>/" (in
> > Documentation/mm/slub.rst) or "/ sys/kernel/debug/slab" (in
> > tools/mm/slabinfo.c).
> >
> > Furthermore, the current modification only involves optimizing the outp=
ut
> > of proc/slabinfo,
>
> It's not "only", the output of /proc/slabinfo is what those tools consume=
,
> so that's what concerns us the most.
>
> > and does not modify the  struct slabinfo or struct kmem_cache.
> > So there is no need to adapt other modifications.
>
> These on the other hand are internal details of the kernel which we can
> modify as much we want
>
> >> >> How about we simply do nothing?
> >>
> >> Agreed wrt modifying /proc/slabinfo
> >>
> >> > The note here means what changes will occur after
> >> > we modify the version number of proc/slabinfo to 2.2.
> >> > As for the replacement of tools/mm/slabinfo (that inspired
> >> > by Christoph=E2=80=99s suggestions), it will be implemented in the n=
ext version
> >> > or even the later version.
> >>
> >> So what is your motivation for all this in the first place? You have s=
ome
> >> monitoring tool that relies on /proc/slabinfo and want to distinguish
> >> reclaimable caches? So you can change it to parse the /sys directories=
 Is
> >> it more work? Yes, but you only have to do that once per boot, because
> >> unlike the object/memory stats in /proc/slabinfo, the reclaimable flag=
 will
> >> not change for a cache.
> >>
> > The situation as you mentioned is very suitable for my current needs.
> > My original intention is just to get an intuitive slab screen through a
> > simple =E2=80=98cat proc/slabinfo=E2=80=99 command. As for the descript=
ion "<slabreclaim>
>
> That would be nice, but again we must be careful about existing consumers=
 of
> /proc/slabinfo so we can't always have nice things.
>
> > comes from the collected results in the file
> > /sys/kernel/slab/$cache/reclaim_account"
> > may not be appropriate. Here I want to express that the column <slabrec=
laim> has
> > the same effect as traversing "/sys/kernel/slab/$ cache/reclaim_account=
".
> >
> >> Would tools/mm/slabinfo almost work for you, but you're missing someth=
ing?
> >> Then send patches for that in the first place. Changing /proc/slabinfo=
 (and
> >> breaking other consumers) for a quick and easy fix with a different so=
lution
> >> planned for the future is simply not feasible.
> >>
> > Using the slabinfo tool to parse /sys/kernel/slab/$cache/reclaim_accoun=
t
> > is what I think about optimizing future tools during the discussion.
> > It will not affect the current patch 1/2, and patch 2/2 is mainly to
> > supplement the output examples of proc/slabinfo.
> >
> > If the community is willing to accept it, I will only modify
> > patch 1/2 to implement it.
> >
> > Thanks very much!
> >
> >> HTH,
> >> Vlastimil
> >>
> >> > Thanks!
> >>
>

