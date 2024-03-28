Return-Path: <linux-kernel+bounces-122564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C167E88F9AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24EF1C2BFEC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622275787B;
	Thu, 28 Mar 2024 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="WaP4xcod"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4903D57870
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613142; cv=none; b=b/ZJUQYpH/bceYQep1bUO+FMOGrBsBa6wsfmeE9vHJlFrdrr9DOAwoQRKCs7co5MLXi33R1buZ+lEcX6euczqZIw4mj6y2mS55L4M/CWWo1ufyQoVsLmiRWy6F+ZZhTl0lXRDLMgMXLSsOCEhknrRdcG2XcPIWreu+T25qcuakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613142; c=relaxed/simple;
	bh=yjnhXmaMnVEbDN87O8WMVQMObw//YS/XVKq+IiQQtI0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WZ/2uiCuPSJNHw4rqJWAY5ZF/qO5ZxLfAvhcA9pRWva4/FWcauY8vDC6YIu1AOnii8WT8k6u0vVqFPsvG7i5oC8SamsV2JFVzGPJHzP7KYyrrOnxKbjdyzH1HjfU9pwWsBr5lLebgEScyDyoMoDeJqx1fcWyWkMVTgb6mptpG1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=WaP4xcod; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513e25afabaso630691e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1711613137; x=1712217937; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjvmSG9QLL+8JxFPMAhTrQfWNaL+EODKgEV1lHWuZn0=;
        b=WaP4xcoddk73Nw4PJr7tcYsjC8ODRZbNEVLML3noy2BGlgMUOq7AFj6D3+3jh2f8kx
         uMrbU9cKr/pyFviAp7nXuTD69BJAeFJVU7r1Sn5nKvIHj74Vs5e4WrBxDjsPmOIWX383
         UXnziBdZQtmpIPZaGvUiFs38rtz9zgczH7yyy3B0QMDdKmbKNzKvPL0JmNUUI3kCQ8y+
         EE/cVPx8sMk+38vWaqrk4ypO18Tu6amGI67p4P6lLep29uIR2lBGEKrwUAHr3GeQnXF2
         vHeLtlrv1dBqKwQWAaC+YAmrvnClqF0JPDqUDg4pD6PB9kcHLA2A6UGIw2rsLe9rGsXD
         J2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711613137; x=1712217937;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjvmSG9QLL+8JxFPMAhTrQfWNaL+EODKgEV1lHWuZn0=;
        b=NzJT7JlRGGYDIjPVwk95eexvuWsOXL2qnrxVJTpPimNW+fZF4w/JKtTnsUolXq4I20
         7WxDSMp/c3hoEfbiyYJflaFv7U4GCbIjlb3GBkmGNZGxNN/mg65CYkiZUSpyM+Z3CLas
         xSjZF3pKxjZAHEE7ZM5IGPsGJ357md+89gUQ1s6Zr9H6URfLcr+8WdRmuAsSzAQ2sAY1
         2ly/O+T0TP+zBy+R7o9JIeammytWJjrKN+uIe5x/4u3NyHKzN3T3Ix0unJaof6KcVvd9
         R43qRmA5yfXd3JK1SLu9ZPMcGAzJr9/SUikeOO7EWXPuFF/j4MwgMb0hC/NgzRaFsjtX
         Ii8A==
X-Forwarded-Encrypted: i=1; AJvYcCVvMkaKLaB1CmsxcD7+ITTPuX2pirPUWlWzr+3QHdqi0piNO+i0hKLQOVF+vvMfxnZkD5ORIeME3JNeJ7kSTnDVQScK45ysycalybki
X-Gm-Message-State: AOJu0Yw6XdQf/BQ+WaEc5+H8ILYgKM0Fn6vyPsRcFQP3eR2ML4JEcVL4
	OMAaGi3pXExDUva/c1bdB7TGejC1g/0QqDEwlmJuImf6hkHhU9TMPstP2MVil8A=
X-Google-Smtp-Source: AGHT+IFrYwSIqg79NLq2byoG3OlkUZikLzETvtMHvIzq87EemGEvn6YgogXjKDwDSMwvzIJu/C/jBA==
X-Received: by 2002:a05:6512:312d:b0:513:4a0c:b83d with SMTP id p13-20020a056512312d00b005134a0cb83dmr1263720lfd.46.1711613137216;
        Thu, 28 Mar 2024 01:05:37 -0700 (PDT)
Received: from smtpclient.apple ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b00413eb5aa694sm1444424wmo.38.2024.03.28.01.05.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2024 01:05:36 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v7 6/6] docs: trusted-encrypted: add DCP as new trust
 source
