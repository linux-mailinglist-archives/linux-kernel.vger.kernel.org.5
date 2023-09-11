Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB5C79BFDC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378886AbjIKWht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237933AbjIKNXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:23:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD322193;
        Mon, 11 Sep 2023 06:23:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A65C433C7;
        Mon, 11 Sep 2023 13:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694438591;
        bh=9c86DeoJl8jPh2wNBHyQjlcM9oD3W5Uj+epx+7R7eJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0MaO5HNviSut7sksefXMT1eJkSifD0wIZPiLIQ9+wNjQcbNLI603jBv4CT38SU5QQ
         bKUIZtO4FEfTBt5ixp5VUc8pXfOO/We0js9r9O91G2Za1KUxzwn+VB2cWopAyy+FfD
         DzXNY+yhXmFN3Jv62Oojj+2328hWqQh+X17okHeU=
Date:   Mon, 11 Sep 2023 15:23:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco)" 
        <deeratho@cisco.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Message-ID: <2023091116-disband-modulator-e451@gregkh>
References: <20230906121525.3946250-1-deeratho@cisco.com>
 <2023091012-python-image-6f03@gregkh>
 <DM4PR11MB61891026BF701EB7254CECF4C4F2A@DM4PR11MB6189.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB61891026BF701EB7254CECF4C4F2A@DM4PR11MB6189.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 01:17:47PM +0000, Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco) wrote:
> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org> 
> Sent: Monday, September 11, 2023 1:56 AM
> To: Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco) <deeratho@cisco.com>
> Cc: stable@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition
> 
> On Wed, Sep 06, 2023 at 05:45:25PM +0530, Deepak Rathore wrote:
> > From: Zheng Wang <zyytlz.wz@163.com>
> > 
> > [ Upstream commit 73f7b171b7c09139eb3c6a5677c200dc1be5f318 ]
> > 
> > In btsdio_probe, the data->work is bound with btsdio_work. It will be 
> > started in btsdio_send_frame.
> > 
> > If the btsdio_remove runs with a unfinished work, there may be a race 
> > condition that hdev is freed but used in btsdio_work. Fix it by 
> > canceling the work before do cleanup in btsdio_remove.
> > 
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Signed-off-by: Deepak Rathore <deeratho@cisco.com>
> 
> > Meta-comment, are you SURE you want this applied?  If so, why was it reverted upstream in 6.4 in commit db2bf510bd5d ("Revert "Bluetooth:
> > btsdio: fix use after free bug in btsdio_remove due to unfinished
> > work"")
> 
> > What testing did you do that determined this should be added to the tree?  How did you come up with just this one commit to be requested to be applied to just this one branch?
> 
> > thanks,
> 
> > greg k-h-
> 
> Hi Greg,
> 
> Yes. I am sure that this fix should be applied to v6.1 stable branch. Our CVERT tool reported kernel CVE CVE-2023-1989 on v6.1 kernel and this fix is also missing in upstream kernel v6.1 as well.

I have no idea what a CVERT tool is, only that you can almost guarantee
that it will not work well for kernel cves given the way that cves are
broken for the kernel.  But good luck with it!  :)

> In the reverted upstream commit db2bf510bd5d ("Revert "Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work""), it is clearly mentioned that this commit db2bf510bd5d is causing null-ptr-def problem and fixed bug by this patch have resolved by another commit 73f7b171b7c0. I have backported same commit 73f7b171b7c0 and sent this for review. Please see the below commit message of commit db2bf510bd5d:

So, can you verify that the latest 6.1.y released kernel is correct now?

thanks,

greg k-h
