Return-Path: <linux-kernel+bounces-140551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BA38A1619
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28215B28A93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF23F14EC6B;
	Thu, 11 Apr 2024 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bWsAx8hE"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876F614E2D4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842782; cv=none; b=TVedcE7jEpHxHwctXf1Sv/YdvQ+FbpCrZC67uNzZ1h/MtPTelec+DlDZNN9K6EuIjyepTsuVblcABaITebJTJ5sU+76t+CUZVwel6r8yEbQILSwH/aaR1ZP1KtUK/KGoh6/csxZeMKFxkHg0nAzX6hdt88Cvw2KmxPHPSCSeglE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842782; c=relaxed/simple;
	bh=Q4lqBLJ/e15bzi65GJXnnE58jRGWZqvbLdUwj7++o/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ats03DSsUOrUPUpRGUoenoyHjb5EdEVE00mV3HPMj55gqPiVKZyQr695CodXLxXHoRxB9BwnFU9laN9LeYtVzyEPWIWfUbXSzhsIUmzeii89251ZS1hMezl2L0f5FbLJz6jeD+6tPM43NFzViHoeGQXW17CcoZVH4VtGEPkzz+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bWsAx8hE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46a7208eedso1121340566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712842777; x=1713447577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nw5oWo8SbG/JjbLUd+pDYICRWpYvqotAi1XzjeWc850=;
        b=bWsAx8hEMGpeM1lyQr0o//O4d3QluxZexMku39HXmCJiNaikY+UukL7dtx2nt+e/5r
         r/um/s/W8Ekxq+nOXIlL0UW2pgNxJiiRciz/iQqbXfMSTUPonM8TYzTfPWR+MR2r+4Hu
         gnNMrEjK4juKqdD8PPPJrH/mrCz4WQwjfuPXs64O1PtpQaxbjfCzt9BIOHliaB4L9qL4
         dr7e+EwD7gj/Qr3DQG/qAL1gp803UcmqRSdU/PMC1Ev/T0O56I0wu1ED+ACdxr6ehSHZ
         cygw/3K30ERwvhpqVvon4xX+b870RThzZZSI6ThBdchHp/E0hR31FJQITj9tM2pGZ4o+
         Fd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842777; x=1713447577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nw5oWo8SbG/JjbLUd+pDYICRWpYvqotAi1XzjeWc850=;
        b=vVMTotlSq34r8g474NWdqfcgomcijjS+kiRCjdMVlMkFVOuUocooNGSvezRWygh6IO
         /RMwR5QuewLbWT7aOfIaq6RScqj6rnuByiXFfI3wJVFFrHDXRRvZiOz9mWMZdpa+ou9Z
         fxKretHOpeAec9nBjwf2/BebAPhogTrziUKyrjwumem8o2qsMXzbIEM8vv2Id+RkCYJf
         R69IQqz76jvt0bqYzKse6Q+MLeJQtFGL8bW/OChs0pym0wc/3v0A3fdd3VLun7T2Oz1j
         C7cpodGniGjMk1tjvr5U62NSadHO2M3W7+vXcoKEacuU6CJR2wFRR3o7vTk1IQG4HnJO
         bpzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXN0KzCdjm81H4XfAxNkMq8oP7uQgeTSHNJR4jBPqVE/L3OisJLWlpWUPqkjjDOl9RBCT2bu85rlia6258uSsJw+Oe0ndAT7qw8+s/
X-Gm-Message-State: AOJu0Yyy2Is7EqHinvhb29YdZvGFzfo2Bwf27eLEEGpdb+/w5oPVpVVL
	0FT0wIki/CGDyZn/c04FRaEFnQ+wxTlcSpcxLbrgLVSkJkLhcFG5gTJVLZe5WTI=
X-Google-Smtp-Source: AGHT+IFDZdEXgvpYFvYDPlTbFe/I24LhPGaam33E+x0qZmk8Ha0VpCJchtO79TGC7Q5GKUPegeSFeg==
X-Received: by 2002:a17:907:ea5:b0:a51:c281:60f3 with SMTP id ho37-20020a1709070ea500b00a51c28160f3mr4251234ejc.77.1712842776616;
        Thu, 11 Apr 2024 06:39:36 -0700 (PDT)
Received: from ?IPV6:2003:e5:8705:9b00:4df1:9dd5:4f97:24a? (p200300e587059b004df19dd54f97024a.dip0.t-ipconnect.de. [2003:e5:8705:9b00:4df1:9dd5:4f97:24a])
        by smtp.gmail.com with ESMTPSA id r10-20020a1709060d4a00b00a46a9cdcfa5sm759701ejh.162.2024.04.11.06.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 06:39:36 -0700 (PDT)
Message-ID: <99c720a9-b042-46d3-8182-cb9bcabb89db@suse.com>
Date: Thu, 11 Apr 2024 15:39:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/x86/xen: Use try_cmpxchg() in
 xen_alloc_p2m_entry()
Content-Language: en-US
To: Uros Bizjak <ubizjak@gmail.com>, xen-devel@lists.xenproject.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20240405083335.507471-1-ubizjak@gmail.com>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240405083335.507471-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.04.24 10:32, Uros Bizjak wrote:
> Use try_cmpxchg() instead of cmpxchg(*ptr, old, new) == old.
> 
> The x86 CMPXCHG instruction returns success in the ZF flag,
> so this change saves a compare after CMPXCHG.
> 
> Also, try_cmpxchg() implicitly assigns old *ptr value to "old"
> when CMPXCHG fails. There is no need to explicitly assign
> old *ptr value to the temporary, which can simplify the
> surrounding source code.
> 
> No functional change intended.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

