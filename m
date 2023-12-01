Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AC880046E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377705AbjLAHIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjLAHIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:08:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219FDF2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:08:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4141FC433C8;
        Fri,  1 Dec 2023 07:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701414493;
        bh=kkDlSi8LK9wnO0BxtoNklTwo0Po3lzBpozTfDh5KYnQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DcvyVC/azyDijmRL8how/2ktMXVEwKIFt5n4L6TFDZ9/YbVs6t4DBQJGb3xWXQNw7
         CThYeS4obQ4V9I/mInL+2uX5bMRuYkx1C7EXpUoQjE5zAtYb96Wu6svE1ppqEayKOK
         kH+frqVB83WDfjMVmYTBQNs/I6VCXLdIP0I7dagdGgNMI01jHBUT4dzH3uQ04Aoepz
         n0jYCcIWo0WdcN3ZnK/8NM7yCBX0LcKDOCd941LyLvKpELhfV5R3VmGFBZLLOrIaU+
         LbI1B6Y3cByx5dO/oKqPn2iRH921YFJOnqF0QMeDde6/4n3skcm9FvT/OIFJT53KlL
         ZMxfwsEVqJa0A==
Date:   Thu, 30 Nov 2023 23:08:12 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Bert Karwatzki <spasswolf@web.de>
Cc:     almasrymina@google.com, edumazet@google.com, hawk@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: page_pool: Fix NULL pointer dereference in
 page_pool_unlist()
Message-ID: <20231130230812.16461d0f@kernel.org>
In-Reply-To: <20231130192542.4503-1-spasswolf@web.de>
References: <20231130192542.4503-1-spasswolf@web.de>
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

On Thu, 30 Nov 2023 20:25:42 +0100 Bert Karwatzki wrote:
> When the the hlist_node pool->user.list is in an in an unhashed state,
> calling hlist_del() leads to a NULL pointer dereference. This happens
> e. g. when rmmod'ing the mt7921e (mediatek wifi driver) kernel module.
> An additional check fixes the issue.
> 
> Fixes: 083772c9f972dc ("net: page_pool: record pools per netdev")
> 
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>

Thanks for the patch, we got a couple of similar submissions,
and merged the first one to be posted.. should be fixed in net-next now.
-- 
pw-bot: na
