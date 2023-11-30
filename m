Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DCE7FFE73
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377147AbjK3W2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjK3W2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:28:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF45610E5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:28:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1186CC433C9;
        Thu, 30 Nov 2023 22:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701383297;
        bh=pCd4lFCDaZ7PiW4wTVqQ114lN6MT9ckyByeLpH+GFAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AS7PKpoxuGooLU3MtdgH2+Ev7ToehwgZt0qBOOQByGtOGBmJFJ++fB7vmlRlERSiz
         fKZdJsJhS7WefOPmAljGpHWBQPlS3ErIcfVOtscafQa77EAtcURW2/B6DKTstKDT6i
         BKWnFfcIhIA1VZRMqGntHFSfbFziQa7yhV0CtYUIMa92dz38S4lyfzNXLIEtdEY/Os
         tOTKwCQOuAnJn+fbRlUkc9a5SbrSOC2C5uKZxGg79hId7MwTptzEktgsBqDSNA9M8e
         PZ1GNEQZzyzoPtLnxkkr4oitCvy66rCfF9MHZ0fzZpJF0PkQYprC0jknftxR3YXA0K
         RONGnOK6Dq81g==
Date:   Thu, 30 Nov 2023 15:28:14 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Bitao Hu <yaoma@linux.alibaba.com>
Cc:     sagi@grimberg.me, axboe@kernel.dk, hch@lst.de,
        kanie@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: fix deadlock between reset and scan
Message-ID: <ZWkMfqF_VociudNB@kbusch-mbp.dhcp.thefacebook.com>
References: <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
 <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 10:13:37AM +0800, Bitao Hu wrote:
> Fix by marking the ctrl with say NVME_CTRL_FROZEN flag set in
> nvme_start_freeze and cleared in nvme_unfreeze. Then the scan can check
> it before adding the new namespace (under the namespaces_rwsem).

Thanks for the detailed explanation. This looks good to me.

Reviewed-by: Keith Busch <kbsuch@kernel.org>
