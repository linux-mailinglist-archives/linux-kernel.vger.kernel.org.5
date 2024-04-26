Return-Path: <linux-kernel+bounces-160647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6382E8B408E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C0128B8B6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5FB22EF8;
	Fri, 26 Apr 2024 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DUJoHdQg"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A48E208D6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161432; cv=none; b=SlyNUnPZn6PN/u2fiapymXvEsiXI3r51nLQUi8RoUP2EYGxramYOeYsEtVT73BOdBJE8H9v6jJF3atXjglaoZQJR+pHHqVhUG0v3oVBznPzhTLTVexfKageXDZ1t0z8boWKS8uFVJ0WsAFcOnBd4JMY04IQoYjiyxVNZcwT2YkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161432; c=relaxed/simple;
	bh=4Tl6Q7eOW4o1xylpHfLT20dEfliDc3ACOmwo+d+76q8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sl3qHIAXzbyR9ldWv6zliZgznq2US2XbNsXGcisBbKpOmCyvTzKH665Qae30cRYK8OrK3RYfhzRJxZyTfJdA6yxafTtzEnsm/Udm/Jl9rUm1IyZwwsv0AmaTLhI1ieqRBvsoljcTz7o6h4WQBODCJ72RJX1B4+RNTBBu5fCrN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DUJoHdQg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6167463c60cso29665757b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714161430; x=1714766230; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7JHOwynv12T0Y/tQm4DZx8daXixOsghTKfdQCt+IwUg=;
        b=DUJoHdQgSkNEv5FFc8d+51AkMU+KSLEf78ghN7IpvWkZ5WN1FWM6w5GzUr2KJKHUbr
         xAo42I0B9Jqc/lZeeIx3HPSVaoNuOqcqpRY8wonTdKJM6ER64qrQ+CYXuvETyBK4n8I8
         COoXCR10OC7ZU3ShH9dzB9wgVdWV6wqXO/dSLeNWhjbKuXxkzO0iyHg8Ad6iuI1CcOP7
         EiYsnfGWMAb4YNxPTjAyhtIgSIsGvYNaFwZpHpNqd7yG6nlhAtrx6VmwaxIXxLR/wPcY
         9OGStJ5EAuG7qgqV10d/7DDMve6LOSUA1dAynGbSieZYe4PVCorFHfPkzhCHgjtTmMbf
         8dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714161430; x=1714766230;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JHOwynv12T0Y/tQm4DZx8daXixOsghTKfdQCt+IwUg=;
        b=AuVJhLxdplu+/hfI4GmMLPDia1HKNXKdJ1TKaFvRTn2lpz2o61PQqtIZevCwXGehWQ
         KqdWjBJLcJ2qwsCEr99R+rk5vzTP93Cf9vCb1vG03k8cyzrSDVAQuZ94srZSwXsSU8hH
         TYMdoFHCl4j88g0YQQ3O1VychCvTi6eyRqt8kJRbICmaWOTOPmJTjkbCJE2KmhIVK8PC
         5CGiG/o5Gn2+qOK/0eHEFqOltIDSiIbo2jLXfnnmR3Czeh+b4SF65oZXj54qi1gMSb5v
         jjv0qyo+WVThLiBzrQQaeTli59tdyua3LA/QlRdWouSBdHGFtJlOCbZSOuVGatZ0ssoz
         ioyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDT/ViPd/RnqGFg4CpFepD4/fWCMTBwlZZYWM5LaXN4+XlWR+seJhgADO5/THVQM1NqASDEyZsjkTUoV8GuSfpjvPB0PrE7s1wuEcU
X-Gm-Message-State: AOJu0YxXTIcP74BiDZtsWeM8VR6fCMiArsi7znskpm1wzJcRDVPCbsr5
	wDpfUYqkRUmtnAsNw/UpHlYWlbjpr8i4Y94RWXvBLD0XzpdriVQHafn+9Z1iBa1WMnO3hPsNBeh
	0qA==
