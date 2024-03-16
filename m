Return-Path: <linux-kernel+bounces-105182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D44F87DA36
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130611F21750
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 13:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC63318AED;
	Sat, 16 Mar 2024 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="BZVbZMGd"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E6517BAB
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710594004; cv=none; b=HjWLubwLl1EhudkjwNnJENAU4twrQZMvPTC5NgoDgrca8QbD+uveIkpfiRY8BQHVcz+TaasIIiGXXJJPpSUqS028+NmTz18zRUY6fZnilirTml8ytG9f9wwzJvDGi8z3c36JbGYduaFbacDtFgjIlctgAXgVpbww1P+2vZWr/7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710594004; c=relaxed/simple;
	bh=v8Rox1ogxmz7Ft/ssmsIOWeO1jLLouxlki+YyqgVA3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqXMb+/y6xp3Dm58Avbb6s2Ug4YUZWBqMhKog8KotUCtK/6B7rnC9FAVzSrRDH/kE9YKE8paro3f/M6LeddB8AwkpSEOvAjdfwjlDLDgdT6vMLxA5EHrjxl0fa0LNd0H8oYk8od/SdsvyBU4H6Gsibvl147CGY8bc8Ze00rw7Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=BZVbZMGd; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42a9c21f9ecso14619911cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 06:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710593999; x=1711198799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M6JBV1o4tFTfWcpNa8PqFJZZHeTUvsNQYMGRSklUsd4=;
        b=BZVbZMGded68IIZRuhI9Xd0ThgYOn7CD7uotrKBX6mOtWfyD77r+Um5VMIArakDnxF
         OOF4VxQwL637Jfi3wZ4ePpt9bceMMoP2MHXlN9IixtkInf+OSUNzBXA80xIyBXHx2Lf3
         StigB6H7KdgV/av0qUaQ1Vvn1sWsC8d3oMT63kFmud6CxDQUti6QCL97EAlAYNFMW61h
         LmJBmp0jKBbX6ZpaHR3kse10wLqsEisiLhkDZaIWjUsLXa+giXGWqaYtaH2o05GgIIQT
         O8vECkNH8B9tTx2QKzfVzSF1pVkJsxXg7dI+kDR544yl9PbIA54ifll3/lc/ON7lNdkc
         bjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710593999; x=1711198799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6JBV1o4tFTfWcpNa8PqFJZZHeTUvsNQYMGRSklUsd4=;
        b=j7n7AHOpi41Qt9/8XYXj9+bGo9DaiVT5i6MIr2iKFMgplrIhfhAcoApJfW7gTUrVLm
         roOv5snAHjkE/iacbJVEv6YKC7JQoQke5KXjGURy6pcMoySUTsjjuIYdAIBcHt0lTtQy
         F4PRyuqBFhQBw4mgmUBzJGHTZimW4n1pAP7cSNakuK1G9f5knxe+3I08Xc/3pEpIDRxv
         mrAbTZkFtOCEGEEn4ZvIRjtT2d1g6uWNJWGeVJ2mI0pfHFnei1amkpFO7KToH0YkprFL
         vWaKBUTvfqW7FFwDJ4URADNnaenfbR3HnIwREb0H+bnT0lhPnzSWRY5ndaCf547AN8+M
         lnOA==
X-Forwarded-Encrypted: i=1; AJvYcCUwNdPGqWGSxAlrw9MPck8xG/KO86WVrYYTTpz1vi779iCfEdmGsr5IQxSBKOochnsv3cVonQchaN/mvv6Kh82Z/RmPev7tOz0A4oUm
X-Gm-Message-State: AOJu0YzrZFXck1gdtm9bnU9B8/HoNPpHWPZq8iWKUO/91YDfP1O196xB
	ihCPT79Q4GruQtFr2p327pBlxeNVvS7J4MiUJRNVNDujSxuCQaC0BfRVLwVgI0g=
X-Google-Smtp-Source: AGHT+IHpbFzgEKXjojU4Ggg7u9Z9cA1BJvuMtFASRZGmdq/PZOEzx9uD7HWVPRTzb2D1RTSJhIHPPQ==
X-Received: by 2002:a05:622a:1b1d:b0:430:ad8b:6138 with SMTP id bb29-20020a05622a1b1d00b00430ad8b6138mr6934246qtb.29.1710593999390;
        Sat, 16 Mar 2024 05:59:59 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id k20-20020ac86054000000b0042f43a486c9sm2661625qtm.77.2024.03.16.05.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 05:59:58 -0700 (PDT)
Date: Sat, 16 Mar 2024 08:59:57 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: add NULL check to obj_cgroup_put()
Message-ID: <20240316125957.GA372017@cmpxchg.org>
References: <20240316015803.2777252-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240316015803.2777252-1-yosryahmed@google.com>

On Sat, Mar 16, 2024 at 01:58:03AM +0000, Yosry Ahmed wrote:
> 9 out of 16 callers perform a NULL check before calling
> obj_cgroup_put(). Move the NULL check in the function, similar to
> mem_cgroup_put(). The unlikely() NULL check in current_objcg_update()
> was left alone to avoid dropping the unlikey() annotation as this a fast
> path.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

