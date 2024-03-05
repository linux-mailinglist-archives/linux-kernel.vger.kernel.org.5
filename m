Return-Path: <linux-kernel+bounces-91483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E800B871234
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A061F21907
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2126125C1;
	Tue,  5 Mar 2024 01:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPA66ciG"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503E710949;
	Tue,  5 Mar 2024 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709600796; cv=none; b=SdiOCmhCMIVzXAFKqYtUi0f51NgkgyQ1wv0F8OkdMPXfnDjS1cKYkiYutmR7w+yLpf/jDY1lGDY/RCrMAYuevo3M6ndB6PZ4m2wtgqX4Ng142i2aAAvXmpXxqgXvKs8povl8Kc2p0NMQBfXLrZ1jhsK6mUSfZ+cYpniXv4/4jyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709600796; c=relaxed/simple;
	bh=cQCRo+Wv+HOwMH+PV6D9rsq03fTP+dSaHgddNObywro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8fTJaKw3A4yyypBhEkmWH+ezPK7iJuvQnxSxdVUpbA6qvu9JeJJhVc4pbpUrDILscCibN5aXORN5nIF1kgfxlXiaCXk1jDU2YHm1ZNpKLh0kD2pRDe3icNHBfPF/mNxuOWOxOC9miE8IsK6sx1OyZnMcFlGhXbOod6KxE6ByiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPA66ciG; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29b42198c1dso1124160a91.3;
        Mon, 04 Mar 2024 17:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709600793; x=1710205593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh48g1IXDkz3oP+XbtshGQjif6bNyT6W+lSLVq2O+HM=;
        b=IPA66ciGU197488lVOKNbQPsed2L1UDaFehPcIcD2jqf+vH3EpdR6hVRGhTQKNnABD
         7V78/V3z9r8RiZezmHHrtE2mHlZLhumuTPTElH4Rr1/SeYU5PVJoO9Sho6s6wm5M7d+2
         dGY85ysLPY9zRHSv1IbLObO3dnKI9C6BJZ8nqp0HOQp05NIVxdRU1ABiWLr9iTVJZj4q
         Fx+z4aTqZxgo+IZ4aQwFK367j/4kFqOlZH5QpwuWca9+0kSfsFby0VKUbum1zaiGWnUD
         tSX4A65GCpIkbXm+IqRA3jxqetKm80AfwcoQVGJK890vpbokE0oTsXLwqtCU4xFSMrQP
         iJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709600793; x=1710205593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yh48g1IXDkz3oP+XbtshGQjif6bNyT6W+lSLVq2O+HM=;
        b=L2b1YOJ/EHkauyIGdnCDBWTcmMHLDG3xC03x2CQ6rpw5fO/JjScQeaSdKLx8bCpOPU
         KPuViymPrVIA2wPT6S0Z1pwhszUYzMfC9t4Ew6om40OzN1VaSNfBKovV3h88SE18RkPh
         IuIQ/nhIennIOfe3Gku1LQX55qzvUN37PYF+ENVEAVk5WUDIOOJxsqTsUQlkU+IUhdVI
         i8CcCRRUSKNwHNA26/SRxoXep7ZDPzew1KzLr9Dxr9rVxYr2xuWizCZrQfjycuRep3ID
         jeKPBPVkI5d7ZE4xabbcYxX7IMgLOMIFiaLSvcNsFtk0NmD5PNoupIxy0NRu4YrPrUjy
         w1kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXAqrj3bvRfA6JpSzlmn2ZBgWsB/agfiv8ZxdiCyVZDKFnLcNZ08Y7r8n8am7G5JT/kTxFRcpfmDUlK4Fk97OQjg8GhI25o2vHR9XHNsz0rX6ZM4OH0z7TblIuL7sO5iKSvo+w
X-Gm-Message-State: AOJu0YznmZzt8FHcUb6LBYUjci4sdS0lxIhz1Y8g3hE4Tnr3AaxpcWbi
	7y0SaF62pjRNPeu29GRr7cEsaQBap8M5zx7DI1Cn54bRWpViZEXD+X23sOXaNeTwOwPQXYdwmWp
	QwFXLPfKRrVUrvlVfYIGZkWq5uEM=
