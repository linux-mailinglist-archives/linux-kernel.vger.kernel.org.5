Return-Path: <linux-kernel+bounces-85773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F1D86BA91
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB221F26113
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5822E1361B9;
	Wed, 28 Feb 2024 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImeQDEUF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4DE1361A3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709158200; cv=none; b=kV9O9ScEMMWV13TXz5sHo1853xI9RdtmnwLi23r426OtgAz2I61AWgRW5OPfClO1xqLQ+DIDAjGlrpjP8JsijjoRmsYeRkv4M4BzopRszKmMXN1h5zm6It1YJ6Cp1baNBvTZ0XZ68xJGz5EnqmKt1Zrv0KQ1vIQWN5KWnHvOn5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709158200; c=relaxed/simple;
	bh=FQZMCebfNSkeDmZFSWAulJ5x1GW1PgsPZyHv7UHk+Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUVExbyAaiHoTapOvRn1IPK60YHsql4GnS5f8ASAhhKe/O6B89IzDxgwqGAU4IDmU/MPbFMvXuOTRQoNT9N1nJzs1xO+LYC76SYJFkXfB/56isSMqP6+F36DEyZ1yL4VYrUHcvZv2S3r/8M/QH74q9wRN/XoUwSJ7ioas9VCsVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ImeQDEUF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709158197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B+EV2lT6BWSdE6oX0hxuy5LN6iik9wzjXnU7iqkhDv0=;
	b=ImeQDEUFSah36PQ9XRWRirI63ajp2om+Wyz3bZKkOAS1q03UONY/D8mcgDKOz+o9mV1SBJ
	nqX3IbSPwgabm83ejQO0WzgUZ+W8LnhhBT4zeCxPDzHpJE2y9hCnwxYXW++bh5AU7UHBdN
	JVPQv9ZqOhP5R+QFtJAo43a0EZAP2Ro=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-sGxDJZOqMWKC2THDiXaxFQ-1; Wed, 28 Feb 2024 17:09:55 -0500
X-MC-Unique: sGxDJZOqMWKC2THDiXaxFQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-56618452b5eso220165a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:09:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709158193; x=1709762993;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+EV2lT6BWSdE6oX0hxuy5LN6iik9wzjXnU7iqkhDv0=;
        b=vgqyBExLbFn4Z43DAbSy/tEfFYuJ2Y45PtwasCnLpNtpG40++dAVXcduJtVq3GKg7c
         hq1rw3jWCH1OUlbZJiDQtTLuIhYebTmIUbhKso0iJdUGmBudWY2CB6rZ8bSpjKrr1dg8
         IQhLO5bdPw1HZWMUqUd9q8dwiRWoLeWcnLa5laShonQzCwVCFiR0wH2ZIoAL+j1Ktepu
         vlFaO7WpSG46LlmWriwEXTqRG+tB17BDArbXGosQcG7Csn9LcbHg/8MDAMr1FVD7+H7X
         c5SwpFsbstdM1lulkFDdaEKLL27fO09kX+A8qefb5hml8X6QE05dywucoqVpoh35r2Ww
         qy6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6HRP34P3xEljZdAJD06uBRYfSJOCImuzE0B9JTmhXUGBhYalF3wL23y8WmPBd5o6XszD6OYlxncMKUoPwI9TMrncZYj0EgkGzOkfw
X-Gm-Message-State: AOJu0Yw0Z4hxhj5F3q9VlBaFt9gx4Ii6Kznz8x+EYbyWq+5znnR4uRib
	FnoQWOaReKus47rDKcA4gMLrTcUOZHDMQpVKMKbig6ZU4MZCrgeKpdv/X1XPghJkIvZgEmN9OWt
	RoNe0bG3DpbFstNye+iCFM/oq5eQasksq89xBk0Mt8QV0igLVCta7i6cIgThDww==
X-Received: by 2002:a05:6402:30bc:b0:566:1794:394c with SMTP id df28-20020a05640230bc00b005661794394cmr129069edb.24.1709158193120;
        Wed, 28 Feb 2024 14:09:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmfu24bp7UkGvEcQ4+tEbIWqtnZpk5H8albcf/QuQmopUid88So6QN4WY3xD6rZZKzDvbECw==
X-Received: by 2002:a05:6402:30bc:b0:566:1794:394c with SMTP id df28-20020a05640230bc00b005661794394cmr129057edb.24.1709158192759;
        Wed, 28 Feb 2024 14:09:52 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id en18-20020a056402529200b0056691924615sm184389edb.2.2024.02.28.14.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 14:09:52 -0800 (PST)
