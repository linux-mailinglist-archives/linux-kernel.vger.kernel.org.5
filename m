Return-Path: <linux-kernel+bounces-159293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6AA8B2CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EB94B27C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014FA16EBE4;
	Thu, 25 Apr 2024 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYPLC9iX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74473152DE4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082502; cv=none; b=LAS9em54QyRkhgHkBofvLl/me5okXSJ34h1nAwS0/4UbU1MrYjlaxFNHtMX2y7EElnhvMnhxal+XKzTKr3/cre2Li8ndCuLIXxvlv1ir2/+/ioWlaK4/DnSytTlAbW/gFF+4iFZVi+vB7jEKub6CEKoQbvmofNxxlWz+2idj+js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082502; c=relaxed/simple;
	bh=klttxZkZSgZ3DZsghzDVzBR6b+2+d6rMvLnyNr/Ky6A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SSqVKOjgrAHPJLaAFdpKWSfruoR2o7yYkcD8BY1qnQCAoABhPBy/IFCiQy0P/kZKbweVrVmUJvEbTD95F4NUZIqRD18iuTa4MtEkmLO3G4c5G3bB/KZ8Ipi/XN2yag0FugGrJDZkY+UCeaY7jxtD2eGoLZgGk74h+a0e4wguUj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYPLC9iX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714082499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=10EB8JD8eFQ62awPO/uclqEC2RU83uJhAuNpjb8D5/0=;
	b=hYPLC9iXiCfk2vUtNNXAwT5SNShsRH4GUD2MlYfZMFFNk4wnY1qVjakDYp4FztiuBN4Dwz
	BqsBcxVgJXYf8JP+OJHPl8hysHr+w4LIKkjgMhnnECRF56b4aBf06GDPzTSRIGr4iHeciP
	3D0WKeMUooIgM8blCZUMthPC69rJetU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-jponz5uGN3ak0HlksO7ayw-1; Thu, 25 Apr 2024 18:01:37 -0400
X-MC-Unique: jponz5uGN3ak0HlksO7ayw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d87ba1f5e0so12673021fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082496; x=1714687296;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10EB8JD8eFQ62awPO/uclqEC2RU83uJhAuNpjb8D5/0=;
        b=w9XOKTyClLb+0sdVlSwOXSfKpvHqwG2lZ0zHt2MlSt5bDqyR0aBIMJpTcdzhjGkfyH
         uUNijN/fZVkupEH1fE+iFyXu27AgYSpW6PF9zM481ffwPCnR7PKCPPOneNdzim3gZ03W
         dQRXYN/vFWSRCwbm1VRBhKBsDRDZXXpVMBke9IqJpxd9e9pfAOqodCH1rEb1r8wGcfAU
         B5ZGHITb5GtKpLiN6Dda/rPryvAbcNHitjOhG1AXDYQMqyPTTF4w+wapDA01tE/SlMcc
         BUbpyH6imysbShtwsszDd96ah0Gyv+v4+pVshzbl0DJpgcJtSxiRkm3UPJ1uXgMBw3+j
         lRJw==
X-Forwarded-Encrypted: i=1; AJvYcCWJAVuaSF1JHsRtq56ZvLzRZX0LQC4fP5ge+yjj56cPJQRm3NSapY1z5pGgoPasCEI6cGCiUpLXgSnm95UBXkVNJyE5yHaC56l25RES
X-Gm-Message-State: AOJu0YzAFGplBk1fyx0ksEbjz87xF7HTxGvNjEFby3jmY6W4xwsmvqmG
	BXm2pWAlxXpCsmHHpOotk8CXgzSsX3v6xyHnSm3Dwfmphn1Xrs+Z4yQ/30xxajiFH3Rm6gljFf6
	ZMIN9yqucZBII9d3jUXKbnCZtjDYyb26DorHL6+Y/43Lx0N6pK26um4WiunhwnA==
X-Received: by 2002:a2e:740a:0:b0:2de:48ef:c3e1 with SMTP id p10-20020a2e740a000000b002de48efc3e1mr346932ljc.21.1714082495871;
        Thu, 25 Apr 2024 15:01:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm8NOZAbGoDAO9gTfyNd8pkjMtJVBD9uka+bmH/x6q4ADf9V1x2L+PuxHiHii3JJvSfxbhQw==
X-Received: by 2002:a2e:740a:0:b0:2de:48ef:c3e1 with SMTP id p10-20020a2e740a000000b002de48efc3e1mr346916ljc.21.1714082495199;
        Thu, 25 Apr 2024 15:01:35 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:ffa:7b40:24cf:6484:4af6])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00417f700eaeasm28993447wmo.22.2024.04.25.15.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:01:33 -0700 (PDT)
Date: Thu, 25 Apr 2024 18:01:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lingshan.zhu@intel.com, mst@redhat.com
Subject: [GIT PULL] virtio: bugfix
Message-ID: <20240425180106-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 0bbac3facb5d6cc0171c45c9873a2dc96bea9680:

  Linux 6.9-rc4 (2024-04-14 13:38:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 98a821546b3919a10a58faa12ebe5e9a55cd638e:

  vDPA: code clean for vhost_vdpa uapi (2024-04-22 17:07:13 -0400)

----------------------------------------------------------------
virtio: bugfix

enum renames for vdpa uapi - we better do this now before
the names have been in any releases.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Zhu Lingshan (1):
      vDPA: code clean for vhost_vdpa uapi

 drivers/vdpa/vdpa.c       | 6 +++---
 include/uapi/linux/vdpa.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)


