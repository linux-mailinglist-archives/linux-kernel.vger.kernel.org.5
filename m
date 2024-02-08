Return-Path: <linux-kernel+bounces-58290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F084E41E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D314028919F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E747C6CF;
	Thu,  8 Feb 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="snWlvqd1"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EAA7BAE3
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406502; cv=none; b=BYhfr93vMRomPngFsX4QBMz7msjq+baVhPniMm5dXl91mmLl8yoy0Pb8Gd6KhWMagMYIaeGl6WmDE1oL2V6x7L90LqShovxTzxvQFCuFP/h7OFedexVRnOAueL9+19jHLsK6qjm/oSwwR+CXsxWSC5NDuwEVl5UnXqZiDYr+aU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406502; c=relaxed/simple;
	bh=t+l40GmP0QAn/4c0/ghq4xN+7pA+v/SJsg3gMQcxNKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHXtOevUKfuvtU7IMA7SCBzfBu5wgUDJxaitYYy9KVcXZmxiN9uBY4ZRsPGKvO9Pqs6uER14FyFMMMEJgqUKN73ZniqnbjP/Y2BE7QLKxto2wJ7ZDb9FrOtpD+MN3bQl4LXLdGiMasyMu0+rEchQ+RN9Mn1s/mA3dHeDiuO+Fg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=snWlvqd1; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c3d923f7cbso9947339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707406498; x=1708011298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SOzmztXeA4vVietcHAXayN5BtLIUIC76hlExobZmwgk=;
        b=snWlvqd1T8z3+zor2ShQGffMbJpYWT9E5A5+rVjO+RF+aGc5mCOOiStx6QFh2nFj2Y
         YCw0IkMVIeM/KEI3tVDg8wJCcf6qM87uMtqsXqL8E5kWuipryTSIltHDA4m2TZvt1Y3F
         6WkFAnGr0fWH1bzn15SNYyTgZUx/Q3Cs2Q0myLAIg7qNc3YTCRSKonDlFT9ps2+Aixi2
         3dm+B6sCJlmWRTABP13t2X508MNPaYlMvlMiwkw6gHdKsGqUC7HO6vTHqWUK0OChDLZ7
         7oH7D2cBtqfVGodXddOaaCVXNzMx1DIiQazaADQW9bpIxOF6eZZjFXbtzGdgjZKSDaUy
         hWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707406498; x=1708011298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOzmztXeA4vVietcHAXayN5BtLIUIC76hlExobZmwgk=;
        b=FJG3snuqYZ511Q4OR/wBodF8ZzsyUWFe/cJuKdoWMJ6t6NcBG3R+fely222SMv2WTB
         a+6uzksA8x/YP/jNSL41eSdQMj2IWfEGxX+15lwzgAw5UpNS6MoXYlAPQ71jJupXT+Am
         9WVIU6mM2hbQTWZ0SRRbkwjwbb4Psgdo3avPB3XyRDg5ADVenjaH2qmclO0WVqV6caJF
         3o4NRRmQoJBQAiGRPA/XfDPfQ3rqh7e7CHUcnIqTDIGEokxAsXj29eejkhDoRFAbblGU
         Srllq8NTuwuKZ5CbzS7R6lEepow+r2hNzymORcqRkg39/AW3CNe3byB378Wqe+tn/44T
         DlDg==
X-Forwarded-Encrypted: i=1; AJvYcCXCVba8Oxl50nBG7nSdHri2TFdf6A4aStiM2GdT61Krq7jiQLfNUqAlK9SBqCi1QRgnPGaAbBJ9ofrahnlxWZkQOij2jfdHwi4XAmBW
X-Gm-Message-State: AOJu0YxLrOZ/cdCm270H7u8rdkeq36Df1/JwvWHAXj1jrFriGebr/+49
	OEAb3PpJvV5J93aji8Hg2FV67qpUyII4QaTuniyhKSYNlpUBLMFnbi/Nuy5OOLU=
