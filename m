Return-Path: <linux-kernel+bounces-112474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5AA887A48
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D351F217AF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF804A1B;
	Sat, 23 Mar 2024 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4Nn42iu"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D1A3201
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711225839; cv=none; b=b9rYQEAV7FidlbQJBkkYfTMEofKSxsWdkGZEfe7iXD2VJnHgn3R7FNFxo4nHvCDH5UGhyPW9f21u+X2sFiA6t6YcMrA5ehGDaQd1Iij1crql4ItZTwkTvoNd4VfvWLHywKzswv65gCPqAYe80NEbXT8bG31G3KLGaq6nGW0Tyjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711225839; c=relaxed/simple;
	bh=ECgsqfRgT5Sbdk25sDAGP2uRSBhpqVcqVq7bIPzB0Cc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=b4FgNzkD6umWLnWbm1MVDjLRRt5BYbiFZIqg6anrsNg9cJ/Aw2PM3LVBaAzJlCyNW813bygUOYfJ2NpMm7mV0r4q1QBDtQJfmk5wn9T3m78KXDK+3KjoY2AlfCGgNQYGwtzPDmZRvsXjH3BqHmAPM3N3kvEIDb4MbOGgsuBNjSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r4Nn42iu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1deddb82b43so73355ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 13:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711225837; x=1711830637; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DmCb//8SB6ZvkShO2VQklDOeGzHiX1umwhzy6l3Nsgo=;
        b=r4Nn42iudTCO7rWWqoFDJLxbRASjzCcrbrCAJhkL7bov7MCkdkXL7ypRR5Ta5CtUD/
         jtvz4RRv8prl3KGVNRA61HHOjKZ8DTUS0xPXtISdmeDBufZoPWz+arr09BBquEVosZ3B
         MAa5RYCEz9dGl3GeA4RIYUI8Re8+F5EJSLU4p+J3DLK9voKLsKWbn5PsCTjGL8Jdp2hS
         fuC/Arp8ykYBznFnkdhAkOBH441lFHPXdXYfJabCnSvk34zKTItYNMlZ5Bcx5kOvS0be
         mcjDUv65vN7ZZPYVS5Ozsm6l79FUcG/R10EOmofwku0PyUXyBj6OMp6z4wbjWljOAC3e
         YEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711225837; x=1711830637;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmCb//8SB6ZvkShO2VQklDOeGzHiX1umwhzy6l3Nsgo=;
        b=e/84UDTVzUvwYq74MzHb6Y9f76U7eiwyuJaU0ymHCCf1M2jdEWYUEMw7vukNvZ40KR
         MK7G23eTJtWgT4gPdvHT8sH74Wx/HA4OO1wWD2URML9oyV6hWuvVAXRoQp5lIvJGckZ7
         KPpwS/lFGwFSFA/7rUGpCcRO/oZQniVDtomKUfYaQzqe+1nxpNACx1zHs0UQGb1yskfh
         9qBoGb96s8uK+WBXLCSJUOE+1V/CwMS33SjRsz9VAbmPS8JFOryQrxIhJcjig64ObVvp
         kEQ2PDcUk9FutK1qvKjIXZX3oetjIZRlF+X+p77idjFdGycHwPOodtIl2jFu6YvEM9ja
         g5Kg==
X-Forwarded-Encrypted: i=1; AJvYcCV1wD6WmTHuBtqu4CbPb1pdkMtckGlYEOJlMZq4ABsa+TET5eZgIlq3lHOV2Kg23hI8cguD4+l1nMKULbtzNfNBm3w5vDbSIZA2jUcE
X-Gm-Message-State: AOJu0YxKTTtKxX7gAsTXFTaCzEZIK8Doj4qmN6f8NZTsyugBRLQyKXay
	/i62nvK3HrdtFKJ0bORq+fkKYikgjg1y5tVTjSIMCEoVzKtYSi2qg4BQsMRJAA==
X-Google-Smtp-Source: AGHT+IFg1QPMdHA0DRSxf6VJUzQ45OllQbVu8vufiSOrwX9IOEj3YyC0/bFnrFQ/txtE+F2DIyAU/Q==
X-Received: by 2002:a17:903:32cb:b0:1e0:a4e2:89fe with SMTP id i11-20020a17090332cb00b001e0a4e289femr115702plr.18.1711225837319;
        Sat, 23 Mar 2024 13:30:37 -0700 (PDT)
Received: from [2620:0:1008:15:3d66:4340:db89:5c9e] ([2620:0:1008:15:3d66:4340:db89:5c9e])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170902fb8c00b001dda336de37sm1950588plb.240.2024.03.23.13.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 13:30:36 -0700 (PDT)
Date: Sat, 23 Mar 2024 13:30:35 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
cc: cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
    akpm@linux-foundation.org, vbabka@suse.cz, roman.gushchin@linux.dev, 
    42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    xiujianfeng@huawei.com
Subject: Re: [PATCH v2 -next] mm/slub: remove dummy slabinfo functions
In-Reply-To: <20240321131733.268615-1-xiujianfeng@huaweicloud.com>
Message-ID: <8883b376-ba5b-58f5-40b8-0c15a6a6e256@google.com>
References: <20240321131733.268615-1-xiujianfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 21 Mar 2024, Xiu Jianfeng wrote:

> From: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> The SLAB implementation has been removed since 6.8, so there is no
> other version of slabinfo_show_stats() and slabinfo_write(), then we
> can remove these two dummy functions.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Acked-by: David Rientjes <rientjes@google.com>

