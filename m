Return-Path: <linux-kernel+bounces-57402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F23584D7F7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27939287629
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756CC1D525;
	Thu,  8 Feb 2024 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="1rFqLYfK"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3F61CD3B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 02:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707360463; cv=none; b=ZDXC5QrEA/jeOFk7BlGZKH+ikx4qhBoJ6RicCapF5XKEhjAYRQjOVshTGFLImuPwWi/0QMY15VJGgq19lbJGGkQ46T0F0LD+exC6esm1a6Vn7eKsv4EHS+m/hGNrIpIg0VtKXU7EIfmgJU8dK4yJKZSfZsXh6W1DxVsGDDJww2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707360463; c=relaxed/simple;
	bh=MK76DvHni7iW6Jm9pZscOdxTC14rov0rPpzyV+KhtIU=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=BVRnOzP6gkUA5e2v01EjJTs2y2gXATj8YsSd6X64M390a5NlFX5woxleDMi5swvd08YqbjVFozeBNN+4TiNs8Y/5Xzah9CktVFm6SSGvsYS/XCcU31vFg2HOAMmvq9cKeKPgwpTS/HRXoq8Ori6nYG5PjMC5TpDYV4mBqWxrh+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=1rFqLYfK; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bbb4806f67so941556b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 18:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1707360460; x=1707965260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0iq8cRJkj/2hm4TS0USuQqVEylYWKy8V5m45mzf9FJM=;
        b=1rFqLYfK0o04y64bu/H5z3ySITQpkQuiXwHAzaPPWXRKtbR5ecSMQWUZWKPEg+njeT
         OVMeC4ulioJEFwvw29P+q0W4AcEefBBMtM4uA+PfcqrgwtQ7ldS2NLRpMAUgoGQd2TAd
         W/R0vS/ScMcJ6SVDdpU1aa1oOHAeqBdWKmPyQl7FbID8J+SUx6VYpYWCPMIPZLKmevGt
         rfH2PiejTABx9HFUesse7ZHr8uL0dGmc16fMI6jGUYDMeaE4goJUbvhet0qkByRrLTSm
         7r550+dwzj4MEYS4aH0NFGU8y3yibr/MA8EtBne0u2j+mDl2iEgRgb1W+kTxaUq8scmC
         NdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707360460; x=1707965260;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iq8cRJkj/2hm4TS0USuQqVEylYWKy8V5m45mzf9FJM=;
        b=Z0jPKJKxsPfnQjye1x91lH6tHuTbWO1wRsWNlZJBYUBMqVsjXX5JCaToAgaX9QZS56
         wkjgwG0e4DtwYKeds4g+BWnafG4Rm3GeV0bZnAKqoxGokVI6z9ZgLzaJ6eDsvQ1ffETn
         mIXuSjEEDXGL1YnG0eoGa+f0OM5ynLssc27cyWfxO6qfZ98JveKunZOILIVhvAjYk2GD
         26N2EaL3RIexuu4bhjPm24zoo74RoeaqgI5RhuywyHSt9k3y3YqWKqyLTSx6i3/pXTMV
         ko+inpwVh74zuktIsRS4hPl0amL4WN7UO7Zyr9Ei2T39FKn4gXweXEfPilndg3MkCovC
         MN/A==
X-Forwarded-Encrypted: i=1; AJvYcCXnKsrixGgLv+0OfoLi0r/ZGtSwpr0jYvdkDAjuh30UTrfgmZICSOXasYIV16DuLoeQQ9a11ky/s4KVzje0x7j7nnyBvzHumV5rM3lq
X-Gm-Message-State: AOJu0YyTRifmy03xT4720sF/9VZUtw+7y/25XCDZoui5fPgOZrvqP9N0
	CYnlLHtEWnf9FoR4ZCqFvCbYxoF9HjmVT+u15OU3FRCZ63sjkldPSQR38ySbTGy/QydP4eGln/3
	3
X-Google-Smtp-Source: AGHT+IFUbgMtRmLoM4JP4qOx2jVNkH61Uehs1tay1NhFzV4whTXYeTv64G+5s1YTdluJGfoKAm7dmA==
X-Received: by 2002:a05:6808:1a04:b0:3be:24d2:6d74 with SMTP id bk4-20020a0568081a0400b003be24d26d74mr8040618oib.38.1707360460304;
        Wed, 07 Feb 2024 18:47:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkCt3S09kDcU8uWirtmwpuc8fI+9UPxZbKNaSJl0hV+RJHa6Wt9EWLb8CQOMW8nF2BsTgvQ09ClNk8JrcpQrBhGCbEIXtlUdwdzdz2Iddij5Hr/y/e7HDZ9hI/VS8FbGfcrmMPpxdH9i3EldrMPFJqwNNw20GLGa3J64wGYKppYA48nxogkkALaAe3EgIjBQ==
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id p17-20020a056a0026d100b006dde1781800sm1812370pfw.94.2024.02.07.18.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 18:47:39 -0800 (PST)
Date: Wed, 07 Feb 2024 18:47:39 -0800 (PST)
X-Google-Original-Date: Wed, 07 Feb 2024 18:47:37 PST (-0800)
Subject:     Re: [PATCH v6 0/2] lib: checksum: Fix issues with checksum tests
In-Reply-To: <622b1790-8abb-463c-b6f6-9fb8b4a739cc@roeck-us.net>
CC: Charlie Jenkins <charlie@rivosinc.com>, akpm@linux-foundation.org,
  David.Laight@aculab.com, linux-kernel@vger.kernel.org, lkp@intel.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: linux@roeck-us.net
Message-ID: <mhng-908111c9-c8d6-4adf-9d44-e704aa794efa@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 07 Feb 2024 18:44:42 PST (-0800), linux@roeck-us.net wrote:
> On 2/7/24 18:09, Charlie Jenkins wrote:
>> On Wed, Feb 07, 2024 at 05:45:22PM -0800, Andrew Morton wrote:
>>> On Wed, 07 Feb 2024 16:22:49 -0800 Charlie Jenkins <charlie@rivosinc.com> wrote:
>>>
>>>> The ip_fast_csum and csum_ipv6_magic tests did not have the data
>>>> types properly casted, and improperly misaligned data.
>>>
>>> Neither this nor the two patch's changelogs describe *why* these changes
>>> are needed.  They merely assert that we need to do this.
>>>
>>> IOW, when fixing a bug please always describe the user-visible effects
>>> of that bug.
>>>
>>
>> I can add a description that says that the tests are being fixed because
>> they caused failures on systems without misaligned access support. As
>> for the casting patch it's a bit less pertinent but I can add that it
>> allows the code to pass sparse checks.
>>
>> - Charlie
>>
> I don't know exactly what Andrew is asking for, but maybe including the
> error log from the failed selftests and/or the sparse errors would be
> sufficient ?
>
> Not sure though if any of those count as "user visible".

Ya, for compiler warning/error workarounds I usually just include 
something like "without this, I get $ERROR".  Something like 
28ea54bade76 ("RISC-V: Don't rely on positional structure 
initialization").

For the aligned access on there was a fairly interesting discussion on 
why this hadn't tripped up before, I forget if it was on LKML or IRC (or 
Slack or just in the office).  That's worth including...

