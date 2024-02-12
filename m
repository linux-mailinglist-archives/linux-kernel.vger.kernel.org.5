Return-Path: <linux-kernel+bounces-61281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 414F285104B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1298284D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD84C18624;
	Mon, 12 Feb 2024 10:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhvY2WCp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AB2182A1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732356; cv=none; b=ENJcbkdjekFwlqxPGWMcmW/cVvqPrggY5Yn8jzbIE2pljr7a6vHHZv/FiMY+3H8uqp59TjHyb77rq3rK1qpSYYWWBYB3XBIKeocBRJNFzkjfWXcsDp0WN2i4bgj51ElP6gveEZqNGmFbEguun2l/wGM/U8grQFCWbHFOOKA9Akc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732356; c=relaxed/simple;
	bh=Wz3Igt76gUzwJJe3QfNiRBzS4XiV7PCRiBzUXh+mcIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZZ33RMzOS//1DiqAPUqnqjEBi01d9LZy/b2oH/1pjvqiDCqvMUOkj5YS6Wr+W0YJoxHm4n9pxHmeV1dOLs8WUjhNskeotOm6i2Dfm+uQF0gnzqRJuX43Rs3zr+s5FVYQQc2ykKngxXlYhp/Uj8EBTe24L0b/kSL1NnySjmzFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhvY2WCp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707732353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9NB+yvDFxltKDSPmB8kuUqoCt7FggvFJ2MXEIt1gVg=;
	b=QhvY2WCpjGCoVMlWaOGGkriYI0VPSkTmbOhXnNkwoxuspiQFIEqxhLNVShPBx/fjfb5Vz1
	dxnYU8dHsMBlg7CFoPsGhgwvejqDSJKx95oxJrDilEU6nUUgmXsqUqhoAnPDK+GJ1PIOtr
	CGG+TQf8D6n+8beEFFk8/nnEYTdVGGQ=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-ELuluS6cNUKJnip4Jv6X-w-1; Mon, 12 Feb 2024 05:05:51 -0500
X-MC-Unique: ELuluS6cNUKJnip4Jv6X-w-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4677690896cso1210714137.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:05:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707732351; x=1708337151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9NB+yvDFxltKDSPmB8kuUqoCt7FggvFJ2MXEIt1gVg=;
        b=mhs3dbXmt4nB6T7R9EzLBTGANynRE3ne16hE6fiE/jHSutUFJNNy6OsGRo+sJDkehk
         jHXT9m2ulcFND5Ve5YvWEoY1TwL25TXh3pXRN/zL9JNJGsw+eCrZuN4AQfWKOGERC+jp
         xlyX9SPM5gDGa6c1vc0aLmg1V5Lvvsn6u2VILIR0ICdv3EQS6D1cNZAmi/sBVjkmw++v
         sKfKDkto6PsjDvAl1e0hsJB9imaEPj4ZitaJ6q7P3XCOUBjTwdbTUngiN4dzqL+4kWnl
         l0zawpOrhfNjffauypBK8SnpSouXVawDUFkhyCan9Ksp8hSvF8YrQdm1vnGf75gvtu89
         qsng==
X-Gm-Message-State: AOJu0YwyG6XkmJA9mMiafy1vZxwRG+Z8OglBIL1B2gtGpzZBIw+/KoKw
	/XkFF/5vWdADncop40KiZ+d6DhlTHRFcAgHdHOsoZDxN//+V0bm5l/Em59fAHkqkPF+2sL8eaRY
	z/XWgTOJ/yEeeA1sSh0hVTRaXMbKnde4UoLjaXhrW2c5m8aa74ePgNedGgqRisxQBGhrXUZ01V0
	m3PF+VBHFwV5Pnah/bzKqHJ35Vj7wop+SGe2fj
X-Received: by 2002:a05:6102:2257:b0:46d:3a98:2846 with SMTP id e23-20020a056102225700b0046d3a982846mr2605339vsb.15.1707732351348;
        Mon, 12 Feb 2024 02:05:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHi0TD7WQgwvMqZlbCAYD+0WsvU/zcQXCDClTSsPA8snYp3w4Kzc6xouTVN8AwdtHUnBD76nnZDXf/199GkL/o=
X-Received: by 2002:a05:6102:2257:b0:46d:3a98:2846 with SMTP id
 e23-20020a056102225700b0046d3a982846mr2605328vsb.15.1707732351120; Mon, 12
 Feb 2024 02:05:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705965634.git.isaku.yamahata@intel.com> <a4d44b01523c935595c8ee00622ab8766e269ef4.1705965634.git.isaku.yamahata@intel.com>
In-Reply-To: <a4d44b01523c935595c8ee00622ab8766e269ef4.1705965634.git.isaku.yamahata@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Feb 2024 11:05:39 +0100
Message-ID: <CABgObfbjKb0x+uO=LRLqU8CZ35L7Tgg9B1i0NUwNRG5aQK9ixA@mail.gmail.com>
Subject: Re: [PATCH v18 015/121] KVM: TDX: Retry SEAMCALL on the lack of
 entropy error
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	isaku.yamahata@gmail.com, erdemaktas@google.com, 
	Sean Christopherson <seanjc@google.com>, Sagi Shahar <sagis@google.com>, Kai Huang <kai.huang@intel.com>, 
	chen.bo@intel.com, hang.yuan@intel.com, tina.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 12:55=E2=80=AFAM <isaku.yamahata@intel.com> wrote:
>
> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> Some SEAMCALL may return TDX_RND_NO_ENTROPY error when the entropy is
> lacking.  Retry SEAMCALL on the error following rdrand_long() to retry
> RDRAND_RETRY_LOOPS times.
>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>

This patch should not be needed anymore, just...

> +       /* Mimic the existing rdrand_long() to retry RDRAND_RETRY_LOOPS t=
imes. */
> +       retry =3D RDRAND_RETRY_LOOPS;
> +       do {
> +               /* As __seamcall_ret() overwrites out, init out on each l=
oop. */
>                 *out =3D *in;
>                 ret =3D __seamcall_ret(op, out);
> -       } else
> -               ret =3D __seamcall(op, in);

.. use seamcall() and seamcall_ret() here instead of the "__" versions.

Paolo


