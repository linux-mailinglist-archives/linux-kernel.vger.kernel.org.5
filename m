Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCA67C6A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbjJLKG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbjJLKGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:06:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A66D8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:06:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30472C433C8;
        Thu, 12 Oct 2023 10:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697105182;
        bh=s/sZcf7nbHGgtGqnIcOjvr3LFAA8WfuaI+wbvCv/HyI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kZGe/FHAs9+4LTHdzHXm0+1PGY7i3nPHVD57gn6TDSc2Bb1npF2C35wRQ82wFC6m4
         7cQS8FtUVc68v7i/MR/EnMNBVHJOfb3bW5ZLNE1D3PrsSEnCFZmXaUB1/34FQ25f7B
         RzP7ryErVzHM4X7ovAsfcAlKeVNY4I9tF+a/6BvhNvc8jYH0ryJAXftTtgTnjJKZqU
         eELZXoaLMm9NIhfJy0mnyc1l3bRdW9vMs0b8/eQ3DDxXe0xECnvDSe13tTTM09Fs7G
         Fg5/qSG+nXV82eAvhnlXrU1MMKRzS4srhjnwPWmrNuwCd308hN8AYAz+SiLiVqJZuD
         TExicGO5tUv8A==
From:   Pratyush Yadav <pratyush@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Md Sadre Alam <quic_mdalam@quicinc.com>, tudor.ambarus@linaro.org,
        pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        quic_varada@quicinc.com
Subject: Re: [PATCH] mtd: spi-nor: Ensure operation completion before shutdown
In-Reply-To: <bb12db1205a5d1bfbee341d23defe0be@walle.cc> (Michael Walle's
        message of "Thu, 12 Oct 2023 11:11:09 +0200")
References: <20231012055148.2445303-1-quic_mdalam@quicinc.com>
        <bb12db1205a5d1bfbee341d23defe0be@walle.cc>
Date:   Thu, 12 Oct 2023 12:06:19 +0200
Message-ID: <mafs034ygm9yc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12 2023, Michael Walle wrote:

> Hi,
>
> Am 2023-10-12 07:51, schrieb Md Sadre Alam:
>> Ensure that there are no pending spi operation inprogress
>> when system halts.
>
> What operation might be in progress here? Did you encounter some problems?
> Please explain it in more detail in the commit message.

+1

Ideally we should never reach this function with a pending operation. I
think we should do a proper wait in the place we did the operation that
needs waiting rather than here. That would make sure operations other
than shutdown, like reads, also work properly.

-- 
Regards,
Pratyush Yadav
