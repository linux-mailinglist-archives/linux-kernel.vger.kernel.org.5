Return-Path: <linux-kernel+bounces-9513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2862F81C6C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B4DD1C22655
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF7BF9DE;
	Fri, 22 Dec 2023 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeKwTsJw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A9DF42;
	Fri, 22 Dec 2023 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3dee5f534so19715595ad.1;
        Fri, 22 Dec 2023 00:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703234597; x=1703839397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEUyZsx1RFbSwcEw8c3ANFWhuGTAtkuoqqLQilnp4zE=;
        b=BeKwTsJw3g5a/IPwHHonsZlMQtyRxFvieqcmiq1Anx1JKw9XGZ8KJXxvATYq3OZ9D+
         yn1RWZ9ehXBLeFAD6SP6OzWqsfw/RR4lq35OYNyXglHV+yYW4NJjUcp+zPWBPtGJ/E0S
         H+MCzs3v4HAJxZEELbLovoENkelo0HAE5yfwR6MM7OTtTr3JqkQQkYiaJfQZzFGWDyXx
         89pWjGsXTW6+zL3N0BPVhvvhzdN63k+w3E7OmvWZKfO9C5tdvR5OLVsFO7DE16iUuOn1
         c84t8nJSealwiibxjGXgvgmjSkF7zIjchW6hLlaPbAhtlY52ZysamGmSTLvi4ixl6gqD
         o5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703234597; x=1703839397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEUyZsx1RFbSwcEw8c3ANFWhuGTAtkuoqqLQilnp4zE=;
        b=D/0AIVBuVJ07xtyQeOZlnEHDwS0Y8+z0r0DMdayqaiIqk5ifuUHPUOhB+rxtx5dYU8
         wUtDdseczKfZdmW5mj/YaPDiCuFseRb+1F+lGLprOto7XBzytDanG8Z90J4ckEGond+X
         RsFtTHZWUXeieyi4wvMIjBw1lpZjO7CMKmVxzJv7AxjVpJacXyGIN141odjDXng+eX9j
         bI67t6U/mQsMvEZZiGht4wwa6B1ajAF1qXwoNxHd0Eci3DiPwj+Q81Bepecu4wP8+6nn
         OXPwUuMAiq6RclwavlXr3NMoWq3ebCcGM8Nv8LBR1kvbuYKIFE2IRRU1bH90mShFg2L6
         k5mg==
X-Gm-Message-State: AOJu0YxbCEyma6CYRvMPIVLU9sYBR/Q+zBLLQo/g1B6yF4ifT9n3kA+2
	GHU3lRYGEUG1eyAlJOFh7BI=
X-Google-Smtp-Source: AGHT+IHrpQsrggaKmfmv1uB9n08kCC/Cs17bwN6uju3OJHHg3jjSx3hhXltw63wbVH/iiAwh6FH3Yg==
X-Received: by 2002:a17:903:210d:b0:1d4:1809:7b86 with SMTP id o13-20020a170903210d00b001d418097b86mr903439ple.53.1703234596813;
        Fri, 22 Dec 2023 00:43:16 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902ec8500b001d04d730687sm2919062plg.103.2023.12.22.00.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 00:43:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 22 Dec 2023 17:43:13 +0900
From: Tejun Heo <tj@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patchs in the cgroup tree
Message-ID: <ZYVMIamGdgG0AsyD@mac>
References: <20231222142049.397619e5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222142049.397619e5@canb.auug.org.au>

On Fri, Dec 22, 2023 at 02:20:49PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the driver-core tree as a different commit
> (but the same patchs):
> 
>   2bf46683842b ("kernel/cgroup: use kernfs_create_dir_ns()")
> 
> This is commit
> 
>   fe3de0102bc8 ("kernel/cgroup: use kernfs_create_dir_ns()")
> 
> in the driver-core tree.

Sorry about that. Missed that the patches were applied to the driver-core
tree. Reverted from cgroup (it was top of the tree anyway).

Thanks.

-- 
tejun

