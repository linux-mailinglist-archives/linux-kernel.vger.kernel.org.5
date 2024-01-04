Return-Path: <linux-kernel+bounces-16410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B47823E0C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995AD1C21564
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AF020300;
	Thu,  4 Jan 2024 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NJUWkLXt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2371EA84;
	Thu,  4 Jan 2024 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704358841; x=1735894841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tNlRBzJDdgAtPRThgcKGd66oGqP55+o+uVLu7u78wsw=;
  b=NJUWkLXtqlqJwoOP1kEODIp9Gh2Fl6ttXI1XsP9ETMRC6sY+BiWRwRba
   bGM5cZLM34H8bXB9SpsvrQ2W6gsBS9KMAe/tQGI95F/DzNM+T4h3V5y67
   85sjWrzlRfErUNZlANwiY0Yb12S+EtnW/426+y5DKiUeFqfQhmSkMQcpQ
   Y=;
X-IronPort-AV: E=Sophos;i="6.04,330,1695686400"; 
   d="scan'208";a="694906906"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 09:00:33 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com (Postfix) with ESMTPS id EF266160691;
	Thu,  4 Jan 2024 09:00:26 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:30427]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.136:2525] with esmtp (Farcaster)
 id cbab2357-f29d-4d1f-a64d-f885bb61257b; Thu, 4 Jan 2024 09:00:25 +0000 (UTC)
X-Farcaster-Flow-ID: cbab2357-f29d-4d1f-a64d-f885bb61257b
Received: from EX19D037UWC003.ant.amazon.com (10.13.139.231) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 4 Jan 2024 09:00:25 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D037UWC003.ant.amazon.com (10.13.139.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 4 Jan 2024 09:00:25 +0000
Received: from dev-dsk-jalliste-1c-e3349c3e.eu-west-1.amazon.com
 (10.13.244.142) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Thu, 4 Jan 2024 09:00:23 +0000
From: Jack Allister <jalliste@amazon.com>
To: <usama.arif@bytedance.com>
CC: <bp@alien8.de>, <corbet@lwn.net>, <dave.hansen@linux.intel.com>,
	<hdegoede@redhat.com>, <hpa@zytor.com>, <jalliste@amazon.com>,
	<juew@amazon.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mingo@redhat.com>, <paulmck@kernel.org>,
	<pdurrant@amazon.com>, <peterz@infradead.org>, <rafael@kernel.org>,
	<rdunlap@infradead.org>, <tglx@linutronix.de>, <tj@kernel.org>,
	<x86@kernel.org>, <yanjiewtw@gmail.com>
Subject: Re: [PATCH v5] x86: intel_epb: Add earlyparam option to keep bias at performance
Date: Thu, 4 Jan 2024 09:00:22 +0000
Message-ID: <20240104090022.41499-1-jalliste@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a57b9e19-3466-bb73-1c88-c19417ac6822@bytedance.com>
References: <a57b9e19-3466-bb73-1c88-c19417ac6822@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

> Thanks for the patch. Is auto needed over here? It was pointed in an 
> earlier review that it could be an option, but it doesn't seem to serve 
> a purpose.

Auto is effectively just the default as if no parameter is passed in here.
In the reply from Dave for he has mentioned that displaying it like this
may actually be clearer.

```
	intel_epb=	[X86]
			
			auto (default)
```

As we're not implicitly not taking any action for this default case it
doesn't make too much sense to add in a specific strcmp case for auto,
however what I can do is add a comment within the code to explicitly show
that this is effectively a no-op when parsing.


> Maybe add an print in else here to say that unexpected value has been 
> encountered for intel_epb if preserve is not seen.

I'd be hesitant to do this as we already have the pr_warn_once during the
intel_epb_restore path when defaulting from perf -> normal.

