Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A7678DFFC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344146AbjH3T0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245420AbjH3PMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:12:18 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E919E8;
        Wed, 30 Aug 2023 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693408336; x=1724944336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MjUZcxZ7RsuvcZ9EFUr1kf2dnv7Em04ZkKJ/d4jJHEg=;
  b=BaK11JJ9J1oBzaOjLRK//bzS+y/PD/Bw8owqlv5cNqRNVsiK9FGfYaW5
   fzLemFlT1JtDUP0LhW+PrFJDD4xkjAE2VWlBUn6tfsspe5CNE6t+GgRzc
   kdtnViMrCJABe8xgrYPgy6hC0YCX4gYoCNTBIcJll2C6RhLUH0EH+Ln6L
   A=;
X-IronPort-AV: E=Sophos;i="6.02,214,1688428800"; 
   d="scan'208";a="348522557"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 15:12:13 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com (Postfix) with ESMTPS id 93CFAA1013;
        Wed, 30 Aug 2023 15:12:09 +0000 (UTC)
Received: from EX19D002ANA003.ant.amazon.com (10.37.240.141) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 30 Aug 2023 15:12:08 +0000
Received: from b0f1d8753182.ant.amazon.com (10.106.83.32) by
 EX19D002ANA003.ant.amazon.com (10.37.240.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 30 Aug 2023 15:12:04 +0000
From:   Takahiro Itazuri <itazur@amazon.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>
CC:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takahiro Itazuri <zulinx86@gmail.com>,
        Takahiro Itazuri <itazur@amazon.com>
Subject: Re: [PATCH] docs: Add desc for best effort mode of mmio_stale_data
Date:   Wed, 30 Aug 2023 16:11:53 +0100
Message-ID: <20230830151153.84489-1-itazur@amazon.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <87msy8r3cj.fsf@meer.lwn.net>
References: <87msy8r3cj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.83.32]
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D002ANA003.ant.amazon.com (10.37.240.141)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> wrote:
> So the change seems OK, but why not just describe the "best effort" mode
> in the place where you refer to it, rather than creating a forward
> reference?

tbh, I just followed the docs for mds and tsx_async_abort. Of course, I
can do it! Would it better to do the same thing for mds and
tsx_async_abort docs as well?

Best regards,
Takahiro Itazuri

