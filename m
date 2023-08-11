Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E53778C04
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjHKK0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjHKK0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:26:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2549DD1;
        Fri, 11 Aug 2023 03:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691749571; x=1723285571;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Voec7eWZoxmqfomcHyf2KT9ZSoXULKiQMeY+HYes2i8=;
  b=d+20oNhRLmvsDMpkvfZkS2pWdVeDvgT4ryRXTOYHMZOWwnRFyB1OeNBC
   R/bAxfXRLjnJStyRxLpuuy0k8kBmtDgfQVTObiHFUqLkZdrlopLwksDim
   3mZW3kvpRI8bNIPrds7MI4sE4erpx3nSXujw/Ry054GIb6GkL+1H8FfUT
   q7F5PqUlHuTTvEsSdTflz+SDQqI7653MGS4Dz+4a4s6RPzFpnznJfYBwy
   UCJj9ZgXwsmWGEwAcSWPDlRB7toFZnE+fmdT5iAbycFY5iOWXXOv34+z5
   8aSix/11iJFM2xzVgrPPfF6uZz1ojFFQuDvlRuVN1krqRu8mr4MvQMCC+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="375360744"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="375360744"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 03:26:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="979191880"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="979191880"
Received: from aberko-mobl1.ger.corp.intel.com ([10.252.51.87])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 03:26:09 -0700
Date:   Fri, 11 Aug 2023 13:26:01 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/36] tty: type unifications -- part I.
In-Reply-To: <20230810091510.13006-1-jirislaby@kernel.org>
Message-ID: <728dc060-d38c-b8d4-783-2322115cf4b4@linux.intel.com>
References: <20230810091510.13006-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-37000700-1691748787=:50003"
Content-ID: <d9fa254c-87e5-ac5a-7164-2e78e8519bf9@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-37000700-1691748787=:50003
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <ae8faddc-86f9-4636-f6da-aca0718884a@linux.intel.com>

On Thu, 10 Aug 2023, Jiri Slaby (SUSE) wrote:

> Currently, the tty layer ops and functions use various types for same
> things:
> * characters and flags: unsigned char, char are used on a random basis,
> * counts: int, unsigned int, size_t are used, again more-or-less
>   randomly.
> 
> This makes it rather hard to remember where each type is required and it
> also makes the code harder to follow. Also the code has to do min_t() on
> many places simply because the variables hold the same kind of data, but
> of different type.
> 
> This is the first part of the series to unify the types:
> * make characters and flags 'u8'. This is what the hardware expects and
>   what feeds the tty layer with. Since we compile with -funsigned-char,
>   char and unsigned char are the same types on all platforms. So there
>   is no actual change in type.
> * make sizes/counts 'size_t'. This is what comes from the VFS layer and
>   some tty functions already operate on this. So instead of using
>   "shorter" (in term of bytes on 64bit) unsigned int, stick to size_t
>   and promote it to most places.
> 
> More cleanup and spreading will be done in tty_buffer, n_tty, and
> likely other places later.
>
> Patches 1-8 are cleanups only. The rest (the real switch) depends on
> those. 

Yeah, very much needed change and step into the right direction!

