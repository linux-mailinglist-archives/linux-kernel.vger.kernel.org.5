Return-Path: <linux-kernel+bounces-76059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D2085F270
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820C01C23306
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D4A19452;
	Thu, 22 Feb 2024 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZrzN+Gn"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8F718048
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589120; cv=none; b=DnKa8BlFnHJF+J5mLI3azjMbbh9Qi9OFmrp7Sd/6ijBvMulIWJYZlAmVIV1p+p4mmWPoAqvNgATC3M26ZoNPinpPzzwnsoJFeequ+PzDAq/8GYXHBRY4gr2e2OBu9NA7JGmHfitFC77EPl1r6O1/jFwP+VA4IXPCQwyjeSmxCZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589120; c=relaxed/simple;
	bh=H8y0VExe0EqJh5jKeAVExv4Qf/vyHTye4Sn8c50i+0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIB7++H0sFTNgXsdPW0YCpoQwu/cn2oT7U69Mt1gkXrHHz6PC3nIzveROW2cI2gTM4uGFwmDKmbfrFyy9lbaRNroNEJfObvsodxf9vBlXyL4R2g3cre+RGPm6uEY0+0VDCLfSC/wdNs//c/AvEgtwoD0BoNdHCmhyyM0iRf/rCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZrzN+Gn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e4841ce028so1700246b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708589119; x=1709193919; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7lXsgNHchdaAuraQyZst9y8PMmO/uD31+mOeALRf8Rk=;
        b=nZrzN+Gn1gxEeYdDQVJ+zCVTYEGOv7521wc82MEOGOey+Loc0QVnmezv84vyGyPvoK
         3hGSH251GxOIJheKphZC11u5U85CYq2oc6Jbe9yerKV7AxkwKp7hQ3UixD0avWIe7Fvj
         4Wpeox/pLWEl/gCAh6uSxVK+DwsLNlQiQfB8VZZ2+GFTZbRnr0tRilict0vR5MQP2EuT
         8/hz3sU4Hy5buAoqCDvQxvnq9+i7aXktBaxrODEyW81qntmLSeje0jDtlapQXo2yEs2G
         dxSF7FICuVrncfrGCVnSOiZh126nqoeT5EwFhpO3byeB/flIscJMQQXIUBKX82p+/e/y
         qxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708589119; x=1709193919;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7lXsgNHchdaAuraQyZst9y8PMmO/uD31+mOeALRf8Rk=;
        b=WWHySdLJZ/tI4FcZYM/aIU6FczLSkLB2jPZxhx/VRVFUaZ2lFnCzk0Uzs1GVEQloyL
         ec5PnkIJRgGGbUv1Al2dSDG2UmtH1ZLfXpSW2V5LUnAtKbmIX3lfy+5F2X+Gwhuqewmt
         LvSVurSSsjm+MZu3QUfdkkzwrxwqtYno++439z5Vs5yXPsQHDmq6hYRzBYDFUaxPLMI7
         mJo6dP67CMsMibCEu62AeuC8EiwggvLHPXlxGLWykgUBH6U1ZYoaanL7vUUqwvo3J3yy
         /88yasp8RgpztUSZAdSo9yts1qJooyDUMr+h9EKHsDSW8aOO9VXj99+UhGjXZO7gEiM2
         l1wg==
X-Forwarded-Encrypted: i=1; AJvYcCWxbgQAgagfzFFLjeTCz9yP6HQf9ZyUCxD759DSdYFNM4e7PRpz9perb+IrT8xGND/8aIX4qxRFtIf4gNfHVWtM+u0XUEBee/dQei2n
X-Gm-Message-State: AOJu0Ywvgq98xRNbZAz/JRSyd5+seHvaIZ0bZwkS07H5wpSg3bmt2tNY
	VL6SP5J4wOmCi+4/1bFt1glhQZTWHt9LOM6eNl93l9XReoa1WhOw
X-Google-Smtp-Source: AGHT+IFufpAdF4l+oCHHmNXrTCPl+6CIG54cDQXsyvWLrpNClK2zMw8WO/5HH+Cph1tpxz20mEaQ8w==
X-Received: by 2002:a62:bd02:0:b0:6e4:bb45:4ac8 with SMTP id a2-20020a62bd02000000b006e4bb454ac8mr2905656pff.26.1708589118621;
        Thu, 22 Feb 2024 00:05:18 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id y14-20020a62f24e000000b006e25d4085b4sm9897082pfl.27.2024.02.22.00.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:05:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 21 Feb 2024 22:05:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH 1/7] workqueue: Preserve OFFQ bits in cancel[_sync] paths
Message-ID: <ZdcAPKtxgw2ZUVFn@slm.duckdns.org>
References: <20240221174333.700197-1-tj@kernel.org>
 <20240221174333.700197-2-tj@kernel.org>
 <CAJhGHyBgjMWtob2VRWhxCRyNuUVMzSEQufza5TRn7Cw-hBaQ3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhGHyBgjMWtob2VRWhxCRyNuUVMzSEQufza5TRn7Cw-hBaQ3Q@mail.gmail.com>

On Thu, Feb 22, 2024 at 12:35:31PM +0800, Lai Jiangshan wrote:
> Hello,
> 
> On Thu, Feb 22, 2024 at 1:43 AM Tejun Heo <tj@kernel.org> wrote:
> 
> >
> >  /* Convenience constants - of type 'unsigned long', not 'enum'! */
> >  #define WORK_OFFQ_CANCELING    (1ul << WORK_OFFQ_CANCELING_BIT)
> > +#define WORK_OFFQ_FLAG_MASK    (((1ul << WORK_OFFQ_FLAG_BITS) - 1) << WORK_OFFQ_FLAG_SHIFT)
> 
> It can use GENMASK.

So, that'd be

 GENMASK(WORK_OFFQ_FLAG_SHIFT + WORK_OFFQ_FLAG_BITS - 1, WORK_OFFQ_FLAG_SHIFT)

I'm not quite sure that's an improvement. It's longer and more indirect -
the open coded one says "BITS number of 1's shifted by SHIFT", which is
shorter and easier to comprehend.

Another thing is that none of the other masks fits GENMASK either. The only
other candidate is WORK_STRUCT_PWQ_MASK but the number of bits in that mask
depends on the size of ulong, so it can't use GENMASK.

I don't think using GENMASK would be an improvement here.

Thanks.

-- 
tejun

