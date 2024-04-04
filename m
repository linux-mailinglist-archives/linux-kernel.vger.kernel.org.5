Return-Path: <linux-kernel+bounces-131345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7919898687
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6716C1F29F37
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838FD84FCF;
	Thu,  4 Apr 2024 11:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0kq/QWF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B8184D10
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231621; cv=none; b=crSf8u3Q/ajlg9hwO9xPLpUxzYw9iNZ2tNY4uWO9ZaIyTyuy8PgvU3eN91BZH55ErZuUB4dBSarKmQrmIovlwR2u/ERgYbGD9ldRhzA9btblMTnw2KeQj1rayrFKRt+wrns/P8itKhHaKko2d3hEoSkW+8fHOp31e29LeRf/+UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231621; c=relaxed/simple;
	bh=g6Px9tlSXBxUzorbMkQXJNo3nNSoY0owCkx1nBqEoj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKA3dvNHTnfpZndP9lP0XwFkmja36y7ZJYACmbqqMLgvMz380hoDkicEK32Qi0lYLKKZlYf7kszTjoZa/F5WlZkHM6vZfkklduvEottzmCdh+ulpSaPCHryImaFoMQed1E/1AlsIPbDb80S7Y3VTNYzZmUoPkXhrMEVMRCj1HxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0kq/QWF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712231619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6Px9tlSXBxUzorbMkQXJNo3nNSoY0owCkx1nBqEoj4=;
	b=e0kq/QWFm4wn0xFFxuOp6z5SXEnu4kYPeeMPMopKMfIVeUwzblWK4z0Mi1Tt4/ZS49gI4D
	CsOQL7PbqP4f76G6cd/TgH+mvkDOJAcA3Wz+aFLH+wK5HiJEOpB0X+WhkxqmvrPJZmg6bG
	mqCqcMDuOVQNfe3P3ypDLw8bX1AnvqM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-rFAmNF0WPYeW1EBdRoh6kA-1; Thu, 04 Apr 2024 07:53:34 -0400
X-MC-Unique: rFAmNF0WPYeW1EBdRoh6kA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41463be093aso4178595e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 04:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712231613; x=1712836413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6Px9tlSXBxUzorbMkQXJNo3nNSoY0owCkx1nBqEoj4=;
        b=RhxSIsO6aJF8/kflEBatxRpDwaI1gcuYppWASoWzFKwZUPgaT92peUH28/KDX5njJN
         Dtb1rusqInekndbwZflo/N5/Wi0Rf+5pHnIrZus+Wv/RXFW5o9B+fxpXJPvrp7bzJcvD
         8xSkt+YE5PXFqfyoyErrgVyUbSPt5MRUb+HgN2YUtk4VVxwRTJpymNdkpM6Y3/RUDUTZ
         lM8WC8HG5rDyoF754jmLu1iMGRaWdpk7YtNR1eo6NI63lZnC5yP1dNWGUHjono9eIRff
         DhhU9ygjB4k399t84xf8LItb6EZa5hph81a1ExGTs1mRryxgYNEIYi3BO6Mfmb9N4MbA
         FXkg==
X-Gm-Message-State: AOJu0Ywk84ntvK2JHkbt6a/JTSuz5FeyS8/4EMdaCRKoYuDDsmVGsjBt
	DO026VMzad1lZhu5wBu8RjOn4RTOHJ4yNR7ilhJ6qFFF+Bi4WWypO9de/D9a0DVh2gDzU5FutXZ
	YHk86dl/YYkB1od98q8wJ6xjGmfttZ6a4UQxnz3rAlOnDMZxt1bJeyWKyPVDaUF7oiG3TFwONhn
	EeIBOEaYkzxtfIm+Fare3UzAQCMxkOlqetnN1j
X-Received: by 2002:a05:600c:3586:b0:415:54d2:155a with SMTP id p6-20020a05600c358600b0041554d2155amr1787069wmq.10.1712231613728;
        Thu, 04 Apr 2024 04:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESEgkpGiuslXRhwuv9Ia0bzlGOZuvK1wVw34I8Lmio84RtnHXGCk7Boo8hw/o3eDIB5LCNP1M5YAVa/U3N3eg=
X-Received: by 2002:a05:600c:3586:b0:415:54d2:155a with SMTP id
 p6-20020a05600c358600b0041554d2155amr1787056wmq.10.1712231613436; Thu, 04 Apr
 2024 04:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318233352.2728327-1-pbonzini@redhat.com> <20240318233352.2728327-10-pbonzini@redhat.com>
 <20240324233918.25tsnexp3rlnhtaa@amd.com>
In-Reply-To: <20240324233918.25tsnexp3rlnhtaa@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 4 Apr 2024 13:53:22 +0200
Message-ID: <CABgObfa3UQd7LqWh0SYgFjxCtKiq64yHycw7LEu1h_1F0=Q4Xw@mail.gmail.com>
Subject: Re: [PATCH v4 09/15] KVM: SEV: sync FPU and AVX state at
 LAUNCH_UPDATE_VMSA time
To: Michael Roth <michael.roth@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	isaku.yamahata@intel.com, seanjc@google.com, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 12:43=E2=80=AFAM Michael Roth <michael.roth@amd.com=
> wrote:
> There may have be userspaces that previously relied on KVM_SET_XSAVE
> being silently ignored when calculating the expected VMSA measurement.
> Granted, that's sort of buggy behavior on the part of userspace, but QEMU
> for instance does this. In that case, it just so happens that QEMU's rese=
t
> values don't appear to affect the VMSA measurement/contents, but there ma=
y
> be userspaces where it would.
>
> To avoid this, and have parity with the other interfaces where the new
> behavior is gated on the new vm_type/KVM_SEV_INIT2 stuff (via
> has_protected_state), maybe should limited XSAVE/FPU sync'ing to
> has_protected_state as well?

Yes, in particular I am kinda surprised that MXCSR (whose default
value after reset is 0x1F80) does not affect the measurement.

Paolo


