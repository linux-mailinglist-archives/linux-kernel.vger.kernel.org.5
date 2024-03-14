Return-Path: <linux-kernel+bounces-103606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDFF87C1D8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E2A1B21786
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936B074432;
	Thu, 14 Mar 2024 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="PkOlADmd"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915D17351C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436201; cv=none; b=AQwgKzulGvXqteM6W7AxsZ27bOgi8W75HkFnj9tZ9WYUy4dpgbJayzvAvIJhqRYWNGmT8l3aQq0ejncGPEwgSTMSWf5hNMK0OJ+xH8Xpp7Cd3FEvciKVGomc4qGIkkesJxYDsWfr6rYTEP+nOcCv5QjuE/iUXxNO6tCUlzFjchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436201; c=relaxed/simple;
	bh=0BnOssXuAHPcjC84J7jWUWt/Nn94F6Ev7bJGrF4SoNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akynoq8u+5/6gv52KE8oMbpwDrhHndusdYctVje1PwsKiXCn5n1hMjRvk87rQbHP+inw8TIfh9L2+nLglcklV4ib98xj3S2qEh+8Bs4YufaBhvwHERMEDfuIl2vDXNUa79tLPFXwMJdVltB/S/AG7O5WXg+MfTeVIfmekr865yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=PkOlADmd; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-690bff9d4a6so9106076d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710436197; x=1711040997; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wq3tDY8BbJifWyupgIyZpzh/9hWKNCkxl+BfruynXAQ=;
        b=PkOlADmdKKSjk3/CLHQ+OJQVw6kF94EC2kOCcRYv8jamLmmbXkWaGNo9dqgzVxkvyJ
         R3/EmysmZIQyBOymD7P+luFYBTDGkBBOsGP7xT/u3ydOPR414BIdZGnru5bfKwXTrhSe
         f0B0a0yhkqARRM3TizKUc+euT77D+cKBaGqFMxbvHRSuheKV/S6aHVs1IoL55f4Z7/xZ
         5F2I1h7awEm27hghqsYHgcriYpozozfUZw+s2SHBhXYQgb8+fTkB0cCMVN7cXJufHlml
         E4S1IBS7rxhfglBv3PhznsF7pJc6TPrimO5cNLT5yO3RsyfhhoTb5vFNJQ7WIw9E7ovc
         7xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710436197; x=1711040997;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wq3tDY8BbJifWyupgIyZpzh/9hWKNCkxl+BfruynXAQ=;
        b=Y0pZ1EvRiA5PYu4A2lL5QDwKpZqiGlDwpTGwL2jTXekJZKgKKeka/oqbNw1r3WlQQT
         72W7lfApj5OvgnID+f29zMyPkYMctnEN4DgFoOxGDB8wYLIJy5tGqOOjmRoeN/ihHYip
         AcNtLgK71gDh1XFkVi2taTiaZeU1uNsyEfNWvqMU2rf3fnLf69DZGk+6F76IXStq5mTu
         YVGJNyWxdMra59WL7zc58Tr1PleZiE17eZY8q+vN2jAoCy0O5aJiJRUZo2lkxhNdGmUu
         xNoD52RXt3cxnSQws8B0xKZZTc17KQFRbBg5yWejj46rkKeSzTI4lkIjJvTonHbwqYSc
         pCOw==
X-Forwarded-Encrypted: i=1; AJvYcCXMRWL6tbHUvz8RkUZ640O7K7KVoj8vdPa5JTWo4RmnX+h00dGS4gp/5O7evuTqOmV+JtcSLNvDq6Jf8LO8C7ZcaAcsBuc5zxUVY0RB
X-Gm-Message-State: AOJu0YyVL5Gmb3J5ApWrKKpr/DPVCwa2HPZU1R7Qb35EERm91NmucPZo
	fY21RJtIxgkhW8BhWxSF1D8m7cI+9KQZLS0wN/ulRkm9Df9O/l4h/pqgWCwPCZg=
X-Google-Smtp-Source: AGHT+IG9aYKr3SLrUEGgyDZji2FG4IGp3KCRhhwIdIrak8oLuo4wulKWroEURFFbiWSVw95P6gj41A==
X-Received: by 2002:a0c:d989:0:b0:691:6dd8:4606 with SMTP id y9-20020a0cd989000000b006916dd84606mr65545qvj.30.1710436197410;
        Thu, 14 Mar 2024 10:09:57 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id z10-20020a056214040a00b00690d951b7d9sm700131qvx.6.2024.03.14.10.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 10:09:56 -0700 (PDT)
Date: Thu, 14 Mar 2024 13:09:48 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	"Sharma, Shashank" <Shashank.Sharma@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: fix deadlock while reading mqd from debugfs
Message-ID: <20240314170948.GA581298@cmpxchg.org>
References: <20240307221609.7651-1-hannes@cmpxchg.org>
 <c411dce6-faaf-46c3-8bb6-8c4db871e598@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c411dce6-faaf-46c3-8bb6-8c4db871e598@gmail.com>

Hello,

On Fri, Mar 08, 2024 at 12:32:33PM +0100, Christian König wrote:
> Am 07.03.24 um 23:07 schrieb Johannes Weiner:
> > Lastly I went with an open loop instead of a memcpy() as I wasn't
> > sure if that memory is safe to address a byte at at time.

Shashank pointed out to me in private that byte access would indeed be
safe. However, after actually trying it it won't work because memcpy()
doesn't play nice with mqd being volatile:

/home/hannes/src/linux/linux/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c: In function 'amdgpu_debugfs_mqd_read':
/home/hannes/src/linux/linux/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:550:22: warning: passing argument 1 of '__builtin_dynamic_object_size' discards 'volatil' qualifier from pointer target type [-Wdiscarded-qualifiers]
  550 |         memcpy(kbuf, mqd, ring->mqd_size);

So I would propose leaving the patch as-is. Shashank, does that sound
good to you?

(Please keep me CC'd on replies, as I'm not subscribed to the graphics
lists.)

Thanks!

