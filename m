Return-Path: <linux-kernel+bounces-74093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41D185CFDD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB07282DED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C929C39FCF;
	Wed, 21 Feb 2024 05:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AU8WSuWs"
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5FB15A5;
	Wed, 21 Feb 2024 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494130; cv=none; b=XI8jd8jq+dBwzKcHj+X2gLUFgIFxwmQadpPMTAoZgZW3PE+7t/pwKNxnY33oU9Q0UCR9o7V1dC/fBCcGmKwQdEdAcmmxjlXB9Q3DdruP+EloFnu96lGf8rWqvcSPmIAuXkhdpYat4R2ZjQYXPFm7fQUvOqi3poW7CmuHbqo5uyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494130; c=relaxed/simple;
	bh=cGaSLMlLu7obgGVEplEAZ5ydNe3Gim/TosgoGlQ22y8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9NZ3SmUPGc9kVlo7ptEBUctfG32WGlU/RdhxlE56eXDvjeLY82EnofgTmaroam1S/PkcycuWAUFOy8mWv/4+4OV8+5lPWKIEClx44sNZ3/a/xNAwuEmpWWuvdcAmYKUKRqu8IS0q2e2eCZ9IJRc/mavKszrgH3Lvz3iNaeE8zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AU8WSuWs; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708494129; x=1740030129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nCb56l2vj0YcNG57jkT1YQ6JqSPECiwfE7fb1NQs81g=;
  b=AU8WSuWsi/NRLuor6onCW2LI1c8Bi+CQfI4a+RfGr+33gCHgiP5sqcsr
   EmQxuqf0W554ey/fQzHg6zLUQi44I9oUG4uEtFpXHBhrn+hXxCu9G+lDe
   MthdiQZkH0HTvsSkaHlhzwCTQacgbe+1gGEboD7xRo//DdkKGnDhHXP9B
   o=;
X-IronPort-AV: E=Sophos;i="6.06,174,1705363200"; 
   d="scan'208";a="274736649"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 05:42:07 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:29998]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.151:2525] with esmtp (Farcaster)
 id 1cf9b7cc-9ac7-4cda-a4e5-9730db8a2576; Wed, 21 Feb 2024 05:42:06 +0000 (UTC)
X-Farcaster-Flow-ID: 1cf9b7cc-9ac7-4cda-a4e5-9730db8a2576
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 21 Feb 2024 05:42:05 +0000
Received: from 88665a182662.ant.amazon.com.com (10.119.137.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Wed, 21 Feb 2024 05:42:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pengfei.xu@intel.com>
CC: <davem@davemloft.net>, <dumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<lkp@intel.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [Syzkaller & bisect] There is BUG: soft lockup after sendmsg syscall in v6.8-rc4
Date: Tue, 20 Feb 2024 21:41:54 -0800
Message-ID: <20240221054154.51749-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZdVgLbuAYGKoDzpS@xpf.sh.intel.com>
References: <ZdVgLbuAYGKoDzpS@xpf.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Pengfei Xu <pengfei.xu@intel.com>
Date: Wed, 21 Feb 2024 10:30:05 +0800
> Hi Kuniyuki Iwashima and kernel experts,
> 
> Greeting!
> There is BUG: soft lockup after sendmsg syscall in v6.8-rc4 in guest.
> 
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240220_161242_softlockup
> Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/repro.c
> Syzkaller syscall reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/repro.prog
> Kconfig(need make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/kconfig_origin
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/bisect_info.log
> v6.8-rc4 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/841c35169323cd833294798e58b9bf63fa4fa1de_dmesg.log
> bzImage_v6.8-rc4: https://github.com/xupengfe/syzkaller_logs/raw/main/240220_161242_softlockup/bzImage_v6.8-rc4.tar.gz
> 
> Bisected and found first bad commit:
> "
> 1279f9d9dec2 af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.
> "

Thanks for the report.

I think syzbot reported the same issue.
https://syzkaller.appspot.com/bug?extid=ecab4d36f920c3574bf9

Could you try this patch ?
https://lore.kernel.org/netdev/20240219174657.6047-1-kuniyu@amazon.com/

