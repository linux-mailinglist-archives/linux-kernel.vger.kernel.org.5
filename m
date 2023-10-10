Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D7F7C02F1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjJJRpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjJJRpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:45:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C54C99
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:45:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360A4C433C7;
        Tue, 10 Oct 2023 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696959921;
        bh=12HETObScvICGvJBj/jsxHUGs+99NSdL0zEu4lhBNzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBpniwwTUojc0NnCQJeOU65qlwLKGVTSmkkVf7Iy6gZ+L/0v5MRNtOwTstrHS5+td
         QCDTF/eZXfb1s3RelWJdj7Z9ajTRKlNdpLwkHPTXiDs0EyNltaCYL04uLFzS6ZAhbu
         V4nEf1wDAa6zsJXOW8QJkk+NRC/hp3Oscwsk95rBuTLP0JMEWDVxyCW9ElEycUMKDn
         SRj9bkBc1s19gDDyfF6KONE94I9MkbgGqOw2GWzc86G0lCFYx10VAsbq1SLcd795bj
         KKadPfA8+XJeagyKFmjz5lwaf87UuEnRgYX17ObVKwdVrPixhjabn5IeBl6y158lL+
         8v0vnBXTQIyQA==
Date:   Tue, 10 Oct 2023 19:45:16 +0200
From:   Simon Horman <horms@kernel.org>
To:     Sonia Sharma <sosha@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, sosha@microsoft.com, kys@microsoft.com,
        mikelley@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, longli@microsoft.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v7] hv_netvsc: fix netvsc_send_completion to
 avoid multiple message length checks
Message-ID: <20231010174516.GA1003866@kernel.org>
References: <1696838416-8925-1-git-send-email-sosha@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696838416-8925-1-git-send-email-sosha@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 01:00:16AM -0700, Sonia Sharma wrote:
> From: Sonia Sharma <sonia.sharma@linux.microsoft.com>
> 
> The switch statement in netvsc_send_completion() is incorrectly validating
> the length of incoming network packets by falling through to the next case.
> Avoid the fallthrough. Instead break after a case match and then process
> the complete() call.
> The current code has not caused any known failures. But nonetheless, the
> code should be corrected as a different ordering of the switch cases might
> cause a length check to fail when it should not.
> 
> Signed-off-by: Sonia Sharma <sonia.sharma@linux.microsoft.com>
> 
> ---
> Changes in v3:
> * added return statement in default case as pointed by Michael Kelley.
> Changes in v4:
> * added fixes tag
> * modified commit message to explain the issue fixed by patch.
> Changes in v5:
> * Dropped fixes tag as suggested by Simon Horman.
> * fixed indentation
> Changes in v7:
> * Dropped the prefix "net" from subject line.

This seems address the concerns raised by Michael Kelly in his review of v6.

It doesn't include his (or my) Reviewed-by tag(s).
That not withstanding the logic change and overall patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
