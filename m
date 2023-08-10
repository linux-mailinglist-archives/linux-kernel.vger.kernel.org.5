Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CCB777CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbjHJPtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbjHJPtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:49:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A46E76;
        Thu, 10 Aug 2023 08:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B9C7660EF;
        Thu, 10 Aug 2023 15:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8047EC433C7;
        Thu, 10 Aug 2023 15:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691682572;
        bh=7JZ+hjiGnW6zlgnmFdgRvS45F6iLlcnWLPDgR5IUKPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRrAvjEGrOfwyKQm5uaZj1BWRp0OibK4wDpl/exdaLQEATqBt/bTkHphCxjUyc983
         T/hqV+eu+Y6kEbPvq8rdci27BgFTSvEi2trukbFD+4dOci13LG1YzZ8nCs6Fe4eZpS
         zNDaydwuH9FowoERk/VycQ6pZC3JyQsQJwv/P+ME=
Date:   Thu, 10 Aug 2023 17:49:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eugen Hristev <eugen.hristev@collabora.com>
Cc:     Wei Chen <harperchen1110@gmail.com>, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] media: vcodec: Fix potential array out-of-bounds in
 encoder queue_setup
Message-ID: <2023081004-stout-blanching-6f17@gregkh>
References: <20230810082333.972165-1-harperchen1110@gmail.com>
 <45d0f538-9769-f4eb-7479-cf676337ff55@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45d0f538-9769-f4eb-7479-cf676337ff55@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:12:39PM +0300, Eugen Hristev wrote:
> Hi Wei,
> 
> On 8/10/23 11:23, Wei Chen wrote:
> > variable *nplanes is provided by user via system call argument. The
> > possible value of q_data->fmt->num_planes is 1-3, while the value
> > of *nplanes can be 1-8. The array access by index i can cause array
> > out-of-bounds.
> > 
> > Fix this bug by checking *nplanes against the array size.
> > 
> > Fixes: 4e855a6efa54 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Encoder Driver")
> > Signed-off-by: Wei Chen <harperchen1110@gmail.com>
> > Cc: stable@vger.kernel.org
> > ---
> > Changes in v2:
> > - Add Fixes tag and CC stable email address
> I guess stable needs to be added by the maintainer, not by the submitter

It's easiest if it is added by the submitter, makes the maintainer's job
much easier.

thanks,

greg k-h
