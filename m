Return-Path: <linux-kernel+bounces-32269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB34835942
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000181F21891
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD72EA48;
	Mon, 22 Jan 2024 02:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bygA4KGi"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3236F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705889622; cv=none; b=Uf7Nq+UDC38iQ8zxYtF9bSutqz1r+SgvXDnf7WyeO+NsfY/1u4UQ8xs6nd36WvPHFrtJ5stUJ28qOQHiUCxU5eeS03FXShy+RPVZlI6uM15rwZx+3JcAGDOemG8K8IdoM3XpShTta5n4jv7Pe7PIU5rr6xR6aQI7N/azUaEfUVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705889622; c=relaxed/simple;
	bh=icNW4/xhKqZ6WbDPXU1c9QcZmWfNcULyBBu4f7nUWug=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZFzhE8NpUuBDkDHAGoVOtKBJZNLkn0aakn/aXuyPfWqf7o8U28VFbpqd8zJSE1VGwzAHFRXwiY2mwIp/pWCTQhXiXXA9NmUgwD9bWq9w0Tj/4z6TJUQIKvp8Ctp00hOyl0x6XcJ1VGPOGiIXmDwTD9c5hVjWSvstTpejjrtGqpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bygA4KGi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d72043fa06so118965ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 18:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705889620; x=1706494420; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJresfRYgND1exp7nzUKm6DtOgS/nV0ltqFvHDxyhCU=;
        b=bygA4KGi3Cvq3ooOZCl0iRa4uKfpIkXQMVL2em0OtEAR29+E1dYotSULi3ndCqbY9e
         d2YNz3XHpZizT3HPiwu4hZKRhpfNZbZ9HVVSO0DwAj8uaes8IrTu22jdV6OQlBMQA1NI
         pRcnMzfpHQYDqcvLY8dzsCGza4K5LJrXbHNs6qQejcaB/vYAUmm+R13pT+ywtvfhubNa
         ETv5vXdL/2kqKeGwYixw8xp3wOhu9yqvquVdj3m1JO/2qNa2VHcbEcJofS45hF6fi5z4
         P16qIWO1vqiWI1WGRjBoLTbcyiv1xRKR+NS4YUwVaT6/6Q6qxRTh3dLYza468MdLgd3V
         KijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705889620; x=1706494420;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJresfRYgND1exp7nzUKm6DtOgS/nV0ltqFvHDxyhCU=;
        b=ua8w7B1ZX5nJ49UVbgUKAssd4QIID6ikKXhKP/4ePaw9MCSxH2iTnoA6LZtXijxClx
         DoBr44JZjCKFIzizsvxZAkqQ3nSVY4jSolithvP0XaqDWCmt/4Q7N40a/h6NZxC+OWlZ
         9z55nGIbnY0oNwMcm0ozfQGsmrp6IrKgYRENJnMqaQ5Vmo6RLTAqoDDkxDJgeFN3m+AW
         /iaTnbet2QL5NHMt4QqxX37QXIBrSGZuiEcWKSG50YpY4d1O4ppU1cPHT5ZlNhhqRBt9
         KGb5MV3sNZW+vJ0OjbdjMd3uGSaLyV4hTI8p0qSO73Vx2gXWqxF06xGqcbtDe23K3vTk
         WQFg==
X-Gm-Message-State: AOJu0YxdGaeDGfogJKqIiOIGWLd0cExFwga9w9vBU/WxR2eW1qquYmmh
	Fw6Vyqhux/v2bTKWFKwIP4f+hJWv4DJm
X-Google-Smtp-Source: AGHT+IFsZ0c1WBY0CQFpaLyD11HBFC0LBPll1/o26BoV+BpzENSWDv5QO0phrYVxgiXuQtTkUEu5JQ==
X-Received: by 2002:a17:902:e88a:b0:1d5:4c40:bf01 with SMTP id w10-20020a170902e88a00b001d54c40bf01mr154243plg.17.1705889619744;
        Sun, 21 Jan 2024 18:13:39 -0800 (PST)
Received: from smtpclient.apple ([2620:0:1008:1:cca:f75b:5f93:609b])
        by smtp.gmail.com with ESMTPSA id mm3-20020a1709030a0300b001d740d195e0sm1736763plb.93.2024.01.21.18.13.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jan 2024 18:13:39 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
From: Qinkun Bao <qinkun@google.com>
In-Reply-To: <Za1G9I+tYuIL9ser@vermeer>
Date: Sun, 21 Jan 2024 18:13:28 -0800
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CF3D8DE1-AD47-4A77-B8BD-8A12A6F7E9DB@google.com>
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240114223532.290550-4-sameo@rivosinc.com>
 <1bbf8d3e-aa94-48c7-a1e4-76f9eefc4af7@linux.intel.com>
 <65a72c305291f_3b8e29484@dwillia2-xfh.jf.intel.com.notmuch>
 <5539c533-37b2-4b12-a5c5-056881cf8e3c@linux.intel.com>
 <Za1G9I+tYuIL9ser@vermeer>
To: Samuel Ortiz <sameo@rivosinc.com>,
 jiewen.yao@intel.com,
 ken.lu@intel.com
