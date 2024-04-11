Return-Path: <linux-kernel+bounces-140494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F7C8A156C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36911C2129B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787DE14C5B8;
	Thu, 11 Apr 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIJkG7pQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7328FD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712841750; cv=none; b=pZV/0RfUAi2sdfhUyl9drL5LS24k9mM7zUiGDNsnTuHNeUeo9rRROu5uLpQTA6F7tqcknlbIQm/RAHE1UbCA+5ScH1CUYkqxO/rGC6GJzxY5OQx/1qh49UwA291chAjmR5fpKoQY/vAB7ycsC+14eVNp3LIbDVNJtCXn5pMZi+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712841750; c=relaxed/simple;
	bh=U9U4DrMa8C0Tg6a+6toTBCCdpB+9LfQnli9OY5KSfHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdO2OpEUmQsDE9qDQ8Wr5jUiLf9PE97WzQTr2k8BoJm8sEs0SW9XvXv7eJ4RwugODlc9gt9h+5fgYcnAZI6B2Bl0vOrlF4vC6drroKiZehiIJIowZD59gK3eusnxdlHBsan1ceJs3Yrl34Ut19csAmpm0fK016+A/Vqbn26Bw30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIJkG7pQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712841748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U9U4DrMa8C0Tg6a+6toTBCCdpB+9LfQnli9OY5KSfHk=;
	b=dIJkG7pQGejLEmPwY+1h6hUfOKRk0dGuM0pnd3oqD1WBmI/K/zO0ImY07Z9WeZyfF//gYB
	n93WY8jG32M9uEgSle+JsN7yO5svdy5SEX7l/x61iyyodoPc1bTmcMdMPy5oCp3kjznAYc
	DdSwyvtALmCY93zVEABxnSccIqJBGGM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-1EqWjZoANW6xeQZsNCO2nw-1; Thu, 11 Apr 2024 09:22:26 -0400
X-MC-Unique: 1EqWjZoANW6xeQZsNCO2nw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-417ee376987so38605e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712841745; x=1713446545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9U4DrMa8C0Tg6a+6toTBCCdpB+9LfQnli9OY5KSfHk=;
        b=Jk76S5kZXGtFHRHCujLxw3Po5ETE2SY7DeqhHVzMOhc3NtEm5zf4YR17sDOQZwJQtt
         NHlWY7RBrf05yYiGDLtAf2eQjfCkSUh8X2+/398cSEd/Xk6BCeGdeQLFhXBeyHQ1GG3O
         EoQ6PyuKmeLo5Qb7/Ermnph0JYlE2NDFXkN1JukHzXSKsQSYrd5ztg39Ee0YuyyECK3I
         jbOasOlhHQMkGgUkedrIBM1R7Y2q1LSiV7YiKUYe+3Ecn46Axve18mttaPPii3eh5jzo
         mYcgegRdVxz2/9zZjuaMaYIJOLkUeD/eEjvyNhayh0xhL+AxZrn3Bss8JNCWQWbxLgYg
         2YGg==
X-Forwarded-Encrypted: i=1; AJvYcCUCAv4dHHlAWn/W4eNiqWVZK/YxnYLLqTt52i8oUccSIjHmNNJauJpMmRVl5AtvBHTugCo1FfvvSBon10tiV86U4MJ5rXTMuAenoalr
X-Gm-Message-State: AOJu0YxnNTxV0HtAhbxEJA/dsqkyIKCEkiRzQ1TXHfwt3fE2XzVUxQag
	dS3TicyHZlBRNxOYSytVdTFqdC+MYKOmcSchjxKAqENd3sB6kZURB019sgJJRajSW+BT/z4Q72H
	YpQYJVykAm9UqhNK2/HxMAOy883ZwCWM3esNZ7EG0sHFWxGAW/UpmbMySV7p2dPAB4kPMRJQ1Hl
	sHaxnLb5+7XhDFVwx0ph/B8qWEGQbsAiiySd0m
X-Received: by 2002:a05:600c:3c89:b0:414:9676:4573 with SMTP id bg9-20020a05600c3c8900b0041496764573mr3428924wmb.36.1712841745444;
        Thu, 11 Apr 2024 06:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOqpae7e7YHtDrPKdTbcCevuUXTBRFS+swIe7b3hMN/ct9nTKRbjdAZ5D1U4nS1cq29M1FDblW8ISPSai+0+w=
X-Received: by 2002:a05:600c:3c89:b0:414:9676:4573 with SMTP id
 bg9-20020a05600c3c8900b0041496764573mr3428899wmb.36.1712841745063; Thu, 11
 Apr 2024 06:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411072445.522731-1-alexandre.chartre@oracle.com>
 <7f1faa48-6252-4409-aefc-2ed2f38fb1c3@citrix.com> <caa51938-c587-4403-a9cd-16e8b585bc13@oracle.com>
In-Reply-To: <caa51938-c587-4403-a9cd-16e8b585bc13@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Apr 2024 15:22:12 +0200
Message-ID: <CABgObfai1TCs6pNAP4i0x99qAjXTczJ4uLHiivNV7QGoah1pVg@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Set BHI_NO in guest when host is not affected
 by BHI
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, daniel.sneddon@linux.intel.com, 
	pawan.kumar.gupta@linux.intel.com, tglx@linutronix.de, konrad.wilk@oracle.com, 
	peterz@infradead.org, gregkh@linuxfoundation.org, seanjc@google.com, 
	dave.hansen@linux.intel.com, nik.borisov@suse.com, kpsingh@kernel.org, 
	longman@redhat.com, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:34=E2=80=AFAM Alexandre Chartre
<alexandre.chartre@oracle.com> wrote:
>
> So you mean we can't set ARCH_CAP_BHI_NO for the guest because we don't k=
now
> if the guest will run the (other) existing mitigations which are believed=
 to
> suffice to mitigate BHI?
>
> The problem is that we can end up with a guest running extra BHI mitigati=
ons
> while this is not needed. Could we inform the guest that eIBRS is not ava=
ilable
> on the system so a Linux guest doesn't run with extra BHI mitigations?

The (Linux or otherwise) guest will make its own determinations as to
whether BHI mitigations are necessary. If the guest uses eIBRS, it
will run with mitigations. If you hide bit 1 of
MSR_IA32_ARCH_CAPABILITIES from the guest, it may decide to disable
it. But if the guest decides to use eIBRS, I think it should use
mitigations even if the host doesn't.

It's a different story if the host isn't susceptible altogether. The
ARCH_CAP_BHI_NO bit *can* be set if the processor doesn't have the bug
at all, which would be true if cpu_matches(cpu_vuln_whitelist,
NO_BHI). I would apply a patch to do that.

Paolo


