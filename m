Return-Path: <linux-kernel+bounces-49392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46C28469E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029C81C24E31
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F0B1802E;
	Fri,  2 Feb 2024 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dq44r7Ny"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2918029
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860587; cv=none; b=pGO3yrvp2VS4T1lCGvvlgyeROpwMT7ydrt5mHJBs6CzX4qeK/UGfnY7h5GzEfJ3GVqrz6y4L24HntfWpvm/+XcmI0Lx0oAKVHZh2G5//QOwVL0GyImhaVtL2lVpD0Je0/T0u/3xIqDndVRcV65/3KskBgAfstMRi0pTsGbLcb2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860587; c=relaxed/simple;
	bh=XxRpLa/IOE75cRWpu6fpKAMFysBjwggTfJU7a6h0y1A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=okW4zpDlCyOJb7fAtE+Zi4nWd/30zpUqNvYaV6jTcjDDIRABEyJMe7K+p1FWEwEf4FqdrkEMow2kBCQBQTzlH5GlBP4WrMGu3gxQ4F2tWBGOxmSgJcr2VQn/mCglNntNN77KE6PJ0YkofSGWgTJleRDng0e1vKcTUA4p3ulUa6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dq44r7Ny; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-46caa53a65eso234875137.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 23:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706860584; x=1707465384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D8E2Jbl6TudHLXjI1L3R9CJRxDNzy0rQRKMEEkmPbao=;
        b=Dq44r7Ny5XISOIqgOrLwhhnS5cmXCx3ypprM7cY9Ka9DGnIsZBa/9VWA9XgdmrZyAW
         mWpCR/kRpNqHpJIW+Ye4zE9EuyWG3r1iDXMMI8OLdZ0NUeLjs3pFQLdSs5WtDfj0s8dq
         TRzh8v3YSXNikKMNLGt1obaNaYx7HNnvGlIjWsHhrrlrxC4eQal57a7KJGd7ME53RJDv
         VgVUM3i/rw2fx2i7XiJxIYvVMaDHLXBc7zooZYzOTuwOMm/C0EzvdlR5MAnINAu2YX38
         vHDhpKvsHztm2UVFrDRQpMq4YSK9zOOHeV3au0JJU6CXr2Ng+0g5xATBvCpFNFOhqkuV
         YBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706860584; x=1707465384;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D8E2Jbl6TudHLXjI1L3R9CJRxDNzy0rQRKMEEkmPbao=;
        b=Pm4PQ1FgipRi7KJNp/xbUELoIzSatj00ta3qfbzQ5FfbEQnd+Vv9/St9fYgm+wTmJJ
         NErnMEhZDOcSM8I43wbwxF9ObNm9m1VFfmxG5EZiC5KEKBbrbeXrzvbeo67+0TIQNmyX
         WJf/PUtKXBE+iV/9uFM7P19yVppaEATJtAXHVXzu6CPJANeHgpsssbeTXJqZSHmQltia
         17g+ibAsbF507rEgj6VOaRLahTsDAc1PC9O1yKH1xroOb+e4S6wBCS+OqW221K/8J5b9
         8w0EW84CGjNzG2NKaorvwMKMgvbe3m+nHuEGI1toZQ9/QfFIKSX3oFhgqt4O+bIzs6Qa
         E5eg==
X-Gm-Message-State: AOJu0Yw8zfp3MXbWJ9Ek7z3xq7BB4TMSgyEeQhBmQDlirBMclRNmMTbW
	ifuuxIjtHCKAouTvO2xMueFGLGkovm6HWhKIwIdzWsNiM4dVhWmFT+k+GK/OOYIZnJfI1ReYeaE
	olczcZvUjDxFLbEyTLo6Zwr15SAG6y+1I8uY=
X-Google-Smtp-Source: AGHT+IEXCpA+3mSoecvSgXGs45X6HFuOicSGoBKswRqYkxgfmQ5rQ4JUOhuBxwI48V4xCrljGUSYernpTUTuOSlC01Y=
X-Received: by 2002:a67:ecd3:0:b0:46b:3eff:9b5e with SMTP id
 i19-20020a67ecd3000000b0046b3eff9b5emr5092139vsp.2.1706860584067; Thu, 01 Feb
 2024 23:56:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Micha=C5=82_Jakubowski?= <kajanos@gmail.com>
Date: Fri, 2 Feb 2024 08:55:47 +0100
Message-ID: <CAHOGJipx37tUoiSp87Np4b0qzREj60+FEkdi_0X0_JoQW8cYeA@mail.gmail.com>
Subject: Kernel - 6.7.3 - failed to compile the module
To: linux-kernel@vger.kernel.org
Cc: shravankr@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Regarding: https://bugzilla.kernel.org/show_bug.cgi?id=218445

  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp1_execution.o
  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp1_transition.o
  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp2_execution.o
  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp2_transition.o
  LD [M]  drivers/gpu/drm/amd/amdgpu/amdgpu.o
  MODPOST Module.symvers
ERROR: modpost: "sched_numa_hop_mask"
[drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
make[1]: *** [/usr/src/linux-6.7.3-gentoo/Makefile:1863: modpost] Error 2
make: *** [Makefile:234: __sub-make] Error 2

