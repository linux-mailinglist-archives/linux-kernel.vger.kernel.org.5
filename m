Return-Path: <linux-kernel+bounces-155847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7018AF7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2C41C22D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82557142906;
	Tue, 23 Apr 2024 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajSuadJY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AC314265C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713903910; cv=none; b=bKYliDfzn03rpiS9Wyr5qYp+vz5gdopRm8jwxY35rsPqOfwQ1aoxPgQg5IqTdJYiYVE8el5IFRdmkvIdMRc7NPs0oPDbZKCxjF3xsmeIxOp+s6vNEbFgcxdg4mWprVno2L41e8XIx8sI876yKsnamt2hQJ8QQUeiM/H6FN/QH2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713903910; c=relaxed/simple;
	bh=IiKD5SyliMCZS6uycnE4FDV8Y10UkP2LI2qZh1H+yng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pC4JdH2Ifxlo3COOUNbK1yBwIkHqvdFdBuel0HUKYcQYS+Zl5e+bh5uiRfDIvmmKlSnM55V5zxPui5NYV0TnRKEUoEh90rJXqRu9vYGIl2j801IDZACUFdpgxJtIoMrTI2fXi55zjZyDYOXUiRRGLbM4sH+onYcQAbDWz8xO2lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajSuadJY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713903907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2YosHNze/KnevH6aeloLEYctU29JplkQLtgxuJbONU=;
	b=ajSuadJYZZ1mpu4R2wKGhe2ERXcnxj7lPynHgesqOFwyq811pxlXpn3djEoMp5TcEfR+D8
	CZCQWX0leErPUn4n55Q+prQc891twBwaXdc9qTsCKxeqIHG507Hk+J/WrjFlEPyNPbmsfL
	K5Qcyq/zj5Nj19HkXdu84x6vd8kHE28=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-rpCWMtz4NCqJdVfZY904HQ-1; Tue, 23 Apr 2024 16:25:06 -0400
X-MC-Unique: rpCWMtz4NCqJdVfZY904HQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7dd8cd201aaso204193239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713903905; x=1714508705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2YosHNze/KnevH6aeloLEYctU29JplkQLtgxuJbONU=;
        b=ZVzmeoAwfRowp/RQWkNCpF87svJyNva5T/6YkACwDxbJo3eotopQyeWZ7YkFcce8Z+
         DmfZzYPvjQ11a3UFV+LtxMgY6zgsgtzQGQaAatPGcbH/wfzdnbMYNNzZZzlNTGufr+/a
         tG9P9u3wW2Bx0WvHPVwvvHEDTPsZGc+1dGQMBGP1nhT4iES6bJayCYGqX381yGYRU/8W
         CCftIFsCxyXVd68pPNQUlHp+DZ1PSKbAVNFHH3ireiuFKdiCIfguFXaJgTrsRI7KPkmT
         FWRZSG8JBlogQszhXBUe/0y/qLkZ/IVg+EWRs3dmQcXTACz74fxbaOk5T1lndtcrpn0W
         nDAA==
X-Forwarded-Encrypted: i=1; AJvYcCXkbhvXB3heAHrJZgEATMY2JYYjh7RXhQiYU8my9pIJ0IZKfGt7VxVWKdANENVT+/vvPknydWJLQ283b4D6WzvQPbweu3mgjcicrGN1
X-Gm-Message-State: AOJu0YxqOZmM4qJxZ0e02K3crqtErQ25mJIEY+q6khHZSG/XF1oRggcB
	LEmDetFUkBcvhiGl2maRGtAABD3ctgMh0GVJCENwqdHiVyIAeJoJRBXk84AtiXoCL5OMoybieF5
	JlYM6YpYPxmmH3ZYqf/RqN0Fo3R1b8+pApsK6XwnaY4d5N+Pifxkf3l7hyZDuOg==
X-Received: by 2002:a6b:fc19:0:b0:7d6:bf30:a39 with SMTP id r25-20020a6bfc19000000b007d6bf300a39mr634219ioh.9.1713903904557;
        Tue, 23 Apr 2024 13:25:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERbsuOghp6nNjyihZkysSp2DlUBwqMP/IoKpPnCpTuyK0FOD4xZogtqfEBcmtUW2M41qudAQ==
X-Received: by 2002:a6b:fc19:0:b0:7d6:bf30:a39 with SMTP id r25-20020a6bfc19000000b007d6bf300a39mr634209ioh.9.1713903904304;
        Tue, 23 Apr 2024 13:25:04 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id x5-20020a056638160500b00484f72550ccsm2540519jas.174.2024.04.23.13.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:25:03 -0700 (PDT)
Date: Tue, 23 Apr 2024 14:25:02 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ye Bin <yebin10@huawei.com>
Cc: <kevin.tian@intel.com>, <reinette.chatre@intel.com>,
 <tglx@linutronix.de>, <brauner@kernel.org>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio/pci: fix potential memory leak in
 vfio_intx_enable()
Message-ID: <20240423142502.3f10bc92.alex.williamson@redhat.com>
In-Reply-To: <20240415015029.3699844-1-yebin10@huawei.com>
References: <20240415015029.3699844-1-yebin10@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 09:50:29 +0800
Ye Bin <yebin10@huawei.com> wrote:

> If vfio_irq_ctx_alloc() failed will lead to 'name' memory leak.
> 
> Fixes: 18c198c96a81 ("vfio/pci: Create persistent INTx handler")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  drivers/vfio/pci/vfio_pci_intrs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to vfio next branch for v6.10.  Thanks!

Alex


