Return-Path: <linux-kernel+bounces-63936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ED8853691
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36C61C24282
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834C960260;
	Tue, 13 Feb 2024 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FODxZYvu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B245F54E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842880; cv=none; b=u8drkd1diH9Hkc/WjgvGzwIzEXWHjORs3T1720su6zYV7U0fpR/v7Z2HPhJ8Iq3Qg4uAPc4bvKh8cGYEzjfw98eXjopeOI9EjpjLY71RcHemPirkTcJhimrPEVMj7plqa8PhUBseovVVqic2rKM2Mrt0598b+U/We9zVXcJ9gIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842880; c=relaxed/simple;
	bh=QMyITr22VNOez+0Eu6FIvd5XT+rl1JLLwyX/uWCBhQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bf2fcfljQNPWqn4vQKf8jwvEFoX+gLEvNpdg3SDeVDdaNzSMAj/kKO64RCKJE6q6YmSYQFMLiiUhSNUT80/JL+rTuGbEByB885V7Q4HMT9NRLO5RVgPJXk6KqwOoOD2TNIbtSZ0d0a2U7me1pGUBhlGbfFWLPc0ByoEsknAxmCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FODxZYvu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707842878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMyITr22VNOez+0Eu6FIvd5XT+rl1JLLwyX/uWCBhQQ=;
	b=FODxZYvuvfvnvqutrYSQgZh8eWSK7zFJ8kCgOIJnJsfUm31LRdrxsUYvC7hinV9aGueNUN
	yOKTtY+1CiusyxktCUhfrxFAISQM+aYW7kHkQVDhx2MNhKYHQMUURm6GGyWiNNYgffQv4i
	meUOSLkgY0Otae1URJmy+4GpIzWzt/k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-w-iK0o4KMcaqwPHBFcDmqQ-1; Tue, 13 Feb 2024 11:47:56 -0500
X-MC-Unique: w-iK0o4KMcaqwPHBFcDmqQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33b8837355dso715227f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842875; x=1708447675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMyITr22VNOez+0Eu6FIvd5XT+rl1JLLwyX/uWCBhQQ=;
        b=M+CxOnbECwYn3jG2CZBVQGXztX9llyAuMgbx6a4VbQOpZET1KnUQPLuuaD2NXjG5vM
         MYFD1jLbJnIogCCrA05onrbv9rbwJVVYI2hLcU5lTp6kJeG+xIM1+dIk4PNYeff6hIQy
         Kgem7u9kwWOHjcqM3jpjHvHIK5kXLx+dpFT3tcTgMnlYwYge7Cd/X2acnlWQ1iPTC07V
         25szsq0nBCX5uVei0Ivn8UGEQJAERVqEMKLSM+Jg22EuuLe5y18JOndVVtszRaseisgB
         kW3CZcwXrS5HDhXkMl4O2ALiDmI+2QZxKCiCwbS9qwt2iDIgU9p6qDyj5sYKjBLXIbEG
         kpkg==
X-Forwarded-Encrypted: i=1; AJvYcCUFBxb7uGg1fmshGTUWWJucVLx/0hNKVNMlwQ0zHLzHyP4iiInb2DKgTOt7AYdSXNZMGIugay4RHtry3m5HRhO1Z99Qk/XXgcKGzTWN
X-Gm-Message-State: AOJu0YyWAZ6Jvj/bn/y9u2ZuwEJWyYHK3DPkQCR9cWzlX1CMfvsUOW11
	YFqkAikuqwgBW6v+DWBKvyUh+MGJZ7g9fbHCV3ySRxbT16/2OMh8NKQw6Sxnc5fn011wqncrbZj
	ooigaogVO/kOnvvIorhO5RwH699aWudReK/rsCZp0kfk5ql0bou/5Jyp6HWDvAQFVITBHT6dWjz
	BQNFRTKHnAOGVcx3fHfa1xiGCg6fatYdChs7bS
X-Received: by 2002:a5d:5706:0:b0:33c:e339:6b21 with SMTP id a6-20020a5d5706000000b0033ce3396b21mr317084wrv.3.1707842875448;
        Tue, 13 Feb 2024 08:47:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjt8790Sjzdp3j57iU8n+hsTKRyoCw6s864kVDcam+5Q/1BmuuCqAAfIwXrcWPZpVf9etFaTvSje6Pkl6muNc=
X-Received: by 2002:a5d:5706:0:b0:33c:e339:6b21 with SMTP id
 a6-20020a5d5706000000b0033ce3396b21mr317064wrv.3.1707842875120; Tue, 13 Feb
 2024 08:47:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705965634.git.isaku.yamahata@intel.com>
 <591420ca62f0a9ac2478c2715181201c23f8acf0.1705965635.git.isaku.yamahata@intel.com>
 <CABgObfaEz8zmdqy4QatCKKqjugMxW+AsnLDAg6PN+BX1QyV01A@mail.gmail.com> <Zcrarct88veirZx7@google.com>
In-Reply-To: <Zcrarct88veirZx7@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2024 17:47:43 +0100
Message-ID: <CABgObfYFnpe_BO5bNRvXC6Y-3rUxFAogs2TGFUTBu+JR25N=pQ@mail.gmail.com>
Subject: Re: [PATCH v18 032/121] KVM: x86/mmu: introduce config for PRIVATE
 KVM MMU
To: Sean Christopherson <seanjc@google.com>
Cc: isaku.yamahata@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com, erdemaktas@google.com, 
	Sagi Shahar <sagis@google.com>, Kai Huang <kai.huang@intel.com>, chen.bo@intel.com, 
	hang.yuan@intel.com, tina.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:57=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> The only thing that even so much as approaches being a hot path is
> kvm_gfn_shared_mask(), and if that needs to be optimized, then we'd proba=
bly be
> better off with a static_key, a la kvm_has_noapic_vcpu (though I'm *extre=
mely*
> skeptical that that adds any measurable benefit).

I'm okay with killing it altogether.

Paolo