X-Mailer: Apple Mail (2.3774.300.61.1.2)



> On Jan 21, 2024, at 8:31=E2=80=AFAM, Samuel Ortiz <sameo@rivosinc.com> =
wrote:
>=20
> On Tue, Jan 16, 2024 at 07:35:30PM -0800, Kuppuswamy Sathyanarayanan =
wrote:
>>=20
>> On 1/16/24 5:24 PM, Dan Williams wrote:
>>> Kuppuswamy Sathyanarayanan wrote:
>>>> On 1/14/24 2:35 PM, Samuel Ortiz wrote:
>>>>> Many user space and internal kernel subsystems (e.g. the Linux =
IMA)
>>>>> expect a Root of Trust for Storage (RTS) that allows for extending
>>>>> and reading measurement registers that are compatible with the TCG =
TPM
>>>>> PCRs layout, e.g. a TPM. In order to allow those components to
>>>>> alternatively use a platform TSM as their RTS, a TVM could map the
>>>>> available RTMRs to one or more TCG TPM PCRs. Once configured, =
those PCR
>>>>> to RTMR mappings give the kernel TSM layer all the necessary =
information
>>>>> to be a RTS for e.g. the Linux IMA or any other components that =
expects
>>>>> a TCG compliant TPM PCRs layout.
>>>>>=20
>>>>> TPM PCR mappings are configured through configfs:
>>>>>=20
>>>>> // Create and configure 2 RTMRs
>>>>> mkdir /sys/kernel/config/tsm/rtmrs/rtmr0
>>>>> mkdir /sys/kernel/config/tsm/rtmrs/rtmr1
>>>>> echo 0 > /sys/kernel/config/tsm/rtmrs/rtmr0/index
>>>>> echo 1 > /sys/kernel/config/tsm/rtmrs/rtmr1/index
>>>>>=20
>>>>> // Map RTMR 0 to PCRs 4, 5, 6, 7 and 8
>>>>> echo 4-8 > /sys/kernel/config/tsm/rtmrs/rtmr0/tcg_map
>>>>>=20
>>>>> // Map RTMR 1 to PCRs 16, 17 and 18
>>>>> echo 16-18 > /sys/kernel/config/tsm/rtmrs/rtmr1/tcg_map
>>>> Any information on how this mapping will be used by TPM or IMA ?
>>>>=20
>>>> RTMR to PCR mapping is fixed by design, right? If yes, why allow
>>>> user to configure it. We can let vendor drivers to configure it, =
right?
>>> I assume the "vendor driver", that publishes the RTMR to the =
tsm-core,
>>> has no idea whether they will be used for PCR emulation, or not. The =
TPM
>>> proxy layer sitting on top of this would know the mapping of which =
RTMRs
>>> are recording a transcript of which PCR extend events.
>>=20
>> My thinking is, since this mapping is ARCH-specific information
>> and fixed by design, it makes more sense to hide this detail in the
>> vendor driver than letting userspace configure it. If we allow users =
to
>> configure it, there is a chance for incorrect mapping.
>=20
> I think I agree with the fact that letting users configure that =
mapping
> may be error prone. But I'm not sure this is an architecture specific
> mapping, but rather a platform specific one. I'd expect the guest =
firmware
> to provide it through e.g. the MapPcrToMrIndex EFI CC protocol.
>=20
> So I agree I should remove the user interface for setting that =
mapping,
> and pass it from the provider capabilities instead. It is then up to =
the
> provider to choose how it'd build that information (hard coded, from
> EFI, etc).

The UEFI specification has defined the mapping relationship between the=20=

TDX RTMR and TPM PCRs (See =
https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#intel-trus=
t-domain-extension). The current RTMR implementation in the boot loader=20=

is =E2=80=9Chooked=E2=80=9D in the implementation for the TPM.=20

When the bootloader needs to extend the PCR value, it calls=20
`map_pcr_to_mr_index`  to retrieve the corresponding RTMR index and=20
then extends the RTMR. Considering this behavior, I don=E2=80=99t think =
we should
allow users to configure the mappings between the PCR and RTMR. (See =
https://github.com/rhboot/shim/pull/485/files).

Add Jiewen (owner of the RTMR changes in the firmware) and Ken (
owner of the RTMR changes in the boot loader) for the visibility.

>=20
>> Regarding the TPM proxy, I am still not clear how it is going to use
>> this mapping. If we want to provide TPM like feature, it needs a
>> special kernel TPM driver, right? Even if we enable TPM support
>> with RTMR, I assume it can only support pcr_extend().
>=20
> Extend and read, yes.
>=20
>> Other TPM
>> features should be disabled. If yes, since we already have this ABI
>> for measurement extension, why again support it via TPM or did
>> I misunderstand the use case.
>=20
> I am not sure the TPM compatibility is always needed, but for =
subsystems
> (like e.g. IMA) that look for a TPM as their root of trust for =
storage,
> providing the extend+read ABI and the PCR mapping should be =
sufficient.
>=20
> Cheers,
> Samuel.
>=20
>=20


