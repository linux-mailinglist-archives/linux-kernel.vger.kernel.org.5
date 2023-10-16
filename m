Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363917CA6B6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjJPL20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjJPL2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:28:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8979C8E;
        Mon, 16 Oct 2023 04:28:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B521C433C8;
        Mon, 16 Oct 2023 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697455704;
        bh=A5cUwPAsu3oksXhFl3oa+u3vGrczDMCN23UrhSj9K+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANdei5ZgS5hh8GiV0Sn5KlfXvQDndrXD/HZQbhlKSCnodHzXM8r3BePaCcWUxAk8j
         AkzqA4kBLR77RPdnbcHLRgZPWIgGbtKYqoJ1T6lvLo0qCIvg+o/b/CkAyrlum4RU4f
         MyTNz3xH0YZc5Wy0a4tynECi5TpEOqxp1T7w2mCSi8e3A6PfNwGvmWMuDudc6c8nkH
         xRhahEnAp+PfH5XJsu2wY7pn3Fuj1wkVLcWMFV9/3JflkkbS01kcEFG3F/NzEh6H9R
         I1wivZbLz178pKipPjrPmJHN5mEHhIuYGO2/O9OUZojMIniW9kAu0FBM0L5xsgRDAZ
         EdALH4UXHkxWA==
Date:   Mon, 16 Oct 2023 13:28:19 +0200
From:   Simon Horman <horms@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Frederic Danis <frederic.danis@linux.intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?6buE5oCd6IGq?= <huangsicong@iie.ac.cn>,
        stable@vger.kernel.org
Subject: Re: [PATCH net-next] nfc: nci: fix possible NULL pointer dereference
 in send_acknowledge()
Message-ID: <20231016112819.GL1501712@kernel.org>
References: <20231013184129.18738-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231013184129.18738-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 08:41:29PM +0200, Krzysztof Kozlowski wrote:
> Handle memory allocation failure from nci_skb_alloc() (calling
> alloc_skb()) to avoid possible NULL pointer dereference.
> 
> Reported-by: 黄思聪 <huangsicong@iie.ac.cn>
> Fixes: 391d8a2da787 ("NFC: Add NCI over SPI receive")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks,

I agree that nci_skb_alloc() may turn NULL and that this
is an appropriate way to handle that.

As an aside, I observe that the return value of send_acknowledge()
is not checked. But I don't think that affects the correctness of this
change.

Reviewed-by: Simon Horman <horms@kernel.org>
