Return-Path: <linux-kernel+bounces-73761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEA185CAB1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D398DB22AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1ED1534E1;
	Tue, 20 Feb 2024 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAaM6+q4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A604152E19
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467988; cv=none; b=PSTVwqS+Nh76OMYFm6mno0eCy9P9fluc5uIswKRgq0ISXVBXr2BPjpbBnVq591JODwS2+uy0zdKmFPHAA802hRvbCx0N+m9yw0AoYLpe7tSumY3o94va6Iw0Y93XkSQ1FqUXgl82bw8asqE+M4D3ZzB9eRU1UKl55L5OkrPozYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467988; c=relaxed/simple;
	bh=fK9sjV2iYgk6EEpywtKXdHIXojjey3gn/L6ZBE72Rwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3eZXymgVhq63DLZ377mMKaCPsqr78Dl+fDH76ZJ3fRLhXyE7NnUbnrICHr7oilFtEWDanY8irBd/CUx2PNDl7mdbhmopNAHrQl2WDt750WyfpxXSMha30Wb8qW/dbMxoGuytY4jXGkYlKaTe8vkD9luHfuZlloRoXDKZXTZBSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YAaM6+q4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708467986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NPHpbIqvGI3GZAeZJOSIdpwg4OWy0KxmA+JMGQUGRJ4=;
	b=YAaM6+q4D6nhMqN7Wk7Q4KnN8hA6DDNDqIjTB4kJHvzQfj6K3BDNdwZj3h4m3pKK27+ysf
	IcgCO5m42BLnpSIortSGQTBWDzBLlbimf0QXDGul/UiKTEc93UTStW0v9+A21KqILUFtl1
	zmZl/fFqPHSAzzuetFhlDrmneMClxcQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-z69_Jh0jNBe6tGhKZ18dMw-1; Tue, 20 Feb 2024 17:26:12 -0500
X-MC-Unique: z69_Jh0jNBe6tGhKZ18dMw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7872ef032c6so1075318085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:26:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708467972; x=1709072772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPHpbIqvGI3GZAeZJOSIdpwg4OWy0KxmA+JMGQUGRJ4=;
        b=sG/Fn5ABCJ80D1GzcSY/CxZXYFvm612UJUxG6v8Cl3ZPl8R20F46d2ZoA+UaitIVeC
         p83bX8YBOSEQSwJ9BETqwj/gsCUC3Jx4Fa2LYpEwM1ioGMkT5ObPWyO5mHDUqJxPxCU2
         doUmw9vnYu7ZPy6BXz7sT+H9b8+7nd4uOFjz8gmqKWYNyZGM1ctulkvN6BDIY6fabGio
         zaREEBnslRS098R+iovUTON2y67NXTLUs5MZ1O7ISfJfiLW+3lAajn9HsHryyjvDu4Qo
         AxFEtdMElgvNtYG0X2OrCEdWVvuhsABp4HufrH5v/hN9XirKgwWJ3FYTdpikwqTXrwB+
         wUAw==
X-Forwarded-Encrypted: i=1; AJvYcCVMdySQ32gImKET2HX0lmfzdG9WDSPA0591zEiSROFsYEajzrlp0QsecSo84dmA/liZM7tld3KhGEXLyE7EsNR5cDucS9CT0MRAyxyf
X-Gm-Message-State: AOJu0YxJTbpCR+hLSiYWwUe9jXxZwqmooGz+s2xjB4nXDpn6tYBtWoEj
	JI7wjKaofEmM1zdFWOYr0K+nASyk4Bn1nrgzcDABNEtDcLD8/RZdY4qpJE9TuGeqmr42Y5SOT59
	N71Yp1/WIWEFXrk9wqgRS2NBNojGC6B/7TZO9j1FJ89Fq8AGdB9TDIrxk35ak/Q==
X-Received: by 2002:a05:620a:13c3:b0:785:c3b7:4e84 with SMTP id g3-20020a05620a13c300b00785c3b74e84mr25773191qkl.35.1708467972254;
        Tue, 20 Feb 2024 14:26:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDxpqQD+BPPqTlPrne7pDxsr8iJlYVf/WMcfo/C/M1OEfbvY9gUL6WrF/kIV/P1TVnpH561g==
X-Received: by 2002:a05:620a:13c3:b0:785:c3b7:4e84 with SMTP id g3-20020a05620a13c300b00785c3b74e84mr25773161qkl.35.1708467971966;
        Tue, 20 Feb 2024 14:26:11 -0800 (PST)
Received: from thinkpad2021 ([71.217.33.204])
        by smtp.gmail.com with ESMTPSA id j10-20020a05620a000a00b00787702a13c0sm1619411qki.114.2024.02.20.14.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:26:11 -0800 (PST)
Date: Tue, 20 Feb 2024 17:26:09 -0500
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Clark Williams <williams@redhat.com>,
	Juri Lelli <jlelli@redhat.com>, Derek Barbosa <debarbos@redhat.com>,
	Bruno Goncalves <bgoncalv@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: Automating console_blast.sh
Message-ID: <ZdUnAdrJC4VWRlmv@thinkpad2021>
References: <ZdOQ2KzOIgYc8Ber@thinkpad2021>
 <87frxo2vhg.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frxo2vhg.fsf@jogness.linutronix.de>

On Mon, Feb 19, 2024 at 06:57:23PM +0106, John Ogness wrote:
> 
> It is called "console_blast.sh". ;-)

:-)

> SSH is fine. SSH sessions are not consoles. Consoles are specified with
> the console= or netconsole= boot argument and receive the kernel
> messages automatically from the kernel.
>

Ack.

> > The license for our test suite is GPL v3 [2]. May we have your
> > permission to license it under that or permissive?
> 
> Yes, GPL v3 is OK.
> 

Thank you.

-- 
Sincerly,
John Wyatt
Software Engineer, Core Kernel


