Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1E47D6C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344087AbjJYMjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344054AbjJYMjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:39:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11539C;
        Wed, 25 Oct 2023 05:39:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611B9C433C7;
        Wed, 25 Oct 2023 12:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698237589;
        bh=izrauq5aGqPVsDf/t0BCTrBB/O9la1zB0gYc2jn+qiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tqNrenIzHolLr1199ZbICpYPT1fmWKQEqqMcl7slVFxLQuTTJa91uF8NBve1BVg4f
         UavUx9TeF/lflT6Uk4F/O7rGGwM2+8bEhGFHok4GWU5ULI9TbGzIkmMXcxQn70Qegx
         JPPYBdpvKvaQKKBwRk+P8fpiRQAGHlMP4fgLJx2UCLf0tC/QQFUrbQFbJdBRPQnN8E
         APEuJCM/0RNhIJzBz1oWrGnCP42F2zrXl/f6AA6/rimZS5qxNqaiOq3zeQZvadEm/N
         5n9bEBwYBeN7eGzp/l76c4a8qVtRdGx7601TQbt21+lBkSTsylNHxtNVDiRfb3N1VF
         jkbC433is4KWQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qvdBB-0006Ln-1I;
        Wed, 25 Oct 2023 14:40:09 +0200
Date:   Wed, 25 Oct 2023 14:40:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Simon Ser <contact@emersion.fr>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pmic_glink: fix connector type to be
 DisplayPort
Message-ID: <ZTkMqYQzy7k-zgJM@hovoldconsulting.com>
References: <20231010225229.77027-1-dmitry.baryshkov@linaro.org>
 <ZTkIpMWpxKzSE7gQ@hovoldconsulting.com>
 <NDl6Ye92jJDp3fm20AwcuUKWuP8tzQ9CyWGGRltZ_DxYgxep2DO8Wil0Nmsfmhp1j4vAp9Yu1duiHeQkjBG-bcAdFoW3ZbWxvVqrCEpQe_4=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NDl6Ye92jJDp3fm20AwcuUKWuP8tzQ9CyWGGRltZ_DxYgxep2DO8Wil0Nmsfmhp1j4vAp9Yu1duiHeQkjBG-bcAdFoW3ZbWxvVqrCEpQe_4=@emersion.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 12:29:26PM +0000, Simon Ser wrote:
> On Wednesday, October 25th, 2023 at 14:22, Johan Hovold <johan@kernel.org> wrote:
> 
> > I was just going to post a patch fixing this after finally investigating
> > why the DisplayPort outputs on the X13s were annoyingly identified as
> > "Unknown20-1" and "Unknown20-2" instead of the expected "DP-1" and
> > "DP-2".
> 
> Note, ideally userspace should use drmModeGetConnectorTypeName() from
> libdrm to figure out the proper name for a connector type. That way we
> only need to update a single spot when adding a new connector type,
> instead of patching a whole bunch of programs.

Yeah, I only skimmed the xrandr code and these strings appear to
originate from some X library. So hopefully not that many places to
update.

Scripts and other tools may still be using these strings directly
however (e.g. as did my custom script to enable external displays).

Johan
