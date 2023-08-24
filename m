Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21671786FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238290AbjHXNIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238756AbjHXNII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:08:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41142E5E;
        Thu, 24 Aug 2023 06:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C781564821;
        Thu, 24 Aug 2023 13:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0209C433C7;
        Thu, 24 Aug 2023 13:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692882485;
        bh=5kv7c0ZfFob0DGy0661SYa21MIEtjGdTk1bTOfjvva4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C7wyzQZN9knqog/1W+XLEFj/J6gQPE3dXwgAfIIiIxMe0zlmQOHAgkw/7FlHHDXeV
         UNQXEYEbG5zoTQPwotgPSlZsOHL1QNnIMH1Halw9VM69/ymG89FgIcsJQRYuSfgnXv
         1Ty+H3dofPEfyVIWEub+MCrf32cOBWkcXiDm+aMk=
Date:   Thu, 24 Aug 2023 15:08:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, quic_jhugo@quicinc.com,
        nipun.gupta@amd.com, tzimmermann@suse.de, ogabbay@kernel.org,
        mathieu.poirier@linaro.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, linux@zary.sk, arnd@arndb.de,
        yangyicong@hisilicon.com, benjamin.tissoires@redhat.com,
        masahiroy@kernel.org, jacek.lawrynowicz@linux.intel.com,
        geert+renesas@glider.be, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com
Subject: Re: [PATCHv5 2/4] wiegand: add Wiegand bus driver
Message-ID: <2023082412-grandly-imply-4a2f@gregkh>
References: <20230824111015.57765-1-m.zatovic1@gmail.com>
 <20230824111015.57765-3-m.zatovic1@gmail.com>
 <2023082420-quaking-barley-47b4@gregkh>
 <ZOdSudrhg/9u3a9N@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOdSudrhg/9u3a9N@fedora>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 02:53:13PM +0200, Martin Zaťovič wrote:
> On Thu, Aug 24, 2023 at 01:40:35PM +0200, Greg KH wrote:
> > On Thu, Aug 24, 2023 at 01:10:13PM +0200, Martin Zaťovič wrote:
> > > +static inline void wiegand_controller_put(void *ptr)
> > 
> > Why is this a void *?  It should be "struct wiegand_controller *"
> 
> It is a void* because it is being passed to devm_add_action_or_reset()
> and this function only accepts a pointer to a function that accepts a void*
> parameter. I am not sure if there is a way around it.

Why is this passed to that function?  This feels odd, I'll look at it
again when you send your next version, but this is not a normal "put"
type of call at all to have.

And inline functions can't be passed as parameters (well they can, but
then they are no longer an inline function...)

thanks,

greg k-h
