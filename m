Return-Path: <linux-kernel+bounces-58325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A7F84E4B4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB27285859
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6167D417;
	Thu,  8 Feb 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAsEs6Rv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5897B3DB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408600; cv=none; b=m/rMBBAxEncvzXgbJxHhYM8DKWcOW4hJxKSKVshcvfEM7QRw6Z5GoNE9QgWrp4g7S5yDU3nKb/ENZ8jNyg+/7F444r2WK8NF+s9q9mxpb8ceq+6E4M+/jVBN5oh8GZewDRNLp6bXtrT77SCoc8yJWlp9+rkgaQAJgewqpmPipBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408600; c=relaxed/simple;
	bh=8b6yhfgHTrK7SL+o2yqwRJqBoR4vo8TvUDQmtT6mkeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5QO0bxQ0K/m1fU8r3RuvZtT6+DLHHJeB6VkcbzZfuKx6BL8Wzo/Zdd5NQzaLYbnPSsR0MUQP9J/XPdjHGegtY007xGIiz09JzaByNiBxUhHoVQPvggn62pjrKuvl7dwINitUBpW4iJUPyRpFYsao2mdQqJ7LZJu/4I4AQKqRuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAsEs6Rv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707408597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDmR4tHnXMzdgyQmi3H+OCa7thhQCaZGsxtXTelmwuA=;
	b=UAsEs6RvmOhc5c8mX8Fzi9OFB2xqpI3X8bYQAWT94LIW3xb0APi/cDqoSPZUtbYG117L1a
	rRUT+OQmEBOP49whnV5z6iOio7YK5/EEpXfmh2p4FBHutWKt7bcOBi8vF8NfHSug0GKcrW
	1zlKvfpgdxZK/nZ04BOLORe1CanLRb0=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-VtkL5YNUNA-n8Y1SzAEjrA-1; Thu, 08 Feb 2024 11:09:56 -0500
X-MC-Unique: VtkL5YNUNA-n8Y1SzAEjrA-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363c5eca20eso13094295ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 08:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707408595; x=1708013395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDmR4tHnXMzdgyQmi3H+OCa7thhQCaZGsxtXTelmwuA=;
        b=TnKchytArHA8Tw3uugYKEXpHwclI27S+xvv5nUMB2JBU6i0oPb+Jn48QZokGAw9sgb
         n9iWGd2MpBfzM+HGpMD5Fq/6myUElp7k62C209muDxDzIzTJHID1IMaCpmGdLkmGnTzq
         Ru6nP691fk9pxVdXp8clTyO9SjqPs27xFgfzcxGYoBbDBv5X5X4csL2EdSyN7otoy1rA
         7EoPHYhpXGTzCEzmkyk+5P+VUJN764pwLcVpXmA4KJXG3r9QmTciHHFDNTVnem9VHE7a
         vmsE6RpcfwV39aIgD20jf1g1jxsJPzMft9egesamuBqwFsSANcocCeV5/XxV7QR53Iq/
         STNw==
X-Forwarded-Encrypted: i=1; AJvYcCUfonpe+LpDItTgbyELeMG9NYhd1U2hjM12aQ+jkXb/HAVjmR4MFcVzkV2Y65ueghCF3SV4Qvsowg7ZMbQyX7NlewH0n1o5NqZ7QbAH
X-Gm-Message-State: AOJu0YyvGgnun/uF6y7P7n3m2qHjIIItVysWOMK/oqc5iqIT96TJ2VFh
	ubJo/vEujpi3SJfrdkMxeT8lTWuZJ+Qg9Inyo9Al2rbbAKAG8CaGspyZNg+WT8VBC6JlG3GE792
	mdnjVO74kIHrrLqz8mtd6vyPNkTxmvnlWo7ufzLfDarn8PG411SgCzOUqrR1ebg==
X-Received: by 2002:a92:603:0:b0:363:c919:2713 with SMTP id x3-20020a920603000000b00363c9192713mr8586148ilg.22.1707408595232;
        Thu, 08 Feb 2024 08:09:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpIxBR8eMWhkHq5KoRpU8/4mjUiBShDenZIpFCN7Unh14JXNhOvvFTsgG1RPRhQA12D8cNCg==
