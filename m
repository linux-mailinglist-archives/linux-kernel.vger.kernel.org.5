Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715E2798685
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 13:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242461AbjIHLjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 07:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjIHLi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 07:38:58 -0400
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7901BF9;
        Fri,  8 Sep 2023 04:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1694173132; x=1725709132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JOQos2qmljJVtEePP+1McXoDJjdUpywTYtAMgyf4ge8=;
  b=Pf2DY+zBtQTwM80lfqm4KETtmgKPJ1kROHT39Vo3eTVrbkvMMOfV8zwa
   G3+yHFFd1TK4OscYSp9e9p41uZpOtZ3DXgG7czy9TMl1Pn7nSF8hD/cCv
   7wQ7ta3LPmA52aSPL4iVmMWrFzmX47fR4uPXbs0pqUXx7KKv6tKf3s70L
   Y=;
X-IronPort-AV: E=Sophos;i="6.02,237,1688428800"; 
   d="scan'208";a="671102936"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 11:38:45 +0000
Received: from EX19D008EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com (Postfix) with ESMTPS id BFDBAC3159;
        Fri,  8 Sep 2023 11:38:42 +0000 (UTC)
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008EUA004.ant.amazon.com (10.252.50.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 8 Sep 2023 11:38:41 +0000
Received: from dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (10.15.57.183)
 by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Fri, 8 Sep 2023 11:38:41 +0000
Received: by dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (Postfix, from userid 5466572)
        id E815B963; Fri,  8 Sep 2023 11:38:40 +0000 (UTC)
Date:   Fri, 8 Sep 2023 11:38:40 +0000
From:   Maximilian Heyne <mheyne@amazon.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <stable@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] virtio-mmio: fix memory leak of vm_dev
Message-ID: <20230908113840.GA19696@dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com>
References: <20230907141716.88863-1-mheyne@amazon.de>
 <ZPn6KZpdPdG2LQqL@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPn6KZpdPdG2LQqL@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 05:28:25PM +0100, Catalin Marinas wrote:
> On Thu, Sep 07, 2023 at 02:17:16PM +0000, Maximilian Heyne wrote:
> > With the recent removal of vm_dev from devres its memory is only freed
> > via the callback virtio_mmio_release_dev. However, this only takes
> > effect after device_add is called by register_virtio_device. Until then
> > it's an unmanaged resource and must be explicitly freed on error exit.
> >
> > This bug was discovered and resolved using Coverity Static Analysis
> > Security Testing (SAST) by Synopsys, Inc.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 55c91fedd03d ("virtio-mmio: don't break lifecycle of vm_dev")
> > Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Tested-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Thanks.
> 
> --
> Catalin

Who would apply this patch? Something seems to have choked my patch so it didn't
reach lore.kernel.org (message couldn't be delivered due to timeout). Should I
try to send it again?



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



