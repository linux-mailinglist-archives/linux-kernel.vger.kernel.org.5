Return-Path: <linux-kernel+bounces-88809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF1686E6DF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F73C28FBCC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD78538D;
	Fri,  1 Mar 2024 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHFZivBa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FEF3D8E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313006; cv=none; b=L00wUBmShtorOcYYcnD4tTQ0YnAQspP1Bc1qzgzieYgIo9qDKLYVkscOfN5RzZqtDVMgrKxswNb0QLQK5Fm2YvMg97yWBIvaYCAbMJQ+sLRoZPRi9lZLhGoJfrd4FU9Yx8B04p+uEYTG5OYFNmJSuZMGArWGxh2u32bEYdfkcqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313006; c=relaxed/simple;
	bh=W3iraL+3eNuYYpp9mYFoCXa3DxgLirdBiNPHCzX+wQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpEy+wLrIpf+4P6Lkr/3kuVd3+e46pNfaJaBKPw6rAntYIpAFMk5S5hclZ0ARwqcBsv4pOdr/67ssVKBiAH8xxRhb4dZuk41hX4vKtMCzAoKodQuJQwLSG8SvI/nFU2n58jUSRxvjkTXYrIL8AaomzE0RnNUWo6yEZA8pENBPCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHFZivBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83844C433B2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709313006;
	bh=W3iraL+3eNuYYpp9mYFoCXa3DxgLirdBiNPHCzX+wQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HHFZivBaF9rj/8yGMfHXxvnLC6sQsnbdN7rDRIBE046cJnrz0NPxU2KXBkGRXZUKE
	 vaydm7GQ/DhplGYGoOiImY6oLUASJfRi7IqvzJ2eu3V7HurbYVrIyLovQjBeVkkyEl
	 yUzWayn3RbNtU3MtKp3yzBrdrGMlWQvSjT9TyyufYsRV1205mx1OndJP1hcp692OAN
	 lLecpMNRAAgRMDkmzlQ3xOr6YR/mZ4xo0He5m4TvxZlxd7Gf33SrDeDtxJh9l/Rau3
	 2qOUHJxj+R2YEZTcfbMJis+OJVJnuhRYZZGuIPF4aSblMWFuHwoZYVId4aesBS1fC2
	 Llvhj7oK0e5IQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5132010e5d1so2481464e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 09:10:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXs1UyipfEgR8LKrIye0zBN5Mz1hD5DNU45QIqRlB8wFHitaNm/AIVMRqMknSUuI1W8SXXfLEpI6qTdzCmoQ0sIwepNdmnvL6L+ZP/K
X-Gm-Message-State: AOJu0YwZbF7Y5uGw+BTA5Jpl++OJkO+hXtxWWfhgNXpctm765NTUAHu6
	s4MRw/lD0/9XsjjEFllNPbwotgcy0wy2m5jHyCvGvjRvIYamqxALnfmyuT6kdGVAIuwVgHSXEY6
	xBym32zhh9WNeybjEweR73O6ucW0=
X-Google-Smtp-Source: AGHT+IE1tp9WZHxjHLNKlCxc7dPiXhlbU1KBVConDTOssaF8yvexwuNBvn9lEc/ZiX84SDnO1qx/uRokK29Ymi7fcu0=
X-Received: by 2002:a05:6512:251:b0:512:d877:df6f with SMTP id
 b17-20020a056512025100b00512d877df6fmr1674577lfo.2.1709313004711; Fri, 01 Mar
 2024 09:10:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227151907.387873-11-ardb+git@google.com> <20240227151907.387873-13-ardb+git@google.com>
 <20240228205540.GIZd-dzFYIBbtfIAo3@fat_crate.local> <CAMj1kXGhZU+FE2gE262Q8_vZEFHicsRtVPzXT-dhhCvBuiMjUA@mail.gmail.com>
 <20240301160921.GBZeH9sZhp73xX40ze@fat_crate.local>
In-Reply-To: <20240301160921.GBZeH9sZhp73xX40ze@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 1 Mar 2024 18:09:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFJwEUExy7+Snh3QHVn-ATj0C+sYje22Qmc+y=cCtAV7g@mail.gmail.com>
Message-ID: <CAMj1kXFJwEUExy7+Snh3QHVn-ATj0C+sYje22Qmc+y=cCtAV7g@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] x86/startup_64: Defer assignment of 5-level paging
 global variables
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Mar 2024 at 17:09, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Mar 01, 2024 at 11:01:33AM +0100, Ard Biesheuvel wrote:
> > The scenario that I have not managed to test is entering from EFI with
> > 5 levels of paging enabled, and switching back to 4 levels (which
> > should work regardless of CONFIG_X86_5LEVEL). However, no firmware in
> > existence actually supports that today, and I am pretty sure that this
> > code has never been tested under those conditions to begin with. (OVMF
> > patches are under review atm to allow 5-level paging to be enabled in
> > the firmware)
>
> Aha.
>

I've built a debug OVMF image using the latest version of the series,
and put it at [0]

Run like this

qemu-system-x86_64 -M q35 \
  -cpu qemu64,+la57 -smp 4 \
  -bios OVMF-5level.fd \
  -kernel arch/x86/boot/bzImage \
  -append console=ttyS0\ earlyprintk=ttyS0 \
  -vga none -nographic -m 1g \
  -initrd <initrd.img>

and you will get loads of DEBUG output from the firmware first, and
then boot into Linux. (initrd can be omitted)

Right before entering, it will print

CpuDxe: 5-Level Paging = 1

which confirms that the firmware is running with 5 levels of paging.

I've confirmed that this boots happily with this series applied,
including when using 'no5lvl' on the command line, or when disabling
CONFIG_X86_5LEVEL [confirmed by inspecting
/sys/kernel/debug/page_tables/kernel].


[0] http://files.workofard.com/OVMF-5level.fd.gz

