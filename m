Return-Path: <linux-kernel+bounces-133444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB58589A3C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD671C21D40
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA45172764;
	Fri,  5 Apr 2024 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XM68a/Fw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4E4171E4E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339891; cv=none; b=ukpx29pTzk31Cc8sr8uKKqJ6g2SrPv0Tbdy66xnhycUY39Dw4b7DMBDgAyziqWOuiKs4DVP3ovVM5DwHAOmEio46qX2XsaJ36ajaK2I/2hml9qjXbUApQKG54ZAX7iYMXTrOSNLPV9OzX8MoWx8v9IGvCQtLQUFPaLOJtKJystQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339891; c=relaxed/simple;
	bh=OhLR3iFcGyOMlWUTvWA89GxCLTl14dKyEPs7NecTHTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1qVhgF/XFJA/+KTGH0VczGryGgfBeQLT8IqhFCRozNwwotZ+2JaVC9Ke5oe6wHTMK1tcYUB4h+BH+rNp6hwdSjBX0ocQA0F7PZ1M6cJ6XVbcwO1FcnUS7FLRyKz+J6EeTPz+vZbEK7U9YD59XQQi6DAHfiCCP5zJsWG1eQNKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XM68a/Fw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712339888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OhLR3iFcGyOMlWUTvWA89GxCLTl14dKyEPs7NecTHTU=;
	b=XM68a/FwgHNprCpqSgJNunkolJLMVYT966+W+FknBnEn/ViFy6J99IIQZ6nK7hnoSocx7z
	81uXfzwnWfRxDQSO15JJVhgp9fiWX3AVL3+hz7+OwrgkNeW2ZDgl62VASWZd0vVUHlY9Tm
	YODQ43fiTY4Lo6D2LmSVRWyY3RqbbX4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-2iqGZelRPOWsBqBnTdnKVw-1; Fri, 05 Apr 2024 13:58:07 -0400
X-MC-Unique: 2iqGZelRPOWsBqBnTdnKVw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343e00c8979so593561f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 10:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712339886; x=1712944686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhLR3iFcGyOMlWUTvWA89GxCLTl14dKyEPs7NecTHTU=;
        b=jA6Jg2fZycjGakhuwKnYc7Ne2eAN54cB8ADTNIoTBbo2nia3Mjk0h8CIEx2o8rT4MI
         kSF8Ycbyi7M6tI6Kxrrc2qopJLF0QkxSjNssdyP0wGH94C76mO2VVF+EBEF3GPgm+Yy7
         r5iUgEjpZAgbrIPhsUjlgyv0sncxJmqgolFHXiCz2ArjsNlSjL8fYHhZSIWv8zp87U9z
         KUok+zcA3nh6vQY4/DCvvr0Du2kmzqG/6nf93OonCg+DDjXRiLoTKdYa2Po2BgYeoRBW
         KigH9KIgtbj3epWmX5wWXdIjrxmVDjHZLiQOsugQhhvTJLMqmx4RDSniAoY1CQOODSAv
         PlGQ==
X-Gm-Message-State: AOJu0YwXr+Efgw+FF5ks2De2PeWoc8ScxuVjlxx/QYbtyB2a1/ahw4YS
	4Xj0ia8EVVM6odR2l0k6eJsF7Yg5Udpuog0P+15q9m4Ug9Qkj0qiLfDQxTkplP6vJYif/ib4XTy
	mGcMTCWLaocQ9Zpav+GuOX21KghzBpWu8nfsjsy0R/Bq/o50k4nztDi/t3vROCr7EkcUr5b3hz0
	aVxtv8ytmQAbI3s5D1DYHkcpmKswkLgSXYGqef
X-Received: by 2002:a5d:4f0e:0:b0:343:6f88:5e5 with SMTP id c14-20020a5d4f0e000000b003436f8805e5mr1340184wru.55.1712339886054;
        Fri, 05 Apr 2024 10:58:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3CWAbZ2yvXyD8JF17AyMAjvakK2b+OL6J+dTN23cnwf6QWbAXTlTGCRG23eceVxdEZJl2migUhbs+XDvpQjo=
X-Received: by 2002:a5d:4f0e:0:b0:343:6f88:5e5 with SMTP id
 c14-20020a5d4f0e000000b003436f8805e5mr1340171wru.55.1712339885715; Fri, 05
 Apr 2024 10:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227232100.478238-1-pbonzini@redhat.com> <20240227232100.478238-14-pbonzini@redhat.com>
 <754f2fcf-fc00-4f89-a17c-a80bbec1e2ff@intel.com>
In-Reply-To: <754f2fcf-fc00-4f89-a17c-a80bbec1e2ff@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 5 Apr 2024 19:57:53 +0200
Message-ID: <CABgObfaGhH1aQyR-k_x=yrSRE3uwDpx9JJoMdiAdJCq72-O4DA@mail.gmail.com>
Subject: Re: [PATCH 13/21] KVM: x86/mmu: Pass around full 64-bit error code
 for KVM page faults
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com, 
	michael.roth@amd.com, isaku.yamahata@intel.com, thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 9:57=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com> wr=
ote:
>
> On 2/28/2024 7:20 AM, Paolo Bonzini wrote:
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> >
> ...
> > The use of lower_32_bits() moves from kvm_mmu_page_fault() to
> > FNAME(page_fault), since walking is independent of the data in the
> > upper bits of the error code.
>
> Is it a must? I don't see any issue if full u64 error_code is passed to
> FNAME(page_fault) as well.

The full error code *is* passed to kvm_mmu_do_page_fault() and
FNAME(page_fault), it's only dropped when passed to FNAME(walk_addr).

Paolo


