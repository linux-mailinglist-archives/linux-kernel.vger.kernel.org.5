Return-Path: <linux-kernel+bounces-166498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A79928B9B79
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676D42823F4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B754B84A4C;
	Thu,  2 May 2024 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXyBfWXY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905493E47E
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655936; cv=none; b=JRWL8rLjXd9K0KIGnFvozhJ1ORZm3qWN3CIp48DK2ZWn1p0R4tIk4LfniHn6jqYCmaH2dMk/eLQnwVVQ1dFF/GB0A2IUAhZXIubinidogBenIr7BlRaDHBfgyfq92PLmjLx4wFWaE/OSlde8k+gxwxeRuXubZyT+vQuim4bPuW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655936; c=relaxed/simple;
	bh=DMVru4iHMRJwA3MA08IKQpkHAhcOmFJx20VroT9z1cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WdAJD52m9HIY2J+YX+BBvAiqp9cX9mX5j2Jt6pf+rB264Wop/Up7q0PKWRKHH+Ty1Dc0WRX4jhyGeOhUWhaE5qWvrYEbpMlip7n9JNlPEYvSR0tI8d10mIfoIPJfwWFIwrCOfpz5GUZpTh73ZHYkYwfKbnVpQjbvjUKqXf3sGzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXyBfWXY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714655934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WAenIvJSBiSJOxHk0lkzJ2HHgC5rMnP/wGaQjLUg+90=;
	b=BXyBfWXYqh4+zPDNK2Wk2EcRS7wT6jxOvpc5u1VZT3KD02+HB6efABLy/zdgFQThFjEGbK
	M8GLsKUJwV2RZP3anQKxqKKEbEp4QhLmJ8nzsrTN5FiPdpweseZTcoARJt1gBpw1stsiL4
	sVUkApMXqizBMHe8uPIlkYmkcKPRPF8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-Kck9DbyJMuCvFqIKjrQ4wQ-1; Thu, 02 May 2024 09:18:53 -0400
X-MC-Unique: Kck9DbyJMuCvFqIKjrQ4wQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a5564a2e3a5so569434366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 06:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714655932; x=1715260732;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WAenIvJSBiSJOxHk0lkzJ2HHgC5rMnP/wGaQjLUg+90=;
        b=fh58T+INvH4ozDkLDdQXrC3vav0LjRvOFZpABiXpLa+ILdvYvq+n9FOWPzIpS6smev
         6cfOp641LJlgdW0W+LBLby312nwBWpFECbMr3fyha79ohSfv67uWp9plccVwFd3Bl0k0
         DJq9BGwCTGGka9+L+SxROyM3L1+mY1mDCHN44sAdA4c70NSQOMgpl+nOiAXfjKhXbPJd
         5BVLXi1og+3azYyR/ErFF4KVLZsqum69Kivl02vEuNShXLD9jA1oqqILgN+dyEt0ij3V
         bQQ6K7c9eyyr0JUKbTBr64KelzPqccqYQ05MYQSf7Mk9TWgblDFohq8KZ/nNK8vcGESt
         4XEw==
X-Forwarded-Encrypted: i=1; AJvYcCWpYtW+ELWjEdIirpAhTQaA/EhOQkZuh3/gK1rP8i3bQUODFGs1/2hijswfoMVw6rBh2+zgDdWY0NlKMk291HO2QeF2PiwerbeSdxnk
X-Gm-Message-State: AOJu0Yx6mEwO3Vwoj14KS5XjjW1Ifyk4RbF9qtQDH9it+GAIGoO0WOJ7
	l5+du/uKeQqdR5G3ruhVtqYFwBimYInkuxWSVqo3J8XvzAdtFR8LgBt1NHUKZxuKOc+tnJHIBoz
	6r36IJthAMaWM66Xo/UqwziYEAIH2hKubw9SlAUEaXQOLRk/expEi0a9hZR8duyTcgU+cQA==
X-Received: by 2002:a17:906:a299:b0:a52:6b12:3078 with SMTP id i25-20020a170906a29900b00a526b123078mr3658944ejz.55.1714655932119;
        Thu, 02 May 2024 06:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFXZ0krbL1GKDnIwrF8YVx2p8EkgadJYoIBwVa1w9Sk98/seVuLSay0MT9Iphw5PkgQakBVg==
X-Received: by 2002:a17:906:a299:b0:a52:6b12:3078 with SMTP id i25-20020a170906a29900b00a526b123078mr3658911ejz.55.1714655931654;
        Thu, 02 May 2024 06:18:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71e:bf00:eba1:3ab9:ab0f:d676? (p200300cbc71ebf00eba13ab9ab0fd676.dip0.t-ipconnect.de. [2003:cb:c71e:bf00:eba1:3ab9:ab0f:d676])
        by smtp.gmail.com with ESMTPSA id br25-20020a170906d15900b00a57bf8305efsm550485ejb.152.2024.05.02.06.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 06:18:50 -0700 (PDT)
Message-ID: <b3d29640-9a38-4d4e-a914-764832b219f4@redhat.com>
Date: Thu, 2 May 2024 15:18:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 1/5] ring-buffer: Allocate sub-buffers with __GFP_COMP
To: Vincent Donnefort <vdonnefort@google.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com,
 rdunlap@infradead.org, rppt@kernel.org
References: <20240430111354.637356-1-vdonnefort@google.com>
 <20240430111354.637356-2-vdonnefort@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240430111354.637356-2-vdonnefort@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.04.24 13:13, Vincent Donnefort wrote:
> In preparation for the ring-buffer memory mapping, allocate compound
> pages for the ring-buffer sub-buffers to enable us to map them to
> user-space with vm_insert_pages().
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


