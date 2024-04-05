Return-Path: <linux-kernel+bounces-132699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5566B8998FB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF9F2819A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5664F145FE4;
	Fri,  5 Apr 2024 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/FI1WnW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3676611E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307993; cv=none; b=ahZyH/9qz0cdDxw56OB4wHFknEXAEZX6XC7VBoDtJIe2OBpgzSKMDHBRqwUtXjuptpzD8uwn3kyjjrneC/7n3OzhNsQYT1+NW+L+a99gu+YtupV7eZ43Y/vb0BNDEQU36JLBrAe5TmUQtUCpHWIc2ouk8BA7A8YXbXQftlSLrcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307993; c=relaxed/simple;
	bh=OyyGdzehw2fZZ0tV7w05sTWY86GxZwpwuw8P/8pI+Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G47tIJx7MyQaJDzi4eTbCnqUv2Wn0wbAz268dRPYobcmdavNTrP+2ImK2jcmTKIF2dI6XtsfoYcZ7YBcAa9A5PYqRj0caBZAH/8AuF854uYj6l62kdeHqkojLCHFn4WBkYL2R05mXaYStPGl7rkD69juEqKq81Tm3EolVemrNpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V/FI1WnW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712307990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xvcvhRh6MByDfdF0RnRtqNmfRJilUMG9FsE390NV9Ak=;
	b=V/FI1WnW9yvvJCWdkWF25V6OqGAVA1kujKms/u9L0+StR0Zuz1C29bQ0+RzCDLGD6exUsg
	9ONsp9PtF8mP+wxW4wGS0Y97EzScU07P3169l+/o62uyVI3xx59m+6DXPx4HJXd5Mkd046
	quvXb5mHO65JcBH++QaIh2XCwbkkPWw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-G4L8MNq8PkqtqJSQXz-ABQ-1; Fri, 05 Apr 2024 05:06:29 -0400
X-MC-Unique: G4L8MNq8PkqtqJSQXz-ABQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4156e6f39c6so9173715e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 02:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712307988; x=1712912788;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xvcvhRh6MByDfdF0RnRtqNmfRJilUMG9FsE390NV9Ak=;
        b=gzGf5sXVxVCiCXipTyZTDUTZPGYUORlYzEEjeKixJZmttXpXk7A21p975MRphIiFXs
         f5WMKk3TB/xvz9vHml0tNoDS8uRJsPv8Za3yqRtplmgBYXG3O2SGk9QtmGVmL66WI+N0
         DSslvmsuHsvb+3V3+Ts5Kws2qXVzpsi0dIogyuIvaVWTxly33Qui/e+Ln+hR2sfEBfza
         phIf8GfHkxSbZLmvcH+nxioPyPfonT7vYV/BvEAFOs+kAs6co9B2ex3D6B7t3h4p3U6G
         tE2GqQ82Qa444I5v+VBvp6mHMHLI0eeOWFMtqzvr05FW+/ugA93ltLOjZyegV1t/n6m4
         NSRw==
X-Forwarded-Encrypted: i=1; AJvYcCXPPsnJNc6Pev/XeE94Vfj2PF6iYrxtHcvK+rpwrk2DJex6J4bK58d4hOHRwO7/jb9A6dWNNK2XZeZ9vHs0vfN0XcPztUF+1q4FXdh/
X-Gm-Message-State: AOJu0YxUucAiX3wDJJFAylYffqZIhZZAhISXVviRBdoD5A8/aCCGZSyX
	QkzwWWiu8HKBWDS7cgxyuokrPg9/z0CrFYZKEOFYtRh9MOOWdbez8GWT9NzuASEsJkOtvTlpCd7
	iNSidAYOmvp4WAArQy7AVfbUW8yMPtsEGBzbqLW+p5lIDCXrtQRcCeN1ciOYHhw==
X-Received: by 2002:a05:600c:470c:b0:415:511c:f801 with SMTP id v12-20020a05600c470c00b00415511cf801mr650423wmo.34.1712307987883;
        Fri, 05 Apr 2024 02:06:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbrx4/ssTnIv4ztnQyJk8eIHAjmkCWgQup3YOTpp0Vl95g5n2VZZ0VrVXK6EgqCDXCWw7N+A==
X-Received: by 2002:a05:600c:470c:b0:415:511c:f801 with SMTP id v12-20020a05600c470c00b00415511cf801mr650402wmo.34.1712307987477;
        Fri, 05 Apr 2024 02:06:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1? (p200300cbc74b5500e1f8a3108fa34ec1.dip0.t-ipconnect.de. [2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c488a00b004161ea7ed6dsm5549625wmp.38.2024.04.05.02.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 02:06:27 -0700 (PDT)
Message-ID: <15080b4f-ac9f-4f5f-9a27-d1773d015fdc@redhat.com>
Date: Fri, 5 Apr 2024 11:06:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/14] mm/ksm: remove get_ksm_page and related info
To: alexs@kernel.org, Matthew Wilcox <willy@infradead.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Izik Eidus <izik.eidus@ravellosystems.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ryncsn@gmail.com
Cc: Hugh Dickins <hughd@google.com>, Chris Wright <chrisw@sous-sol.org>
References: <20240325124904.398913-1-alexs@kernel.org>
 <20240325124904.398913-12-alexs@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240325124904.398913-12-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.03.24 13:48, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> Now since all caller are changed to ksm_get_folio, let's sync up the
> related usages with ksm_get_folio, and remove get_ksm_page.
> 
> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Chris Wright <chrisw@sous-sol.org>
> ---

Move that after current #12, and then simply squash current 8,9,10,12

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


