Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81955781685
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 03:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243544AbjHSBxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 21:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243362AbjHSBx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 21:53:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD332722;
        Fri, 18 Aug 2023 18:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=umGobu/WEh30Unz95zedAfhIw4lti6auHb3YP7vsTTM=; b=w/Y7nb+bxzP1VLmz16BK0TOivH
        a6B5xRQg5irisBdEooAkpst6QQORpkJSXwlksgT8qKbJ7zHcUedj0aC8RzTMfQufRodA6jRPXPqRL
        T14QOQDDY5qtjCjIp3tQDllk+JLYDiTXek7Sna+fXwBCLDdPgvpiVvdDmWQGADfSHuJg2367mB3t4
        fkj8r7wxIwyK+VYXiHKEMfkqCgjngYahHpZwI6eBPpwFMcDLb7F66If57uH+sZ/nZkoF207oJFSfi
        ZCT5x01SCacEmfH3IsjLTsV5yEy3YpTnZfT1c3+oGPZuErE8lbt5fH1jJ5R6ws90MT7Q7QAUqOmMT
        NBV6Qjyg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qXB9V-00AH3M-1D;
        Sat, 19 Aug 2023 01:53:21 +0000
Message-ID: <f5bf21f5-3ca2-ade1-16dc-44588d2663ed@infradead.org>
Date:   Fri, 18 Aug 2023 18:53:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/1] media: v4l: usb: Use correct dependency for camera
 sensor drivers
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next@vger.kernel.org, Wentong Wu <wentong.wu@intel.com>,
        Zhifeng Wang <zhifeng.wang@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20230818095149.3863285-1-sakari.ailus@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230818095149.3863285-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 8/18/23 02:51, Sakari Ailus wrote:
> The Kconfig option that enables compiling camera sensor drivers is
> VIDEO_CAMERA_SENSOR rather than MEDIA_CAMERA_SUPPORT as it was previously.
> Fix this.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 7d3c7d2a2914 ("media: i2c: Add a camera sensor top level menu")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> since v1:
> 
> - Also include MMP camera Kconfig fix.
> 
>  drivers/media/platform/marvell/Kconfig | 4 ++--
>  drivers/media/usb/em28xx/Kconfig       | 4 ++--
>  drivers/media/usb/go7007/Kconfig       | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 

This v2 patch fixes a few more issues but there is still one nagging problem
(2 versions of it, one with VIDEO_VIA_CAMERA=y and one with VIDEO_VIA_CAMERA=m):

(1)
WARNING: unmet direct dependencies detected for VIDEO_OV7670
  Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
  Selected by [y]:
  - VIDEO_VIA_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && FB_VIA [=y] && VIDEO_DEV [=y]

WARNING: unmet direct dependencies detected for VIDEO_OV7670
  Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
  Selected by [y]:
  - VIDEO_VIA_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && FB_VIA [=y] && VIDEO_DEV [=y]

(2)
WARNING: unmet direct dependencies detected for VIDEO_OV7670
  Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=m] && VIDEO_CAMERA_SENSOR [=n]
  Selected by [m]:
  - VIDEO_VIA_CAMERA [=m] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && FB_VIA [=m] && VIDEO_DEV [=m]

WARNING: unmet direct dependencies detected for VIDEO_OV7670
  Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=m] && VIDEO_CAMERA_SENSOR [=n]
  Selected by [m]:
  - VIDEO_VIA_CAMERA [=m] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && FB_VIA [=m] && VIDEO_DEV [=m]

Let me know if you need full randconfig files for any of these.
Thanks.

-- 
~Randy
