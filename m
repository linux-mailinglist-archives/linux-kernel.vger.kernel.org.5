Return-Path: <linux-kernel+bounces-45514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CC88431B2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504D01F25DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF7F360;
	Wed, 31 Jan 2024 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UftDpcrf"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D50E363
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706660116; cv=none; b=fSwBZbzJHvktKDgWM9GuzpjNHxpuOJ4U0wn+O92orURm75RksC+DFWtpHMF9S8xppk/FyIYjw7PjigkpE677NNWzCbt9Hyps8+bB8E4ON1mBZOsiwrZmULWXvA+EWUtz4/pwSV8HEJ+rUgD5iXpJ7yUmdxvANatn5hC1gFHj/u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706660116; c=relaxed/simple;
	bh=k8/pae4/da/ya9K4eL0CHzudnNR9VXfTYjjxeLuhV0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhL5wD0BjLSL3cFcQMXsVjRFaOBo4zxF7i+ENeYd3ckfZNkCst92u6ENfA4mWHax5J1qYbYKB4+5ZwbIzR5BIzkQr0w4xGXLzKWubW8gUgYMNZG93AVzfzb9Sr73G3OBNsyCezDk6Ke7RuPSg7ar8qsA32YzCIUU2efrEYJs1Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UftDpcrf; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6dc8b280155so2707323a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706660114; x=1707264914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a63LSX7VCM/bGDS9g/hRD7iO96L/4kBBk83/2uvCRqc=;
        b=UftDpcrfmNPiUn0M1D/3WXiKmXzSTGQOvBdwUwKIXFy0OjCx50cwu079RY7J/Eh7BM
         /u9ZPj5vbcopO8JNuytxCxbwY6n77xe4Z23PzbcpoUSqqSIrPJ6Z2bD8fE6qbXXdtakS
         uRN91NuPEeZ2MOBQBLeHuYNQFt5nAjKGJ5H2PS+EjZquD21WeU+Wf8y/oVbUeYrSshUw
         PTOFkf/gMoxiwkQLQ8wa2iIdywocUGKEmyS8OsFLSVG1tX9GWWYUxeXTWqoKe1syUizR
         pMtVQpHQU0kzhC5woM5QA4zD1dfzRyDO3FGXyVYXlGM4EDsper0qpvlYxzV52AytVV5e
         x8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706660114; x=1707264914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a63LSX7VCM/bGDS9g/hRD7iO96L/4kBBk83/2uvCRqc=;
        b=o0ffJGtl7QzQEbFOdvf0ENfXxv9QUBlZ5QzRnWuWgygzkhoWuJNGN+ny1qm3TCbz1a
         yoSdfW+39GqKm+Jg2oOwV7lnZCfP1LI/3RZptUK0xJPjRr3hWCVGoEUYStPDK9d0KAVc
         K0PQPp8fUFhXnf9mCFeNM55lp122RlhCpA8L2UeQa2ZldDmtlojP670xwSKAD24oB3dd
         fZJXTTEMgT6aWHoEWP3K1Og2vEGYflaGpE905BVn9YhVxwD0WnROCeCudyXtUIBX1pkO
         tVgjC0RT01nV9KOS8HtDF1r0TrvfSOg+BbLETpbaLf+ln6K4tNg0Xk+a0ktF5weuIoNp
         Rrcg==
X-Gm-Message-State: AOJu0YzUYrb5iuKMXggUKg2OWahlMrVuQN5oceNlwfIqL/DHwAg12tN/
	ePufdampqqsKrBLOIlkj2BxarOPqbHCHHUXFUpBVuDJiTOvNPRqqDQZbW74sVpM=
X-Google-Smtp-Source: AGHT+IHTFB8hY1gHZ2pUGG0RuZA9P/NJGfLJG2nR+Nw1grF/tQeys8OqibvEtbPsu41uPv0jyJZ9GQ==
X-Received: by 2002:a05:6830:34a8:b0:6e0:f80a:fbad with SMTP id c40-20020a05683034a800b006e0f80afbadmr6481258otu.23.1706660114168;
        Tue, 30 Jan 2024 16:15:14 -0800 (PST)
Received: from [192.168.17.16] ([148.222.132.181])
        by smtp.gmail.com with ESMTPSA id l31-20020a056830335f00b006e11e3fafb8sm1460719ott.66.2024.01.30.16.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 16:15:13 -0800 (PST)
Message-ID: <787d3fb1-7aad-4e92-8a22-360b92f46c68@linaro.org>
Date: Tue, 30 Jan 2024 18:15:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: selftests: ftrace: Internal error: Oops: sve_save_state
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 linux-stable <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Marc Zyngier <maz@kernel.org>
References: <CA+G9fYtEGe_DhY2Ms7+L7NKsLYUomGsgqpdBj+QwDLeSg=JhGg@mail.gmail.com>
 <ad5b7442-385d-41db-9202-a36414460610@sirena.org.uk>
 <CA+G9fYsbwWpDVR9KJXx8UO5MXsYT81uAJbLLNDnLianr8jmXUA@mail.gmail.com>
 <63e92a6a-9cb7-4272-b524-ccaf997aceb3@sirena.org.uk>
 <CAEUSe7_9tE5K7NpsmaG_v_bTJaMGhVVSDRhMn1QYnr2z4vSg8w@mail.gmail.com>
 <b1b8cbdd-6d6c-4656-b17a-4d2dfb555f8a@sirena.org.uk>
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <b1b8cbdd-6d6c-4656-b17a-4d2dfb555f8a@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 20/12/23 7:06 p. m., Mark Brown wrote:
> On Wed, Dec 20, 2023 at 06:06:53PM -0600, Daniel Díaz wrote:
> 
>> We have been seeing this problem in other instances, specifically on
>> the following kernels:
>> * 5.15.132, 5.15.134-rc1, 5.15.135, 5.15.136-rc1, 5.15.142, 5.15.145-rc1
>> * 6.1.42, 6.1.43, 6.1.51-rc1, 6.1.56-rc1, 6.1.59-rc1, 6.1.63
>> * 6.3.10, 6.3.11
>> * 6.4.7
>> * 6.5.2, 6.5.10-rc2
[...]> Looking at the list of versions you've posted the earliest is from the
> very end of June with others in July, was there something that changed
> in your test environment in broadly that time?

