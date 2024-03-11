Return-Path: <linux-kernel+bounces-98981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41B48781D9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68E3D28278F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7230A405C6;
	Mon, 11 Mar 2024 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZO7jkqYy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB413BBF7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168170; cv=none; b=CDRuDwcP6fmiweYZXlz+Jva1UNrOfsCktpkY/5dnSbp78pQXjJJE63uqQJMtwg0ihf/2Sx9EPcXUnJtiOdXp9fRj84FH24nD8CPXRhTynO/nhvIXFTlY0pBDsi87VT4d/ovLs5YzYhhnKQ3g7710YfowGrFE+icwkX9hfYv1wxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168170; c=relaxed/simple;
	bh=A3oQXxWzlMn1lydUi7NGqY9tMDrbtGOIZKyu+vUBslQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3OqDvLKlMn7sfO69H+RsjUYQe6LskaRaHv/p10eL5I6hb2ZF6LHjXKT8YTG+fC+1P5blddvQtvdrSkUDT7/tfBOSJrudKRIpK9riw1UdmJHK1IaRn5Hy2gkk7l4pbmlBQ6UA4oIfs1qGFaEKCUbHI5p+RIYwG+5Bo+wSjlUcHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZO7jkqYy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710168168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GxZ9fFFPslO+OLKMfpAr9nGvMTH6LktDGeSdQkQFB5o=;
	b=ZO7jkqYyrnwcjvHSy8m0wgoK4e7bietp3m2HctJG2ORmuLXl8bwYyBsYuvIlpWQRI5NIOx
	E035C0+yjef7RZ65VCJDS5l76uJf2EBGq2saLbvhuaRgc+Lxi3y2zFJdtC43zlZYpuJhl0
	1d8A9OBnRaD1+FuwPalGYEC03RMfaJk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-X4olWhURP3WndTxBPpQ2-w-1; Mon, 11 Mar 2024 10:42:46 -0400
X-MC-Unique: X4olWhURP3WndTxBPpQ2-w-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5684b963708so1108777a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 07:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710168165; x=1710772965;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxZ9fFFPslO+OLKMfpAr9nGvMTH6LktDGeSdQkQFB5o=;
        b=qT0GZbxwQMZvpFb4FXBGqe1GAIv2KV87jKdUSylH+XIcCYhQFOwN1b1WIcmCaAYmxo
         9FFWrl2MPvsUIT7c7/kdCav798rrJbP72s1S4MJJz/+CCNWs3hNwrcQXJVeBHcLjxaek
         pX2kb9UXHiheGx2MNscKg0NgjzcV2LI9F3LDmf671AX+Ajdv20lTfSSPijOlDGLzj8rO
         k9iO9kb9P+DIf8KQzAiysq8KXGNwCc+WEMECgulK5ZTJor6Pe/anE3bnvbo1KpN+uj4Q
         riNrBMVUrroLX+nLF9qZmGXaX0cpfMEUOCMjAVel7vPgvWnTW5lMHX+mpFqdUVAW1gdl
         1qFg==
X-Forwarded-Encrypted: i=1; AJvYcCWoXtvJLTNiPrITUgElvDp5xrmYGSvVDubTeMI3CLyulepN4l9KIs9lNaMxOxTZnVaMpTMJiVbxRw8EPY3hd65IY+V5y3VaqEgK/K5K
X-Gm-Message-State: AOJu0YwOKJ1wQTQ/QLFe8AtExJ6I17F+NzgeqX6R9oCrmVjIzXrWnPVI
	OECadYmdeqcjo7o/jAhEEvpihTQCKHLmjNXWU9KziGQirZQzi+NXYgl0A1wC9fVWsuNzB/+qanj
	K4dEw6CzUHzm6QZay9GOfdu1y5kvCIFPOS3yh4GRBbYK388vr9Pbz3wY2SJWvew==
X-Received: by 2002:a17:906:13c2:b0:a45:b5a2:e963 with SMTP id g2-20020a17090613c200b00a45b5a2e963mr4620445ejc.22.1710168165702;
        Mon, 11 Mar 2024 07:42:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJQ9OaaLR4hlEWqsbUP4H9nNdXzE2njeF3Z98Buf4Bsx4IRNPe7qugxKpPOfhlcA/yvZK3/Q==
X-Received: by 2002:a17:906:13c2:b0:a45:b5a2:e963 with SMTP id g2-20020a17090613c200b00a45b5a2e963mr4620432ejc.22.1710168165372;
        Mon, 11 Mar 2024 07:42:45 -0700 (PDT)
Received: from [192.168.10.81] ([151.49.77.21])
        by smtp.googlemail.com with ESMTPSA id t25-20020a1709063e5900b00a45c8c9a876sm2911741eji.88.2024.03.11.07.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 07:42:44 -0700 (PDT)
Message-ID: <4bd8b807-a52a-423e-925d-415a70a25b0b@redhat.com>
Date: Mon, 11 Mar 2024 15:42:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] KVM: x86: VMX changes for 6.9
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240308223702.1350851-1-seanjc@google.com>
 <20240308223702.1350851-8-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240308223702.1350851-8-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/8/24 23:37, Sean Christopherson wrote:
> A small series for Dongli to cleanup the passthrough MSR bitmap code, and a
> handful of one-off changes.
> 
> The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:
> 
>    Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/kvm-x86/linux.git  tags/kvm-x86-vmx-6.9
> 
> for you to fetch changes up to 259720c37d51aae21f70060ef96e1f1b08df0652:
> 
>    KVM: VMX: Combine "check" and "get" APIs for passthrough MSR lookups (2024-02-27 12:29:46 -0800)

Pulled, thanks.

Paolo


