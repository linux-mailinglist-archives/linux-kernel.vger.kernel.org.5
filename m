Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE757DCAD1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjJaKaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjJaKaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:30:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21C310D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:29:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BF2C433C8;
        Tue, 31 Oct 2023 10:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698748198;
        bh=2ve8baLNLJx1j/DE/18O2xVsUvR0jKzzYfVZElQOVg8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fC2f98N9B/E/C5ZWiobhoexBLUU/nOZA6/4Fwumqon44CfQeKTplbvPOSpsWcGXE5
         j6GKWNzd/yIucMGlkfpo3fHNpjX0FSlVVGF9JA1XJfH7dxa1npm7dICwOCHf9eeLZ/
         IxPcK1GeDsRUEg+R/d7Ko9Hl58/zQ/pHzb4/Kix5F04XpDe27nKf0l7XsaJNgunvaP
         fm22n78oLz2ZZ3CoXokOsFiSKMY9F5JY2mzwyUHhngo3/ktHgpkXhV0rhit27Tbu+K
         sQxIVcs9M/Xxg2O3bb25SMtIhHs4219c/PgoR++6XcdATSmXrSC1754KK5UdKOF71j
         BZPPKLihbwtWg==
Message-ID: <c962f0be-c82d-51a8-6b74-4a61e40048b7@kernel.org>
Date:   Tue, 31 Oct 2023 18:29:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] erofs: fix erofs_insert_workgroup() lockref usage
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20231031060524.1103921-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231031060524.1103921-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/31 14:05, Gao Xiang wrote:
> As Linus pointed out [1], lockref_put_return() is fundamentally
> designed to be something that can fail.  It behaves as a fastpath-only
> thing, and the failure case needs to be handled anyway.
> 
> Actually, since the new pcluster was just allocated without being
> populated, it won't be accessed by others until it is inserted into
> XArray, so lockref helpers are actually unneeded here.
> 
> Let's just set the proper reference count on initializing.
> 
> [1] https://lore.kernel.org/r/CAHk-=whCga8BeQnJ3ZBh_Hfm9ctba_wpF444LpwRybVNMzO6Dw@mail.gmail.com
> Fixes: 7674a42f35ea ("erofs: use struct lockref to replace handcrafted approach")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
