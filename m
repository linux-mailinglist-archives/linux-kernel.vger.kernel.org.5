Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2558128EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjLNHQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjLNHQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:16:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF1EE8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:16:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E68C433C7;
        Thu, 14 Dec 2023 07:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702538195;
        bh=3TpFSw6c14ZZQZiXkduDLlSNFGLigPiCkjMZk553ex8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t5jzaMu8+fN+K6vHUbhaWDmbgt2ncJZr/CbWW9NMRVvAJTdZE230GqM9K5GKvGzdp
         dzJT3eSES44awaJfFDmQbv34b+ekXPBe4eHYPa4MKpNHLqhcQ14EctPF9hwGYW3Skh
         8cMF57s7i609078CATCWc+MjVAzr4ypyKi4uOiRmqcpXq3LSA5l2PJpQEJ5WSAb0wq
         ZOx+JMX9BBin0q0/nCOYIfKuW8e8V0IeVYeNzPzp6ZbZcSeGO+uI/0JwdvTQutv1l7
         SVcdkzQXUUK7MNVqiNri7lvWwi9k0Kj9zyWHggi486k2YfqKnTZuslbsQn2zEGwAAC
         ATLwVJ9PqrZCQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rDfxR-0000pv-34;
        Thu, 14 Dec 2023 08:16:34 +0100
Date:   Thu, 14 Dec 2023 08:16:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: pmic_glink: Fix boot when QRTR=m
Message-ID: <ZXqr0RFw9KsP876v@hovoldconsulting.com>
References: <20231213210644.8702-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213210644.8702-1-robdclark@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 01:06:43PM -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> We need to bail out before adding/removing devices, if we are going
> to -EPROBE_DEFER.  Otherwise boot will get stuck forever at
> deferred_probe_initcall().

Can please you expand on why this is a problem here in the commit
message?

The aux devices appear to be tore down correctly in the probe error
paths so how exactly does that lead to deferred_probe_initcall() being
stuck? This sounds like we may have a problem elsewhere which this patch
is papering over.

Also where does the probe deferral come from in your case?
pdr_handle_alloc()?

If this is a correct fix, I'd also expect there to be a Fixes and
CC-stable tag.

Johan
