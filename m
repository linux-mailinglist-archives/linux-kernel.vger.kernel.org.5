Return-Path: <linux-kernel+bounces-62386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F6A851F80
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD7E284EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9E64CB4E;
	Mon, 12 Feb 2024 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+Bnm3FK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6338487B0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772992; cv=none; b=go7eITciDm8rcOo7N1sPEY/61C9bVyX/wuTcm+JaSkBks11d/EGWozgTZK9aGk5rHKtU+YSexrZvekRCBF0xPW/qAGE/V4swfbQRlTnIeUsrTC4o03Q7+GLRz2cIht7togCUqksIqXmQaMgxSoX52WCC67FmI964FBNm8a1D5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772992; c=relaxed/simple;
	bh=GaIow7DABO7d1iaUez27x56iIoIwRTb+Q1jWvdo15Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2LFLZU/YdvWQCvssglI4nbwM51VCmGyzXQKiHg03kzwPz3C5Cmu+vDWf1yY39Ii5HMQCwQszoLzsX5FD4zCq/yqRV9yVxNTLP188S62cYXCqXKJDQThFa3tTndsIZiOkpVjbYheGWFnHUzoQjJpCoYKlB2VQrUn8km+I07H7Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d+Bnm3FK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707772989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaIow7DABO7d1iaUez27x56iIoIwRTb+Q1jWvdo15Uk=;
	b=d+Bnm3FKLPY7Eom/Uda70rN69k5PzhXGTOKTqtxQoJXzavPGTPDrZZhU1kz21H0S2FdYtP
	R7bal3SpO0n4Y0PjVIiq8fpbZ/zImQ9hYwG6UJ4jIzSwrQBm7wflJQ2mrGfylQ8Hg1PIjL
	lgWFrsFdxt/t2m0mR8sMw4rHN6/cLGg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-RSyT2SdBOJ6Rudy0YhTC_A-1; Mon, 12 Feb 2024 16:23:08 -0500
X-MC-Unique: RSyT2SdBOJ6Rudy0YhTC_A-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-785947d659cso401291685a.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707772987; x=1708377787;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GaIow7DABO7d1iaUez27x56iIoIwRTb+Q1jWvdo15Uk=;
        b=qdqmusTbKL1KxV62euZmqFft4Z9X9mrZLfNT0+SfyYbh/7SfHkHDYTZnR3ulRwGGS/
         hWocIGfmaFOc1r+2qV/gXaY3umlcMHbq9PkOpUsPPayC9HuVXM78C3GhUirMcnuzMOXs
         1eySQM5vcQr6HSAtKMrky+xJzob6+p2RVUCU4fibsldedwm1Wh7U5DEbMzjF6wyRqKcl
         4TosuuQEKPwfttO7Z0jjBAR4dXo4ZcmX0Jh99Elj/fITeFnY/kEdcJaou9XHRrLT2WZ9
         Dc+7qssUbNOUODTBiRJ5pgWkXEPCm7R3sRtv37qnYG9eErRRIOPiSebw7f1rfOsjAxo4
         BvRg==
X-Gm-Message-State: AOJu0YwO7qXDJonew+NRjoA6oxQQM65B+04SYpwm948SAMxAus+6TB9R
	7q5AKSNnCXEVHaKAbB1A1GXEjcI9bSjVtSAgMzmGFoSyHmaJzUSTyDf2NMxdpG+EpVBiNSZcHzR
	xZ13QyEJjTatXducPY1NC7dpnvSH0EsOQrD5r6O1k8srV37oNeGhC4Lb/wWZFPA==
X-Received: by 2002:a05:620a:e81:b0:785:5b28:eaba with SMTP id w1-20020a05620a0e8100b007855b28eabamr6371306qkm.4.1707772987740;
        Mon, 12 Feb 2024 13:23:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwMX5DViKV5i8GevVnlP/Ta/Jb6WOrk812GKH9d/JcuehM7OyZ6wIF2DEXwb36IuE6jclwyw==
X-Received: by 2002:a05:620a:e81:b0:785:5b28:eaba with SMTP id w1-20020a05620a0e8100b007855b28eabamr6371296qkm.4.1707772987503;
        Mon, 12 Feb 2024 13:23:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXoHuKZM1foE0J/pCIYf5+fl4/eTb61+FMWlU637I5jHF/5yZb0g4g6I0QIpAXXvdIVX7qiHsk8d5/Wzu8JOl1kl23GUkXag4OEcB35S/GC0KW56WT2Qaqy70NdAfdhLRgzDaUWinipv2H/MAHphYXTsgINdUqZUVstoQxYWse23GLL3x20LBP/VRo9rdIkR/lY7w0wYhmyl+tdMHMx1Nc51z8XW6ct67J1TnpkYmUcg6RMthCCO2T9RDHDOzmodVxgoA==
Received: from thinkpad2021 ([71.217.33.204])
        by smtp.gmail.com with ESMTPSA id x2-20020a05620a14a200b00785d9e3b744sm818978qkj.108.2024.02.12.13.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 13:23:07 -0800 (PST)
Date: Mon, 12 Feb 2024 16:23:04 -0500
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Clark Williams <williams@redhat.com>,
	jlelli@redhat.com, Derek Barbosa <debarbos@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: NMI Reported with console_blast.sh
Message-ID: <ZcqMOKtHsZ9qnxNg@thinkpad2021>
References: <ZcQjxa4UA6hzXHnU@thinkpad2021>
 <87v86yc88b.fsf@jogness.linutronix.de>
 <ZcaQI8l1dcBx2feC@thinkpad2021>
 <87a5o8j9gp.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87a5o8j9gp.fsf@jogness.linutronix.de>

On Sat, Feb 10, 2024 at 10:33:50PM +0106, John Ogness wrote:
> On 2024-02-09, "John B. Wyatt IV" <jwyatt@redhat.com> wrote:
> >> Could you provide me your kernel config and boot args?
>=20
> Thanks for the config. Could you provide me the boot args as well? I am
> trying to understand why early_printk is showing up in your trace.

I forgot to include that, my apologies.

BOOT_IMAGE=3D(hd0,gpt2)/vmlinuz-6.7.0-rt6 root=3DUUID=3D6e05c61a-a39c-45f1-=
acf2-0b0892c0739e ro rootflags=3Dsubvol=3Droot console=3DttyS0,115200n81 sk=
ew_tick=3D1 tsc=3Dreliable rcupdate.rcu_normal_after_boot=3D1 isolcpus=3Dma=
naged_irq,domain,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,2=
3,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,4=
8,49,50,51,52,53,54,55,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,7=
4,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,9=
9,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,1=
18,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,=
137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155=
,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,17=
4,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,1=
93,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,=
212,213,214,215,216,217,218,219,220,221,222,223 intel_pstate=3Ddisable noso=
ftlockup

I talked about the isolcpus options with Juri. Tuned had the realtime profi=
le enabled. Juri suggested testing with the thoughput-performance profile.

Red Hat's conservers are having an issue with the machine I was testing
on. It may take me a while to get back to you with more test results.


