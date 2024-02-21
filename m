Return-Path: <linux-kernel+bounces-75622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98DA85EC14
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08600282C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24843BB37;
	Wed, 21 Feb 2024 22:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="sgUXToH/"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2C43EA8F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556132; cv=none; b=jSUW7L7c0mS6lP+gCu0sJHB1nM/rSwtGkBO4rGAlB+4wYBPgB9kF239IMqzD9C0pk8whZJS4xn41zLNefVvkfscDM9rbA+314x0461+pHE59qc8PhVE6sG1ktDibmHcokBh48pSqs8IoEy8oV63gg2F4Nx1yGtL9kLNDV/TMAXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556132; c=relaxed/simple;
	bh=Wwde3rA5tjYRA65lr69fJ02UloO7h2osuwWzVIpWHmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7eeyf25t0DZaVZiyquNuzznaugpRGcst3AH6IP3AqTFlCYQakJ8INKZDPqpnNCfQQL5B8vePhmzGCmmBx0ib8F+Lcj4Dbp19WlG9/+SHpfZkMjVof7Wk4PFE8oYoKXTpeuJp6QXyjH87OxjbXFZWt57rDx6hu+vI/7FRFb4LB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sgUXToH/; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-60495209415so70786097b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708556129; x=1709160929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAMt/hLWAxcvMGr5+QIpeSl7/TSI4+J3f6SxfqhNwSU=;
        b=sgUXToH/5O4ShiNiiu1EJPkdzhC9VNqsBc+LPRFJBSWKvhPmQzAPGUX6vbGHcu4Fov
         Lk99RP24EgXYR4onS8rENSTlCvkdEKBv65yv0rpciTNNjY4S/m6xDw8VVz6GvRf1Qn9r
         IZlb23aeb+U6n6IJv6Y/ss+RojeN98quxXF/0pLuj44kHFuUu7Oit1qb3k6Al3RtBQL8
         eYKZjvi1F1hkr3pOpVA/5GDn3WTuKX/tqVRcRhRHZInQhpJ5Mm/5p5M7d/8jY/uClFLg
         LqwtWc1ZvElmOJZLvxfqsNAawIUClIeznD8IPIeX+LbsivKOzqjSbmq4jGfkzxt2CbqH
         5Jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708556129; x=1709160929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAMt/hLWAxcvMGr5+QIpeSl7/TSI4+J3f6SxfqhNwSU=;
        b=uHJlJ4WpulFNt1i8YrhKlG3c7adkyIgah78kzN+Lyfz/iIqYNIXAhgQ2QjmObxbmES
         46EHBKEs1vahuu4VA1xpn+ax/qasppytpTCXV1SGmuGdasGH5OcH3v1GNTHBXJtqaQI9
         WQ3jgfz3qL/4URUMmajtUYX6qixttC8NnYzMWTn81FT8h+H5kwpUHmdu/czGobEDakiK
         u9uFRhsUPxnl6h7icG6F5CQV6SrxK/BqDxc9fv8BWxlpUW1cI6PzskdgLDR1weemqn+X
         5ksBw7nu5zGP9/rO3buBDykIlItt0ltnyvTn3Hw5sreN7jCNBrNDfZUheVGCSVGe+EWR
         WfPA==
X-Forwarded-Encrypted: i=1; AJvYcCUJK4I4q5r9NtatRXka8ajs9yF+v2WdiyoaVcNNLz3BdD4g+JFLgLQp6G+QoQApE0qQXOG5gLmuEQ3fKrrQbzw65dEXBW9bi15nRADX
X-Gm-Message-State: AOJu0YwRNUEMWufTnSvQaRYPH3culHrXWo015GqV0CP6qwDhEQakFrL8
	6G6Gvhe2KYl3Q+B+XqQl9dn8K7oxe3KtwXVSZiwOyq3BVGnr9NMlZoUqFM0Yu9R1JBHY6qhdt7f
	XZzF1gnAJnDzeiyBp3pBuuG9PdY+uD2ppyG7PYGXT3MFnJZhlXwd8
