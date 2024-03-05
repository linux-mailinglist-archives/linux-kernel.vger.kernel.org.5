Return-Path: <linux-kernel+bounces-92015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E66F38719BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D66282D4A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4821152F97;
	Tue,  5 Mar 2024 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnIxOuts"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC474CB2E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631688; cv=none; b=LASWX8afBUHaeJQL+rbOlVulh5o42ZckispUyya80NiNqSYFfoLHcgyu2hFTKgPZQ7iD3k/TlisIAGM3pOC02amYV5nw83yCCtewZRCBjzUFGFUkbezmZ7tZiWwSBEEKC3A5xyDFuuLMovk569d7hltUzCtty/PrWJTvn9Ng4y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631688; c=relaxed/simple;
	bh=j99ddBTiQ9lQxPqXZPMvZcO5f+DwjapqgNSi3KxFs4E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=TFyr6HnRdL6rPdqFD0emDtB7njJ0Dq7LNWBnlQ6e16RiMhM1Js0KVbMmHDF9AqpywZNjcByX85/EWZbPXW6K+Mgh8E7kgnICrNeBuwOtvvJhV/YbH4Cd3P7ixtO7+vb1a0iCHD+DtkmV/VUQ80yToOmjrGjbvXBfHUq4uEGRxWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OnIxOuts; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709631685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wr0roZvWuOsUV+YvTOf0P3aaCM+zuRpbCTEDJoBeQ4c=;
	b=OnIxOutsXOeGgXTiOy2nRNaxYVvheeAd8aUyoZhnBiMhoDf8V1duXymTAJbqeQ14w1W74W
	ApWiedmbuWGDwoYej5Pr8G6YWI4Q2jOOZvffEfzBx3gfi+bPyb+MSLUTM6yB6edLBvDkNS
	ius8xoLD0ZXX/bNKmSbHs3hlDsZx56k=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-LEWtDjW3PGGoyxrx4wtkpg-1; Tue, 05 Mar 2024 04:41:23 -0500
X-MC-Unique: LEWtDjW3PGGoyxrx4wtkpg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d30e16be75so46120681fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:41:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709631681; x=1710236481;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wr0roZvWuOsUV+YvTOf0P3aaCM+zuRpbCTEDJoBeQ4c=;
        b=hf7tQuNKyzZeLpnkbLInXW61yHYkkmPeyqmBX9pGweUQjZ6r/MiEV6upvPhtUaZ1gs
         8cMKVuodcBGhMJeeHEjYjZhp9IuSTRFvngfuzjDr4JywFrSFRrlZCFSaG/u1qWy8C+ac
         qhxC+rhXIwpUF5eTEPSFTgqGp85DdJ5Rm7YIh7RxZ7wkmO7zh9omf24vdxbq6WKIbjUp
         Wp4mU9vYa6dx/x5MCN8NS1poBx+Myju/BHvOErG9cq8owqktJeW3UhH3ImEgxha1oQhd
         NWASIjjEQL0AYPcavQkneJbRt2VFbLAjDMs29iagi6KZnvtdSBYXiuVr9Z8a7+aBjXxY
         xQSQ==
X-Gm-Message-State: AOJu0YwJRI/4RAWa8FoX1/C+hsJBl+LSq1A9wo1vWK2tzc+rp7FLIpyC
	DW6wbNok/RpZPau8j9pjX4WZNQ1RPgMeJ68Vh19TLoyfG8Br0mH2Oz+Ytq1m55NZEJa4eFTfGwn
	jiRkGb/k0WgzHzgrjE4o7aH+mMT3CSE+3t0i/5Oqlm45qWutJepbdyiNh4Ep7D1DH1eVBtw==
X-Received: by 2002:a17:906:374c:b0:a45:8424:163d with SMTP id e12-20020a170906374c00b00a458424163dmr2143502ejc.17.1709631370713;
        Tue, 05 Mar 2024 01:36:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoYQkZSrR5bSpBqmOm1XmIkknblRMs/TxvEnFWo/B3gpC5Ka7h1SJRq8pzlbR5tYftd8e0nA==
X-Received: by 2002:a17:906:374c:b0:a45:8424:163d with SMTP id e12-20020a170906374c00b00a458424163dmr2143493ejc.17.1709631370440;
        Tue, 05 Mar 2024 01:36:10 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id rp25-20020a170906d97900b00a3d665c6778sm5922772ejb.12.2024.03.05.01.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 01:36:10 -0800 (PST)
Message-ID: <cfc29d60-e11c-4d7f-9d9d-637ebde8f5fd@redhat.com>
Date: Tue, 5 Mar 2024 10:36:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.8-4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here is the third round of fixes for platform-drivers-x86 for 6.8.

Highlights:
 -  Fix P2SB regression causing ACPI errors and high CPU load
 -  Fix error return path in amd_pmf_init_smart_pc()

Regards,

Hans


The following changes since commit 427c70dec738318b7f71e1b9d829ff0e9771d493:

  platform/x86: thinkpad_acpi: Only update profile if successfully converted (2024-02-20 14:35:36 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.8-4

for you to fetch changes up to 0314cebb29be2f961abb37bd0b01cb16899868f2:

  platform/x86/amd/pmf: Fix missing error code in amd_pmf_init_smart_pc() (2024-03-05 10:17:07 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v6.8-4

Highlights:
 -  Fix P2SB regression causing ACPI errors and high CPU load
 -  Fix error return path in amd_pmf_init_smart_pc()

The following is an automated git shortlog grouped by driver:

p2sb:
 -  On Goldmont only cache P2SB and SPI devfn BAR

platform/x86/amd/pmf:
 -  Fix missing error code in amd_pmf_init_smart_pc()

----------------------------------------------------------------
Hans de Goede (1):
      platform/x86: p2sb: On Goldmont only cache P2SB and SPI devfn BAR

Harshit Mogalapalli (1):
      platform/x86/amd/pmf: Fix missing error code in amd_pmf_init_smart_pc()

 drivers/platform/x86/amd/pmf/tee-if.c |  4 +++-
 drivers/platform/x86/p2sb.c           | 23 ++++++++---------------
 2 files changed, 11 insertions(+), 16 deletions(-)


