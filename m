Return-Path: <linux-kernel+bounces-167562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D178BAB56
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC04C1F21E34
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5876B15217E;
	Fri,  3 May 2024 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4Z9eGLt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49478152523
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734206; cv=none; b=c4PJlP4VHGp1Ov9Ph8BzEtgjpOuA1+sx80pz5A2SOfOiE6CAMCe9UQ3Yb4zeSfDVrtaVdhEfL6ZWhmRzibpyybT2eTz+9pHz+fWnGviuk+4N4hxWy/h7yQCavi9HI3caVs9E6sq8ha4hxnxz1BBLBNc2tZuYR3JQqFAOeQb8ZV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734206; c=relaxed/simple;
	bh=U8pbEeU6q3HFr1TucM82IKlHv9be5/rhk+jTB/vMHrQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XeiWVkXARRPI4f9H7oH2feGFyb5ycCAov0pn6bDyQf40JNiVJaWz0Fe33ZrmUouVxqM7RtEYu+eJUGJrswHcM1AhsPGOHdhgAIGzyaP3nLbPJ8KHrd8DPj8MpU6WSl5ix3BhmzchCyq49IvjPKIsr1PheZ8So8qw8MP7be/jLnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4Z9eGLt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714734204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8pbEeU6q3HFr1TucM82IKlHv9be5/rhk+jTB/vMHrQ=;
	b=T4Z9eGLtvDQP4Xg2qXytevGXqNCRIgA8miw1Aim6fxfiGiiCXg6Emz9zfB0rfnYjkTge9v
	6lGx+YRhsOhiNhEpgQHzPinCTps8Vez5YaSNIxM83/DM8ZQAKCP0mbZNkZp7pvg+SbmUp4
	93bXJPO3IYfuR7mAk4McXOK6qjEGsyE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-Iz6ugXzeOjuJGL15kRTzmA-1; Fri, 03 May 2024 07:03:23 -0400
X-MC-Unique: Iz6ugXzeOjuJGL15kRTzmA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6a0b3599f2cso84080576d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 04:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714734201; x=1715339001;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8pbEeU6q3HFr1TucM82IKlHv9be5/rhk+jTB/vMHrQ=;
        b=U4rprUkees2Hjam4g7d3VxGRgfaLBd/BmvZ6VCrbDr6MbgLo9kGfIYlu+nZnz6WMBS
         NbY7uWw5ovcBbiPY2nvqIhTI35AZeUZkIRWF/s3MAcKrBEq95W0x11WSt+M0rG2Ksn6p
         MoVr2cvDG1nEvKRTwtX+FBMHxttUpazdgK5++TroaNVBU3oEH8UF5pGrSyhmjdO4DNEN
         vB6SGLO19wZFw3fthSNebDsvGbOijec9LwDw4/Wuat3qDWmf+z+myKb+N5BOPg+8hQTk
         TVSjdrtXlEA/LyQRWfCtn5CPRRYBlZBmyaAI9L/I24uMchtYIt4bjdT6XSbB9KMBCSrR
         H6+g==
X-Forwarded-Encrypted: i=1; AJvYcCWuFKLSGn13PdXLpegZx2Ze8sEdhufQOuisqQLqJt7V58SYj2Q0YUz9JKN85vuEYoln2KGRor9G0u4TuHPtrdScqhQNoE2HWZAO3gdt
X-Gm-Message-State: AOJu0Yw+Ean3JV+8vApu1pMeMitXQqEgBFOYI6tUdUpf1SUXAYu9Z4V6
	Uu1OxmphL4HaGbXosoWQ+rnG54PZ/TRR8lj1NoMhpd9xefqZ8R3qRCCZjqpvooQzzDu2KdF5LRL
	doL1bucc+ouC1upGgcCzQZZMk07PznKbg7hhn7rCgybKdQuOXpM0hoBMT2+R9vq6hgL4tVw==
X-Received: by 2002:a05:6214:20ea:b0:6a0:b507:9be2 with SMTP id 10-20020a05621420ea00b006a0b5079be2mr2172158qvk.38.1714734200734;
        Fri, 03 May 2024 04:03:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9Y4yhIMgz3JvEeyI3wePqNUPZGn7oPAlntaf8m61AG7y4+NXlBKBUHbSvQZE8Oga+ZVXwcA==
X-Received: by 2002:a05:6214:20ea:b0:6a0:b507:9be2 with SMTP id 10-20020a05621420ea00b006a0b5079be2mr2172136qvk.38.1714734200390;
        Fri, 03 May 2024 04:03:20 -0700 (PDT)
Received: from rh (p200300c93f4cc600a5cdf10de606b5e2.dip0.t-ipconnect.de. [2003:c9:3f4c:c600:a5cd:f10d:e606:b5e2])
        by smtp.gmail.com with ESMTPSA id m15-20020ad44a0f000000b006a0e0e93aa7sm1107669qvz.57.2024.05.03.04.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 04:03:20 -0700 (PDT)
Date: Fri, 3 May 2024 13:03:15 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>
cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>, 
    James Morse <james.morse@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 5/6] KVM: arm64: show writable masks for feature
 registers
In-Reply-To: <ZjHv14-GBafptt-m@linux.dev>
Message-ID: <eee2b0c4-2245-15d4-b887-122e080813e9@redhat.com>
References: <20240426104950.7382-1-sebott@redhat.com> <20240426104950.7382-6-sebott@redhat.com> <ZjHv14-GBafptt-m@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 1 May 2024, Oliver Upton wrote:

> On Fri, Apr 26, 2024 at 12:49:49PM +0200, Sebastian Ott wrote:
>> Instead of using ~0UL provide the actual writable mask for
>> non-id feature registers in the output of the
>> KVM_ARM_GET_REG_WRITABLE_MASKS ioctl.
>
> Urgh, yeah in retrospect I think we should've constrained this to the
> registers KVM considers "id regs" (the space occupied by known registers
> or otherwise RAZ).
>
>> Explicitely set the mask for CLIDR_EL1 to make sure we present
>> the same value to userspace than before.
>
> typo: explicitly
>
> Also, we know the set of mutable bits for CLIDR_EL1 as it is handled in
> set_clidr(). The mask really should match that, since the UAPI is
> documented as "allowing userspace to know what fields can be changed for
> the system register"

Done for the next revision.

Thanks,
Sebastian


