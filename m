Return-Path: <linux-kernel+bounces-86269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7566E86C31D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1841F22E42
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA99E482E4;
	Thu, 29 Feb 2024 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIuDEOyy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6591547F42
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194131; cv=none; b=jSA9DiQguvbNwGHlWh/BoPpqYW9Uaxmb/jztZbXzvjK5B1NG2f3Kn09BCqDwW9x0+x+ai+IUrJeO+lQwEpCIAIiaKcXikHB7JcDfSyb8SL3BDqI0v681J9a4IeoMupWANiX8MuSKbyqZcshTjYVfSkJVmd7l8JQMIijoNAVSTWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194131; c=relaxed/simple;
	bh=p2AucDcjwJAc5f/us8nHZQzK0FZ0x5K7PfiLkMlk26c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=npKCIJ1wEpe5AreMBhhJVqY1s8OlKkmDxQmvDSST6vabUf6JdqhW6nhBvF4WMumNS59TK5BEfHGpeqRickLLIR42H/YsQEy9T/wTg/3I35ATa7N4c7FPeLqxHI9Ys4qvpy8a3iBFAajzAprf3e+ayU0N1rDd9ZCN8q7Zv+rRKCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIuDEOyy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709194128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15w6wj3J35usSWdRwfld/vYX5aTLUZWqSCkNcgI5sDA=;
	b=ZIuDEOyyKZxH2YzGwtOtE2uLkZ/D8LaKZBGiuwXelZkx6ilMsT7/DKL+A+JzSJG87T1I/v
	UIE/5arE23z6XAyeSgI6IbEbbPLjmE+rp5Nzgxf/szQGEwtPjP00aW92ZTzj3kypclUvn0
	GyZZPnJLQbbko1K0f2nmfbC9LmSFCTc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-iONjQSVFPqivyx301iEVsg-1; Thu, 29 Feb 2024 03:08:46 -0500
X-MC-Unique: iONjQSVFPqivyx301iEVsg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a3bdd99a243so66803366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:08:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709194125; x=1709798925;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15w6wj3J35usSWdRwfld/vYX5aTLUZWqSCkNcgI5sDA=;
        b=nYlKIz/fktZlMttN4JukzXtMPY8uIE/236OKgGwQ0JJgYcnJQOZrsa3RTtA4rnq1sa
         2PV35v1CnZe91jCXX6za9Si8mHDSm+mSbTpXkx8R5tH3Q6WvUZ70V3SBuOBmP4d+QKuE
         n745UuYEwMdPkFIC0JjAYY/oK9BaTBOYNIi1n/Q555POgA1cLneObwD6owPgf33FqOPP
         g5iaIkLegmdGdPOllhgZefvAphQHp7Ynzt9GbhC+6JyxUrcnDj1bCHS6+tgGI2DFr8jY
         8YHWgtYRUN/2azXSsqO85G3QJS7yacR7mQAetHbYvVx38j9z9O777z5CTSn44qrB5bs7
         WvPg==
X-Forwarded-Encrypted: i=1; AJvYcCVUALBLY+JntrOZntNu2PWWt9j8SvRvry1IJdDtP3zvTLS+n+xiDrczfUT7vwDnWqdeBic/LGczCueVHk0/SyF7rE7GWMJh2hIBMLzR
X-Gm-Message-State: AOJu0YwyZbAYuE6+yQS/wROdNKhdUMTc2X0CwsixVS64UMbc0Mgj9Xch
	80xyocGaWriy+XmYbDJK/75IVkyq3bpENOOjyxdaqRReCJ9Oa/4pZhMSxw0roA8OYBu2lHpmu9z
	wWSKEvwrMQR9DLWjEofDH/mbqouhEQYsYpWfRjoGpZIxMR3yQBTClkmVbgLbHsA==
X-Received: by 2002:a17:907:1deb:b0:a44:3dd:1a70 with SMTP id og43-20020a1709071deb00b00a4403dd1a70mr823110ejc.11.1709194125603;
        Thu, 29 Feb 2024 00:08:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRmHLabCtfkOep1wbFTP3rLm0qXOdCtirtmFfOtY9v2jAX1oaNJwrNSFqOP0TRw9SJDaT04g==
X-Received: by 2002:a17:907:1deb:b0:a44:3dd:1a70 with SMTP id og43-20020a1709071deb00b00a4403dd1a70mr823096ejc.11.1709194125225;
        Thu, 29 Feb 2024 00:08:45 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id js9-20020a17090797c900b00a3d0a094574sm419645ejc.66.2024.02.29.00.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 00:08:43 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Greg KH <gregkh@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org, KVM list
 <kvm@vger.kernel.org>
Subject: Re: CVE-2021-46978: KVM: nVMX: Always make an attempt to map eVMCS
 after migration
In-Reply-To: <2024022905-barrette-lividly-c312@gregkh>
References: <2024022822-CVE-2021-46978-3516@gregkh>
 <54595439-1dbf-4c3c-b007-428576506928@redhat.com>
 <2024022905-barrette-lividly-c312@gregkh>
Date: Thu, 29 Feb 2024 09:08:42 +0100
Message-ID: <87jzmnn14l.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg KH <gregkh@kernel.org> writes:

> On Wed, Feb 28, 2024 at 11:09:50PM +0100, Paolo Bonzini wrote:
>> On 2/28/24 09:14, Greg Kroah-Hartman wrote:
>> > From: gregkh@kernel.org
>> > 
>> > Description
>> > ===========
>> > 
>> > In the Linux kernel, the following vulnerability has been resolved:
>> > 
>> > KVM: nVMX: Always make an attempt to map eVMCS after migration
>> 
>> How does this break the confidentiality, integrity or availability of the
>> host kernel?  It's a fix for a failure to restart the guest after migration.
>> Vitaly can confirm.
>
> It's a fix for the availability of the guest kernel, which now can not
> boot properly, right?  That's why this was selected.  If this is not
> correct, I will be glad to revoke this.
>

To be precise, this issue is about guest's behavior post-migration and
not booting. Also, it should be noted that "Enlightened VMCS" feature is
normally not used for Linux guests on KVM so the "guest kernel" is
actually Windows kernel (or Hyper-V) :-)

Personally, I don't see how this particular issue differs from other KVM
hypervisor bugs. I.e. when hypervisor misbehaves, the guest will likely
suffer and in many cases "suffer" means crash. What *is* important is
who can trigger hypervisor's misbehavior. In case it is guest triggered
(and especially if triggered from CPL!=0), security implications are
possible. In the even worse case when such guest's actions can cause
issues in the host's kernel, the presence of a vulnerability is almost
certain.

Migration is (normally) not guest triggered, it's a deliberate action on
the host.

-- 
Vitaly


