Return-Path: <linux-kernel+bounces-147538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAFB8A75F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B7B1C218AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23D72375B;
	Tue, 16 Apr 2024 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOX+B0gH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8354E4502E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713300809; cv=none; b=p932k/Fg/qFYtz9VEBhX+xwCgqLgZXCzUmPmwB2wvbTXaq2lApsTz3NZ+SHoPoGkgkhp0Pb1uIx6qHjzSSosMyc6BZ6k54e5VEzG8NOCqdRADKBQQ0QouYd/ezPJjDF45RV5zwOMNwffvk6H1wKez0LIa04Sj26hvl+/+zA/jq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713300809; c=relaxed/simple;
	bh=2VUPsNGTvaCb6MINiK02YsJin39zd+0ghPTKjVLVvio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkeHzi7Uy3vLaEhCzlw2fuc6oKNcmB3koDH2SsJf0drdQbeZWIAa5z+yQl2nrHtRK3JhR/0eGgxHPJEpWV0/r9Vnmk5rgQWfkLXGKogZa+Dg2hP7jVyUYm3O/bWdkMObUWQ2Lt0dMwpkMkUm2TlyZNJ2cJ+iySiqgLgXMDTMFA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOX+B0gH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713300807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w0LXRE+t+WnC8kTK9JZPMPSEIrgpz4+A1T0TjLOgBQQ=;
	b=XOX+B0gHOR15PDMbjR8oGa3rRHx3cVQyT8aCW8332kpYjzy7zj3jmB/pJB+yZI0lJ1/n1A
	k9NMapYqis/lJdMxEZv5IwDD3JiSeRBlWtpEZCbjdUY97/fA47jtjViB1INA5/660DYqHG
	pi0fOFDyEfZrrmblF25feldM5q2U49Q=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-Rc5o4dSOODq54MkEZexmSA-1; Tue, 16 Apr 2024 16:53:25 -0400
X-MC-Unique: Rc5o4dSOODq54MkEZexmSA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d87257c610so50384731fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713300804; x=1713905604;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0LXRE+t+WnC8kTK9JZPMPSEIrgpz4+A1T0TjLOgBQQ=;
        b=vhrDD17T9UCjb+R66AAPF23s4zOx6mvrkkWUb2iCCajItmTkmj0UDO1D89obbkRpOf
         hxEM86r4aeNYkz3E0bfXDY/2ezFmA5aAXWd96IXpubrD7aYcAtOQuzC/pwhP8KtOJeLU
         q7gQvKYPzx2ET4QumdgGJXUvXdqUuVcG1DFey/q8ZAbfBZ/GtvqyZEoN1vG0SYkt79z6
         LjqkVOEray/VTnygPsQkSMFISpoNlcn6GSmQqWtpnu7Dl4DA7MEVeC88e8Ggwf7XYXpX
         7cOYOvgFyOBszOoI/YXCRFTuFFf39L63qM3zCPsiv0ytd/uzNeHlD3FPdGmrWx6JyltI
         XgiA==
X-Forwarded-Encrypted: i=1; AJvYcCXHlEfnZ83TkCO88R/mFPD7TayFpdUIL4hirlhY0TSvqvKHitF+CW6Ufwd1vnKAWHOlsLS2G0Lua21HTSuIRCoL3dMhmAHBPDCga0cF
X-Gm-Message-State: AOJu0Yx1c6ODr3+Cb/MrGOVAID0UAR1B/XE55GrgLl+Wn/VUrLhPDltn
	J07PmLlCvIXhAbDRlutHVJjhgT9K/tjK8kbswZO0adhV0AnqUUYZnmPBM+VJRyrYlqPGTU2l9oi
	Qivx6MgQd5MxmhoLChJaNkgJN6Z1dJ/Hw1/g8aXfwZXq7aGHfdaT+51X50U6m6g==
X-Received: by 2002:a2e:a545:0:b0:2d8:58b6:c10d with SMTP id e5-20020a2ea545000000b002d858b6c10dmr13647780ljn.18.1713300804422;
        Tue, 16 Apr 2024 13:53:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfasX2C9RXD1QxCmrRiZ9/PmkUafU+pu20xDYC6mW5MZk9tqlruDfwYXzlTcti9KVGP4yb7g==
X-Received: by 2002:a2e:a545:0:b0:2d8:58b6:c10d with SMTP id e5-20020a2ea545000000b002d858b6c10dmr13647771ljn.18.1713300804066;
        Tue, 16 Apr 2024 13:53:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.82.91])
        by smtp.googlemail.com with ESMTPSA id h6-20020a0564020e0600b0056fed5286b5sm6114425edh.55.2024.04.16.13.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 13:53:23 -0700 (PDT)
Message-ID: <c7091688-8af5-4e70-b2d7-6d0a7134dbbe@redhat.com>
Date: Tue, 16 Apr 2024 22:53:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM/x86: Do not clear SIPI while in SMM
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, linux-kernel@vger.kernel.org
References: <20240416204729.2541743-1-boris.ostrovsky@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240416204729.2541743-1-boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/24 22:47, Boris Ostrovsky wrote:
> When a processor is running in SMM and receives INIT message the interrupt
> is left pending until SMM is exited. On the other hand, SIPI, which
> typically follows INIT, is discarded. This presents a problem since sender
> has no way of knowing that its SIPI has been dropped, which results in
> processor failing to come up.
> 
> Keeping the SIPI pending avoids this scenario.

This is incorrect - it's yet another ugly legacy facet of x86, but we 
have to live with it.  SIPI is discarded because the code is supposed to 
retry it if needed ("INIT-SIPI-SIPI").

The sender should set a flag as early as possible in the SIPI code so 
that it's clear that it was not received; and an extra SIPI is not a 
problem, it will be ignored anyway and will not cause trouble if there's 
a race.

What is the reproducer for this?

Paolo


