Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1900C7DCD83
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344428AbjJaNCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344366AbjJaNCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:02:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0617CB7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:02:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E12C433C9;
        Tue, 31 Oct 2023 13:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698757366;
        bh=i9Bih+a16N50+/wqLFiAeUDIZcIh3ceZh6I9qgR2a5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=icnAV7+5EBcAHpu97hpv3ZB78z2tDH2iMG8B9ft8cQCXz446hHGiaVQGw6VAhoXS4
         98+bb5MtZqD7l6YKxlwafs0h2XFpLodgAPAGROwlP+WAMLt0qxO1od3vbGqHYPo1xO
         CR0uuqay2LQ8GUDMVKjs6uE/wTRGcekSuzzUaU30=
Date:   Tue, 31 Oct 2023 14:02:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Yu Wang <quic_yyuwang@quicinc.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH] Devcoredump: fix use-after-free issue when releasing
 devcd device
Message-ID: <2023103119-litigator-yonder-6ee1@gregkh>
References: <20231027055521.2679-1-quic_yyuwang@quicinc.com>
 <2023102730-twins-thieving-d04e@gregkh>
 <22ab53d1ae36d4925732e6e1dc989dc75af126da.camel@sipsolutions.net>
 <ab509035-cf3c-4902-87a8-cbba03ac948c@quicinc.com>
 <d00e8976baa4fb93a1f3f1191998994540bb173b.camel@sipsolutions.net>
 <bb8113aa-1573-5e02-3fcd-bd92b8ac14ba@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb8113aa-1573-5e02-3fcd-bd92b8ac14ba@quicinc.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 06:16:08PM +0530, Mukesh Ojha wrote:
> 
> 
> On 10/31/2023 2:29 PM, Johannes Berg wrote:
> > On Tue, 2023-10-31 at 16:29 +0800, Yu Wang wrote:
> > > 
> > > In this case, the device is temporarily added for dump only, so we need to
> > > delete it when dump is completed.
> > > The other users doesn't add/delete the device like this.
> > 
> > For good reason, I guess? I think this is probably a bad idea.
> > 
> > The whole point of this was to actually know which device created the
> > coredump? If you make one up on the fly that's ... pointless? Surely you
> > must have _some_ device that already exists?
> 
> Passing device name to be user space looks to be the reason.

Wait, again, why are you creating a fake device just to dump data?
That's not what this api is for at all, why are you abusing it in ways
it was not designed to be used?

And I will strongly argue, that if no in-kernel users are having
problems, perhaps it is your out-of-tree code?

Unless you can show any in-kernel user of this trigging the issue, I
don't think there's anything we need to do here, do you?

thanks,

greg k-h
