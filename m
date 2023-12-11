Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC3380CF06
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343989AbjLKPEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbjLKPE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:04:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCD8DB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:04:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E1CC433CB;
        Mon, 11 Dec 2023 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702307075;
        bh=1YrRT7IzA4Ihuwv6ehGHUYg8NSaZHj7uaeGlSMs+Ub0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZRjQEhbzmyMbkfryspKnxuwSVtvo317UrIoOzgcbKCrJYco0b3x2mhw52Ejiw5WhZ
         IDI9OGDUimIe13n2pvl8LOttmxdTXPDD9U817zSVzKf86totJFc9+XpwuQT5Jf4R/D
         jXrqmMwSM8xmL+nHD5H8suRERegClAE7X8u+WimS8bG6MfQAoN1argRVAbN0EGFZ9Q
         1+bXP1Q04E9p1geo8w2YmcwjXPZTGimvBsLo0C9jKYIF+kWGAEV3xF8JU/cCS6iKbf
         PQYu5erNWE4uVqhJu/Aw4re9G1Mq1rbC5DhPXQirMnneblycesdh67vrBRInR7Ttxw
         pwYELzUkOm6Mw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231124160235.2459326-1-amelie.delaunay@foss.st.com>
References: <20231124160235.2459326-1-amelie.delaunay@foss.st.com>
Subject: Re: [PATCH] dmaengine: dmatest: prevent using swiotlb buffer with
 nobounce parameter
Message-Id: <170230707383.319997.16133040652159955271.b4-ty@kernel.org>
Date:   Mon, 11 Dec 2023 20:34:33 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Nov 2023 17:02:35 +0100, Amelie Delaunay wrote:
> Source and destination data buffers are allocated with GPF_KERNEL flag.
> It means that, if the DDR is more than 2GB, buffers can be allocated above
> the 32-bit addressable space. In this case, and if the dma controller is
> only 32-bit compatible, swiotlb bounce buffer, located in the 32-bit
> addressable space, is used and introduces a memcpy.
> 
> To prevent this extra memcpy, due to swiotlb bounce buffer use because
> source or destination data buffer is allocated above the 32-bit addressable
> space, force source and destination data buffers allocation with GPF_DMA
> instead, when nobounce parameter is true.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: dmatest: prevent using swiotlb buffer with nobounce parameter
      commit: 70f008fb3ea9bd2e6727eebc858405acd49a212b

Best regards,
-- 
~Vinod


