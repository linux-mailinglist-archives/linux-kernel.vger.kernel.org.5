Return-Path: <linux-kernel+bounces-131785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1956898BBF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230DD28699C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599A517BA8;
	Thu,  4 Apr 2024 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5rtdcsh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94B1D545
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246653; cv=none; b=S6+PSY8eoBvG5jjmTebpCiS1MaWwVKIGcPUqM0c4yHqWHVxegpz75MNijZ9kwMuqh66xxDbTgYlQUAm/3HNsATg6m5BquopCQP4nT24H7FaBUE3bvJEKO+ZFEnWZF1mKpv5D9G3/y1jfhwcgfmTT04ZjGizlZJKpKltNYTDmghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246653; c=relaxed/simple;
	bh=AYKWp+p64k+3RQGIf/6q/yPwgymf6ydLwHfuSidhdYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhL54ID1o+0xo4C4dNNASqbwWsFfmcWkyultcnQWN4BUJAo2ZFyfJ9Ef/jHhIruBM5H/ql/CFP8sjrS9IDeAg4omHD+EirVz+KDosSYBvf89adLt37TcIV5GsVJWHM1FuK8zjp7TiZPrs8godMhr4TcVm8qRtC8cKAqDzEhG3mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5rtdcsh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712246651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvQMa3e6aa+6chnorpY7KHYDJwijcL8jvc2jYGypk/c=;
	b=O5rtdcshnrtpKXg7g+Quew7dKXWy6Llad//gFAGbDgbSTcSCtgPpHBtmHeFqehfD9F8wlg
	UtXaUwoscRI2eEymQeIGr9rhoS13xCI9mpHEFx46+sSe4vF4bQ0DeCWtG0pTmlWjpWFibY
	xSxR0qelbeoawPTbc/PT4qgBWMWJmWw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-9ZnzzwZ8OJeRq5vtq9SviA-1; Thu, 04 Apr 2024 12:04:09 -0400
X-MC-Unique: 9ZnzzwZ8OJeRq5vtq9SviA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33ed71800f2so685127f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 09:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712246648; x=1712851448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvQMa3e6aa+6chnorpY7KHYDJwijcL8jvc2jYGypk/c=;
        b=X+8ZPZzAUMTgp+8G0qb90P9KRm8ShfDDj6gIa04Y9mNs6pyKrDRxkMw9iPAZbXlPnV
         PPgn7phET4QVojQQ8TWyosWfvbAXCbayQtJYR2FzAaTOdbynwlvF2FJEzLs5DjOCN3hs
         Fhgtf3dLAME6S/lzn4k+uuDcL7M2PxyG0wW8ccSmbS5I/xj201vrrAjbZCpjmHpzzTU9
         N7VxGg7Ax866tkCNCke1q1mnLfpVvZOf0spEcDA/BfkXtGYmLj6FuLdxK2eoxRobUQve
         BLxrUoKaL0jVtYpshOZ4raRN9dMllDXoOGPaocEDo1lgqa5T9+UR6m+1BtVXChMz02d1
         vd1A==
X-Forwarded-Encrypted: i=1; AJvYcCVOdH7EJZZD/imJFo5cQPtEO0VFOE6syBq/fR98TukjAmRnrxjuHaFJX0GOQkj0tbiVF9RD8nDq7xFNNpKVVHbm+CxB5mG9ZAX0ZdUi
X-Gm-Message-State: AOJu0YwcrOlpKgUGxd6BZszgXqn2VJDCV4tHj7jxhOoeXnmeCwtHCh61
	s5yo1SoyR4k9o2Y5r1yMnaftvqQNKlxcGcmxtvjcwfQZIZiBRj9C3LO8snUQ6l9ZXrurg8JGaQH
	ECD4ApHrKF2VgWAVF9BeVWXmH08B2JsY3Iq4xfaRJIdV10D6intGaCWkEzLWMT2Era0vItg3gpL
	lyuhlxs5DBmP4y3vPkzknVzV9+VZ6r4WoUI82O
X-Received: by 2002:adf:fe0a:0:b0:343:b0b8:d68f with SMTP id n10-20020adffe0a000000b00343b0b8d68fmr18351wrr.25.1712246648584;
        Thu, 04 Apr 2024 09:04:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9lMpRrvRHs7aq9HiR8B7m2xP5O9kx9uCjd68Psn0mas4tU/87cr01m6gWW8MfdNwKQqtC9KSc5JGf2m+NNJ0=
X-Received: by 2002:adf:fe0a:0:b0:343:b0b8:d68f with SMTP id
 n10-20020adffe0a000000b00343b0b8d68fmr18315wrr.25.1712246648224; Thu, 04 Apr
 2024 09:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329225835.400662-1-michael.roth@amd.com> <20240329225835.400662-12-michael.roth@amd.com>
In-Reply-To: <20240329225835.400662-12-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 4 Apr 2024 18:03:56 +0200
Message-ID: <CABgObfaGNsAva0t0_gm8m0QANaOU7d-EeHvcShJSpCozoJwDnw@mail.gmail.com>
Subject: Re: [PATCH v12 11/29] KVM: SEV: Add KVM_SEV_SNP_LAUNCH_UPDATE command
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, jroedel@suse.de, 
	thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org, seanjc@google.com, 
	vkuznets@redhat.com, jmattson@google.com, luto@kernel.org, 
	dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com, 
	peterz@infradead.org, srinivas.pandruvada@linux.intel.com, 
	rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de, 
	vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com, 
	jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com, 
	Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 12:00=E2=80=AFAM Michael Roth <michael.roth@amd.com=
> wrote:

> +static int snp_page_reclaim(u64 pfn)
> +{
> +       struct sev_data_snp_page_reclaim data =3D {0};
> +       int err, rc;
> +
> +       data.paddr =3D __sme_set(pfn << PAGE_SHIFT);
> +       rc =3D sev_do_cmd(SEV_CMD_SNP_PAGE_RECLAIM, &data, &err);
> +       if (WARN_ON_ONCE(rc)) {
> +               /*
> +                * This shouldn't happen under normal circumstances, but =
if the
> +                * reclaim failed, then the page is no longer safe to use=
.
> +                */
> +               snp_leak_pages(pfn, 1);
> +       }
> +
> +       return rc;
> +}
> +
> +static int host_rmp_make_shared(u64 pfn, enum pg_level level, bool leak)
> +{
> +       int rc;
> +
> +       rc =3D rmp_make_shared(pfn, level);
> +       if (rc && leak)
> +               snp_leak_pages(pfn, page_level_size(level) >> PAGE_SHIFT)=
;

leak is always true, so I think you can remove the argument.

Paolo


