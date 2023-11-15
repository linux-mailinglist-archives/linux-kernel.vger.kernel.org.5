Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F84C7ED570
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345011AbjKOVF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbjKOVFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:05:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5E91BFF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700082323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TILtTIeu3gXnUdrdAENWa1V+qtf2djaxseto/GpIGiU=;
        b=LJzD51DFRJEUxMRRx0Ed/letfIyQuyDy/MFmupEIRIAlvbN7xX2K2SX+usOlq52yFa7LWw
        Hox4D0GFwc4uOT4if01DCuSbV5zv7hUMOLUSPT27IV/wYWMk17iahmNosWH2ysP9cVtIwR
        P9qdiF/1CPS2Rr/lUPAl+qJDAgCBpLQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-F0EMJrXzPk-lvIhyom_TEw-1; Wed, 15 Nov 2023 16:05:19 -0500
X-MC-Unique: F0EMJrXzPk-lvIhyom_TEw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0074382A62C;
        Wed, 15 Nov 2023 21:05:19 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.22.34.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 232ED3D6;
        Wed, 15 Nov 2023 21:05:18 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tomas Glozar <tglozar@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 0/2] tcp/dcpp: tw_timer tweaks for nohz_full and PREEMPT_RT
Date:   Wed, 15 Nov 2023 16:05:07 -0500
Message-ID: <20231115210509.481514-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v2 of [1] where the tw_timer is un-pinned to get rid of interferences in
isolated CPUs setups.

Patch 1 is pretty much the same as v1, just got an extra comment in
inet_twsk_deschedule_put() to highlight the race.

Patch 2 was added as AFAICT the bh_disable is no longer needed after patch 1,
and Sebastian mentioned during LPC the he had been looking at getting rid of it
for removing softirq_ctrl.lock in PREEMPT_RT.

Eric mentionned rsk_timer needs looking into, but I haven't had the time to do
that. It doesn't show up in our testing, which might be due to its relatively
low timeout (IIUC 3s).

[1]: https://lore.kernel.org/all/20231016125934.1970789-1-vschneid@redhat.com/

Valentin Schneider (2):
  tcp/dcpp: Un-pin tw_timer
  tcp/dcpp: Don't disable bh around timewait_sock initialization

 net/dccp/minisocks.c          | 14 ++++----------
 net/ipv4/inet_timewait_sock.c | 20 +++++++++++++++-----
 net/ipv4/tcp_minisocks.c      | 14 ++++----------
 3 files changed, 23 insertions(+), 25 deletions(-)

--
2.41.0

