Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FFE76CB6A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjHBLEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjHBLEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:04:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C6F1FC2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=QhJKHY1UwcsCYX6Bp7y3rQbFiLEcfTFwILtpulGs0FM=; b=jtB4Ys6MU7/v5KvSuvgU8+2sqK
        GPOpaka1DGhqa08++g8qPnHayONjlc39PjAewoivQcEx6s5rPWJC+VhVNDaKWJL4V/WrDVr4U/1O3
        giB8ILdI1/hRw9RF1ffItgSgDY4rXDuzh4d6dK+CCOO7mWy9xTRCPKjO3/SdOQ3zSd3oP1mRUtWy7
        PKJHC9R/LjgN+owJ692nkgO8mqUAULvef0Px+GSijU4Bn9okpf3AvTQa/mAW9FdcHoeYnKYV6a+/J
        1nixau/Uhm7DXeMLAzd+SOKHZMMVzFERq0vP6buDaCvequMgPDJEL9eLN5PK2z1LtQWfniboMU32r
        P8MuNEYA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qR9eE-00EaIo-Gb; Wed, 02 Aug 2023 11:04:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A24B3006E2;
        Wed,  2 Aug 2023 13:04:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id ED66321000C82; Wed,  2 Aug 2023 13:04:09 +0200 (CEST)
Message-ID: <20230802105545.594381530@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Aug 2023 12:55:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org, andrew.cooper3@citrix.com,
        David.Kaplan@amd.com
Subject: [PATCH 0/2] x86/ibt: Fix some spurious ENDBR instances
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

David was staring at assembly output and noticed a few spurious ENDBR
instructions.

