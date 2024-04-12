Return-Path: <linux-kernel+bounces-141888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 681058A24B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A751F240C4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D9718633;
	Fri, 12 Apr 2024 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SouzeARN"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA97617C7C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712894869; cv=none; b=Aicc1VywPAj2kyrifOdOkpyHm6rCGT3UDcwSwhPiGqeIi3dziET1AC/d9MFnEF97yOUKm4sXQp4GUZ1XcKKodUV2srspmgYvtXuWBanPYwWR37/+pdp7FfDL1KsEZ/tXpHEuGj6/rSeyNhjiNeSdTkqCDPQk03uzvYW2lNPLILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712894869; c=relaxed/simple;
	bh=TWGZtsGqJTB94/trEDr9F6ImbwgWZVLIi8X5eo0700A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTe2Np6565GNDcvFH6N9lKcRoBjgo6Sqi9RrzC7MycgBcYjtoit6gIORV5QLETtRkqZVxJscM9RgbMJ59LIl4RZZzTTpDkySh8gWzGblU5JGQq0vHcSPP7qLUth0OwOfJr6gMR5b2R+207IJ4+nrn6NxFebUEVs+j8sHhcMigA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SouzeARN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so4383a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712894866; x=1713499666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWGZtsGqJTB94/trEDr9F6ImbwgWZVLIi8X5eo0700A=;
        b=SouzeARNw7rD+rebCEMhpsY+SW7/KHC/Kz+gOFZadUyP+XtPWrtUsN/Cx7/PPUiZlX
         MajORzxmA5PCgyfiJCxqt8ePbwHq2T2pdYL8SOujg9mEKXmFdI1RrURxaieqqdLBVBE2
         lTvB50hCigGZp/MhE8V1aoXZJPSoH1gw3N6KnqW6k3xBBnG9IKf4oL8oBnU57h7OgYz6
         wR+Z3RDrTUyB94mQyjglo2g46SO9h9kxH4aS8va4NHYVq6dY+5bP/cse9QmTHJSLNW61
         k0FnyvixPb/PK587u5fES9qNE2/HOMgrMy8+3cBUvG7JbON4QEqcdGOpai8QE6zcs0uv
         jHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712894866; x=1713499666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWGZtsGqJTB94/trEDr9F6ImbwgWZVLIi8X5eo0700A=;
        b=oK9Gb2PliyQJW2NCoXGUkMNs/HPWO9srXj+uuNCvZ4BH2+qYPTo+sK0mnAg4EvKaSp
         7Yi6VcCRjnorescsN+wFVW0O4f45UakfQhohMPVv7ZmDNLtFHjHL1CQp2N3OjIFGHcls
         LKaMRZfdPgNxx5IYTAUgiuiqsMNeAZ8qoF87Ml2a8L3L4LTO++gEdN4JZim3Z8Qfz0VW
         4Tgrolejhet0FNI7cYFLmVfEoVPz3565g2iXt45y6oEX48xJcmmYq+YB0tZ2hoHk73LN
         wSKSgjq+MtmVz1AGmWgF0YhmtDT0ilfGfq1wIx5GoZp2s8ZJWCaxFiTSiStbCBKhwpVx
         df2w==
X-Forwarded-Encrypted: i=1; AJvYcCXM8kUmlYfUoEt8tCWX9C3vxh6NOtz4nX4W4/kRAbZZ5PMSOGxEsyabfK1zRoW8l4GnkJpIXwVoYhhdFZW8EDvD+Vlhvi8OGqc06KjS
X-Gm-Message-State: AOJu0YwpKNiAAD64FwRE/At5CwybXIswQZfL26TUef0yDP5ZvjCYpSHS
	8y7Xsy082FpMue3ZNXJw3n8acMkqNkK/L/Sb/PEBxtbDHnKdVE8cAJv6AYqZajRr5QK53c+T/XU
	EO0xTlJHSM15SIxRHSYPyNS11AiTvQC0g63T+
X-Google-Smtp-Source: AGHT+IGacs87JzD3+00IR4DdmXTCoGSOnuLu2Y8Xpg8F2oinFjbxlZn4UjUPETVqKejXadBJjQ2fG2vaWytLNg7ABoM=
X-Received: by 2002:a05:6402:610:b0:56f:ed6f:2b6d with SMTP id
 n16-20020a056402061000b0056fed6f2b6dmr90879edv.6.1712894866168; Thu, 11 Apr
 2024 21:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410143446.797262-1-chao.gao@intel.com> <20240410143446.797262-2-chao.gao@intel.com>
In-Reply-To: <20240410143446.797262-2-chao.gao@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 11 Apr 2024 21:07:31 -0700
Message-ID: <CALMp9eR294v_2-yXagKR8HM_WbqihJ5JcRwD1NTGvJxsOFsnyw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 01/10] KVM: VMX: Virtualize Intel IA32_SPEC_CTRL
To: Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daniel.sneddon@linux.intel.com, pawan.kumar.gupta@linux.intel.com, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 7:35=E2=80=AFAM Chao Gao <chao.gao@intel.com> wrote=
:
>
> From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
>
> Currently KVM disables interception of IA32_SPEC_CTRL after a non-0 is
> written to IA32_SPEC_CTRL by guest. The guest is allowed to write any
> value directly to hardware. There is a tertiary control for
> IA32_SPEC_CTRL. This control allows for bits in IA32_SPEC_CTRL to be
> masked to prevent guests from changing those bits.
>
> Add controls setting the mask for IA32_SPEC_CTRL and desired value for
> masked bits.
>
> These new controls are especially helpful for protecting guests that
> don't know about BHI_DIS_S and that are running on hardware that
> supports it. This allows the hypervisor to set BHI_DIS_S to fully
> protect the guest.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> [ add a new ioctl to report supported bits. Fix the inverted check ]
> Signed-off-by: Chao Gao <chao.gao@intel.com>

This looks quite Intel-centric. Isn't this feature essentially the
same as AMD's V_SPEC_CTRL? Can't we consolidate the code, rather than
having completely independent implementations for AMD and Intel?

