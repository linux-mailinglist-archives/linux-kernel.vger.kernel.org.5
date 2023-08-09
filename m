Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A47E775406
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjHIH04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHIH0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:26:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E3B1BFE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=nVCebUMp5VJ4qmM0n50gD2UNTfBIogwVkY7lfsytXS0=; b=PwB+XY4HX6fRQiPoC7b/rX9dgK
        I+QUuEV1BoIYhUE98qg78VHoGIJPYWkk5PbLqjMR6bEbSHr+LvssMMVI76KMUTppiP1ESjsogvmRa
        96XY++nP3ujUhmQJla/YbnzInxCTOg6hMNiK3JHVp1qpH7F32Rj2SVhnPWMF1FWwfNMubsWqtjVGD
        zMt4BAy+LK0E5zrT84OeDCfuob7VvCEiA95CQRoJ7j7Qy2r3P1xKneGbngoXbgwaAFVz8pykc4HWv
        2jjNlc8x0popzMqiojcaKmVqcerzJE6e5sHMPyzXN927iSEFBVjUq2gIeoVNEHhHjY7E4m+dIljVM
        HKKyUyhQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTdae-004olN-T8; Wed, 09 Aug 2023 07:26:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 632C2300487;
        Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 490F52C86567A; Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Message-ID: <20230809072200.646688083@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 09:12:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: [RFC][PATCH 03/17] x86/cpu: Make srso_untrain_ret consistent
References: <20230809071218.000335006@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This does change srso_untrain_ret a little to be more consistent with
srso_alias_untrain_ret (and zen_untrain_ret). Specifically I made
srso_untrain_ret tail-call the srso_return_thunk, instead of doing the
call directly. This matches how srso_alias_untrain_ret amd
zen_untrain_ret also tail-call their respective return_thunk.

If this is a problem this can be easily fixed and a comment added to
explain -- but this way they all end with a tail-call to their own
return-thunk, which is nice and consistent.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/retpoline.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -262,7 +262,7 @@ SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLO
 	int3
 	/* end of movabs */
 	lfence
-	call srso_safe_ret
+	jmp srso_return_thunk
 	int3
 SYM_CODE_END(srso_safe_ret)
 SYM_FUNC_END(srso_untrain_ret)


