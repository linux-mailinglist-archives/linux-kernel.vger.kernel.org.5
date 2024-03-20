Return-Path: <linux-kernel+bounces-109428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA88818F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0A22837BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5138595F;
	Wed, 20 Mar 2024 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRA1FaFZ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5EB6A8C5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710969297; cv=none; b=LMUEFFqxyOlV24Gxmu90K7jWLGSX7BnxCS0clSZa6AIyzWOBvd0trjLQJpv/D4z1w8O88g7TdtxDdgrtoDvaSJOQPRUnJOvlmL0uDig6wM0XCwfwN4h0d8lq8ucCGNIfEyJvrjuBaL96xchcKTc5pXatGmXYkyzTMIqlqDIROlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710969297; c=relaxed/simple;
	bh=wd1nYr8m1KR2n3urOxGOjtHYYjJVJHI4iyGiHvDBp6c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CnK8U354x1JblA6/+cBuSFmhXTOqSzvhHCYlV784JQmHoaDbnKC4U7E7+VwzhK0u8Bwajro6OL8M69tRXlJcYS0v0G8FfgcvTzGPT5oqzDGXSoDLS3XctTh76w0HStLpSFSsZDr17MTnBZRietf9E+rTMop5G46O5x+4NuEPG34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRA1FaFZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e034607879so2230495ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710969295; x=1711574095; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7fFGAwFervR59ppe1kqtK+ZKXlEJIswmFJJz9qkT1I=;
        b=MRA1FaFZ2iNTL2dnlnCL5G5BJfoLqY2KclK2sulnP+RrRQ9qHEu93Hta6680RUFs/Y
         uMB7LOwo/sM1MubqkNCqhvToAPB9orjyw2YwAni93pcCmHEJjd93slfpEg6l82+sfNTH
         wtXKW+mRhiLI1yZB9MaQ1nxGOVjXDF3FViVHMjiw/Yb9nxhEuQTsflDV6Z4ke+xP/kgO
         tzR92G/VSweQF4tPRkINoV661JDVVWHny2xsivsJ1BR7IyA72fHsXDrBMLxXqZZhRFeg
         faxGPvzLwQs8Y2zu51Si8rZurH06nxJADNXO25nnLzBIINAyQOTc4cFDzXZZ/tFTy283
         VgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710969295; x=1711574095;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7fFGAwFervR59ppe1kqtK+ZKXlEJIswmFJJz9qkT1I=;
        b=N+tEF8D4Wp7hXRoSCG1cC2vvOG4pB/gBlngBcjRz8H9+m52FUk+oqVHAsmrSakrl+E
         lQIs+89YSJidAjYgEjKp/lJTFcTsumEn0ShbIiDM1SfeCw8ks0/Rbg8WT36t6+FarKaK
         +g6StI8Dbafk3tOe7aKJLAp8SBxD6k/76wWIwEiikG1pHvXe8Pwro8MhlS/8MQiosn6j
         uqxRSAelAl504DhkLD1JuR+dh5XLSCiiNQEBxSad9+y14+mwAMkhe2E20OT8TW2L1Bxh
         jebNrz72j9rng6hCmhY8SBlCnwst1AJhRZaxePYX0ist7QqdD6JotFueOIbEhXefAVPb
         gLJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWF9btZH4yZM14JrF9vElns/gY/8LhR4njB7TET6DSeO9gd8epy7qcCK4O5CXPl+TYjCM1qqx8F9gx0OgBlKzBJ8+VViJciZRoK+Zb
X-Gm-Message-State: AOJu0YxekvzJPE7t/ReU/TOfp0N4hPTt/Y4GY0AODNTqtRvnvuyB+xGR
	65DHno/zdPGP7bnm+MDHMAazinZUzCy1IVeA/BLq/QC/odDqa5PG300x+AYQy6A=
X-Google-Smtp-Source: AGHT+IEN4zZwUIlDsr0tDIndaRJ8gb8+vxa1njntTQABc8skaQTzg+nHVWus0UDTG+TjZJ+f9r3nCQ==
X-Received: by 2002:a17:902:ea10:b0:1e0:1496:91ec with SMTP id s16-20020a170902ea1000b001e0149691ecmr8658280plg.20.1710969294813;
        Wed, 20 Mar 2024 14:14:54 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902c40500b001dd635551f1sm14145020plk.255.2024.03.20.14.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 14:14:54 -0700 (PDT)
Date: Thu, 21 Mar 2024 02:44:51 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v3 0/3] Trivial code cleanup patches
Message-ID: <cover.1710965653.git.ayushtiw0110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Address different kinds of checkpatch complains for the rtl8712 module
to ensure adherence to coding style guidelines.

Changes in v3: Fixed issues about backupPMKIDList and verified with
CONFIG_WERROR set and built the kernel.

Changes in v2: Checked any possible reuse of backup_PMKID_list
manually and rebuilt, rebooted the kernel and loaded the driver
with modprobe.

Ayush Tiwari (3):
  staging: rtl8712: rename backupPMKIDList to backup_PMKID_list
  staging: rtl8712: rename backupPMKIDIndex to backup_PMKID_index
  staging: rtl8712: rename backupTKIPCountermeasure to
    backup_TKIP_countermeasure

 drivers/staging/rtl8712/mlme_linux.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.40.1


