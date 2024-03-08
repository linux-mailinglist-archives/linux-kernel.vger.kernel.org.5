Return-Path: <linux-kernel+bounces-96554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76730875DF6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A351F21B45
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEA53613C;
	Fri,  8 Mar 2024 06:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZGO8D0A"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF16E32C89
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709879262; cv=none; b=rFKD8kAptFoxDyIRjHQq+BcTu0SnPD33bGOQBGSmEd3OaDRK9skUvtx6w39RiKQyilXAlBXkyndA1+BcgXUVeb8cZhOV0yEChnBpNwaRUJEfYKL8cjH/558XkIWfBuv6ibrwoKNyHjgkjEVgMGWvj/ouZW7bpdzgzuEmKiWu7q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709879262; c=relaxed/simple;
	bh=PWim9qCxnlV4pAI4jnDGKmSRCnuE2YFtgorJYA6Rk1E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=guJTMxktAALi2opufvAQ5Z8xQBRsazombtAkpMI8jo/iUXPHAPh0wfAdWX524vvNEcQ1ngReHSRvvkYT7GLVf0eb2sozM+ogihqwwj5V0jUX7RvlMla7FrsAMWrtmqCbx/d3LUgXtzkI5W746FxW9IwHr9/OD/jQeMrLqwXxrIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZGO8D0A; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d2fad80eacso5370491fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 22:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709879259; x=1710484059; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PWim9qCxnlV4pAI4jnDGKmSRCnuE2YFtgorJYA6Rk1E=;
        b=CZGO8D0ACHqjUuFClB4NqJJ4syTjDQuY0l7vDjggaYNspt+evTNO06gvu265CAXIPa
         IACAW7VlidSr2hfo8MVX8KzEVA5WD4IPdmVLUUYvPSQb7mFGBUcsLLk2HR408HLCjsZq
         md307yhkSh+rDwPT6OKe2fzxnUUfwJnWVkPuY4g4g5yyrkO4F+AQ7mpwOBX9v/VmDSD/
         VQXzSD6oUnH/JeAkFzEsk2x2dUbEnn6sEf1lxQGLyBQb15tV2Mu/8p3e6idalcwHFsLB
         GzD9dUU+Tje5CD7DhynKwCuzNPA8OgSPdb4SKCBjafdxcTI11xqCXMSK8/9C0trPfX08
         s+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709879259; x=1710484059;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWim9qCxnlV4pAI4jnDGKmSRCnuE2YFtgorJYA6Rk1E=;
        b=S/+f9U7B6qjoI3tJjefvgU0ZPJ0z9EGXEXAjPkaFmlPkIC0QzwsiYk7hhRr2RPm7i6
         66oQhyLDlu3UkeT4tsR+KPBtTg0sziVuTrOP9vSd3n2IU/4OPCV3j4P/LxUKlafxNUIt
         SkKtBqGwgJMTPEHIZDw83nCc+xl+D4AX8TDBSdeez2yUkejZ6QHy9CkT6L2cdJ/Pn/cr
         jy5uuwkHW/djevKIa787wwmUM8Pgo4/lAsQFR6edNDU2aPEDrhDloELgaPVCEnCP+/Ud
         439JRwW5ow4AF7wRnmo/JLL1fYEsOCajTbxSzq99yIGAevHWBs/xwipK3heXGj8maeCj
         t5Uw==
X-Gm-Message-State: AOJu0YwAmJg7Wx+p+HFhuPJdW8ctl00eGa0KJjp757HYi1D7eGYQkbpz
	kufULDQCdwydhPlH2H3rfBy+e0QrLv0mQMtXGwRs9gJKWFKgE4ciCJY3RdjkPtxsSDhHMGCg1MI
	rdqMrSZr+wE+GcGATHQHxBlxlF2C2bHuw0+s=
X-Google-Smtp-Source: AGHT+IGUG0Bz36CI1YkD+HQ1DeVsZGjfMPo53vZwlci8kAlSeOUyMciqNxRADSSMl9P5qMniZE2ksOVz7zDMDmcsubs=
X-Received: by 2002:a05:651c:314:b0:2d3:4c74:10cf with SMTP id
 a20-20020a05651c031400b002d34c7410cfmr2167522ljp.24.1709879258748; Thu, 07
 Mar 2024 22:27:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: hy c <harry.hycc@gmail.com>
Date: Fri, 8 Mar 2024 14:27:27 +0800
Message-ID: <CABAmdSf=wQn7qdjnEZTdQms9DNaE_PFxypsvX9ZG-i1EoUQQCQ@mail.gmail.com>
Subject: Subject: Inquiry Regarding Obtaining Mount Point Path in fsconfig Syscall
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Description: I'm developing a kernel module that includes a syscall
hook named fsconfig, intended for managing operations related to
remounting readonly mountpoints. I'm looking to extract the mount
point path within the fsconfig hook.

Specifically, when a user executes mount /dev/sda /tmp/mytest -o
remount,ro, I'd like to extract the string /tmp/mytest.

I've attempted several methods, including trying to retrieve the mount
point path from the fs_context structure, but haven't yet found a
satisfactory solution.

Methods Tried:

Attempted starting from fc_context->dentry, but the result was simply
"/", which didn't meet the requirement.
Explored using d_path, but it requires accessing the path structure
within the fsconfig syscall, which isn't feasible in the current
environment.
I also came across the __is_local_mountpoint function in the kernel
source code, which seems to suggest that iterating through all
mountpoints might be a solution. I've attempted this approach and
successfully identified the mount corresponding to the fs_context, but
there's an issue regarding namespace_sem.

Primary Questions:

1. Is there a secure method to obtain the mount point path through
fs_context without needing to modify kernel code? (Assuming fs_context
always corresponds to a mounted file system.)
2. If we can only iterate through mountpoints, how can we address the
challenge of not being able to access the semaphore securely?
Environment Information:

Linux Kernel Version: 6.6
I sincerely appreciate your assistance and support.

