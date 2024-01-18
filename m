Return-Path: <linux-kernel+bounces-30118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D79831994
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4C528193A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FC524B4E;
	Thu, 18 Jan 2024 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZDMlyq+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334C13AFB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705582386; cv=none; b=XsFrAkQk/p7kv5ikd91hGcAqJY0hcjuioIhDWi1VvY6XE7Z9xqI0Mktfr5jVKAhp2isMUaK0EuSIAF/Ec4GpWgmD3AQEkV6vH1AcVpuYDOwn5K1cvz8dxeV8oFolJWVd9UOpAXtZJ39ViqZmC0Tssj7saUrlyc1u6U6EXnotUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705582386; c=relaxed/simple;
	bh=uXo0mHZKY3fqD8ScPUdC3c1CIbxwxMPAdvA4h74cD9A=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=F0cPpGZe0M5DjmYrYtAJnHK2JSh7Bxful4F84TNSScIkJxWtt1uANkNxs9/dbXnTVVoRRGMrqFXocOSfOPM3cBtPKI0B91kgIL4i2XAMo6akqjpAl75zsc607NZYfLsrgjI9zVxZ9nZhfnB3X+/m/YqRSZaBKA6ja5e0MNYcLdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZDMlyq+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705582383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yY59x6E87aIGPRPHD7KitEjGWkNgVC7Ifo9pzeQ/g8U=;
	b=aZDMlyq+4CxOriVTFm0ybBgSdJejTL9woo/0Husks2IPooxfFxCyQ/QcCE+xvOr6dD2BFF
	WA8+OIf74u+GDBz7DkQg5XSmDP+vqeKZLP47iQJWPC7uphZnrwKkXEAEPw1gqWzZv0yS2b
	jnij+lL+GRIklekLnEfZHKljy3jzi2I=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-0CDqSiG1M6e4V3tc5yXdgw-1; Thu, 18 Jan 2024 07:53:02 -0500
X-MC-Unique: 0CDqSiG1M6e4V3tc5yXdgw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7816bea8d28so133202485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 04:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705582381; x=1706187181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yY59x6E87aIGPRPHD7KitEjGWkNgVC7Ifo9pzeQ/g8U=;
        b=MCMW9AgBq6I6mZe4G9zyhUy5dqUc3FUlK3BS2uZw02KP4CwiA3HpOF7h1CrITn+1NY
         6UEpIBNhVOfPzpmu25qu9T7Zs+ZMvfl2v+sN0rBdmGlvDKYGTd8tYAT4XoC68zkdsRn8
         fq9fH6/nzcsvox/2TYRUw7gzY82V7O7CFhfxn55xbi42gqa78rtim6hQdHQlPs7X/gom
         ZRhd+NXRWpFZ+OaL6KtQujxZeoXT3gKDTLu5offrecuzhobtANpNE147JtbHBgm7kSCL
         anwjHGNL9TWZrFboQ+O3YwKYsnqO9z+daTXKfZJVivv646vSspMrG/au/qOOnF5ejyQO
         bRpQ==
X-Gm-Message-State: AOJu0YxKn71QZiTLUQg+BXJN+vacGbTu7OyAifJn8VDiuQR6AjMsvnfI
	rAvVISgDMh1hXuY0uV09zUgoqrvtLpIitTC9U9+orCtgPeUaza9wl2SSHcmJ5K7IXXtxagK8d0c
	ofQVMntIxyGQmMuyje9rfFMrYP0PQdF0AC6K31zTHzwPMzqKR30A1OyDtqzhFZQ==
X-Received: by 2002:a05:620a:2415:b0:783:3cdf:7e36 with SMTP id d21-20020a05620a241500b007833cdf7e36mr2106186qkn.58.1705582381692;
        Thu, 18 Jan 2024 04:53:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7As1BDqXY9resBjb7KtzVWa0wxxWHCvwG2FLi7KKlmWPYt9Q+Y1u/l56Ffk5pU4XqKV6msA==
X-Received: by 2002:a05:620a:2415:b0:783:3cdf:7e36 with SMTP id d21-20020a05620a241500b007833cdf7e36mr2106174qkn.58.1705582381434;
        Thu, 18 Jan 2024 04:53:01 -0800 (PST)
Received: from localhost.localdomain ([151.29.130.8])
        by smtp.gmail.com with ESMTPSA id he23-20020a05622a601700b0042a09928c10sm2114740qtb.33.2024.01.18.04.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 04:53:01 -0800 (PST)
Date: Thu, 18 Jan 2024 13:52:57 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] kernel/workqueue: Distinguish between general
 unbound and WQ_SYSFS cpumask changes
Message-ID: <ZakfKWVdAUZ4wCNf@localhost.localdomain>
References: <20240116161929.232885-1-juri.lelli@redhat.com>
 <20240116161929.232885-4-juri.lelli@redhat.com>
 <ZabRlEklmuqwFPj-@slm.duckdns.org>
 <ZafQwMw8ZKztunMU@localhost.localdomain>
 <ZagKbRlBxZHsKiw5@mtj.duckdns.org>
 <72e4a971-96e5-44b7-b348-bbdb68e54b40@redhat.com>
 <Zagtpw-JQvdpFseh@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zagtpw-JQvdpFseh@slm.duckdns.org>

On 17/01/24 09:42, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jan 17, 2024 at 02:32:34PM -0500, Waiman Long wrote:
> > My impression is that changing the workqueue cpumask of ordered unbound
> > workqueue may break the ordering guarantee momentarily. I was planning to
> 
> Ah, you're right. Changing cpumask would require changing the dfl_pwq and
> that can introduce extra concurrency and break ordering and it's exempt from
> unbound_cpumask updates. We likely need to add a mechanism for updating
> ordered wq's so that the new pwq doesn't become until the previous one is
> drained.

Thanks for the additional info! Guess I'll need to think more about this
and possibly coordinate the effort with Waiman.

Best,
Juri


