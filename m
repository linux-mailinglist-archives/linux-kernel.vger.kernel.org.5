Return-Path: <linux-kernel+bounces-125576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665898928F2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDE01C20F72
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 02:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5611C3E;
	Sat, 30 Mar 2024 02:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="TbqJ7lQU"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4D917F6
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 02:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711767349; cv=none; b=AWJ0DDn0Prm+lT7stfpiEFkEBaenHaDMEC08Pzsqf8NuFjo535VcrlrrAr6peXfnvScAQfWUiT6sKTcbvOsVbZxflNLeDE3xYXzCekESyIsXjt2dm3uvcACeThpNqWP9u5eyds1B3AgPmBj4xER2eeK+94z64YKGfQbaxMdM1lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711767349; c=relaxed/simple;
	bh=0VnDNUx5No0InUGDHz18xd4XvgnzvL/GPmTikaNRNSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbZ+/Lb6hxrzCsrTJBil6C5ORWaZJRMKj9iuJl/w/mJeB+fRAlbXg1WxKWv/7yUptkx6KPhMTP492sA2MErsbLFp5IcpbIoXIsOTspRK9oEGPqfiTD3v8liaDN50FN77sWSQ8aRjUj/cMfC/kebdRzQlvXlVhco9rUPEmsowuWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=TbqJ7lQU; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=TbqJ7lQU;
	dkim-atps=neutral
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 49DB9B94
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 11:55:47 +0900 (JST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c65e666609so2029050a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1711767346; x=1712372146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8glfhFm/X2eIF0Nkd61jE+/iOe2enj8BzdC/2dzRn+4=;
        b=TbqJ7lQURAYRiLzRWgOxl19cKv8YG6mlF30+JYFIFCmiCjn6zVCp776wMgkBaxKqTV
         QHhbUsuXBNN8r+8hYaIzLWijBbOWg9IyY2Ff9qhYdQ3h/vq3v1qatxOWZ1GihIrSmdhn
         z4hq/1jGXQHVynXuqjZ5Kp7qmlYpfIAg3IYpn5Vp1vkSnme5koPhlQbjMAbebtsO5vd8
         mfBgyP3T5yghtsyuOq2ReAQe2cdYDgrEp1jmJPLVjYl5rJpaTfIdVOylLwCgnclOyAcl
         W6JwyN2Aq6lBk4EZuNowB1SKe2aU5Uu4xLRA+jZDdjxhB/dBL0DcANB8MnkCWw8T6d8P
         5uAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711767346; x=1712372146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8glfhFm/X2eIF0Nkd61jE+/iOe2enj8BzdC/2dzRn+4=;
        b=Vnz7/VgWSQAdiX6bt33rAJ71XUAlALqV8nNBLOTUO4UGfS39gOLfTE4epOHRbOAKZf
         iAq9mIlHQtHcaUkHrukgQOEZivvHaJG+wpVwF4A4DYv7fks6/Jv5mF9BsIMMNWu6PWMc
         V7luYwDDLpLlMAAX0a7L2Iz8CB63WcqT+Okp6s/NoQHyuFSsYu1wV7iF+yOahA/wnEFR
         Plwv0aNJFuLwC0+m7nuK87mxBgnYkYfjhzgX4a4DBvM5/EQdA+hiZemBlyJyLvg09YfE
         3xgDusc4oZ946Ba5535wOd9W97U4gjV8dUFQZXaTT3LYmUIF2docz7USMvx0OfLawKul
         7rFA==
X-Forwarded-Encrypted: i=1; AJvYcCXOQaIgJ6/N20bsf4ttzrair8WBc6CI1L3AdYIFgkrSsetEjsrnITT58Tk3SzQM0ntO9y2BupgjhrPjfkJkIwTgz96WNYmNMsT9M6A6
X-Gm-Message-State: AOJu0YwJeRvaowN8+l3aIIQ+apXs1G+JJM+VEr5lNe410CqDrUhV3m+N
	qyDcjgenjiiuvPJCVeFl8lh3I6kCsELVxWHRBn8Wx9TvWU7aMQzVkItlVoCaWB43+dEqAp+ZEcZ
	E+szNOItPu7LCSH9mykYXwjgLNmWrFxmUIvJEd6GOYCZVuy9x2m3VEkK1GyK/1TM=
X-Received: by 2002:a05:6a20:a128:b0:1a3:dc59:764a with SMTP id q40-20020a056a20a12800b001a3dc59764amr4414535pzk.37.1711767346189;
        Fri, 29 Mar 2024 19:55:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4xb6OliXnzmmC+a2AvHpBjl34nevNeqiwBBaQDRKuRe8GNrieLJEfK4fFkOXc+0OJ1x4pUQ==
X-Received: by 2002:a05:6a20:a128:b0:1a3:dc59:764a with SMTP id q40-20020a056a20a12800b001a3dc59764amr4414518pzk.37.1711767345737;
        Fri, 29 Mar 2024 19:55:45 -0700 (PDT)
Received: from pc-0182.atmarktech (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902a38700b001e0a08bbe49sm4225745pla.140.2024.03.29.19.55.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2024 19:55:45 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1rqOsh-00B5mf-2u;
	Sat, 30 Mar 2024 11:55:43 +0900
Date: Sat, 30 Mar 2024 11:55:33 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
	"bumyong.lee@samsung.com" <bumyong.lee@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"petr@tesarici.cz" <petr@tesarici.cz>,
	"roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>,
	"lukas@mntmn.com" <lukas@mntmn.com>
Subject: Re: [PATCH 1/1] swiotlb: Fix swiotlb_bounce() to do partial sync's
 correctly
Message-ID: <Zgd_JaCHzOOLqWUM@atmark-techno.com>
References: <20240327034548.1959-1-mhklinux@outlook.com>
 <ZgO3HlYWo6qXaGs8@atmark-techno.com>
 <ZgZNAM337-UEY1DH@atmark-techno.com>
 <SN6PR02MB41574B5BC91B70AE74E51FE6D43A2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41574B5BC91B70AE74E51FE6D43A2@SN6PR02MB4157.namprd02.prod.outlook.com>

Michael Kelley wrote on Fri, Mar 29, 2024 at 03:18:16PM +0000:
> * tlb_offset = 1 - 3 = -2, as you describe above
> * orig_addr = 39 + -2 = 37.  The computation uses 39 from
> slot[1], not the 7 from slot[0].  This computed 37 is the
> correct orig_addr to use for the memcpy().

There are two things I don't understand here:
1/ Why orig_addr would come from slot[1] ?

We have index = (tlb_addr - mem->start) >> IO_TLB_SHIFT,
so index = (33 - 7) >> 5 = 26 >> 5 = 0

As such, orig_addr = mem->slots[0].orig_addr and we'd need the offset to
be 30, not -2 ?
Well, either work - if we fix index to point to the next slot in the
negative case that's also acceptable if we're sure it's valid, but I'm
worried it might not be in cases there was only one slot e.g. mapping
[7; 34] and calling with 33 size 2 would try to access slot 1 with a
negative offset in your example, but slot[0] is the last valid slot.


2/ Why is orig_addr 37 the correct address to use for memcpy, and not
33? I'd think it's off by a "minimum alignment page", for me this
computation only works if the dma_get_min_align size is bigger than io
tlb size.


> * size is still 4.  There's no computation in swiotlb_bounce()
> that changes "size".
> * alloc_size is pulled from slot[1], and is adjusted by tlb_offset.
> This adjusted alloc_size isn't used for anything except as a sanity
> check against "size".

Right, sorry - so size is ok (assuming slot[1] is used, I conflated the
two sizes.


I'm probably still missing something here, thanks for bearing with me.
-- 
Dominique

