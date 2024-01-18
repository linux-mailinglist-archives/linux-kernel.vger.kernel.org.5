Return-Path: <linux-kernel+bounces-30440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBAD831EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AF51F28BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB232D605;
	Thu, 18 Jan 2024 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvCP81my"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D702D054
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600235; cv=none; b=Mazkrm6HU919r7GisrtD28DmcjOiDEyk0x84Y5IeJqG/6lMgt/8L+yD0i5S8P9A9dvc5inXPwICdpDTpQt8r+kpFr0jIp9aVry88uxxxqnQQgCGX6hbb3JDl1jgMoLAICT6Hr1caCYpBBwET3dS2EMArIh97/XmgHErB7kuI6XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600235; c=relaxed/simple;
	bh=aUaKUwh3YAaWNKWA7dj+PRcrSs20vLRDXme+DX+1ioM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=WQZnDYx00jfaKqYxTXMJuzjLEkP0qiQFJhvZikTCzuykXlbB7MXbY/26Gt0UiI1zpjkmZGowrfsQVj1LiH4E2vWfisYE110AOXUnrXFxF5mQAmuZGi6htlkrNRVq6gb9fyz8YXY25q6G79QfYRHbhRabLz2S75ZAi+fGTme/hjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvCP81my; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705600232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aHsNkGQXlA8j1zbdtTdQqDbzc5qUVpizDvSzqJvBko=;
	b=XvCP81mykMH2XolhDrZI/jT/ed+5wsbvzUD5ajvonFgWSKcGoQcNIvefV+e8srBceNbmrc
	kZW8YYtOuiWKV/8QudVudSRcwGbsZUqmfIvQ9MgYqsJC8NR/h45d/Kdm8qzAA5L0ZdOD+B
	SzNYgWFsrzpvoG6dL/4aRhYCUOn+qik=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-LL9zUts-PGOTPziGVOqGVA-1; Thu, 18 Jan 2024 12:50:30 -0500
X-MC-Unique: LL9zUts-PGOTPziGVOqGVA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5ce97b87716so6432524a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705600229; x=1706205029;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6aHsNkGQXlA8j1zbdtTdQqDbzc5qUVpizDvSzqJvBko=;
        b=wafYWO/ot0OyqqeKbBtcAgCymDsugJ2bEmRn0A4ax9utGcTu0pK2TrtmGjoitTubEt
         czPA6zFLcfcgiQCe8eo/cKMJ1pCu4BXwCsgSpxNhc9Ceme6dqKCm0c+0711EYcrS4GeN
         UmahRc5V0ykaiLycRFTLWO0/XZVpa4wuo0Hk38OvdAtcJg/Ei4R0qpA7v2ePqMzVPJSm
         rz+hzaBibbw9u4Xk8WFNrOY3cEaDD8VQwFNW2pxfZXRyRV7GQb2gaVH9HBG2gybfdrzm
         KKOB4hmUxLiwsDKBxCusOVWD8ZGP5qjA6zE53SFLAOqig6+sACgh2yZh+R+k1IiSoH2D
         jMCw==
X-Gm-Message-State: AOJu0YxeIswXTc4TEjzS1eEt9lxs20VSGUPs0kehMBUqf7M/vh2UsFL3
	KxN4iyFPZiF1tkowVaumnRhfDcCmecO4USxQ4ja6N866jXsNrAPo8YgYG3JSoww0TSGk87Ble+y
	YB8YDH7TQFC5cdd+3V2drbWCTGnGRdmyz0HFC5OwAshhBATlcjmVqn0DMhXzaMJtHkbbTMQ==
X-Received: by 2002:a05:6a21:3183:b0:19a:42b3:d68c with SMTP id za3-20020a056a21318300b0019a42b3d68cmr1179174pzb.57.1705600228849;
        Thu, 18 Jan 2024 09:50:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+a7eH+d8iL1heB53j0/12YRSVmaGC7RabUtALrUzma6iH+gcMuNZfyaB6zX3v4ROAyDuHuA==
X-Received: by 2002:a05:6a21:3183:b0:19a:42b3:d68c with SMTP id za3-20020a056a21318300b0019a42b3d68cmr1179164pzb.57.1705600228557;
        Thu, 18 Jan 2024 09:50:28 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a803:96a5:ba81:becc:80f3:6a79])
        by smtp.gmail.com with ESMTPSA id qa17-20020a17090b4fd100b002902e409b77sm1481848pjb.57.2024.01.18.09.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 09:50:28 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Leonardo Bras <leobras@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [RESEND RFC PATCH v1 2/2] serial/8250: Avoid getting lock in RT atomic context
Date: Thu, 18 Jan 2024 14:50:08 -0300
Message-ID: <Zalk0Md6F12xNz91@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87cytzaqdj.fsf@jogness.linutronix.de>
References: <20240116073701.2356171-1-leobras@redhat.com> <20240116073701.2356171-3-leobras@redhat.com> <75a39f0a-8f79-eacf-4a35-5de512a3cbed@linux.intel.com> <ZabJGefGkrs0SNzW@LeoBras> <87o7djaubq.fsf@jogness.linutronix.de> <ZajxMc05uVmK7e60@LeoBras> <87cytzaqdj.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jan 18, 2024 at 11:33:04AM +0106, John Ogness wrote:
> On 2024-01-18, Leonardo Bras <leobras@redhat.com> wrote:
> > Sure, please let me know of where can I find the latest PREEMPT_RT
> > patch series so I can re-test my bug. By what you comment, it's higly
> > probable that patch 2/2 will not be necessary.
> 
> Some links for you:
> 
> 
> The Real-Time Wiki at the Linux Foundation:
> 
> https://wiki.linuxfoundation.org/realtime/
> 
> 
> The latest development RT patch series for 6.7:
> 
> https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.7/patches-6.7-rt6.tar.xz
> 
> 
> RT git (branch linux-6.7.y-rt-rebase is probably what you want):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
> 

Hello John, thank you for sharing the links!

> 
> > On the other hand, unless some extra work was done in preventing the
> > scenario in patch 1/2, I think that can still be discussed.
> 
> I agree. Thanks for looking into this.
> 
> John
> 

Thank you!
Leo


