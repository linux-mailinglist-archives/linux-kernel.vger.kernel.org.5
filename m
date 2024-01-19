Return-Path: <linux-kernel+bounces-31498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B59832F08
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A7A28814A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8150E5646D;
	Fri, 19 Jan 2024 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OAXOKUh2"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F9E56453
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705689565; cv=none; b=o0cTFWbpwtMIfuVAchuoWg3MiriMWzq/dX0YOLKPCFbMSmkA7KuQClwj2uvt4u5eplX3tbU1v38lvOMXY4huulHKJnUBdyG2uydH3ZLBms87njsfcc7syb2DjZzQ9yJUhxHGQ9sI//YDHbRdCnye8YcnZRXppIVMSRsXazUEVkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705689565; c=relaxed/simple;
	bh=KPBYnvXs+bRh8VQUcF3cGEvDOy/UxtfQJY6XAedGMkE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=DsvPy6zhRujwlfhnsjuHe3/pHeAkktoBt7qo1PF7JieOeCaErtha50aalZA/8xDbHOt9E7Z44f/sJaILFlm+hsombkc64YKqAkF8oICesnMJ/vevhCM+hDXz7fl+IdJrnG3kPDCRhwUSXAoLZJL3ZLjdkcuRRqW/bt1gZYoC81s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OAXOKUh2; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7bee9f626caso15518839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705689562; x=1706294362; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YqF9VDWGaS4VlQNR7o2au0lZg/1V8nOrIBJo7jDbbk=;
        b=OAXOKUh2tLnEJ/7cQFrpSvVdQcql8RO27m8kReJn8sy8qbYp3kJq7bLIfx+TYln+No
         Iau6brV/T/aQWw5ymKtNX4jyqXQmyt44roXdbjPJf2ht7hVTBiBVPSOIi4PFhKDketfI
         /gEM7gSBbtQPtiuT4p5KJQe+7aFj3fIowKuoq2idrnrQJyb6ofODjgfMm8pkAEOUds6y
         G9DGdcNMpEovHpRwVu8JOQzJ7XBMrA9LAPViJCWo5MSBwiNejijM0UoFfUethkRaAA0n
         M0gAN+Qt07SFImJqioe2TKfFETgeKfYhInSDhSiDiYMCPs6PUDHgrx1F1bunZ/o7hjUu
         3ZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705689562; x=1706294362;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3YqF9VDWGaS4VlQNR7o2au0lZg/1V8nOrIBJo7jDbbk=;
        b=DtbR6ChrArJmPGOh94TeYQ1DNr1yfvTmfGQjBP73uJ9u1bcgcNAhHluG6XPcB5wjlU
         VaZlpEnKz2gsdRIw+vLJjf8/gAS/tUleGy1Gv9LSW6IPies8LW2kFgu+CJ+FISj8ouj+
         jTxE7+B97L6v834sraIoEOiHaZsg26cZDMnMoscrRB/0QBGhSZ+FbQokYBB8lExtWKge
         yYPchMPP+WroQ0Bg+CQq4nNnCdg+U3YTvvgqvHvTHDRskH4f6utphiZ1wArCB+ITW7wP
         vz2qPITs8pMFJsm4/IgaEEQDuSIKBv6RwI1M/PolbCZB/MRrQ9iH+Y7Yuq/Ao73Tczg6
         VvPA==
X-Gm-Message-State: AOJu0YwhdSWEji8QvddfTLqyJ5rKgPb02LjoZYmV8GXbUe0qzeLU/7dy
	xh3tYd+vGFOWG0o9RhRjBO9D5wFVniWkH6sO7v6OtTTUkXBA8Fv+Je9231t4r1dTlsnxAvOn3UX
	5D5w=
X-Google-Smtp-Source: AGHT+IG/wN6lTQv3q2R53igCCDQ0O7n9t9yzniyNiXLbO+u1nKR+CX6nGMNXevdX7msmrrgcagZdzQ==
X-Received: by 2002:a92:c549:0:b0:360:7937:6f7 with SMTP id a9-20020a92c549000000b00360793706f7mr570951ilj.3.1705689562493;
        Fri, 19 Jan 2024 10:39:22 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bf7-20020a056e02308700b0035fabab7985sm5669677ilb.21.2024.01.19.10.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 10:39:21 -0800 (PST)
Message-ID: <05ea3233-20dd-4af7-86cc-de11ad2efe84@kernel.dk>
Date: Fri, 19 Jan 2024 11:39:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 avier Martinez Canillas <javierm@redhat.com>, Helge Deller <deller@gmx.de>
From: Jens Axboe <axboe@kernel.dk>
Subject: REGRESSION: no console on current -git
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

My trusty R7525 test box is failing to show a console, or in fact anything,
on current -git. There's no output after:

Loading Linux 6.7.0+ ...
Loading initial ramdisk ...

and I don't get a console up. I went through the bisection pain and
found this was the culprit:

commit df67699c9cb0ceb70f6cc60630ca938c06773eda
Author: Thomas Zimmermann <tzimmermann@suse.de>
Date:   Wed Jan 3 11:15:11 2024 +0100

    firmware/sysfb: Clear screen_info state after consuming it

Reverting this commit, and everything is fine. Looking at dmesg with a
buggy kernel, I get no frame or fb messages. On a good kernel, it looks
ilke this:

[    1.416486] efifb: probing for efifb
[    1.416602] efifb: framebuffer at 0xde000000, using 3072k, total 3072k
[    1.416605] efifb: mode is 1024x768x32, linelength=4096, pages=1
[    1.416607] efifb: scrolling: redraw
[    1.416608] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.449746] fb0: EFI VGA frame buffer device

Happy to test a fix, or barring that, can someone just revert this
commit please?

-- 
Jens Axboe


