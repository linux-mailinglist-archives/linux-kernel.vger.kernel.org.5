Return-Path: <linux-kernel+bounces-141311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BC38A1C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63FF1F20FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1E1199EA3;
	Thu, 11 Apr 2024 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vp96rktp"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA71199E9F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852544; cv=none; b=sXaLYam5qfg20yMclGdK/UudFv79Qhv8EWtTkNnEIe1PqI/td/DUN1WKoAVqXX9ybm+TWWZ9wK79Oly4Fw3SK7WNClqun+6EHaKI3/byeHODryRH+EB8xWwrAO1zkycmXme2IRjvd3K61Vr3askZ802A8VKhcq4htoLdl/NQ7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852544; c=relaxed/simple;
	bh=p6FrjYIuiPv/OWpL96geXDj904xQ+ExT33zK5ULyOlw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hc7drhYIKA6dqtg8pVZv+AlcSAC8dsMJcksT4AnWz2Iy+kmaMd9MUz9Z3iOjVMsmbQv7biNGjpajphzOHL0a7qqPXEryhOsgtqm/DtHO1iVQp1FaLqKHfADgumXQ2ijOlkOQFJnLnNFCxCfd6sv8/1k0qJt8l7y6P+EVtvs03k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vp96rktp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc3645a6790so13384460276.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712852542; x=1713457342; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2OyM+clVKBMLI18tEOZmwU9RMDce6Apgb7FSUXC0ZlQ=;
        b=vp96rktpy6Kz6r5ihcstSGE4QUNDRhRqJwwKNJIfjHA+om/vvULP95S/oml4rP3qsY
         HAtpXlOIwiIigtnPtvkzYkF1HbgjB9O0bdmWvlTF4PTNo47jfj5RP8xc/D3Yrbc5FQJZ
         r7XGNNbc0J96i1X1KH/WdfxuX/xyvlraN+4WKcV2xpoKTSAz4n8tbNnMiOGc9HR8bYIH
         rlHJ3IHLQwp+K2f8yjFNfMN/FJLcEPtgmhFIz3LE9wA+b1Fyz5fqda5eOaTTPqRbJ7Oq
         QASgNUG82mkhL6rFT3ndkwy6i83yMLg2Mnh+vPSbVDDhxez6lXI3uGViSwHDJ/JU/1kF
         hHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712852542; x=1713457342;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OyM+clVKBMLI18tEOZmwU9RMDce6Apgb7FSUXC0ZlQ=;
        b=FkyInAeElCYoST4UUfI6TG+JT1n0WVHQ2ut2FMyY6NeE236xh0ZLwFVnx3rad3lufS
         O0rr5oKG/mo6uUM33XI3HB7kFEQHNxFxxF9v6TktLSiwC9PidfGT9uyxV/jVQqKuf6fD
         XY+7G1ioq2DtPdVKjlSQAjvKFF4VS+i6M2PpvkzLaZ8eCye5TxfWSHLyT0jq27lz9jgT
         pZ+MHzHFw9uZ/H6yBXAvtYBqcHLIVX2U+IFZmQDizGqWZ9WXlmirY0zUFcZMNgaOReII
         vgt3t1W9oq3GN+bvz6/QWYX5712hfVXy5y1h/erFc/F/+gqb82kNtp40sTXV2zDuRP6B
         aDbA==
X-Forwarded-Encrypted: i=1; AJvYcCWm3jxe2B88Q6o81lAlQNLmkibPMTVS1DfQhOJeQKwngau6LV5IP8SErDP0lRFkSZjrMDG1AJGfZo9VJLPq+RKfp1Qh4fjguZ7yD59r
X-Gm-Message-State: AOJu0Yx+ORyZzKBPMaapDWzmjksUpa1OtEWXOnWkQKbEDsc1kJIp/kgs
	ncNcy0//0IqkWzP9t7gpZuhEe57G9ILAnRz8oxSirrmIABDsid5RxQ0KgkWYqiCXhSV+lUanrUC
	snQ==
X-Google-Smtp-Source: AGHT+IH8shHr+4EPWdkZff41gDNU0fbuUzfcXkhlsV3MsbImVHl0+gtWqqzpDVUl8lRDwzXVv545KyKt7Z0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1887:b0:dcd:875:4c40 with SMTP id
 cj7-20020a056902188700b00dcd08754c40mr1893180ybb.10.1712852542506; Thu, 11
 Apr 2024 09:22:22 -0700 (PDT)
Date: Thu, 11 Apr 2024 09:22:21 -0700
In-Reply-To: <20240411144322.14585-2-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240411144322.14585-1-xry111@xry111.site> <20240411144322.14585-2-xry111@xry111.site>
Message-ID: <ZhgOPRIA5lyhTfGs@google.com>
Subject: Re: [PATCH v7 2/2] x86/mm: Don't disable INVLPG if the kernel is
 running on a hypervisor
From: Sean Christopherson <seanjc@google.com>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Michael Kelley <mhklinux@outlook.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="us-ascii"

s/INVLPG/PCID again

On Thu, Apr 11, 2024, Xi Ruoyao wrote:
> The Intel erratum for "incomplete Global INVLPG flushes" says:
> 
>     This erratum does not apply in VMX non-root operation. It applies
>     only when PCIDs are enabled and either in VMX root operation or
>     outside VMX operation.
> 
> So if the kernel is running in a hypervisor, we are in VMX non-root

No, this is not strictly true.  The HYPERVISOR flag only states that the kernel
is running as a guest, it doesn't say anything about what mode the guest is run
in.  E.g. a fully PV guest running at CPL3 isn't in VMX non-root mode.  Ditto for
a fully emulated environment.

Of course, in such a setup the hypervisor really shouldn't be advertising PCID
support, and I've no idea if Xen PV (or any other PV mode) even shoves guest PCIDs
into hardware, i.e. PCID might be emulated and thus not subject to the hardware
bug.

In other words, simply checking HYPERVISOR *might* be safe, but it might not.
If we wanted to be paranoid, this could also check X86_FEATURE_VMX, which also
doesn't guarantee VMX non-root mode and would unnecessarily restrict PCID usage
to setups that allow nested VMX, but AFAIK there aren't any hypervisors which
fully emulate VMX.

> operation and we should be safe to use INVLPG.

s/INVLPG/PCID

