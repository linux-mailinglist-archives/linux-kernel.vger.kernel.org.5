Return-Path: <linux-kernel+bounces-56733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A1A84CE4E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D590282725
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE1580021;
	Wed,  7 Feb 2024 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITlOJxGB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41D87993B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320630; cv=none; b=YWUHZLr4d4DG3kPk57tHNbPkVAbfVnWBRCLGGrymX1U6rbYgRvtAJAtYFXMBUtLCONDPEg+/bk/g3LXd8yT8UlhzOFLecn39pIpUtTT+O+IUVm963foCJgVlpn6mFpUCQNM07FnrhpJjF7Q+UhvZCimc1MA076PDZPxdRRMzfWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320630; c=relaxed/simple;
	bh=oMhnQDhbzTftoXe32RQIwWtdO96us4xrhjolZAiZHHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9UEI54Uy0pVia0FZf/kzsjs5pl3Dqkb4YsLGL9tePtLK6pd9E6BhqVno/CB8GV3Y9RztvIgMMqWx9yFejKr/HL65GvMuI29i61gkIRIh1Vmjg+ve+uOTTxhEMAwhtPs+ETJMr6p7q7n1qsSwe07ITCKmmW+rWstjW3h/RRgtJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITlOJxGB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707320627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29GmU0WJVI81RRCnUaroCVhXsQRA2hKi8oNlrxbN5n0=;
	b=ITlOJxGBLRbh78QhLJ9b8GFVlZ+xnnmevzTIKZSTXRzcFLCeR03Osxg+//nAZxzglvUd2E
	KYDqJDw6wYqV9NbdMiEYQBb7AOLQEZ4Nz9/98Av9fRXoCytEV9mkUwVL6CbrlQdSwztiwf
	KyXi+6Q6Wbtq0pv02YFiAzDMnlIT2IA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-nqX9PV6BOPGo2jmWgcuHeQ-1; Wed, 07 Feb 2024 10:43:46 -0500
X-MC-Unique: nqX9PV6BOPGo2jmWgcuHeQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7859d428fdfso81422885a.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 07:43:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707320626; x=1707925426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29GmU0WJVI81RRCnUaroCVhXsQRA2hKi8oNlrxbN5n0=;
        b=HVuKs8HUmByaINDTVwkyNPo7uKHJNYYMXkYEYlIeep7TYbZK1D1aSauPE8FVcJBmtF
         KBWXX3JaC+vIzlbYFB77kimF/CCkA3VIe3slKKkVKEx0kHhrJqfQ86Pp+ozE0sdvCe6K
         ad+CG9RG8sSns5viBpgvhjBLo3Ntk4ifT8/RxeljQ+QJ1wyZQInGmDvEaHTS5QO7qP3P
         sqxzACNJ0gm/LWdoHfJz36+Uh3Upnj+uwrZrDkkeHi2Ybw5fMVOreorFiBdVL5BEOYk3
         rPkh0wJUGUX2l9XOc7R0aUetV4wv9ZM2BKpe0SxFh2tizjdmvAEwSfoOfUiIiJWTyikU
         sQFw==
X-Forwarded-Encrypted: i=1; AJvYcCXFPA35dR+jML23TA06g2VK2JCd++BRZbK1iz7HecY7lr8n8G5XbiAzZrJvEkYl7dqRw22IATRwV2rEIFalheFDkqtg4j1m+64ffgT2
X-Gm-Message-State: AOJu0YyWKpYPBZVCNK2u3VL5QojE1xTfiL+aPmtfONrqHG3M7NEun6J4
	+7Mfe3QrrBTK5tnR37G/pmqxgRLbrJnKBlGTpP/0qG+RTowntL9tudX0XS/vlYynG9s2YfQ8OTS
	8WgvwxSGdAIbpuYFn9qAMNXvaaQTbw7KKSBZb16i+/VWQpD/AJMjg4lzbSIVDkA==
X-Received: by 2002:a05:620a:612a:b0:785:5a45:c051 with SMTP id oq42-20020a05620a612a00b007855a45c051mr6515421qkn.10.1707320626038;
        Wed, 07 Feb 2024 07:43:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzonaLyrIAVvkXXGpzqr7TSJxC/KB7KAItXbWifbvzd/5hFgwnWuI+eWmu0G+TxPkW33FFBw==
X-Received: by 2002:a05:620a:612a:b0:785:5a45:c051 with SMTP id oq42-20020a05620a612a00b007855a45c051mr6515406qkn.10.1707320625752;
        Wed, 07 Feb 2024 07:43:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgFggNyOqEwxOXsDjt+zIkkPwv8yHX3cH+PDA0TmIe69kGLkevANZZURzsWtBSkRjifEbwcO45Bik2TVz2YxAnGDWnwEQaoZsKO+hNcSocl2F0yGwet8AwPH/pjLOpqws9Eh5ra/ikZE5Qmtb7WRLGMg9SjHxw
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id d15-20020a05620a158f00b007859d590478sm602828qkk.64.2024.02.07.07.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 07:43:44 -0800 (PST)
Message-ID: <86c33c28-77a8-46ed-9c5c-2ae0acbf5b3b@redhat.com>
Date: Wed, 7 Feb 2024 16:43:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: selftests: Fix a semaphore imbalance in the dirty
 ring logging test
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shaoqin Huang <shahuang@redhat.com>
References: <20240202231831.354848-1-seanjc@google.com>
 <170724566758.385340.17150738546447592707.b4-ty@google.com>
 <6fdbeed0-980e-4371-a448-0c215c4bc48e@redhat.com>
 <ZcOXSZ2OPL5WCcRM@google.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <ZcOXSZ2OPL5WCcRM@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/7/24 15:44, Sean Christopherson wrote:
> On Wed, Feb 07, 2024, Eric Auger wrote:
>> Hi Sean,
>>
>> On 2/6/24 22:36, Sean Christopherson wrote:
>>> On Fri, 02 Feb 2024 15:18:31 -0800, Sean Christopherson wrote:
>>>> When finishing the final iteration of dirty_log_test testcase, set
>>>> host_quit _before_ the final "continue" so that the vCPU worker doesn't
>>>> run an extra iteration, and delete the hack-a-fix of an extra "continue"
>>>> from the dirty ring testcase.  This fixes a bug where the extra post to
>>>> sem_vcpu_cont may not be consumed, which results in failures in subsequent
>>>> runs of the testcases.  The bug likely was missed during development as
>>>> x86 supports only a single "guest mode", i.e. there aren't any subsequent
>>>> testcases after the dirty ring test, because for_each_guest_mode() only
>>>> runs a single iteration.
>>>>
>>>> [...]
>>>
>>> Applied to kvm-x86 selftests, thanks!
>> Do you plan to send this branch to Paolo for v6.8?
> 
> That wasn't my initial plan, but looking at what's in there, the only thing that
> isn't a fix is Andrew's series to remove redundant newlines.  So yeah, I'll send
> this along for 6.8.
> 

OK. Many thanks!

Eric