X-Google-Smtp-Source: AGHT+IHZgx3StvUWO+J2QBwaDpZO9EaUbE1rjq6scoyDsKilkifQneLa/6jcOZKMSEj18fd8Q8NpDmYaHoUQYyupNg8=
X-Received: by 2002:a1f:6dc3:0:b0:4c9:79d6:7f17 with SMTP id
 i186-20020a1f6dc3000000b004c979d67f17mr8003678vkc.9.1708555812137; Wed, 21
 Feb 2024 14:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213040747.1745939-1-kevinloughlin@google.com>
 <170785457569.2934648.10119965441921727215@amd.com> <CAGdbjmJAE5Uo5LA=hkMFwp+LdnNxxKgSwgkpdWZ69kwS-tLkFw@mail.gmail.com>
 <20240216225019.upcxwd6vkxv5dp4n@amd.com>
In-Reply-To: <20240216225019.upcxwd6vkxv5dp4n@amd.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Wed, 21 Feb 2024 14:50:00 -0800
Message-ID: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
Subject: Re: [PATCH] x86/kernel: Validate ROM before DMI scanning when SEV-SNP
 is active
To: Michael Roth <michael.roth@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dionna Glaze <dionnaglaze@google.com>, 
	"H.Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Kai Huang <kai.huang@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ross Lagerwall <ross.lagerwall@citrix.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Yuntao Wang <ytcoode@gmail.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>, 
	Sidharth Telang <sidtelang@google.com>, Conrad Grobler <grobler@google.com>, 
	Andri Saar <andrisaar@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 2:50=E2=80=AFPM Michael Roth <michael.roth@amd.com>=
 wrote:
>
> On Tue, Feb 13, 2024 at 03:10:46PM -0800, Kevin Loughlin wrote:
> > On Tue, Feb 13, 2024 at 12:03=E2=80=AFPM Michael Roth <michael.roth@amd=
com> wrote:
> > >
> > > Quoting Kevin Loughlin (2024-02-12 22:07:46)
> > > > SEV-SNP requires encrypted memory to be validated before access. Th=
e
> > > > kernel is responsible for validating the ROM memory range because t=
he
> > > > range is not part of the e820 table and therefore not pre-validated=
 by
> > > > the BIOS.
> > > >
> > > > While the current SEV-SNP code attempts to validate the ROM range i=
n
> > > > probe_roms(), this does not suffice for all existing use cases. In
> > > > particular, if EFI_CONFIG_TABLES are not enabled and
> > > > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel will
> > > > attempt to access the memory at SMBIOS_ENTRY_POINT_SCAN_START (whic=
h
> > > > falls in the ROM range) prior to validation. The specific problemat=
ic
> > > > call chain occurs during dmi_setup() -> dmi_scan_machine() and resu=
lts
> > > > in a crash during boot if SEV-SNP is enabled under these conditions=
.
> > >
> > > AFAIK, QEMU doesn't actually include any legacy ROMs as part of the i=
nitial
> > > encrypted guest image, and I'm not aware of any VMM implementations t=
hat
> > > do this either.
> >
> > I'm using a VMM implementation that uses (non-EFI) Oak stage0 firmware =
[0].
> >
> > [0] https://github.com/project-oak/oak/tree/main/stage0_bin
> >
> > > If dmi_setup() similarly scans these ranges, it seems likely the same
> > > issue would be present: the validated/private regions would only cont=
ain
> > > ciphertext rather than the expected ROM data. Does that agree with th=
e
> > > behavior you are seeing?
> > >
> > > If so, maybe instead probe_roms should just be skipped in the case of=
 SNP?