X-Google-Smtp-Source: AGHT+IHn9i2CgaP03XL4C5VjNlfh9cv9fEuXGoSUlZWXwvdVd3yXnN23oHf7awYJ910wLOD7Lx/Azw==
X-Received: by 2002:a5e:a91a:0:b0:7c4:965:f8c0 with SMTP id c26-20020a5ea91a000000b007c40965f8c0mr2635453iod.2.1707406498571;
        Thu, 08 Feb 2024 07:34:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWW8tQLvEMAj/grMaWGPmQmAMGh5cYxnsOdG4uvYmJGCac7GRDVOJwfsKEvGz5if4/9yK7dYDtf9hPPRJHxFXxok6n3WsgGi8Rt93Jbr8dfR8r5BFWHn4raXhpg0ELi/MDW6qFlWiHld0X8ST3xdEj8MJD90k5BfdHMdESgb5ezCJFiZJ73Wkcu5jPGJn6VoZL2QoxT3ia8K5jVSECD72xh0cWiqW2aLNuyUWEEYX7+tY0S86apKmV0QLNe+QnmRfovw3RbroS/7YZSVCMEgRWUZ/q4HVi8wj20nwAsj/ZP6qjCTVVNAw/gVlDJRIz3fGUT5ZzY6SqvXwo+6Y/0fo+MMHIZlWO6y2zi6BLpBQxip12WWosZI8dVjqWVbVpLukMN4N/2r4XoYmhKB5MaZRE0KVzTXeII7o7FaY1Cf8YcVzfvL5q/4r1fCqEqksHW3ZBD6sgFjJJvspuZEB97CCG8VXJulLewpMWAr6qkeUqFz2rayWGxLFUzcU0EVyt2yVroWvSQWpKVw7iMqJ4XF9T9Mq26D+TErzD3oLY1FPXiVkw=
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id hl8-20020a0566020f0800b007c3f4c29570sm987484iob.39.2024.02.08.07.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 07:34:58 -0800 (PST)
Message-ID: <051cf099-9ecf-4f5a-a3ac-ee2d63a62fa6@kernel.dk>
Date: Thu, 8 Feb 2024 08:34:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Coalesced Interrupt Delivery with posted MSI
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, iommu@lists.linux.dev,
 Thomas Gleixner <tglx@linutronix.de>, Lu Baolu <baolu.lu@linux.intel.com>,
 kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
 Joerg Roedel <joro@8bytes.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc: Paul Luse <paul.e.luse@intel.com>, Dan Williams
 <dan.j.williams@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, maz@kernel.org, seanjc@google.com,
 Robin Murphy <robin.murphy@arm.com>
References: <20240126234237.547278-1-jacob.jun.pan@linux.intel.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240126234237.547278-1-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jacob,

I gave this a quick spin, using 4 gen2 optane drives. Basic test, just
IOPS bound on the drive, and using 1 thread per drive for IO. Random
reads, using io_uring.

For reference, using polled IO:

IOPS=20.36M, BW=9.94GiB/s, IOS/call=31/31
IOPS=20.36M, BW=9.94GiB/s, IOS/call=31/31
IOPS=20.37M, BW=9.95GiB/s, IOS/call=31/31

which is abount 5.1M/drive, which is what they can deliver.

Before your patches, I see:

IOPS=14.37M, BW=7.02GiB/s, IOS/call=32/32
IOPS=14.38M, BW=7.02GiB/s, IOS/call=32/31
IOPS=14.38M, BW=7.02GiB/s, IOS/call=32/31
IOPS=14.37M, BW=7.02GiB/s, IOS/call=32/32

at 2.82M ints/sec. With the patches, I see:

IOPS=14.73M, BW=7.19GiB/s, IOS/call=32/31
IOPS=14.90M, BW=7.27GiB/s, IOS/call=32/31
IOPS=14.90M, BW=7.27GiB/s, IOS/call=31/32

at 2.34M ints/sec. So a nice reduction in interrupt rate, though not
quite at the extent I expected. Booted with 'posted_msi' and I do see
posted interrupts increasing in the PMN in /proc/interrupts, 

Probably want to fold this one in:
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 8e09d40ea928..a289282f1cf9 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -393,7 +393,7 @@ void intel_posted_msi_init(void)
  * instead of:
  *		read, xchg, read, xchg, read, xchg, read, xchg
  */
-static __always_inline inline bool handle_pending_pir(u64 *pir, struct pt_regs *regs)
+static __always_inline bool handle_pending_pir(u64 *pir, struct pt_regs *regs)
 {
 	int i, vec = FIRST_EXTERNAL_VECTOR;
 	unsigned long pir_copy[4];

-- 
Jens Axboe


