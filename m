Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5A37B4F1C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbjJBJfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjJBJfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:35:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DC891
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:35:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC250C433C7;
        Mon,  2 Oct 2023 09:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696239305;
        bh=dnFTdFOeagWaBjtPe10DLkl9Q4FvdlXBuptRNi7f1Co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W2HtDzXu4yOZbQ2AFnAcl/zCHHLxln8B/vd/0FptfV1dKTGOdS0Edm4RggU+VF74U
         zE9POEtYaZ+J45iLWkBdchlSprJVOky94tjUrFD/FKXXVwDu+I5+RuqtyIh173wQ67
         nMahuGSlY81z+9tHkhIVFGOv5LRccRcJFv1pGJCU=
Date:   Mon, 2 Oct 2023 11:35:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH v10 1/3] nvmem: core: Rework layouts to become platform
 devices
Message-ID: <2023100200-snowcap-arena-a548@gregkh>
References: <20230922174854.611975-1-miquel.raynal@bootlin.com>
 <20230922174854.611975-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922174854.611975-2-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 07:48:52PM +0200, Miquel Raynal wrote:
> Current layout support was initially written without modules support in
> mind. When the requirement for module support rose, the existing base
> was improved to adopt modularization support, but kind of a design flaw
> was introduced. With the existing implementation, when a storage device
> registers into NVMEM, the core tries to hook a layout (if any) and
> populates its cells immediately. This means, if the hardware description
> expects a layout to be hooked up, but no driver was provided for that,
> the storage medium will fail to probe and try later from
> scratch. Technically, the layouts are more like a "plus" and, even we
> consider that the hardware description shall be correct, we could still
> probe the storage device (especially if it contains the rootfs).
> 
> One way to overcome this situation is to consider the layouts as
> devices, and leverage the existing notifier mechanism. When a new NVMEM
> device is registered, we can:
> - populate its nvmem-layout child, if any
> - try to modprobe the relevant driver, if relevant
> - try to hook the NVMEM device with a layout in the notifier
> And when a new layout is registered:
> - try to hook all the existing NVMEM devices which are not yet hooked to
>   a layout with the new layout
> This way, there is no strong order to enforce, any NVMEM device creation
> or NVMEM layout driver insertion will be observed as a new event which
> may lead to the creation of additional cells, without disturbing the
> probes with costly (and sometimes endless) deferrals.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Did I miss why these were decided to be platform devices and not normal
devices on their own "bus" that are attached to the parent device
properly?  Why platform for a dynamic thing?

If I did agree with this, it should be documented here in the changelog
why this is required to be this way so I don't ask the question again in
the future :)

thanks,

greg k-h
