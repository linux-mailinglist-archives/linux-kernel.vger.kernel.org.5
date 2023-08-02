Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08D976CBC1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjHBL0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbjHBLZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:25:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E3126AD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=pEzjmPZQXN77TfOBMdhvBXs5pJBqHRT9DURj0AtCKHE=; b=gH9VvqjfKQeu8GRITPA9/0Mxky
        U+DkHsrNsz99JRiY/ArRgb98cyxmV2ywjyiFEqn5FVeGkYqaG9P84dnRGx1t4mws1JZgxJQXZSDdY
        4hHq5qzVFTEzMgL0LPybLEMoI7HnmrW5g1R/LQbsdOfoSRHdTZYkWy/gXEMRreFL0KEKCXvZ0Bu4R
        cJ5zDtoz2jpk17k6bQ/Ho/SZqc6FXAvsR6CPeVTdD0MSqnD5lQ7j+zZxDZFRi+MSoljswLlyOAlc/
        QkSlrpBfMMYmQnaBkmNVukBIJB+eeYcuF88Zvk4yb4j6FVCGgharkaV3XfxfAxDO5BRDAvRfR9t4d
        PacBCP7g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qR9yx-00FtnV-18;
        Wed, 02 Aug 2023 11:25:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9D60C300301;
        Wed,  2 Aug 2023 13:25:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7CCB421000C78; Wed,  2 Aug 2023 13:25:34 +0200 (CEST)
Message-ID: <20230802112458.230221601@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Aug 2023 13:24:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Cc:     peterz@infradead.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, rppt@kernel.org
Subject: [PATCH 0/2] nodemask: Use nr_node_ids
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While working on some NUMA code recently, I stumbled over how nodemask
operations are unconditionally using MAX_NUMNODES length, which is typically
1024 for distro configs.

OTOH typical machines only have <=4 nodes, so doing these crazy long bitmap ops
is silly.

Therefore do as cpumask does and use nr_node_ids analogous to nr_cpu_ids.

These patches are lightly tested -- as in they seem to boot on a 2 node system.


