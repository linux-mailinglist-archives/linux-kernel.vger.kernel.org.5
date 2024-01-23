Return-Path: <linux-kernel+bounces-34620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385B383842B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FA329840D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE01E67E9D;
	Tue, 23 Jan 2024 02:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="A3mfkw5u"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC6467E91
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975318; cv=none; b=du29g2tOEcGTyKHO48h1ZtLe4s/FkeJMMSTbld6JvifdF9eb6czDvgmcgp5GiX0vxMFFkMRJ7MhsYsSgVFhxx/HMqWvX4EiUQoLboCegwex/zamqE0dRGXcpMeomq99/WaCLUhuKFcCDZq9H9V8fH2dK48a3fwgXrEA+1kIf0H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975318; c=relaxed/simple;
	bh=FVNYP8JfoSdaqbA74w1z4SHSa2bTCKMOqhNLl8AfhxM=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=GUFDQhDsujSLvPF+ndz4vE8qm5cwftQPBuoG8A/2Anvm5q1uwDDhn9L7xWuBHvql5em05X+RcOqzy9xEg4iObQzFDT3SgoVsuLM/LJTC7T2nZRaaFOEW9pgVZliovsCso/bHzeXk9Fp4uX1NMJwcnPgDb/Tmml8KL0nJ0HjMcyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=A3mfkw5u; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ddee0aa208so2701560a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1705975315; x=1706580115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91+TcT5wXxz+6ZAfNQ55hsyl7IKvd4OOiIR66plDFoI=;
        b=A3mfkw5uBHFzdmKCJSZrBCLfIYeirRF7ZThnkRnG5rIJkaIX/MAKvruzlXDjhHy4nB
         WW0Km6wcE98Z2/Oad8rcG2zrRjUQ/rjSq18vrotIshf807/GT6eqwsdh8l+CtXRM0fuq
         cb3aGkbl4hWb8tGNNe4WaQmuJVldsdNvvUPP8M4fEZy5cCj2kvYh1DC4zqrmIm1YcLRW
         FnM8IE4XdLxcdfHZnevbFzNw+ypYM1uWQdhEUlCtM7rr373visiNszJJotLKpKUkdVQl
         VhSxiaDlwu28IJr6zPkTIWnJKenHXHRXJju3XJq4cmeqhBd1CMj6cxZ9+6tn+GESc/P1
         yPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705975315; x=1706580115;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91+TcT5wXxz+6ZAfNQ55hsyl7IKvd4OOiIR66plDFoI=;
        b=kfU41TmK+P7L+/T9eW4DfIXmruAKwCUkUyPexoc8rec8LGQgW3lLKlkyCb7RH7emr6
         tha3IgqBENXzZEieRIYXkAdbxVcd0fK6+vF0yx9+WdwkWrsxPChpmfSMX2B5aMe5/AZC
         DrAf41iQ6z0vICFK4pqy9mkAhuRDWz9CymjgPULxIr8YIOX+kygr/p1s3kCLIP3wnDAA
         lgpMs2o2MnYD7S5mMos/rrlGULCmY7QdOMLDF/NiIADDhgZ8xORifdxsbe1tcNAp/ESz
         uscR/SNaTx+wOx80COeoRQ8sYcRbSZZGg+afA1iE2IGvwNPbLpDGRHtvH37BZT/F8zEy
         bncA==
X-Gm-Message-State: AOJu0YwPVq4rEAV1xmEkRCGU9CG5IZdLzZ8L4uHq2fMI3WGD4xUGipE4
	pdzJ93byrvAuyT7LxYN8rFvUGPLsHNriFPXssiHmlPGiQizJBPcVybpInR2e9Hg=
X-Google-Smtp-Source: AGHT+IESW90AYBQosWUrRQ4cqcsVqGDQjIXW7uRC4UGcFqiR9D5hAMz3HmcEAMTUdoKOolEo1uL7Rw==
X-Received: by 2002:a05:6830:3114:b0:6d9:d786:b260 with SMTP id b20-20020a056830311400b006d9d786b260mr7024435ots.60.1705975315530;
        Mon, 22 Jan 2024 18:01:55 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id j19-20020a635953000000b005cfbd4b3cffsm5280084pgm.16.2024.01.22.18.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 18:01:54 -0800 (PST)
Date: Mon, 22 Jan 2024 18:01:54 -0800 (PST)
X-Google-Original-Date: Mon, 22 Jan 2024 18:01:53 PST (-0800)
Subject:     Re: BUG Report: Some issues about vmlinux with emit-relocs
In-Reply-To: <mvmcyymxh8f.fsf@suse.de>
CC: suagrfillet@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, anup@brainfault.org, alex@ghiti.fr, Conor Dooley <conor.dooley@microchip.com>,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: schwab@suse.de
Message-ID: <mhng-b104f14d-b712-4ad4-a981-b38c07b4b106@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 13 Sep 2023 07:47:28 PDT (-0700), schwab@suse.de wrote:
> On Sep 13 2023, Palmer Dabbelt wrote:
>
>> Having R_RISCV_NONE in any binary is a bug, it's not a real relocation
>> just an internal binutils thing.
>
> That's not true.  It's an official part of the ELF psABI.

Ya, sorry, I got it mixed up with R_RISCV_DELETE.

