Return-Path: <linux-kernel+bounces-89958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7BC86F820
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38EA21F211E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 01:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3743017C8;
	Mon,  4 Mar 2024 01:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpaSsHvm"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFF5399;
	Mon,  4 Mar 2024 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709514903; cv=none; b=L652iqzQAPLip0AS9ACRoa/GL4mRqd/eMvXt6PD/ugcXbkb0sp1fY9IrYN5gvf0aLfpK2O6rcXE6PISeiv2HBH8SQggmq1IixbZPB1CMKE7unWxNwMNpi7oglyRtPyDWhx6icoJ9QtxcI18GpeH9ZG5Xt9a2w4lC46j2utDgXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709514903; c=relaxed/simple;
	bh=Is9g0jTE6Hghw4bYKw5kyfKhPC01Ffmw3Zw+sD4jVFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLjv/D+nTpodkSTWizlZYTVQUDqluhdixgYJM1o4jP77DB3G2Hy1stbc+2wFphXpL8DidmVxute7q3t4sZTuHU61LEy8gYriIDRLtbm72Z5Au610m71yHnlDZQkjGIGfgyiyZF/ifu6kK+It1EXs7+1nbmdSQts2iVWftl4QGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpaSsHvm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dcab44747bso31882495ad.1;
        Sun, 03 Mar 2024 17:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709514901; x=1710119701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J7+1VZ0sKh4c9zBtqZ8bdjGmhnnmQ3652uHnuEg9cXA=;
        b=VpaSsHvmsq8wPxFxaVNe2k8EnXqmcm+fwBhjAVyzu+u4sDsBPDBZC3y81tGIubjuIx
         K4JMcyVWYboXOAtx/0nfPOTvcNBmttNxkj5PzO7YyItuyd7nuE9jkoSMDuz/zpqu+Zpd
         JDKZ7Qn08vNQ+yCp/NOSyAqfCx5JXF/3SrjqrAoQgcEteyjERPQVpCKozwX0UQzM68lf
         nrtRfBeR2MsmZqkAH2BwgngLivWHPqt9IDw2tVxobgN4Q0Jx4hH4LEd/kjwiPQ8ymkke
         6pLEraPupI4qGYpEZJwLy3Hmycz4zW7AwG0Eitfr8/iBYn4zQrV15F4StUYXnxKSsJVj
         IvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709514901; x=1710119701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7+1VZ0sKh4c9zBtqZ8bdjGmhnnmQ3652uHnuEg9cXA=;
        b=QmVN1j87Q6h9ixYQ5XbLKuNv/iiHlJjKZl/TipaEbfAve+vrVwXtWnUdHnlNBO/HHz
         ek4fviPSmDjOKNI8XZebhkRlcGtxHykKEaSaJQMQrhManHrG1mYzZgeOssDbNqM7V/+o
         B+Aqif9w1b4kW4kEWuqx8qkxoilfLNB4wMiPA8XuUpo/dPeMpsR3jMCEGL1svULqwoV0
         hNCm3tUJM8n3XWT+76KuAUHktG0eW3yqlL89Tu47ken46rkQQgiCSK+cfflz/HnqCaeM
         og8MKWOQT+g4OLdcOryYXEMRLEWXd57EZRaU3O8xEPP29xl/PuqzgzXDXP9pdAShewfz
         Rypw==
X-Forwarded-Encrypted: i=1; AJvYcCVKedpZu5DoTDcbg37EflbEfS04jtM5InjBaq1Rsb+5+VoUJuOwPx+0zr5lMsk5ct0nczfGuKIpiJentRrUufSZC+FpfzUbpk9rW/4BUppbWcnaAN25r+d6MdH2/0nGzKKs+K8kgcqDWEtxnWkZn9H6nkqaxESkuRa0anQt5c7U5rT9cXCE6AleLaTF09R9wCnS1VWoLGnSYoeRf64Sfx4wVaPn
X-Gm-Message-State: AOJu0YymeynGbXn+aFnktXY5vVoJu7BEjfxUe/JoNGErxXTz6mfd7ZZA
	6FpcFmNVph4A1X8j7/YDaAeqi0wxPrzEsV2fxNOPrgaDi26AsQtA
X-Google-Smtp-Source: AGHT+IEhK3iUr8gBsGpNgs3hqYm/t6yFB3ipQbpCNtATZpIrbUTkevMfOSYevSIdRpG7OBtzj6KfsQ==
X-Received: by 2002:a17:903:2309:b0:1dc:43d:964 with SMTP id d9-20020a170903230900b001dc043d0964mr8277235plh.48.1709514901309;
        Sun, 03 Mar 2024 17:15:01 -0800 (PST)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902d10100b001dbb14e6feesm7212913plw.189.2024.03.03.17.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 17:15:00 -0800 (PST)
Message-ID: <ef93a03b-d43e-44e7-bb55-17b46d86104c@gmail.com>
Date: Mon, 4 Mar 2024 10:14:59 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] docs: submit-checklist: change to autonumbered
 lists
To: Jonathan Corbet <corbet@lwn.net>, lukas.bulwahn@gmail.com
Cc: jani.nikula@intel.com, kernel-janitors@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, workflows@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <20240229030743.9125-4-lukas.bulwahn@gmail.com>
 <8df0c587-8f5b-4523-89d7-dc458ab2c1df@gmail.com>
 <8734t7z4vs.fsf@meer.lwn.net>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <8734t7z4vs.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, 03 Mar 2024 08:55:51 -0700, Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>>> -1) If you use a facility then #include the file that defines/declares
>>> +#. If you use a facility then #include the file that defines/declares
>>>     that facility.  Don't depend on other header files pulling in ones
>>>     that you use.
>>
>> Wait.  This will render the list starting from:
>>
>>     1. If you use ...
>>
>> In patch 1/1, you didn't change the ")".
>>
>> It was Jani who suggested "#.", but "#)" would work just fine.
> 
> So I'm a little confused.  Is the objection that it renders the number
> as "1." rather than "1)"?  That doesn't seem like the biggest of deals,
> somehow, but am I missing something?
> 

I said at the top of my reply:

> I might be nitpicking too much, but let me go ahead...

, and my point here was to let Lukas aware of the variation of auto-
numbering patterns.  I don't object the change from "1." to "1)" if
that change is intended and explained in the changelog.

HTML builder recognizes "1)", but renders it as "1.", while
LATEX builder renders it as "1)".

> A bigger complaint I might raise is that auto-numbering restarts the
> enumeration in each subsection, so we have a lot of steps #1, which is a
> definite change from before.

+1

> That, of course, can be fixed by giving an explicit starting number in
> each subsection, partially defeating the point of the change in the
> first place.

Right.

> 
> I honestly have to wonder: does this document need the enumerated list
> at all?  We don't refer to the numbers anywhere, so I don't think there
> is much useful information there.  How about just using regular bulleted
> lists instead?

That would make a lot of sense.
Auto-numbered enumerated lists look mostly the same as bulleted lists
in the source.

No strong opinion, but I'd respect Randy's preference of not applying
this change.

        Thanks, Akira

> 
> That said, I don't have strong feelings one way or the other, and can
> certainly apply it as-is if that's the consensus on what we should do.
> 
> Thanks,
> 
> jon


