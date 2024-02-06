Return-Path: <linux-kernel+bounces-54565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B39E84B0C7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBA21C2373B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A6512C811;
	Tue,  6 Feb 2024 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrJhd4B6"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E241F12CD85
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210548; cv=none; b=WVYDXmfUOVSMpN9J73PsI6tyrE3ZMZG3+UyQFtSRdKFGsQcN5/rpMc69CiM7kuKzc3A1Ga20o1RRd29hcgl9awpG4k0qq55eHlfeDLtDRORSMBWMDO8ByD8/O3932RfI2S6qaDGyFNYYb6vTK1CPojLbELZh+ayS2ws2+gV097g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210548; c=relaxed/simple;
	bh=JfmFBJ8uFPBab88o46myXeib2a4j3O4syxAhuZFSsrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JE262XZoWmtRNAXEbCJhSZ6N4KuALPMMrGBXOe0PzkDr1xUMuDwjQZaQHw8zRbeYg2nrLA4XeMvYrIcAJwyd1VaqIZm9/69Rhjv035LDEnEZ7yKVsOowAFTgrZDVzaM8NENvnzoa0B1I1/lGwm1AaeFfDSZ61Ja3droNxdOj9TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrJhd4B6; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d090c83d45so39847651fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 01:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707210545; x=1707815345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3bYfjQv3EOlzlAH6SnTprc6MRzkybq6MP8ULvKh3QU=;
        b=BrJhd4B6Fkz8rjzkl8S5hR2NDsMMz3NPOeRwIFdmqKZxn6AHg7DM9XBGXpspIgJO1h
         DkDfIuPTeZqkuVl5Jha3nE/U7CU4ZU/txyAWhrkpBi92x22FRN3B6LsEMWzLWrB2WM5k
         zR1JNaWdFQu9/31w3DSD5ebtxeOevPmJq5PGa/ei+XEpO1B4hadqIcw2hYp+Ry7ers2Z
         4Se5FJw9QnWcBf2QyTi/dZgGx0kHqjFlwP9Plooa/DmumtiZNMJHOmbWlp9OZUIF10CF
         FWUd3dCJXzNP+btqIVP7V1Xm/cjWtWNSI3uQu4p3+JhXnSfqFAQv7xttDigHI01Y95rQ
         p3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707210545; x=1707815345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3bYfjQv3EOlzlAH6SnTprc6MRzkybq6MP8ULvKh3QU=;
        b=rP4btxhh7KGxI2wghn8fXvP94HFO84zyaSOFx/gv38H9mM7YTyUxTG7UrbC6pH1pF9
         k5iJfVvvBkZs051Edf/WuynbICrlIZuFrUQhJjQEkcgtrGTW71ZVbQcAay3VeiL4rMfc
         M2USsCcH4/ZjLoBnA8d7YRLFj/vyXm5Ghlk6i2ND+hc6dcPW7c0bsmNK6nfprWEO0EKt
         woE74q/xXT7LZejWahqIB7dmyFmxGVTlapYOIS5HdFhHJ6OGSflCNiIBiFOPTrrPEabV
         n9YX9IOKpG0d935IRkMFdQWZeXhAxuXYrZZ+o1a+qBHDtoP4raKcq5p8ioJULItoVT4+
         MMaw==
X-Gm-Message-State: AOJu0YyfWHtX5d0QC3KFsW8+7YpOd5jY+eJUKIZa/xHQshSrhEtuOouF
	Gabdx3dCYrdlaqejep5w0gQcz3CpQWoGLb90+3fYQQvU6fablifT2wsAS0oGHr0R2KEloxliwGa
	8pmYSuzSxbNDh1mdLWzlLQPKunQ==
X-Google-Smtp-Source: AGHT+IGYvvPPJdsNReDALgL4bf4CddTEvWD64Y89A60pb0Wv4pCnc6aQ+IjbSJcarg4fKsvCTx541JtYLFO+ZrdbChk=
X-Received: by 2002:a2e:9d05:0:b0:2d0:9cbf:f389 with SMTP id
 t5-20020a2e9d05000000b002d09cbff389mr1491170lji.26.1707210544507; Tue, 06 Feb
 2024 01:09:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131094442.28834-1-fangzheng.zhang@unisoc.com>
 <2024020441-version-chihuahua-1067@gregkh> <2f43774a-16cf-412e-b4b7-840889bb796b@suse.cz>
In-Reply-To: <2f43774a-16cf-412e-b4b7-840889bb796b@suse.cz>
From: zhang fangzheng <fangzheng.zhang1003@gmail.com>
Date: Tue, 6 Feb 2024 17:08:53 +0800
Message-ID: <CA+kNDJJAQ8FP5U+SJWRAvhqEfbmmqkNpOKVk9SC66q-auCPg0A@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: Add slabreclaim flag to slabinfo
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Fangzheng Zhang <fangzheng.zhang@unisoc.com>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yuming Han <yuming.han@unisoc.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 4:50=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 2/4/24 14:09, Greg KH wrote:
> > On Wed, Jan 31, 2024 at 05:44:42PM +0800, Fangzheng Zhang wrote:
> >> In order to enhance slab debugging, we add slabreclaim flag to
> >> slabinfo. Slab type is also an important analysis point in slabinfo
> >> for per slab, when various problems such as memory leaks or memory
> >> statistics occur.
> >>
> >> Signed-off-by: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
> >> ---
> >>  mm/slab_common.c | 7 ++++---
> >>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> index 238293b1dbe1..aeeb2bfe6dda 100644
> >> --- a/mm/slab_common.c
> >> +++ b/mm/slab_common.c
> >> @@ -1038,7 +1038,7 @@ static void print_slabinfo_header(struct seq_fil=
e *m)
> >>      seq_puts(m, "slabinfo - version: 2.1\n");
> >>      seq_puts(m, "# name            <active_objs> <num_objs> <objsize>=
 <objperslab> <pagesperslab>");
> >>      seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
> >> -    seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>=
");
> >> +    seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>=
 <slabreclaim>");
> >
> > Doesn't this change the slabinfo version number above?  Where is this
> > change documented so that userspace knows about it?
>
Ok, I will  modify the slabinfo version number to 2.2 and I find that
there is no corresponding slabinfo output example in the proc.rst
document. Can we add an output example so that user space knows about
it?

> Yeah I was vary about this. Do the other longer-time-than-me slab
> maintainers recall how we handled this in the past?
> Also the information is already available, even if harder to gather, in t=
he
> file /sys/kernel/slab/$cache/reclaim_account
>
First  of all, thank you very much for your comments.

I would like to say, when performing slab memory information
maintenance, people often hope to see more detailed information
through a simple slabinfo command. As you mentioned the method, but it
is very unintuitive to the status of the entire slab, so we add the
slabreclaim column to slabinfo and directly output it using cmdline '
> cat proc/slabinfo'. And I think this approach will also be helpful
for future work on memory statistics.

> > thanks,
> >
> > greg k-h
>
Thanks.

