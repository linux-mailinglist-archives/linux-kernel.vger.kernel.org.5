Return-Path: <linux-kernel+bounces-78612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3FC8615DC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3351C23890
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED7C10A3E;
	Fri, 23 Feb 2024 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEUFeLJy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5048E823D8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702333; cv=none; b=JkvqQV/4MIPmnP8sFzZRO1dfVmkdVIlwkBeBXz++NjTarFfb1z4DuPP+u3Tcw5N7ZvCj65fFWHs32inFHjUqBBdIghc1lqQxvO0cSfQFvmXskBspkBTF46r+X370S5AkIiQGWHprUeeePbWt8rC7Gqk01ZanxzadBGkqDXgD/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702333; c=relaxed/simple;
	bh=ltXfiFuoTEtZlQ375zaRTODYeS+HobqFtlM+RXnHddQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxXeToVVJezv1fRS359Tivd/8kPyB/R/unbNpvZt9DmNhx3EmoL9zfnlBd84q9/8E8pEa6fEXXNwlU/ZHhg574ZvdEiFCEPTB3e5+eE48hT2GDJrhLIhl9xGTlMic1I8qBr1xjyceoer/+DjN0ZqfPbUW1a10OcqtSDIbk+3L6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEUFeLJy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708702330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ltXfiFuoTEtZlQ375zaRTODYeS+HobqFtlM+RXnHddQ=;
	b=fEUFeLJy7wWCGpsIiw44ytq1MxrQn95Q8qS+X9SfrvuWRe09YCVAmK+wOeulUp2jRM+VmD
	wO9W+Hh+Y+4yDpJgbRlzyDVDDJ2HME5w+r4iCliYoMzQjCgnIw6RD3aC1iEKITUMz0lF9A
	5klySqb5NbQZTkujA+CmSs52nZDzW4E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-nSogOnByOHmtDwumvMgsMA-1; Fri, 23 Feb 2024 10:32:08 -0500
X-MC-Unique: nSogOnByOHmtDwumvMgsMA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d256ca4c8so660116f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 07:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708702327; x=1709307127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltXfiFuoTEtZlQ375zaRTODYeS+HobqFtlM+RXnHddQ=;
        b=pseUVZeoPQ0PlLreh3jnWPuXsSwcIAtbUJ23aE391gUYVr3qtGAjYkvNLO2cRc5MYb
         m2AtfcNsX0d1xXRyIfke5E0qKvyjq74kNO3qXBJaVncQr/dqpXKeDCeeNUIeugVOc8L2
         sQ4ccnxbb9E1NuzDrXnEB75P4EagAWKros85brJ72g/lbUrmFZmQF3V9Yv1fqUJHsZlQ
         XVqgEeNmD6xoWFeRuLtgspLwnaMz8KBbcVgm+P1I3JyL9M3xKzGdo409pR4elW/vt8Hu
         1zUKF8vZjI5QktdGIMknqRWaFoWUFoLhBTghef3fpOqZNdUVYVzG4p6b7POlnFZuLXE0
         mWZA==
X-Forwarded-Encrypted: i=1; AJvYcCVoF/h/QQfINPn6CjG4sZ4/od6R5cjx6EVPeJnsnSbIHfID9iUCNFhVSzRmQU29KgWoQ9qtCMseJzTsocSla9SAx7akmYHcAM+2R0lm
X-Gm-Message-State: AOJu0YyTrWVJU7uWeUhZXbe1xih89zYiX7X7bMGCGW8Cy8DEBx5Yx3VQ
	BFhcCfunx7fBT4xINh3fi/7HtGWgX0E36zJA0Aj5MeY9/ce2uRspDs3By3CkzeyR19K3tTlozPC
	m/cASCv8dV374lCLxHDCCrbbfdrp4DY1eK1uHKXF884+RxFXsEu2+RWlhBOTPzwryuv/a5LsE8+
	O00Sk4p3SpgNYLfJcj/g6SQ2NZnxUWhgJ9cBrb
X-Received: by 2002:adf:e511:0:b0:33d:5ae5:f356 with SMTP id j17-20020adfe511000000b0033d5ae5f356mr94668wrm.20.1708702327609;
        Fri, 23 Feb 2024 07:32:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLm2G66Tw4sgodVUIb9Jzv+TjNHaof3FgriahBQfesSvJsXof4hqEVZ82kEIdVUXv/1jq4kYYkRea+6qJNwbM=
X-Received: by 2002:adf:e511:0:b0:33d:5ae5:f356 with SMTP id
 j17-20020adfe511000000b0033d5ae5f356mr94647wrm.20.1708702327323; Fri, 23 Feb
 2024 07:32:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216155941.2029458-1-oliver.upton@linux.dev>
In-Reply-To: <20240216155941.2029458-1-oliver.upton@linux.dev>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 23 Feb 2024 16:31:55 +0100
Message-ID: <CABgObfYZBnTjXh4TqH77HjO3zTMRfekaorTUVqQoFOMPJLjJTg@mail.gmail.com>
Subject: Re: [PATCH] KVM: Get rid of return value from kvm_arch_create_vm_debugfs()
To: Oliver Upton <oliver.upton@linux.dev>
Cc: kvm@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, 
	Sean Christopherson <seanjc@google.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	Marc Zyngier <maz@kernel.org>, Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 5:00=E2=80=AFPM Oliver Upton <oliver.upton@linux.de=
v> wrote:
>
> The general expectation with debugfs is that any initialization failure
> is nonfatal. Nevertheless, kvm_arch_create_vm_debugfs() allows
> implementations to return an error and kvm_create_vm_debugfs() allows
> that to fail VM creation.
>
> Change to a void return to discourage architectures from making debugfs
> failures fatal for the VM. Seems like everyone already had the right
> idea, as all implementations already return 0 unconditionally.
>
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Feel free to place it in kvm-arm.

Paolo


