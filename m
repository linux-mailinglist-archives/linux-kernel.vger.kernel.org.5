Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245767622BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjGYT4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGYT4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB4119A1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:56:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EA6661883
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFB4C433C7;
        Tue, 25 Jul 2023 19:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690314963;
        bh=GiXQu/nD8DNTAps01d2gInzs5Y3/qwmhEDn60fHTXNc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V2y6Y1HJ2urzh7TOYLE5dX/DhXm07qPkuUdUmM9FSyxBGbCikHDt7bKkVl1f4ictT
         jsfMI1oiafgXo3vqvhAmrWGzOpShV20VY8ImYhGtW2Mrzx/eHpj0Bx15JIPvzsH6Hr
         AyJXL9YDzBa1haqs/6/IVjlYz1XAvBRMh/dbje22tBMFnWPZkxF29wSnamY4p3eHQy
         qkqyclynQ8VFIbFZ/7n5lTOtHHMbHTR1jIevefLhtKdsgQ8FDf9RCcxeCvTUkd/rjU
         jsLw39GdxVXXh6Dm8ZxoagaoxwOgM0QkbTbdHJ70qhnl0V9YunOICB46M9DcBQiOb9
         otVlAUiij8ckg==
Date:   Tue, 25 Jul 2023 12:56:01 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Lin Ma <linma@zju.edu.cn>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/sched: mqprio: Add length check for
 TCA_MQPRIO_{MAX/MIN}_RATE64
Message-ID: <20230725125601.7ec04aa5@kernel.org>
In-Reply-To: <4ce3c7a980be3ce9012ba02a5d9d4285cdf4fd07.camel@perches.com>
References: <20230724014625.4087030-1-linma@zju.edu.cn>
        <20230724160214.424573ac@kernel.org>
        <63d69a72.e2656.1898a66ca22.Coremail.linma@zju.edu.cn>
        <20230724175612.0649ef67@kernel.org>
        <d02a90c5ca1475c27e06d3d592bac89ab17b37ea.camel@perches.com>
        <20230725123842.546045f1@kernel.org>
        <4ce3c7a980be3ce9012ba02a5d9d4285cdf4fd07.camel@perches.com>
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

On Tue, 25 Jul 2023 12:50:00 -0700 Joe Perches wrote:
> > > What do you think the "case" is here?
> > > 
> > > Do you think John Fastabend, who hasn't touched the file in 7+ years
> > > should be cc'd?  Why?  
> > 
> > Nope. The author of the patch under Fixes.  
> 
> It adds that already since 2019.

Which is awesome! But for that to work you have to run get_maintainer
on the patchfile not the file paths. Lin Ma used:

  # ./scripts/get_maintainer.pl net/sched/sch_mqprio.c

That's what I keep complaining about. People run get_maintainer on
paths and miss out on all the get_maintainer features which need 
to see the commit message.
