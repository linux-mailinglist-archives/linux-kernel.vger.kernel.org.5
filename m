Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D9377CDE4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbjHOOQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbjHOOPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:15:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB00199A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:15:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D66F061693
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFD7C433C7;
        Tue, 15 Aug 2023 14:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692108944;
        bh=Pvw0knH5aK1JT76Gogw5tdklLV3FIclvxoJl43eExcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HvklSn5g0JGJd5ghvIpMvQuV6qnVfCz3qsGVAi+1A4rAE6xlGgw5yHuqiKwTKI84v
         Nhg+POoqt+u9pWOPVFtKcgc0v8Kk6aU9w2FW5fogV7q4fV/eRPkB/SLnKrWpxh1ufd
         knLpxqm8LtSFVn+ejy1lJKTzkHTlyfbrNVyKKiOad3eFTMZVz6bOSTLeXhE20K3Bq2
         V5mIRvBq7/QiOD7kWtq7DYwXpIwa4ZdnTtJ4y0BRb7jniiQiTFtasPXL2hG4ohqBg5
         IWszMUGsiVF0YdlqWcOJV8LfMlLAbu2bNv3ayhTo7ylUQ1uZxYeBmkGyhLbs69zyd7
         epSohgoPyeMjg==
Date:   Tue, 15 Aug 2023 07:15:41 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: rt5677: fix -Wvoid-pointer-to-enum-cast warning
Message-ID: <20230815141541.GA4129040@dev-arch.thelio-3990X>
References: <20230814-void-sound-soc-codecs-rt5677-v1-1-5c468c60fa37@google.com>
 <94c059a6-07bf-4887-8c67-b8b0724baa49@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94c059a6-07bf-4887-8c67-b8b0724baa49@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 01:54:40PM +0100, Mark Brown wrote:
> On Mon, Aug 14, 2023 at 09:58:56PM +0000, Justin Stitt wrote:
> > `match_id->data` is a void* and as such is being truncated when cast to
> > `enum rt5677_type` which is only int-width.
> 
> This doesn't apply against current code, please check and resend.

It looks like Andy fixed this warning as part of the refactoring to
device_get_match_data():

https://git.kernel.org/broonie/sound/c/043bb9c012ee7d092a477159cc66dbdf62fd2666

Cheers,
Nathan