X-Received: by 2002:a92:603:0:b0:363:c919:2713 with SMTP id x3-20020a920603000000b00363c9192713mr8586101ilg.22.1707408594914;
        Thu, 08 Feb 2024 08:09:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZJoqj5Isq+p556FX3b/py3/DV7OopvrH+GGYskZGGSMob/9P2Mu2LHPFEL52ws78iXNOl6RUPlrkzhAAn/aFSZL6OmE8L3pLVvSD+oAR/KOaLiHISuyPHnOItQU/cbdoR+jk/hK8apYxgEjxusDUcYpVkKwd57wUuN9S9io4ySpzkWjZjpjxhRIrEtgZrU33QoX6EV/wzXc9am3aim8QeWmGMu/jtgd38jobbIrWOyARM0N7vgNi4skcAy/grRUGUh1hjewjYobq1FCDI1vxJNto8CyP/xmrw5i1Mc2HZ53PsGZLWM0an+QFpksmOzI8hd/Ud7dOG0r0kRdVW+HYDsHvYN6sqn+9NUQBvqacYSbDjHu1O22h5+GENH7XAR6BSvxNU7LPR5ibcT9RDmeC96QmZK4Acr9WrFp+ygfZh9+L5PolCRXdW4USfDz7oOCpgArcwinknJsqtkEf4z9U+Cvz3f2BCi7UDG4jARAkmq3zZ0QJNCg1BUHChIdrcSdZznQqf23m87Yn7q0GtllT9HJWd0AGWiGHSZgGdpMtr/0fSy5XkRApAZYFF09+bzbGR2BciXlZkiGR0kG15v0raYfioSxCsGbsYjaEa/klalbbLGyfgE2HKdA0XVMe29PXhk1M6TLPRqRS/pkOILG5L08g6VeuNWVibeEhsiWmr9bhPaLnF90fABk0E4rmW1IOgJvbktWLXxXFMcm0JS1LFi8LU8lOnlK6Vl4+8kGnoWdJ4aPFPUl9AQejjIyhX+dio2kt0K98ww3hn7GosuVLjN07ZEU75fUglFRMo8xkOQxvbitARxcQU3wa++3M4EF2T2k5o5TSDtxk9x3s=
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id s5-20020a92cc05000000b00363c8e5a1a1sm1077348ilp.44.2024.02.08.08.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:09:50 -0800 (PST)
Date: Thu, 8 Feb 2024 09:09:47 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 "mst@redhat.com" <mst@redhat.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "clg@redhat.com" <clg@redhat.com>,
 "oleksandr@natalenko.name" <oleksandr@natalenko.name>, "K V P,
 Satyanarayana" <satyanarayana.k.v.p@intel.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "brett.creeley@amd.com" <brett.creeley@amd.com>,
 "horms@kernel.org" <horms@kernel.org>, Rahul Rameshbabu
 <rrameshbabu@nvidia.com>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, "Currid,
 Andy" <acurrid@nvidia.com>, Alistair Popple <apopple@nvidia.com>, "John
 Hubbard" <jhubbard@nvidia.com>, Dan Williams <danw@nvidia.com>, "Anuj
 Aggarwal (SW-GPU)" <anuaggarwal@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v17 3/3] vfio/nvgrace-gpu: Add vfio pci variant module
 for grace hopper
Message-ID: <20240208090947.1254e72c.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB527640ADE99D92210977E7CA8C442@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240205230123.18981-1-ankita@nvidia.com>
	<20240205230123.18981-4-ankita@nvidia.com>
	<20240208003210.000078ba.zhi.wang.linux@gmail.com>
	<20240207162740.1d713cf0.alex.williamson@redhat.com>
	<SA1PR12MB7199A9470EC2562C5BCC2FAFB0442@SA1PR12MB7199.namprd12.prod.outlook.com>
	<BN9PR11MB527640ADE99D92210977E7CA8C442@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Feb 2024 07:21:40 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Ankit Agrawal <ankita@nvidia.com>
> > Sent: Thursday, February 8, 2024 3:13 PM =20
> > >> > +=C2=A0=C2=A0=C2=A0 * Determine how many bytes to be actually read=
 from the
> > >> > device memory.
> > >> > +=C2=A0=C2=A0=C2=A0 * Read request beyond the actual device memory=
 size is
> > >> > filled with ~0,
> > >> > +=C2=A0=C2=A0=C2=A0 * while those beyond the actual reported size =
is skipped.
> > >> > +=C2=A0=C2=A0=C2=A0 */
> > >> > +=C2=A0=C2=A0 if (offset >=3D memregion->memlength)
> > >> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mem_=
count =3D 0; =20
> > >>
> > >> If mem_count =3D=3D 0, going through nvgrace_gpu_map_and_read() is n=
ot
> > >> necessary. =20
> > >
> > > Harmless, other than the possibly unnecessary call through to
> > > nvgrace_gpu_map_device_mem().=C2=A0 Maybe both =20
> > nvgrace_gpu_map_and_read() =20
> > > and nvgrace_gpu_map_and_write() could conditionally return 0 as their
> > > first operation when !mem_count.=C2=A0 Thanks,
> > >
> > >Alex =20
> >=20
> > IMO, this seems like adding too much code to reduce the call length for=
 a
> > very specific case. If there aren't any strong opinion on this, I'm pla=
nning to
> > leave this code as it is. =20
>=20
> a slight difference. if mem_count=3D=3D0 the result should always succeed
> no matter nvgrace_gpu_map_device_mem() succeeds or not. Of course
> if it fails it's already a big problem probably nobody cares about the su=
btle
> difference when reading non-exist range.
>=20
> but regarding to readability it's still clearer:
>=20
> if (mem_count)
> 	nvgrace_gpu_map_and_read();
>=20

The below has better flow imo vs conditionalizing the call to
map_and_read/write and subsequent error handling, but I don't think
either adds too much code.  Thanks,

Alex

--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -429,6 +429,9 @@ nvgrace_gpu_map_and_read(struct nvgrace_gpu_vfio_pci_co=
re_device *nvdev,
        u64 offset =3D *ppos & VFIO_PCI_OFFSET_MASK;
        int ret;
=20
+       if (!mem_count)
+               return 0;
+
        /*
         * Handle read on the BAR regions. Map to the target device memory
         * physical address and copy to the request read buffer.
@@ -547,6 +550,9 @@ nvgrace_gpu_map_and_write(struct nvgrace_gpu_vfio_pci_c=
ore_device *nvdev,
        loff_t pos =3D *ppos & VFIO_PCI_OFFSET_MASK;
        int ret;
=20
+       if (!mem_count)
+               return 0;
+
        ret =3D nvgrace_gpu_map_device_mem(index, nvdev);
        if (ret)
                return ret;


