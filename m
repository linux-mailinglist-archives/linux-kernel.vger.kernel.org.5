Return-Path: <linux-kernel+bounces-65386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ACD854C37
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C513728CB8D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062705C5E8;
	Wed, 14 Feb 2024 15:10:52 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336DA5A7AB;
	Wed, 14 Feb 2024 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923451; cv=none; b=b06W402VNDbqUgUwCh10GXQ3dV0M47T3pnJgUmVTsAETKdIbX3jMZhYmFUuxXKn8tdJKW+D1rMJAKnXOk1xNWeKzHIp+ScfNp7LDU7J+oyt6XNhUu81CzKH/9IaNuE3ELSYtkaGU5jkyLWAx/93/DVNDUBKjmndxhb45lPRAYSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923451; c=relaxed/simple;
	bh=3A1tr6ddj4x++YoCIZGrOZCWzZE1imB7GaGMVd+favc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GqJwMJyJsM0KurWKBPuldeSi5GvjQVIj6tkksl/LBGc7Fy2ElfU5nIiQoQbxT6+HXjSXBXZh4Y/09Ym6gue38vpHc4vz1UIHLfuTQI3qGe/TUCSTNGmcteP3Pe5OY4K39F6x2NQONyJuLDq/6HdE4EmV5S6aGvJt6bMEmqMbVr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5aea4b.dynamic.kabel-deutschland.de [95.90.234.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7B4B461E5FE01;
	Wed, 14 Feb 2024 16:10:34 +0100 (CET)
Message-ID: <0eba23c7-f62a-4a85-a383-60dec9d198f9@molgen.mpg.de>
Date: Wed, 14 Feb 2024 16:10:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: =?UTF-8?Q?init=5Ftis=28=29_takes_50_ms_on_Dell_XPS_13_9360_?=
 =?UTF-8?Q?=E2=80=93_almost_10_=25_of_whole_time_until_initrd?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


Trying to optimize the boot time of Linux on the Dell XPS 13 9360, 
probing of MSFT0101:00 takes 52 ms, making `init_tis()` taking almost 10 
% alone until starting the initrd:

     [    0.000000] Linux version 6.8.0-rc4 
(build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 13.2.0-13) 13.2.0, 
GNU ld (GNU Binutils for Debian) 2.42) #20 SMP PREEMPT_DYNAMIC Mon Feb 
12 09:40:49 CET 2024
     […]
     [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 
06/02/2022
     […]
     [    0.320057] calling  init_tis+0x0/0x100 @ 1
     [    0.332190] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 4)
     [    0.372164] probe of MSFT0101:00 returned 0 after 52101 usecs
     [    0.372186] initcall init_tis+0x0/0x100 returned 0 after 52127 usecs
     […]
     [    0.588643] Freeing unused decrypted memory: 2036K
     [    0.589068] Freeing unused kernel image (initmem) memory: 3976K
     [    0.606115] Write protecting the kernel read-only data: 22528k
     [    0.606527] Freeing unused kernel image (rodata/data gap) 
memory: 276K
     [    0.652327] x86/mm: Checked W+X mappings: passed, no W+X pages 
found.
     [    0.652329] x86/mm: Checking user space page tables
     [    0.695968] x86/mm: Checked W+X mappings: passed, no W+X pages 
found.
     [    0.696104] Run /init as init process
     […]

For users, where boot time is most important, can this be moved out of 
the hot path somehow?


Kind regards,

Paul

