Return-Path: <linux-kernel+bounces-141362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C67588A1D48
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1431F25318
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AFB4DA04;
	Thu, 11 Apr 2024 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bq8kXP5M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE94D112
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854662; cv=none; b=nSSlu7ednT8Zfp5Z5bF0PBpV3FaxuHZ7J2ZgaHro8gZRxMpyugUJDg3ycRV5+B3//R+5hd4bJvgFOTDyzEMFpGVoOxuFK7bpfsCwtHTnlxszApH0/DdpczBqTHT9b3uPJK0pwfgZ8pm1mNbryQ5V7etBGWT4AypkxiYG6pz19e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854662; c=relaxed/simple;
	bh=mW9Wy5zwtCPwddAQPsiCFCBdlF3xxhTlbzOesWPW9Dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fU2FSLMqMoCv9L1sn5N6nijzAQoaGiy/KiHxzsnZyyMqdyF+Lee+ECUcR5vHMVvNMJmTHxyYzEwY27QXxAeSC34Q3L+OOOCDiYjh+UCFHdZF9ent2fIEjDz0MftC1V8v8NwpJeNyU5Ve9GBaVhF4y0Nh81LhfITeVNCKJdlLM0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bq8kXP5M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712854660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzMoeKDG3HLVO21BydyhZtfJookrt2+0z0ZoaUJK4l8=;
	b=Bq8kXP5MkuS3XlmJgPrN64Q1/iXQRKGX6ssRCLiiB/npbhsJe5J5QPll85IKXyVcVBe5T0
	P6i2Z/KDltJ1Bp6cHXYOsxBL1jzHH53jd3V2nHkDrIaI9OHg63sxV8ZqvSFza8OpSPLbtE
	NSy0gh6YAogdcY/UN8s4pii88bKFqNI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-5Kz9c7MZNMKmM8QRU7thpg-1; Thu, 11 Apr 2024 12:57:39 -0400
X-MC-Unique: 5Kz9c7MZNMKmM8QRU7thpg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-417df7b0265so373045e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712854658; x=1713459458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzMoeKDG3HLVO21BydyhZtfJookrt2+0z0ZoaUJK4l8=;
        b=gADPQZSyUQfh03/c7W5a+WcltVe0jFoT3JGWbaYZR/yfz7ol0qDkaQ1sdLYZQhvrDC
         GGOwsZivTKyfy/ljdC0d/7hoj6Mz/cFjhaam9l22e+ItZ7TqY7/QyrGcBpfhvICDb2wk
         kyhisR10XQR5bvfFqVXKPYbKCLmhqtqpxAQlUACQ1XNrmSlrMA7tavPahCl9fkFlY3kT
         cZSDEKtw7A5JHMIi2y8ix5mZWCHs/HmFnlnzXCI4dOCwIQfVWh9cJwidShAmcHyelAea
         ZKvsBaZkttml4VhZyPEn34AY2AenuIvkPrw34mcYYKuyJ0KQAdjlYLghLaImjvNGIyyh
         Cc5Q==
X-Gm-Message-State: AOJu0YzepbqvZU148VSpMMpFkZl8xt9m7wXcozdCP2ic+dt6fOt5O4Qm
	QmMQ78Mvin42mEmcMd4aiWuClZRsQ4z5G13tL5PCjwGHaYjOZaYZIdkeubnfY+1zBKjIPhRx9o5
	N9oPt6Uj9eV0YoL3hv84ZzJWYJG060sWD9H9PYlM7Wl9oPo9OPHhQqTBxHXEoKb/h00UhkFJ+3y
	KiMlpkYFTM0ZDj5EUUy9hDLiXMUva53dujGE9G
X-Received: by 2002:a05:600c:c07:b0:416:b75e:ffb9 with SMTP id fm7-20020a05600c0c0700b00416b75effb9mr294481wmb.19.1712854657978;
        Thu, 11 Apr 2024 09:57:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmoGFz39xTCvG23vKtpQgogb148s+KvVt7/U1rBvktp1dcwHHxjM7spsq3rgOmQW5LGi5xUnT62q1v5vcy7Gk=
X-Received: by 2002:a05:600c:c07:b0:416:b75e:ffb9 with SMTP id
 fm7-20020a05600c0c0700b00416b75effb9mr294473wmb.19.1712854657685; Thu, 11 Apr
 2024 09:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405115815.3226315-1-pbonzini@redhat.com> <20240410143020.420cafd47bf8af257b2e647a@linux-foundation.org>
In-Reply-To: <20240410143020.420cafd47bf8af257b2e647a@linux-foundation.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Apr 2024 18:57:25 +0200
Message-ID: <CABgObfZiEiLbbp35gNmSGd9vNr03__Eep+D_Mj7r2o+XbF96TQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] KVM, mm: remove the .change_pte() MMU notifier and set_pte_at_notify()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nicholas Piggin <npiggin@gmail.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Sean Christopherson <seanjc@google.com>, David Hildenbrand <david@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 11:30=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri,  5 Apr 2024 07:58:11 -0400 Paolo Bonzini <pbonzini@redhat.com> wr=
ote:
> > Please review!  Also feel free to take the KVM patches through the mm
> > tree, as I don't expect any conflicts.
>
> It's mainly a KVM thing and the MM changes are small and simple.
> I'd say that the KVM tree would be a better home?

Sure! I'll queue them on my side then.

Paolo


