Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745167568EB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjGQQRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjGQQRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:17:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2A31705;
        Mon, 17 Jul 2023 09:17:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2563561158;
        Mon, 17 Jul 2023 16:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25342C433C7;
        Mon, 17 Jul 2023 16:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689610661;
        bh=rklkSn2I4OMoVdkUFdDOBY840kFiGCRvcTcV6VUW7m4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9UqLOURQa2K8mf2+ew57b6VAH0ytvxvuIE8LsDfkK98kgRXcwb6q2RAHayXvyCb0
         SFNSq6tl9U0cCVb+V+/U41IIuNezqxHH0GMNcL3UmC0W11elKJ/hqcJKU1kBYz0+Lr
         HgNSHkewHDgzyDK0DYsoBkiP9cQ8+YYYApBg5uchJJXk9kbZT0vZ7hshWRd9WoCk9g
         Gqll010uTcBqWPZQZDQA1bwf7stenlyfqRRJIeZDFZvAWVNLJxjpCKNUdyN2B5dmMX
         0hstbomwEwYZuxeaU4ootNFHwl1BILT8fvvogfaPTHbA+FD2VQnRJVmTW8lxrGVKcj
         Dbe2b2NC9Ce1g==
Date:   Mon, 17 Jul 2023 09:21:05 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: (subset) [PATCH v3 00/18] Add basic Minidump kernel driver
 support
Message-ID: <tgvnwxbfamfayswhlqiehk5t3kqdzxhabnpmfl4dl7wvvrpzl2@arabqkz5xyyy>
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <168945921478.1805013.7211960599963339759.b4-ty@kernel.org>
 <ZLSWTaMtr9UGmrDy@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLSWTaMtr9UGmrDy@p14s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 07:15:57PM -0600, Mathieu Poirier wrote:
> On Sat, Jul 15, 2023 at 03:13:34PM -0700, Bjorn Andersson wrote:
> > 
> > On Wed, 03 May 2023 22:32:14 +0530, Mukesh Ojha wrote:
> > > Minidump is a best effort mechanism to collect useful and predefined data
> > > for first level of debugging on end user devices running on Qualcomm SoCs.
> > > It is built on the premise that System on Chip (SoC) or subsystem part of
> > > SoC crashes, due to a range of hardware and software bugs. Hence, the
> > > ability to collect accurate data is only a best-effort. The data collected
> > > could be invalid or corrupted, data collection itself could fail, and so on.
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [01/18] remoteproc: qcom: Expand MD_* as MINIDUMP_*
> >         commit: 318da1371246fdc1806011a27138175cfb078687
> >
> 
> Krzysztof asked for modifications on this patch.
> 

Krzysztof pointed out that there was no reason to trivially modify the
defines and then immediately start moving things around.

I agree with this, but as the consensus was that the rest of the series
needs more work, I find this to be a sensible cleanup, getting rid of
the cryptic "MD_" abbreviation.

Regards,
Bjorn
