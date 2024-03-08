Return-Path: <linux-kernel+bounces-96747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC1B8760F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05C61F22BB4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1772852F91;
	Fri,  8 Mar 2024 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="poqyepOR"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755722F0F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890247; cv=none; b=hVmYI+aYMqy+QvJ0awXzSkGIu5f8umwapzPInJNH85AXOzjUb3pbUoixy2604Hu9TYjGCkRyWATO9Kzb6J6kb4ZPuyht3l4LHQXjxCetqS+0O7cm0b4bvxx6HDY/BJ6ghMjSetOiWFMIYt4L0dUsj0hexVspApMPlYOYt21HxOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890247; c=relaxed/simple;
	bh=tiO0bXgsOr+PuXLGnaMqo6dxWeWjXreRkFH/dObAfKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AC6fJibJfOj6KOChzSymPo/UWwCtyFttyOj62gipJIsT2MybE77pwAoncQkU4zludHQquIrXHPpvajJpP3L4xB6Qj3OYy8ndEaQnlqVy84w+7e9Z6NB/ymgPYb7zZ6uT4JUsqoQMoxpG/hn3WtaYzp1Bccz7WfIBxDmtGXbopfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=poqyepOR; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709890241;
	bh=YrG1vi6s/nTwQkG4YsY+XqFiQyMrqUljBKJEXiaxAlo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=poqyepOR/C++MsETS/6QVuyHg2UIBvlhqaSA6Ce5Go5wIxdCFrubcjS2LSzyhflBx
	 5Q8AwLdlL2B59MTdND6P3EKY3yJHoSAF5lQwj+e3T5JjlYw/NFKrOAMlt7OKAil0jj
	 YW14/V32vV7XsCKTeyA889fdfzECaYF2iEYktWeiycbVj5Ac8St5Le2sG+/b3PSqVw
	 xXOvXyMSA0SUfjBYo24HFVHSMiUygB5X8tWiLkyxMM6aDZHznE3RrumAU5gQIRV9eN
	 Je+IdqrXNZpGz8tPt0SXHU475HQ0xcw7+qbjPtDVRAgtHtZmA515omGgpXybBDi7Nq
	 etlkkl91F1cxA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Trgrc6vwJz4wc4;
	Fri,  8 Mar 2024 20:30:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Savitz <jsavitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Benjamin Gray <bgray@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>,
 linuxppc-dev@lists.ozlabs.org, Gonzalo Siero <gsierohu@redhat.com>
Subject: Re: [PATCH] powerpc: align memory_limit to 16MB in early_parse_mem
In-Reply-To: <CAL1p7m7nHfLM=koNaFZ0MrrcC6Lyj3VWdC9i8rOWGmrijKR3+Q@mail.gmail.com>
References: <20240301203023.2197451-1-jsavitz@redhat.com>
 <87cysdfsef.fsf@mail.lhotse>
 <CAL1p7m7nHfLM=koNaFZ0MrrcC6Lyj3VWdC9i8rOWGmrijKR3+Q@mail.gmail.com>
Date: Fri, 08 Mar 2024 20:30:39 +1100
Message-ID: <87zfv9m5og.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Joel Savitz <jsavitz@redhat.com> writes:
> On Fri, Mar 1, 2024 at 6:23=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.=
au> wrote:
>> Joel Savitz <jsavitz@redhat.com> writes:
>> > On 64-bit powerpc, usage of a non-16MB-aligned value for the mem=3D ke=
rnel
>> > cmdline parameter results in a system hang at boot.
>>
>> Can you give us any more details on that? It might be a bug we can fix.
>
> The console freezes after the following output:
>
>   Booting a command list
>
> OF stdout device is: /vdevice/vty@30000000
> Preparing to boot Linux version 6.8.0-rc6.memNOfix-00120-g87adedeba51a
> (root@ibm-p9z-26-lp11.virt.pnr.lab.eng.rdu2.redhat.com) (gcc (GCC)
> 11.4.1 20231218 (Red Hat 11.4.1-3), GNU ld version 2.35.2-43.el9) #3
> SMP Fri Mar  1 10:45:45 EST 2024
> Detected machine type: 0000000000000101
> command line: BOOT_IMAGE=3D(ieee1275//vdevice/v-scsi@30000003/disk@810000=
0000000000,msdos2)/vmlinuz-6.8.0-rc6.memNOfix-00120-g87adedeba51a
> root=3D/dev/mapper/rhel_ibm--p9z--26--lp11-root ro
> crashkernel=3D2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G
> rd.lvm.lv=3Drhel_ibm-p9z-26-lp11/root
> rd.lvm.lv=3Drhel_ibm-p9z-26-lp11/swap mem=3D4198400K
> Max number of cores passed to firmware: 256 (NR_CPUS =3D 2048)
> Calling ibm,client-architecture-support... done
> Ignoring mem=3D0000000101000000 >=3D ram_top.
> memory layout at init:
>   memory_limit : 0000000000000000 (16 MB aligned)
>   alloc_bottom : 00000000114f0000
>   alloc_top    : 0000000020000000
>   alloc_top_hi : 0000000020000000
>   rmo_top      : 0000000020000000
>   ram_top      : 0000000020000000
> instantiating rtas at 0x000000001ecb0000... done
> prom_hold_cpus: skipped
> copying OF device tree...
> Building dt strings...
> Building dt structure...
> Device tree strings 0x0000000011500000 -> 0x00000000115017b7
> Device tree struct  0x0000000011510000 -> 0x0000000011520000
> Quiescing Open Firmware ...
> Booting Linux via __start() @ 0x000000000a6e0000 ...

Thanks.

I haven't been able to reproduce this unfortunately, and I don't see the
bug. As Aneesh pointed out the code should be aligning later anyway.

Can you build a kernel with CONFIG_PPC_EARLY_DEBUG_LPAR=3Dy and boot it
without the patch? That should hopefully give you some more output.

cheers

