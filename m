Return-Path: <linux-kernel+bounces-109526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDACD881A87
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F63B282B01
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863461877;
	Thu, 21 Mar 2024 00:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K94BTkR+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED292622
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 00:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710982617; cv=none; b=c9wp2a4cLQ5GcPT13iMJcftfrNXC+x5I/wo4CNgdQWjpJaJLrQZeA8jxiF4IQ1H1qKw9u8bn+hYHmbMpaPVrRRj5FB8aeEDYSbES+VOMP/G3vhSiMr/8LM76KcP2utNnk1JgPaH5Lb2jDfwz9M8td4SEg0DA+Czq1yQd65t+Gg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710982617; c=relaxed/simple;
	bh=9ZnOG4t7XnKauVjt7NHBrdrVwADnleN7F5cXhVv47E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvzve5yNY3R+wqlzYf6iHwG5PCrvyYVJa0/NZHmlT53D8ndTqkgMkNAgDIZWPFrxJkbRgYWnzlI7+g5TLSqhTRXmOgFKZNKTvnXIszr8pMbB4mN6Zwgvns1SAf5SWk11HWc/EMM0TN2TY2cGPmqmbnlXQl40gEdZeAmtEx2pODE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K94BTkR+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710982614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7nyTfy4ZKS+0vxtvDTzpFx0ooSJsIqwsPGQDi44f8vU=;
	b=K94BTkR+SAlyB+ACQhq9OTPPESYOS7VkULA26lix/lfHIRZl+6zwfpUWf6iFvNEJLB9YQm
	B81XTuh+MaSq89ewiUbQ8n5ILaf2Oce29cBGTD3i72AfLCd+gBihKaFDAXE9CHtXvpjWPG
	Tm00rboAUGWqrVFa7Ko1DwC/Lmb+pzk=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464--pvvBiS3MAOLsa1hXQRX6A-1; Wed, 20 Mar 2024 20:56:50 -0400
X-MC-Unique: -pvvBiS3MAOLsa1hXQRX6A-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-366b311d172so1432345ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 17:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710982610; x=1711587410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nyTfy4ZKS+0vxtvDTzpFx0ooSJsIqwsPGQDi44f8vU=;
        b=hRd4IjZxSBWVMcmUwBwUoQSimYP+uUCpJK8yWXAYNQz53eadSq0t9AeaSpNYfQGlGC
         a5H+JYzheL+je0uLt5tHHVIenME/RIZgeytmu3vek7hwu/dLeAtjo4t8ilGIFtDRvgl0
         J72bM4jprSrvzlsZKmq0n/bS8NV+Pxk+C3WEVnYt1hd1NbXW4aijI5vzI6cwQ2JJFLxB
         GOak+dwm1rbGy2awARr/4QBUe+TQfGKL9DG/HcTF913wNwnt2CiFWPStmIImiuv8OFqd
         +NzQ5g6rHLaMIpqmX1py3sPebkBbHOc8Q7BDS+BsaJZAtp+DFAXC8D066o/Nr5ST2XT4
         eOUg==
X-Forwarded-Encrypted: i=1; AJvYcCXszZblwXMB+7dxPEsC+i1unckAPz+sckEPEJQAEQVcnw9HXJAjXx9OOFS563Bzd+Q6BlM5BFN1kzrUtdfEMLYMsEAOYHgIfawkgTyx
X-Gm-Message-State: AOJu0YyOiSegpJ30OlrJOY6Qu5Xpt4rrQc088HOzXu3n0JdRumoIph1d
	YAt2rTCT/wP8v+vo5o6gDu7gkfxBE3PzP2V2M3qGsG7ZR3WOvz8DUrMKlhhN3iWBe3Ec6FgJ6/c
	nJWkfsgaRzP24hCI6IaDIHP1exvgx//Q/hhUI1PBzTZuzgRqJaUyDckDIIVajZLPvQjTVVzHvjW
	L8xH6nI12mqi8g2K74Y1HQsQh1KU6q2yVmWMW1
X-Received: by 2002:a92:dcc2:0:b0:366:7922:9509 with SMTP id b2-20020a92dcc2000000b0036679229509mr15726553ilr.2.1710982610103;
        Wed, 20 Mar 2024 17:56:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8Cyz7FUh75+9TP6TV4dnUMPt/EleDATTJuOKf6cagiCNR9N9d9vuTcHdlDAPkWI1xkb8qk+TQeLIJNaZdTSw=
X-Received: by 2002:a92:dcc2:0:b0:366:7922:9509 with SMTP id
 b2-20020a92dcc2000000b0036679229509mr15726542ilr.2.1710982609844; Wed, 20 Mar
 2024 17:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeZ2Kos-OOZNSrmO@darkstar.users.ipa.redhat.com> <4d9fe26b-cf0e-4381-9dee-20f43f371710@intel.com>
