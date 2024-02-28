Return-Path: <linux-kernel+bounces-84474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0B986A732
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA9D6B2CFCE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FD820328;
	Wed, 28 Feb 2024 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dmfOanEO"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BED20320
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709090800; cv=none; b=mSkzLowxIIuEqNmLLGovmCnJXQ+7TjFHfWB5GJ8fynbpfyl2aIfs0x85bbIaxgktnURua/AUWOXPxv32OJuye4q4410jHfD7eMgon/igKyoO1gpRcq0WkGdV9rBk7g6AvKR2scwifA2rpwiFy5+Ri9m6vDtn9xzJ988sCt7arzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709090800; c=relaxed/simple;
	bh=8OtT/g4e41nvDmoPuiBisjrJJG5cIKIV/+8CKhLGz2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lliHfkpWUfS3CbbcUfeE2xBBd4dHT/Tk4NZq2gr7nHtCgdVC8kV7UICSw6BCZ1U3J0KClmxTgzNrfg1NeWhgRAULeYmTwMzl1B8DH6YjZmR7tujrszeoLnh1ul6Mk0YhGDWy5RXsV83qXilTWuaraHDBuiXEjx+MF7e/+05Fv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dmfOanEO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso42593365ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709090798; x=1709695598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfBHH2R+HpI9h6VdbpXXPvs6htYiUptEJQWxbn/nS7o=;
        b=dmfOanEOPRmEkibxq0rqo1NX8rmPlAnLxy7s9j4oqUGhZIjXnZNsYRRkAu/BDegIin
         +ePTQL5t1sJrdVRo4SOgMkJMtVmtWXADPOU8VwnbOSVAEUOKb9YQMofo6q2qUusb1wIU
         Qkq2coYwczVO0NjaNT58WT7NSH/kd51DE6v+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709090798; x=1709695598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfBHH2R+HpI9h6VdbpXXPvs6htYiUptEJQWxbn/nS7o=;
        b=d8I+fm9m5MPgX9X4xb/Wnb60qzTAWS1sKZFA0VKy9NbWPEP/8j2VL2TIfDyA9ArZ/c
         0Dx7lREt6GMeju6RgMpz5ZR6E6+At/l5NvBy438PuWmSThE8Psx9Px/gMfGy21y39d4d
         WsCVBvqi3CN8kCKnRdcHPhDio8fD8xcivOZ5GjRzCrvf5QKmo03ibAAmv8C5KJ35DYAB
         zkPM2X3a/AYLhf7ZlHmAPgDoFq6MumXi1kB0Xvej3CZq3jOyD7FVhA8uzJUAelk/MVjY
         RcU3CgqZhD7YlKAfa7D/LLVzoOmh/wXFMiUhVFLKXp1lu8XiHupycwDKpnNEcBNOM6pU
         ew/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBC6E1D9dbSo/F23ah0EafUS6aMZVEStXCuqfw3xmosTfLESLLZzDAJMu6dzax3BbUjhhmxVBjdIYh1xBIW5khtnw7keSmci2qZJ/C
X-Gm-Message-State: AOJu0YyjhwpQWkXPDXmviBh995+i7sQl8aWkyC4dMUUnd1QcwrPpIOSH
	gNd509UHddJBpRp9xSPXmU5Q/mM0ju1dke8OW58p8T0xG65ZgSDIHiNMCP7hmg==
X-Google-Smtp-Source: AGHT+IGjKWH8WdXwvyPbqGQkoMzuAhN4wTInVqdRoI7ktLotObm59XuZ8U8NdyqyEjua2GDsjoQ3Vw==
X-Received: by 2002:a17:903:2309:b0:1dc:b4ef:b199 with SMTP id d9-20020a170903230900b001dcb4efb199mr5260618plh.36.1709090798499;
        Tue, 27 Feb 2024 19:26:38 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:f4f0:fb4d:aa01:9068])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b001d7252fef6bsm2217289plg.299.2024.02.27.19.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 19:26:38 -0800 (PST)
Date: Wed, 28 Feb 2024 12:26:33 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: minchan@kernel.org, senozhatsky@chromium.org, akpm@linux-foundation.org,
	hannes@cmpxchg.org, nphamcs@gmail.com, yosryahmed@google.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/zsmalloc: don't need to reserve LSB in handle
Message-ID: <20240228032633.GD11972@google.com>
References: <20240228023854.3511239-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228023854.3511239-1-chengming.zhou@linux.dev>

On (24/02/28 02:38), Chengming Zhou wrote:
> We will save allocated tag in the object header to indicate that it's
> allocated.
> 
> 	handle |= OBJ_ALLOCATED_TAG;
> 
> So the object header needs to reserve LSB for this tag bit.
> 
> But the handle itself doesn't need to reserve LSB to save tag, since
> it's only used to find the position of object, by (pfn + obj_idx).
> So remove LSB reserve from handle, one more bit can be used as obj_idx.
> 
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

