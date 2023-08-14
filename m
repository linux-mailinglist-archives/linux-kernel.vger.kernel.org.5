Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACD577B889
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjHNMUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjHNMTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:19:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8736B183
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=UPLaEzNE8Ub4tdTij9UMa81BMLeus6lxHe2rDMIHscM=; b=VSzU9J9UpjTc7Oc+POVy3Bkvac
        OGJW1CEHefckCLqw23P3rS0Q3De6biBn45Pv+lVkW4cDx8Wdn3j8nTgoRulvi7c6MyS+e+PXDw0IY
        lNPtgBhtedNdH5GFEruSsUONEEl2U5EZLIeZMltaLQB4LW196tGCFcEzMDKEuMJYjUofQe7QNVQ9x
        hCWFqW5O4tIQs8PV8DLht0PPzEq2TtpuaBDDNxXxONLmG0XgDYT9bk6WlzrTGbTRLsVmIeUyPpiiX
        igl5qqcH6evqoIc4TQrrkGh9hoyHrJSq+mKB9JFAcsSfEUrU+F5nEvfvFC250XBdJFTSMbfjpiWSa
        GoM9sUyA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVWXY-001t44-Ae; Mon, 14 Aug 2023 12:19:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C6F00300137;
        Mon, 14 Aug 2023 14:19:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id ABADA20410DA1; Mon, 14 Aug 2023 14:19:19 +0200 (CEST)
Message-ID: <20230814114426.057251214@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 14 Aug 2023 13:44:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org,
        nik.borisov@suse.com
Subject: [PATCH v2 00/11] Fix up SRSO stuff
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Second version of the SRSO fixes/cleanup.

I've redone some, reorderd most and left out the interface bits entirely for
now. Although I do strongly feel the extra interface is superfluous (and ugly).

This is based on top of current tip/x86/urgent 833fd800bf56.

The one open techinical issue I have with the mitigation is the alignment of
the RET inside srso_safe_ret(). The details given for retbleed stated that RET
should be on a 64byte boundary, which is not the case here.

I'll go prod at bringing the rest of the patches forward after I stare at some
other email.

