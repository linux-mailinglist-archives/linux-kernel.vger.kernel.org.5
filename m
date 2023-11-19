Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317EE7F0458
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 05:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjKSEWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 23:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjKSEWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 23:22:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128DFA8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 20:22:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EE1C433C7;
        Sun, 19 Nov 2023 04:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700367728;
        bh=46ZpEAegBzDsGRG/6xeHo6oLyXNnMQAtkVXlHiBHSKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qp4YyRG++RoMvkw8/Co9B0TbaVvIzlXjc3rhJ7zj2V6SeqSThtmiNz10FM4OQPHmF
         1ffEwiVWo2ZabFMcNiLDXu1xWS/QiQ4W5oj30/BV3umwtYvoutGpsgoKvUTsuHZmRM
         PDryk4UxdFSTFT2DlE3w6N+8g/N09ceNKi8DzUllEPrpaNLKKep9yCtDJbRpQ9X8Q6
         5+scIoXIgk1snDpd8MzQl/6Usen3OjXvyzs435HLO4wilfecd+j1dNYlhrKN81U2gE
         A14IIhMGaek8Zj5bNgqX2ny3iN0DZwUJm6LRzBe2ooqvdAGZzvcEyVkbKRlw9+X00J
         516riIEo9LD5g==
Date:   Sat, 18 Nov 2023 20:22:07 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Louis Peens <louis.peens@corigine.com>
Cc:     Denis Arefev <arefev@swemel.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, oss-drivers@corigine.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] nfp: flower: Added pointer check and continue.
Message-ID: <20231118202207.16a60834@kernel.org>
In-Reply-To: <ZVd4RYURdHLL+F2h@LouisNoVo>
References: <20231117125701.58927-1-arefev@swemel.ru>
        <ZVd4RYURdHLL+F2h@LouisNoVo>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 16:27:17 +0200 Louis Peens wrote:
> >                 acti_netdevs = kmalloc_array(entry->slave_cnt,
> >                                              sizeof(*acti_netdevs), GFP_KERNEL);
> > 

Unnecessary new line, please remove it.
There should be no empty lines between call and error check.

> > +               if (!acti_netdevs) {
> > +                       schedule_delayed_work(&lag->work, NFP_FL_LAG_DELAY);
> > +                       continue;
> > +               }
> > +  
> Thanks for reporting this Denis, it definitely seems to be an oversight.
> Would you mind adding a 'nfp_flower_cmsg_warn' here as well, so that
> this case does not go undetected? Maybe something like "cannot
> allocate memory for group processing" can work.

There's a checkpatch check against printing warnings on allocation
failures. Kernel will complain loudly on OOM, anyway, there's no need
for a local print.
-- 
pw-bot: cr
