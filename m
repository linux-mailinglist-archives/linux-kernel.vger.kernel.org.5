Return-Path: <linux-kernel+bounces-130145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDCA8974B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D7FDB2F323
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3A014AD15;
	Wed,  3 Apr 2024 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlU7SVui"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EBD14A4EC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159739; cv=none; b=IW9cIGg0w5Q6IHZzhZXwDSy1hyEIAxeYUvAgwaZVefsMIDsMPzUoYG2T4cT3Q/kcqV0fVQ8eYzkA67zC/AmKbcPD3zbnSwPJk3+lIMDR+KIaYFSLZuYWWcsAmgmgA/jLob2tzRHLpcTnIVDp6kMegG9Ceiusb+3SkoFHC1qumPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159739; c=relaxed/simple;
	bh=IwYLSmw6cSGNLuV0Ni0hrtcuYuIHxuLFn/0L5iZ3uzY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=euB6EJTme4SFP5WplnV2xTxSp82K4B8hFrjNSFC+9lWNxtHCrVPqleadcVMOjBwF89esrevkg9a2/ioc5VslkgU2VC34fERQU0uLVY/A3MHmtLKR9f9awf8DYxAh+rLS/X/zXm7gEpdKm8V+jLr2n58j05lykkJzNrq+34f9mYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlU7SVui; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712159737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7RJPDwaAOgtbZoy/29/fhYCHYRqX2V7Vbp496XGZuLc=;
	b=PlU7SVuiybn2O/SC+UaMq9iLzsCstoaXpm+BwHJG8urt1GkVNPJJ1ZD6qIs+jm2MSY3P5A
	B4zpfRmoHc9P2fGXetvfN7stpBguCXl1VdCRqTTQFOKjUKJSdjj9zkkBLYwsO4hhoc2z1P
	67qDHFd4k+SoXeCPqMRJn8YlQPjRFtE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-Xlv3I_8RNnSkbkpWpvEFZw-1; Wed, 03 Apr 2024 11:55:35 -0400
X-MC-Unique: Xlv3I_8RNnSkbkpWpvEFZw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a45acc7f07cso1044166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 08:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712159734; x=1712764534;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7RJPDwaAOgtbZoy/29/fhYCHYRqX2V7Vbp496XGZuLc=;
        b=wfkG4iKvL0kFDkB4bwWDEdE94Or/W1G7HeZtdusHE1SPgjN2YWMyplHdjyv/TmiIhx
         NkQ/I5zXyK5DG0hN97rL1kk1u8efMnQvjhdQAV7vr/nZVeJs1Vdit5E6OKc1IQYR+5rR
         wvyOmTjp/827EcaX7hcgONPMLaIUkp3wvn7yYbZ0p1ccye5JR2orkGt+npgnn0NHx6H2
         fLoRIrdQcNAua2tTrfK1iDdyJk240ABJCjXtbb7vaD43CC7qrpyPvymnQQnJ9tvIvCCr
         T8Ns+jrIEG5p8gm5UD8MnYbT76rJDnefbMNC3T+OiJkw6Vip1CAPh0ITs4YFWM1x0xqD
         xI1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoYvUXXQAYtXvCZ6+V7R0fVM5ci3viipUvhpwx0yTI36310CrkszrElDGZOJgo8+We4t0Ce55mGvD+G2Ddeh/Xbs1FNx8UL6bMwJEG
X-Gm-Message-State: AOJu0YyYGoBANH58h/TRrheNi3m5XgZjp4uMf+UBV+yVo3WM0ETVruxl
	n6ismCf5EhLqIuKTckzg15JTYpUkX73mSuiVoB+sBaTz3fvGWeyjttTff5AslNbYw/CLFsBfVhK
	nHnhPG94hNotGB3bJ7CAjLr/kb9qzbR6Asi2qzsSeBBMLzxt79klIatWWyVLIPA==
X-Received: by 2002:a17:907:2088:b0:a4e:4e8c:bedc with SMTP id pv8-20020a170907208800b00a4e4e8cbedcmr7916550ejb.53.1712159734698;
        Wed, 03 Apr 2024 08:55:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLNqrunE1FiBRVtmLkrQRwQXKNs/L7K0nBHa9W3hVmvgbWBcmFn0s9kHAY8Q4Qk2Mzij3JMQ==
X-Received: by 2002:a17:907:2088:b0:a4e:4e8c:bedc with SMTP id pv8-20020a170907208800b00a4e4e8cbedcmr7916540ejb.53.1712159734395;
        Wed, 03 Apr 2024 08:55:34 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id bn1-20020a170907268100b00a4e6750a358sm4036971ejc.187.2024.04.03.08.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 08:55:33 -0700 (PDT)
Message-ID: <88f45a04-4218-4d40-8338-86cbc4e3e61b@redhat.com>
Date: Wed, 3 Apr 2024 17:55:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] vboxsf fixes for 6.9-1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Colin Ian King <colin.i.king@gmail.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jeff Layton <jlayton@kernel.org>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here is a pull-req with a set of vboxsf fixes for 6.9
(I am the vboxsf maintainer):

- Warning fixes
- Explicitly deny setlease attempts

Regards,

Hans


The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git tags/vboxsf-v6.9-1

for you to fetch changes up to 1ece2c43b88660ddbdf8ecb772e9c41ed9cda3dd:

  vboxsf: explicitly deny setlease attempts (2024-04-03 16:06:39 +0200)

----------------------------------------------------------------
vboxsf fixes for v6.9-1

Highlights:
- Compiler warning fixes
- Explicitly deny setlease attempts

----------------------------------------------------------------
Christophe JAILLET (2):
      vboxsf: Avoid an spurious warning if load_nls_xxx() fails
      vboxsf: Remove usage of the deprecated ida_simple_xx() API

Colin Ian King (1):
      vboxsf: remove redundant variable out_len

Jeff Layton (1):
      vboxsf: explicitly deny setlease attempts

 fs/vboxsf/file.c  | 1 +
 fs/vboxsf/super.c | 9 +++++----
 fs/vboxsf/utils.c | 3 ---
 3 files changed, 6 insertions(+), 7 deletions(-)


