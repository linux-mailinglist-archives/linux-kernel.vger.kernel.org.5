Return-Path: <linux-kernel+bounces-69046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ABD8583BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE5E28372B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7542A135A4E;
	Fri, 16 Feb 2024 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3gPGtm+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23948135411
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103497; cv=none; b=bE0oGWHsXfn7TtEaqhVvOR+1Iw0KVpqviyl2sO+xnrM+BgKCTUcsviEJwhljYWhjCtz/V0skMUAPqnkFZI759Z4+ma3y6mMcmzoRMMx5rDnpBxHlmnsGzWGdGCRV5UvmBxYGQC93y7rBXwVqgUrOROSiAjDxFP55ejwvClnh704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103497; c=relaxed/simple;
	bh=JGNjC7+UwjY9T7LKlTiK6c8kteezBUyHZKMhIDM1Evg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5FltuZtEgdSIYXIaXZrrAuRD7Udj3wfZVxJsMdtdPihGWifiqKMQR/pZAyvjzUMfCJytLUotC0rjG5A95Vkd5zit3GUDupxEbDAS1d1rrg5td9qHpREiDfhE5RsclHtyM3IY2Rt2ctLZOKRjzf6zfWCOohHhgaVR43k8OoWEjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C3gPGtm+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708103495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIijY/r8LLfMl6D20rFmwbeRhmzXm+JMQ2A7E38ejDY=;
	b=C3gPGtm+sb2FuixF0HaBMQzSDAHE+xXXnArPIEnRRH4+KtZGvRAcXZ06b0cZi2KeWCMC7x
	djQk8AhSnSM1RuHfG8oJHGaOwxviikfRWkxa4katVb3M/M35DvhDdHR2b9QOP/xTYsTO5C
	ovrMs0HyJIC0KQmEUKt+r3E+VtuzvnA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-M2Rj73FvOBu5iOT_p3gnQg-1; Fri, 16 Feb 2024 12:11:33 -0500
X-MC-Unique: M2Rj73FvOBu5iOT_p3gnQg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a35a649c608so129559466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708103492; x=1708708292;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIijY/r8LLfMl6D20rFmwbeRhmzXm+JMQ2A7E38ejDY=;
        b=ReUiIx6APPOviY53+G/kD/4vsz5sCBYK/LNJVqFuKNdWfmIIzqql1018MMwGVM2LkP
         DPvVDRh22ZpfR4/19fHwhpp2uHulsAPaAF3PHgUf0RZ95JBEWEG6xoOnk/XmHfUE97Fh
         aOt5yLwJoKwuTVaUH52uz9jeEuDYWG60+nPF8GkZP1XDOY5sH4CqRNWkp77z6gMOacLQ
         0wH6GVHAlcDq9J8p+xo1O+XugFf3W4gwmTD+CKzQLyxgPYeogLkJY8ujW4XJKWNM3ITL
         Qxr3DsXiWRArNaiHF1uoELDDqnF+48oUB86YadcpByFGb6+5MTxCjxOzegyJlLjbziWQ
         lR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzFVF/n+jsxOhy0z5RxOufxMvEdcG8vWAOSi+Q4YyZqa+zWCA6AvYtoLd/Tug0YBjABp3Q7+dEf5BPcRDaaorK1ONTvuOTvgNxwIlt
X-Gm-Message-State: AOJu0YwkWPx/QOYllp4cPf/fiEdtF2lesoYEcxuHcoBYwmBk/TLHO54c
	LYulZyHUkAijo8g88znVazMOKI2BJoTqVxvJ6rR1nhxGZhl4z7TKuMrjvPR/O1Pgr5n2c+xVIpG
	pRkY8UkivhD4Ql//g62ZaXQbkEavnxen0+o2e8lEK6zdxfo/sY8kccnEbqDV8jQ==
X-Received: by 2002:a17:906:3bd8:b0:a3d:86c0:4689 with SMTP id v24-20020a1709063bd800b00a3d86c04689mr3695498ejf.32.1708103492550;
        Fri, 16 Feb 2024 09:11:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpvQYv23/X9db3iCL0o1v5CbF+U8MTR/LKixroenoT99EeMYj3m5SvBXid/pIob2FHWV+Y1A==
