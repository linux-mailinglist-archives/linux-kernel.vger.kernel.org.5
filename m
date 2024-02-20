Return-Path: <linux-kernel+bounces-73759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3947685CAA9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B501C2181A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B042152E16;
	Tue, 20 Feb 2024 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjbr9eC5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F0B14F9CE
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467884; cv=none; b=C7n5LzaIzvIJyrbyiZwkvCPnoBSBvKcB9bB13ET92UOiTVSpCZmoBjEaq5YiM4zPAjuuWmiOSADaSnCJKfqrcQfYR45R14WnO000aLsg6f4XP7BDgePMB6u3iuZS3GdNv7vMUav0SwvJlE46fCsvhfrWevpcQZfEH5Qc5DCsHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467884; c=relaxed/simple;
	bh=g5UH7tdCMPlNrjY5k7QwcIoKNj4+ocCFWLo1As6HTYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhWewsbDOPM+woZ6yWVpQ1Lg5bD5iJcKI2AG3V+Cn9NR7eGF56lKdEnE6rULjD3HmZQMKk6QuIRoI4pm/MWxJiZbWInXmvK7D0MTQk4g8xOWmUgnWDToa9Pfo3rqHs4asreRP+ptkxEiM9Rrg/wtQxr0feahSkv9/nQUG2LVrco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjbr9eC5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708467881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0NjQBQA/lUjdbHUMGa7rbh+2FLAyaGbRLlsYMTVFpfo=;
	b=fjbr9eC50DE3qVzXTGiA+xU0+0BTsxdtZx5/E0lykOApYi9GnND+FX9Xfxvjy3qQrxhBQo
	GbqZybO0GubCHxYAz5i83nvPtGOXLL+eKbx3vEv4MMxUmWkV6YLXQx7oGodiJacLswwAad
	epyDCiYs//jCDgGx1gkttMcTK42CZ+g=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-HY9JeosSPFuGnVi5ZV61Ug-1; Tue, 20 Feb 2024 17:24:40 -0500
X-MC-Unique: HY9JeosSPFuGnVi5ZV61Ug-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6e461f6f991so747004a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:24:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708467879; x=1709072679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NjQBQA/lUjdbHUMGa7rbh+2FLAyaGbRLlsYMTVFpfo=;
        b=b6A836qQfMWbGRuZPtnIvT5Um9HRc993v5/WwGHFVE9eTAuWWfBrrsh/WtbQjprba2
         lzUlhIpbbeZgeNyFGI7Oesjin4YhswDWer8OkdQ5VKd9d1wM1LISVh9mKZiUh7iopjey
         o4lnWrW4uNvMz6Rl9KqwtHec/cePET+KWM9Ijbt9hYYnwKuAcPC57YfMTZ8ci5aNOxwT
         A4fPvzQFqVVZq9njMV49Z4nWNa85cFD8pAiH0th4/4LXDJ68SuJu6Yl/US2wQ+WVfy35
         GTnzyVs2JJlAPPD0FUzp7o6nCaqB0/TUNk0SRdxJB7xcFWvozIdmIOQuR9vBxQPOFKTv
         hDbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqsc4K3061U4BSvr+TGKtAWDNZ0xaDASb4u4Vr44JrJCWyRVKau/LI7oTreEzbmh4hNT2DvaE06N8fgjlZVRvFXzKQK+YqUAruFdWC
X-Gm-Message-State: AOJu0YwOq9q26Pl9E3j1g01RA2ZWP7sjsV3rVRfmy8pn3f2CU36JG48o
	+QWeIRcAnPO3ADu6lsMj74nSU37z9LE5B+V/ieig5nFsROor+3jU3vDHU1he8lCs2lHzcWC/paU
	NYz6OyYwpTXtFtN2AbRWCqip+fuSRFEGcH9BVuDwMUm8cfX7nLQgS1K/i5uBvzg==
X-Received: by 2002:a9d:6d83:0:b0:6e2:e09b:a68a with SMTP id x3-20020a9d6d83000000b006e2e09ba68amr18311076otp.21.1708467879808;
        Tue, 20 Feb 2024 14:24:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaeGvlNNYy2/qSVFub612PKKR6oUapbT/TJ9+26EU3vkcvx2qMSi6pHYZKV/zhPQa3oaHgnw==
X-Received: by 2002:a9d:6d83:0:b0:6e2:e09b:a68a with SMTP id x3-20020a9d6d83000000b006e2e09ba68amr18311066otp.21.1708467879565;
        Tue, 20 Feb 2024 14:24:39 -0800 (PST)
Received: from thinkpad2021 ([71.217.33.204])
        by smtp.gmail.com with ESMTPSA id j18-20020ac86652000000b0042c7c1b51absm3823798qtp.77.2024.02.20.14.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:24:39 -0800 (PST)
Date: Tue, 20 Feb 2024 17:24:37 -0500
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Clark Williams <williams@redhat.com>,
	jlelli@redhat.com, Derek Barbosa <debarbos@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: NMI Reported with console_blast.sh
Message-ID: <ZdUmpblrzX0pcPjz@thinkpad2021>
References: <ZcQjxa4UA6hzXHnU@thinkpad2021>
 <87v86yc88b.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v86yc88b.fsf@jogness.linutronix.de>

On Fri, Feb 09, 2024 at 10:17:48AM +0106, John Ogness wrote:
> I am curious why early_printk is here. Are you using KDB or KGDB?
> 

Missed answering this in my previous email. I was not using KGDB was
disabled.

-- 
Sincerly,
John Wyatt
Software Engineer, Core Kernel


