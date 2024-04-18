Return-Path: <linux-kernel+bounces-150344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31BB8A9DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F27E2818B0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6162816ABC2;
	Thu, 18 Apr 2024 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejI4EaRZ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268CC168B11;
	Thu, 18 Apr 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452070; cv=none; b=AIS9ekBeVMWkfFLCuDj/F/TlSKPyyUfTnu+Rg7oKiCVEPXG3TAm1rumTGQVMcH5lgbJZHP6xUu/EWI6dbwlQ7Bi9oDqCF3j4T3sSdrBJnkvyzYKNPMJhwl6p1XCLigPb0HLGkwWak9LwQ/1446om5DUtoTQCs0hpreYtNKCJjMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452070; c=relaxed/simple;
	bh=OvGBkvFoWVsZGonrRvzCmb0bTHJXTs/4/G/PWLo4Ruw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=niJBsbVOcTrMd4QqiwBjj3ZXcowgEkcdIZQQ2JtOXo6+iHrVK7IM1zdnImdJw4yfMX/DUlPbjjg6QwlfhyrLMfsNwLwr0yPeJIAMDnxo+zZNe1OOCiFAViTpmW1PBzAAUcrhk5hacDbvZyYEz6lTijChvRE5raTSO0nvUB3TiAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejI4EaRZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34a32ba1962so296212f8f.2;
        Thu, 18 Apr 2024 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713452067; x=1714056867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvGBkvFoWVsZGonrRvzCmb0bTHJXTs/4/G/PWLo4Ruw=;
        b=ejI4EaRZmJTO0TmoeEAKyrXH8dJZyWVcDROO4BZKsjLAxC56M+4zvvouW5/jTaQmGz
         YBEEhxKB7pEenbsCBQCnyHtVPKygNUVARV/biy03bAFbT3FgKdZ6vxPdfCgfVigFKGqe
         shOWhz1rgTmRMuty/OPoRqcclcZEt+alS7mavnYURDSg6mOLHtQKHjsKYNpFklLykKap
         Veq+UJc4hDmMvtAZRDaL11tWyjnq9umNIqW142DcDR+Xbel2DQgkF/cn9xDqSaWrVNOm
         CfUY0Zdgce3c9qEsZkPtDMF50yrzCyFO2JOnuy0ZLeTdwIkHpPA5gKnWI8JGg7tFe0tC
         SHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452067; x=1714056867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvGBkvFoWVsZGonrRvzCmb0bTHJXTs/4/G/PWLo4Ruw=;
        b=Ls4O9r68W/DmoWBMH5IBZo/im2u+f9RWAxT3xPEyUFt0BVdbqJKO+erhc3Y4fbmawY
         vJwBuVMq5nieH1ts8pCcz+N0JVRMeBpIw3oQY6/JShAXrByix+G4KLt94InkKF85xzat
         N+q5QFzgC2LQ8f6VoUgxr1YPOL5EslnLqYy0vG3vFp8klRU4AQ7r10jg9SE7Yfm81IIS
         BWL4DXYyPZ5/l17OH6d/+W2DuHIgqvIlrQku4lpGnPCqwUDNaUkr4TNMU0gsF9tRTbTI
         nEmt5h9CK2KNpnK6NQhAHLuNwWpBXqxx8IK9h1UZROboerbsNZRTUOih+z/FFy0xo2AC
         zBkw==
X-Forwarded-Encrypted: i=1; AJvYcCWPz0AS3mJ6bekTsVKgzT/NkWQFxMjHCwEG8uQi5jJwE3s1jW2+dNNtq3vxhQNR76elBAsGTe5uN0YNUenBl9aWuEi3qgz6m+MOn4wRzVmA+hY/7S0Vaovxiy8CQW0B6gSvQ8x7Y/724g==
X-Gm-Message-State: AOJu0YybqAYmGCQX1KA64vefZ3RA9ZSXlPhIY8zozR61mACeL5G/J4bi
	DrJdRU6KYh8txfVhl09JgHD82I3FhNq7BVDa4Ta+ovpuff25cXf2GEkaaar2BN6zr67WLhQa11G
	fM5ItDkCHJzyxVg9ixYkAjFPGOi8=
X-Google-Smtp-Source: AGHT+IF1GOB+9k0yqpKSFsOcg6dnXs0PLwnWjCVD16905JB4IckCABWiGjTamMXxYATZwLvowgjCD80p4Zu9jj0+CjI=
X-Received: by 2002:a05:6000:1:b0:346:d2c0:7682 with SMTP id
 h1-20020a056000000100b00346d2c07682mr1734554wrx.30.1713452067341; Thu, 18 Apr
 2024 07:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <linux-mm@kvack.org> <20240416120635.361838-1-skseofh@gmail.com>
 <20240416120635.361838-2-skseofh@gmail.com> <Zh9l_LpThq9aFUR7@kernel.org>
In-Reply-To: <Zh9l_LpThq9aFUR7@kernel.org>
From: DaeRo Lee <skseofh@gmail.com>
Date: Thu, 18 Apr 2024 23:54:15 +0900
Message-ID: <CAATEi5kywwC2yUaYjgs+Gm=4HM5o=KHTqH1ALKJijWE_gge0=g@mail.gmail.com>
Subject: Re: [PATCH v2] memblock: add no-map alloc functions
To: Mike Rapoport <rppt@kernel.org>
Cc: robh@kernel.org, saravanak@google.com, akpm@linux-foundation.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Daero Lee <daero_le.lee@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 4=EC=9B=94 17=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 3:03, M=
ike Rapoport <rppt@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Apr 16, 2024 at 09:06:35PM +0900, skseofh@gmail.com wrote:
> > From: Daero Lee <daero_le.lee@samsung.com>
> >
> > Like reserved-memory with the 'no-map' property and only 'size' propert=
y
> > (w/o 'reg' property), there are memory regions need to be allocated in
> > memblock.memory marked with the MEMBLOCK_NOMAP flag, but should not be
> > allocated in memblock.reserved.
>
> This still does not explain why you need such regions.
>
> As Wei Yang explained, memblock does not allocate memory from
> memblock.reserved. The memblock.reserved array represents memory that is =
in
> use by firmware or by early kernel allocations and cannot be freed to pag=
e
> allocator.
Thank you for your comments. I used the wrong word.
When I use 'allocate', I mean that the region 'adds' to the memblock.reserv=
ed.

>
> If you have a region that's _NOMAP in memblock.memory and is absent in
> memblock.reserved it will not be mapped by the kernel page tables, but it
> will be considered as free memory by the core mm.
>
> Is this really what you want?
If my understanding is right, before freeing (memory && !reserved)
area, we marked the memblock.reserved regions and memblock.memory
regions with no-map flag. And when we free (memory && !reserved) area,
we skip the memblock.memory regions with no-map(see
should_skip_region). So, I think that the memory regions with no-map
flag will not be considered as free memory.

If there is anything I think is wrong, feel free to correct me.

Regards,
DaeRo Lee