X-Received: by 2002:a17:906:3bd8:b0:a3d:86c0:4689 with SMTP id v24-20020a1709063bd800b00a3d86c04689mr3695480ejf.32.1708103492265;
        Fri, 16 Feb 2024 09:11:32 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id v22-20020a1709061dd600b00a3d8fb05c0csm141614ejh.86.2024.02.16.09.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 09:11:31 -0800 (PST)
Message-ID: <18a49662-3640-49c1-9587-db5cc9d62fbc@redhat.com>
Date: Fri, 16 Feb 2024 18:11:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: str: add {make,to}_{upper,lower}case() to
 CString
Content-Language: en-US
To: Alice Ryhl <aliceryhl@google.com>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, benno.lossin@proton.me,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 linux-kernel@vger.kernel.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
References: <20240214172505.5044-1-dakr@redhat.com>
 <20240216165320.1820346-1-aliceryhl@google.com>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240216165320.1820346-1-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/24 17:53, Alice Ryhl wrote:
>> +    pub fn make_ascii_lowercase(&mut self) {
>> +        self.0.make_ascii_lowercase();
>> +    }
> 
> It's important to note here that this doesn't remove or introduce NUL
> bytes.
> 
> pub fn make_ascii_lowercase(&mut self) {
>      // INVARIANT: This doesn't introduce or remove NUL bytes in the c
>      // string.
>      self.0.make_ascii_lowercase();
> }
> 
> Ditto for make_ascii_uppercase. (But not the to_* methods.)
> 
>> +    /// Returns a copy of this [`CString`] where each character is mapped to its
>> +    /// ASCII lower case equivalent.
>> +    ///
>> +    /// ASCII letters 'A' to 'Z' are mapped to 'a' to 'z',
>> +    /// but non-ASCII letters are unchanged.
>> +    ///
>> +    /// To lowercase the value in-place, use [`make_ascii_lowercase`].
>> +    ///
>> +    /// [`make_ascii_lowercase`]: str::make_ascii_lowercase
>> +    pub fn to_ascii_lowercase(&self) -> Result<CString, AllocError> {
>> +        let mut s = (*self).to_cstring()?;
>> +
>> +        s.make_ascii_lowercase();
>> +
>> +        return Ok(s);
>> +    }
>> +
>> +    /// Returns a copy of this [`CString`] where each character is mapped to its
>> +    /// ASCII upper case equivalent.
>> +    ///
>> +    /// ASCII letters 'a' to 'z' are mapped to 'A' to 'Z',
>> +    /// but non-ASCII letters are unchanged.
>> +    ///
>> +    /// To uppercase the value in-place, use [`make_ascii_uppercase`].
>> +    ///
>> +    /// [`make_ascii_uppercase`]: str::make_ascii_uppercase
>> +    pub fn to_ascii_uppercase(&self) -> Result<CString, AllocError> {
>> +        let mut s = (*self).to_cstring()?;
>> +
>> +        s.make_ascii_uppercase();
>> +
>> +        return Ok(s);
>> +    }
> 
> Please move these to `CStr` as well.

That would result into two copies if I actually want a CString, wouldn't it?

Also, what would be the use case? And even if someone wants to have a CStr
again, couldn't we just deref the resulting CString?

- Danilo

> 
>> +impl DerefMut for CString {
>> +    fn deref_mut(&mut self) -> &mut Self::Target {
>> +        unsafe { CStr::from_bytes_with_nul_unchecked_mut(&mut *self.buf) }
>> +    }
>> +}
> 
> Needs a safety comment.
> 
> impl DerefMut for CString {
>      fn deref_mut(&mut self) -> &mut Self::Target {
>          // SAFETY: A `CString` is always NUL-terminated and contains no
> 	// other NUL bytes.
>          unsafe { CStr::from_bytes_with_nul_unchecked_mut(&mut *self.buf) }
>      }
> }
> 
> Alice
> 


