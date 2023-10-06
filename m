Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79767BB5DC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjJFLEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjJFLEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:04:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC91CA;
        Fri,  6 Oct 2023 04:04:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05BEC433C7;
        Fri,  6 Oct 2023 11:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696590275;
        bh=XLlwpGj1hGJ6zbiAJm0mczBltVK0XU1/GnjKB3xO8Kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t9sDin+6Bx9KckpASK79eyQQDDBomfGeuU8KogasxXKv1d57Mtv6mAj2kIKRC3dLy
         VBKwFd5ahyGAq9dVV30loulisE9s6e5uBc/iPD9mZ01kDzVB8/J1vvH6HbPHu+M7sx
         6PD2ArRTwAJZmzeD6382ROVEM6iZjKSSbIo4/4ao=
Date:   Fri, 6 Oct 2023 13:04:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v4 5/5] drivers/tty/serial: add ESP32S3 ACM device driver
Message-ID: <2023100640-isolating-privatize-7bf7@gregkh>
References: <20230928151631.149333-1-jcmvbkbc@gmail.com>
 <20230928151631.149333-6-jcmvbkbc@gmail.com>
 <2023100326-crushing-septic-4856@gregkh>
 <CAMo8BfJgpP-=tNEChcyR3z6i_QeJ9Ywq7EOjjC5i7Uq4OrgXNA@mail.gmail.com>
 <2023100544-rendering-identify-e0ad@gregkh>
 <CAMo8Bf+wS+qiX2mMZm0i8dt7xkDO8RvroP8RF=78zxgFj-zwaA@mail.gmail.com>
 <2023100625-water-molehill-4a8f@gregkh>
 <CAMo8BfLfBEQVTyBXw=K2wsgGF+ZUfJhffX4ax8kX+k_DPSOKYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMo8BfLfBEQVTyBXw=K2wsgGF+ZUfJhffX4ax8kX+k_DPSOKYg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 03:27:37AM -0700, Max Filippov wrote:
> On Fri, Oct 6, 2023 at 2:34 AM Greg Kroah-Hartman
> > > > Yes, but not all do.  If you don't need to do anything special, it can
> > > > just claim to be a normal device, we've had threads about this on the
> > > > list before.  If you don't need to determine in userspace from the tty
> > > > connection what device it is, just use the default one instead.
> > >
> > > Ok, it looks like having
> > >
> > > #define PORT_ESP32ACM (-1)
> > >
> > > in the driver source should be ok? I've tested that it works.
> >
> > Hah, I like that hack.  But why not just use PORT_UNKNOWN?
> 
> A lot of functionality doesn't work with PORT_UNKNOWN, e.g.
> console or modem control.
> I've got the idea of using -1 from this email:
> https://lore.kernel.org/linux-serial/502240f7-2cac-4fe6-9e27-f9861db3666d@app.fastmail.com/

Ok, we should encode this as a "real" number, "PORT_ANY" and set it to
-1 and let all new devices use it.

thanks,

greg k-h