> >
> > If probe_roms() is skipped, SEV-SNP guest boot also currently crashes;
> > I just quickly tried that (though admittedly haven't looked into why).
>
> default_find_smp_config() will also call smp_scan_config() on
> 0xF0000-0x10000, so that might be the additional issue you're hitting.
> If I skip that for in addition to probe_roms, then boot works for me.

Yeah, smp_scan_config() was the culprit. Thanks.

> It seems the currently handling has a bug that has been in place since th=
e
> original SEV guest code was added. If you dump the data that probe_roms()
> sees while it is scanning for instances of ROMSIGNATURE (0xaa55) in the
> region, you'll see that it is random data that changes on every boot.
> The root issue is that this region does not contain encrypted data, and
> is only being accessed that way because the early page table has the
> encryption bit set for this range.
>
> The effects are subtle: if the code ever sees a pair of bytes that look
> like ROMSIGNATURE, it will reserve that memory so it can be accessed
> later, generally just 0xc0000-0xc7fff. In extremely rare cases where the
> ciphertext's data has a checksum that happens to match the contents, it
> will use a random byte, multiple it by 512, and reserve up to 64k for
> this bogus ROM region.
>
> For SNP this resulted in a more obvious failure: a #VC exception because
> the supposedly encrypted memory was in fact not encrypted, and thus not
> PVALIDATED. Unfortunately the fix you linked to involved maintaining the
> broken SEV behavior rather than fixing this mismatch.
>
> >
> > > And perhaps dmi_setup() should similarly skip the legacy ROM ranges f=
or
> > > the kernel configs in question?
> >
> > Given (a) non-EFI firmware is supported in other SME/SEV boot code
> > patches [2], (b) this patch does not seem to introduce significant
> > complexity (it just moves [1] to earlier in the boot process to
> > additionally handle the non-EFI case), and (c) skipping
> > probe_roms()+dmi_setup() doesn't work without additional changes, I'm
> > currently still inclined to simply validate the legacy ROM ranges
> > early enough to prevent this issue (as is already done when using EFI
> > firmware).
>
> The 2 options I see are:
>
>   a) Skipping accesses to these regions for SEV. It is vaguely possible
>      some implementation out there actually did measure/load the ROM as
>      part of the initial guest image for SEV, but for SNP this would
>      have been impossible since it would have lead to the guest crashing
>      when snp_prep_roms() was called, since RMPUPDATE on the host only
>      rescinds the validated bit if there is a change to the RMP entry.
>      If it was already assigned/private/validated then the guest code
>      would detected that PVALIDATE resulted in no changes, and so it
>      would have failed with PVALIDATE_FAIL_NOUPDATE. So if you want to
>      be super sure you don't break legacy SEV implementations then you
>      could limit the change to SNP guests where it's essentially
>      guaranteed these regions are not being utilized in any functional
>      way.

Based on your explanation, I agree that (at a minimum) it makes sense
to rectify the behavior for SEV-SNP guests.

On that note, as you describe here, I skipped the 3 ROM region scans
on platforms with CC_ATTR_GUEST_SEV_SNP (and deleted the call to
snp_prep_memory()) and successfully booted. I can send that as v2.

Note that I have *not* tried skipping the scans for all SEV guest
variants (CC_ATTR_GUEST_MEM_ENCRYPT) since those boots appear to be
functioning without the change (and there is a risk of breaking the
sorts of implementations that you described); also note that
clang-built SEV-SNP guests still require [0] and [1] to function.

[0] https://lore.kernel.org/all/20240206223620.1833276-1-acdunlap@google.co=
m/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?id=3D1c811d403afd73f04bde82b83b24c754011bd0e8

>   b) Modifying the early page table setup by early_make_pgtable() to
>      clear the encrypted bit for 0xC0000-0x100000 legacy region. The
>      challenge there is everything is PMD-mapped at that stage of boot
>      and there's no infrastructure for splitting page tables to handle
>      non-2MB-aligned/sized regions.

If ever needed/desired, a slight variant of this second option might
also be providing a temporary unencrypted mapping on the fly during
the few times the regions are scanned during early boot, similar to
how __sme_early_map_unmap_mem() is already used for sme_map_bootdata()
in head64.c. I haven't tried it, but I just wanted to note it down in
case it becomes relevant.

