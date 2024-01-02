Return-Path: <linux-kernel+bounces-14503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB481821E04
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63968B21BE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A23012E5E;
	Tue,  2 Jan 2024 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ppg+h/jS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F400112E55
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704206813; x=1735742813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1xOgkD9JBJe8uies5tEljqRtMC1wo5efArySvQ9q9+o=;
  b=Ppg+h/jSD272CSoSSe59ulD+5bgmcU/lFGujudTnrxdCYIrpcJTTDYWe
   aKbuqJyGcGL2jFjcbdhSoH2zcnCPaYWhilHtSWkUljNph63zjV73Z09mN
   1G40yxj/qeMtng1DmcbDwVb1pfa9aScZ6a0QBDPn8p9KPslG2kDVhL1V2
   0=;
X-IronPort-AV: E=Sophos;i="6.04,325,1695686400"; 
   d="scan'208";a="263877950"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 14:46:51 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com (Postfix) with ESMTPS id 3365640D65;
	Tue,  2 Jan 2024 14:46:50 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:38664]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.59:2525] with esmtp (Farcaster)
 id 5351803e-5eff-4784-a7ab-0c4a56c9f593; Tue, 2 Jan 2024 14:46:49 +0000 (UTC)
X-Farcaster-Flow-ID: 5351803e-5eff-4784-a7ab-0c4a56c9f593
Received: from EX19D037UWC001.ant.amazon.com (10.13.139.197) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Jan 2024 14:46:49 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D037UWC001.ant.amazon.com (10.13.139.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Jan 2024 14:46:49 +0000
Received: from dev-dsk-jalliste-1c-e3349c3e.eu-west-1.amazon.com
 (10.13.244.142) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Tue, 2 Jan 2024 14:46:47 +0000
From: Jack Allister <jalliste@amazon.com>
To: <dave.hansen@intel.com>
CC: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hdegoede@redhat.com>,
	<hpa@zytor.com>, <jalliste@amazon.com>, <juew@amazon.com>,
	<len.brown@intel.com>, <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
	<pdurrant@amazon.com>, <peterz@infradead.org>, <rafael.j.wysocki@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <usama.arif@bytedance.com>,
	<x86@kernel.org>
Subject: Re: [PATCH v4] x86: intel_epb: Add earlyparam option to keep bias at performance
Date: Tue, 2 Jan 2024 14:46:46 +0000
Message-ID: <20240102144646.44355-1-jalliste@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bcd1b113-94b7-41a9-a3f6-fde1dd54fc74@intel.com>
References: <bcd1b113-94b7-41a9-a3f6-fde1dd54fc74@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

> Jack, I'd really appreciate if you could please slow down.

I'm sorry about this, I'm still extremely unfamiliar with the open-sourcing conventions/
workflow when working with mailing lists & the upstreaming to the Linux kernel. I have
taken this feedback & have started to look through the maintainer tips & docs for
guidance.

Also sorry for the delay in actual response here too, general work responsibilities & the
holiday period has had an affect here.

Before I go ahead with posting up a revision 5 with all of your queries/suggestions I do
have a few questions I'd just like to clarify.

> We could, for instance just support this pair:
>	intel_epb=auto		(default, will hack performance=>normal)
>	intel_epb=preserve	(leave it alone)

With the suggestion above you mentioned implementing this, if this was to be implemented
do you think keeping it `intel_epb_restore_default` as a bool is still worth it? e.g:

```
static __init int intel_epb_no_override_setup(char *str)
{
	if (!str)
		return 0;

	if (!strcmp(str, "preserve"))
		intel_epb_no_override = true;
```

Or do you think it would be worth actually removing `intel_epb_no_override` and creating
a module variable `intel_epb_restore_default` which is an enum of the performance values.

Doing so would then allow for expansability in the future which you had already alluded to
e.g setting to other values such as EPB_INDEX_BALANCE_POWERSAVE/PERFORMANCE.