From: David Gstir <david@sigma-star.at>
In-Reply-To: <D04N9E61QWYB.3IPEEGVPY6V8L@kernel.org>
Date: Thu, 28 Mar 2024 09:05:24 +0100
Cc: Mimi Zohar <zohar@linux.ibm.com>,
 James Bottomley <jejb@linux.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Shawn Guo <shawnguo@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 NXP Linux Team <linux-imx@nxp.com>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 sigma star Kernel Team <upstream+dcp@sigma-star.at>,
 David Howells <dhowells@redhat.com>,
 Li Yang <leoyang.li@nxp.com>,
 Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Tejun Heo <tj@kernel.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 linux-doc@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org,
 "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
 Richard Weinberger <richard@nod.at>,
 David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3831544-E47C-4AEB-9963-536F0B1EE8FD@sigma-star.at>
References: <20240327082454.13729-1-david@sigma-star.at>
 <20240327082454.13729-7-david@sigma-star.at>
 <D04N9E61QWYB.3IPEEGVPY6V8L@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Jarkko,

> On 27.03.2024, at 16:40, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Wed Mar 27, 2024 at 10:24 AM EET, David Gstir wrote:
>> Update the documentation for trusted and encrypted KEYS with DCP as =
new
>> trust source:
>>=20
>> - Describe security properties of DCP trust source
>> - Describe key usage
>> - Document blob format
>>=20
>> Co-developed-by: Richard Weinberger <richard@nod.at>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> Co-developed-by: David Oberhollenzer =
<david.oberhollenzer@sigma-star.at>
>> Signed-off-by: David Oberhollenzer =
<david.oberhollenzer@sigma-star.at>
>> Signed-off-by: David Gstir <david@sigma-star.at>
>> ---
>> .../security/keys/trusted-encrypted.rst       | 85 =
+++++++++++++++++++
>> 1 file changed, 85 insertions(+)
>>=20
>> diff --git a/Documentation/security/keys/trusted-encrypted.rst =
b/Documentation/security/keys/trusted-encrypted.rst
>> index e989b9802f92..81fb3540bb20 100644
>> --- a/Documentation/security/keys/trusted-encrypted.rst
>> +++ b/Documentation/security/keys/trusted-encrypted.rst
>> @@ -42,6 +42,14 @@ safe.
>>          randomly generated and fused into each SoC at manufacturing =
time.
>>          Otherwise, a common fixed test key is used instead.
>>=20
>> +     (4) DCP (Data Co-Processor: crypto accelerator of various i.MX =
SoCs)
>> +
>> +         Rooted to a one-time programmable key (OTP) that is =
generally burnt
>> +         in the on-chip fuses and is accessible to the DCP =
encryption engine only.
>> +         DCP provides two keys that can be used as root of trust: =
the OTP key
>> +         and the UNIQUE key. Default is to use the UNIQUE key, but =
selecting
>> +         the OTP key can be done via a module parameter =
(dcp_use_otp_key).
>> +
>>   *  Execution isolation
>>=20
>>      (1) TPM
>> @@ -57,6 +65,12 @@ safe.
>>=20
>>          Fixed set of operations running in isolated execution =
environment.
>>=20
>> +     (4) DCP
>> +
>> +         Fixed set of cryptographic operations running in isolated =
execution
>> +         environment. Only basic blob key encryption is executed =
there.
>> +         The actual key sealing/unsealing is done on main =
processor/kernel space.
>> +
>>   * Optional binding to platform integrity state
>>=20
>>      (1) TPM
>> @@ -79,6 +93,11 @@ safe.
>>          Relies on the High Assurance Boot (HAB) mechanism of NXP =
SoCs
>>          for platform integrity.
>>=20
>> +     (4) DCP
>> +
>> +         Relies on Secure/Trusted boot process (called HAB by =
vendor) for
>> +         platform integrity.
>> +
>>   *  Interfaces and APIs
>>=20
>>      (1) TPM
>> @@ -94,6 +113,11 @@ safe.
>>=20
>>          Interface is specific to silicon vendor.
>>=20
>> +     (4) DCP
>> +
>> +         Vendor-specific API that is implemented as part of the DCP =
crypto driver in
>> +         ``drivers/crypto/mxs-dcp.c``.
>> +
>>   *  Threat model
>>=20
>>      The strength and appropriateness of a particular trust source =
for a given
>> @@ -129,6 +153,13 @@ selected trust source:
>>      CAAM HWRNG, enable CRYPTO_DEV_FSL_CAAM_RNG_API and ensure the =
device
>>      is probed.
>>=20
>> +  *  DCP (Data Co-Processor: crypto accelerator of various i.MX =
SoCs)
>> +
>> +     The DCP hardware device itself does not provide a dedicated RNG =
interface,
>> +     so the kernel default RNG is used. SoCs with DCP like the =
i.MX6ULL do have
>> +     a dedicated hardware RNG that is independent from DCP which can =
be enabled
>> +     to back the kernel RNG.
>> +
>> Users may override this by specifying ``trusted.rng=3Dkernel`` on the =
kernel
>> command-line to override the used RNG with the kernel's random number =
pool.
>>=20
>> @@ -231,6 +262,19 @@ Usage::
>> CAAM-specific format.  The key length for new keys is always in =
bytes.
>> Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
>>=20
>> +Trusted Keys usage: DCP
>> +-----------------------
>> +
>> +Usage::
>> +
>> +    keyctl add trusted name "new keylen" ring
>> +    keyctl add trusted name "load hex_blob" ring
>> +    keyctl print keyid
>> +
>> +"keyctl print" returns an ASCII hex copy of the sealed key, which is =
in format
>> +specific to this DCP key-blob implementation.  The key length for =
new keys is
>> +always in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 =
bits).
>> +
>> Encrypted Keys usage
>> --------------------
>>=20
>> @@ -426,3 +470,44 @@ string length.
>> privkey is the binary representation of TPM2B_PUBLIC excluding the
>> initial TPM2B header which can be reconstructed from the ASN.1 octed
>> string length.
>> +
>> +DCP Blob Format
>> +---------------
>> +
>> +The Data Co-Processor (DCP) provides hardware-bound AES keys using =
its
>> +AES encryption engine only. It does not provide direct key =
sealing/unsealing.
>> +To make DCP hardware encryption keys usable as trust source, we =
define
>> +our own custom format that uses a hardware-bound key to secure the =
sealing
>> +key stored in the key blob.
>> +
>> +Whenever a new trusted key using DCP is generated, we generate a =
random 128-bit
>> +blob encryption key (BEK) and 128-bit nonce. The BEK and nonce are =
used to
>> +encrypt the trusted key payload using AES-128-GCM.
>> +
>> +The BEK itself is encrypted using the hardware-bound key using the =
DCP's AES
>> +encryption engine with AES-128-ECB. The encrypted BEK, generated =
nonce,
>> +BEK-encrypted payload and authentication tag make up the blob format =
together
>> +with a version number, payload length and authentication tag::
>> +
>> +    /*
>> +     * struct dcp_blob_fmt - DCP BLOB format.
>> +     *
>> +     * @fmt_version: Format version, currently being %1
>> +     * @blob_key: Random AES 128 key which is used to encrypt =
@payload,
>> +     *            @blob_key itself is encrypted with OTP or UNIQUE =
device key in
>> +     *            AES-128-ECB mode by DCP.
>> +     * @nonce: Random nonce used for @payload encryption.
>> +     * @payload_len: Length of the plain text @payload.
>> +     * @payload: The payload itself, encrypted using AES-128-GCM and =
@blob_key,
>> +     *           GCM auth tag of size AES_BLOCK_SIZE is attached at =
the end of it.
>> +     *
>> +     * The total size of a DCP BLOB is sizeof(struct dcp_blob_fmt) + =
@payload_len +
>> +     * AES_BLOCK_SIZE.
>> +     */
>> +    struct dcp_blob_fmt {
>> +            __u8 fmt_version;
>> +            __u8 blob_key[AES_KEYSIZE_128];
>> +            __u8 nonce[AES_KEYSIZE_128];
>> +            __le32 payload_len;
>> +            __u8 payload[];
>> +    } __packed;
>=20
> I'm thinking here given that you need to replicate the same thing that
> is in the source files. E.g. Documentation/gpu/i915.rst.
>=20
> The rationale would so many sources so maybe it would make sense to
> maintain this in the source code.
>=20
> Also this documents how to generally insert documentation inline:
> https://docs.kernel.org/doc-guide/kernel-doc.html
>=20
> I.e. I'm feeling that this is good time to improve scalability so that
> documentation will keep up to date. Also then backend specific patches
> mostly go to their subdirectories and not to Documentation/ subtree
> (or that would be more rare case).
>=20
> So a good chance to do more than just a new backend for the benefit
> of the trusted keys subsystem :-)
>=20
> Also, later on if something is changed e.g. in the above struct you
> don't have to do matching update to the documentation so it will save
> time too (over time).

sound good! I=E2=80=99ll maintain the blob format documentation to the =
source and insert=20
a reference in the documentation. Thanks for pointing that out!

Is there anything else I can improve for this patchset? I=E2=80=99d like =
to include that in v8
too and make it the last iteration of this patchset.

Thanks,
David=