X-Google-Smtp-Source: AGHT+IE4NLwh8x7jkAD5qeEydFjXAvMqjpo1AYsohti1aJ34BobyyvHRtsg9vDMC6fL2JjEowvp/KEyN3vfinKM5lRY=
X-Received: by 2002:a17:90a:ea87:b0:29b:41aa:1673 with SMTP id
 h7-20020a17090aea8700b0029b41aa1673mr4128895pjz.23.1709600793370; Mon, 04 Mar
 2024 17:06:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211549.876981797@linuxfoundation.org> <20240304224858.73401-1-sj@kernel.org>
In-Reply-To: <20240304224858.73401-1-sj@kernel.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Tue, 5 Mar 2024 02:06:20 +0100
Message-ID: <CADo9pHh4Xk8dzehYQnOpqNGx4QyGQzgUKgBtGWnZuLqPeyWi5w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/143] 6.6.21-rc1 review
To: SeongJae Park <sj@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Den m=C3=A5n 4 mars 2024 kl 23:49 skrev SeongJae Park <sj@kernel.org>:
>
> Hello,
>
> On Mon,  4 Mar 2024 21:22:00 +0000 Greg Kroah-Hartman <gregkh@linuxfounda=
tion.org> wrote:
>
> > This is the start of the stable review cycle for the 6.6.21 release.
> > There are 143 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.21-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> > and the diffstat can be found below.
>
> This rc kernel passes DAMON functionality test[1] on my test machine.
> Attaching the test results summary below.  Please note that I retrieved t=
he
> kernel from linux-stable-rc tree[2].
>
> Tested-by: SeongJae Park <sj@kernel.org>
>
> [1] https://github.com/awslabs/damon-tests/tree/next/corr
> [2] 5f9255b6ac45 ("Linux 6.6.21-rc1")
>
> Thanks,
> SJ
>
> [...]
>
> ---
>
> ok 1 selftests: damon: debugfs_attrs.sh
> ok 2 selftests: damon: debugfs_schemes.sh
> ok 3 selftests: damon: debugfs_target_ids.sh
> ok 4 selftests: damon: debugfs_empty_targets.sh
> ok 5 selftests: damon: debugfs_huge_count_read_write.sh
> ok 6 selftests: damon: debugfs_duplicate_context_creation.sh
> ok 7 selftests: damon: debugfs_rm_non_contexts.sh
> ok 8 selftests: damon: sysfs.sh
> ok 9 selftests: damon: sysfs_update_removed_scheme_dir.sh
> ok 10 selftests: damon: reclaim.sh
> ok 11 selftests: damon: lru_sort.sh
> ok 1 selftests: damon-tests: kunit.sh
> ok 2 selftests: damon-tests: huge_count_read_write.sh
> ok 3 selftests: damon-tests: buffer_overflow.sh
> ok 4 selftests: damon-tests: rm_contexts.sh
> ok 5 selftests: damon-tests: record_null_deref.sh
> ok 6 selftests: damon-tests: dbgfs_target_ids_read_before_terminate_race.=
sh
> ok 7 selftests: damon-tests: dbgfs_target_ids_pid_leak.sh
> ok 8 selftests: damon-tests: damo_tests.sh
> ok 9 selftests: damon-tests: masim-record.sh
> ok 10 selftests: damon-tests: build_i386.sh
> ok 11 selftests: damon-tests: build_arm64.sh
> ok 12 selftests: damon-tests: build_m68k.sh
> ok 13 selftests: damon-tests: build_i386_idle_flag.sh
> ok 14 selftests: damon-tests: build_i386_highpte.sh
> ok 15 selftests: damon-tests: build_nomemcg.sh
>  [33m
>  [92mPASS [39m
>

Works fine on my Arch Linux server with Intel(R) Core(TM) i5-6400 CPU @ 2.7=
0GHz
after the Arch Linux manual intervention for new mkinitcpio settings
and version in Arch

Tested by: Luna Jernberg <droidbittin@gmail.com>

