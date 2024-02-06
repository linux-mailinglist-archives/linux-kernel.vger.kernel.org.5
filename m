Return-Path: <linux-kernel+bounces-55327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFA584BB24
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607291C24803
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D6BD51A;
	Tue,  6 Feb 2024 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pAq+m1hV"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A6EC129
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237457; cv=none; b=NwaAbt51lUq8fqv9R0/j6txzwOBJO6eevBIMpRwrzuMrmc9n74meOFDISBGXpO5iyz1dQMsKkvmDmYR0Wf9wGxUMQGTocWRGiQConJsejJPms/fQ8hCYa+85C9TPB3e19thkkDLH/H8ul4praVRwNN0awl30hXY4+hfgNdQj4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237457; c=relaxed/simple;
	bh=jljibtEnrL5qs/+L9RQviAE8du1HVx4lbuNPnRgMbO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAIHL1vl+ZL7WlVEoWUYPf6M/HH/hFWUPGloX7b2U9RR6XDO4ZuPqoRCut59yTicCyyntYZ0x1QXAtTtekLYSK9E9ZR+h2Wbg8VdwZfyWmckPVB2LrprDECptmyjuF2Py7aRviZ4nbQSAqK9R3GvCAcDlWkCRqNDwINwabLhcMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pAq+m1hV; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bff8f21b74so59184739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 08:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707237455; x=1707842255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rMKa9vx2csPH/9vnVAWHORedkxFcj1vRCUSAMzGARdg=;
        b=pAq+m1hVHYPiZV2I6AaXZSjpA4wAAKK4N1N8T0Idj5sasRsgGJy8uWy0T2CEe2hNkj
         jy+gAjYiB9V2Y6cWQ/su5/6u3ObENYN2isavjArSbuZ6o8u4HVrb9Qq5XojHFLjkbfoK
         X/u8THtvYyujFX/8Qp7E/ev/1vHDTFUnhFuerdB49Vf20p7JX93YfEQbFvghirM5K8xp
         wDmQ9EH1JFLP01E593lq42cTNFnYFc5rnXgcADTSrb9FH/YBYMAnrFMSMjqnmDcdUIAf
         +wDx/IHJwXI6othYrXVd3WLycrLQSUHR2UZhr4wHOq9VU23y+5+d/bafUE9Y9/suSLS9
         5+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237455; x=1707842255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rMKa9vx2csPH/9vnVAWHORedkxFcj1vRCUSAMzGARdg=;
        b=Dxt/o/Gz0Aayg3/zR2cMvK2Jtqezs04shE2Rfj/jLmZL471Eh97El1miknnP2LRpyD
         klOkANPvN89KgyFBBx6y74jwRB3HBL25/TtAMwXeZb0kfQiwWUIVEv7b92JuRAXPU0mr
         18A40GqehIUS9g8gZ9eQxhs4SdCFHy0Rg+oxZqPUxTbMXGrhaq3sqxGJEynG8lcYHgSw
         dq6zBWw5n0Env3e+DfByAfb0Slvb0EW4G6jRBja3nvQ2zIMo+9z+MFfRgXSv0NqWZo2U
         L4S1XZVj4UGHpcBB0KeSLGs+bU24KJudM6VNyTUtEnVE2liWDkqeL6r8XHtn6gt3EzKa
         VHoQ==
X-Gm-Message-State: AOJu0Yz0Vdz0Im63HeOSVbNGXHAzEEnZ6tyuYucVwI/abxYHicR0TI6Y
	gbfhDEsTHdxmhLFyRQy5TDbdPPOn8Gf0oQLc9Z7pLIDOR7hUbnpB4qPaKKcAEP8=
X-Google-Smtp-Source: AGHT+IEBUar7ymwYDA53iN7yKehnTg3OxaGvYRImNKd6+XLKBquZempTK/akY2fwvmFaAiT8s/k6GA==
X-Received: by 2002:a05:6602:123a:b0:7c0:2ea0:b046 with SMTP id z26-20020a056602123a00b007c02ea0b046mr3708151iot.1.1707237455016;
        Tue, 06 Feb 2024 08:37:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVkIUq1r2b1tNBwaFkIo6mEAbuTiIypPKWB720Oi37L0kUtffvOlSBzn+yGtA44HQzU8aZxnf67Xqr3PZnvrtyPLKm4WDb4rOM3H/NWOItFbrCG5vovBy8RrZioC9mw
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id k2-20020a02c762000000b0046ecafac861sm603295jao.153.2024.02.06.08.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 08:37:34 -0800 (PST)
Message-ID: <332c106c-21af-4691-8b3f-ffbdf30fecf0@kernel.dk>
Date: Tue, 6 Feb 2024 09:37:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the block tree with the vfs-brauner
 tree
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Christian Brauner <brauner@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240206124852.6183d0f7@canb.auug.org.au>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240206124852.6183d0f7@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/24 6:48 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the block tree got a conflict in:
> 
>   block/blk.h
> 
> between commits:
> 
>   19db932fd2b0 ("bdev: make bdev_{release, open_by_dev}() private to block layer")
>   09f8289e1b74 ("bdev: make struct bdev_handle private to the block layer")
>   d75140abba91 ("bdev: remove bdev pointer from struct bdev_handle")
> 
> from the vfs-brauner tree and commits:
> 
>   c4e47bbb00da ("block: move cgroup time handling code into blk.h")
>   08420cf70cfb ("block: add blk_time_get_ns() and blk_time_get() helpers")
>   da4c8c3d0975 ("block: cache current nsec time in struct blk_plug")
>   06b23f92af87 ("block: update cached timestamp post schedule/preemption")
> 
> from the block tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

That's a lot of conflicts. Christian, we really should separate some of
these so we can have the shared bits in a shared branch.

-- 
Jens Axboe