Yes! Important to note here is that I started collecting that date around that time, second half of 2023. It's possible that the same problem was there before but I didn't register that.


> I see that the
> logs you and Naresh posted are both using a Debian 12/Bookworm based
> root filesystem and that was released a couple of weeks before this
> started appearing, Bookworm introduced glibc usage of SVE which makes
> usage much more common.  Is this perhaps tied to you upgrading your root
> filesystems to Bookworm or were you tracking testing before then?

I don't have an easy way to swap the Debian version right now, I'll have to ask around, but that might be a good experiment.

This message appears so sporadically that it would be hard to determine with 100% certainty if the changes we make really fix the issue. We can try to figure out just how sporadic that error is, though, and go from there, but the numbers looks slim with this happening once every so many weeks.


>> Most recent case is for the current 5.15 RC. Decoded stack trace is here:
>> -----8<-----
>>    <4>[   29.297166] ------------[ cut here ]------------
>>    <4>[ 29.298039] WARNING: CPU: 1 PID: 220 at
>> arch/arm64/kernel/fpsimd.c:950 do_sve_acc
>> (/builds/linux/arch/arm64/kernel/fpsimd.c:950 (discriminator 1))
> 
> That's an assert that we shouldn't take a SVE trap when SVE is
> alreadly enabled for the thread.  The backtrace Naresh originally
> supplied was a NULL pointer dereference attempting to save SVE state
> (indicating that we think we're trying to save SVE state but don't have
> any storage allocated for it) during thread switch.  It's very plausible
> that the two are the same underlying issue but it's also not 100% a
> given.  Can you double check exactly how similar the various issues you
> are seeing are please?

I'm not sure of how similar the test cases are, but I'm inclined to think its occurrence is not related specifically to ftrace or one test case. It looks like these appear on FVP and Qemu-arm64, on several LTS branches, and while running different set of tests. On today's episode, we had it happening in the middle of ltp-controllers' cgroup_fj_stress:

-----8<-----
   <4>[  619.431962] ------------[ cut here ]------------
   <4>[ 619.432530] WARNING: CPU: 0 PID: 10382 at arch/arm64/kernel/fpsimd.c:1403 do_sve_acc (arch/arm64/kernel/fpsimd.c:1402)
   <4>[  619.433889] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 fuse drm dm_mod ip_tables x_tables
   <4>[  619.436649] CPU: 0 PID: 10382 Comm: cgroup_fj_stres Not tainted 6.1.76-rc2 #1
   <4>[  619.437435] Hardware name: linux,dummy-virt (DT)
   <4>[  619.438319] pstate: 42400009 (nZcv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
   <4>[ 619.439680] pc : do_sve_acc (arch/arm64/kernel/fpsimd.c:1402)
   <4>[ 619.440003] lr : do_sve_acc (arch/arm64/kernel/fpsimd.c:227 arch/arm64/kernel/fpsimd.c:253 arch/arm64/kernel/fpsimd.c:1400)
   <4>[  619.440572] sp : ffff80000f3e3e40
   <4>[  619.441022] x29: ffff80000f3e3e40 x28: ffff0000c4e42100 x27: 0000000000000000
   <4>[  619.441860] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
   <4>[  619.442789] x23: 0000000080001000 x22: 0000ffffaa47a454 x21: 0000000000000001
   <4>[  619.443893] x20: ffffb6cd7e13c0b0 x19: ffff0000c4e42100 x18: 0000000000000000
   <4>[  619.445033] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
   <4>[  619.446017] x14: 0000000000000000 x13: ffff80000f3e0000 x12: ffff80000f3e4000
   <4>[  619.446991] x11: 25fdfcd46891cd00 x10: 0000000000000200 x9 : 0000000000000000
   <4>[  619.447614] x8 : 0000000000800000 x7 : 0000000000000000 x6 : 000000000000003f
   <4>[  619.448285] x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000000
   <4>[  619.448963] x2 : 0000000000000008 x1 : ffffb6cd7c019eac x0 : ffffb6cd7c019eac
   <4>[  619.449852] Call trace:
   <4>[ 619.450219] do_sve_acc (arch/arm64/kernel/fpsimd.c:1402)
   <4>[ 619.450983] el0_sve_acc (arch/arm64/kernel/entry-common.c:133 arch/arm64/kernel/entry-common.c:142 arch/arm64/kernel/entry-common.c:550)
   <4>[ 619.451394] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:0)
   <4>[ 619.451849] el0t_64_sync (arch/arm64/kernel/entry.S:585)
   <4>[  619.452333] ---[ end trace 0000000000000000 ]---
----->8-----

The full log, reproducers, artifacts, can be found here:

   https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2bgeMqo59p7kgw5dKw0m5uNegzy

Greetings!

Daniel Díaz
daniel.diaz@linaro.org


