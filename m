Return-Path: <linux-kernel+bounces-69368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0089A858811
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C6F1C220BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B0D145FF9;
	Fri, 16 Feb 2024 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H53vjPWh"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9921F136658
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119372; cv=none; b=Cgr+5lU95T6T7sPUh5D4OmlyfvhkgKLgif5rJVG6BxH2YSKazay2WSY0bh842BYERbZKtf9ewuDxBgnu8gi1Lpz7e9Uk6Gfs58G0tCK3dUnB+4HUkzOwg6JiLN4mmhDdPx+qkfgltBqVNfyz4siBN1QascnPiZBLFHKaWJ/d2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119372; c=relaxed/simple;
	bh=llCryPeZKPC3peuANCsMad6kJTIc/2KpAtyMnpKsZmk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GLuo23B6e2Cm3wmIWG4ZLYaN8NLxUFLbk4hWryQzz3wVkRahVrFrM16YwtCFAyEQ+witB4RZY2HpXNE+X8CQ/i5KhscluNhU+BcM26Nnzyj/ra1XK3ocmlfABEUYbx+rX7/I2yzpw7brQyY4GuC8yKYPqIjn97Cbn6YK1nBUlu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H53vjPWh; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e0eacc5078so2102444b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708119369; x=1708724169; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=E6p8O4oRNFst+6Ab9och+HD3OoVinOBFShK5KI2dZR0=;
        b=H53vjPWhdwkVEfzFibyvH6QI87ZQbhT6nrppakPc/XmbuPqlqO8At+62ZGKfyCoWwe
         ijoxE1PCfx4iqNC7GrQEd/jW6QU4WBKscakVczwaxjzMvlkzEXDgFid8i/j8PE5w6u8t
         0ZK3wJtFaW3L9lW5vGGZXEiUp8959DfVPcZ46SuaZj2NsxGl1IEBsu+R+x6K82fXl6QE
         oKnE/j15GbWhiuRL60uIqoQXfjCe/Dm9CpIascrbZe7h8fiojQgJoq0cIad2S1Yv6DaL
         i4SwvSyfX4TzOnDOQhMWNacuLsL3y+BqjzzBm6su4/JmBs5x4JagmA2p6k7nDr7MqCR+
         JfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708119369; x=1708724169;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6p8O4oRNFst+6Ab9och+HD3OoVinOBFShK5KI2dZR0=;
        b=QzU3vcrpZ88/TKd5adltymJ6skb0pUpBeYB37kVpEGGxd2h3p7R+LxiU1jVmAZuBc7
         aaFekyhT1ryJG1TyjzjAqQoN/VIw5pxsOmWK4QvCYOYg85lKHY7JbmjWOTk8AkgvhTjB
         OBd9KtwEPoK8CCMxHLaaVByhPJqnxLl3qRnjAiFHgWTE6XxEB5M4C8auSZWR3i1kljlz
         6h3QTu5fuC51lKBdTJO6RZg3Wrw/DOPvyJ6WzqDBXDj57hGeFhFekwqxAYYo7a5og3Su
         hZ8ZYt4wpwvcPi8W12K9yDsAIdKAdjJxo1hx5+kJb20XukfVklPYUCGX8yiQyw92t27L
         xsbw==
X-Forwarded-Encrypted: i=1; AJvYcCUXCGr5Mf76aufJoMuovWcvxM14KuWaQB+VHnMDKbeVcIVzlegqVxtuYGU0LE8sdl7+7yDUU8IRjhn5wBM3JNiK5oIhTympngbL4Fox
X-Gm-Message-State: AOJu0YxdipPYjKG97BwtsNe//DRgTae+iuu24J3Q0AzRR2ceIUL3oVln
	Ok87RNBl1p3lVLiIzDXRNZCIDAfAQSoCupRiRrCn8BFbqmW6l299
X-Google-Smtp-Source: AGHT+IHEotwD+0xdqSOtDq+hRutYhBX0++jVH5wG9sRTK7XnnDuSClVa2bzgjhOCrfiOJC9lrHp8OA==
X-Received: by 2002:a05:6a00:178c:b0:6e0:51d7:5805 with SMTP id s12-20020a056a00178c00b006e051d75805mr8878362pfg.1.1708119368753;
        Fri, 16 Feb 2024 13:36:08 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id x40-20020a056a0018a800b006e0503f467bsm405938pfh.39.2024.02.16.13.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 13:36:08 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 16 Feb 2024 11:36:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] workqueue fixes for v6.8-rc4
Message-ID: <Zc_VR5qdSuLcmL3Y@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 052d534373b7ed33712a63d5e17b2b6cdbce84fd:

  Merge tag 'exfat-for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat (2024-01-12 18:05:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.8-rc4-fixes

for you to fetch changes up to aac8a59537dfc704ff344f1aacfd143c089ee20f:

  Revert "workqueue: Override implicit ordered attribute in workqueue_apply_unbound_cpumask()" (2024-02-05 15:49:06 -1000)

----------------------------------------------------------------
workqueue: Fixes for v6.8-rc4

Just one patch to revert ca10d851b9ad ("workqueue: Override implicit ordered
attribute in workqueue_apply_unbound_cpumask()"). This could break ordering
guarantee for ordered workqueues. The problem that the commit tried to
resolve partially - making ordered workqueues follow unbound cpumask - is
fully solved in wq/for-6.9 branch.

----------------------------------------------------------------
Tejun Heo (1):
      Revert "workqueue: Override implicit ordered attribute in workqueue_apply_unbound_cpumask()"

 kernel/workqueue.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--
tejun

