Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05221757D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjGRNVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjGRNUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:20:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409B9198E;
        Tue, 18 Jul 2023 06:20:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4F5161574;
        Tue, 18 Jul 2023 13:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECE2C433C8;
        Tue, 18 Jul 2023 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689686445;
        bh=qxHnS2H4SpiZ8oKCK0VuJ2HjGf7X9AuQaK16fBcFmyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CuaBlEfDAHGjuzmURVPNAW++eLVcsReLEZyJKyx2ZT0bQp3RDvDPE+d2ZL3lRFm4e
         40SYzAUsYsWw3Ys0pQG9a7LSwbCckQb/vNrBI89NKjO/ChhRRuXbgLrDMI0D0KJNkv
         EIKRAqsv2+7F3mD1QqRo4TB1pH3HfIOvGLHfrRXSwVOzEkzSeXiTyJi3LjK0arCvvu
         fyGBLeaPn8kaw7pzIBjF3luSFnxaEUbK8fOVyW5B9hzuvm4PZpK3lex41W+ThuUHCJ
         jqfypE7o5RBKUbb69vrN0pa4NtKuo9WWEvq5BkCBhtlgbxQg4TCPUhiiCeuAAWIxfu
         EEtIhgZ7Ng22g==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qLkdK-0005Wc-1c;
        Tue, 18 Jul 2023 15:20:54 +0200
Date:   Tue, 18 Jul 2023 15:20:54 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 03/15] clk: qcom: gcc-sm6375: Unregister critical clocks
Message-ID: <ZLaRtrH85v4kpSvb@hovoldconsulting.com>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-3-27784d27a4f4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717-topic-branch_aon_cleanup-v1-3-27784d27a4f4@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:19:10PM +0200, Konrad Dybcio wrote:
> Some clocks need to be always-on, but we don't really do anything
> with them, other than calling enable() once and telling Linux they're
> enabled.
> 
> Unregister them to save a couple of bytes and, perhaps more
> importantly, allow for runtime suspend of the clock controller device,
> as CLK_IS_CRITICAL prevents the latter.

But this doesn't sound right. How can you disable a controller which
still has clocks enabled?

Shouldn't instead these clocks be modelled properly so that they are
only enabled when actually needed?

Johan
