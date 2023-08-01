Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1695376BE4D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjHAULv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHAULt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:11:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2629BE71
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:11:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3EEA616CC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 20:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9528C433C7;
        Tue,  1 Aug 2023 20:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690920708;
        bh=0gCBbS6tj9vwj7Q7yqVIWg0y6AxgBA6QkVD5cPt2Tag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q0P0AhH2PjRdCup+bz0QUvVga1KT6jxrbjnHmehAHcEAecETIY8mkdLDiLh4attCI
         f9MB6WbvBXVtrN9yNnSjVcRxvXzJ8qX5nn9JliUSjkWTd4qwP5OAIHJLgZvVJqs5b1
         6T0MXKzIV3sluCzHzpvLg1phbBgIEoU64tCRBH85OSqn/GRtZFYltvXqb0nptLgs1Y
         0gsg6150EML3ukOwdel8kE768dD3xNyan8C/5trWJhXWeE1X8ZXo5AsjqPFPvtMHtT
         mm51mQGwvuw/HsXP709M4K1j9RZM/bZEzYLqcLSJAYE71vveQeejwaSAKJ2GYPvhf9
         cY422eqtPAdEg==
Date:   Tue, 1 Aug 2023 13:11:46 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
        dsahern@kernel.org, pabeni@redhat.com, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        simon.horman@corigine.com
Subject: Re: [PATCH v3] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
Message-ID: <20230801131146.51a9aaf3@kernel.org>
In-Reply-To: <CANn89iJO44CiUjftDZHEjOCy5Q3-PDB12uWTkrbA5JJNXMoeDA@mail.gmail.com>
References: <20230801064318.34408-1-yuehaibing@huawei.com>
        <CANn89iJO44CiUjftDZHEjOCy5Q3-PDB12uWTkrbA5JJNXMoeDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 09:51:29 +0200 Eric Dumazet wrote:
> > -               skb_push(skb, -skb_network_offset(pkt));
> > +               __skb_pull(skb, skb_network_offset(pkt));
> >
> >                 skb_push(skb, sizeof(*msg));
> >                 skb_reset_transport_header(skb);  
> 
> Presumably this code has never been tested :/

Could have been tested on 32bit, I wonder if there is more such bugs :S