Message-ID: <54595439-1dbf-4c3c-b007-428576506928@redhat.com>
Date: Wed, 28 Feb 2024 23:09:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2021-46978: KVM: nVMX: Always make an attempt to map eVMCS
 after migration
Content-Language: en-US
To: cve@kernel.org, linux-kernel@vger.kernel.org,
 KVM list <kvm@vger.kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: gregkh@kernel.org
References: <2024022822-CVE-2021-46978-3516@gregkh>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <2024022822-CVE-2021-46978-3516@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/24 09:14, Greg Kroah-Hartman wrote:
> From: gregkh@kernel.org
> 
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> KVM: nVMX: Always make an attempt to map eVMCS after migration

How does this break the confidentiality, integrity or availability of 
the host kernel?  It's a fix for a failure to restart the guest after 
migration.  Vitaly can confirm.

Apparently the authority to "dispute or modify an assigned CVE lies 
solely with the maintainers", but we don't have the authority to tell 
you in advance that a CVE is crap, so please consider this vulnerability 
to be disputed.

Unlike what we discussed last week:

- the KVM list is not CC'd so whoever sees this reply will have to find 
the original message on their own

- there is no list gathering all the discussions/complaints about these 
CVEs, since I cannot reply to linux-cve-announce@vger.kernel.org.

This is not the way to run this, and you're not getting more complaints 
just because people don't care, not because it's all fine.

Paolo

[1] 
https://lore.kernel.org/linux-cve-announce/2024022259-CVE-2024-26592-58f7@gregkh/T/#u

> When enlightened VMCS is in use and nested state is migrated with
> vmx_get_nested_state()/vmx_set_nested_state() KVM can't map evmcs
> page right away: evmcs gpa is not 'struct kvm_vmx_nested_state_hdr'
> and we can't read it from VP assist page because userspace may decide
> to restore HV_X64_MSR_VP_ASSIST_PAGE after restoring nested state
> (and QEMU, for example, does exactly that). To make sure eVMCS is
> mapped /vmx_set_nested_state() raises KVM_REQ_GET_NESTED_STATE_PAGES
> request.
> 
> Commit f2c7ef3ba955 ("KVM: nSVM: cancel KVM_REQ_GET_NESTED_STATE_PAGES
> on nested vmexit") added KVM_REQ_GET_NESTED_STATE_PAGES clearing to
> nested_vmx_vmexit() to make sure MSR permission bitmap is not switched
> when an immediate exit from L2 to L1 happens right after migration (caused
> by a pending event, for example). Unfortunately, in the exact same
> situation we still need to have eVMCS mapped so
> nested_sync_vmcs12_to_shadow() reflects changes in VMCS12 to eVMCS.
> 
> As a band-aid, restore nested_get_evmcs_page() when clearing
> KVM_REQ_GET_NESTED_STATE_PAGES in nested_vmx_vmexit(). The 'fix' is far
> from being ideal as we can't easily propagate possible failures and even if
> we could, this is most likely already too late to do so. The whole
> 'KVM_REQ_GET_NESTED_STATE_PAGES' idea for mapping eVMCS after migration
> seems to be fragile as we diverge too much from the 'native' path when
> vmptr loading happens on vmx_set_nested_state().
> 
> The Linux kernel CVE team has assigned CVE-2021-46978 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Issue introduced in 5.10.13 with commit 0faceb7d6dda and fixed in 5.10.38 with commit c8bf64e3fb77
> 	Issue introduced in 5.11 with commit f2c7ef3ba955 and fixed in 5.11.22 with commit 200a45649ab7
> 	Issue introduced in 5.11 with commit f2c7ef3ba955 and fixed in 5.12.5 with commit bd0e8455b85b
> 	Issue introduced in 5.11 with commit f2c7ef3ba955 and fixed in 5.13 with commit f5c7e8425f18
> 
> Please see https://www.kernel.org or a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2021-46978
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	arch/x86/kvm/vmx/nested.c
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/c8bf64e3fb77cc19bad146fbe26651985b117194
> 	https://git.kernel.org/stable/c/200a45649ab7361bc80c70aebf7165b64f9a6c9f
> 	https://git.kernel.org/stable/c/bd0e8455b85b651a4c77de9616e307129b15aaa7
> 	https://git.kernel.org/stable/c/f5c7e8425f18fdb9bdb7d13340651d7876890329
> 


