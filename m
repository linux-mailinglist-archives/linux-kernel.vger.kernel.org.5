Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FB3757FBB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjGROhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGROhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:37:16 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 465E1113;
        Tue, 18 Jul 2023 07:37:14 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 20E5E92009C; Tue, 18 Jul 2023 16:37:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 1AFCA92009B;
        Tue, 18 Jul 2023 15:37:13 +0100 (BST)
Date:   Tue, 18 Jul 2023 15:37:13 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Jan-Benedict Glaw <jbglaw@lug-owl.de>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] MIPS: Fix build issues from the introduction of
 `need-compiler'
Message-ID: <alpine.DEB.2.21.2307180025120.62448@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HDRS_LCASE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 With the addition of the `need-compiler' variable the `Makefile.compiler' 
fragment is not included with no-build targets such as `modules_install', 
which in turn means $(call cc-option,), etc. are no-ops with these targets 
and any attempt to evaluate these function calls causes all kinds of weird 
behaviour to happen.

 The solution is to avoid making these calls in the first place, as they 
are surely irrelevant where the compiler is not going to be otherwise 
invoked.  This small patch series fixes two places known-affected in the 
MIPS Makefile fragment and also included a follow-up revert of an earlier 
misguided attempt.  See individual change descriptions for details.

 Verified with `decstation_64_defconfig' and `fuloong2e_defconfig' using 
`modules_install'.  Please apply.

  Maciej
