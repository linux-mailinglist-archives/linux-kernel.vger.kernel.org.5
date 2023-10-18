Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B647CE5C3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjJRSA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbjJRSAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:00:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02555D69;
        Wed, 18 Oct 2023 11:00:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F4AC433C8;
        Wed, 18 Oct 2023 18:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697652033;
        bh=fwBe8jxgE+4u2AB8YE8yDH3Vb62bVELd+j7oqk5Rn4Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GRploEu5vVGFSUtxMPZlDvYI8uwkxN8TXTL7FTK2BH7RYIJP/SbXnThNur53RqICi
         BbyvFT7Vu/7JLmlTIcwQImHqyXgm0lsQt1Hw4Q1yRHSZvWMbBthgzaigI/aiJ4zvJB
         6tXPEmAvjzNI5hR8SN3w8G+zf9S/Hm18QUcwsCEl5VEhjjIPRMUZ2y7W78Tojnksgk
         U93LqcGSiE7mPcEnr2cV40SE8BHyU/uDmFE29TTTEj84eMtRqJjPSSNk1s30NjIM5S
         xkeFN1jZ+1KudK4rUOOOEAOGlQIAttXMmjfCU890omzq4SHZBYFuYhxNeCrwbxv7n2
         oIppS4TtQ1xwg==
Date:   Wed, 18 Oct 2023 11:00:32 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net/smc: correct the reason code in
 smc_listen_find_device when fallback
Message-ID: <20231018110032.13322b8e@kernel.org>
In-Reply-To: <20231017124234.99574-3-guangguan.wang@linux.alibaba.com>
References: <20231017124234.99574-1-guangguan.wang@linux.alibaba.com>
        <20231017124234.99574-3-guangguan.wang@linux.alibaba.com>
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

On Tue, 17 Oct 2023 20:42:34 +0800 Guangguan Wang wrote:
> The ini->rc is used to store the last error happened when finding usable
> ism or rdma device in smc_listen_find_device, and is set by calling smc_
> find_device_store_rc. Once the ini->rc is assigned to an none-zero value,
> the value can not be overwritten anymore. So the ini-rc should be set to
> the error reason only when an error actually occurs.
> 
> When finding ISM/RDMA devices, device not found is not a real error, as
> not all machine have ISM/RDMA devices. Failures after device found, when
> initializing device or when initializing connection, is real errors, and
> should be store in ini->rc.
> 
> SMC_CLC_DECL_DIFFPREFIX also is not a real error, as for SMC-RV2, it is
> not require same prefix.

If it's important enough to be a fix this late in the release cycle,
it better come with a Fixes tag...
-- 
pw-bot: cr
