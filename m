Return-Path: <linux-kernel+bounces-76346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC3185F5EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87879282354
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6143E3FB22;
	Thu, 22 Feb 2024 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJkEAVxd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CF83D97D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598539; cv=none; b=IcKDxyyy0JwQgmIu7I380ADCTD8Vz1Cg9UUcUfzaQKbBKTmMur1vq54O6G7JdNcWHaHbG/L+p6k80iTMMzA+A045BgMKlxUIIcEOw02DCXOgAGsXfBJciQtkBjqVLLyLZgmgW4tdW76IBv5/e/MMdoOfZIAe1twoMxToS9lEBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598539; c=relaxed/simple;
	bh=Wr5ytHS/LMlDWoRnSdVRq/OpKXEKN1tbEGP4/UioQ8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVvC3bNWconA+qqBOyHSu6c0y0B3MgvHepqndUshJDnctTNSldjwdI0hTRdj6HxJbVl9VHxEHaf3qkBE71rnirUEgWi7Blnf3CktfjQRlQd/f6eBupmTw1ZLz36irOrVnMQd+RdovTYwE/prus5jSl+Fz6vU/VCeLOJuqKnrc7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJkEAVxd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708598537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IVi5xtqagqhQr4yQkZ21VVqriPXn5rhJhhfioOmJJms=;
	b=IJkEAVxdJD44zn7swPrGfCw7WR5J8HVixSLVmmIlwzS0wjBpQl361lVdcBmejuDgAHVthX
	WM33T12THEwlopGiHtesWDJDbXQ3yALktXXdQtjq3/HnY6SUdDoy2h2zsJUUK9VxpkJ9S2
	UHAhwy+Rflhn1zGsmYA7HeaG8K5ellQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-gPspGIiDOZWmQExj-lSLOg-1; Thu, 22 Feb 2024 05:42:14 -0500
X-MC-Unique: gPspGIiDOZWmQExj-lSLOg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d60ac6781so1679297f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708598533; x=1709203333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVi5xtqagqhQr4yQkZ21VVqriPXn5rhJhhfioOmJJms=;
        b=OogY2g7bMBF/C7Tfgew8mtdh4iNsMlcFr2rFFu+h9Ab2SQ4Wi0AjjxvTp53p0+B2bz
         5JQk/7ktIx6rZ+eOvgOyD62ZAiaJaknvwO8HWZplWh28lK13H6PbooeHye7nKPqAEFZt
         ZcPh1zkjuprXRxEx5AX498NrV/2e+kY6Xy3ZyDLAB1XE93xgY4IdNkf8BMsB2cxXeap3
         SWIboyZ6n/YzUevhE006qBWctxSeTAkxXb3O+eKTTzBMBk5AzxyO56erVvaMUKEpyUxl
         cMwFUKc70DE8gNIVk1AAV6C2VSaq6tdGZqCSMO4/cEIWF8yano9t3V13Uu8KIY7KX+IH
         Qj3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtCTID9RIc7rrs3Tzv2xlS9vnELEu3u4/Mj1epYElEPLC/SOaLMYSg7IqIqQIMjp+lSbS9enQ3C+7kObNItXskq49IluTb8khN0qHX
X-Gm-Message-State: AOJu0YyYminHPX2RKO2QJ9+7dfjwd9XgTSfaHsWeMWVJcgZfWfSG+O2Y
	z2Ijcbf0M968nYmtpqBNSc3YRGeJENlTUTqbm2Hpw5iqU8AZU3Nkh8Z9RDUJeKE/NkPm8CPLdJC
	wiHL7jGFNlg6Ox2ofN5QYbLLb+epWe7TtDlINXCxLAQTgIx1H4whsKj+6UGnyZPd1TDo7g38wTI
	A6guaQCc9/4X1nwWaRqfTA7g/UY0rgGwT9MXJn
X-Received: by 2002:a5d:4850:0:b0:33d:391b:8db2 with SMTP id n16-20020a5d4850000000b0033d391b8db2mr9472700wrs.61.1708598533672;
        Thu, 22 Feb 2024 02:42:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFt816+aUtSBUADBI4CYXrHxRHYjhYyzfPh3WwqLeFMhlmXg2tNA3B2shw4FqT67BiVbto4PUojvsiihkGZ5Sc=
X-Received: by 2002:a5d:4850:0:b0:33d:391b:8db2 with SMTP id
 n16-20020a5d4850000000b0033d391b8db2mr9472691wrs.61.1708598533378; Thu, 22
 Feb 2024 02:42:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222145842.1714b195@canb.auug.org.au>
In-Reply-To: <20240222145842.1714b195@canb.auug.org.au>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Feb 2024 11:42:01 +0100
Message-ID: <CABgObfaDQMxj9CZBzea+=1fcFQXEemAJoH5Jvc9+tfiC7NAvrQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the kvm tree with the drm-xe tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	DRM XE List <intel-xe@lists.freedesktop.org>, KVM <kvm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Yury Norov <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 4:58=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the kvm tree got a conflict in:
>
>   include/linux/bits.h
>
> between commits:
>
>   b77cb9640f1f ("bits: introduce fixed-type genmasks")
>   34b80df456ca ("bits: Introduce fixed-type BIT")
>
> from the drm-xe tree and commit:
>
>   3c7a8e190bc5 ("uapi: introduce uapi-friendly macros for GENMASK")
>
> from the kvm tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Lucas, Oded, Thomas,

do you have a topic branch that I can merge?

Paolo


