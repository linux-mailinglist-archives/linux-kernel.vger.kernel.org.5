Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9251E756C30
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjGQSf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQSfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:35:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB36394
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:35:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43032611E0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 18:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB147C433C8;
        Mon, 17 Jul 2023 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618922;
        bh=Ln5G/1ffsW20fUWdvDiNE8hPwJEGikakIk5ZGTSKIFc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=hdKC6CvXBaExBx5wfgGi2V/PCYoNSL0Vu/9M9w1mGkNa08xRfxh7KL3x8JEBwqGQC
         wpYDCQqs2NLFf7U+1qzBrd81mkbWae4enm6FR2Lu0anTnwW1orPWl0OFV4qzz4Go6E
         m/jC6GFboe9yAvyeWUH6xrholoBXb01g39YySxB+U3oSnPb981op1PPVpjnb/oap+f
         AChSxq9jQbd+yvtQzzqZpRJVWCauHw2j7kuGCiX+rCyBp5GWxAECmTVHi9hIC/+yWi
         gRXYnxcR8a8i2SRezv1BIXby7MAbjsgcTaaQcemkV8bZKDzlauhe0fYXIzFLDdgb4F
         D8Gsk0y9/Io+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3EEDCCE03F1; Mon, 17 Jul 2023 11:35:22 -0700 (PDT)
Date:   Mon, 17 Jul 2023 11:35:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org, jgross@suse.com, vschneid@redhat.com,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, imran.f.khan@oracle.com,
        kernel-team@meta.com
Subject: [PATCH csd-lock] Decrease console output from CSD-lock timeouts for
 v6.6
Message-ID: <96818440-a922-4b43-8871-50358e18b523@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains a couple of patches that reduce the console output
produced by CSD-lock timeouts.

1.	Reduce logging due to dump_stack of CSD waiters, courtesy of
	Imran Khan.

2.	Reduce NMI traffic from CSD waiters to CSD destination, courtesy
	of Imran Khan.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/smp.c |    3 ++-
 kernel/smp.c   |   10 +++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)
