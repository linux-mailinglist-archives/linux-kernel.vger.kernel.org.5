Return-Path: <linux-kernel+bounces-32029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E672835579
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C331F21386
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD5936AF1;
	Sun, 21 Jan 2024 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="BZZe9MvG"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9D36AE3
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705836085; cv=none; b=nxWtPg6gOk6ZQ+68SM5ZkRQL9uNCPmPrhzR7X9t8Sl7rD66WlOE9SKniZAiBDy3qJi6djXVvtGSa0fnx/uEbNDkizDcgy2W0LbEh33Seaxh6jY0v0BmKKh0lZJ+J2/CXlSBZGG5tWtsu+qu75L8+sNx5XH2mWyxbS3+3whKHJc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705836085; c=relaxed/simple;
	bh=8UO3qbjWHZCXyqvXRq6xNC3hqjM0b5QnsPavUA5ujBw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LMzvANY3JKCxyCcgMtsqL4+gWxaYYDm/9HMyLDJCinfkhS5ormt2nGMNVfcziwZ0R9UgYO7Q3CZGZEGNnCNNuBZvnJuNTmkxbhy/BG6BqOg1DQzapn43/S0ay1UaRYD1HaQCUQ34JbVlnvvit4H7haKl/VBJ8sYul0Kf1czSYpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=BZZe9MvG; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=h2WPn6Ego06GRxcMe6RmIAum7jBpuI3hvgZ5Ctv8lLk=;
  b=BZZe9MvGBm/CybP4VqEyEz4a/w2mz8R8ev0qJQ9qy1AXWkdOJBVhox7Q
   rcWlD11pNGUDmmMVuyXpUo6zBWbAadnFGIxb9Etu6M/pyU286AtPnTOZZ
   +GYY8ZuA9hrlaFm2tpPp5GdSLaEfFfM/5MpA1V/KsWeNfa1RsFmS9J99K
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,209,1701126000"; 
   d="scan'208";a="147778071"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 12:21:19 +0100
Date: Sun, 21 Jan 2024 12:21:19 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Li Zhijian <lizhijian@fujitsu.com>, cocci@inria.fr, 
    LKML <linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [cocci] [v2] coccinelle: device_attr_show: Adapt to the latest
 Documentation/filesystems/sysfs.rst
In-Reply-To: <161c3be1-011c-4ffd-8646-1b95f1a461eb@web.de>
Message-ID: <alpine.DEB.2.22.394.2401211220480.3743@hadrien>
References: <20240119062057.4026888-1-lizhijian@fujitsu.com> <alpine.DEB.2.22.394.2401202217550.3267@hadrien> <f34231dc-186b-4cb9-889b-b3be9224c5a9@web.de> <alpine.DEB.2.22.394.2401211159350.3743@hadrien> <161c3be1-011c-4ffd-8646-1b95f1a461eb@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sun, 21 Jan 2024, Markus Elfring wrote:

> >> Would you like to consider the application of the following SmPL code variant?
> >>
> >> -snprintf
> >> +sysfs_emit
> >>          (BUF,
> >> -         SZ,
> >>           FORMAT,
> >>           ...
> >>          );
> >
> > It's ok too.
>
> Are you going to integrate such a transformation approach?

No.  I already pushed the commit for Linux v6.8, and I don't think the
change has any practical impact.

julia