It's a bit tedious to review all this and comment a particular subchange 
but e.g. n_tty_receive_buf_common() still seems to still have int count 
which I think fall into the same call chain about size/count (probably 
most related change is #15). Note though that it also has room which I 
think can actually become negative so it might not be as straightforward 
search and replace like some other parts are.

At least for patches #1-#14,

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

> Jiri Slaby (SUSE) (36):
>   tty: xtensa/iss: drop unneeded tty_operations hooks
>   tty: ldisc: document that ldops are optional
>   tty: remove dummy tty_ldisc_ops::poll() implementations
>   tty: n_null: remove optional ldops
>   tty: change tty_write_lock()'s ndelay parameter to bool
>   tty: tty_port: rename 'disc' to 'ld'
>   tty: drop tty_debug_wait_until_sent()
>   tty: make tty_change_softcar() more understandable
>   tty: make tty_port_client_operations operate with u8
>   tty: make counts in tty_port_client_operations hooks size_t
>   tty: switch receive_buf() counts to size_t
>   tty: switch count in tty_ldisc_receive_buf() to size_t
>   tty: can327: unify error paths in can327_ldisc_rx()
>   tty: can327, move overflow test inside can327_ldisc_rx()'s loop
>   tty: make tty_ldisc_ops::*buf*() hooks operate on size_t
>   tty: use u8 for chars
>   tty: use u8 for flags
>   misc: ti-st: make st_recv() conforming to tty_ldisc_ops::receive_buf()
>   tty: make char_buf_ptr()/flag_buf_ptr()'s offset unsigned
>   tty: tty_buffer: make all offsets unsigned
>   tty: don't pass write() to do_tty_write()
>   tty: rename and de-inline do_tty_write()
>   tty: use min() in iterate_tty_write()
>   tty: use ssize_t for iterate_tty_read() returned type
>   tty: switch size and count types in iterate_tty_read() to size_t
>   tty: use min() for size computation in iterate_tty_read()
>   tty: propagate u8 data to tty_operations::write()
>   tty: propagate u8 data to tty_operations::put_char()
>   tty: make tty_operations::write()'s count size_t
>   tty: audit: unify to u8
>   tty: ldops: unify to u8
>   tty: hvc: convert counts to size_t
>   tty: vcc: convert counts to size_t
>   tty: gdm724x: convert counts to size_t
>   tty: hso: simplify hso_serial_write()
>   tty: rfcomm: convert counts to size_t
> 
>  arch/alpha/kernel/srmcons.c               |  5 +-
>  arch/m68k/emu/nfcon.c                     |  8 +--
>  arch/sparc/include/asm/vio.h              |  2 +-
>  arch/um/drivers/line.c                    |  2 +-
>  arch/um/drivers/line.h                    |  3 +-
>  arch/xtensa/platforms/iss/console.c       | 27 +--------
>  drivers/accessibility/speakup/spk_ttyio.c |  5 +-
>  drivers/bluetooth/hci_ldisc.c             | 15 ++---
>  drivers/char/ttyprintk.c                  |  5 +-
>  drivers/input/serio/serport.c             |  8 +--
>  drivers/ipack/devices/ipoctal.c           |  7 +--
>  drivers/isdn/capi/capi.c                  |  8 +--
>  drivers/misc/bcm-vk/bcm_vk_tty.c          |  5 +-
>  drivers/misc/ti-st/st_core.c              | 11 ++--
>  drivers/misc/ti-st/st_kim.c               |  6 +-
>  drivers/mmc/core/sdio_uart.c              |  4 +-
>  drivers/net/caif/caif_serial.c            |  2 +-
>  drivers/net/can/can327.c                  | 39 ++++++-------
>  drivers/net/can/slcan/slcan-core.c        |  5 +-
>  drivers/net/hamradio/6pack.c              |  4 +-
>  drivers/net/hamradio/mkiss.c              |  4 +-
>  drivers/net/mctp/mctp-serial.c            |  5 +-
>  drivers/net/ppp/ppp_async.c               | 26 +++------
>  drivers/net/ppp/ppp_synctty.c             | 26 +++------
>  drivers/net/slip/slip.c                   |  4 +-
>  drivers/net/usb/hso.c                     | 20 +++----
>  drivers/s390/char/con3215.c               |  6 +-
>  drivers/s390/char/con3270.c               |  6 +-
>  drivers/s390/char/sclp_tty.c              | 10 ++--
>  drivers/s390/char/sclp_vt220.c            |  6 +-
>  drivers/staging/gdm724x/gdm_tty.c         | 14 ++---
>  drivers/staging/greybus/uart.c            |  3 +-
>  drivers/tty/amiserial.c                   |  4 +-
>  drivers/tty/ehv_bytechan.c                |  4 +-
>  drivers/tty/goldfish.c                    |  7 +--
>  drivers/tty/hvc/hvc_console.c             |  4 +-
>  drivers/tty/hvc/hvcs.c                    | 10 ++--
>  drivers/tty/hvc/hvsi.c                    | 14 ++---
>  drivers/tty/ipwireless/hardware.c         |  2 +-
>  drivers/tty/ipwireless/tty.c              |  4 +-
>  drivers/tty/mips_ejtag_fdc.c              |  6 +-
>  drivers/tty/moxa.c                        |  8 +--
>  drivers/tty/mxser.c                       |  4 +-
>  drivers/tty/n_gsm.c                       | 14 ++---
>  drivers/tty/n_hdlc.c                      | 12 ++--
>  drivers/tty/n_null.c                      | 25 +--------
>  drivers/tty/n_tty.c                       | 59 ++++++++++----------
>  drivers/tty/nozomi.c                      |  6 +-
>  drivers/tty/pty.c                         |  2 +-
>  drivers/tty/rpmsg_tty.c                   |  5 +-
>  drivers/tty/serdev/serdev-ttyport.c       |  4 +-
>  drivers/tty/serial/kgdb_nmi.c             |  3 +-
>  drivers/tty/serial/serial_core.c          |  5 +-
>  drivers/tty/synclink_gt.c                 | 13 ++---
>  drivers/tty/tty.h                         |  8 +--
>  drivers/tty/tty_audit.c                   |  6 +-
>  drivers/tty/tty_buffer.c                  | 35 ++++++------
>  drivers/tty/tty_io.c                      | 46 +++++++---------
>  drivers/tty/tty_ioctl.c                   | 18 ++----
>  drivers/tty/tty_port.c                    | 34 ++++++------
>  drivers/tty/ttynull.c                     |  4 +-
>  drivers/tty/vcc.c                         | 18 +++---
>  drivers/tty/vt/selection.c                |  2 +-
>  drivers/tty/vt/vt.c                       |  6 +-
>  drivers/usb/class/cdc-acm.c               |  8 +--
>  drivers/usb/gadget/function/u_serial.c    |  6 +-
>  drivers/usb/host/xhci-dbgtty.c            |  7 +--
>  drivers/usb/serial/usb-serial.c           |  5 +-
>  include/linux/ti_wilink_st.h              |  2 +-
>  include/linux/tty_buffer.h                | 18 +++---
>  include/linux/tty_driver.h                |  9 ++-
>  include/linux/tty_flip.h                  | 22 ++++----
>  include/linux/tty_ldisc.h                 | 67 +++++++++++++++--------
>  include/linux/tty_port.h                  |  7 ++-
>  net/bluetooth/rfcomm/tty.c                |  9 +--
>  net/nfc/nci/uart.c                        | 15 ++---
>  sound/soc/codecs/cx20442.c                |  4 +-
>  sound/soc/ti/ams-delta.c                  |  2 +-
>  78 files changed, 381 insertions(+), 493 deletions(-)
> 
> 

-- 
 i.
--8323329-37000700-1691748787=:50003--
