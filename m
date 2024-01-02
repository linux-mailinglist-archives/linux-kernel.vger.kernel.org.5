Return-Path: <linux-kernel+bounces-14468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69142821D6E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C0A1F22CE0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB51F10955;
	Tue,  2 Jan 2024 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O6qcUVpk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35D10788
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so933669e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 06:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704204592; x=1704809392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0CaqYteyDB6DSZaj2cT5acnP15a5TO5ZRNcWIqlu/lo=;
        b=O6qcUVpkHMj1aRPNjW5WAYaHAbWuM8RgXykCEnMpNRNrq4re4hYPqU2ulaS2LDSWIG
         CjGm709oTGZ6J13RdjdlTYoAkaDwSVsWRIQm3EbWARThWlKFWBSowWNqjOjUWJZI92PL
         rC09orsWUNvjePbkV+2Jas+7mL/fjA1xVDGuMahAtJoenqefFhd5+0tCpbuvt2/wRtBC
         kGYE8gA1brmfp0NIiWsmGwHZW0J/gsPXLaHoqAYQlKbkkQ5I8/IPFgDD8fXz+kC1Eeve
         /PJN6+yGOmNeu5sqV9W4KHTvdtxlXA1UuOR/0EBuLWGdMWnorK5Vx3qIXINgJmaYvklE
         rJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204592; x=1704809392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CaqYteyDB6DSZaj2cT5acnP15a5TO5ZRNcWIqlu/lo=;
        b=UlnF78S5gcHMtGch5u0jxgoesS+zxNGVkOPf1B+mi8YqOTqkW9+LHu9AdPdB7fkiZZ
         vAJeYQIVYa4+Urth50KT3EoYdERU3w/cpbjqO1mzrCCZqUBUqXCglY74Vr/kHrbH3+qh
         cHYAALftX/aO5EGlcscmtqfE/HkQPIssAJRuW3Ht/kPjy39Yat8L7ELItk1+RfHl2T2m
         cE3Yzi/2sIdATdxd1tV18EKwV8931lOwoAzeWSQ2Wx6AmNwtzRu4RJf/M2ttQwih2mND
         DnbKA8mKkndiOFSM8JByvkAuiKqkI2HFfMzw990kprcemFkasFf/waz1eBJJEJiEcJuq
         Mh9Q==
X-Gm-Message-State: AOJu0YxbTC8vhVA24gjRhQsWyTBhLWQnRQoeYSwFHXvLAcrVMjERtEjb
	Ap7j5FFN3QGufa246nDcf1PTlrQqpb7+9GO0LXEJpjpNk9XNVw==
X-Google-Smtp-Source: AGHT+IELL9nUa31vUXEX5h0bZNF4Tr1uek7jeQ8pU4/BAeKEpKlwSYfXKBsBWrqJmh62sjzGLdBraG4h6YhZDcbM+QI=
X-Received: by 2002:a05:6512:e9f:b0:50e:7b20:3092 with SMTP id
 bi31-20020a0565120e9f00b0050e7b203092mr5345311lfb.33.1704204592366; Tue, 02
 Jan 2024 06:09:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=OiNB+pPhb-3Tf7O=F7psKE3EOpwmbPSeLSOyuHpj3i+Q@mail.gmail.com> <CACSyD1P6HmH9tSvONnNxYv8P+am_hH2dK3UJQd9_+o6EWkPsXA@mail.gmail.com>
In-Reply-To: <CACSyD1P6HmH9tSvONnNxYv8P+am_hH2dK3UJQd9_+o6EWkPsXA@mail.gmail.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Tue, 2 Jan 2024 22:09:41 +0800
Message-ID: <CACSyD1Oq_0+y=2LbbMEJPtnm4tQt61pbP=CnqtprKan5U3-cVQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Base:
>                      total        used        recalim        total        used
> Mem:           38Gi       2.5Gi       ---->             38Gi       1.5Gi
> Swap:         5.0Gi       1.0Gi       ---->              5Gi        1.5Gi
> used memory  -1G   swap +0.5g
> It means that  half of the pages are failed to move to the tail of lru list,
> So we need to release an additional 0.5Gi anon pages to swap space.

Based on the results of multiple tests, the following information is updated.

Base:
                      total        used        recalim        total        used
 Mem:           38Gi       2.6Gi       ---->             38Gi       1.6Gi
 Swap:         5.0Gi       1.0Gi       ---->              5Gi        1.9Gi
 used memory  -1G   swap +0.9g
It means that  most of the pages failed to move to the tail of the lru list,
So we need to release an additional 0.9Gi anon pages to swap space.

Thanks again.

