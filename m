Return-Path: <linux-kernel+bounces-98970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964CE8781BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB7028704A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E8541C89;
	Mon, 11 Mar 2024 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7pNRqjR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE683FE52
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167754; cv=none; b=n1HhFQKGFYPQ41ISsxdOX5EL/nWY61aU6/sVr/w05++mVtlJT0wmDjg0qIzqSjudnr7PZysgwP+66OlO//+fgG5xVZQFFr8E3FjpbA/GFV8vkZp/emTBx+t5HLKAPjrkSfM1TT6WIjrVnoNlUblH8euXWfjT5YI48S5mF3vELmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167754; c=relaxed/simple;
	bh=lkoiJTksbCZErFzuqOyx/HHT4scED6edeNDIRRJqW3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkTPqa8dVEXwiAxuTBSCZrzsMnpcl0Wz5uv6DArN+sWwLac+h2rRmS37qwLaZbeVB+HBdqxJPnO7gxPfgrDkhEbm8e7YfzeTPWYOBQlVA7aOtqS1e7BPOfVnvjX6UDU3kZqQp2Q2+bqMxyld01ZEh+oUfTe7Vf2akYWDk6O/xVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d7pNRqjR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710167751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gvu+1wcrc5tjvaQFe51dGXMMu6HyGWiHl6X3cU+orKo=;
	b=d7pNRqjRUMNNscTFDwzhEFdO+lkxC//dgJquB/ZlzFGQEtp04EQL+WpG6cLN/P+eEgT4cb
	bIyfuJ1kk9raR4S6tRwR8Wumz5SWJ2a5CnAWbvTd5er2iqNtu/2wYIitBiRxeFqnYXzbfz
	R7r3DchYWOFC5LNFdnSwVhk+r8PfQuk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-d78FgL9bP1uyNFjLlRWnFA-1; Mon, 11 Mar 2024 10:35:49 -0400
X-MC-Unique: d78FgL9bP1uyNFjLlRWnFA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-56849d0ec7cso1194468a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 07:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710167748; x=1710772548;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvu+1wcrc5tjvaQFe51dGXMMu6HyGWiHl6X3cU+orKo=;
        b=dq8qGhgSDFzEOXedsw2Rb729p6Am/W9FInPflDxRunacGbYq4VZXVhel3cuY4inWUu
         TBSR3HXtivWr8q1R82d54ssA+G6xdIEO0UsgNkvW2WIMu/steezDrj7eLS3ootALJv7Q
         frgy5YVqAws1lqU/wFlvWX67+20U68M0bBYL16+nq9KEyG8WpRRWVQhjfcjw6w6Lwqxw
         //3gnMhf0fj0NYh3yByAqRYL2HjI/FmHZ8btV7j2DN2AS8L5gv+FLms64VA7Xv3VhhxG
         ZaKmUDiMEMciVb0iabw5gyPnfi+FlgpC5q/4kSuJwzFYheLDZyOyzBvpLYkfU0VAw1IG
         WNrw==
X-Forwarded-Encrypted: i=1; AJvYcCX0mD+d1V0M9op9CjXd9zCU9Ad/SPUnZnEdFU2tbhgkbEe16ZRdld6/20yp5PK/Xf/rUGeAnVIxYdmrZuHvJIpeS9Bssr27gY+2rsGD
X-Gm-Message-State: AOJu0YzBXgvBJB0HDO6f/fH2lcbNw8ZD0bVn5CpV5lWGRezwqOGqsGJe
	GGvDdQQ00TrqYq0Rqb4o9GkzTujcJ96Ax0DhP+FBc2cuhH+ZLXY9ExHeN2y1UEUqW0Ua8DXvWvn
	QEMfla4HXuFfgaDbaXTsf8IJfXr1NGzWEmLe/LIo5LIYsObLOaLm4eLLtKchGOwZuYVFSZg==
X-Received: by 2002:a50:aad8:0:b0:566:b09e:80c4 with SMTP id r24-20020a50aad8000000b00566b09e80c4mr4311264edc.19.1710167747872;
        Mon, 11 Mar 2024 07:35:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5GJzW1MwAKdVPFXr+4oz+4aIry982Z+VpDEim0ijtLOpgIU8EqBwrLd87kFd8GONzruz6pg==
X-Received: by 2002:a50:aad8:0:b0:566:b09e:80c4 with SMTP id r24-20020a50aad8000000b00566b09e80c4mr4311249edc.19.1710167747563;
        Mon, 11 Mar 2024 07:35:47 -0700 (PDT)
Received: from [192.168.10.81] ([151.49.77.21])
        by smtp.googlemail.com with ESMTPSA id s23-20020aa7cb17000000b005676dc74568sm2965882edt.92.2024.03.11.07.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 07:35:46 -0700 (PDT)
Message-ID: <5e302bfa-19a8-4849-82d0-0adada3e8041@redhat.com>
Date: Mon, 11 Mar 2024 15:35:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] KVM: x86: Selftests changes for 6.9
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240308223702.1350851-1-seanjc@google.com>
 <20240308223702.1350851-7-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240308223702.1350851-7-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/8/24 23:36, Sean Christopherson wrote:
> Add SEV(-ES) smoke tests, and start building out infrastructure to utilize the
> "core" selftests harness and TAP.  In addition to provide TAP output, using the
> infrastructure reduces boilerplate code and allows running all testscases in a
> test, even if a previous testcase fails (compared with today, where a testcase
> failure is terminal for the entire test).

Hmm, now I remember why I would have liked to include the AMD SEV 
changes in 6.9 --- because they get rid of the "subtype" case in selftests.

It's not a huge deal, it's just a nicer API, and anyway I'm not going to 
ask you to rebase on top of my changes; and you couldn't have known that 
when we talked about it last Wednesday, since the patches are for the 
moment closely guarded on my hard drive.

But it may still be a good reason to sneak those as well in the second 
week of the 6.9 merge window, though I'm not going to make a fuss if you 
disagree.

Paolo


