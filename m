Return-Path: <linux-kernel+bounces-43301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A138411E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0321E1C21358
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F636F080;
	Mon, 29 Jan 2024 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZB6xfZa"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C03F9FC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552183; cv=none; b=nCorAI69gIzxjVUwwGgq/40nshksSQnEaXpNQNId5WELR/UpBCmBkrBCe/u+bnx6AN5tMhYUeyzq8CuODn8G+wLDokqcQRaoDE991u57MKoe/IkP0uf7NAKBLKYcoPi0nepniB823abZYvLQgXOtaL8IX2J7B95nB1Nn9AVwxEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552183; c=relaxed/simple;
	bh=4TWZ4WsxRlDcM1yW2EecnzCe9JTpQcCO+ieUAB1Ukg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckUodnHPfu6ujdf4blkpS55ZbPTTCk7l5ERoSJEQJ83OsZqLi7ruwGt9ymFYVm+H84o81gIxSSjHvAZ6B1yQYRt5tLd5bctEG50fY6QHhTuFuFWrtAukjvHNxEZ49q1/d5OFBCq4fLEJXVs7dfUjMrt31zeULIXjwcVEDExxDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZB6xfZa; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d51ba18e1bso29182625ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706552181; x=1707156981; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kqyU9DXwN8j46E2KrXUrO2lXrMIFjFZ0DrupptOiWZw=;
        b=ZZB6xfZaHXtJ8+zb8TWtobIRy1vqLiQYj7/FYF5ey7rzAQg2eu8DZTP8Qi7BBBSQ7f
         ioAr4SNVjBrC5BMp5rB1xllQh3klvn3l7u1Y2pKYmyAOWeerGopQ4PfQoZdAW+a5PFSR
         3gr8hVf1owknpLtUxzsmfl2OhzNr3Izij1W465W1QAnKGbGTlotILRePp6wnDpkLwMCS
         +/Ffgrhf5YC57WN2Uyw3YgAYmrCh/Eb/CRw8a4eXcDManlW8jfediHfnFhTSr6ANzXYm
         hWVC+DYIq9w7ZtWJIWYMIYDG59CSj+ThI7rGAjstYroZmGRx8SFpO3cDfBNjKOp9R0mF
         7vUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706552181; x=1707156981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kqyU9DXwN8j46E2KrXUrO2lXrMIFjFZ0DrupptOiWZw=;
        b=gHo0eL2ZaiHCn/0MRujooLKRu97Zo79LM2uxS92q2BxYXxz8ksczJqOSNYhJ4jqGJj
         RXeQR6LW/SzBjZLIbwQO6eGiyh8vDI2vFHwmNxlJ5G3L2b3KsI3SrgV7OseTCKh/deQ2
         Whfp6eht2NdLaUzmJMZ4opaS/1WDRSPCwSqXNr1HAEKysbm2WPnK2REGyDh62zLpSkds
         Ha/kWzo5brx68qVt2IEl22+F/jDt4kTKtcVUx7SBCqn8g2SRZL5JcD1BThpMkB1+B3vP
         JCVDYBvy1S78l72/OUjrFaOwJ8FbeN03+RgBSun6dfgFiIftSEeFnvGkVnFFV5xWADc/
         IT5A==
X-Gm-Message-State: AOJu0Yw2fU0ZL7ycy265Vb7TUWfdVMl3YXtVoblnh+l/9imyYeYBM8lj
	pWmEGFSY+vjd9XRIi4XT6cW/6Ouu9LddWYhzWdgb/aVfc5AEQASYa9kPe/es
X-Google-Smtp-Source: AGHT+IH9tPkBWGOEAnVDZvo+C4jPC6Td+LamA27dO+2bpJfn3kVt8MEdJYsE3Ml4FrVJVHhsiR7+EQ==
X-Received: by 2002:a17:902:7482:b0:1d8:ab46:c18 with SMTP id h2-20020a170902748200b001d8ab460c18mr6045754pll.45.1706552180698;
        Mon, 29 Jan 2024 10:16:20 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id la13-20020a170902fa0d00b001d8e9750b0csm1747228plb.52.2024.01.29.10.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:16:20 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 29 Jan 2024 08:16:19 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCHSET v3 wq/for-6.9] workqueue: Implement system-wide
 max_active for unbound workqueues
Message-ID: <Zbfrc__7_kWow5wG@slm.duckdns.org>
References: <20240125170628.2017784-1-tj@kernel.org>
 <CAJhGHyDHP97ZHbDwPwhiYvBWbzvXw_UnXhPs4RRJ6nQBo3_x=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhGHyDHP97ZHbDwPwhiYvBWbzvXw_UnXhPs4RRJ6nQBo3_x=Q@mail.gmail.com>

On Tue, Jan 30, 2024 at 12:07:33AM +0800, Lai Jiangshan wrote:
> Hello, Tejun
> 
> On Fri, Jan 26, 2024 at 1:06 AM Tejun Heo <tj@kernel.org> wrote:
> 
> > This patchset includes the following patches:
> >
> >  0001-workqueue-Move-pwq-max_active-to-wq-max_active.patch
> >  0002-workqueue-Factor-out-pwq_is_empty.patch
> >  0003-workqueue-Replace-pwq_activate_inactive_work-with-__.patch
> >  0004-workqueue-Move-nr_active-handling-into-helpers.patch
> >  0005-workqueue-Make-wq_adjust_max_active-round-robin-pwqs.patch
> >  0006-workqueue-RCU-protect-wq-dfl_pwq-and-implement-acces.patch
> >  0007-workqueue-Move-pwq_dec_nr_in_flight-to-the-end-of-wo.patch
> >  0008-workqueue-Introduce-struct-wq_node_nr_active.patch
> >  0009-workqueue-Implement-system-wide-nr_active-enforcemen.patch
> >  0010-tools-workqueue-wq_dump.py-Add-node_nr-max_active-du.patch
> >
> 
> I just left a small piece of comments on patch 8 and patch 9.
> After they are resolved, for patch 1-9:
> 
> Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

Updated 8 and 9 and applied the series to wq/for-6.9. If there are further
issues, let's address with followup patches.

Thanks a lot for all the reviews. Hopefully, this should address the
max_active issue for the long term.

-- 
tejun

