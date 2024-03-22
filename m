Return-Path: <linux-kernel+bounces-110878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF746886521
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1595EB2114B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D67F1854;
	Fri, 22 Mar 2024 02:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjHlDnUL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109A138E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073834; cv=none; b=kyo9ABmOkB4z13pbKx5ZzxS+l51hwa2sBJzcugYHkQbIxmIyaaqejKG9DX+LaEBUTComGypavlBegBWj7mWudI0oCchKB4AnENzVBHm98Cclbm3v7pymjMcTmjW8gONuuMJbRtm2hh4GhcxzroPW4BsfIKICIRTD0WckX829GeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073834; c=relaxed/simple;
	bh=+CFWwGA4gGcLX2iyxoP7lPaCxmN7SrqBm9vV/0Vrvco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMRWgT7R1C06Px9imQGk4MAun60r25WrSMQdo2rb6i5JZZseNN86fPPfInyDJKRVFbFiXnFvOsu+dYXSvDXDKEumgTdCM9E3wEFdrk0qgckwlE6lrypftFwaydl8vNfZXx03ud1W/GJ2TuEuCNtxDLz/sNHRf9cksfqbHyDTIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bjHlDnUL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711073831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MNgO21cK7btQLoesiqjurVas6kvko8W7lGGjCXh1DPY=;
	b=bjHlDnUL1LC2SH0WTx4RkIFDcRikBflKK7RBGJzwJNgU1CW13JmZWGzr3Rle41N8oHUaV1
	ymSwFwv6vf4qjm9zvr2a4ygYgm1XRsY6USJnKW8mqQHBq/SqkZRdmqkJH5P0jzp5kqjwkU
	Dj8yRdasyr6KXVYqcBez3ofvRFZpDMg=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-E869HfsJPpCfe509XmoggQ-1; Thu, 21 Mar 2024 22:17:09 -0400
X-MC-Unique: E869HfsJPpCfe509XmoggQ-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d0252030adso41713839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 19:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711073829; x=1711678629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNgO21cK7btQLoesiqjurVas6kvko8W7lGGjCXh1DPY=;
        b=ETXtYoAqio2+Csfe5kebmHOPWRQ5GmyiNeDnl6j54WT6lUfattXU0ugfUil53ZjUgZ
         tgHLv3Vn5uYfeqNv2Hxx2Pka+q7hukU8FvFy7ns7PLwN3cTJGpL0eBDjjk4bwqpIkvfX
         RMZLmJqE7RwxsZmmyfC4UjVSUlg+xN9BjHxlSoP1h2W8M71MfjariPckPRk4HFdyGywo
         dX0C7Fw4tdbyyBJXHCtmMUfexF5qaHBhiMKOOHIKqClmciPum8VSMw3SDFDvTtmJFhBQ
         j6FQ/sXqnh++oOPvgmpbZm0O7teaMHol2s0xyK2DeEAqMGQUEOdrfBYYpRXLlm4HbzMa
         VOBg==
X-Forwarded-Encrypted: i=1; AJvYcCUKDh3oUdyg4zyFSlo3eBaVBqmcXumwjPakUuwOV7hnNDNc5cNJshYFeGg9IFkrysRnzS29LhjI2BpnkH5KV8Aw0MoQnvsouGCppT0K
X-Gm-Message-State: AOJu0Ywc6SZSGUWiwnZNmEf/7yEuDyuGxnoyiv38XtOg7UOtyxk6YEdQ
	1tcjQMwC5HYRDehZhUK0ttKvQL4MGVHjfbOngxRvpGTX3bqviEuPO5kkZ5/Ehk/nnsQvKR5sGSl
	EDj58b+lWZjLTff9VHQI/V/v63stlAooWp+KFGM3uYJdxXs50kheqh/fL8Skm/r3sYkG4iN5sIq
	+KrvFQuhvgO4uvoxOHbfg6olDn3K5IrMXBEr4Z
X-Received: by 2002:a05:6e02:60a:b0:366:b533:cef1 with SMTP id t10-20020a056e02060a00b00366b533cef1mr1241304ils.1.1711073828745;
        Thu, 21 Mar 2024 19:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfAUv9CbsYT6rba0olU8YsLcYCsd+s9n6n8+9mllRpKdxyde3A9FklpPaV/NC29Hkk7aTJUhio/6Yy0QrvU3E=
X-Received: by 2002:a05:6e02:60a:b0:366:b533:cef1 with SMTP id
 t10-20020a056e02060a00b00366b533cef1mr1241287ils.1.1711073828471; Thu, 21 Mar
 2024 19:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zfv8iCL6CT2JqLIC@darkstar.users.ipa.redhat.com> <ZfwMribQCTKWSO9l@dwarf.suse.cz>
