Return-Path: <linux-kernel+bounces-161403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E70C8B4B90
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FDD1F21586
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB905C602;
	Sun, 28 Apr 2024 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT3rvuF5"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0A4EB41;
	Sun, 28 Apr 2024 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714304940; cv=none; b=VqSrBjj422qQ2pnQABuowl+r8ABMv1VkuiyxrG+ggWWYbg1uoMvl0pT+VBqpB/8jMF5vk+x3/vJmaX8iY79A3k8U5a+40hhQ5p6rkWmHy+nWe2+O86eIXHCqnZvTLI7xOiqR+Nkw6SFbHGsJWjMQAiPkg6tmbVyhJNf0t7d7W3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714304940; c=relaxed/simple;
	bh=OnI6cUk44LsQbKr/M0rkgGZtY7M8erbagdEljkfjqQI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dhK383eMONQr8swDBIRv5tACrZlNwyMZFVFezYCQ0/Qz+nhLxOF8RPlPlkxl5NHIIzlsZmVOvmIpDZ0TikLEz0HiKWAXQezvvyfGTM6yyP8CWOjNOb8MShKjx57Fp/xECiS00iAGrvNW8ctB3vpZ51lw3dHZRvQzGN79yqkEs2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AT3rvuF5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e51398cc4eso32784865ad.2;
        Sun, 28 Apr 2024 04:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714304938; x=1714909738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OnI6cUk44LsQbKr/M0rkgGZtY7M8erbagdEljkfjqQI=;
        b=AT3rvuF5k9WSAtYA92vqqRTUz53gyDzPkwyBhtlU1X1Zo2MPM8BJG9tSvKYj2px0as
         QqoHWcDwUHcWqb/y07dhZcNTB6mCkRvOJ3t4uaRSqNJW0nEXKA7eaXxw4dTXLw+98DcU
         CoFSD9GYc1yCv44W5NuOIM5ThoiUyt6OjIOR5r9Z5vOK7QJWVTEbLCHcAfqx4O+RJzal
         uGBxSmoC9wx86J2rRtu5Yvp/zsmlbZk9eBBaaSZ48wuyxbgfFfk1yPRJAxRlt1yMRb0d
         vrxwIRucEwTUjFZBOIYwxBl9ER+tRA8SHn6Yvb8GqUscAlzXvJjhTIO2NEHYHGrDSFEv
         N0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714304938; x=1714909738;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OnI6cUk44LsQbKr/M0rkgGZtY7M8erbagdEljkfjqQI=;
        b=UssuiSCU61yXcPI2qTXG2CCExzbhOqHdVxtwVwCRFjzz3lQUZ1/iBXjfHJ7o/8CyFU
         eGtOIZWTSqKNfb66y41IB5xgJWBW23ia538zAQjlzObDWVllmCgEJ0+oA5qZmghYuca3
         Avv937Jz5gGkqZj4b/VMdNZtIjkUSfofLfkWMAUbWpQ9JPknOPt6XYJzaQURm5rhqRVr
         4pNkLkaLEC6Hi6wt0KwPQ1LBFYhwqbGTH8rUQOgLta4Iq/1x8AxuVYfYp3aAHyUUbo9I
         AO29IPLnv4pFC99RXi4mS3YHM96GUz73+msQPTpnvlNrLkJJIEAJ0mpadCGk/SIGEEfO
         NzGw==
X-Forwarded-Encrypted: i=1; AJvYcCWM0f6TRnWCyRISuslXdiFqN+oz5vd3uzqhKwK1gyQwZaEoLOnEIwfK/9eNN+0EzMrCZ8FJl0ZapTJ8FT77kAZrQrSo2Uw/rfNwf/i2h8DL48PoR+cRbq8S+WnK/MddPS3Fvf7vQxGcAz0=
X-Gm-Message-State: AOJu0YzeUc2OIrwwznlu6EapgUjWfAKpbt1M/IvAVvrwcS7lb+kqfl2P
	cXFpoo99BxoFMIOsHVk6S0Ey5kYz/lMpS0o4HJFSPo+JA2F/DNAkiy+cgT/H84ExcjN40uC8lz3
	DZDM4v2OB0fn3OUtH+8GsuFCoRpuIxQ==
X-Google-Smtp-Source: AGHT+IHvwz4nmdunBr6J2yHHs8FhQymazg6kf8ScSAEcvNAnXFEsWfAvs5rH77tf3wCOJPv/oQPjDRBhRwGD7Ji4RbI=
X-Received: by 2002:a17:902:f547:b0:1eb:fc2:1eed with SMTP id
 h7-20020a170902f54700b001eb0fc21eedmr8045865plf.41.1714304938213; Sun, 28 Apr
 2024 04:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Sun, 28 Apr 2024 17:18:46 +0530
Message-ID: <CAE8VWiK8sOm6=q4JoTV7kCjQ-b3feO0FYqjQc_TZvLGe6Oi2zw@mail.gmail.com>
Subject: Re: [PATCH v2][next] backlight: sky81452-backlight: Remove
 unnecessary call to of_node_get
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: daniel.thompson@linaro.org, deller@gmx.de, dri-devel@lists.freedesktop.org, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, jingoohan1@gmail.com, lee@kernel.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi, any updates on this?
Has this patch been accepted?

Regards,
Shresth

