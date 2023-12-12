Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C8B80F570
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjLLSXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjLLSXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:23:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FBBA7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:23:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A32C433C7;
        Tue, 12 Dec 2023 18:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702405385;
        bh=uCBGOxwQmDbDUaJRetPxqIoUG3iao+4boB61ae9MrbY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AfccAbTlLY/jvEOi2N3unL2x/pV+T1rSEVJ4T6n2pRgpiY5eGQumcMvCDwWNSVv2P
         pO4ql3SyGZJ/ePLK18FplKmsohGHYOJbmDsU6I0KipvWwKs6wyGeemL+OydqurP2DI
         3F+6meNb4zJe7R2j+dJkU5jp7OaMEcZuMxGrrf4fX1vclAMc66IYUbhE1YLjsRVRDc
         LHjiJvGQtBxcc771Lr+wzfsXxgoTTpLIX53YsmF3RPhR05YhTC+P5T4NBkFIy8zBKS
         RWyW4277N+QLgXAz064reLVML7WZQYlCxe0mXBg5PhckOX5h+G39VvznYK80HVy9+V
         SLpWU7yXmB2CA==
Date:   Tue, 12 Dec 2023 10:23:04 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     3chas3@gmail.com, davem@davemloft.net, horms@kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] atm: solos-pci: Fix potential deadlock on
 &cli_queue_lock
Message-ID: <20231212102304.4f37c828@kernel.org>
In-Reply-To: <20231207123437.42669-1-dg573847474@gmail.com>
References: <20231207123437.42669-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Dec 2023 12:34:37 +0000 Chengfeng Ye wrote:
> As &card->cli_queue_lock is acquired under softirq context along the
> following call chain from solos_bh(), other acquisition of the same
> lock inside process context should disable at least bh to avoid double
> lock.

These appear to have been applied to net, thanks!
