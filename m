Return-Path: <linux-kernel+bounces-151385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EEF8AADE9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6F628242A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A14A83CC7;
	Fri, 19 Apr 2024 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvHM1QVx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAB6823D9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713527561; cv=none; b=OV7iAy1e66m/mhRnOsclIWeVWTapqYAlE7BB031XM5ZkNwxh5go0eMvG5IutFc8OOEEa7H5uIIFx5kT6/g/6DzjxajIOJBKTgo574haFIsEwewtfnlmnu5RIpEQ5vciIkp3P/0fDB8ecFPpG8DqqEr6vaj8YgN+6t80WW+ur2UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713527561; c=relaxed/simple;
	bh=+HnpYIljW903ODlD5/xLD4aOITxYFLDumzggzFZ3LXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5gFN6YbBTK0SnTmj3UjB/IsYd1ib3FDCGAEsZLYdNMYx3I9AXbNDCRUYzZS7yPuHtuDAY33Q5+w1euyM5VGaVrN5kSTOHEWl7csoXszEh1RbWnnEHzBjxStvafw4RLMvRWnh0nQlebBumn6SfAr9RyWar+J3yDn/w98JUvPhJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvHM1QVx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713527559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9gAW74TdLSgAKKdOeHRcIuNI+2QlXI+dYyfePDOsqM=;
	b=QvHM1QVxXd24ATflP4j3EP3JLsgHH5oOiuRX4z2SfJmPwCr+muAzsDosE8SrJGYIY7Jhc9
	inL0nS2Te9StRN2JXrNa7BuxSxoI4el830nrv7l6tByDJrXGMh0N0Msr5f4+Ke4wlFuhnr
	Yg8V0jb5hVKk0kuRJ51c8ZDua88CKOM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-1UeD_w1qMQOwJNP_62--eA-1; Fri, 19 Apr 2024 07:52:37 -0400
X-MC-Unique: 1UeD_w1qMQOwJNP_62--eA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34a49f5a6baso586845f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 04:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713527557; x=1714132357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9gAW74TdLSgAKKdOeHRcIuNI+2QlXI+dYyfePDOsqM=;
        b=m9rJuEddmEmkT+cHuX2Wo3rkoWhCphk7c+bloSdEPFcDDO7e+NZ1dr/DhrJMUc5d1U
         eBqTcl1h/gGfWP6vDtqPlj/8ySYrH+qevJs4gCOlHiOT/f2EmWfC92CLf1QTD2ooaGMI
         ZDxL5jG58lXJKu+k6LCeJwD5T+u7JG9TSLwBaHu9qQ11s65DLfYwF7Y9pbzo+wDMaoXA
         YHH3zT77OGyrckOCBHMsAq9tNrPfe5R6Jedw61v1EwKj6vTF30JbynKg3kIgSXQTiWCX
         imlkm+R2BJWdNu4+wbuXK3/AlZvTbKOSHZtSJR3G0EtdmeS6Yqh0QaPRq5WlwGG0Ku/H
         ejqA==
X-Forwarded-Encrypted: i=1; AJvYcCV4H73qdivO7u2vKKmYoEmEjw88Iiu2uVaS9Ab2Vt2aDT2O86xnhmDDXNEMgB/D/CY+Yu4SEhOmSkoXNKNf6mqHen1XCzxxQCa96s5p
X-Gm-Message-State: AOJu0YzbJlFME+2AzUNSL79+woGKaqzUlwZStwdYJPKy9SaeWvNMng87
	ugAD9EhGGFh57y6R+UlPUgC6HiMDCcXNiGerhHo47sTz36JWd0nI2p9XbDNqy13WdguOZu6DueC
	W+wpHdIVc9D0HfoGDZCHHcp4IAkP72/cj4H7R87jlcJnO3ZCMAHoUI70Ej3BemePcZ0M7+K5k9s
	WLM9iET8hNodTTjx19N64Q6wZNdUxnriZlGDSp
X-Received: by 2002:adf:e683:0:b0:345:605e:fa38 with SMTP id r3-20020adfe683000000b00345605efa38mr1433587wrm.60.1713527556817;
        Fri, 19 Apr 2024 04:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfUJrGef9Pu8qycGP8hLzLT/FO8q371w7fw92YbXK5+2PaDsTI6UQGUVVeBTULcSVYlzzGDl9d79lt6LyM70w=
X-Received: by 2002:adf:e683:0:b0:345:605e:fa38 with SMTP id
 r3-20020adfe683000000b00345605efa38mr1433571wrm.60.1713527556446; Fri, 19 Apr
 2024 04:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418194133.1452059-1-michael.roth@amd.com> <20240418194133.1452059-10-michael.roth@amd.com>
In-Reply-To: <20240418194133.1452059-10-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 Apr 2024 13:52:24 +0200
Message-ID: <CABgObfYztTP+qoTa-tuPC8Au-aKhwiBkcvHni4T+n6MCD-P9Dw@mail.gmail.com>
Subject: Re: [PATCH v13 09/26] KVM: SEV: Add KVM_SEV_SNP_LAUNCH_START command
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, jroedel@suse.de, 
	thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org, seanjc@google.com, 
	vkuznets@redhat.com, jmattson@google.com, luto@kernel.org, 
	dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com, 
	peterz@infradead.org, srinivas.pandruvada@linux.intel.com, 
	rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de, 
	vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com, 
	jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com, 
	Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 9:42=E2=80=AFPM Michael Roth <michael.roth@amd.com>=
 wrote:
> +/* As defined by SEV-SNP Firmware ABI, under "Guest Policy". */
> +#define SNP_POLICY_MASK_API_MAJOR      GENMASK_ULL(15, 8)
> +#define SNP_POLICY_MASK_API_MINOR      GENMASK_ULL(7, 0)
> +
> +#define SNP_POLICY_MASK_VALID          (SNP_POLICY_MASK_SMT            |=
 \
> +                                        SNP_POLICY_MASK_RSVD_MBO       |=
 \
> +                                        SNP_POLICY_MASK_DEBUG          |=
 \
> +                                        SNP_POLICY_MASK_SINGLE_SOCKET  |=
 \
> +                                        SNP_POLICY_MASK_API_MAJOR      |=
 \
> +                                        SNP_POLICY_MASK_API_MINOR)
> +
> +/* KVM's SNP support is compatible with 1.51 of the SEV-SNP Firmware ABI=
 */
> +#define SNP_POLICY_API_MAJOR           1
> +#define SNP_POLICY_API_MINOR           51

> +static inline bool sev_version_greater_or_equal(u8 major, u8 minor)
> +{
> +       if (major < SNP_POLICY_API_MAJOR)
> +               return true;

Should it perhaps refuse version 0.x? With something like a

#define SNP_POLICY_API_MAJOR_MIN    1

to make it a bit more future proof (and testable).

> +       major =3D (params.policy & SNP_POLICY_MASK_API_MAJOR);

This should be >> 8. Do the QEMU patches not set the API version? :)

Paolo


