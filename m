Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A689782961
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjHUMq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjHUMq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:46:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D94CC;
        Mon, 21 Aug 2023 05:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 648AD617D0;
        Mon, 21 Aug 2023 12:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F354C433CA;
        Mon, 21 Aug 2023 12:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692622013;
        bh=+Yots/ZUEXx/2bhWHowrLNBGaKBrF1BoAbF97vzelD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MhzivBHTNiTBRH4EnhhtoQbWX+tHI1NakpwTlZ9ymg2YRGVI/jTPjytuEiCdMqQem
         je8yssRw0yX/vz7VzE/UxH+0KSeH0CN2EY8pYVYxoLQ2WHJ5ouJCcfpusRolSFqksF
         bl029xBiHvmzQE60AmPHG2ykWiGpFrlolkwYO2SLljsO6vhjWU1UqPApux4oiGSApv
         gS9UOYPgbAZHdsd4qOhXVVpksNtGIHQzNBuIpxI88jdXV0LXvaMUNiCF3iXMUNhMIE
         M9WV90PD7ncEFCojARkXVmvQBtsoCfr/NvcKwF5p7Hk6NF+aOmESWzF3ptmbc90R6N
         tZgJX9jxb4B4w==
Date:   Mon, 21 Aug 2023 13:46:49 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Sebastian Reichel <sre@kernel.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the battery tree
Message-ID: <20230821124649.GN1380343@google.com>
References: <20230821125741.3a2474d7@canb.auug.org.au>
 <20230821070731.GB1380343@google.com>
 <20230821071331.GC1380343@google.com>
 <CAL_JsqJbi-780UdoOizx3fMOv+W9WcvNqQt+0fUYwMQAet6BUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJbi-780UdoOizx3fMOv+W9WcvNqQt+0fUYwMQAet6BUA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023, Rob Herring wrote:

> On Mon, Aug 21, 2023 at 2:13 AM Lee Jones <lee@kernel.org> wrote:
> >
> > On Mon, 21 Aug 2023, Lee Jones wrote:
> >
> > > On Mon, 21 Aug 2023, Stephen Rothwell wrote:
> > >
> > > > Hi all,
> > > >
> > > > After merging the battery tree, today's linux-next build (x86_64
> > > > allmodconfig) failed like this:
> > > >
> > > > drivers/power/supply/rt5033_charger.c: In function 'rt5033_charger_probe':
> > > > drivers/power/supply/rt5033_charger.c:694:19: error: implicit declaration of function 'of_parse_phandle' [-Werror=implicit-function-declaration]
> > >
> > > Is this because your merge-conflict patch:
> > >
> > >   linux-next: manual merge of the battery tree with the mfd tree
> > >
> > >  ... removed of_device.h?
> >
> > Oh, that was Rob's patch.  I see now, thanks.
> 
> Presumably the functions below got added and failed to add of.h and
> instead relied on of_device.h's implicit include of of.h which is
> going to get removed. So Stephen's fix is the correct one.

Super.

Stephen, would you mind submitting it in a format we can apply?

-- 
Lee Jones [李琼斯]
