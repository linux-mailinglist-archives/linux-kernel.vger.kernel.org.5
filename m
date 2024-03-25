Return-Path: <linux-kernel+bounces-117801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C77888AFB0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E27B1C61EED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D661BC20;
	Mon, 25 Mar 2024 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMhRivhb"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAA51B969
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394379; cv=none; b=ko+acBGdvTWWUUFahHn0GCDAuGv1y71o1rbtY7i1IyAuqFJciPNDoyFC1epqLJRNLJLmNzlHrXQZyzOMxsX198rKEr6S7+XcHYo+gqx4yRSei2Kflqu45IiVUJy3hKAnLpt8YqNL9GYkhh7ZpRNu7dhTq+oMp6PUYjzCSUMZKTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394379; c=relaxed/simple;
	bh=UXoE6gNvexq6RzQDKcfVEH//h4NSGarMHdqugOZ2GPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGS2JPGysBUgRNznvcR/OeRT3GXGoLIqobOT2DG2C/nr/C6PGy0ttBjPhSyz8HnFb16TFTagrhHd1Px76+GKGZwuaX8zAg1lSAicGTYUm4BxKNXwrtY9lX2Vs9+dk30tdIsGTRj4zIy3ExJGUJaq2gJVQQNJBacIfUUi4BuumP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMhRivhb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso3227726b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711394378; x=1711999178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1HMDfEEMbk9wuNsh7vcv6iAt2aqAQq0VhaZwldUM6/U=;
        b=aMhRivhbqn71Y/KH2V/fSJTTIzG7XTeYu7gz++6mwBVn3uDpHATDGZmS/vjhC6ubHh
         /s4XrGDjHduwm25bRGMhxyThW6GFasjzFgnz3CgeEe4+P5JThlzVThUtBkRZ7CUSBVc0
         ZGK/IvWEa91eeKHaIj7ktSey92xGh7m4MyjfNaNtDWKc9cJE54crFllJ+LNubQjHDpbG
         GsxLi/2CW3vpGSKG5ZjP1Q/Z/ulj386fQHS/GjlGSNpkZbHSQuYTyZ1h633qqkXiaF3U
         BtbQ0ki+b5X3OMExzm8qTXtkPwuT6JmiySzuFXZULnGXuiPu2vDTg+I1QOOl+Z/Wan+O
         /Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711394378; x=1711999178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HMDfEEMbk9wuNsh7vcv6iAt2aqAQq0VhaZwldUM6/U=;
        b=bp/hbFogIhJOyftvKsw/1cfewF/fHuExV55bXena5vpVwyoQMJYUA4ti31OWmLuO+5
         kp5loBQ6oAoqx4tntOnyOAuUeX3xrSngyXhmwRBYEpnX2OOdYsSxS2ik+tJ+e3hVt7V6
         VTe5fB2isG/e+uDdIxJEr9sqQzEdRhjGbg++nMFJDdcn+00qMr5hKd4JLirnKTHXuaio
         4I9WfzE+8HOCADBHdwYsZfiwatynahEMQeL8GhQu7L9MIlWcYYjzmuPWx//8AhlFoxH6
         pUlXFd+2/Qmh5Ng70Et4cwjR3QDSy4HXDLxX5moGPCllbDw9hqmguAT5Q1bWK+V65MsH
         GLOw==
X-Forwarded-Encrypted: i=1; AJvYcCV5VLWDlCi9viNPUfLAZVeScez6ATw6KnvTLqSy1M+FcJ49V/ha4xefRTIOEXBBs1dla7nEAOfyPKrPQVbbRF5zYSLpXp2k+i/9fMPU
X-Gm-Message-State: AOJu0YwD7mx2leH9ddv9Ttw1WboZ5Bqns23bRLCzIvlYvGKTKzYjsMr9
	me5qGccBlOdxDheaLK5sB0qAN9oo+bc7vO94/So+b2oh+r9iniu9z8Ky1pBu
X-Google-Smtp-Source: AGHT+IGa7/2pYDaZi1cFnfHgdA4th30w5FVEbr9kROAJyDZVsW9AgENtTY6GgUxoJkIVhttFFge2wA==
X-Received: by 2002:a05:6a00:a0d:b0:6e7:82f4:d904 with SMTP id p13-20020a056a000a0d00b006e782f4d904mr10626240pfh.11.1711394377058;
        Mon, 25 Mar 2024 12:19:37 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id b187-20020a62cfc4000000b006e73d1c0c0esm4656204pfg.154.2024.03.25.12.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:19:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 25 Mar 2024 09:19:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Cleanup subsys attribute registration
Message-ID: <ZgHOR3BA2ui5zvVH@slm.duckdns.org>
References: <170987627011.449367.8705596691078598981.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170987627011.449367.8705596691078598981.stgit@dwillia2-xfh.jf.intel.com>

On Thu, Mar 07, 2024 at 09:39:32PM -0800, Dan Williams wrote:
> While reviewing users of subsys_virtual_register() I noticed that
> wq_sysfs_init() ignores the @groups argument. This looks like a
> historical artifact as the original wq_subsys only had one attribute to
> register.
> 
> On the way to building up an @groups argument to pass to
> subsys_virtual_register() a few more cleanups fell out:
> 
> * Use DEVICE_ATTR_RO() and DEVICE_ATTR_RW() for
>   cpumask_{isolated,requested} and cpumask respectively. Rename the
>   @show and @store methods accordingly.
> 
> * Co-locate the attribute definition with the methods. This required
>   moving wq_unbound_cpumask_show down next to wq_unbound_cpumask_store
>   (renamed to cpumask_show() and cpumask_store())
> 
> * Use ATTRIBUTE_GROUPS() to skip some boilerplate declarations
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Hi Tejun, just a drive-by cleanup while poking around sysfs.

Applied to wq/for-6.10. Thank you so much.

-- 
tejun

