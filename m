Return-Path: <linux-kernel+bounces-145696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F0A8A59A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206711F22BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766D813A89E;
	Mon, 15 Apr 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="e+DlGRPF"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A6139CEE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205203; cv=none; b=QVU4sgNelyHAT/Rf3IWeaC9hDrDpZFTeVD0kQgPEUvORcW8oJLQjLxtyVEZ+SdJzb/g+Ib1Gp+uikfkb7XZ6agRKHofPZjKZt4U2hHTu0TaBGc9wvFn4Ci0xW6g+11rCmnzDL44dKo410qWTXtxCpRQgE/eFxNSVM+YxnkYXGo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205203; c=relaxed/simple;
	bh=6bK9/EmLtsGWBkVVtivqidNz/Hm2f1PhZTOetEUlll4=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=fElOGqDrQccDuJbEpkdGaBg8R6vNGSnwyEq11gv2NSGyAkvv98cuR3Brvs31qlcaH4xSL5JIHt47Ff7V+ghV+sRI9FreIKzjExkGQi2688Oxu4Ewy7+cl7R7S2q9Vf6ej6Ao1zKXXrjQxeFz202cyKmwhlLul7O00ewDIHXbZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=e+DlGRPF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e5c7d087e1so20318125ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713205201; x=1713810001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMYfsNuUq9BKvqfKjhxnbpLMRwsgeNj3FevT6pUpzBc=;
        b=e+DlGRPFoGfqrQNnLCrhoOEIsMRLgVpmuZQuejIQuELfnDQh5ERKyLn2bJp70pJGPU
         fZJ6voM2Vq55AhXYqmdDwxsN9m1u8OlPuEBUkPFtQPngYnLMp7+7Wff85dQWrf3vYBAP
         PEwWttYXotfByQPfQaXO+YGUmSu1M8thlHiXwKSmQafrzjQfDpFlnqcFOeze7ARnE/kF
         94Hu6tM7fWbGgxSaUlyIom7ZLF3w8M9zLapkTInu2bmvYnNL1AvncLHsnBCBXZckXcV3
         mxneJrmUOYv9PBW5Ip3LAu/e1C9fxb3zD2HqLH3qSxtlUuPHPIn0dlnwZezx4ZBkX+f1
         9yQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205201; x=1713810001;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMYfsNuUq9BKvqfKjhxnbpLMRwsgeNj3FevT6pUpzBc=;
        b=wZKg3qHadKRHgFD1/IS9LEG9lpbLf1PdOXd6gKT3Ix5x/G3aA9FXCj6leCPoXbA03z
         l7a2YAQEyC2LuFeMRK6VIms61hBsl5lpGL7K9jOrNK6xbMY63iwkB7iBgv2EoZymB025
         rjtA7P/OvO6/GoUOXHk2QG6pJ+Tck8UNyQaJ7rrDZypY5LS8OZGQSBeQgO0loHXvh+Ix
         UbSpo7chuZ52SJRUYoiEnOUqGtGWINVou6XziMBil9aVjGYzF4wXs8oWsiibJ2JAVvEt
         Lwt5T3O4B+34zt/aFaoL/t78XjBOtbSau451BlxGsG8F6QEEmV1dzV4xUQN9a0NkyXF+
         5sJA==
X-Forwarded-Encrypted: i=1; AJvYcCXqhhKAfMlU2LXRMjfAqHRID3B75xVJXlhwUZLzVaQHbCrn+gwP6pzLVyJb8HFEF3UrzWoUVP55+0aeezrGF0oqVndenfjBRYR3BA+R
X-Gm-Message-State: AOJu0Yzl4KrnUdOKBJXgwvn2LjABbfvoi8A2NczNSdtSgigkuAf7MfQQ
	2cYYr/JVHWDoiNjzY92C3lKYPGX9LcPm44matF+RGotNl3yr8jo7XQXiAjUJvmM=
X-Google-Smtp-Source: AGHT+IFzrfkhu7oRgAgzvuYnIB9eEmIOMjOJI5EU0J1KJYpJ0UThV3k2FZqv7S67F8Ljyu0GZ8zduw==
X-Received: by 2002:a17:903:11cc:b0:1e6:34f9:f730 with SMTP id q12-20020a17090311cc00b001e634f9f730mr4247720plh.52.1713205201209;
        Mon, 15 Apr 2024 11:20:01 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id kz5-20020a170902f9c500b001e7b80b7c82sm412788plb.283.2024.04.15.11.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 11:20:00 -0700 (PDT)
Date: Mon, 15 Apr 2024 11:20:00 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Apr 2024 11:19:57 PDT (-0700)
Subject:     Re: linux-next: manual merge of the rcu tree with the risc-v tree
In-Reply-To: <b147ca95-c0e2-4729-b670-a1ee605369d2@paulmck-laptop>
CC: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Walmsley <paul@pwsan.com>,
  leobras@redhat.com, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, yujie.liu@intel.com
From: Palmer Dabbelt <palmer@rivosinc.com>
To: paulmck@kernel.org
Message-ID: <mhng-4dd659ce-865c-48c8-bf51-397804035d60@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Sun, 14 Apr 2024 21:44:10 PDT (-0700), paulmck@kernel.org wrote:
> On Mon, Apr 15, 2024 at 12:32:47PM +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the rcu tree got a conflict in:
>>
>>   arch/riscv/include/asm/cmpxchg.h
>>
>> between commits:
>>
>>   07a0a41cb77d ("riscv/cmpxchg: Deduplicate cmpxchg() asm and macros")
>>   54280ca64626 ("riscv/cmpxchg: Implement cmpxchg for variables of size 1 and 2")
>>
>> from the risc-v tree and commit:
>>
>>   b5e49f1af563 ("riscv: Emulate one-byte cmpxchg")
>>
>> from the rcu tree.
>>
>> I fixed it up (I just used the former as the latter seems to no longer be
>> needed - I also undid the change to arch/riscv/Kconfig from the latter)
>> and can carry the fix as necessary. This is now fixed as far as linux-next
>> is concerned, but any non trivial conflicts should be mentioned to your
>> upstream maintainer when your tree is submitted for merging.  You may
>> also want to consider cooperating with the maintainer of the conflicting
>> tree to minimise any particularly complex conflicts.
>
> Agreed, it looks to me like I should drop my RISC-V change in favor of
> the native support.  Please let me know if I am mistaken.
>
> If I do not hear otherwise, I will pull my commit out of -next in favor
> of those two on my next rebase.

Sorry I forgot to send the shared tag.  We can pre-merge if you want, 
I'm fine either way just let me know.

>
> 							Thanx, Paul

