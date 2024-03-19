Return-Path: <linux-kernel+bounces-106985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A013787F64D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 808D1B220E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DA17C081;
	Tue, 19 Mar 2024 04:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IcjrwVnv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B11556B6E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 04:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710821609; cv=none; b=Bt0LCimawDXp4cGZIinWK27rk2KrcIquIOyPCGHDG2J95enNoELcqE6/6kux/wCm4RrRbXnE2C9gNHzc3dqsZjAKw83YbZYh53yoXXkpsYe92W44jzpcL9p4qKYsZGQcKgJjcQBPNaoSB3qc592GaKuvp+3uGsYluNNIbBI1WYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710821609; c=relaxed/simple;
	bh=Ah4Ny8uUQBmfdpD/uzmJd5xYp4kcbIf+Duq2v3FNUAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2Zzy9FpLenpfFEy6BOH+XhdlWGBJYRWxXcklplyw9jXuYqEVUkkH2GFswfo7xM+Xt9Jj9cYILYCRQi9zfmjOluEO/PV/26MDsO3MWCsdgC3gkoH5wYCzDn8ETFtsrLt745PoX8HkPZQUYB3QTFHkoKtpZ5m5aWAVJAsHz6oRkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IcjrwVnv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710821606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JWG74Dl5bTbuxCti86zPWOGnY2g2FNK26/oHUY3dQ8I=;
	b=IcjrwVnvr7QPBqohWq1yMKF48oPMmPJecR50VrHIYWb0jIjfRcQvrkrtjYxYlsE5SRgGDj
	YDj7P8CnY9d4TSSURPgXT3DJ/B8ilbHeeYsPoA9eJjLI8vaLngHWC+yFvj07NmWCe6Svru
	fOQXJLSgH2/fDipyQG6H1Mm2uxm+EYM=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-Ox1hhmp4Po6ETsho4St6sw-1; Tue, 19 Mar 2024 00:13:25 -0400
X-MC-Unique: Ox1hhmp4Po6ETsho4St6sw-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3684d716b9eso41985ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710821604; x=1711426404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWG74Dl5bTbuxCti86zPWOGnY2g2FNK26/oHUY3dQ8I=;
        b=IQd545cn7IfFRwRLCFJrPFzFlBXbzdd0FUcJ0dRyW0OgCOmYNnxYDy6w0jemOmCN7V
         wDTBgEtzjp1vT6QkcBdsy7qkSFfbUdcGN3bOiGgkNqdMd9IjNKhdX+6K4GD5clI79aIi
         wg1kTzLqCu0JFgsFxL5lWWrB8+kpkPYlrsWZtmrWU9SpW87zN7bZdfSdDbLIeFomWEWY
         SRvlMbdaM9S6oH2LfEk336Give+SdU9KQy0Nxyn91dOMiQ02GFRreN9oRYzMnaXn81A1
         p+enAlnLdrW7VSfEBmTLfGpeXu1Bp3LOFR/PSM7qAA1GQcUz5h0sCdvB66okCA9s5Sma
         2Fng==
X-Forwarded-Encrypted: i=1; AJvYcCU0BsUWv9jEdbMj6ifYXemv4Xr6XVMNd7zVc2RLs6RF4gH6RpH5w2ZcixnE094sxa98gvBENW1nookMg3LtOwzYaxwo3ibWagYB9wNB
X-Gm-Message-State: AOJu0Yxgh3gJwRboVGw5CEVxtICmjpy4tpndz1B5ueqxs9znLjG/1VCj
	ShakIGRqjUC4l/t1q0dWlvOBVhuPxK8XjOAxVDdA4c53RKXHxmR93JtwFwHYXf6zqnujwSy8o1l
	DRQXSW8IGFsjot9uV+zgUeCUMX3VJHuES+fHVYUcsRWIrE0FOEDNdj6w13RQdfpq8ZQzcx5H+gX
	5/AfEI1DjrPA4+ry67Bzd+gPoZ8J3jZQiNkFp/
X-Received: by 2002:a05:6e02:2197:b0:367:841f:4ea with SMTP id j23-20020a056e02219700b00367841f04eamr1703763ila.3.1710821604465;
        Mon, 18 Mar 2024 21:13:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw2yGPDwNdTHpgshZtX42+6Fr/AzzNGxTbh290UoUCFi635TZEchb+9DVQ5qVrlww2086xuAqQekPrqvHq3lE=
