Return-Path: <linux-kernel+bounces-78677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C176E86171F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62C2FB24C28
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6187885262;
	Fri, 23 Feb 2024 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dWk8Oeyp"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3E584FA8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704506; cv=none; b=XWcAt0+uYMGYags0hOyAyC7j2OgL++dbsHkJJ4h5btLITezONIAX3RE/jXVWWxbaSg0sEwdySo6y6eZJDL6KMaRwvUal0YXOdq/wnl/ui7jvIZecuiP0ZgSkzYeSEmYS8hR9ngbqzY4sA5QsAQE+tW2MMcLfkbtyK0Lg/0GwMJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704506; c=relaxed/simple;
	bh=2PMjD9iHH3ocbBefw//1TN5JlDlwz5Msjr28jhhqymw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ay3ZdVjdOOGZ28vbI4ArAud+a/HBkkofXbcMgn1LYKAHW6HtNduJf7l5Ewa6Kfzp7YB69/oYrpQlpirQzW7ZOz+ju8oOsmDw/HJ5VYSCh19kOuLYYJeYxOnrYm/AoB6kwB8NmDpaenlzROPQnkN9XnfJu1p2+zIHWxBjfeeQfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dWk8Oeyp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2992c1d4e7fso205114a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708704504; x=1709309304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/NLktSsNTI2TQw0/DJtmGZ9UBM2FfO1AcEKluSzavPE=;
        b=dWk8Oeyp5tiCJYZFuBQNshLJNO3A32T9B1EamHkjVf8KFM9eXrZXirrUfc7Y2nf4cU
         RwfifSzbd7P8NWTaWMqCEtXffUmEfqHpJD0ToQFgoNCcm8jj8ws8upDmNVemIQdbugb9
         2mQ527Skp5TvZzK5m687LE0glJnpqGDgagCtqXbC0HB3uA8XlzpzJCHJiiUTU0toykG9
         wni4aPX1JxZpiFz6dkI84FMFxa878d+bUAZHVqD6Lvx51U3mEAHTZ3GIQjbCoNRQvFJk
         EKv1Pg43awpb52jDvqaU1uCovzhAUBCilVtUkaMILD23azBl5L/X/6StA0Zw5TdSWzmM
         Ryiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708704504; x=1709309304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/NLktSsNTI2TQw0/DJtmGZ9UBM2FfO1AcEKluSzavPE=;
        b=jWMrXDPe1kOsxB1YTCJHpbepgoAaAe3AhXxo4qFZGD3uvU9F8erkm2RWzhiKJGjNpo
         iKXUxQUjc8DqOj54d1LyI096+/S6f7HWI3x2j7ZwhlMkVuLHqLNxzQecF41iyCsMpT2j
         JAjRcYNIRCw2aTYt/muRWklfE7Q1kseG3cXFqd91Vo4ofATg/cUd49lS5UHjxPb6qYz6
         leSRXxx/OekyFL2k2uVyOwab+JWNsEReiiAvFkeniN6ebeKVgC0fNXMMusFp+CI1m2LW
         FpSiot8H+mpqGUbzXI1R4uS6F050ZSzxRpSm+m8kT3rP+S3m/TtAYL0Yl4S/ONFEufcX
         VIOQ==
X-Gm-Message-State: AOJu0Yywsl4cFqEGgIBVVyiX0wAaJVdqxH/MXcXDme4p3z+1BMjgzmE+
	VtnRWlHd/Ol1Nc7i6/kUvbaE59efYCQyOqwle5waxotns0ZrbPCTMY7kBEsAF3q9CcQJyzT4NEP
	dqg==
X-Google-Smtp-Source: AGHT+IHlCSKX3D/08U9DgXj+O49FoqJykL2DTVuXyOPcFje2VkAVkZpw4D1FRULWHx92im0ftmbOMNy9FT0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1d48:b0:29a:8489:1f05 with SMTP id
 ok8-20020a17090b1d4800b0029a84891f05mr3149pjb.2.1708704504478; Fri, 23 Feb
 2024 08:08:24 -0800 (PST)
Date: Fri, 23 Feb 2024 08:08:23 -0800
In-Reply-To: <20240223104009.632194-7-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223104009.632194-1-pbonzini@redhat.com> <20240223104009.632194-7-pbonzini@redhat.com>
Message-ID: <ZdjC94grcjWynW9n@google.com>
Subject: Re: [PATCH v2 06/11] KVM: SEV: disable DEBUG_SWAP by default
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	aik@amd.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 23, 2024, Paolo Bonzini wrote:
> Disable all VMSA features in KVM_SEV_INIT and KVM_SEV_ES_INIT.  They are
> not actually supported by SEV (a SEV guest does not have a VMSA to which
> you can apply features) and they cause unexpected changes in measurement
> for SEV-ES.

Sorry :-(

I've done my best to avoid having to deal with attestation, so it's a bit of a
blind spot for me.

