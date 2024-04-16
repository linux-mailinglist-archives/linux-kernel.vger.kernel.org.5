Return-Path: <linux-kernel+bounces-147338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF0B8A72B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F80283B31
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E125813667E;
	Tue, 16 Apr 2024 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYUG29Sq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC8F1353F5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289947; cv=none; b=kPo8++Rznv7R0kUDieHQZu2MmTRQmUXgHOivTCRGk69cXG4Gk4Wq0IQt9TGxMpllRDWAMGWS0ub8XGaxwZjr3gwlWq7Z0IiCie2/xiyGAmwmrbSAgKQFyr1iTRUoWMSqZxvs27irwVBI9FuACDSGvXfT1LjqCpl2BXmu/nDKapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289947; c=relaxed/simple;
	bh=RL5eJnIJalr+wZY+keQX44XIkYazCOOVBqQCLKNHyck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTSk4ip1f6NE5/nAWtxsjSIr+r0jRXHZxCFIVWzLYCuKAGmqTh59dgDp27t9LF41rEztZclkYf5OLi0q5fWXIgaFbDmK7W3kXoSqRafubJGmNXXxFOHqyxjbr46ZjqKA+7Gg1KW3GysTbmyea1liDIeeTuRea/TxvcHjl+XzF0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYUG29Sq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713289944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SF0Zwul4Q3WHBBYBSPasOP7oJvF1qRnA4BYTQJG/BZI=;
	b=bYUG29SqVMO5jCmg+QLvy6N3Yz/UoGyv6/uj5kjXDuuxPIYQ5kODICYnh9IKQHElF8RBHJ
	O+R0mC6vJmnUpbd+3ZkSH7hE17CJsKMNx4qO4UOb8dctQuFy+svdiUuxgy/fCQ8bFvJzFd
	9Rva5L2q1R1nGeQAuSNrNNC0iqK6at0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-si_pZQEbNnC__cjJdcrPLQ-1; Tue, 16 Apr 2024 13:52:21 -0400
X-MC-Unique: si_pZQEbNnC__cjJdcrPLQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343e46df264so2436737f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713289939; x=1713894739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SF0Zwul4Q3WHBBYBSPasOP7oJvF1qRnA4BYTQJG/BZI=;
        b=B5qxNrp6qiFAgDzu0WtWkErPaN4mrMLeRk+KoY1zICKHa9uVGdiFsl7XAFNG7djyem
         pjhIVQ8uZo0M6eFioKyE+Ke28SWM6jfrKSGV2Fp3aK3I9Dz9EmAQfixnXh1FWY4jyQ8i
         2+85liTkBp5XeC0jDH6g8uxlqChDFOW7QPQe3KR+JLMW8GpDledV2/cWhdi0X5u5WOfu
         vdfgBaAbrw5PkDZZp+U4zOQ9h0rja0/XT7AglPzI8GbMLdXJfxMl1fDgcDLdHdcNS8b4
         54bngmIfnR3uzEMA5FLlHhsElstQwL2yj/bu0ffbr2oYAT4UePTv21jeKFcr+DSp33h3
         47WQ==
X-Gm-Message-State: AOJu0YxyY5xRNLQyn2ikS2I3vXS0SrI8dieESy5evz/3PvtG4WcdsWnk
	bewTztedalNFj9rEbphK9W6OK6Z9sLsATO6FNaKvLEYOF0M0ZXRUF6x2S27n9fzfjV8EEsdfUKp
	3KCkcyb7VhQYrzo7RmOM3FmULt1nCte9nWRwtooeg9JajZ9qHsbCSUd7XYvUXtfEjX19h8ltrH1
	R7TsUZL1YO53vIYJz8MSzP0ImihDd3sPwn6TaTf7D8z6Lp2SQ=
X-Received: by 2002:adf:eb12:0:b0:343:9d4b:d920 with SMTP id s18-20020adfeb12000000b003439d4bd920mr8641687wrn.40.1713289939444;
        Tue, 16 Apr 2024 10:52:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy7ivQXIfAyRYzvSmU//iKgpRiLbz5LJuWHhAqMPpsWN86EtR3FUEfuESD8Ag5BMPC4LO1AHCvyL1UG0bDSfQ=
X-Received: by 2002:adf:eb12:0:b0:343:9d4b:d920 with SMTP id
 s18-20020adfeb12000000b003439d4bd920mr8641674wrn.40.1713289939105; Tue, 16
 Apr 2024 10:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412173532.3481264-1-pbonzini@redhat.com> <20240412173532.3481264-8-pbonzini@redhat.com>
 <Zh0p6Jz5eKBBmWci@chao-email>
In-Reply-To: <Zh0p6Jz5eKBBmWci@chao-email>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Apr 2024 19:52:08 +0200
Message-ID: <CABgObfbsZKRidj7P72suZRAKcNQiRwFb73hi8iELU_g7kvt4Ug@mail.gmail.com>
Subject: Re: [PATCH 07/10] KVM: VMX: Introduce test mode related to EPT
 violation VE
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 3:22=E2=80=AFPM Chao Gao <chao.gao@intel.com> wrote=
:
>
> >
> >-      if (cpu_has_secondary_exec_ctrls())
> >+      if (cpu_has_secondary_exec_ctrls()) {
> >               secondary_exec_controls_set(vmx, vmx_secondary_exec_contr=
ol(vmx));
> >+              if (secondary_exec_controls_get(vmx) &
> >+                  SECONDARY_EXEC_EPT_VIOLATION_VE) {
> >+                      if (!vmx->ve_info) {
>
> how about allocating ve_info in vmx_vcpu_create()? It is better to me bec=
ause:
>
> a. symmetry. ve_info is free'd in vmx_vcpu_free().
> b. no need to check if this is the first call of init_vmcs(). and ENOMEM =
can
> be returned on allocation failure.

There is no need to return ENOMEM however, it is okay to disable the test.

However I agree that doing it in vmx_vcpu_create(), conditional on
vmcs_config.cpu_based_2nd_exec_ctrl, is a bit cleaner.

Paolo


