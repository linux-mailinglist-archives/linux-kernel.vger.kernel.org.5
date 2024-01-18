Return-Path: <linux-kernel+bounces-30185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBD7831B27
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425491C20FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF012576F;
	Thu, 18 Jan 2024 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q26YQKxR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696EA2575E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705587157; cv=none; b=fA/Uz7Mt0wgTNy02C+zt+B/xeiiRvr4P70fDYZ27zMML3uftfFKibVrUfuCUgThZTrBoVFvK2OkC69dtOympgFj9APxMn2Z9X0d723Y5N067owdyf1+rEeE4/Om0ic2XGpcxd0BG1munFNjBtRj3r1+XPwmD4DSoljb86yO2Wo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705587157; c=relaxed/simple;
	bh=MCWy6q/E58MwfEGkejDqVK3TyHf1SVy1zZQ6cr/moE8=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By; b=PXZFlTlcNh1F3d0rGnkhkvkwR5uq0SOT/fH4+JoP8Na4GA9hXAo0X6TvQsoWISKZyYdKNc0Cf5oP4gbY/nzzD3PIZDbVIdEI/vwMXpWC7UHleOv3/g0Kw1daP3IFuFMGvT6SyYJewp4qPMkYb3oAjAS0sZtsoeCYv0bl7+VhDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q26YQKxR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705587155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPLNiSez/b7ttW8/4euRpi1qvACC1p4qqhvlpzOt5f4=;
	b=Q26YQKxRqWBSbsqUCuQl431yalD3KV8UX0jrGv87RsmlLXPmIG/A9VPVbblxB2eIG+816n
	YTWAHc6t0589RsIo2iVgQ6SjaoeHWaBlwIJJ7HBaZxoA1kQPwJmI3/MRH7Pbp2CoSH/wbs
	uPw4vpr1TWNu+d8R5neLbChTd7g4ibk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-fFhJqTaHPvCH9QThx2Wq_A-1; Thu, 18 Jan 2024 09:12:32 -0500
X-MC-Unique: fFhJqTaHPvCH9QThx2Wq_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2422185A781;
	Thu, 18 Jan 2024 14:12:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.155])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 875122022C38;
	Thu, 18 Jan 2024 14:12:29 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: masahiroy@kernel.org
Cc: dcavalca@meta.com,
	jtornosm@redhat.com,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	nicolas@fjasle.eu,
	stable@vger.kernel.org
Subject: Re: [PATCH V5 1/2] rpm-pkg: simplify installkernel %post
Date: Thu, 18 Jan 2024 15:12:25 +0100
Message-ID: <20240118141228.370254-1-jtornosm@redhat.com>
In-Reply-To: <CAK7LNAQ7C+ZN+mxaiw3-10Lmn2f0nAYi+aou=CWraZwV=_iThw@mail.gmail.com>
References: <CAK7LNAQ7C+ZN+mxaiw3-10Lmn2f0nAYi+aou=CWraZwV=_iThw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

>> %post
>> ...
>> +if [ -e /boot/vmlinuz-%{KERNELRELEASE} ] && file -bL /boot/vmlinuz-%{KERNELRELEASE} | grep -q " #%{release} "; then
>> ...
>>
>>  %preun
..
>> +if [ -e /boot/vmlinuz-%{KERNELRELEASE} ] && file -bL /boot/vmlinuz-%{KERNELRELEASE} | grep -q " #%{release} "; then
> I do not understand why this is needed.
> Please explain.
Of course. 
Fisrt of all, I have seen (i.e. openSUSE Tumbleweed) that in the same way
that vmlinuz, System.map and config was not copied when the rpm was
installed (because of the reason that you commented with the missing
script), they were not removed when the rpm was removed, so I have added
the lines to remove in a similar way as you suggested for install. 
And I have seen as well (i.e. openSUSE Tumbleweed)) that if the a new rpm
is installed (same release but bigger build version to use default options
for the tool), vmlinuz, System.map and config are not copied from %post
because vmlinuz, System.map and config already exist and the situation is
not good, because /lib/modules/{KERNELRELEASE} is updated but the commented
files in /boot are not updated. That is the reason why I have tried to
identify when vmlinuz, System.map and config are not the good ones, to copy
too.
Besides, in the commented situation, the older rpm (same release but older
build version) is removed and with that, the new vmlinuz, System.map and
config are removed too. That is the reason that I have tried to identify
again the files, removing only the suitable vmlinuz, System.map and config
with the same release and build number requested.

> And, is the output of 'file' standardized?
With no more information, file is going to print the strings in the file,
that is, the information containig release, version, ... and here we can
find what we are interested in. So in some way depends on vmlinuz binary.

> You need to understand that ARCH is not always x86,
> and /boot/vmlinuz-%{KERNELRELEASE}
> is not always arch/x86/boot/bzImage.
>
> See arch/arm64/Makefile
KBUILD_IMAGE    := $(boot)/Image.gz
>
> For arm64, /boot/vmlinuz-%{KERNELRELEASE} is Image.gz
>
> 'file' says it is gzip data, that's all.
> You cannot read the build version.
You are right, again good catch.
I will try to think something for aarch64. Maybe something more general,
and  independent of the kernel binary name, is possible and valid for other
architectures, maybe with rpm command.
If nothing comes up, I will do only for x86.

> Unreadable.
> I suggested code with indentation and quotation,
> but you got rid of them.
I did not want to modify the style.
Ok, I will follow your suggestion, it's clearer to me too.

Thanks

Best regards
José Ignacio


