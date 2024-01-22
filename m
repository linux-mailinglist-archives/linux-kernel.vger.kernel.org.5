Return-Path: <linux-kernel+bounces-33844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFA8836F67
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EBD1C274CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C9E6774B;
	Mon, 22 Jan 2024 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZBoQERao"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63681679F7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945134; cv=none; b=kUu9Idjp1dUypuwG7orJx0+9oW+MeBFwKWRcOcuzOcv5fL3Ho+WCjPC+LsYtPLLyfoCH5Uc/PLfYZomN4orNFw1mk6ORgjPGCM8TuHYcWGc5m6icYflCI3FkuujY48YyH5Ma+P6sn18ZrGlnbZsnpfLabK5qNjgK7lwYpJW4MJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945134; c=relaxed/simple;
	bh=1agfQj91jKPuM03IvQvPn7FRroTkYhBE3Eyvb0JlhPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcgSZji4Bhk78I3XNDqoSAfp16AcZA9B0OUCQWrzocagwq7fUTvj4WHZRIaCl2QstsJ4v6w1MsFBaW43u3vc+SNnTs0DVMWqvuw/Z21LX1K2DdWn6stEcONnTX87nTLkv0kfFHOAM3NsKR+Gs0fg44+sO9ZC24Sm1GRANoqnJcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZBoQERao; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-58962bf3f89so440644a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1705945133; x=1706549933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XtjcrQsxe6bJ8QdGg7J5xA0F4dr3vWlDQohelUrXlB4=;
        b=ZBoQERaoSnk/Z9mTyIkwFGcoQwwGQQF1Fq7Yu4Ojofn9iy0XPuMROQqBdAfCGayqwV
         x85KBP5HVzHzFN85Feevls5DNb2lnpiWCPPP6ixSNfXozvgXUXfRwxjDNLPBpxvMfxH4
         EJI24VFRApsGmcb5zZrx0FtgJMQTMJFEN/R0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705945133; x=1706549933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtjcrQsxe6bJ8QdGg7J5xA0F4dr3vWlDQohelUrXlB4=;
        b=buKKzg4bU+ar1IeNdUjj8xxfQR48L8nr8n21BBcpTazu2V+1h0QTHvxVswWSdzx4zn
         z/9BXIJ964B0iqHxoKiNJJKshGMxjUTAgAe4amq/GThwgIrdeXE9lSuF5xWU41HmDu2+
         5lTcFZufakOCNMplg3+fRk9Wcm/La78bm2KPTJud+wOf8iN62iWJxEMeNguCaYRTbbus
         EkA36GwNWB3JBGj29pCF5iwGQgh5m1Ih3uLqk7DdAlwujmKlJ29NFc0kMrR91Zwub6eV
         Y7bjMrvTO087xk041V/18BpLe6cCKQF/aM7Vb8KwZhEpcZ20nT6YRTY8GN6gWz53Ib+k
         IB6g==
X-Gm-Message-State: AOJu0YyE3gTADLBaoMcoRBBp8NV+o2hBDB/860S3edPKGiknqcU1yyFw
	9L0jmWRRyiIh33EDDIhtC9vS0e1qcXjTmsRWYdZrV8X6KLsvZ/HKrAT/P0Ejrps=
X-Google-Smtp-Source: AGHT+IGKsyRXEY3tO1H9OuYiUwsfj+vq0ROdCS8ekfKfxcvrR4RqapGfHOijT8aFHG7x9DfCyz47wA==
X-Received: by 2002:a05:6a20:439f:b0:19a:efad:f1c3 with SMTP id i31-20020a056a20439f00b0019aefadf1c3mr12427542pzl.4.1705945132828;
        Mon, 22 Jan 2024 09:38:52 -0800 (PST)
Received: from [128.240.1.152] ([206.170.126.10])
        by smtp.gmail.com with ESMTPSA id kq9-20020a056a004b0900b006db85b12036sm9837515pfb.137.2024.01.22.09.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 09:38:52 -0800 (PST)
Message-ID: <c03a1cdb-43fb-4f5f-8498-c45b7501e1bf@linuxfoundation.org>
Date: Mon, 22 Jan 2024 10:38:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] kselftests: lib.mk: Add TEST_GEN_MODS_DIR variable
Content-Language: en-US
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Shuah Khan
 <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 live-patching@vger.kernel.org
References: <20240112-send-lp-kselftests-v6-0-79f3e9a46717@suse.com>
 <20240112-send-lp-kselftests-v6-1-79f3e9a46717@suse.com>
 <5aceb855-2862-4d53-b27b-50e2956e099b@linuxfoundation.org>
 <dfcf46def7a4b27e30bed0e832fbf24fd7b36310.camel@suse.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <dfcf46def7a4b27e30bed0e832fbf24fd7b36310.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/22/24 10:37, Marcos Paulo de Souza wrote:
> On Mon, 2024-01-22 at 10:15 -0700, Shuah Khan wrote:
>> On 1/12/24 10:43, Marcos Paulo de Souza wrote:
>>> Add TEST_GEN_MODS_DIR variable for kselftests. It can point to
>>> a directory containing kernel modules that will be used by
>>> selftest scripts.
>>>
>>> The modules are built as external modules for the running kernel.
>>> As a result they are always binary compatible and the same tests
>>> can be used for older or newer kernels.
>>>
>>> The build requires "kernel-devel" package to be installed.
>>> For example, in the upstream sources, the rpm devel package
>>> is produced by "make rpm-pkg"
>>>
>>> The modules can be built independently by
>>>
>>>     make -C tools/testing/selftests/livepatch/
>>>
>>> or they will be automatically built before running the tests via
>>>
>>>     make -C tools/testing/selftests/livepatch/ run_tests
>>>
>>> Note that they are _not_ built when running the standalone
>>> tests by calling, for example, ./test-state.sh.
>>>
>>> Along with TEST_GEN_MODS_DIR, it was necessary to create a new
>>> install
>>> rule. INSTALL_MODS_RULE is needed because INSTALL_SINGLE_RULE would
>>> copy the entire TEST_GEN_MODS_DIR directory to the destination,
>>> even
>>> the files created by Kbuild to compile the modules. The new install
>>> rule copies only the .ko files, as we would expect the gen_tar to
>>> work.
>>>
>>> Reviewed-by: Joe Lawrence <joe.lawrence@redhat.com>
>>> Reviewed-by: Petr Mladek <pmladek@suse.com>
>>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>>> ---
>>>    Documentation/dev-tools/kselftest.rst |  4 ++++
>>>    tools/testing/selftests/lib.mk        | 26 +++++++++++++++++++++-
>>> ----
>>
>>
>> Hi Marcos,
>>
>> I would like the doc patch and lib.mk patch separate. If lib.mk needs
>> changes
>> we don't have to touch the doc patch.
> 
> Hi Shuah,
> on patch 2/3 you also said that you would like to have the
> documentation changes split in the future, and that you picked the
> changes into a testing branch. Does it also applies to this patch?
> 

No need to do anything now. I just applied the series to linux-kselftest next

thanks,
-- Shuah


