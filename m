Return-Path: <linux-kernel+bounces-74996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7AE85E123
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD12F28428F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E7E80627;
	Wed, 21 Feb 2024 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mmJQK06I"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06A27F7FD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529472; cv=none; b=uOgxiJ1/O5/J8yIuEuwMhcCb5mH432Mm73iKskbl6bLtZoUj0kEGvujvQe2J7yUCoI9SZNRheP7YZBJjyPr82kxLuZKUcft6adWtpDqzbjpPUAuVDhY7oYgkMBjHBairxKBxoYyZlTOhGpPIpXI2bz1/o/yFAFBCijSeS8BxlJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529472; c=relaxed/simple;
	bh=jfPSTOMFsVKRVNj7i8lkM+J2021KR6bAVax6Lo6yiIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXWCykl5h8NyeE3L05Sr3B4fizrVk5qwX9BT32D96ep/CxfyLdL1gknRSDftxXylzG+TjV41RqsWmaRw7qS60O4OyhdRBSLdt6CddA4o0ECZnNAVeh4bqxfnrgId8BZ0YOCgyZkBMNCs45NjL+rgRrxUUELc7H9PAcCMc/gKCgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mmJQK06I; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7838af983c1so491808185a.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1708529469; x=1709134269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c8vitvLSu3BTqhP5sHDKjXQCZ2zP56e0qTlYZFKdquc=;
        b=mmJQK06IbHLsFZq0E2JWBzGlRGtftqJ09T+fBYOtuW2WNPcyH2nEMBiah4Q1GpJowW
         BaoEKiYdCY/ELiZOeVxQFH+GVWw/9H3eO4pH5MKu2bCY6/w/yH16WHCSBRvimZmsLHJl
         7791vzaASCH9nYXtUb31zoMQVxRAAmUzXiJKlbZbE99CZZhAs7ME/NGRse+zKdubciT8
         a+kBdpmONJZGKT5ewfdTtZVYY8/vreLg/2RwTVf1+1TM2sek9fmMX2s3bRpvX9+150pY
         8nCFdbwv0ifgWSt2XqUJqvNNN6z0cjUbhSzj+PUcuUG13OumxFHdob/jEmr90sBxqAyq
         I2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529469; x=1709134269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8vitvLSu3BTqhP5sHDKjXQCZ2zP56e0qTlYZFKdquc=;
        b=JYgziH6jDk1H3FLvt9VsyBDek7Sa4pVznBM7UZXqG0d2shvsAGpRA6oFXIEazWvrUx
         szbX0Jv9/QLXOOPc9ujtcRGJDQ7wHSLbsjjXKhEx4NhCCE9ECP0sxH16RAmA7rggW0if
         svrcL48ztO/Ffd7KXzz8//ULSkhUBY177wyr0nY3hRKikIZB42fdL01c/q+ox5dh6X1b
         Y5o3Mo7ERs/V6t43mBT5uL58JPcSjAfUfCAetvL6vSaXkYbFlLC7shCT38V+jbXBV6g+
         2judzZP/MZO1/lS+T433bVOnBe+QLjdBfpRDC+/eo8gst6yeccTFbmPSH09aqez5J/dQ
         fJ+A==
X-Forwarded-Encrypted: i=1; AJvYcCUZEJYzWZ2hYybSbLRjSuX4XaX3sR/csJaE5Tn/Pvf+L8mLIvaXyU4ZWxGmlckSPp5SfFm8QZ/YPDf1QHmb/RSwkdRoHEtfhBmVtz/w
X-Gm-Message-State: AOJu0Yyk8DPbl20cQY+TUc8Dm227K/f+kK5tcN2ETYe1NLtt6JmTBp23
	C2CGbakEv1DY+ct2Wn6ShvYoKHSko3EgSANbDiG0f+BSa3O33qw0epUJxvUM0lM=
X-Google-Smtp-Source: AGHT+IEmPbtEB1n97pNqLMavAZrpmnUWZQCFJvhv79vGkSBI1itOYArJupCiyzSQO8AEzyfqYrdwxA==
X-Received: by 2002:ae9:f80f:0:b0:786:2d19:93cc with SMTP id x15-20020ae9f80f000000b007862d1993ccmr20111512qkh.73.1708529469737;
        Wed, 21 Feb 2024 07:31:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id oo8-20020a05620a530800b00783f8693df1sm4420166qkn.37.2024.02.21.07.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:31:08 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rcoYu-00BOuq-6n;
	Wed, 21 Feb 2024 11:31:08 -0400
Date: Wed, 21 Feb 2024 11:31:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Huang Jiaqing <jiaqing.huang@intel.com>,
	Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Use device rbtree in iopf reporting path
Message-ID: <20240221153108.GA13491@ziepe.ca>
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-3-baolu.lu@linux.intel.com>
 <20240215175534.GD1299735@ziepe.ca>
 <67391b2d-b441-4d43-aa46-2a30c95420a3@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67391b2d-b441-4d43-aa46-2a30c95420a3@linux.intel.com>

On Sun, Feb 18, 2024 at 03:02:00PM +0800, Baolu Lu wrote:
> A device hot removing goes through at least the following steps:
> 
> - Disable PRI.
> - Drain all outstanding I/O page faults.
> - Stop DMA.
> - Unload the device driver.
> - Call iommu_release_device() upon the BUS_NOTIFY_REMOVED_DEVICE event.
> 
> This sequence ensures that a device cannot generate an I/O page fault
> after PRI has been disabled. So in reality it's impossible for a device
> to generate an I/O page fault before disabling PRI and then go through
> the long journey to reach iommu_release_device() before
> iopf_get_dev_fault_param() is called in page fault interrupt handling
> thread.

Why is this impossible? Seems like a classic race..

Flush the HW page fault queue as part of the above to ensure there is
no concurrent iopf_get_dev_fault_param() on the now PRI disabled BDF.

> Considering this behavior, adding a comment to the code explaining the
> sequence and removing put_device() may be a simpler solution?

A comment is definitely needed

Jason

