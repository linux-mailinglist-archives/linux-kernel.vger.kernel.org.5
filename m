Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C831F799FAC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 22:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjIJUZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 16:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjIJUZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 16:25:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7203A135;
        Sun, 10 Sep 2023 13:25:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF664C433C7;
        Sun, 10 Sep 2023 20:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694377553;
        bh=M3XVpYTqMwblDvLDn0+Gp61z7L6XFs9z98lcQBonSEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2hGKi4a0virIj+5bk4bqBU5xa6SbOIxFosULuH2+EkgrTYMrzI0i9CE84yuKxSyJ
         7Vi1sgnfUcaLkYQQWc8u0e6kdSgzDZ5eYiw+spV+VsI53R3NMveqrXliFVxNP11hXS
         W0Ne6Lac9BzyGG2JlZvZqLBJXo2OMSD6jnknjAoc=
Date:   Sun, 10 Sep 2023 21:25:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak Rathore <deeratho@cisco.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Message-ID: <2023091012-python-image-6f03@gregkh>
References: <20230906121525.3946250-1-deeratho@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906121525.3946250-1-deeratho@cisco.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:45:25PM +0530, Deepak Rathore wrote:
> From: Zheng Wang <zyytlz.wz@163.com>
> 
> [ Upstream commit 73f7b171b7c09139eb3c6a5677c200dc1be5f318 ]
> 
> In btsdio_probe, the data->work is bound with btsdio_work. It will be
> started in btsdio_send_frame.
> 
> If the btsdio_remove runs with a unfinished work, there may be a race
> condition that hdev is freed but used in btsdio_work. Fix it by
> canceling the work before do cleanup in btsdio_remove.
> 
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Signed-off-by: Deepak Rathore <deeratho@cisco.com>

Meta-comment, are you SURE you want this applied?  If so, why was it
reverted upstream in 6.4 in commit db2bf510bd5d ("Revert "Bluetooth:
btsdio: fix use after free bug in btsdio_remove due to unfinished
work"")

What testing did you do that determined this should be added to the
tree?  How did you come up with just this one commit to be requested to
be applied to just this one branch?

thanks,

greg k-h-
