Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B38976FE84
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjHDKbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjHDKa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:30:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFCA2118
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:30:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99D4C61F91
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50467C433C8;
        Fri,  4 Aug 2023 10:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691145057;
        bh=LisFYqrHrFx436SkEAziF8A92P7uY+qSA0OgMAPh/Bk=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=HlF/5mCQOEUrJx14dljhhBCHpirfYCLy6M1w9mj7gncmtLrJMYh0vwf244TKRZ/Gq
         zg6N/uEGVqdVBMSk0A/GsF+n8MlwudcVTwpvddOyOTUSeObVPquDd7cA5Q2QMuocoU
         Ly1J9cw/xJkm9wQGDkl5yTC6FsXOC4AD1CY91C7LE8/dYn9/+hpygf0tAUEDSfqfQg
         ozBRkyYXD4xPyCAIgaVHojJ+NyZ9QJwvnVgScvDp+L1cNo0d5T8WbWDQtUANXxzDuH
         qkMp/zBzq5KMl2puFlB//tIEVKF+C2bkIMsd11AeN43zF312M32FHnu7RHeHQI06hN
         z5fVyS/iZQ0Cg==
Message-ID: <e9196324-e228-d160-4c8f-ae45b4773633@kernel.org>
Date:   Fri, 4 Aug 2023 12:30:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/6] page_pool: add a lockdep check for
 recycling in hardirq
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230803182038.2646541-1-aleksander.lobakin@intel.com>
 <20230803182038.2646541-6-aleksander.lobakin@intel.com>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230803182038.2646541-6-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/08/2023 20.20, Alexander Lobakin wrote:
> From: Jakub Kicinski<kuba@kernel.org>
> 
> Page pool use in hardirq is prohibited, add debug checks
> to catch misuses. IIRC we previously discussed using
> DEBUG_NET_WARN_ON_ONCE() for this, but there were concerns
> that people will have DEBUG_NET enabled in perf testing.
> I don't think anyone enables lockdep in perf testing,
> so use lockdep to avoid pushback and arguing :)
> 
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> Signed-off-by: Alexander Lobakin<aleksander.lobakin@intel.com>

I like this.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
