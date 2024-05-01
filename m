Return-Path: <linux-kernel+bounces-165698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90B88B8FE7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BC21F21A0F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18BD161320;
	Wed,  1 May 2024 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rfbhiel2"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F31137E
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714589683; cv=none; b=XYEJme+qB67vT+Zos1syEDixcZm2w8rhq6NqfXzp61uoV+oGdZontnqLKzb1pYCSYnn7n0+dfvawXEyBh4bManVOIBM+t8/aYnGafBUcz1QqCSkYZOTpVF50v8eHpOfLmzup4BrdHjP5R+rn0fWFUVj7N5H+L9f0/o3Jcd+aaec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714589683; c=relaxed/simple;
	bh=ZDFyiXcFQpYmQqUMFVEe9FegPdW34mLyaWMr9aBCBF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Om0bIlMWcC7HNa/T+aZqqGZftzA7BQ+qR3cl3rA+o6Ofmnm/oVjUuBKTnfyepSvXHjZLaBaU64knCvTmhBDjSj3FxTzj8CbN8QZ2+E/W9ytAGEGk02izKXGkf69glg5o6uiZ7GYibWcOFQGVI8gieqCtBs68tU2g2rN5oAf9G5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rfbhiel2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6029e614eeeso7414652a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 11:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714589681; x=1715194481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7WCk4sjm/hGbZuv1UBg6truPSxtFEYVHoQRMNBTBqho=;
        b=Rfbhiel2rJKy23lQlRVin50n81HUSBV3ZFmnpqRyt/db2N4NpMBjc7ErfvOvU2jSil
         PycsNaw9FS3MS9JmMqYHesOx8L+/alQuAPaqnknrB0a8QAVXNruTycAHtQjomZsOiV96
         qVneOV9dTDdzdLoLLA5fkv+ciXXmXJRkqPEGEijut85x40eruV1zz9GUG+oOr/Fxt/Tu
         LMBAQefduIF9SMwDyIcNaGvwY+QAq+irqzbJY2RQCZOYst2dDb9kw2Ys/1FIZTmxtYfH
         XteEVba/lOoNT9kXWVIB/4J+HHey7AEjiK400kVZBuYC/rswnTO9RXyk/+IsvNaBWhtz
         ycnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714589681; x=1715194481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WCk4sjm/hGbZuv1UBg6truPSxtFEYVHoQRMNBTBqho=;
        b=PQg/wJLRdU+V3kJfeT8XKL/4oSY7/tlPhzkcXTczKovkDWjBdDLeHBEBFySdcGFI5b
         vTglWotTb4dtMqcbFo1wlzG3vrs9nd2DU32wiCXvovDDbNs8b9XoU61GLVYWQZERILQz
         KL15vryFbUktu5nzo+MdpFzdhJg6NhS6waUZqycIpAaAVhFe6qxcNKTMUuI1BnWKtZ7+
         Evxn/wwKu19xZ8aUGAkOAfTrqw7OpIntBSiEXMVY+kFohgriCd+HnXVoyjsMQ6rdLAp/
         7gabKrvwiIuD/+DYfXT5cpVyuQI+fPkN8nm/BI1jPMimHMCJDQv9Q3QLVvGM+C7JGIuO
         VJCA==
X-Forwarded-Encrypted: i=1; AJvYcCW5MDTc75EyQB0DCwr/PnFVTOGKNfPOAt5KwegdAm1DOoP301h0oRk6J+u/Ot68w2ouZMyTVMaCtjdz45rnfp2F7dRR7a4d7upxNZNL
X-Gm-Message-State: AOJu0YybVOL6Kd56zqEgiwBleUKRFUtMq3O1uVzzMbH3zlnb1vFDpYSO
	Xp34B6+9s9apIGXL0rEwgrhPzWmKSJL3DOgOFnnWkrIa+AedF9ZGGilGgjOOoleBfIKTpVFt7YW
	8Yg==
X-Google-Smtp-Source: AGHT+IEaEMkzuIRvQdXiBfaDkh9C3i4lsdhVtSwmc/4q4ol6mkUrYSdgzDL/fKpff9VrOEqYhmXsnGuyTYg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:360e:b0:2b3:90eb:7b46 with SMTP id
 ml14-20020a17090b360e00b002b390eb7b46mr692pjb.7.1714589681215; Wed, 01 May
 2024 11:54:41 -0700 (PDT)
Date: Wed, 1 May 2024 11:54:39 -0700
In-Reply-To: <20240219074733.122080-10-weijiang.yang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219074733.122080-1-weijiang.yang@intel.com> <20240219074733.122080-10-weijiang.yang@intel.com>
Message-ID: <ZjKP7_vydkig2FQ4@google.com>
Subject: Re: [PATCH v10 09/27] KVM: x86: Rename kvm_{g,s}et_msr()* to menifest
 emulation operations
From: Sean Christopherson <seanjc@google.com>
To: Yang Weijiang <weijiang.yang@intel.com>
Cc: pbonzini@redhat.com, dave.hansen@intel.com, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	chao.gao@intel.com, rick.p.edgecombe@intel.com, mlevitsk@redhat.com, 
	john.allen@amd.com
Content-Type: text/plain; charset="us-ascii"

s/menifest/manifest, though I find the shortlog confusing irrespective of the
typo.  I think this would be more grammatically correct:

  KVM: x86: Rename kvm_{g,s}et_msr()* to manifest their emulation operations

but I still find that unnecessarily "fancy".  What about this instead?

  KVM: x86: Rename kvm_{g,s}et_msr()* to show that they emulate guest accesses

It's not perfect, e.g. it might be read as saying they emulate guest RDMSR and
WRMSR, but for a shortlog I think that's fine.