X-Received: by 2002:a05:6e02:2197:b0:367:841f:4ea with SMTP id
 j23-20020a056e02219700b00367841f04eamr1703755ila.3.1710821604229; Mon, 18 Mar
 2024 21:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeZ2Kos-OOZNSrmO@darkstar.users.ipa.redhat.com>
In-Reply-To: <ZeZ2Kos-OOZNSrmO@darkstar.users.ipa.redhat.com>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 19 Mar 2024 12:13:36 +0800
Message-ID: <CALu+AoQzrVBjkBjurv_3p9kCe9EfPszcf1Lzo1G5_QQGbv8B+Q@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: do not update E820 kexec table for setup_data
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 09:32, Dave Young <dyoung@redhat.com> wrote:
>
> crashkernel reservation failed on a Thinkpad t440s laptop recently,
> Actually the memblock reservation succeeded, but later insert_resource()
> failed.
>
> Test step:
> kexec load ->
>         kexec reboot ->
>                 check the crashkernel memory
>                 dmesg|grep "crashkernel reserved"; saw reserved suceeeded:
>                 0x00000000d0000000 - 0x00000000da000000
>                 grep Crash /proc/iomem: got nothing
>
> The background story is like below:
> Currently E820 code reserves setup_data regions for both the current kernel
> and the kexec kernel, and it will also insert them into resources list.
> Before the kexec kernel reboot nobody passes the old setup_data, kexec only
> passes SETUP_EFI and SETUP_IMA if needed.  Thus the old setup data memory
> are not used at all. But due to old kernel updated the kexec e820 table
> as well so kexec kernel see them as E820_TYPE_RESERVED_KERN regions, later
> the old setup_data regions will be inserted into resources list in kexec
> kernel by e820__reserve_resources().
>
> Note, due to no setup_data passed in for those old regions they are not
> early reserved (by function early_reserve_memory), crashkernel memblock
> reservation will just regard them as usable memory and it could reserve
> reserve crashkernel region overlaps with the old setup_data regions.
>
> Just like the bug I noticed here, kdump insert_resource failed because
> e820__reserve_resources added the overlapped chunks in /proc/iomem already.
>
> Finally, looking at the code, the old setup_data regions are not used
> at all as no setup_data passed in by the kexec boot loader. Although
> something like SETUP_PCI etc could be needed, kexec should pass
> the info as setup_data so that kexec kernel can take care of them.
> This should be taken care of in other separate patches if needed.
>
> Thus drop the useless buggy code here.
>
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/kernel/e820.c |   16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>
> Index: linux/arch/x86/kernel/e820.c
> ===================================================================
> --- linux.orig/arch/x86/kernel/e820.c
> +++ linux/arch/x86/kernel/e820.c
> @@ -1015,16 +1015,6 @@ void __init e820__reserve_setup_data(voi
>                 pa_next = data->next;
>
>                 e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> -
> -               /*
> -                * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
> -                * to be reserved.
> -                */
> -               if (data->type != SETUP_EFI && data->type != SETUP_IMA)
> -                       e820__range_update_kexec(pa_data,
> -                                                sizeof(*data) + data->len,
> -                                                E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> -
>                 if (data->type == SETUP_INDIRECT) {
>                         len += data->len;
>                         early_memunmap(data, sizeof(*data));
> @@ -1036,12 +1026,9 @@ void __init e820__reserve_setup_data(voi
>
>                         indirect = (struct setup_indirect *)data->data;
>
> -                       if (indirect->type != SETUP_INDIRECT) {
> +                       if (indirect->type != SETUP_INDIRECT)
>                                 e820__range_update(indirect->addr, indirect->len,
>                                                    E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> -                               e820__range_update_kexec(indirect->addr, indirect->len,
> -                                                        E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> -                       }
>                 }
>
>                 pa_data = pa_next;
> @@ -1049,7 +1036,6 @@ void __init e820__reserve_setup_data(voi
>         }
>
>         e820__update_table(e820_table);
> -       e820__update_table(e820_table_kexec);
>
>         pr_info("extended physical RAM map:\n");
>         e820__print_table("reserve setup_data");
>

Kindly ping for review.

Thanks!
Dave


