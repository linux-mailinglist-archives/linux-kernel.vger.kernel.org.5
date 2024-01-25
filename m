Return-Path: <linux-kernel+bounces-38099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF4983BAEA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736D41F26126
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D048013AD1;
	Thu, 25 Jan 2024 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="eJpTpzUm"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C30313AC0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168647; cv=none; b=cqVBFbw5NkdAng4sYZbkBuSGMmb1vAp8pPsJ0niNtkglF+I2criHj7XPGftp9ghNwifjfYibywIDcDwNumz/+qycrO1bGL9tsdW9X6j0cf28442zuMfHrvhxTE22BNXNMAxgtB2VfkzSFs6VhtuKNbKbYcnC0pfMN7hSpFPsRHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168647; c=relaxed/simple;
	bh=/zRyXgfScq2qhDzTkUZAnu8mGkZKE+Y7QvmKgYaO/MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKV+ol/Xney44Fr0BpAPq8vPc6iXhG0nWnnRjq0Uub87cTRy7KD6R643hDTag5SktX3q46LkjSOnj/ThygIDEV18K0//hBhBUDNd1VEqOy6jTWvBcSCyAKxywH4fsTuwDFs+hCKe2Nfr/+Hm6VCyRy6PDgNflotibWLMBaRDMO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=eJpTpzUm; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ca1b4809b5so3085438a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 23:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1706168645; x=1706773445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxJzE0zQ0zLO/WoAmLS5VMc9S57pAEx7z2jFnshqCkA=;
        b=eJpTpzUm3PvQOb1xoQ6Pc4X/VszirV42bvwDGta0dWa/dMGmMbFSqFb0+NwRSJaDYP
         kRijm/vcyMYoNXcP9rKT3zQNfxMzAtAAccY87SuDsuEw+bCX+tOSjgct72QV7/kM1FS+
         a0IbRAhPszN5Bf0RlB10/lUIqnaDsFmsXZjFn92aSGzQqpgg7RVsIUr5UGE7ZDP40xvO
         Y8/pfFXYPkBWZnOGuOXlyBwptFI8qgAmE89uDsai0TkyS3Gr9Dj8S0qCkK90C0CeDlo4
         h8FmANIYvaWbTl0LarTAc5LkGL42t9eZh3sGU0nhEWwRK9WuwVhEhIiOp4ixrqBpVGUe
         5vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706168645; x=1706773445;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GxJzE0zQ0zLO/WoAmLS5VMc9S57pAEx7z2jFnshqCkA=;
        b=NRWSstWlPXb8iNB8dfGXH7EwEkMPEngFfqy+lvbarzw42HHkvETJ8D9e9+xh6uvc0Y
         ZuUrIU5hiuxT8j+D8ph258sZss7oZXQx+ZDVkuX13M/DtjJ9GWafKNT1G5f12UynvDKN
         kN+aHhJYSbVQBoXGRJmAIPtEPom991KR04ho6VQnGltri6oH3qQP/f3CVBuBOxS96OMg
         5zTlGJmhbn/mQlo9OUPxJUtwV5dx2MZXkDSW0Gm/uCF+H/spIrP1EK+II4A3/ZIPXiPY
         OODcb2Zc6xjfIIJ7NvpxC58GgSrIRXI5w0YZJTVj/grSNJlr9rb8ae9vfbImx0Xd/Wam
         mByA==
X-Gm-Message-State: AOJu0YxXqpvCNAC4bzfdyBrbDiJksMsdmMQAyeX7MZu0hFGNsexotEzh
	kIJIm4fI9cDf2MmalJ77/8I7X43Nztymdk6n3bNyAfRKjv0Nu5WADJWjo2cp3f4=
X-Google-Smtp-Source: AGHT+IFCTnKXrAaie/pFS6nMVtLCQajjlCNBv89MYx7w4JH0RmXPXGgpFEr/03gzZ2cPlCTe3+NLFg==
X-Received: by 2002:a05:6a20:bf06:b0:19b:665f:1f37 with SMTP id gc6-20020a056a20bf0600b0019b665f1f37mr441538pzb.99.1706168644784;
        Wed, 24 Jan 2024 23:44:04 -0800 (PST)
