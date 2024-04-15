Return-Path: <linux-kernel+bounces-145430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18AA8A560F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D79B1F21E68
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1AB763F8;
	Mon, 15 Apr 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqi44QW7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E5A76044
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193837; cv=none; b=jq72oJbii7KiKKpG/bWfrb1eorByX4B4E5lNVYctxZ9bR1tURntYsEukgSBI+caCdtho1Ide5TzSxnunO9zvqW9ojSW+7NNa53k2nmNQp+x9D/L7HoZnBGBtnW2xi4Ho5aQG4am6wi4JGihAOy4TE/jcBDZGSAqLXC/1NLHkSrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193837; c=relaxed/simple;
	bh=zWaFqp45xreSd1kt8H0PrqpcJfPYwloQ5CpoGlW5FJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sp5lOOjgBsSBd7f9PB7Jjl6B++3XGOa2nxoVTSInfDvBpbgQc33+y420c4a7k6X4VGJhr/6wV4NBV2bzesstTv7sjgf7CW9VbdTthgAURu0l3dhdYPoYsb30fPSsQh0bz0GlIhAsrg7pNBE6O/5qwBXY+2bd4jYawV/ABAuWaBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqi44QW7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713193834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2aJKc1qLqZnJWxvdZ9CCWCQa3ouDy8zOEavGI3plEjw=;
	b=fqi44QW7+QYkj22B3QWBEPZ/mzfivolLH6OiH0UCrz+8/gOdIjvWSeBn4DYJrjKBwXpqTA
	5fKN3sfgp/33HZe9FPcmbbc/EK1LOvtIoRSVdzetG6lHDV76Z9Te71MpfEoqspvDMeKj6R
	bH+8h8lhYogFo6Dp46e182jLMr/zhfk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-CDpoJFwiN4ysWsvmhVbNqQ-1; Mon, 15 Apr 2024 11:10:33 -0400
X-MC-Unique: CDpoJFwiN4ysWsvmhVbNqQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-516dc3ada5dso3566757e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193828; x=1713798628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2aJKc1qLqZnJWxvdZ9CCWCQa3ouDy8zOEavGI3plEjw=;
        b=FhfxZ5eHJpU1cfQyBkry7Ovh8Dj+ui1x7TWsPjz7k0+Zcv41f0uODE+cJQB0dqGmuO
         /5wUEnSuda2Rh+WxTd0yXxqeb4uOLu+MgSVzASriyGb+P/qgXsZEhoT5BFlRKrW5v6RT
         wlEFXyLsinTOJxi/b0oO/MJUhawUFO24PLyR0VnRRC8G1tV/uM8pxByXTLokLz4ypW8R
         gogHbDFEIWD5IvKenkbz841UaG66yOOQTg2h3Ek+gJ9BbFCBD4uFl1C5enRI1gvzeZAI
         1PoexlCgNPF1srbLWE1rr3TdhQv856V1KdLpoGzqQosbDP6yOCcZUVBUVUNU+5WuQZE8
         gIVA==
X-Gm-Message-State: AOJu0YwNzNnce0GeIEFo3aw9uw5DsJELC9EHsOMJqux8yNuGy38vX59J
	VWlqs9qdlbPqp3/+TNjZfogpTVb4NwUBj38SnT4fD+eClUqynOF10ORUfH54PFSLTg7dUg9v0wb
	kBDXgOZ+bzCwHVQpkM7ykwZi9bXGD3weRhxpCfu0+sxBy14LUl7LzwiVnOs+tjA==
X-Received: by 2002:ac2:4d08:0:b0:517:84fd:2343 with SMTP id r8-20020ac24d08000000b0051784fd2343mr6248210lfi.41.1713193828625;
        Mon, 15 Apr 2024 08:10:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExaaXlGV0rESBoorCek8bZesfSkRVyMdj0WAYaof5VX8Izy8004klGK7UZXnewro1ZZRR2oQ==
X-Received: by 2002:ac2:4d08:0:b0:517:84fd:2343 with SMTP id r8-20020ac24d08000000b0051784fd2343mr6248186lfi.41.1713193828190;
        Mon, 15 Apr 2024 08:10:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id qs1-20020a170906458100b00a5227c8f0e4sm5154321ejc.89.2024.04.15.08.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:10:27 -0700 (PDT)
Message-ID: <ab3caa8c-daf0-4d35-a7c7-b1a14f7bc1bb@redhat.com>
Date: Mon, 15 Apr 2024 17:10:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] platform/x86/intel/ifs: Classify error scenarios
 correctly
To: "Joseph, Jithu" <jithu.joseph@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 ilpo.jarvinen@linux.intel.com, markgross@kernel.org
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
 ravi.v.shankar@intel.com, patches@lists.linux.dev
References: <20240412172349.544064-1-jithu.joseph@intel.com>
 <20240412172349.544064-2-jithu.joseph@intel.com>
 <69d360fc-85e4-4a6d-8f08-9f90dd7ec583@linux.intel.com>
 <57c32cfd-136d-4c72-9f4d-12599b508fb8@intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <57c32cfd-136d-4c72-9f4d-12599b508fb8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Thank you for this patch series.

On 4/12/24 9:31 PM, Joseph, Jithu wrote:
> Sathya,
> 
> Thanks for reviewing this
> 
> On 4/12/2024 11:32 AM, Kuppuswamy Sathyanarayanan wrote:
>>
>> On 4/12/24 10:23 AM, Jithu Joseph wrote:
>>> Based on inputs from hardware architects, only "scan signature failures"
>>> should be treated as actual hardware/cpu failure.
>>
>> Instead of just saying input from hardware architects, it would be better
>> if you mention the rationale behind it.
> 
> I can reword the first para as below:
> 
> "Scan controller error" means that scan hardware encountered an error
> prior to doing an actual test on the target CPU. It does not mean that
> there is an actual cpu/core failure. "scan signature failure" indicates
> that the test result on the target core did not match the expected value
> and should be treated as a cpu failure.
> 
> Current driver classifies both these scenarios as failures. Modify ...

I've modified the commit message using the rewording suggested above
while merging this patch and I have merged the entire series:

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans






>>> Current driver, in addition, classifies "scan controller error" scenario
>>> too as a hardware/cpu failure. Modify the driver to classify this situation
>>> with a more appropriate "untested" status instead of "fail" status.
>>>
>>> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
>>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>>> Reviewe
>>
>> Code wise it looks good to me.
>>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
> 
> 
> Jithu
> 


