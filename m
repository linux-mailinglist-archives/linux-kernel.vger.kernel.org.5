Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F1B7BA16D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240002AbjJEOr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239860AbjJEOoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:44:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BA227552
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:22:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7936C116CB;
        Thu,  5 Oct 2023 09:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696498584;
        bh=lTG9KJWY8mad3KgNcv95RiAKVUHghwr6bImXcI5LmUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vt1u/tGxzZPl97g5dmR5Y8Qk6FBFd2S99LYXnjCMdkvZsGAjjdZFqYhsVK5YDot/7
         PNEY8BC00b1g9N6Hi9Ukmqt6IXpWoUaPcrBN/lFXWJo/r87aPtkULPvlYSsB4yEvP+
         MSbeSRDGSygg3snIEyLnwRns3f4lbpK5m3iru+uE=
Date:   Thu, 5 Oct 2023 11:36:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tanjore Suresh <tansuresh@google.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Daniel Wagner <dwagner@suse.de>,
        Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v4] driver core: shut down devices asynchronously
Message-ID: <2023100507-refocus-stooge-08dd@gregkh>
References: <20230921163443.9224-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921163443.9224-1-stuart.w.hayes@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 11:34:43AM -0500, Stuart Hayes wrote:
> Shut down devices asynchronously, ensuring that each device is shut down
> before its parents.
> 
> This can dramatically reduce system shutdown/reboot time on systems that
> have devices that take many seconds to shut down, such as some NVMe drives.
> On one system tested, the shutdown time went from 11 minutes without this
> patch to 55 seconds with the patch.

That's a nice improvement, but I think we need a lot more testing on a
wide range of systems before we can take a patch like this.

Also, what about busses that don't want this type of shutdown?  We allow
busses to opt-in for async probing, shouldn't that be also done for
shutting them down to resolve issues for busses that can not handle
this?

thanks,

greg k-h
