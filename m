Return-Path: <linux-kernel+bounces-151118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D14B88AA957
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A511C21815
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BDC47781;
	Fri, 19 Apr 2024 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQRtGj4M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECBB1DFC5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713512326; cv=none; b=QB3Upcyn8bMvoo9acpOjpkKgonP1b0Y0vFitZihOqa6EMn2P9XcuBA524thfVDLDyU6+SXe7tGGf2wcMKlHSVVkDBYBwqeLNniBomMWwmhV3FE1nZdln6/F867HJhLq+nn8PHnnMAVBpkNTegFSXPu+zHW/Bgz/FTC6K9jR8f4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713512326; c=relaxed/simple;
	bh=Y/f/mgyt7bp88akdaZ9s0ZY+G+A6RHJ/76pkBzfaEgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVtR6iLjp0n2RxvAId5oLfELqsLSA/cFaBY+hLUrjVnOUXOGD0D/e42frr7xiQc7kto4ypjZyYKoy5QEmMq9wKNWp2Q/LtAuLWbmt/pCXSChVT4VZncCJ+bttpFBCY6ARlbDSJknoqdLqg2w79pCC2mpZtmW3nQSSE863IWJ4ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQRtGj4M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713512324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=foFNvAIC2rOsHzxH9Cr3iI2euQ5V0PsZmOseyI5rE+s=;
	b=MQRtGj4MwPxfCIDFzpWTVYAQiYGviuIHR97KbR2iQvTMZfsTF7j+0ikH5JAxEQzZAy+MSe
	i9Hl4YwQUbp4zzF1o3VfeuvaFd1BzFwMQIjt0iM/ilLSIxKKsUhcA72DycFjIKRIqySNRe
	+rM+GyAgQyTszIY4At8/puoqUYdKOGU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-FkGKHmjRPWu3s38Dtek0OA-1; Fri, 19 Apr 2024 03:38:42 -0400
X-MC-Unique: FkGKHmjRPWu3s38Dtek0OA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3497e65c31bso601806f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 00:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713512321; x=1714117121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foFNvAIC2rOsHzxH9Cr3iI2euQ5V0PsZmOseyI5rE+s=;
        b=CqxdbSHeCVTlyYyNwo/LA6ta7gNfmON0zfHLtUfTShxyeQx7wR9upZQr6OEtfE0Ii7
         ValfoNDdXgFKSjpRt+w6hb/BL7DDgcWd80oKkWsv/6MQT4pVGdqH3P8QdTeVGs6X0fTJ
         prr2TyTSprsMSeVrwLkWmZLAMrsK0W8/LtskoLJegqG5Y9altgnMYKxy3V33AxCg/NVV
         043ByEuy7+NFTvIxE4mW+UIzaH18AHbP9e0YBcAy1fhA/V5Yq4qgOAwag+Al1UkzW+Jf
         F1GKNBSsw/JiybTDT9NOB6eeHCSaPsvHi+ESjHp0ZutZhy81njuJl826ZCu7y9y3bxUW
         HIiw==
X-Gm-Message-State: AOJu0YyTdJwM7Or1o1m1LcWa43CV+tuuL0K+EsJJDaHlxkwrWvIV3Uop
	txXwWIrzZ0Dm5mkN6j8CmLsOvtDG3Y2dlql9DEmW9GYxoWYnvw681V3HKFes+4t9MFtsdkYMp90
	g76hSQITtxwwthv2S8LBy1t0bRyFKr8p8Z3lf1rOhUC0TpAuWGN3S5agJvCzHaKp+oGwqG0pjM0
	mM7eJrvv59LK0k2vKkuskIJbhOdSJgNj+JO8gc
X-Received: by 2002:adf:a346:0:b0:343:e152:4c43 with SMTP id d6-20020adfa346000000b00343e1524c43mr1078861wrb.2.1713512321312;
        Fri, 19 Apr 2024 00:38:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBm7gM3w4u49uGFHPoxgT4CnIjPG/kpt9B6lavOOvxtIFnr2HR6Ze5zkVnSN4GZ2f7T7KCLdmfJQEbjRPtbf4=
X-Received: by 2002:adf:a346:0:b0:343:e152:4c43 with SMTP id
 d6-20020adfa346000000b00343e1524c43mr1078843wrb.2.1713512320962; Fri, 19 Apr
 2024 00:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416201935.3525739-1-pbonzini@redhat.com> <20240416201935.3525739-11-pbonzini@redhat.com>
 <9737d0db-0cce-41c5-94fa-c3d9550d7300@intel.com>
In-Reply-To: <9737d0db-0cce-41c5-94fa-c3d9550d7300@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 Apr 2024 09:38:28 +0200
Message-ID: <CABgObfZv9DDkMFT0MpuxQ-U+BQqzURpAR-+mtVNU3pLBo_4XJA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] KVM: x86/mmu: check for invalid async page
 faults involving private memory
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	isaku.yamahata@intel.com, binbin.wu@linux.intel.com, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 9:35=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
>
> On 4/17/2024 4:19 AM, Paolo Bonzini wrote:
> > Right now the error code is not used when an async page fault is comple=
ted.
> > This is not a problem in the current code, but it is untidy.  For prote=
cted
> > VMs, we will also need to check that the page attributes match the curr=
ent
> > state of the page, because asynchronous page faults can only occur on
> > shared pages (private pages go through kvm_faultin_pfn_private() instea=
d of
> > __gfn_to_pfn_memslot()).
> >
> > Start by piping the error code from kvm_arch_setup_async_pf() to
> > kvm_arch_async_page_ready() via the architecture-specific async page
> > fault data.
>
> It is missed in this patch ...

Ugh, thanks Xiaoyao!

Paolo


