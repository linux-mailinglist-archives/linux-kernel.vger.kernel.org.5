Return-Path: <linux-kernel+bounces-139846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496318A0862
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052792823A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643D013CAAB;
	Thu, 11 Apr 2024 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JeC0VHvq"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03D313BAD2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816593; cv=none; b=AYR1jbWpxvi2jD1vBIY9iEVebjGv28YXj4tMPQychuulbOpMJmJ4PinBd7MoRu+lGOKxnQCt06b5Ya4l85egOnm5im0WYflDriVWkTdIRjaYLFSbQEnMdmS4u/ufuWGjjm73Zase+ylt4ckblZZ23lIH07H2fr6gfd/au1+USfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816593; c=relaxed/simple;
	bh=HDf/CGGXdDu0lGgMAh/yl9JtgL1KQh7rxeBcXqe85zA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpIGAp4TW0ZsfqMHUaC4QaN2QVRrTWPW1GJ+3wbikdpI8DsAIPS9KSzIY/P0GLnoPwVzvtR1VYAa0Zs2zMgWiS3plDc9BbwrVXnJ+H6toxkK2NHOb0f7sCWgR1T8V+azfskcS58L0iEwqjg/ejDpuPa2Xqe1hYXo1VVM2NYv2mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JeC0VHvq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e509baddaso4523729a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712816590; x=1713421390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qjhh2+gThEO/kCWezAx59K5A9rb3xa5e1jTaD90Sdow=;
        b=JeC0VHvqeuSbk1l6Acm+NI1eJ00LnQz+xJwjQf7nz518EOJTQTsHX2W4kS1wmNAAD3
         11Q0SpPks04eGCZs/p9r3zi/LKX547fUoJB8JnGLPKJBCy+I7OfVa4GTny2HTyKROXDg
         07aiUbWUlxPjGN9TdWE87fKQWyvVF8CV7u1UyHcOvVfpNsErI7oNZcz4TISUs7W/Vqa+
         bPjxj/Gvm8EebZfI2nANYalj+04koe+t/uyUc0oKq91spLIN7ZMZoZZw+jHBsuqySoCe
         W9KVwAK7Q+0IqYL9C3SMPiWxrDFfLg2cydn9u06u5DZf/ErLLv2OhSlxjOX6LiGB9kjV
         KLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712816590; x=1713421390;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qjhh2+gThEO/kCWezAx59K5A9rb3xa5e1jTaD90Sdow=;
        b=NwOxNl61Vgz4AgyXi1zYb4yJmnB3pk8+ccAJ1CeApoXTbufrrY6bJ8SuO6XTh1Cj+v
         a3OZ9iwni4uWbJPsa1aQiENbf6P9C7Pd60BCff+zBT+IXI7DS0nMHQszmD2ONRYHOWnM
         h+/wCWUPJYkOhUGLqOLuEcnfvYZ09+tVw63rc9GXe2ti1U2GH/4C/LRLnR6VSlkyHury
         38TMr3/9Iqu4/rNOzJwbDZG1Iz19h0mHDTymPHpN3B86pd9I3hGz200I825CvJo0+hb9
         qPKDqdiiyq0Vkode0L0shp3mm+uVwi8BHgLOsPnUyeKGKATwkAwkParHtrzDhJcn1DbI
         ERoA==
X-Gm-Message-State: AOJu0Yx6KSQ9q5uufx0QGjkADMOvR88AZvSSCWxhPMsEyaNI3TkmojGL
	yAu6E4h1hXP/utULrVdJJodlVnnbqzR05Rz+prC3qX5KD4e6bL2gxLCndzAIq+Tl63g9aS1ILBD
	o
X-Google-Smtp-Source: AGHT+IFYBYKGI4UqlhXZVMKPFjO81rQHmToKsALjSU/LFezNWz+es5SklRAtNCLkyh/3QU2ZWf7VqQ==
X-Received: by 2002:a17:907:7f92:b0:a51:969e:d4e with SMTP id qk18-20020a1709077f9200b00a51969e0d4emr3464567ejc.52.1712816590010;
        Wed, 10 Apr 2024 23:23:10 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7318:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7318:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id m10-20020a1709060d8a00b00a4e57805d79sm426232eji.181.2024.04.10.23.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 23:23:09 -0700 (PDT)
Message-ID: <47219c57-e46e-475b-9c88-c0afdc4e97a3@suse.com>
Date: Thu, 11 Apr 2024 09:23:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and
 spectre_bhi=auto
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Christopherson <seanjc@google.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, KP Singh <kpsingh@kernel.org>,
 Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>
References: <cover.1712813475.git.jpoimboe@kernel.org>
 <412e9dc87971b622bbbaf64740ebc1f140bff343.1712813475.git.jpoimboe@kernel.org>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <412e9dc87971b622bbbaf64740ebc1f140bff343.1712813475.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11.04.24 г. 8:40 ч., Josh Poimboeuf wrote:
> Unlike most other mitigations' "auto" options, spectre_bhi=auto only
> mitigates newer systems, which is confusing and not particularly useful.
> 
> Remove it.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

