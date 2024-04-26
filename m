Return-Path: <linux-kernel+bounces-160624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BA48B4039
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A61E1F239FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DB11D53F;
	Fri, 26 Apr 2024 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTHJ5x2O"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077C1171A5;
	Fri, 26 Apr 2024 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714160601; cv=none; b=Bcn1TToavMtw7SpzPwtz+NbrtCnzI+eNWS5Ty/MqyitrZyfL/5R0c7Cnzq0RbaNBBfIx/iAkCWtrnFfvEqVGQBQfWqau8d4dFQGlxOWtzHxFTvXvfaDmffHoWpTSlJA++HLEoHI/xbabvYWkICiDBiqNP7P67ATXaR+acWqCoKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714160601; c=relaxed/simple;
	bh=v3VjEtNySaGx4z/ww+NWdgMzt23br0WBt9LqihrhESs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ch40jcedErXtQuxEAR+iJHoBRL2nJRTEeTRpicMTtha3eLbpnBX2psDNmkVzk5HwZeM55hYaAoiDzVfoCx6B82kcau/j/JTHXMZzAw9SeBot8P0bD93a6ZOMXWFT4EXKxVSWjfgCFG15EXGSz3sDUmp0IPrkSjHSQVIRtU22kEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTHJ5x2O; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c7513a991cso1670904b6e.1;
        Fri, 26 Apr 2024 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714160599; x=1714765399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ez5dwbz8JSjneNoXon0fw7sPpOdQl15Vv9BQ7RclgZY=;
        b=BTHJ5x2O1EsLSmD5D3vODATU7hgzOqZzkrpsu9Kk3f+g90Lp6wwAS53jDRE1hrohwf
         UVKWsO6YV3E3CEY9YJ1nFHYcMg/+bzJXzpVg040Tr1aJjXmdJ0tVbr/3VfW3vjZgpV+Y
         QSLKsgpWF41lTRmpPzKjvHNdwKbgXZCNfDDpSFAtTvT+5xCgfPuDiDm84gBN4Szsyh3N
         R+diXQnxdmfKcGHoLhKZ5JKhMcsmTnBAOVY279Su8t4dk4RobtrZ71LC8gcpPrSa+z1j
         EyJwbSuz4sftO+ZHeZB1RMtq87p/TpZh+FpKDecPHSa5F/nPfCmmkVy+mXrWL1eUjZUE
         antQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714160599; x=1714765399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ez5dwbz8JSjneNoXon0fw7sPpOdQl15Vv9BQ7RclgZY=;
        b=DfS0zSLY0ybQuL5q4APzafwrZoih1iGusYG40qJ97D87BqvrEOezdA/oBmYeZYaDIQ
         oMYEkf1fgxCq2kG7PojhSXHEbLpjznqe8Q8C0Uqn4mWCE4xMX0NVp2ZpTxbubi9TrqC9
         MRApw4KzMoVKELpJ4GP9meB8gp2Kb0xlBJD3wrMRq7z2PdPd1o6DqESMvkKBt7iJCN6k
         9i2JYeJC7o69jcZAi+e6Cts2/7P158UUyRjaNqJgGx/08VSspmOagffyHESRwxHY5ORa
         DvtuWL/wM2IA49PyHL8h9scFj/zs9BySBKfPe8ekwxCkZqGzMIqM3ibXsluwHRTDBmh9
         iaeA==
X-Forwarded-Encrypted: i=1; AJvYcCW17rMPQF3fcKFtz/bN8tkTYZBvp2vtmuPkh56/aR7pT6UPk8ExYHKzt+9GXhHgEAUsmAEam3HhXb6wZsGHJnWL6jlefzLTGvAcMIq3x89l8yHHSkjfP8lEKwWatzP8w74mgXXrMa/pr6p9HaBiopu3FW8hNrbks+iSTXUt
X-Gm-Message-State: AOJu0YxH0jC1gC8/e1skdceVCbz/OVb2Y/KB1/wEPn+3x6QFJ7MJVl/a
	Am3KBgtbxuD9qpjrWi/xwAxJTkCtcsBFsGls5C7+17n5RJNJNcC1
X-Google-Smtp-Source: AGHT+IEzsciE8ILeKhs0ArVzG7BfrvCSt2KeqxyIdeRcj7dPRlFHo4kYggL2paZOpJqzQkT1bDe1tw==
X-Received: by 2002:a05:6808:43:b0:3c5:e66b:1f79 with SMTP id v3-20020a056808004300b003c5e66b1f79mr4200106oic.16.1714160598936;
        Fri, 26 Apr 2024 12:43:18 -0700 (PDT)
Received: from [10.69.55.76] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c12-20020a05620a134c00b0078f0ee3fcfbsm8090095qkl.46.2024.04.26.12.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 12:43:18 -0700 (PDT)
Message-ID: <50522abe-57d0-47df-9917-e0cd6848650f@gmail.com>
Date: Fri, 26 Apr 2024 12:43:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] net: bcmgenet: synchronize UMAC_CMD access
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240425222721.2148899-1-opendmb@gmail.com>
 <20240425222721.2148899-4-opendmb@gmail.com>
 <07b4cb83-08db-449d-9d73-88e84fa570bd@broadcom.com>
Content-Language: en-US
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <07b4cb83-08db-449d-9d73-88e84fa570bd@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/26/2024 11:19 AM, Florian Fainelli wrote:
> On 4/25/24 15:27, Doug Berger wrote:
>> The UMAC_CMD register is written from different execution
>> contexts and has insufficient synchronization protections to
>> prevent possible corruption. Of particular concern are the
>> acceses from the phy_device delayed work context used by the
>> adjust_link call and the BH context that may be used by the
>> ndo_set_rx_mode call.
>>
>> A spinlock is added to the driver to protect contended register
>> accesses (i.e. reg_lock) and it is used to synchronize accesses
>> to UMAC_CMD.
>>
>> Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Doug Berger <opendmb@gmail.com>
> 
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> As a bug fix this is totally fine. I believe there could be an 
> improvement made in 'net-next' whereby we introduce an 
> unimac_rmw_locked() or something that essentially does:
> 
> void unimac_rmw_locked(struct bcmgenet_priv *priv, u32 offset, u32 
> mask_clear, u32 mask_set)
> {
>      u32 reg;
>      spin_lock_bh(&priv->reg_lock);
>      reg = bcmgenet_umac_readl(priv, offset);
>      reg &= ~mask_clear;
>      reg |= mask_set;
>      bcmgenet_umac_writel(priv, reg, offset);
>      spin_unlock_bh(&priv->reg_lock);
> }
> 
> At least a couple of callers could benefit from it. Thanks!
The only issue I see is enforcing the 2us delay in reset_umac(). A 
scenario where a different context might attempt to modify UMAC_CMD 
during that window is admittedly contrived, but the approach of this 
commit provides better protection.

-Doug

