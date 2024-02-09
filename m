Return-Path: <linux-kernel+bounces-59568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BD184F90F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B662C1C2156E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFE6762CD;
	Fri,  9 Feb 2024 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4EplVMy4"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876D54D58C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494501; cv=none; b=F+rQKM47cvUSufolQ9fiF3Anydg6uDUYnlDNqpqs+UX/voaUmFBk8/ybj/3KnrTCgS7tOlTpLb9YoLz44mSqSxjPruwR0gvP32qys++zspdKJtbDhFPUoYVzY5Bou1epEKI4tL93gKnycDFMRyaTHGn28WA4Ur4OcXmIa07xi9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494501; c=relaxed/simple;
	bh=A0ppvdAEssQ0RgSYaqSvMhcfnozN/meETnSjtqFC/tI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RCyKez1zsIFaiOK6AUnh8ZZVroz3FjvHQjIclfKieAERV7iChNZI6dnHYXc+ikk9CC3oMTT5UAHP5YffRWp6ay6+/Ht0Fmrn8VcKpbXu5t1jPcx+xL7pHr/QD7uUdCcZEzh46anXBFyvHJPQXCIDdOs8S+/OKqzYFc8h7kcMpsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4EplVMy4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cfc2041cdfso976506a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707494500; x=1708099300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WbkXeYUaDBncgeOsZac9v7h/OYs9uDYhnmPMW2APu84=;
        b=4EplVMy4iyA5l3qKCK/51jsJKeEElOoEZRUasbbSiG0izQEILpQOILYbxCQzAKKLPc
         LD1RbJI5dGagCBD4yMfXdUG4O3ObMeVnfKoxoolzEKS5CAPsat2yW1TBqLdRPsViIKHA
         ez6NA5PGp4106LAXXHcANhSdGE8fPcwpQMCyH/7wzrBRhBXPr1IRveSt+LwahkOKPvgr
         RzpfGqqZ7GP/Qir5+oeir3f40HP10hFCbkfb3cfCwtIiPZzQEiC8Akqqx5hPceMgFqpd
         yvDOOIHC5YaGOYJZ/1fclQIOfnq3umsuS/GpBsdchhcmNRW6HT6STIEZ6IxitEX1KyLa
         qA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707494500; x=1708099300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbkXeYUaDBncgeOsZac9v7h/OYs9uDYhnmPMW2APu84=;
        b=dqH+HThkn2656nRMNG62bYm8FM0dUaNMx7HBJExenOGoV3VUsSF2gPxMhQEJhyxHCy
         f/mE6pfilOtlfWUozNzSbtm4dDMnTneEEvw0A+00U7UhFyRKNPDohjt1Z3IvLccbRGoJ
         aWRdXys70guXRdWAQJt0045UoIFlEIDP5GhL6N+Ag2fw765jSBeML9/D79jzroHcQHa/
         epVIUheC4TyV8lIXbPCv+TBWQhPaJqBvn0BBk8fWtvxinHJ4DBJfv6PaaH+owBhGrm2/
         foyry778eoW1+oG9bxKrSWOZAapqaYBgMaaF8Nb+FyJqzEOXY0rQK/xYXdYYc/YdJ1zl
         IbHA==
X-Gm-Message-State: AOJu0Yz4fiHf3e9ADYKXTIjbUV9/+FvhzvqgGhX/ydrOHwSbnu/NonUh
	41sq8Cv/iA+yUSyaKeISCPaJfkgtAAJfjn0HoJ0OEpt+99fNfbYis3iKVgQa/P48+5gJRgH4/zm
	Xyg==
X-Google-Smtp-Source: AGHT+IEyKu+Do4l97DjvOFOUv97OY0Nhkddwujr8IqjGCIn2IxgeG40+kn6W+CdStGVDgL7zUYgHlJTuOeI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6e8e:0:b0:5d8:cd91:44e4 with SMTP id
 bm14-20020a656e8e000000b005d8cd9144e4mr5426pgb.12.1707494499773; Fri, 09 Feb
 2024 08:01:39 -0800 (PST)
Date: Fri, 9 Feb 2024 08:01:38 -0800
In-Reply-To: <a2cfad68277cae67791f07646c842672593a8dca.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240115125707.1183-1-paul@xen.org> <20240115125707.1183-12-paul@xen.org>
 <ZcMCogbbVKuTIXWJ@google.com> <92918ee8-3cc9-41c3-a284-5cd6648abc05@xen.org>
 <ZcUF-TNbykWvh3r7@google.com> <148d903c-fcc5-4a6a-aef1-c1e77e74d0fc@xen.org> <a2cfad68277cae67791f07646c842672593a8dca.camel@infradead.org>
Message-ID: <ZcZMYrM_A7UAVIJv@google.com>
Subject: Re: [PATCH v12 11/20] KVM: xen: allow shared_info to be mapped by
 fixed HVA
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: paul@xen.org, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 08, 2024, David Woodhouse wrote:
> Using anything except NULL as the "no value" value doesn't make sense
> to me. It violates the principle of least surprise and would be a
> really bad API.

I'm a-ok with using '0'.  My only request is to check for "!hva" as opposed to
"hva == 0", both because that's preferred kernel style, and because it better
conveys that it's really checking for !NULL as opposed to address '0'.

Side topic, I think the code will end up in a more readable state if the GFN vs.
HVA sub-commands are handled in separate case statements, especially if/when
xen_lock goes away.  E.g. something like this:

	case KVM_XEN_ATTR_TYPE_SHARED_INFO: {
		int idx;

		if (data->u.shared_info.gfn == KVM_XEN_INVALID_GFN) {
			kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
			r = 0;
			break;
		}

		idx = srcu_read_lock(&kvm->srcu);
		r = kvm_gpc_activate(&kvm->arch.xen.shinfo_cache,
				     gfn_to_gpa(data->u.shared_info.gfn), PAGE_SIZE);
		if (!r && kvm->arch.xen.shinfo_cache.active)
			r = kvm_xen_shared_info_init(kvm);
		srcu_read_unlock(&kvm->srcu, idx);
		break;
	}

	case KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA: {
		unsigned long hva = data->u.shared_info.hva;

		if (hva != untagged_addr(hva) || !access_ok((void __user *)hva) ||
		    !PAGE_ALIGNED(hva)) {
			r = -EINVAL;
			break;
		}

		if (!hva) {
			kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
			r = 0;
			break;
		}
		r = kvm_gpc_activate_hva(&kvm->arch.xen.shinfo_cache, hva, PAGE_SIZE);
		if (!r && kvm->arch.xen.shinfo_cache.active)
			r = kvm_xen_shared_info_init(kvm);
		break;
	}

Side topic #2, the above requires that __kvm_gpc_refresh() not grab kvm_memslots()
in the "using an hva" path, but I think that'd actually be a good thing as it
would make it a bit more clear that using an hva bypasses memslots by design.

