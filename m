Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8173C7CB293
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjJPSec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjJPSeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:34:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817B6AC;
        Mon, 16 Oct 2023 11:34:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AB1C433C7;
        Mon, 16 Oct 2023 18:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697481269;
        bh=GCPaprU2n9/5/x5XPtfd6spFd9TDdbgYpE+bKZ6lBoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NSVxWNtXqjeNOoW6QE/hgnomhxVnW0itsgsBHOE3Orxi9rNdo+OdP1BV21Fxx1osO
         cTVFOvJ6KPn5SgqDq3JEJ8JEvNMjpYfPWkohZWyNNzrgs7/yTm2L+GI7tUfrEukJIr
         Tg/OU3v+jjnqK/rGI66MfWaNNZ46XxU+P2OTThIVZNyPjDnrn08IYFzQ6gUQvcPGpE
         8d2CFjOlPyqrzKjzAakSfBqsW72N/0eE+farGqoiWyXvjE4OCz1ZRHHAGSw1trEOBf
         rNY4hYPmSMBwJNJOy8Zj0AAxCuyzOTOkusl5tbaLKPonVPH++7eS7xToT08tbFdcmJ
         QC5OkDr44PQEw==
Date:   Mon, 16 Oct 2023 11:38:16 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pmic_glink_altmode: Print error when retimer
 setup fails
Message-ID: <oay4wz2klkttkxocmtavldjna5vqzo3lmee5uie7yciukvc5cs@yudo2uadv7qe>
References: <20231013-glink-altmode-ret-v1-1-77941537a35b@fairphone.com>
 <6fw7eho6rapvlghujche4k3pm5mx7a7ojx6yyyreq6dhzjfwlt@ggqoxgirpcnr>
 <CW9O1NB1NZHP.34BW2ZGP1WV8C@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CW9O1NB1NZHP.34BW2ZGP1WV8C@fairphone.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 08:56:31AM +0200, Luca Weiss wrote:
> On Mon Oct 16, 2023 at 5:18 AM CEST, Bjorn Andersson wrote:
> > On Fri, Oct 13, 2023 at 03:56:40PM +0200, Luca Weiss wrote:
> > > It can be useful to know with which return value the retimer_set call
> > > failed, so include this info in the dev_err print.
> > > 
> >
> > Is this useful during development, or during normal execution etc. How
> > about using kretprobe or similar tools?
> 
> Hi Bjorn,
> 
> IIRC I encountered this during development of my retimer driver, where
> the op in that driver failed for some reason and it was very useful to
> get the return value to debug that.
> 
> And sure, I guess kretprobe might be also useful here but I think it's
> very common to include the return value in the error message when
> something fails, no?
> 

The problem with the error message is that you often get some generic
error code, but don't know where it came from anyway. So, I typically
use function_graph and set_graph_function to capture the path through
the called function(s)...

But that said, it is fairly common to include the error value, so I am
not against it.

> > If you insist, could you please make sure that the style matches across
> > the various typec_*_set() calls in the driver?
> 
> Do you mean adding the return value to the other dev_err prints after
> typec_*_set() calls also?
> 

I mean that we should be consistent across the error prints, and either
include the error value in all or none of the typec error prints.

Regards,
Bjorn
