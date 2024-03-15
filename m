Return-Path: <linux-kernel+bounces-104797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 080F887D3D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA291F24A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E0038DD1;
	Fri, 15 Mar 2024 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dSI1gJOR"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19F414A9F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528105; cv=none; b=bIqAVHnfrntobBxogs4cnv2t/q2KfyepLWo2lruZPPSrNVnaOScOgTJoFikzKnemz6FgLV6Suq9LC647vLGKF2ccCklcHleBuwc01qc6+qZXQHa2Fh1crSZyOxHQ7fHh1ml72vaRGMjQI41uThPlwYc4hgJ8/noP5cd5rDLjKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528105; c=relaxed/simple;
	bh=6sNODvKTQ/pBcJxGo+BJkhwoG4FuMEJkTeFd/S8dXhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+UNC2v51GW0OS3QmMfuiemZS5TkbMedFIJO21YQqF8rFWfP65hjuknP7lR5X5EUjHcePs6Z8Q5HlmjRnJumF70XOg8lzi9YLiam5ExhJb1qhi7M4mNB9hFxDoErDlBt5tIBLChW3JzpYRHYosRObyhuq/W4bmeyhCN3oKtRH/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dSI1gJOR; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e694337fffso563046b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710528103; x=1711132903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lOi8R60F8R8EFdifsjdi6HEQyuwBQcJc8tV69kgjLY=;
        b=dSI1gJORgoMO+XscvAHQ6cwDHMuDlg73VPSZTJW66ksBYfmYH0teBMk5NxsUWCro+9
         j+sQ/MGxJa650SImSQZF3JfDFt02jXyqvDJM69vxoUo5GhDZGnGSejtiOM6f7LeVAV11
         I5zWeK0g3vkqk/A82jk3TRbx6co57PEhmHJMO3DvHtzebJGKPGZQIAPzkDLXziuUVe+i
         Z2qf9a8EYjIFOJkwIs6l9h4GB2dtYWIpL3vNfW6pWNwPVl41r7at4QOSLwWIZGLjs+Aa
         VRRHacbPyQWc12JHtzEvSG85wwtuo0W8AspXKR2YpPelEDGbp11jznaWKE7gd6HZsSEA
         gqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710528103; x=1711132903;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lOi8R60F8R8EFdifsjdi6HEQyuwBQcJc8tV69kgjLY=;
        b=AM9FGeA10ipLfAl8Y4IjF9YssZkC3tFtTb14sfKBjsyTIEvSz6YlyBwxkWm+4QKdYF
         y9v1KTeWVP1q4l8O3YvDCU3DAiK8Efu2KogYwYJgBSMX+/ALgNaYrXLMS3MAsUFBY9L9
         V4paVf8jEC0DizLLaj+5RBGehWyZOBYQT/YE6M3faGm3QhgUCRuE0EC4mW1u2ZBQWDlh
         63t9yRwry4VnxjKdElApp4lWftefkxwsUoLM7nakaEoFZ35n4nAcByfFP3RU+tUYv1uf
         JfhW3bSdYFWKlwu4cbceVf+NkPGsoXlhOxL75VseQV0S5keQKIL4kbfmoufFJ+dbp2gL
         HLBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQoUj4IN56CIIVzZGkCQB0De9vkplHjfHhqz1KWQK1PcEn+NbWUWfK8MHFbN5hz/1Br7eLxSlrQhgt1Y1b6GaE8cXSXvqlCalAdGXu
X-Gm-Message-State: AOJu0Yy6fbRyxygcKOkySTmzPqtHKB+el2n1hoJUtvjgX6qocGORhOlk
	KoeqkWrMjQSvr/GiT+2zRU1zGzE3c2Zj0dMrPZKYbHEJYZZgaawjWE6zJoa9MYM=
X-Google-Smtp-Source: AGHT+IG8GdCcLOhcKWWAkwSZEstwFYROwikNbnsPoU9FWsxewrK456qV7e8Kku0y8FamKom6HOjqqQ==
X-Received: by 2002:a05:6a00:2d07:b0:6e6:8954:b9a6 with SMTP id fa7-20020a056a002d0700b006e68954b9a6mr3383297pfb.1.1710528103048;
        Fri, 15 Mar 2024 11:41:43 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id ln17-20020a056a003cd100b006e6bcbea9e0sm3716680pfb.88.2024.03.15.11.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 11:41:42 -0700 (PDT)
Message-ID: <0f8291f7-48b1-4be1-8a57-dbad5d0ab28c@kernel.dk>
Date: Fri, 15 Mar 2024 12:41:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] capability: add any wrappers to test for multiple
 caps with exactly one audit message
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, linux-block@vger.kernel.org,
 Serge Hallyn <serge@hallyn.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240315113828.258005-1-cgzones@googlemail.com>
 <20240315113828.258005-2-cgzones@googlemail.com>
 <CAEf4BzZF0A9qEzmRigHFLQ4vBQshGUQWZVG5L0q2_--kx4=AXA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAEf4BzZF0A9qEzmRigHFLQ4vBQshGUQWZVG5L0q2_--kx4=AXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/24 10:45 AM, Andrii Nakryiko wrote:
>> +/**
>> + * ns_capable_any - Determine if the current task has one of two superior capabilities in effect
>> + * @ns:  The usernamespace we want the capability in
>> + * @cap1: The capabilities to be tested for first
>> + * @cap2: The capabilities to be tested for secondly
>> + *
>> + * Return true if the current task has at least one of the two given superior
>> + * capabilities currently available for use, false if not.
>> + *
>> + * In contrast to or'ing capable() this call will create exactly one audit
>> + * message, either for @cap1, if it is granted or both are not permitted,
>> + * or @cap2, if it is granted while the other one is not.
>> + *
>> + * The capabilities should be ordered from least to most invasive, i.e. CAP_SYS_ADMIN last.
>> + *
>> + * This sets PF_SUPERPRIV on the task if the capability is available on the
>> + * assumption that it's about to be used.
>> + */
>> +bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
>> +{
>> +       if (cap1 == cap2)
>> +               return ns_capable(ns, cap1);
>> +
>> +       if (ns_capable_noauditondeny(ns, cap1))
>> +               return true;
>> +
>> +       if (ns_capable_noauditondeny(ns, cap2))
>> +               return true;
>> +
>> +       return ns_capable(ns, cap1);
> 
> this will incur an extra capable() check (with all the LSMs involved,
> etc), and so for some cases where capability is expected to not be
> present, this will be a regression. Is there some way to not redo the
> check, but just audit the failure? At this point we do know that cap1
> failed before, so might as well just log that.

Not sure why that's important - if it's a failure case, and any audit
failure should be, then why would we care if that's now doing a bit of
extra work?

I say this not knowing the full picture, as I unhelpfully was only CC'ed
on two of the patches... Please don't do that when sending patchsets.

-- 
Jens Axboe


