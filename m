Return-Path: <linux-kernel+bounces-49389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D288469D7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800C628485B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD1C17C6A;
	Fri,  2 Feb 2024 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQMCSWcj"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5591E17BC7
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860466; cv=none; b=qcKu7Y/HPzcxYu48AxFussFt5sfDiN240IArysoFutd4RRx5c9vYC4fwgC8up6quQfrhONhXbQS01VMi0uxjGSW6me3wb7BlKgoILlF80ubKr02tBr02fXCflOPsHa3jEzbnqQfJd+3ZgqCb0S66HBdTzVbMxk9sHQzYnYk1kA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860466; c=relaxed/simple;
	bh=XxRpLa/IOE75cRWpu6fpKAMFysBjwggTfJU7a6h0y1A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KA+1kvpwflF2WTdxGSNaAnmjdovbvrV1MUDUBLe7wZVpM3JbgLinW7RdfzobUON6XVdqn9+DrVWr04SuDX1hht4SuXNRBR3bzx2DcBkeekbCX3fAUEM7ePjlw+bd2WquAjc51l2wu4wpLMTdP7P4/KKE8LuW0pLv5c/pTG9SN+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQMCSWcj; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d3216781c5so354115241.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 23:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706860464; x=1707465264; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D8E2Jbl6TudHLXjI1L3R9CJRxDNzy0rQRKMEEkmPbao=;
        b=iQMCSWcjf1ShJAKw1QCdcqE2gTRg1UaWqUbe78S4K5ZBoejcQCf34txWJWWTWkWW55
         Qy9x5wAcrKdu3RMp1oW14kHhnP3HvHvH2XFwgQ2IrqmdFRbfJJrN8lrNC46Jfe35Kqle
         GQh67DiZ4IsOPo3T+MBCercuXFKcFPvMySDX17NkTsqKBnfM7/HVO4Eqv6SzX/KKm/nr
         oyOrSDuX9ZjV1xnDeYA7YtI1RqT7mJOI22lRvHrkknN/grjAO7yCiutN8O3PQzNqMU0R
         rDCizusmFLtjV36F+i87xcQ9fhNLCROIZ3rx2Yw9GiJSyQUOUimTeVFmBq1JcHxZPxDS
         kRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706860464; x=1707465264;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D8E2Jbl6TudHLXjI1L3R9CJRxDNzy0rQRKMEEkmPbao=;
        b=puT23DHRhFlolRSNEzC0Zt9cTwFPsSeu4fEbrgfoVpZN8gcD3JS0kyxhFZy0F4LOAT
         gBmynTnAhpVoSFce7TSL2BNTUgMYQncYLlpNKCuZiE1zGauz96cVVFutIGzJYDqP5jXj
         RtBkCBp6xBBEgMDHun0QVQIbHgtTsLxRu0GTuy3ZHI0VdeXtYREzaFFOUke6p9fJ2FEq
         2JnA32190HrOXiooh45JZwqSwi/8//J93SUB4bmjmqIzM8q0CxCvaa74pt9i5c0ac5J3
         Ktql0VLoE49b6xKvu6CvVK6ByWt2d56u7xPm318wI87XrQApEvT5gW2y07RpX8chs3q2
         ZH1g==
X-Gm-Message-State: AOJu0YzqcpkkAlowrAYh24qtlbgGV0e9g5MGVUv0XRAmAMVCBn9uHzz+
	TJhEW64Ip8VPLXP9SDHDlzGK4FENb3WuGLivNRph01yo7prf4hDDCkwGVlL0O4I4LJek18SX8JZ
	2QGPBFoQu1+lTGeTTJiKPSQ+MWWSJVsw1FDY=
X-Google-Smtp-Source: AGHT+IGvkQoUqT2UVIVzqQykX+xcinX1NylLLznhFoj2GLfhkLNHyYB9NOYZ61MBH51WarwooIhs9sn2b30NvCNOK9o=
X-Received: by 2002:a05:6102:5f6d:b0:46d:2f4:15fc with SMTP id
 ix13-20020a0561025f6d00b0046d02f415fcmr609133vsb.2.1706860463957; Thu, 01 Feb
 2024 23:54:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Micha=C5=82_Jakubowski?= <kajanos@gmail.com>
Date: Fri, 2 Feb 2024 08:53:47 +0100
Message-ID: <CAHOGJioO4bdtH=8swCQQXW0-RKpWFuiRTKMzQ5orEbK8=kmA7g@mail.gmail.com>
Subject: shravankr@nvidia.com
To: linux-kernel@vger.kernel.org
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

