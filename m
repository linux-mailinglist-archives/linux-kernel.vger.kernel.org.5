Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413B07BC722
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 13:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343675AbjJGLdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 07:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbjJGLdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 07:33:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F7CB9;
        Sat,  7 Oct 2023 04:33:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A7DC433C8;
        Sat,  7 Oct 2023 11:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696678400;
        bh=MhC2Xsh1F0Dp/xiGufKa2htr3zYIzm0ooEtftPrfJ5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rDr1R2umQ5BwJUJxxoc2jFkKlxL2yQU6SkCbIMRVdn4NYYTg8CmJH154fL9154PU2
         +ZKCVfl5tqG5SksBNrtI6kwF0uNqyQdfZTSpXm9eEl80y2j2YQUafulniKHjQHtmxf
         ldQuN/RPF5ZBqHna+Mn9BpEnAE7SFVvcMSO8BCS8=
Date:   Sat, 7 Oct 2023 13:33:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        jacob.e.keller@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] i40e: fix the wrong PTP frequency calculation
Message-ID: <2023100707-hydrogen-tapestry-62e8@gregkh>
References: <20230926071059.1239033-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926071059.1239033-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 03:10:59PM +0800, Yajun Deng wrote:
> The new adjustment should be based on the base frequency, not the
> I40E_PTP_40GB_INCVAL in i40e_ptp_adjfine().
> 
> This issue was introduced in commit 3626a690b717 ("i40e: use
> mul_u64_u64_div_u64 for PTP frequency calculation"), frequency is left
> just as base I40E_PTP_40GB_INCVAL before the commit. After the commit,
> frequency is the I40E_PTP_40GB_INCVAL times the ptp_adj_mult value.
> But then the diff is applied on the wrong value, and no multiplication
> is done afterwards.
> 
> It was accidentally fixed in commit 1060707e3809 ("ptp: introduce helpers
> to adjust by scaled parts per million"). It uses adjust_by_scaled_ppm
> correctly performs the calculation and uses the base adjustment, so
> there's no error here. But it is a new feature and doesn't need to
> backported to the stable releases.
> 
> This issue affects both v6.0 and v6.1, and the v6.1 version is an LTS
> release. Therefore, the patch only needs to be applied to v6.1 stable.
> 
> Fixes: 3626a690b717 ("i40e: use mul_u64_u64_div_u64 for PTP frequency calculation")
> Cc: <stable@vger.kernel.org> # 6.1
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Now queued up, thanks.

greg k-h
