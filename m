Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3204C7C4106
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjJJUTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJJUTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:19:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572CA93
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:19:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AC5C433C8;
        Tue, 10 Oct 2023 20:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696969155;
        bh=gfo9pncGhCc3KfWVYgKiKfPohTYEVL0puV5Yd+N8vBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPQRw7dMtDQ2hRCCCsb/nH816uSmuvFfYs4hKEY9J19XErOXvG1R0zT7ulViGPcwo
         xZ8hBgmARiHpMPjmOIQYvWBQPXAz5nrAaSkq/zDV8uFvB5O6O1t0uDsoO31HTInuWQ
         h6CkWOnw5WhIA3fJyTLvuYKJMS98K26PTCnjH63FqtjJ1GsmLuZoLEWyNqkw2zKAuw
         kLoD6SD1dlETneWlXozmxCGjgMkyujuiasTufBZ2Dr0YfXWCn/+2lLwoJfbIMZUj4e
         DBniQAB5ulUdnLxzIDG4qigHHDD4rroJ+EYCfvjX6jNgR9c8Gcirn1F0NolHLQZfqs
         o5pTY9eFHPQgg==
Date:   Tue, 10 Oct 2023 13:19:12 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Kaplan <david.kaplan@amd.com>, x86@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "x86/retpoline: Remove
 .text..__x86.return_thunk section"
Message-ID: <20231010201912.7pjksbparssqu34k@treble>
References: <20231010171020.462211-1-david.kaplan@amd.com>
 <20231010171020.462211-2-david.kaplan@amd.com>
 <20231010174833.GG14330@noisy.programming.kicks-ass.net>
 <20231010195721.p5pb273kevg7ydxz@treble>
 <20231010200429.GIZSWuTWSUM9aId7a6@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231010200429.GIZSWuTWSUM9aId7a6@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:04:29PM +0200, Borislav Petkov wrote:
> On Tue, Oct 10, 2023 at 12:57:21PM -0700, Josh Poimboeuf wrote:
> > Also we could make objtool properly detect the non-relocated jump
> > target.
> 
> I was wondering about that... I guess it can compute the JMP target and
> compare it to the address of __x86_return_thunk?

Fine, you twisted my arm ;-)

This seems to do the trick.  Lemme write up a proper patch.

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e308d1ba664e..6cbc9812a36e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1610,6 +1610,11 @@ static int add_jump_destinations(struct objtool_file *file)
 			return -1;
 		}
 
+		if (jump_dest->sym && jump_dest->sym->return_thunk) {
+			add_return_call(file, insn, true);
+			continue;
+		}
+
 		/*
 		 * Cross-function jump.
 		 */
