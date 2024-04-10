Return-Path: <linux-kernel+bounces-137893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADCE89E910
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA99528316F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B57110A03;
	Wed, 10 Apr 2024 04:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="D25LaJJv"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE4BA41
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723985; cv=none; b=Jrsg9MCr208mOMwViwmtguGn5Zf8ZF5Y1Ll97aPwND1ssv9PuG7Mvr9n4xC9wMIWM8nDWb4vUfAdO5U3AhIMLdCg4IQ8mSUU5b6e9VDcSNHVond4fGkqVzGIe+/VFjXga2YTFPwxmyMY7V5TJaa01Q9C+sbSuhRY9nyNPya+ILw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723985; c=relaxed/simple;
	bh=DtdulvZeq18gg5nwhugKq6JgQxiYFWo/qLdw+2pmabM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dcWqUMxsYvA9XFk0pwf3dD+lZCuVFN8Nm5eJeCLjwmygamb0HVQgDj/l/dYG5x2Bw9y3bhdMP17orZd42u/vuza1blUpAea+q1OvUsa/teLA5rkUWO4yu5Cr+5ePPnJjeyqyovuAoPVef2bul5OFh+3B87SntciAD8Owpprm84Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=D25LaJJv; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a484f772e2so3072015a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 21:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1712723983; x=1713328783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FTBKn+X9fYIhUY+SfQqhA1p7Ow+PslkWyXYeQlLznYk=;
        b=D25LaJJvAKSXYchN6l1DiUFXFFyJthF2928PYJkQVv4AfGh0hfZ1sc/e2aI7RJUHCy
         cJpHgWuaWG2pPoG6tlUlkcOByTeZM2dfRBAemtGWqrgsLBcEq8YLxohiAG35RuvVelPU
         edVqJ+IPaoAGev5jYka87Xgr1vukAITh4pgeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712723983; x=1713328783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTBKn+X9fYIhUY+SfQqhA1p7Ow+PslkWyXYeQlLznYk=;
        b=DrJyY1+GdAp9/bLHZqO6sOgtCn95CVaclGsdMWOvkM+OKtdS6sykjE3+SJXgx0boA5
         Es7x2TqMknjIGPvrZn/jVqiLimvHxdASyzHk/4PaYA8TbhadkBC7clccRLNwVtLkxpzw
         3q6vU7BCRJG9KXh6dubT900sB6BcS0HZO2r5z5t65Xqluo7Izn/RC2QiGyzzZEKlqY8L
         mXQrw6EAPJ0hLwnK+S+rkDjkieB4JAD40cI10sOAMyETqyMd4Umt7YOmN2UjIJUN6ClA
         Dmu9aiqSKcLSxIshLo3qt6ShCyKxEGQ8fsFxGh0m3eNH8OE2yu77x8r8w+LGNEGB6XQl
         /2Zg==
X-Gm-Message-State: AOJu0Yw5RkZAx9tw1Jfp9n2y4KorgoMpn40I8x9DkMTkKlDUHNyo6stF
	PfyGoC3KkNWR9X0a2hntYPcb+Vk9ZYn9rwrT1i4j3aANKlTOwYGkglIPJApYQ5BnkoMaraz1/mk
	awHE7zKiXzeAHIoFCfrPnKFgW6fqw7QZyMBskHsqMyWvRKYo1LjyW+vNKohWeJlIiXJ8AaLswZm
	HXuCJMw3b7yCHq7qZ1pjkvuNeByADfCtoGU00lOTowq4s=
X-Google-Smtp-Source: AGHT+IE6idq9nTJW2mID+KEBk2ciEgsbfXSMT5eLrh1uUoPhsGEPfHjous1/IHHuE4a4LZ+5SF/hIg==
X-Received: by 2002:a17:90a:d505:b0:2a5:37cc:cc4e with SMTP id t5-20020a17090ad50500b002a537cccc4emr1550232pju.32.1712723982772;
        Tue, 09 Apr 2024 21:39:42 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id gn4-20020a17090ac78400b002a5d71d48e8sm260773pjb.39.2024.04.09.21.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 21:39:42 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: sridhar.samudrala@intel.com,
	amritha.nambiar@intel.com,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [intel-next 0/2] i40e: Add support for netlink API
Date: Wed, 10 Apr 2024 04:39:33 +0000
Message-Id: <20240410043936.206169-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

This change adds support for the new netlink APIs to i40e which:
  - link queues, NAPI IDs, and IRQs together
  - export per-queue stats

This change is inspired by a similar change made to the ice driver commit
91fdbce7e8d6 ("ice: Add support in the driver for associating queue with
napi").

I attempted to replicate the rtnl locking added to the ice driver in commit
080b0c8d6d26 ("ice: Fix ASSERT_RTNL() warning during certain scenarios") in
patch 1/1, but there's certainly a good chance I missed a case; so I'd
kindly ask reviewers to take a close look at, please.

Thanks,
Joe

Joe Damato (2):
  net/i40e: link NAPI instances to queues and IRQs
  net/i40e: add support for per queue netlink stats

 drivers/net/ethernet/intel/i40e/i40e.h      |   2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 160 ++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |   4 +
 3 files changed, 166 insertions(+)

-- 
2.25.1