X-Google-Smtp-Source: AGHT+IGVs0AhQC/2tCuBf1vwuuUKjoCfCrLrEQi6QfgrOK53aglDlk7/orKA5npkCNzcOFKzvJ7EPkWyDNk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:9e13:0:b0:61a:d420:3b57 with SMTP id
 m19-20020a819e13000000b0061ad4203b57mr174224ywj.0.1714161430548; Fri, 26 Apr
 2024 12:57:10 -0700 (PDT)
Date: Fri, 26 Apr 2024 12:57:08 -0700
In-Reply-To: <20240426173515.6pio42iqvjj2aeac@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240421180122.1650812-1-michael.roth@amd.com>
 <20240421180122.1650812-22-michael.roth@amd.com> <ZimgrDQ_j2QTM6s5@google.com>
 <20240426173515.6pio42iqvjj2aeac@amd.com>
Message-ID: <ZiwHFMfExfXvqDIr@google.com>
Subject: Re: [PATCH v14 21/22] crypto: ccp: Add the SNP_{PAUSE,RESUME}_ATTESTATION
 commands
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, jroedel@suse.de, 
	thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org, pbonzini@redhat.com, 
	vkuznets@redhat.com, jmattson@google.com, luto@kernel.org, 
	dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com, 
	peterz@infradead.org, srinivas.pandruvada@linux.intel.com, 
	rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de, 
	vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com, 
	jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 26, 2024, Michael Roth wrote:
> On Wed, Apr 24, 2024 at 05:15:40PM -0700, Sean Christopherson wrote:
> > On Sun, Apr 21, 2024, Michael Roth wrote:
> > > These commands can be used to pause servicing of guest attestation
> > > requests. This useful when updating the reported TCB or signing key with
> > > commands such as SNP_SET_CONFIG/SNP_COMMIT/SNP_VLEK_LOAD, since they may
> > > in turn require updates to userspace-supplied certificates, and if an
> > > attestation request happens to be in-flight at the time those updates
> > > are occurring there is potential for a guest to receive a certificate
> > > blob that is out of sync with the effective signing key for the
> > > attestation report.
> > > 
> > > These interfaces also provide some versatility with how similar
> > > firmware/certificate update activities can be handled in the future.
> > 
> > Wait, IIUC, this is using the kernel to get two userspace components to not
> > stomp over each other.   Why is this the kernel's problem to solve?
> 
> It's not that they are stepping on each other, but that kernel and
> userspace need to coordinate on updating 2 components whose updates need
> to be atomic from a guest perspective. Take an update to VLEK key for
> instance:
> 
>  1) management gets a new VLEK endorsement key from KDS along with

What is "management"?  I assume its some userspace daemon?

>     associated certificate chain
>  2) management uses SNP_VLEK_LOAD to update key
>  3) management updates the certs at the path VMM will grab them
>     from when the EXT_GUEST_REQUEST userspace exit is issued
> 
> If an attestation request comes in after 2), but before 3), then the
> guest sees an attestation report signed with the new key, but still
> gets the old certificate.
> 
> If you reverse the ordering:
> 
>  1) management gets a new VLEK endorsement key from KDS along with
>     associated certificate chain
>  2) management updates the certs at the path VMM will grab them
>     from when the EXT_GUEST_REQUEST userspace exit is issued
>  3) management uses SNP_VLEK_LOAD to update key
> 
> then an attestation request between 2) and 3) will result in the guest
> getting the new cert, but getting an attestation report signed with an old
> endorsement key.
> 
> Providing a way to pause guest attestation requests prior to 2), and
> resume after 3), provides a straightforward way to make those updates
> atomic to the guest.

Assuming "management" is a userspace component, I still don't see why this
requires kernel involvement.  "management" can tell VMMs to pause attestation
without having to bounce through the kernel.  It doesn't even require a push
model, e.g. wrap/redirect the certs with a file that has a "pause" flag and a
sequence counter.

