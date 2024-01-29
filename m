Return-Path: <linux-kernel+bounces-42931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE22A8408C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B161F22F20
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60513152DF2;
	Mon, 29 Jan 2024 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONSxxKFm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429025D747
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539241; cv=none; b=X/4PhmokQSrCFIlxErJnmqbljZ56dxbzHQ4Rd3cwfnfERIXIOrah6YN1GFGmur+bnilEzhG/sOmlEsqI5kNRhCKAnwqnGXKHitq2uTJ5uE/WXs162FeE79EjRVde7KAJ7w2/ZOqJOKgI633v9OJNkH20FvbKQRoPa/iZtgo1GO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539241; c=relaxed/simple;
	bh=CuDY//Jc4pnkSyiWVEgd4CjPxKdY35Lgkz0OfKbU0jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eye4gEHLE2XYEXveE6N0lMMKuclPXQqKT8bR5KzpoluAymmWvC07Otf8vJXVy+sEe1eMAxTMx+3cWtRAClSZj/H6CgUdkqIiRInuwXXjQv7N8E0TBOgY7UrcMxHMnuEV7HcU3volwNJzyZYiB4iuCXo4RNP3+2bM91kJiE7Hr8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONSxxKFm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706539239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YLIA/zbg2FSVVYqT+Hqe9p4dbnJscEtFhgaxqRxU42A=;
	b=ONSxxKFmbH0tvCHhNBObOv3o3UPL2yhqnPdeBMtTs6po3U2F4CqN/7Gb1c7p/JQL0JQ2eU
	hIoIhTHu7nBObuBnA3z0i9wKCTPbkswW/6JfM08SXXqjBsNZxmyTUOjj8HamZowxYga9Vb
	Rq14rE/oOAhNaWAQup7AoXgdc/MtQSA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-zcTVLmm0P4C5pfiO1jMVng-1; Mon, 29 Jan 2024 09:40:36 -0500
X-MC-Unique: zcTVLmm0P4C5pfiO1jMVng-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-55f1f480fdcso288198a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:40:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706539235; x=1707144035;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLIA/zbg2FSVVYqT+Hqe9p4dbnJscEtFhgaxqRxU42A=;
        b=QpRmrrwYQ69prH6umNcMkdkG5PCSHP6cRlncWAMJXxJaQYEOK7eTMleMGd50w8GFtu
         uClHNK5GaSG/vlL58SKeZLP7DyQIzSKYTgLuMb0keB+nUKbcv24fe1ngczJf7YihWfr0
         0nDcq8a3uZVzQeq/w+SYLGFP6RjQ19xehhbkAK0ccUlHsGj8weBhHjB+6Nao8DxDWnAG
         xAjzB4lUU9Eezdkz3eESORvR9Dx+V/ruzEmlDIQKE1GwxfCf73vVNajqCwKJTXudagQV
         CmBDwdA8yJPEV+IU5XkAAK5LyuoVdg3SzW+22lCNFPlrny5LKyPG9Ig+CaNLQ/bLnMlP
         X0Fw==
X-Gm-Message-State: AOJu0YwbHLTFjvA6t57XhRe41lmKylG6vcQKcJ0BLjFQcqr1RSvR85ad
	OdVcFwsm8ZS789KCLp7ZaLYus/FWTFYWjPghixrxd6/RXpS5Jpu2yf1EMsLG6EfdDmL5J7Ggim6
	R8UDpihPud1c3/ErrxO8zp+yDRIcx7Pg3O+MxC4zftF+AQstrcCOxxJSSdyybpA==
X-Received: by 2002:a17:906:3913:b0:a35:34a7:af24 with SMTP id f19-20020a170906391300b00a3534a7af24mr4764497eje.5.1706539235327;
        Mon, 29 Jan 2024 06:40:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyqicpOXTaCl2q6hYCc0k0bjh/miwt7kM0GqLKIMQ64Cuo/31PZZ/W1AM94oVrJkxeyNaxiA==
X-Received: by 2002:a17:906:3913:b0:a35:34a7:af24 with SMTP id f19-20020a170906391300b00a3534a7af24mr4764483eje.5.1706539235077;
        Mon, 29 Jan 2024 06:40:35 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id vg14-20020a170907d30e00b00a30f3e8838bsm3963169ejc.127.2024.01.29.06.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 06:40:34 -0800 (PST)
Message-ID: <287ec316-1de5-4777-b56a-2a1b22fbe89c@redhat.com>
Date: Mon, 29 Jan 2024 15:40:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: x86/pmu: Reset perf_capabilities in vcpu to 0 if
 PDCM is disabled
Content-Language: en-US
To: Mingwei Zhang <mizhang@google.com>,
 Sean Christopherson <seanjc@google.com>, Frederick Mayle
 <fmayle@google.com>, Steven Moreland <smoreland@google.com>
Cc: Aaron Lewis <aaronlewis@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240124003858.3954822-1-mizhang@google.com>
 <20240124003858.3954822-2-mizhang@google.com> <ZbExcMMl-IAzJrfx@google.com>
 <CAAAPnDFAvJBuETUsBScX6WqSbf_j=5h_CpWwrPHwXdBxDg_LFQ@mail.gmail.com>
 <ZbGAXpFUso9JzIjo@google.com> <ZbGOK9m6UKkQ38bK@google.com>
 <ZbGUfmn-ZAe4lkiN@google.com> <ZbGn8lAj4XxiecFn@google.com>
 <ZbP7BTvdZ1-b3MmE@google.com>
 <CAL715WKMpui=+U56Qc5AiuLhUw_g-bjvtN5OmVz_hGdJmF1M5g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAL715WKMpui=+U56Qc5AiuLhUw_g-bjvtN5OmVz_hGdJmF1M5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/26/24 20:30, Mingwei Zhang wrote:
>> Hrm, I don't hate it as a stopgap.  But if we are the only people that are affected,
>> because again I'm pretty sure QEMU is fine, I would rather we just fix things in
>> our VMM and/or internal kernel.
> It is not just QEMU. crossvm is another open source VMM that suffers
> from this one.

Can you explain the symptoms in both Google's internal VMM and crosvm?

Thanks,

Paolo