In-Reply-To: <ZfwMribQCTKWSO9l@dwarf.suse.cz>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 22 Mar 2024 10:17:19 +0800
Message-ID: <CALu+AoT2jYfVTFpVvUJv5T+OdSAQzYw0kn74EighK5-4A3O16w@mail.gmail.com>
Subject: Re: [PATCH V2] x86/kexec: do not update E820 kexec table for setup_data
To: Jiri Bohac <jbohac@suse.cz>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
	"Huang, Kai" <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jiri,

On Thu, 21 Mar 2024 at 18:32, Jiri Bohac <jbohac@suse.cz> wrote:
>
> Hi,
>
> On Thu, Mar 21, 2024 at 05:23:20PM +0800, Dave Young wrote:
> > crashkernel reservation failed on a Thinkpad t440s laptop recently.
> > Actually the memblock reservation succeeded, but later insert_resource()
> > failed.
> >
> > Test steps:
> > kexec load -> /* make sure add crashkernel param eg. crashkernel=160M */
> >     kexec reboot ->
> >         dmesg|grep "crashkernel reserved";
> >             crashkernel memory range like below reserved successfully:
> >             0x00000000d0000000 - 0x00000000da000000
> >         But no such "Crash kernel" region in /proc/iomem
> >
> > The background story is like below:
> >
> > Currently E820 code reserves setup_data regions for both the current
> > kernel and the kexec kernel, and it inserts them into the resources list.
> > Before the kexec kernel reboots nobody passes the old setup_data, and
> > kexec only passes fresh SETUP_EFI and SETUP_IMA if needed.  Thus the old
> > setup data memory is not used at all.
> >
> > Due to old kernel updates the kexec e820 table as well so kexec kernel
> > sees them as E820_TYPE_RESERVED_KERN regions, and later the old setup_data
> > regions are inserted into resources list in the kexec kernel by
> > e820__reserve_resources().
> >
> > Note, due to no setup_data is passed in for those old regions they are not
> > early reserved (by function early_reserve_memory), and the crashkernel
> > memblock reservation will just treat them as usable memory and it could
> > reserve the crashkernel region which overlaps with the old setup_data
> > regions. And just like the bug I noticed here, kdump insert_resource
> > failed because e820__reserve_resources has added the overlapped chunks
> > in /proc/iomem already.
>
> wouldn't this be caused by
> 4a693ce65b186fddc1a73621bd6f941e6e3eca21 ("kdump: defer the
> insertion of crashkernel resources")?
>
> Before that the crashkernel resources were inserted from
> arch_reserve_crashkernel() which is called before
> e820__reserve_resources().

I think reverting the commit you mentioned can paper out this issue
but it is not
the root cause.  Yes, arch_reserve_crashkernel can succeed, then e820
still tries
to reserve the setup_data overlapping with crashkernel for another purpose.

>
> The semantics of E820_TYPE_RESERVED_KERN wrt kexec quite
> inconsistent. It's treated as E820_TYPE_RAM by
> e820__memblock_setup() and e820_type_to_iomem_type().
>
> The problem we're seeing here is the result of the former.
> e820__memblock_setup() will add the E820_TYPE_RESERVED_KERN
> region to the memblock, merging with the neighbouring memblocks,
> allowing crashkernel region to span across the originally
> reserved area.
>
> e820_type_to_iomem_type() treating E820_TYPE_RESERVED_KERN as
> E820_TYPE_RAM will make the E820_TYPE_RESERVED_KERN appear as
> system ram in /proc/iomem. If the old kexec_load (not
> kexec_file_load) syscall is used, the userspace kexec utility
> will construct the e820 table based on the contents of
> /proc/iomem and the kexec kernel will see the
> E820_TYPE_RESERVED_KERN range as E820_TYPE_RAM.  When
> kexec_file_load is used the E820_TYPE_RESERVED_KERN type is
> propagated to the kexec kernel by bzImage64_load() /
> setup_e820_entries().

This is true, but it does not matter for the kexec kernel as they are
only reserved for
the 1st kernel, and it is not meaningful to the kexec kernel.  Use
them as system ram
is fine in the 2nd kexec kernel.

>
>
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
>
> Your tree is missing this recent commit:
> 7fd817c906503b6813ea3b41f5fdf4192449a707 ("x86/e820: Don't
> reserve SETUP_RNG_SEED in e820").
>
> Wouldn't this fix [/paper over] your problem as well? I.e., isn't
> SETUP_RNG_SEED the setup_data item that's causing your problem?

Thanks for catching this, I will rebase and repost.

But it does not "fix" the problem as my problem is related to the
other setup_data
range, I think it is SETUP_PCI (not 100% sure, but it is certainly not RNG_SEED)

>
> Regards,
>
> --
> Jiri Bohac <jbohac@suse.cz>
> SUSE Labs, Prague, Czechia
>
>
Thanks
Dave


