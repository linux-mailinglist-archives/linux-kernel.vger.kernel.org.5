Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF207F1DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjKTUHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjKTUHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:07:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097D2C7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 12:07:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FDDC433C8;
        Mon, 20 Nov 2023 20:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700510827;
        bh=qDhVmeRxMwWr07EGDhK+eYCT2EyQYeCpb9U7RNVpTcc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZwrlbX4O71gbSINgSdWtmM9Jt8g9BQ1SOH4d9uRzQuzAIa8QKrXb1gMBsLS93Rr24
         +M4eZ6XJEFiuiqjoX6CWktLduWna9Jb04nylaCAJalxbIXmw4Ptg6ktNuKcWm1MChi
         1n+OqAgi2ClBIpuyvYE2qKsGLBvZ73t8HBJs4V33c/cx1DWFz1iq4+aKFDV/irBkM9
         u/2OZSPeJda7jEnxoV7/geclz0+KqSyLRrtcUSPpukUZd2jdGdhTuUM3PWgi7EplKP
         GY2ruhmygSJPAaJThHKaYCGLi/5grW5iESxl8dpMjyd1gsdy94zZzgK44vpIGzGKBO
         FDU2ZM0U2aHdw==
Date:   Mon, 20 Nov 2023 12:07:06 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     leit@meta.com, Jonathan Corbet <corbet@lwn.net>,
        netdev@vger.kernel.org, donald.hunter@gmail.com,
        linux-doc@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Document each netlink family
Message-ID: <20231120120706.40766380@kernel.org>
In-Reply-To: <ZVu5rq1SdloY41nH@gmail.com>
References: <20231113202936.242308-1-leitao@debian.org>
        <87y1ew6n4x.fsf@meer.lwn.net>
        <20231117163939.2de33e83@kernel.org>
        <ZVu5rq1SdloY41nH@gmail.com>
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

On Mon, 20 Nov 2023 11:55:26 -0800 Breno Leitao wrote:
> I am not planning to do it, since I would like to trust Make. Let me
> know if you think this is important and I can do it also.

Makefile is good enough for me.

> +$(YNL_INDEX): $(YNL_RST_FILES)
> +       $(YNL_TOOL) -x # Generate the index
> +
> +%.rst: $(YNL_YAMLS_FILES)
> +       $(YNL_TOOL) -i $(patsubst %.rst,%.yaml, $(@F)) # generate individual rst files

IDK what @F means, can the tool take one file at a time and then
we can make the rule a more usual:

%.rst: $(YNL_YAML_DIR)/%.yaml
	$(YNL_TOOL) -i $< -o $@

?

> +htmldocs: $(YNL_INDEX)
>         @$(srctree)/scripts/sphinx-pre-install --version-check
>         @+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