Received: from [10.54.24.52] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id iz11-20020a170902ef8b00b001d73126cac1sm7940496plb.173.2024.01.24.23.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 23:44:04 -0800 (PST)
Message-ID: <7e30ea7b-60ac-4c9e-b676-f354e9228ad1@shopee.com>
Date: Thu, 25 Jan 2024 15:44:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] x86/resctrl: Display the number of available CLOSIDs
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: fenghua.yu@intel.com, babu.moger@amd.com, peternewman@google.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240123092024.1271882-1-haifeng.xu@shopee.com>
 <6fb89a6b-031c-451e-80f7-58c277eda265@intel.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <6fb89a6b-031c-451e-80f7-58c277eda265@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/1/25 06:23, Reinette Chatre wrote:
> Hi Haifeng,
> 
> Thank you for sharing your requirements as well as submitting
> changes to support them.
> 
> I would like to start with a high level overview that applies
> to all three patches you submitted. This relates to customs,
> formatting, and style that will help your contributions get
> into the kernel.
> 
> In your next submission, please do submit your patches together
> as a series with a cover letter. This means that your series
> starts with a cover letter (think of it as "patch #0") and the
> patches are sent in reply to that cover letter. This is described
> in more detail in "Documentation/process/5.Posting.rst".
> 
> Regarding the patches themselves. Please read and follow
> Documentation/process/coding-style.rst and
> Documentation/process/maintainer-tip.rst regarding customs.
> The former is a general document that applies to the whole kernel
> while the latter contains more specific customs related to the
> area you are are contributing to here.
> 
> As a final comment, please ensure that your patches
> pass a "scripts/checkpatch.pl --strict" check. There are more
> details about this in "Documentation/process/5.Posting.rst".
> 
> While the documents mentioned above should get you started there
> is a lot of other valuable information in "Documentation/process".
> Consider the index in that directory to help you navigate through
> the available topics.

Thanks for your suggestions.

> 
> On 1/23/2024 1:20 AM, Haifeng Xu wrote:
>> We can know the number of CLOSIDs for each rdt resource, for example:
>>
>> cat /sys/fs/resctrl/info/L3/num_closids
>> cat /sys/fs/resctrl/info/MB/num_closids
>> ...
>>
>> The number of available CLOSIDs is the minimal value of them. When users
>> try to create new control groups, to avoid running out of CLOSIDs, they
>> have to traverse /sys/fs/resctrl/ and count the number of directories.
>>
>> To make things more easier, add a RFTYPE_TOP_INFO file 'free_closids'
>> that tells users how many free closids are left.
> 
> I do not see this as a change that benefits the kernel or user space.
> It sounds to me as though user space is planning some behavior based
> on what it knows about the current kernel internals and requesting
> more information to peek into these internals to make it easier
> to do so. The kernel can always choose to do things different
> internally, but it is required to maintain a consistent interface to
> user space. We should thus always take great care with new interfaces.
> 
> From what I can tell user space intends to use this "free_closids"
> to mean "how many more control resource groups can be created". This
> is not a contract that I think we should enter into. There has been
> discussions aiming to disconnect the number of resource groups
> from the number of closids (effectively letting resource groups
> with the same resource allocations share a closid). 

Is this feature merged into latest kernel or just discussions?
Could you please provide more details?
Last time, you mentioned that a monitoring group can be moved
from one control group to another.

This is something
> that the kernel may still do at some point but sharing "free_closids"
> knowing that user space intends to use it as a "number of resource groups
> remaining" counter would make future enhancements like this difficult.

OK, thanks.

> 
> Could you please provide more detail in why this is required? User
> space should not need to keep track to know how many groups can be
> created, creating a new group will fail with ENOSPC if no more
> groups can be created.
> 

User space reports alerts when failing to create new groups. If no one tell them that
closids aren't enough, they will keep trying to create new groups and the number of alerts
could be very high.

So we want to know how many closids are available, if it's zero, we give up creating
new control groups and those alerts will disappear.

Maybe user behavoirs can be ajusted. There is no need to create too many groups, especially
for those groups with same resource. Or as you mentioned above, we can reuse closid.


> Reinette

