Return-Path: <linux-kernel+bounces-117019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B23C088A639
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46501C3C6AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DCF1292C4;
	Mon, 25 Mar 2024 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2w4uE7M"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C2E143C74
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370203; cv=none; b=tRtQJHEpc/98xEnLGk7O5IWl5BNxozNdtdrcgVJS44U+EnYfqexNe2MoJnz+M3gFxINm8FJUunCtwXcU2CvVl3Ub0ldey3QppYFH92bB+O0nwlmiHYNgSg5RB62etxWZlxBYnZNxhRftza+WU0Qrfc3lDYTJfhaZ7p39OaCFOAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370203; c=relaxed/simple;
	bh=wdSegOXRShuc9cxtvrB+AzGO2il5sOCLpifFFtVjul4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BudG6hJ9IitRpaoBn0crNY6ADjOkgNBE9ohIo5L3/tDx3NR4zW6gCGRCpUoB/zkXdFsxRe1SvbBfxyQn3U/lkGT0QaWJddZ4BzA4POzrJVzsnZ7/sRDDRdcvzydqJX0roAWS6mwwWYt+bJu9/kJdXt2P+Am/YlxQX+C2HA3n9Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2w4uE7M; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6f4ad4c57so3196894b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711370201; x=1711975001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HVD6kyr2yejC7DWiFF8eaBlp4UDIjmyFCY0XmmIOv6Y=;
        b=D2w4uE7MdkA0nnQVBEDQL8F8znqbu/3wrAgra1/+gc28u4GkPihmnRlrKDIXDgjqVi
         cS+bwjvLp4FxlGjBY/ZGxQpoVBrxdeCQBHcxnt11I2rhckuRHbyePmSVg+o/53lgX/rs
         5+nT+U8oG1gwhRf/bAa80FlxCx1ux16ppHUMRxUipvyHLYhA8h53fzzDIlATZrEvHdc7
         Ito7cr2FnIHvdFRyGxat5YFl5s/eEZ4eJZ6385Wnv1aNsqiZI2U+UD3ysGT9JIzaXCIw
         XOz5LalOfLV91tr2NlQqkEFhzYCoGFDvffmgSACR7a+NNv3fD6JbE+rGMScQgcClvUKN
         hDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711370201; x=1711975001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVD6kyr2yejC7DWiFF8eaBlp4UDIjmyFCY0XmmIOv6Y=;
        b=f0UbhYXNpJ5BGsAJs2mAZOxpZVyUQhy8ubAvkiZDLZqFLD7tASO4Nyva8RUC2MOBPo
         kcVenI3Q9yVasW6wFmemy8Np12KoN2w7ErGxql0frEqcnttOk0tshnrySAQPiHQAEZSR
         x6Z7WAciWauH47iS+6lHDRYWJAlTT7vZIAKB6SS61Dq2Mqns4jjpIy9J0YOYa1fxsFHO
         oOu6K7Vx3YgNnRkV9gWhcLPLLQoZFwhjvhyuvUFBYx68/cLQkQ4J/ot/ptlwzv0AJUOn
         IxVRak7gTSjK/LYoJvjziPYHEDcBr8PXdRDBZCdJTGyf5H4pznEvvEp3Zg3Oc3iHlxhQ
         2q4g==
X-Forwarded-Encrypted: i=1; AJvYcCUbcs1Xy1n6egaeZsBhjO9WDVCKDR2euEOISqC0/ejFrVpzOEo+kKKTkt35EBxbZ/BfvJV5x/U7o3JGah01MKPWB4/gpKc/aLX8swwO
X-Gm-Message-State: AOJu0YyVCYnAjTNlTYGandAnn5XptRyszspMO/PIeLRQgaP58DSrALEv
	PQLhvpL/C8XoCOFwCequvK+kswIeNd2HG2d6EKYKiqo7agk3G+3v
X-Google-Smtp-Source: AGHT+IFSAq6ifk8Zm6QypSlyeD9gVsuzinOO29bEJo4kN4j84rCnSW6AUJHOinRtT6jayDegwGpJyw==
X-Received: by 2002:a17:903:32ca:b0:1e0:1bc1:478c with SMTP id i10-20020a17090332ca00b001e01bc1478cmr9186425plr.22.1711370201243;
        Mon, 25 Mar 2024 05:36:41 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id h20-20020a170902f7d400b001db3361bc1dsm4575112plw.102.2024.03.25.05.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 05:36:40 -0700 (PDT)
Message-ID: <f67006d5-026f-407b-9926-1a60f15e6244@gmail.com>
Date: Mon, 25 Mar 2024 20:36:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] mm/ksm: use folio in stable_node_dup
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, alexs@kernel.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Izik Eidus <izik.eidus@ravellosystems.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
 Chris Wright <chrisw@sous-sol.org>
References: <20240322083703.232364-1-alexs@kernel.org>
 <20240322083703.232364-6-alexs@kernel.org>
 <Zf2qcH-bDEgLAP7d@casper.infradead.org>
 <df87f782-185f-40f7-8745-ab09fe144189@redhat.com>
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <df87f782-185f-40f7-8745-ab09fe144189@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/23/24 1:11 AM, David Hildenbrand wrote:
> On 22.03.24 16:57, Matthew Wilcox wrote:
>> On Fri, Mar 22, 2024 at 04:36:52PM +0800, alexs@kernel.org wrote:
>>> -static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
>>> -                    struct ksm_stable_node **_stable_node,
>>> -                    struct rb_root *root,
>>> -                    bool prune_stale_stable_nodes)
>>> +static void *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
>>> +                 struct ksm_stable_node **_stable_node,
>>> +                 struct rb_root *root,
>>> +                 bool prune_stale_stable_nodes)
>>
>> Do we really have to go through this void * stage?
>>
>> Also, please stop reindenting the arguments.  I tend to just switch to
>> two tabs, but lining them up with the opening bracket leads to extra
>> churn.  Either leave them alone for the entire series or switch _once_.
> 
> I wish the coding style would at least recommend something -- I know, different subsystems/files have their own rules. Nowadays, I prefer 2 tabs as well.
> 

Hi David,

Thanks for comments, 2 tabs looks good. But just this file keep using more tabs.
For the style alignment, let's keep them for now?

Thanks 

