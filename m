Return-Path: <linux-kernel+bounces-168256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30138BB5C7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009E51C23861
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E9F56750;
	Fri,  3 May 2024 21:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmUaLXQp"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8EF537E9
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772028; cv=none; b=tjxcVxT8ujzOfyjmyD2bPwlirYFREM0qOpO8MTa5M0dn2neGGwxrJUXIw8xS3D6V5TavshNPGO66lWbzy0hEAMWAZCEHJekLOM5jzMZ/W6eD56T7LdBvMhhx6zWjLWI5GMSCdlA+djqBr1xq0EZlnCyfZbKeh8dGCJCSxGKnyB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772028; c=relaxed/simple;
	bh=2p3EmqeLa76hFcxzVFu3IM1y0mu3LdQ1D6og4KfIlyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X4PQffF5SRZ8oCM8unjL2IODpymKib1cLZvkr4BCJLD1Gg1VKsfleAQqihy7Q2HsEych+6NVkUKy8eorvmGy5C4U4CA8A6gGc7bylFZ9xEi+le7zF6Z9o8eGkwDOq3QNohfGXBqRfiVjpKLx9ZMHepukC79zZAqIyprx+AnIaHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OmUaLXQp; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ed663aa4a7so204098b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714772026; x=1715376826; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MlrISKi2c+M0hlWH8F4xXuKQHxXn7iCZjvDMr+QQnwo=;
        b=OmUaLXQp24JfPCMh5pOxUVioevzmlQEqyZSwtrWKODVyaGCrGZ2Lt3Q9tO6POuOTaS
         GyDUNpr3YtVpdZau2BeUI5vLgkRAEi6HG1P7s78Dnl6he+PYsF5YO63sRioI4+w5MXrw
         woz0Bhcov90Rhk1qomiNFfym/PrfV62UkO4YtkK+H25dgtO2F1OUpJfx1kesv2CR9xAQ
         K1/RsYhakr8ylcNuHuql2/1KvFG1TkHL6vFmgoCSMO8yd7daiigCP1dVhOQ8CeSvqWfl
         wMZBsuzKoSlWSJ5xp0+anL4P0bqExoeCxaAwNGZ/doIPlQZoQsbKvz86KTiIy02y7yza
         u7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772026; x=1715376826;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlrISKi2c+M0hlWH8F4xXuKQHxXn7iCZjvDMr+QQnwo=;
        b=g/85PG2WOfZy5osirBaIHAzQEM3E3hdnJ7MIYMJkUBsR/8zPO/qkIWSyFVBXoZzlmM
         OoEH58N7DxbHUnoeDoNE0U8OlrPEVsVLT/lH4dyq/nLPHYTqE+CGfq43/P2GbhnF5c/y
         fcKKl2kmN3m8hocTYubv0iUnL0FHSAOjGmAee+J+sprxKEpCViZ2bbyZMHHN6mICX7KY
         1ootgs5E0UPsi7RgjGiRILDlVV4n6eKGJ8GDCt7E6d5yVZ6uvn+0mkrvBWod2n13jqGB
         ZJjswCGfKbvMt2aswtyUZmKCspZoPH7ozRn41vffoSFA8zd6LHxazo/Zsng64A51CEw3
         BKTg==
X-Forwarded-Encrypted: i=1; AJvYcCWLIh3/qTNYFnueguyrNGr8AcQPOjfHGEi0BMusMfxkttgGhVDi6cCHR5ot63GrEckt1nHvq3tHIMlljWYPT8Kp7oRQMeN4WEDwclqU
X-Gm-Message-State: AOJu0YwQvAvFmKTP/SMunU/eenSY3DDx1CMj9aSnZBbw8EHw2cok9x+G
	Rofh5HLVGCRHEIs9Y1QjbUL24/rj4rkV+akS+Ay3CVtAJ2OSbTxGVlwPliC8PkbRZg2bDdlAz5x
	xZg==
X-Google-Smtp-Source: AGHT+IEHyKqw2sfoqSfrlqHZmBh3uSQ8p/kW7UX2W50ATZadR3KM3oZfm4nJXRLPcnOkKXVpCRpkzPQWRKg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d8a:b0:6f3:84f4:78e4 with SMTP id
 fb10-20020a056a002d8a00b006f384f478e4mr124606pfb.4.1714772026488; Fri, 03 May
 2024 14:33:46 -0700 (PDT)
Date: Fri,  3 May 2024 14:32:14 -0700
In-Reply-To: <20240418021823.1275276-1-alejandro.j.jimenez@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418021823.1275276-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <171469178174.1010245.3908365461241095071.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] APICv-related fixes for inhibits and tracepoint
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: pbonzini@redhat.com, linux-kernel@vger.kernel.org, 
	joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, 
	suravee.suthikulpanit@amd.com, mlevitsk@redhat.com
Content-Type: text/plain; charset="utf-8"

On Thu, 18 Apr 2024 02:18:21 +0000, Alejandro Jimenez wrote:
> v2: Add Sean's changes to [PATCH 1/2].
> 
> --
> 
> Patch 1 fixes an issue when avic=0 (current default) where
> APICV_INHIBIT_REASON_ABSENT remains set even after an in-kernel local APIC has
> been created. e.g. tracing the inhibition tracepoint shows:
> 
> [...]

Applied to kvm-x86 misc, with the previously mentioned fixups, thanks!

[1/2] KVM: x86: Only set APICV_INHIBIT_REASON_ABSENT if APICv is enabled
      https://github.com/kvm-x86/linux/commit/6982b34c21cb
[2/2] KVM: x86: Remove VT-d mention in posted interrupt tracepoint
      https://github.com/kvm-x86/linux/commit/51937f2aae18

--
https://github.com/kvm-x86/linux/tree/next

