Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251C2805021
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344993AbjLEKXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjLEKXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:23:07 -0500
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9430A0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701771794; x=1733307794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hO/h+lg9f5XLL35KHLPwlXxDM0DUClE8yQc1o+OW3BU=;
  b=sukbXIEHPqtUdRhyOl1g2mo6PwPtxvYKUMBVTClzp9ivDiEna+/MF03D
   twk6OswQ+lej1ob4Evo3sBmtpcjmor8TfsuXtAbgM/Knz83JUP/pti62t
   +mNkidpzn0rO7SM899RdzLycVoAJVCq2z03wxshMQ8d6o0Bm52gwqyL/N
   0=;
X-IronPort-AV: E=Sophos;i="6.04,251,1695686400"; 
   d="scan'208";a="688983494"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 10:23:08 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix) with ESMTPS id 20922C0627;
        Tue,  5 Dec 2023 10:23:07 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:33822]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.167:2525] with esmtp (Farcaster)
 id a0c1ba25-1530-4c7b-9df8-401cf816d3de; Tue, 5 Dec 2023 10:23:06 +0000 (UTC)
X-Farcaster-Flow-ID: a0c1ba25-1530-4c7b-9df8-401cf816d3de
Received: from EX19D037UWC004.ant.amazon.com (10.13.139.254) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 10:23:06 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D037UWC004.ant.amazon.com (10.13.139.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 10:23:06 +0000
Received: from dev-dsk-jalliste-1c-e3349c3e.eu-west-1.amazon.com
 (10.13.244.142) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Tue, 5 Dec 2023 10:23:03 +0000
From:   Jack Allister <jalliste@amazon.com>
To:     <dave.hansen@intel.com>
CC:     <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <hdegoede@redhat.com>, <hpa@zytor.com>, <jalliste@amazon.com>,
        <juew@amazon.com>, <len.brown@intel.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <pdurrant@amazon.com>, <peterz@infradead.org>,
        <rafael.j.wysocki@intel.com>, <rafael@kernel.org>,
        <tglx@linutronix.de>, <usama.arif@bytedance.com>, <x86@kernel.org>
Subject: Re: [PATCH] x86: intel_epb: Add earlyparam option to keep bias at performance
Date:   Tue, 5 Dec 2023 10:23:02 +0000
Message-ID: <20231205102302.58434-1-jalliste@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c1e8e8cb-f792-4dcc-a72f-fbebe4476a1b@intel.com>
References: <c1e8e8cb-f792-4dcc-a72f-fbebe4476a1b@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is fundamentally a hack.

I do not totally agree that this is a hack, the setting of it to the
ENERGY_PERF_BIAS_NORMAL is an equivalent workaround which is used for
systems where the platform firmware has not configured it as expected
for laptops etc. and that is already present.

> It sounds like you want the system default to be at
> ENERGY_PERF_BIAS_PERFORMANCE.  You also mentioned that this was done "on
> kernel boot".  How did you do that, exactly?  Shouldn't that "on kernel
> boot" action be reflected over here rather than introducing another
> command-line parameter?

As Paul has mentioned, we perform live-updates of the host kernel running
on servers. This is done while virtual machines are still running so that
there is no perceived downtime for the guest/customer. This requires a
kexec into the new kernel and there are specific areas such as PCI device
enumeration which can take a substantial amount of time in it's current
form and can be perceived as downtime while the kernel is loading.

> Shouldn't that "on kernel
> boot" action be reflected over here rather than introducing another
> command-line parameter?

A kernel parameter may not be the most elegant solution, would a proposal
for a kernel build configuration be a bit more suitable?
