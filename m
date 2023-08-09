Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9849776635
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjHIRPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHIRPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:15:09 -0400
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF341FF5;
        Wed,  9 Aug 2023 10:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691601309; x=1723137309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uteISYD7JjwOHR1wR44ZJlbh38MA4pfZt8hz5AGXo18=;
  b=md3waMxARUUgjO51GozgYzbPz4zgPuaezY9WZlskZwS51clr34evcYAz
   3aPsWHlgg+VqQBFwwUmf4bMTUWhCRRaqk7fDaAASgfyhwsBTLWLZRRppN
   VkGEBo7W2/2zFjP9OWdhAaVKnxry8zV37pMi8gV/+JVuusSNEuKcmGzuj
   Y=;
X-IronPort-AV: E=Sophos;i="6.01,159,1684800000"; 
   d="scan'208";a="147566634"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 17:15:06 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com (Postfix) with ESMTPS id EE13F40D6D;
        Wed,  9 Aug 2023 17:15:03 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 17:15:03 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Wed, 9 Aug 2023 17:14:59 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <lmb@isovalent.com>
CC:     <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
        <martin.lau@kernel.org>, <martin.lau@linux.dev>,
        <memxor@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH bpf-next] net: Fix slab-out-of-bounds in inet[6]_steal_sock
Date:   Wed, 9 Aug 2023 10:14:51 -0700
Message-ID: <20230809171451.78725-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAN+4W8h44UdLRT+QLdh2rNeiKg0AkPAuGtYuXOgtFzvT2kHsWg@mail.gmail.com>
References: <CAN+4W8h44UdLRT+QLdh2rNeiKg0AkPAuGtYuXOgtFzvT2kHsWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.106.100.32]
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 9 Aug 2023 17:55:02 +0100
> On Wed, Aug 9, 2023 at 4:56 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > > Things we could do if necessary:
> > > 1. Reset the flag in inet_csk_clone_lock like we do for SOCK_RCU_FREE
> >
> > I think we can't do this as sk_reuseport is inherited to twsk and used
> > in inet_bind_conflict().
> 
> Ok, so what kind of state does reuseport carry in the various states then?
> 
> TCP_LISTEN: sk_reuseport && sk_reuseport_cb
> TCP_ESTABLISHED: sk_reuseport && !sk_reuseport_cb
> TCP_TIME_WAIT: sk_reuseport && !sk_reuseport_cb
> 
> Where is sk_reuseport_cb cleared? On clone? Or not at all?

sk_clone_lock() does when cloning sk from listener, and we
cannot check sk_reuseport_cb for twsk as it doesn't have the
member.


> 
> > > 2. Duplicate the cb check into inet[6]_steal_sock
> >
> > or 3. Add sk_fullsock() test ?
> 
> I guess this would be in addition to the convoluted series of checks
> I've removed in this patch?

Yes.
