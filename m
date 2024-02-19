Return-Path: <linux-kernel+bounces-71205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A5385A1F4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016241C2240C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBD42C6B9;
	Mon, 19 Feb 2024 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="U3Mhe0uh"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3302C6B1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342191; cv=none; b=R4XiaKJfE2DwxjdG2c+/KUZkNoigtTX8mQVx45AN2OmD9/evWUvfd6BB06A6iDGkut99xTM/sPNhDASqo5S5FhM0KBEukoMQw5DNS2p56QP7Q9jrnAprtFEZfPNltc9Uwo0MM9nDTY0otVqQWZ2jNGYwgsO1hhxGqonZCtmALps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342191; c=relaxed/simple;
	bh=nh96FlSmKLk6qb9tc5ZMoUTjtdbAbD/L8Kg7/NLW1C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzp121JVwYnp0rkUyotlfeHdZZsFch3NJfHBP3FYRqRkkxdXJ3/jruHWC6AyZqlQTKR8JEqqkd+Umm0gjw2XLQCulUyNu5CZn75qMDcRwIQQKTYich/wbmFun2FFEtZU8FooHIiVZyQo1/PuwidG/Q7mgmrdML4/mfw1+C1hgWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=U3Mhe0uh; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e2ee49ebaaso1298119a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708342189; x=1708946989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cG9aV3CX97NJPbb0apJM5Ou9dcYoJ0CVH07FAS9ZdQc=;
        b=U3Mhe0uhPZhsE+Gqb5HpPigKWYlIzY/qfRKgW27MFZuWoR+6hc43MJhFsYgk8NHBF3
         11mjZXgdA0X5YdYOSh2b/Fzp3NhFXR2RrlCgxGfqL22B/61PWKxUneM/s4KiQ96oYPvL
         EczxXhadAbjGtvx13PY9bBc2PhKRdXQKw6ULCliT1EIJA8u6CXmY2cXUd1SX92US3xm/
         /poJusmiUA22L7Li4AcgQc/O5hM0cEkz52wWTAiXqlVfvnDKG+qXu58jRmYvA7cAZXK3
         SLV60k4o02Ysy6QRPN3Km21QwrbKmv6gELjINRBpIjlP/aWRXr3Jss0AMq7fSjd2Hyi5
         LxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708342189; x=1708946989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cG9aV3CX97NJPbb0apJM5Ou9dcYoJ0CVH07FAS9ZdQc=;
        b=EeyJMmqOcA4kcUPK6bwdbrmEzd5e/EGZMvCxI58EW+SyiNPYwDsPao8uNRdYapgWwL
         QPdjiZrUbNMRH+WGoMSgaXh6KDwTD4yegwVVkUIDaUPYxyfFvY4MkAwSf273G0Ruf/f0
         ABsl0mjcBNZDdEdv9NqW9N0HclXMAGQyzmO/KrZ3vRSgj3i+3YZPNa9sVmtisRnBK9eK
         BC6ZpPZpFVrpDTDHIkgPybVwd4GX7FC0R4K/szFzIv1aMntvq9TrkZ/6LL7Aopukb5J2
         YsnXO+1TOn0QLZH2Ep1P2kcTpn+oFlAHzpBsTCfEUOl3BDw1RvbwMTglYw2DTXLm71Oa
         IHsw==
X-Forwarded-Encrypted: i=1; AJvYcCUzTebaYBN48SHKLuJEbYp40ACyADe+cAyjXjB/x26a5s0D9Xed4T6ltYXNm2Lf+2Mu6V5S10ZlEPU9Zagx/gXMTjhm2tKP04YlQaAt
X-Gm-Message-State: AOJu0YwuapAMm99yKRoGaCuGj2PdpkMnmm0p30FW3GrE877/ox0Ywvrg
	+s7n5bJnKML7Nis0tzcRaB3bOLCAB6urT/Ibw3AfdBs1peCmqYaMSFiwsbe9PJY=
X-Google-Smtp-Source: AGHT+IGi8ElosdzT4CgDfHio0e/jboL3KdbZ3z3Ao5xFz1JHVyhu+vj/sBxstk/McYjajD7KCA/rVg==
X-Received: by 2002:a05:6358:6491:b0:178:799f:bcea with SMTP id g17-20020a056358649100b00178799fbceamr13899484rwh.7.1708342188999;
        Mon, 19 Feb 2024 03:29:48 -0800 (PST)
Received: from [10.4.192.10] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id e20-20020a62ee14000000b006e4716afa58sm483424pfi.159.2024.02.19.03.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 03:29:48 -0800 (PST)
Message-ID: <5cb54690-b357-4e7b-ac6f-23fc8dfe575a@bytedance.com>
Date: Mon, 19 Feb 2024 19:29:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] Introduce slabinfo version 2.2
Content-Language: en-US
To: Fangzheng Zhang <fangzheng.zhang@unisoc.com>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, tkjos@google.com,
 Fangzheng Zhang <fangzheng.zhang1003@gmail.com>,
 Yuming Han <yuming.han@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
References: <20240219031911.10372-1-fangzheng.zhang@unisoc.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240219031911.10372-1-fangzheng.zhang@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/19 11:19, Fangzheng Zhang wrote:
> Hi all,
> 
> This series introduces slabinfo version 2.2 to users.
> In slabinfo V2.2, we added a slabreclaim column to
> record whether each slab pool is of reclaim type.
> This will be more conducive for users to obtain
> the type of each slabdata more intuitively than through
> the interface /sys/kernel/slab/$cache/reclaim_account.

I want to recommend a better tool: drgn[1] for these tasks, instead of changing
the output format of /proc/slabinfo, which may break existing userspace tools.

[1] https://drgn.readthedocs.io/en/latest/index.html#

> And we have added an example of the output result
> executing '> cat proc/slabinfo' in the file
> Documentation/filesystems/proc.rst.
> 
> Changes in v2:
> - Modify the slabinfo version number to 2.2.
> - Add an example of slabinfo output and future works.
> 
> Changes in v1:
> - Add a slabreclaim column to record type of each slab
>   in file proc/slabinfo.
> 
> [1] https://lore.kernel.org/linux-mm/20240131094442.28834-1-fangzheng.zhang@unisoc.com/
> 
> Fangzheng Zhang (2):
>   mm/slab: Add slabreclaim flag to slabinfo
>   Documentation: filesystems: introduce proc/slabinfo to users
> 
>  Documentation/filesystems/proc.rst | 33 ++++++++++++++++++++++++++++++
>  mm/slab_common.c                   |  9 ++++----
>  2 files changed, 38 insertions(+), 4 deletions(-)
> 

