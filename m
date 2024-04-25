Return-Path: <linux-kernel+bounces-158326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DEB8B1E66
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6507FB27BE6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859A684FD4;
	Thu, 25 Apr 2024 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dW5sVIxC"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC1284E06
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038569; cv=none; b=RdXWt2eZJOkQ/4KRvQVYZztU8HwIMJD+3XnK4KJ0a/6/mgCsMqt2SQsGIRHJWh9vsWh7l9goeojAotuBTGVPUKE8y4enBKTbumDiPxDfspd+AZdpMmoIaEDxTWs479rU8H7J/tqBYFjJtr4ptzqfFJxT3RGpWaWc8kzTFk8wASU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038569; c=relaxed/simple;
	bh=35aW69QPE+lCEJiyyhy9K78gc5bTQ0CCX9ATNwOcmrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+sA+YPW2lWA6xI057ffHxK98vHFQbKgWrIMOp0IIlpJY9sVgB7sIh6cb7qy9JGHls6DgQSP12on1SO5oAx92EiR7BDi2fyA5114xSbsxogLa3xKrCubwokiz/ZozcVVNFVMhMw+zN5PYmn4g3wPx+3sPv5flHUQUAq/CALHujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dW5sVIxC; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-47a0f54fb13so336937137.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714038567; x=1714643367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tClP56HRC4jtLkyQNL35pL67xVeU0Fa8cWNQ8DcTkjY=;
        b=dW5sVIxC34/UKwEhLrDvZQB1q44rzx6pOA3BqtXgaM46wjukJcG4kxyvq2Sjl1ppkf
         dA09IwEC76tG8p9rG9dDPJghLMI9xvAYCB7kp9bywikyc5FaAupZltIUfkuDI+UNXWTp
         Sd2HPP2KEHbUhCSLj7gOQF07cJjoXdmpOi8yzRxX+gaSRNbsuLRdKwhWEWoxFYPv80d3
         Oy0wflZiWgAzAKHdbg6uH42KNbIZt7GGfhUBcxYLQmJgnZfrPYOMmEhBtinnhuv3wS1i
         DQDawGAzhz9PSEyQpbPo8M/L1N3oSSAvo/KskPjzUwX852oGlo+e0GZmXqHMSdUGVLvO
         vJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714038567; x=1714643367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tClP56HRC4jtLkyQNL35pL67xVeU0Fa8cWNQ8DcTkjY=;
        b=hTLqRuBv3DIj6X8a7R6hAAsZxsMSAOFhcI1NAp+HldUDHMfqDnkvVqOBHhZiSVnkAU
         HP3bFwyr8rTWZga5qx1rxw3Nsg0ANgnZ2jw2VqEzL14F7az5NF2I8v21o0nNH851xDvc
         az/MQsM3FcdyQJMYBje3P+SJF3HXrAsYKgdM3x1gTXeiWCDGgdXoRMOdsRh0jYEPNo7u
         YsZi421eqKbL/rLRF6XE41vSAH68MMXzePwd2xDeCZYX17ycKggUpkxdxDkASWkz4i+W
         H7Ubd7kc5LISd+XbH/ScC7o/4ZVTuCEz3nBa/Oe76DTPk8OQKWCq7s0/aLP7xWomUEn8
         9IgA==
X-Forwarded-Encrypted: i=1; AJvYcCWyS0DWXFSvSzMrOYwSPjo+t7dJf8JGihyifHXcjegyfq6rILTN4M+S3C15o/Zfb5Xla52480gXS76qo+aRmjSg5kFzBZuKjDiEPJgV
X-Gm-Message-State: AOJu0YxJ1ZtCo0NMQoBepfcSJhaLFyTw4jOfOQII4ROGIIjNaqpyx35x
	hjXuTJBH1FKMSodnvSWiiJjqDYTZo1DuIq+jN3L4TQbQrgGQv3QkKtriiEaanRk09gblM13Pyzp
	PQXWO7dZc4fKoYYuDN+vct2Pw24sH5wcnVI3o
X-Google-Smtp-Source: AGHT+IEC/dRlxbrk0648Rxs8czpEdv4hXYFhGbXj3jiK+CmRCTvqhbhhoKq/K5RAClwxB81VEQO2Gra7meS06C6gGrs=
X-Received: by 2002:a05:6102:11eb:b0:47b:9ca3:e03d with SMTP id
 e11-20020a05610211eb00b0047b9ca3e03dmr4935716vsg.11.1714038567115; Thu, 25
 Apr 2024 02:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412084056.1733704-1-steven.price@arm.com>
 <20240412084309.1733783-1-steven.price@arm.com> <20240412084309.1733783-2-steven.price@arm.com>
In-Reply-To: <20240412084309.1733783-2-steven.price@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Apr 2024 10:48:50 +0100
Message-ID: <CA+EHjTwDaP6qULmjEGH=Eye=vjFikr9iJHEyzzX+cr_sH57vcA@mail.gmail.com>
Subject: Re: [PATCH v2 01/43] KVM: Prepare for handling only shared mappings
 in mmu_notifier events
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Sean Christopherson <seanjc@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, 
	linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 12, 2024 at 9:43=E2=80=AFAM Steven Price <steven.price@arm.com>=
 wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Add flags to "struct kvm_gfn_range" to let notifier events target only
> shared and only private mappings, and write up the existing mmu_notifier
> events to be shared-only (private memory is never associated with a
> userspace virtual address, i.e. can't be reached via mmu_notifiers).
>
> Add two flags so that KVM can handle the three possibilities (shared,
> private, and shared+private) without needing something like a tri-state
> enum.
>
> Link: https://lore.kernel.org/all/ZJX0hk+KpQP0KUyB@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  include/linux/kvm_host.h | 2 ++
>  virt/kvm/kvm_main.c      | 7 +++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 48f31dcd318a..c7581360fd88 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -268,6 +268,8 @@ struct kvm_gfn_range {
>         gfn_t start;
>         gfn_t end;
>         union kvm_mmu_notifier_arg arg;
> +       bool only_private;
> +       bool only_shared;
>         bool may_block;
>  };
>  bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index fb49c2a60200..3486ceef6f4e 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -633,6 +633,13 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva=
_range(struct kvm *kvm,
>                          * the second or later invocation of the handler)=
.
>                          */
>                         gfn_range.arg =3D range->arg;
> +
> +                       /*
> +                        * HVA-based notifications aren't relevant to pri=
vate
> +                        * mappings as they don't have a userspace mappin=
g.
> +                        */
> +                       gfn_range.only_private =3D false;
> +                       gfn_range.only_shared =3D true;
>                         gfn_range.may_block =3D range->may_block;

I'd discussed this with Sean when he posted this earlier. Having two
booleans to encode three valid states could be confusing. In response,
Sean suggested using an enum instead:
https://lore.kernel.org/all/ZUO1Giju0GkUdF0o@google.com/

Cheers,
/fuad

>
>                         /*


> --
> 2.34.1
>

