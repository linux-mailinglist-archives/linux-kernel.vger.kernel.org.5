Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4EC7BA624
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbjJEQ2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244130AbjJEQ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:26:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1787F1709
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:21:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28B8C433C9;
        Thu,  5 Oct 2023 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696522907;
        bh=vVI8ELd2bANGUqh/pj5lOKnspn0ZKfxuLxlqRTq3km0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V2hqIjnc2FRu4Q4idwN+YjRvKFcC97MMcraMtaMDZf3lvHIRCJjYn0wnCQZ+bnVVz
         V4DMWSj18apzV2yEMRX+NVOAvtpIqohsBSNClYUJRYqSpxgb5QSiMT9xt+WxjGW4M1
         8giFd9Gz5cuOxDBGHoNDidTSienNMLgoYDWiYuSmdzfFhc9JZPTJgV8pw2v8s3im1e
         h1EDzp9LOdXueKHmxo6I+gyGLHBUNLa/JJUhphxZPLmeP8lGDYHKXl0lP3efp4/aSS
         uceFuTUPqW944M/fj4E1sK9kdcmyTwI7C/6To2vK+zzBJ7Vujs6WKx9gklogyhSkmH
         TccYTOwWomhdg==
Date:   Thu, 5 Oct 2023 09:21:45 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>, <hawk@kernel.org>,
        <alexander.duyck@gmail.com>, <ilias.apalodimas@linaro.org>,
        <linyunsheng@huawei.com>, <bigeasy@linutronix.de>
Subject: Re: [PATCH net v1] octeontx2-pf: Fix page pool frag allocation
 failure.
Message-ID: <20231005092145.08cc84fb@kernel.org>
In-Reply-To: <20231005021434.3427404-1-rkannoth@marvell.com>
References: <20231005021434.3427404-1-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2023 07:44:34 +0530 Ratheesh Kannoth wrote:
> +	sz = PAGE_ALIGN(ALIGN(SKB_DATA_ALIGN(buf_size), OTX2_ALIGN));
> +	pp_params.order = get_order(sz);

Surely get_order() rounds up by itself otherwise all callers would
have to do the PAGE_ALIGN()...
-- 
pw-bot: cr