In-Reply-To: <4d9fe26b-cf0e-4381-9dee-20f43f371710@intel.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 21 Mar 2024 08:57:01 +0800
Message-ID: <CALu+AoR3QA58_WJVLc06ma5RC69jYLi2BHBsq1fvxK07amNSaw@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: do not update E820 kexec table for setup_data
To: "Huang, Kai" <kai.huang@intel.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, 21 Mar 2024 at 05:56, Huang, Kai <kai.huang@intel.com> wrote:
>
> Hi Dave,
>
> Some nitpicking in changelog:

Will fix the grammar issues.  Thanks for your review!

>
> On 5/03/2024 2:32 pm, Dave Young wrote:
> > crashkernel reservation failed on a Thinkpad t440s laptop recently,
>
> ',' -> '.' to make it as a standalone sentence.
>
> > Actually the memblock reservation succeeded, but later insert_resource()
> > failed.
> >
> > Test step:
> > kexec load ->
> >       kexec reboot ->
> >               check the crashkernel memory
> >               dmesg|grep "crashkernel reserved"; saw reserved suceeeded:
>
> "suceeeded" -> "succeeded".
>
> >               0x00000000d0000000 - 0x00000000da000000
> >               grep Crash /proc/iomem: got nothing
>
> And somehow I found it's not easy to read.  :-)
>
> >
> > The background story is like below:
>
> Better to have an blank line to make text more breathable.
>
> > Currently E820 code reserves setup_data regions for both the current kernel
> > and the kexec kernel, and it will also insert them into resources list.
>
> "will insert" -> "inserts".
>
> > Before the kexec kernel reboot nobody passes the old setup_data, kexec only
>
>                           ^ "reboots"                             ^ and
>
> > passes SETUP_EFI and SETUP_IMA if needed.  Thus the old setup data memory
> > are not used at all. But due to old kernel updated the kexec e820 table
>
>    ^ is                                      ^ updates
>
> > as well so kexec kernel see them as E820_TYPE_RESERVED_KERN regions, later
>
> "so kexec kernel" -> ", the kexec kernel"
>
> "see" -> "sees"
>
> ", later" -> ", and later"
>
> > the old setup_data regions will be inserted into resources list in kexec
>
> "will be" -> "are"
>
> > kernel by e820__reserve_resources().
> >
> > Note, due to no setup_data passed in for those old regions they are not
>
>                             ^ is
>
> > early reserved (by function early_reserve_memory), crashkernel memblock
>
>                                                    ^ and the
>
> > reservation will just regard them as usable memory and it could reserve
>
> "regard" -> "treat"
>
> > reserve crashkernel region overlaps with the old setup_data regions.
>
> double "reserve".
>
> "crashkernel region" -> "the crashkernel region"
>
> "overlaps" -> "which overlaps"
>
> >
> > Just like the bug I noticed here, kdump insert_resource failed because
> > e820__reserve_resources added the overlapped chunks in /proc/iomem already.
>
>                           ^ has added
> >
> > Finally, looking at the code, the old setup_data regions are not used
> > at all as no setup_data passed in by the kexec boot loader. Although
>
>                           ^ is passed
>
> > something like SETUP_PCI etc could be needed, kexec should pass
> > the info as setup_data so that kexec kernel can take care of them.
> > This should be taken care of in other separate patches if needed.
> >
> > Thus drop the useless buggy code here.
> >
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >   arch/x86/kernel/e820.c |   16 +---------------
> >   1 file changed, 1 insertion(+), 15 deletions(-)
> >
> > Index: linux/arch/x86/kernel/e820.c
> > ===================================================================
> > --- linux.orig/arch/x86/kernel/e820.c
> > +++ linux/arch/x86/kernel/e820.c
> > @@ -1015,16 +1015,6 @@ void __init e820__reserve_setup_data(voi
> >               pa_next = data->next;
> >
> >               e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> > -
> > -             /*
> > -              * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
> > -              * to be reserved.
> > -              */
> > -             if (data->type != SETUP_EFI && data->type != SETUP_IMA)
> > -                     e820__range_update_kexec(pa_data,
> > -                                              sizeof(*data) + data->len,
> > -                                              E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> > -
> >               if (data->type == SETUP_INDIRECT) {
> >                       len += data->len;
> >                       early_memunmap(data, sizeof(*data));
> > @@ -1036,12 +1026,9 @@ void __init e820__reserve_setup_data(voi
> >
> >                       indirect = (struct setup_indirect *)data->data;
> >
> > -                     if (indirect->type != SETUP_INDIRECT) {
> > +                     if (indirect->type != SETUP_INDIRECT)
> >                               e820__range_update(indirect->addr, indirect->len,
> >                                                  E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> > -                             e820__range_update_kexec(indirect->addr, indirect->len,
> > -                                                      E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> > -                     }
> >               }
> >
> >               pa_data = pa_next;
> > @@ -1049,7 +1036,6 @@ void __init e820__reserve_setup_data(voi
> >       }
> >
> >       e820__update_table(e820_table);
> > -     e820__update_table(e820_table_kexec);
> >
> >       pr_info("extended physical RAM map:\n");
> >       e820__print_table("reserve setup_data");
> >
> >
>


