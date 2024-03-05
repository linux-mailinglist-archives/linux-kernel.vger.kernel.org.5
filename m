Return-Path: <linux-kernel+bounces-92683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 037C1872447
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D511F25F79
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC3C12BEBE;
	Tue,  5 Mar 2024 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="SpUKm+oi"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B0C128374
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655964; cv=none; b=ED8FYV2j2vg7XAECfZRxrUQY4CRKkw6YqwRDjYDz7x/t1oQm57+G+lgdZExUrMe90DRsAWRZj7J89RJhEq8aJ8UGQlslKlIuaENH6eInwUJlAWaK2ZD6HYe6kfA/dRDG0fqTUr5vy8e8mtalbqG04W5HMRmWN1I++N2YsGmrwo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655964; c=relaxed/simple;
	bh=E68eN6+UOkvcGKAHH1fjK0u2L9AHcuxr8SMH3o/ai24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtFyAG0HzIUFuigOOl2VxMlIJz6SBvIjuaSFzVzhieorCtUy4W1mM9RrQIW/Q0+Nh/TWU0w4PyIBZlUnq7Qd2XFqhyWf1h44BtMamk67J1G8Do4wlKh174D3omMb8fA9vo0ETa8jsrxTVsppH8Uns2yeZTIY0RXd1YCSSPN9bsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=SpUKm+oi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e55b33ad14so3562248b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 08:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709655961; x=1710260761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FkTf9XC1FRr3KOSelsQrNRpfQiCYC4Aa2jODKzu4UZ0=;
        b=py0skU1bDscCzFFrL+pOwY6FvovHe+ooPwpSpC/Lg9lgCgJ0BcH5fL0DyOj4kGuEas
         Q5Tgpq/7eAbz4QBOI0zJ2Eyc75dnYPrO8J71pvEScZxCSywrqmVWsmGI90y8/aULH6E1
         K5inOdsQRVf1XUgK3EMLfFxvdk4ikRgs3jvCYK80HKhyH7+UCjYgwaHZz1+Y49hqImFx
         ZdaFrqPybs1EEgGDK0+W8+YL7RcVg77c+9xQ0dIR1CkAvcTSIOPAq2ZiqjmruJrOCwOa
         IasuKAQ1M113SrE+pcZ6w0GC8YFw5McLHmQi22qQBzhnwsCrFji+PXvO75QxtRyE2rr6
         XuBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjzeLbxV4IKrzJ/Y+qGWBSL9JtPpwvve2DX8JeSDVI9265EEyNVxMK2O6jNWa8d9m3EMNleEg9GFwR/6us+O9zWdLpRNlwlmwEKJpQ
X-Gm-Message-State: AOJu0Yzkwsi0XfJN3p1MoGBKG5Fngey9lbN6Pzp2CYZABROPGSUW96AH
	UV+SZ5qfeVFDxR4BI3GCJef8qSHwHakPCfXkcFpXhGo1Osar8vvx
X-Google-Smtp-Source: AGHT+IHobj7THy2iZGJ+CcuHdHYu60hKjN/DBPQd3Ouy+zBTKPCly8HGREDlb7zehsXPQhWTSuFXqQ==
X-Received: by 2002:a17:902:c40b:b0:1dc:c161:bcbc with SMTP id k11-20020a170902c40b00b001dcc161bcbcmr2564690plk.5.1709655961460;
        Tue, 05 Mar 2024 08:26:01 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ix19-20020a170902f81300b001db45b65e13sm10783079plb.279.2024.03.05.08.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 08:26:00 -0800 (PST)
Date: Tue, 5 Mar 2024 13:25:55 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709655959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FkTf9XC1FRr3KOSelsQrNRpfQiCYC4Aa2jODKzu4UZ0=;
	b=SpUKm+oi1mlySNT3yVDDUXN2narB8CvbEr1APNgz9BTuJ4xezXVkRBMf8+ULOaqbBNMSvc
	q20H3yr7aSXNQlo+VgkhsJgAEDOJ5L8VGosLxc6q8Iruq9/KsHnrdfpO7DoBlE4StmZOO+
	1eAf2RBUEXbm7N/7HyuaMFBDPwd6HmH0NNd+SFztqf4vmrGDQdbtcunVND2pXjhDxdl7+T
	NHbTUQxs2+MwGBtlXq7Seb1z3MW1QXxyu0Hf8pNIX4KnHlCHrwJ0GJF1AFOINFCzEmOl/B
	eytiTYTdlYZ3G1z3/ZzcTeJncZyjUgG7fZWE1Bylky9TBWbnIti4Ud1QBjJeOQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/3] nvme: constify struct class usage
Message-ID: <bri7abpenndub2ejegge667wnrgqpxhyh2zjozotr6qn4xuv2t@dcibklqxgxcn>
References: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
 <20240305135125.GA2802@lst.de>
 <ZedCG81IUxid_KzX@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZedCG81IUxid_KzX@kbusch-mbp.dhcp.thefacebook.com>

Hi Keith,

On  5 Mar 09:02, Keith Busch wrote:
> Thanks, applied to nvme-6.9.
> 
> For some reason this series didn't arrive to my inbox. I got the patches
> from lore, but I probably wouldn't have noticed this series if Christoph
> hadn't replied.

This is weird, I use gmail for sending. Thanks for letting me know,
anyway, and picking up the patches. Also thank you Christoph for
reviewing!

All the best,
-	Ricardo.



