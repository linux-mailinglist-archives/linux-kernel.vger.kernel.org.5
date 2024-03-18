Return-Path: <linux-kernel+bounces-106671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232BC87F1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FA22823B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D2658137;
	Mon, 18 Mar 2024 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="V9e06hcS"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF530535D3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796167; cv=none; b=fua1E46GEhR9Qu2UKi4zTbNkrVaIGZ2/ICrzTHKKiSb0HbOLlvhFa/q8jGpOEYhlMTASx3m5LXwF62Aw1HazFmzBEJsY98NtJ0sjLVTU4jK+xXKXDXKYtbaKu8S5m+FyixeLv4S0+OY7tvfKyyeAv8fyjqlO0rpLi+PdmXz9Un8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796167; c=relaxed/simple;
	bh=C/Puvl79m49Cnp0XGqjFPs+46qFbmpop8duIGHpg/9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3RL6DPM839RDmh/TlhMERJTbhYUUChBT/360YYbt2sMjpCVhtqw6ualIjp26B2iA6i6c22N8n1nnS4sJcl3aTf+sRBUGmbjuLOjyjcrcshSf+EXxdnLd/ND/HF+YKg3/33LBJvSeOQtGl4Edv4T6/RejUNRwtyxC3k/QyCrBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=V9e06hcS; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78a0ab10316so72191485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710796162; x=1711400962; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FOqxWMcGpNyg6Z0UKe89d8UtFLAlVDl2Ge9RAirWCRg=;
        b=V9e06hcSG9QVHvilkhymeyCrDdZKxsSj0hf+ky4aYbz224OR+jLWm6eN2bUrya8ll0
         WADLkWJvURN/Y8G6dudPbGEtJYSN+qUpT12a9rXM860i/AMsCXqExtjkwV2fhS8/Mcr+
         GV/E5YSSdKTfr5WnX2UW8Xz7URxih4pLRPNghOGKD0qKlxlR3QJt9LJiVeDcS+FYwVBc
         prmlvPgT4fAgfGSbPyJQhKmYiG6o5eD+Ssrvp6r2gw/tTdXW/OIoyNoNVDCPc2r0paJ3
         KXTY7sx+nx7miJouJymhEgknc0g+6FPUIY59YryBbCOu48RsjxtOjk7INH8EQljr0WZ1
         i6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710796162; x=1711400962;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOqxWMcGpNyg6Z0UKe89d8UtFLAlVDl2Ge9RAirWCRg=;
        b=Agwb9t96G79UkY9lIGT3hRhGrUfTgvItTq7hcRWv8+MTJ9YvggNNkm2rAMUwdYxqsU
         WEcCpQr7yvKPgOFmBE7XLYNEzmNl7Ja8oeFa93M3RZxZ5NzrOap1atKKftgW1DgbPz1a
         ONwPiPMy58lRntHh7T/Wz9J+YDQI/W7OfJjYT6odj1+lwWLp2gDI4RpqRV5BFLuT0Pha
         AVVUsepnZdOFUmDeWn2ARrM45n0wPdqcQNL6WTp+h/DpetTBXUHRZNU7duifVYSlsXs/
         YBQTnLGiwcQwaVgsDnNOJ22CP4hbEA+9/+s0JMNozHDzOwN/BGTRLnjjz8DFTHiYCTAH
         CPrw==
X-Forwarded-Encrypted: i=1; AJvYcCVfCjoh9oio81y5/fPdCQWEjHV/fMOQvV8HX2QgRclJWJ5bXHF7kJHBsdoxM1gJzAwBq6Cx9hUpF3+cU8CWIXvnqGZa/Cp5FkhDw2K5
X-Gm-Message-State: AOJu0Ywegcz1Z5xyvBTxjAh4UcVQYq2MdazL9ZI55IyH+ea9FreszJkd
	w0Pzi6zsyJdhBJCpD69ZOnW19RSRfR6RPPrtW7gJdHYqrtOd4OjGUHERgCloH44=
X-Google-Smtp-Source: AGHT+IGmezNd7Y22mqc+VPK+jo40NclSbGwKc23t/x+1Yd4e03ws0PD4BlmbAFcaD9ucT9vdpExrYg==
X-Received: by 2002:a05:620a:1722:b0:78a:3c3:a629 with SMTP id az34-20020a05620a172200b0078a03c3a629mr1486052qkb.23.1710796162650;
        Mon, 18 Mar 2024 14:09:22 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id f18-20020ae9ea12000000b007884dd207b8sm4816696qkg.55.2024.03.18.14.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 14:09:21 -0700 (PDT)
Date: Mon, 18 Mar 2024 17:09:17 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>,
	syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
Message-ID: <20240318210917.GA4210@cmpxchg.org>
References: <000000000000bbb3d80613f243a6@google.com>
 <CAKEwX=MAX0km1p43DQmKbeSy2G4dPFHiF+deH_qzqygc2Vnjig@mail.gmail.com>
 <CAJD7tkbEuFkGuQeYjKS02rQoAAKOKieAJ1P2mwukirW3e2JN9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbEuFkGuQeYjKS02rQoAAKOKieAJ1P2mwukirW3e2JN9A@mail.gmail.com>

On Mon, Mar 18, 2024 at 01:17:19PM -0700, Yosry Ahmed wrote:
> On Mon, Mar 18, 2024 at 11:00 AM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > On Mon, Mar 18, 2024 at 9:58 AM syzbot
> > <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-09-36' ..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=13043abe180000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=19bb57c23dffc38e
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=adbc983a1588b7805de3
> > > compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > > userspace arch: arm
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1706d231180000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ba7959180000
> > >
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-e5eb28f6.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/0a7371c63ff2/vmlinux-e5eb28f6.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/7539441b4add/zImage-e5eb28f6.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
> > >
> > > ------------[ cut here ]------------
> > > kernel BUG at include/linux/scatterlist.h:187!
> >
> > Looks like the provided buffer is invalid:
> >
> > #ifdef CONFIG_DEBUG_SG
> > BUG_ON(!virt_addr_valid(buf));
> > #endif
> >
> > which is "src" from:
> >
> > sg_init_one(&input, src, entry->length);
> >
> > Looking at the surrounding code and recent history, there's this
> > commit that stands out:
> >
> > mm/zswap: remove the memcpy if acomp is not sleepable
> > (sha: 270700dd06ca41a4779c19eb46608f076bb7d40e)
> >
> > which has the effect of, IIUC, using the zpool mapped memory directly
> > as src, instead of acomp_ctx->buffer (which was previously the case,
> > as zsmalloc was not sleepable).
> >
> > This might not necessarily be a bug with that commit itself, but might
> > have revealed another bug elsewhere.
> >
> > Anyway, cc-ing the author, Barry Song, to fact check me :) Will take a
> > closer look later.
> 
> I am not a highmem expert, but the reproducer has CONFIG_HIGHMEM=y,
> and it seems like zs_map_object() may return a highmem address if the
> compressed object is entirely in a single page to avoid copying to a
> buffer:
> 
> if (off + class->size <= PAGE_SIZE) {
>    /* this object is contained entirely within a page */
>    area->vm_addr = kmap_atomic(page);
>    ret = area->vm_addr + off;
>    goto out;
> }
> 
> The virt_addr_valid() check seems to indicate that we expect a direct
> map address in sg_init_one(), right?

If the page is highmem, kmap_atomic() establishes a temporary mapping
to it in the direct map, such that we have a legit kernel pointer to
the memory. Otherwise the memcpy() in zswap also wouldn't work... Am I
missing something?

