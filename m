Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40188138D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444127AbjLNRjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLNRjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:39:42 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5ACA7;
        Thu, 14 Dec 2023 09:39:48 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id BD29721454;
        Thu, 14 Dec 2023 18:39:45 +0100 (CET)
Date:   Thu, 14 Dec 2023 18:39:44 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, greybus-dev@lists.linaro.org,
        linux-iio@vger.kernel.org, netdev@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-sound@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1] treewide, serdev: change receive_buf() return type to
 size_t
Message-ID: <ZXs94Mf1eOMCmGpT@francesco-nb.int.toradex.com>
References: <20231214170146.641783-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214170146.641783-1-francesco@dolcini.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 06:01:46PM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> receive_buf() is called from ttyport_receive_buf() that expects values
> ">= 0" from serdev_controller_receive_buf(), change its return type from
> ssize_t to size_t.
> 
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Link: https://lore.kernel.org/all/087be419-ec6b-47ad-851a-5e1e3ea5cfcc@kernel.org/
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> hello,
> patch is based on current linux next.
> 
> It has an obvious problem, it touches files from multiple subsystem in a single
> patch that is complicated to review and eventually merge, just splitting this
> would however not work, it will break bisectability and the build.
> 
> I am looking for advise on the best way to move forward.
> 
> I see the following options:
>  - keep it as it is
>  - break it down with a patch with each subsystem, and squash before applying
>    from a single (tty?) subsystem
>  - go for a multi stage approach, defining a new callback, move to it and in
>    the end remove the original one, likewise it was done for i2c lately

whoops. I just noticed Greg applied commit 475fc6e2de6f ("tty: serdev:
convert to u8 and size_t") that touch the exact same files without much
of an issue.

Probably the "keep it as it is" is just the way to go.

> 
> ---
>  drivers/bluetooth/btmtkuart.c              |  4 ++--
>  drivers/bluetooth/btnxpuart.c              |  4 ++--
>  drivers/bluetooth/hci_serdev.c             |  4 ++--
>  drivers/gnss/core.c                        |  6 +++---
>  drivers/gnss/serial.c                      |  4 ++--
>  drivers/gnss/sirf.c                        |  6 +++---
>  drivers/greybus/gb-beagleplay.c            |  6 +++---
>  drivers/iio/chemical/pms7003.c             |  4 ++--
>  drivers/iio/chemical/scd30_serial.c        |  4 ++--
>  drivers/iio/chemical/sps30_serial.c        |  4 ++--
>  drivers/iio/imu/bno055/bno055_ser_core.c   |  4 ++--
>  drivers/mfd/rave-sp.c                      |  4 ++--
>  drivers/net/ethernet/qualcomm/qca_uart.c   |  2 +-
>  drivers/nfc/pn533/uart.c                   |  4 ++--
>  drivers/nfc/s3fwrn5/uart.c                 |  4 ++--
>  drivers/platform/chrome/cros_ec_uart.c     |  4 ++--
>  drivers/platform/surface/aggregator/core.c |  4 ++--
>  drivers/tty/serdev/serdev-ttyport.c        | 10 ++++------
>  include/linux/gnss.h                       |  4 ++--
>  include/linux/serdev.h                     |  8 ++++----
>  sound/drivers/serial-generic.c             |  4 ++--
>  21 files changed, 48 insertions(+), 50 deletions(-)
