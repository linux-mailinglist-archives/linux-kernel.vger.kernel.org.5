Return-Path: <linux-kernel+bounces-167559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D1F8BAB4F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17FD286092
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05695152DE3;
	Fri,  3 May 2024 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8Yc/nbk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87519152523
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734098; cv=none; b=eFbaMaZ6XX9AtZ6pkhbGnhb8HVvIkA08JKOuGny4S1XHATcE1J24oTULaMX+5Yd1uNjIqO+V7W6yHGWEhIJW9NtplF5PnhvYtQBOAR3eVSZC4khyg7qg0rxoSvnmIbmiwMsQqh+HebVY7boZfkffnMtGBAW+QCaEuNPUou7BiFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734098; c=relaxed/simple;
	bh=UQCloiX3c/KJBlQsBJGrwnc3Ql1oJvoDpAJQP1qJtMc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D8sE59EEEbt1765P0WoeSZtxRG2qR8zxTnRnKDA5SFeVkaknJXJgOTE82Rlx93/rb4nm0s6EzXUFnPf1xn0loYKFaXA3maf+2dfaHMNF6CknmR2ZLEeFnZx4FZgu277M8fDuWeoN9R7P0Pp8JAx0w7XWSgryBgyQnjYZ65s9ahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8Yc/nbk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714734095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UQCloiX3c/KJBlQsBJGrwnc3Ql1oJvoDpAJQP1qJtMc=;
	b=L8Yc/nbkktGtystCSnEFxZzoqyrx7Kr13XaSx6wm03q4bMYZZeQARYiZM2FhixyZlo/kB7
	ueDtIkOfeqjOQ3HaXXNKe9BMLWKDSd5SQRdUup8TQhCDKDpeG71FgGEJJ2icE4KyO7kBro
	CrgtUGH96k9TjcrWHdU6N2POx+w6jUk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-8Rz_GkBhP-WUIEou-fie5w-1; Fri, 03 May 2024 07:01:34 -0400
X-MC-Unique: 8Rz_GkBhP-WUIEou-fie5w-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7906ec81e49so1233621085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 04:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714734093; x=1715338893;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQCloiX3c/KJBlQsBJGrwnc3Ql1oJvoDpAJQP1qJtMc=;
        b=StXZW1QaQN5fWYVkIEU8OzYBEoNVGex6FCWQn5ECO0/psnobw3sPZt3JU4GqjezkQP
         mwiWlMOslXDDXxa9rAZKdcRL8hBsT/r42wfo1vZw26IrQHfAqf+AzcUnwfCoiw4QDkkh
         v1KPogF/tWyRQMxxPvRDzGy5KMHdiGfTPcBOgKiuoINiF2IozPH7E6MtOaDkZMeclJ4Q
         qJn9rLyQYqKeO5c3/Pkzb4CDyXyymQzKzJHV4I2Ta9h1hwTUo7K1z2p4Hq4TpeE3/DP5
         l8tOenIH0tv7TAVu80dVed+C4mz/PT5nN76tTZvMIiwqjLEhm0rC5JdiCHHMOb18mvNK
         4HyA==
X-Forwarded-Encrypted: i=1; AJvYcCV0mrQynHzHuOtKeccuJxKBAuehA7g8myEw2mCkjINwLT9qph31u/jFBUdeYoeZ06dmMF12PUmCkUOd7Wks4KGjZLCT3PS4S0jsgNIi
X-Gm-Message-State: AOJu0Yzcgl20rXACTC15HnrGlur+KjFAzo2/nqAoJ6xuEP5zgtHVPW1n
	cxgTbp1aTEbd5I0vrhaz9tJ4reV6/UqUeQqDWbdk3dTShPFqXGuy+7ikreaYGCV+9dqL5NHx7nt
	mhiZqxy+Imr9oCBebj5KzI4uzS+pX6QV1fghQNsi4bxzVpJBKT75udrmOsTyslw==
X-Received: by 2002:a05:620a:4412:b0:78d:6377:33a6 with SMTP id v18-20020a05620a441200b0078d637733a6mr2934057qkp.66.1714734093375;
        Fri, 03 May 2024 04:01:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO6LE/GI/eMlo7xlWJ52xIvHraHShveurskORqRDPjdGmEWvDY/jklm4FvgSaNXa9nLceCgg==
X-Received: by 2002:a05:620a:4412:b0:78d:6377:33a6 with SMTP id v18-20020a05620a441200b0078d637733a6mr2934028qkp.66.1714734092998;
        Fri, 03 May 2024 04:01:32 -0700 (PDT)
Received: from rh (p200300c93f4cc600a5cdf10de606b5e2.dip0.t-ipconnect.de. [2003:c9:3f4c:c600:a5cd:f10d:e606:b5e2])
        by smtp.gmail.com with ESMTPSA id a7-20020a05620a124700b0078d667d1085sm1128144qkl.84.2024.05.03.04.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 04:01:32 -0700 (PDT)
Date: Fri, 3 May 2024 13:01:27 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>
cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>, 
    James Morse <james.morse@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 0/6] KVM: arm64: emulation for CTR_EL0
In-Reply-To: <ZjH6mgJa-ilmPu95@linux.dev>
Message-ID: <c7dad35e-1a7f-74fc-95f9-ffd9cdd53f95@redhat.com>
References: <20240426104950.7382-1-sebott@redhat.com> <ZjH6mgJa-ilmPu95@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Oliver,

On Wed, 1 May 2024, Oliver Upton wrote:
> On Fri, Apr 26, 2024 at 12:49:44PM +0200, Sebastian Ott wrote:
>> Hej folks,
>>
>> I'm looking into supporting migration between 2 Ampere Altra (Max)
>> machines (using Neoverse-N1). They are almost identical regarding
>> their feature id register state except for CTR_EL0.DIC which is set
>> on one machine but not the other.
>>
>> CTR_EL0 is currently marked as invariant and migrating a VM between
>> those 2 machines using qemu fails.
>
> I left some feedback on the series, but in addition to that would it be
> possible to augment the set_id_regs selftest to exercise the CTR_EL0
> mutability?

Yes, sure!

Thanks,
Sebastian


