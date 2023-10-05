Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990FE7BA1A3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbjJEOqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbjJEOmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:42:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD3287401
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:17:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71345C116C8;
        Thu,  5 Oct 2023 09:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696498344;
        bh=uQhmru28T4p29u3DzJdyPYOa1mlQjv1khbGuV8J5/s4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=15dHlpS0zrLNdY8nCFmCERJmHCqDy/H49lKC70IOqBUeKv+r4cn3ImTrNmUh+azw6
         xkj+e8eM22p26Tlx0KJKwDPo8ORvujHmI6UmO69rfda813eG5gx/5AyTYIgILw4O4V
         ubc1vWml5oo2ArajP71rFasQTcobaNa4T3s9bdLc=
Date:   Thu, 5 Oct 2023 11:32:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_tingweiz@quicinc.com,
        saravanak@google.com
Subject: Re: [RESEND PATCH] driver core: Clear FWNODE_FLAG_LINKS_ADDED in
 device_links_purge()
Message-ID: <2023100501-entourage-bounce-3364@gregkh>
References: <1695781810-5700-1-git-send-email-quic_zhenhuah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695781810-5700-1-git-send-email-quic_zhenhuah@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:30:10AM +0800, Zhenhua Huang wrote:
> Flag FWNODE_FLAG_LINKS_ADDED stops fwnode links creation. Current kernel
> only adds it once after fwnode links creation in fw_devlink_parse_fwnode().
> After that even device links being purged, the flag will not be cleared.
> 
> Fwnode links are converted to device links and will not be added back
> forever in normal case. Essentially if a device is registered and
> unregisted (also deleted) before it is probed (due to missing fwlink
> dependencies, abort in device_links_check_suppliers), the fwlink is not
> setup next when device is newly created again. This means the probe gets
> called without meeting all dependencies.
> 
> It usuallly happens in the case of a glue driver.

What exact glue driver is causing this to happen?  Why can't we fix that
up instead?

thanks,

greg k-h
