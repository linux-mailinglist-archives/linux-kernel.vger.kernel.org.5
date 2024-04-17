Return-Path: <linux-kernel+bounces-148500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342618A838F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5BE1F21FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055BB13DB8A;
	Wed, 17 Apr 2024 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmHNYmls"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47D213D61A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358705; cv=none; b=c07sKH6+1okktJJn7+2Ml+JvnfbT0lbx5At2AQI2Agqz+7brV/LgK2TUQ0KDhdsL1R8EbnJjAGJgTdXsS6VrPEqmGVpExukuTwS3DaheJveiOuYqG/QggG3Av+v1HJ0DLIi4ajxCtYCjyzn/AdYwY9mhKdLsZuKT5f8teeeWop4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358705; c=relaxed/simple;
	bh=odBinATsxiv0QntS3vmmZ+hwTGfp9CbUJ8OWIdv7zD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+JHPSFE5TbbDpodUJ/gsNze8QOMjc+d1ZctnH7LML5VTnOQXDnSVsK//vwqxrWLyaMRBnHm06jRTNoKOnDpT5lq3UosAf0l4qsVl1hzcMPl2aEN7kncFnuhAYclUst7v3YD3JY0OhBuhiP7P0ASm7lukquZSLEzaDkQEIEt5ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmHNYmls; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713358701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Yf7QCrWbLl6GzRDJkeqCAapOLNVCTZM435GPN2S7N8=;
	b=QmHNYmlsggF5Uarc9u60cPLmnJomNdZf6tDWk6SZFLvh1mWC1gFyjx6KxnevL0ljVcNdcs
	8Gj0QocAcjd85gqlPwHNKhCAL56rwZRM2GDg9GZkIEiqhN59jAopP045+EZSyI9h9ATsV9
	5iTf5cb6w0vAAFAjIGwEPghDRVQTyoc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-POlBnhoTNX2Q7VfonUD8lQ-1; Wed, 17 Apr 2024 08:58:19 -0400
X-MC-Unique: POlBnhoTNX2Q7VfonUD8lQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a4fc4cf54dso5667285a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 05:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713358698; x=1713963498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Yf7QCrWbLl6GzRDJkeqCAapOLNVCTZM435GPN2S7N8=;
        b=VM4nKOZm7Sv2ddxD30EygkL4qW4yWjU++2nqts2ZYSPPMtvIPMaL+gISyOGdITz+Vl
         85riLGsPIQ8iuCWNc/+wqkkuoQZzdoU+Bs5DwxcoaRJPgbz8+Y9wXVc3hpZPPRRNSfnc
         cs2LnpraWdbF6qZAN7dzsO9uAAxdK5bNgju6TS5houU2H+1omfIkgckL9CHkXKF4Tfo0
         AiMnaaWCF87xJqAIMNB8gvqJIuxeHH955Rq1ywKNAROQm7AVxYAOtWNNdMN47YD4ZhIX
         jqI/f72CObwmugkRkUkYVTRsBV2K2E2NzPBubdrexMlvWLUrGiSrf+DqvTn55LXQas9R
         iMzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5XUl+HfOF0j/LRIyz4vJGJd4B8rwnoWAZheRh0wuLT1kLdtF4Hi6tcOXCyg1Q7Qv2Ne9Oi3C3glM5zoEUJ1k6DK9hue2j7nOlZNZ3
X-Gm-Message-State: AOJu0YzKbL0xTOtMLO8XBABxCtm5KJy/oSascYd3/TBt4rzeJmUijwn8
	jYzY/P3ibU0dtitMVB6fqlty5BFvEy/16ofQtBwOuPwiylI2FHCcrGAyN7H/f0CFZjuNQjcSJBa
	tDvfE9uMJtbVVz/n9Xuk1g6yK6FGlYoqe7cSN7srk/BoQmEOuqfHMLql1AHQZrdCsr2C2773vkR
	6B+dZ3rXz/MGA/uo3HN4/GAO8OPoS6IKYowFQe
X-Received: by 2002:a17:90b:3c3:b0:2a6:db3:1aa5 with SMTP id go3-20020a17090b03c300b002a60db31aa5mr16000807pjb.18.1713358698441;
        Wed, 17 Apr 2024 05:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeusKXHozTa59pxGQzEfxCvxThXecAwYhUkuqOmc1hiPkPd4IGoLD9R12W5ib2l84GuAmF5uPenTcpb+y/FQ4=
X-Received: by 2002:a17:90b:3c3:b0:2a6:db3:1aa5 with SMTP id
 go3-20020a17090b03c300b002a60db31aa5mr16000792pjb.18.1713358698142; Wed, 17
 Apr 2024 05:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223204233.3337324-1-seanjc@google.com> <171270505394.1590014.8020716629474398619.b4-ty@google.com>
In-Reply-To: <171270505394.1590014.8020716629474398619.b4-ty@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 17 Apr 2024 14:58:04 +0200
Message-ID: <CABgObfYHbsb9hySxXbwCTP_mhuKUVdRDFs71XotEB5FAaPeEpQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] KVM: SVM: Clean up VMRUN=>#VMEXIT assembly
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 2:23=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> Applied to kvm-x86 svm, thanks!
>
> [1/8] KVM: SVM: Create a stack frame in __svm_vcpu_run() for unwinding
>       https://github.com/kvm-x86/linux/commit/19597a71a0c8
> [2/8] KVM: SVM: Wrap __svm_sev_es_vcpu_run() with #ifdef CONFIG_KVM_AMD_S=
EV
>       https://github.com/kvm-x86/linux/commit/7774c8f32e99
> [3/8] KVM: SVM: Drop 32-bit "support" from __svm_sev_es_vcpu_run()
>       https://github.com/kvm-x86/linux/commit/331282fdb15e
> [4/8] KVM: SVM: Clobber RAX instead of RBX when discarding spec_ctrl_inte=
rcepted
>       https://github.com/kvm-x86/linux/commit/87e8e360a05f
> [5/8] KVM: SVM: Save/restore non-volatile GPRs in SEV-ES VMRUN via host s=
ave area
>       https://github.com/kvm-x86/linux/commit/c92be2fd8edf
> [6/8] KVM: SVM: Save/restore args across SEV-ES VMRUN via host save area
>       https://github.com/kvm-x86/linux/commit/adac42bf42c1
> [7/8] KVM: SVM: Create a stack frame in __svm_sev_es_vcpu_run()
>       https://github.com/kvm-x86/linux/commit/4367a75887ec
> [8/8] KVM: x86: Stop compiling vmenter.S with OBJECT_FILES_NON_STANDARD
>       https://github.com/kvm-x86/linux/commit/27ca867042af

Do we perhaps want this in 6.9 because of the issues that was reported
with objtool?

Paolo


