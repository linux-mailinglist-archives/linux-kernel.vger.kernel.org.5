Return-Path: <linux-kernel+bounces-165547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFB08B8DD3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D324D1F22188
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EAA12FF78;
	Wed,  1 May 2024 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YlgVTqgA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D5A12FB36
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579978; cv=none; b=ZJbGVYYt53m1o2Iu7VjEphdwuO4k52HU0jghRVdeOHLyX7JPZbx+y/01TTTkLKF+S/8e8yFCMdKSPtLoZdoLMzX6XQ8lY2Zcnb+24WJydawl5yb43MvztYXBAJ3gMuuziDjVXuqtvogO5Ve4z8a1tiFcXRaZ6O9FJL0UWdCQPsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579978; c=relaxed/simple;
	bh=hrRDPH5KmWRr+9x1RV6ps3o4KFAfIeKcj/QXwk73n2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGG+vW4XYv1il8ZcF0ZakbiYqI8i9twnt3f0Zm/vvB4OysJum1TGXT38V5fGkAYARZDf1OzGkzOrsVDschRx53ZdnpMeyJu46vtQv/WIU+gMKTQtTf8TpMFckeBrAX4fHv25qgjEfa2iGrWtUphd2t5QMkZDfPOUT7dwDy8fQrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YlgVTqgA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714579975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hrRDPH5KmWRr+9x1RV6ps3o4KFAfIeKcj/QXwk73n2Y=;
	b=YlgVTqgAsfsalY/s5N01BofuEkinquxeGyCsRykx/HuFxMG3iyFuKUG4xuJ2nWUQFIX/Yq
	prnFnh6GtR5m3aESpFdZfPX6xZbwXbeNOq0Jd47yjEv6F9aY4KcOnSMm7sTimQp3sXtZYD
	baNp1rKK0hHXqh2bsOEWZXwoZpl6quY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-hPU9xpgKMqykWA4CcsxAMQ-1; Wed, 01 May 2024 12:12:54 -0400
X-MC-Unique: hPU9xpgKMqykWA4CcsxAMQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-418a673c191so29881995e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714579973; x=1715184773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrRDPH5KmWRr+9x1RV6ps3o4KFAfIeKcj/QXwk73n2Y=;
        b=nAQsfZ6o8OTz7yjV2QeuF5aL2tuTyT99B+J8Mng2Z09eTfEmU9UtemLcJ2Nfk0KeK/
         g1o6pj0MxjTHTEXg0/+AjNlScp1PMDfoOuybJRlFGFaYYmb1BvQ9qZHtfg82eaqys9t8
         +/VdN6wiUQMIbTIUQDm7PlYv8uxb6UJvlFWTlcID3nyQmI6nt3+pWq0hHkbWrSUDBE8n
         edes1sY6NAr2jAumMchPcE2hsp5ftmSggsiwOhZfIzIbRow8HHywaDSRSjKOLg4TmCUe
         MbyjtSOIdsuXnIZBTs2JYJSdQeYeUByQh8mbHF2oxWCm0GS5O6z0mJZDzQMHOYHAvWA9
         5www==
X-Forwarded-Encrypted: i=1; AJvYcCXPFDJescb1diJYjNzO5h/gSyC9GxlPXIuyHtYLjQ9reNxT6Nw8VbvC5Nhh/ogmD5ZsxTBU2x/1dqAaw2xcjc2M0QifcS2lWSo8FgJB
X-Gm-Message-State: AOJu0YyxL61GGXsaYq4PqNj83S1uEoK5tmBC3gwt1vdQu6bQYPEiIVK4
	ECMtiEbpLtwZ7dvTAK5S8h/It60pLk9GCXwSwY5sdhWiOP3Xa0QhnyvoTo7tJ9gGDgz4UWrp6s7
	vTlWp2phEkHUC5k0UBN2RJuCztPZiDDWdskQOl1PH9tVKKhKOfpiRhSclG+vWzA==
X-Received: by 2002:a05:600c:3552:b0:41a:be63:afbc with SMTP id i18-20020a05600c355200b0041abe63afbcmr1920318wmq.28.1714579973239;
        Wed, 01 May 2024 09:12:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM9eMgnWpKr6MeblXMaPo1/itIFX2oETmSIeau52sprOYTLIeHS2zSDJpwo+oNvlucm1N6qQ==
X-Received: by 2002:a05:600c:3552:b0:41a:be63:afbc with SMTP id i18-20020a05600c355200b0041abe63afbcmr1920294wmq.28.1714579972623;
        Wed, 01 May 2024 09:12:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:6a42:bb79:449b:3f0b:a228])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b0041c5151dc1csm2639208wms.29.2024.05.01.09.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:12:52 -0700 (PDT)
Date: Wed, 1 May 2024 12:12:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael.christie@oracle.com, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read
 in vhost_task_fn
Message-ID: <20240501121200-mutt-send-email-mst@kernel.org>
References: <000000000000a9613006174c1c4c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a9613006174c1c4c@google.com>

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git f138e94c1f0dbeae721917694fb2203446a68ea9


