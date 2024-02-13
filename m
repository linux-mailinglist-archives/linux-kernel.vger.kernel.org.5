Return-Path: <linux-kernel+bounces-64454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 575A2853E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12ED1F27A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174BD62167;
	Tue, 13 Feb 2024 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMI5rw7P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10016215F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863135; cv=none; b=DIw2axbQUNl0eQEhxtCgUcHwhK181JayFwbs17mrbcvL1lCgwLIDg/2KQe3Zb5Hjw9v7gzW+VdL9X31K4qtANusmSye/T7bLeI5G/rJHa7YppItxqjk9ZrtxMIYUYO5DxBJCKgHsmWILkd/dnTKiazn/bYeXO8E7Pf1OlW777fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863135; c=relaxed/simple;
	bh=SI3shktrX4HINcYJVC974f91I6xkc56CaOZn4QD2LpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sauqQQEbHZF4FPaupXbt8dBjluqwYd2/L0NUcK7qehDgSNoYPFKLCl6ClssR9opFQcI3ppFzOJfmHjYc4jfKyAZFUuBvakID5eJ5y0JEsGWH8AJynNh3BhSLNxS65/s9RQgF826N5/j9nnRwDqpttf4ccjoxiiMMSCXtmQFrV0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMI5rw7P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707863132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zN8IxTd9DLdZiajIVz77TiDGZaCMDEd7tzeTNMH5Qo=;
	b=WMI5rw7Pyj5TBt3GtUd8TsRW4kd/XG7/JJxv1Nl2GEasmKFJt6KoonR0vHrZ9AYvdAnTxd
	CZFHYP+zy4aPGqBMdYEslciQscXxn2GkQIxpgX+ViJCXXykfJTog2RT//DcmgYuhCFld7k
	D/n9SPagQ4ivniKoT8gezHAeMlMkXLI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-xVGVW0n3O9SVJw1zVNSirA-1; Tue, 13 Feb 2024 17:25:31 -0500
X-MC-Unique: xVGVW0n3O9SVJw1zVNSirA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33b376cc518so2735704f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707863130; x=1708467930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zN8IxTd9DLdZiajIVz77TiDGZaCMDEd7tzeTNMH5Qo=;
        b=el5HQDUDDNxmgdxFVzlXcfqYVQsZB8ufaXtI8FraREfqigfwQfJFTw9jPm3tpyAG+0
         CIag1V6j8eDUtBzRKFq65HbnlqDBjc8IaCT7FJt5KMLtJUJZGjnSA7zeIe+jgd7kXvXV
         vbWJR1Uj6+3GU5q23pS/NOIhmeCCUaPo+oODeGFdQV4neZniW4afwkYWO8EqzLy3Dzt/
         wSKldPT1slyuMTdzC6gOzIycr8Ht1I7E+hStI58wy+1DPtIgnna5AP17TODtVgdFiG60
         Jhw4cUnnizKWYRfho7ykNRplVAIhx/Ml2aMUTieqV/vd0cCUaL0wD7+/VF1WQllA5orT
         W4iQ==
X-Gm-Message-State: AOJu0YxPYqy0Es9sL36/oJYP1tRyNYbn9wUJw845C8YIzUy2ISSsNdvz
	YyQM1Eu9KLUDDhao9ZkPUjJCrRXB09iGf3f++tjlXt2zoNVv8jlxOIGVnaEW4hXQbdLlNnZMvT7
	i4BdARFR69aH7XEPQPHHlShaHqv0CtAdae05wuHQiAEle3qQBeOGAgH17To+J+IdknLnmUTjaPG
	wZCDlmiFq+x7Gjsb45aYLs/yMAnKn/h11g6BTP
X-Received: by 2002:a5d:62cc:0:b0:33c:e2b0:600e with SMTP id o12-20020a5d62cc000000b0033ce2b0600emr457124wrv.32.1707863130149;
        Tue, 13 Feb 2024 14:25:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpDxI/1ABJ8jxCmM4EEqjpASCtGW/vicnp2/NOEK+1DZlZOJK4JIxwJcACRJWQ3PmDfKng/CMvaYkQtmA8JAE=
X-Received: by 2002:a5d:62cc:0:b0:33c:e2b0:600e with SMTP id
 o12-20020a5d62cc000000b0033ce2b0600emr457105wrv.32.1707863129799; Tue, 13 Feb
 2024 14:25:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230902.1867092-1-pbonzini@redhat.com> <2b5e6d68-007e-48bd-be61-9a354be2ccbf@intel.com>
 <CABgObfa_7ZAq1Kb9G=ehkzHfc5if3wnFi-kj3MZLE3oYLrArdQ@mail.gmail.com>
 <CABgObfbetwO=4whrCE+cFfCPJa0nsK=h6sQAaoamJH=UqaJqTg@mail.gmail.com>
 <CABgObfbUcG5NyKhLOnihWKNVM0OZ7zb9R=ADzq7mjbyOCg3tUw@mail.gmail.com> <eefbce80-18c5-42e7-8cde-3a352d5811de@intel.com>
In-Reply-To: <eefbce80-18c5-42e7-8cde-3a352d5811de@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2024 23:25:17 +0100
Message-ID: <CABgObfZ9od1XNVR_Xc6dBrvCDs3v=FwDLx6EZA_53W4kAo8jnA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/cpu: fix invalid MTRR mask values for SEV or TME
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Zixi Chen <zixchen@redhat.com>, Adam Dunlap <acdunlap@google.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:02=E2=80=AFPM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 2/13/24 07:45, Paolo Bonzini wrote:
> > Ping, either for applying the original patches or for guidance on how
> > to proceed.
>
> Gah, all of the gunk that get_cpu_address_sizes() touches are out of
> control.
>
> They (phys/virt_bits and clflush) need to get consolidated back to a
> single copy that gets set up *once* in early boot and then read by
> everyone else.
>
> I've got a series to do that, but it's got its tentacles
> in quite a few places.  They're not great backporting material.

Yes, same for mine. I probably digressed in a different direction than
you, but there will be conflicts almost surely. I can post my stuff in
the next few days.

Paolo


