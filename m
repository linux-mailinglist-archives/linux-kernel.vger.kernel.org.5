Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8607D1DEA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 17:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjJUPgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 11:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjJUPgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 11:36:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87659135
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:36:05 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9b70b9671so85925ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697902565; x=1698507365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1/bD0uI8apvYKkyWMUR7rXdPh1/dRGPdShtsOh4fKM=;
        b=nzj9E2Og95lM+yPOa3ybwGcdPo9nGaT1L0cPA/2hMi5m8qhTP/ArEQIjix80LWxtbU
         v0CdeFXNOx1d59r7x1cbfWdhjmj+za20fv/g5Yt1DFhJeXCV7R2ZPTmykK3j9udwPbT6
         APGyEWaz6HA86fYLzmvKbJog9uF0E/d9InnbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697902565; x=1698507365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1/bD0uI8apvYKkyWMUR7rXdPh1/dRGPdShtsOh4fKM=;
        b=S4Jorpxk1Pljok/cAD7KALltK55WWrirHMnqOgWrdqNycEpW2iOjjif14is0uhV1mh
         NoW2FeQuyKjBQs3kZkq2N0tN12hwsomA/AJa9xtYYKX+EqMzEAC+U+P1xkPd5j9f6XoG
         DmIe+EOskogdtVOi2DNhy6suMttgqaDjIqsUjQdXYpiezIlbG0ij6Kgg4BHrhI/99zn7
         z5pGvsGsnNTmGN7fb0RotY8XfyMyeP+YzRA0W/aLVTdDPE5nsV6zgs0WjU+kpq1NjmRD
         1gkfeCe33755paRLCbpi61xEO/5QPce/cOQBGiuCbQHQX66l7yBIbjj3ErZhJfTsvlDi
         eBdw==
X-Gm-Message-State: AOJu0YzlyRH+pFssy4At7XqxHBu8qE1eZ79pM1ppZWx7FYPUkwoy0qKr
        BNj+6Kv4hXIjCAhtXamqyCxdqjIzZzHizE2r5mUKLA==
X-Google-Smtp-Source: AGHT+IH6oS1wa+pRQeczcipu1cqq3ss/zTINwWdECYOdSrMAv7R3sGJrGFLz6ZXT7sSfsilEoRCm2VquApk245vY3Lg=
X-Received: by 2002:a17:902:9047:b0:1ca:42a:1771 with SMTP id
 w7-20020a170902904700b001ca042a1771mr392272plz.24.1697902564543; Sat, 21 Oct
 2023 08:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231020210751.3415723-1-dianders@chromium.org> <20231020140655.v5.8.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
In-Reply-To: <20231020140655.v5.8.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
From:   Grant Grundler <grundler@chromium.org>
Date:   Sat, 21 Oct 2023 08:35:52 -0700
Message-ID: <CANEJEGsTpm0QWWPLVnD980oaHHwTKzZoNnuaCdZwJZHPHTG2sA@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] r8152: Block future register access if register
 access fails
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>, linux-usb@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 2:08=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> Even though the functions to read/write registers can fail, most of
> the places in the r8152 driver that read/write register values don't
> check error codes. The lack of error code checking is problematic in
> at least two ways.
>
> The first problem is that the r8152 driver often uses code patterns
> similar to this:
>   x =3D read_register()
>   x =3D x | SOME_BIT;
>   write_register(x);
>
> ...with the above pattern, if the read_register() fails and returns
> garbage then we'll end up trying to write modified garbage back to the
> Realtek adapter. If the write_register() succeeds that's bad. Note
> that as of commit f53a7ad18959 ("r8152: Set memory to all 0xFFs on
> failed reg reads") the "garbage" returned by read_register() will at
> least be consistent garbage, but it is still garbage.
>
> It turns out that this problem is very serious. Writing garbage to
> some of the hardware registers on the Ethernet adapter can put the
> adapter in such a bad state that it needs to be power cycled (fully
> unplugged and plugged in again) before it can enumerate again.
>
> The second problem is that the r8152 driver generally has functions
> that are long sequences of register writes. Assuming everything will
> be OK if a random register write fails in the middle isn't a great
> assumption.
>
> One might wonder if the above two problems are real. You could ask if
> we would really have a successful write after a failed read. It turns
> out that the answer appears to be "yes, this can happen". In fact,
> we've seen at least two distinct failure modes where this happens.
>
> On a sc7180-trogdor Chromebook if you drop into kdb for a while and
> then resume, you can see:
> 1. We get a "Tx timeout"
> 2. The "Tx timeout" queues up a USB reset.
> 3. In rtl8152_pre_reset() we try to reinit the hardware.
> 4. The first several (2-9) register accesses fail with a timeout, then
>    things recover.
>
> The above test case was actually fixed by the patch ("r8152: Increase
> USB control msg timeout to 5000ms as per spec") but at least shows
> that we really can see successful calls after failed ones.
>
> On a different (AMD) based Chromebook with a particular adapter, we
> found that during reboot tests we'd also sometimes get a transitory
> failure. In this case we saw -EPIPE being returned sometimes. Retrying
> worked, but retrying is not always safe for all register accesses
> since reading/writing some registers might have side effects (like
> registers that clear on read).
>
> Let's fully lock out all register access if a register access fails.
> When we do this, we'll try to queue up a USB reset and try to unlock
> register access after the reset. This is slightly tricker than it
> sounds since the r8152 driver has an optimized reset sequence that
> only works reliably after probe happens. In order to handle this, we
> avoid the optimized reset if probe didn't finish. Instead, we simply
> retry the probe routine in this case.
>
> When locking out access, we'll use the existing infrastructure that
> the driver was using when it detected we were unplugged. This keeps us
> from getting stuck in delay loops in some parts of the driver.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Grant Grundler <grundler@chromium.org>

> ---
> Originally when looking at this problem I thought that the obvious
> solution was to "just" add better error handling to the driver. This
> _sounds_ appealing, but it's a massive change and touches a
> significant portion of the lines in this driver. It's also not always
> obvious what the driver should be doing to handle errors.

This needs to be done one code path at a time, not in one massive
change. This is the driver equivalent to removing the BKL
(https://kernelnewbies.org/BigKernelLock).

For two years, I worked on an HPUX SCSI driver (1990s) that supported
the equivalent of hotplug (but it was called "Power Fail" on that HPUX
server). We continually found places in the driver  where the error
handling wasn't exactly right or the device FW wasn't responding to
the error handling the way we expected. Even after two years, the rate
of issue discovery was constant despite refactoring most of the driver
(reducing the driver from 15k lines to 11k lines).

> If you feel like you need to be convinced and to see what it looked
> like to add better error handling, I put up my "work in progress"
> patch when I was investigating this at: https://crrev.com/c/4937290

And this still isn't anywhere near "complete".

> There is still some active debate between the two approaches, though,
> so it would be interesting to hear if anyone had any opinions.

I have a strong opinion that the "fix all error handling" needs to be
done by someone who is willing and able to invest several years into
this driver. In other words, based on my experience, I don't think
it's worth doing for this driver.

The approach proposed in Doug's patches can easily be removed if/when
someone is able to fix up all the error handling (and even then, maybe
keep it around "just in case").

> NOTE: Grant's review tag was removed in v5 since v5 changed somewhat
> significantly.

No worries - I'm quite happy to review this again. It's a non-trivial
change but the most important one in the series.

cheers,
grant

> Changes in v5:
> - Removed extra mutex_unlock() left over in v4.
> - Fixed minor typos.
> - Don't do queue an unbind/bind reset if probe fails; just retry probe.
>
> Changes in v4:
> - Took out some unnecessary locks/unlocks of the control mutex.
> - Added comment about reading version causing probe fail if 3 fails.
> - Added text to commit msg about the potential unbind/bind loop.
>
> Changes in v3:
> - Fixed v2 changelog ending up in the commit message.
> - farmework -> framework in comments.
>
> Changes in v2:
> - Reset patch no longer based on retry patch, since that was dropped.
> - Reset patch should be robust even if failures happen in probe.
> - Switched booleans to bits in the "flags" variable.
> - Check for -ENODEV instead of "udev->state =3D=3D USB_STATE_NOTATTACHED"
>
>  drivers/net/usb/r8152.c | 207 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 176 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 65232848b31d..afb20c0ed688 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -773,6 +773,9 @@ enum rtl8152_flags {
>         SCHEDULE_TASKLET,
>         GREEN_ETHERNET,
>         RX_EPROTO,
> +       IN_PRE_RESET,
> +       PROBED_WITH_NO_ERRORS,
> +       PROBE_SHOULD_RETRY,
>  };
>
>  #define DEVICE_ID_LENOVO_USB_C_TRAVEL_HUB              0x721e
> @@ -953,6 +956,8 @@ struct r8152 {
>         u8 version;
>         u8 duplex;
>         u8 autoneg;
> +
> +       unsigned int reg_access_reset_count;
>  };
>
>  /**
> @@ -1200,6 +1205,96 @@ static unsigned int agg_buf_sz =3D 16384;
>
>  #define RTL_LIMITED_TSO_SIZE   (size_to_mtu(agg_buf_sz) - sizeof(struct =
tx_desc))
>
> +/* If register access fails then we block access and issue a reset. If t=
his
> + * happens too many times in a row without a successful access then we s=
top
> + * trying to reset and just leave access blocked.
> + */
> +#define REGISTER_ACCESS_MAX_RESETS     3
> +
> +static void rtl_set_inaccessible(struct r8152 *tp)
> +{
> +       set_bit(RTL8152_INACCESSIBLE, &tp->flags);
> +       smp_mb__after_atomic();
> +}
> +
> +static void rtl_set_accessible(struct r8152 *tp)
> +{
> +       clear_bit(RTL8152_INACCESSIBLE, &tp->flags);
> +       smp_mb__after_atomic();
> +}
> +
> +static
> +int r8152_control_msg(struct r8152 *tp, unsigned int pipe, __u8 request,
> +                     __u8 requesttype, __u16 value, __u16 index, void *d=
ata,
> +                     __u16 size, const char *msg_tag)
> +{
> +       struct usb_device *udev =3D tp->udev;
> +       int ret;
> +
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> +               return -ENODEV;
> +
> +       ret =3D usb_control_msg(udev, pipe, request, requesttype,
> +                             value, index, data, size,
> +                             USB_CTRL_GET_TIMEOUT);
> +
> +       /* No need to issue a reset to report an error if the USB device =
got
> +        * unplugged; just return immediately.
> +        */
> +       if (ret =3D=3D -ENODEV)
> +               return ret;
> +
> +       /* If the write was successful then we're done */
> +       if (ret >=3D 0) {
> +               tp->reg_access_reset_count =3D 0;
> +               return ret;
> +       }
> +
> +       dev_err(&udev->dev,
> +               "Failed to %s %d bytes at %#06x/%#06x (%d)\n",
> +               msg_tag, size, value, index, ret);
> +
> +       /* Block all future register access until we reset. Much of the c=
ode
> +        * in the driver doesn't check for errors. Notably, many parts of=
 the
> +        * driver do a read/modify/write of a register value without
> +        * confirming that the read succeeded. Writing back modified garb=
age
> +        * like this can fully wedge the adapter, requiring a power cycle=
.
> +        */
> +       rtl_set_inaccessible(tp);
> +
> +       /* If probe hasn't yet finished, then we'll request a retry of th=
e
> +        * whole probe routine if we get any control transfer errors. We
> +        * never have to clear this bit since we free/reallocate the whol=
e "tp"
> +        * structure if we retry probe.
> +        */
> +       if (!test_bit(PROBED_WITH_NO_ERRORS, &tp->flags)) {
> +               set_bit(PROBE_SHOULD_RETRY, &tp->flags);
> +               return ret;
> +       }
> +
> +       /* Failing to access registers in pre-reset is not surprising sin=
ce we
> +        * wouldn't be resetting if things were behaving normally. The re=
gister
> +        * access we do in pre-reset isn't truly mandatory--we're just re=
using
> +        * the disable() function and trying to be nice by powering the
> +        * adapter down before resetting it. Thus, if we're in pre-reset,
> +        * we'll return right away and not try to queue up yet another re=
set.
> +        * We know the post-reset is already coming.
> +        */
> +       if (test_bit(IN_PRE_RESET, &tp->flags))
> +               return ret;
> +
> +       if (tp->reg_access_reset_count < REGISTER_ACCESS_MAX_RESETS) {
> +               usb_queue_reset_device(tp->intf);
> +               tp->reg_access_reset_count++;
> +       } else if (tp->reg_access_reset_count =3D=3D REGISTER_ACCESS_MAX_=
RESETS) {
> +               dev_err(&udev->dev,
> +                       "Tried to reset %d times; giving up.\n",
> +                       REGISTER_ACCESS_MAX_RESETS);
> +       }
> +
> +       return ret;
> +}
> +
>  static
>  int get_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void=
 *data)
>  {
> @@ -1210,9 +1305,10 @@ int get_registers(struct r8152 *tp, u16 value, u16=
 index, u16 size, void *data)
>         if (!tmp)
>                 return -ENOMEM;
>
> -       ret =3D usb_control_msg(tp->udev, tp->pipe_ctrl_in,
> -                             RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
> -                             value, index, tmp, size, USB_CTRL_GET_TIMEO=
UT);
> +       ret =3D r8152_control_msg(tp, tp->pipe_ctrl_in,
> +                               RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
> +                               value, index, tmp, size, "read");
> +
>         if (ret < 0)
>                 memset(data, 0xff, size);
>         else
> @@ -1233,9 +1329,9 @@ int set_registers(struct r8152 *tp, u16 value, u16 =
index, u16 size, void *data)
>         if (!tmp)
>                 return -ENOMEM;
>
> -       ret =3D usb_control_msg(tp->udev, tp->pipe_ctrl_out,
> -                             RTL8152_REQ_SET_REGS, RTL8152_REQT_WRITE,
> -                             value, index, tmp, size, USB_CTRL_SET_TIMEO=
UT);
> +       ret =3D r8152_control_msg(tp, tp->pipe_ctrl_out,
> +                               RTL8152_REQ_SET_REGS, RTL8152_REQT_WRITE,
> +                               value, index, tmp, size, "write");
>
>         kfree(tmp);
>
> @@ -1244,10 +1340,8 @@ int set_registers(struct r8152 *tp, u16 value, u16=
 index, u16 size, void *data)
>
>  static void rtl_set_unplug(struct r8152 *tp)
>  {
> -       if (tp->udev->state =3D=3D USB_STATE_NOTATTACHED) {
> -               set_bit(RTL8152_INACCESSIBLE, &tp->flags);
> -               smp_mb__after_atomic();
> -       }
> +       if (tp->udev->state =3D=3D USB_STATE_NOTATTACHED)
> +               rtl_set_inaccessible(tp);
>  }
>
>  static int generic_ocp_read(struct r8152 *tp, u16 index, u16 size,
> @@ -8262,7 +8356,7 @@ static int rtl8152_pre_reset(struct usb_interface *=
intf)
>         struct r8152 *tp =3D usb_get_intfdata(intf);
>         struct net_device *netdev;
>
> -       if (!tp)
> +       if (!tp || !test_bit(PROBED_WITH_NO_ERRORS, &tp->flags))
>                 return 0;
>
>         netdev =3D tp->netdev;
> @@ -8277,7 +8371,9 @@ static int rtl8152_pre_reset(struct usb_interface *=
intf)
>         napi_disable(&tp->napi);
>         if (netif_carrier_ok(netdev)) {
>                 mutex_lock(&tp->control);
> +               set_bit(IN_PRE_RESET, &tp->flags);
>                 tp->rtl_ops.disable(tp);
> +               clear_bit(IN_PRE_RESET, &tp->flags);
>                 mutex_unlock(&tp->control);
>         }
>
> @@ -8290,9 +8386,11 @@ static int rtl8152_post_reset(struct usb_interface=
 *intf)
>         struct net_device *netdev;
>         struct sockaddr sa;
>
> -       if (!tp)
> +       if (!tp || !test_bit(PROBED_WITH_NO_ERRORS, &tp->flags))
>                 return 0;
>
> +       rtl_set_accessible(tp);
> +
>         /* reset the MAC address in case of policy change */
>         if (determine_ethernet_addr(tp, &sa) >=3D 0) {
>                 rtnl_lock();
> @@ -9494,17 +9592,29 @@ static u8 __rtl_get_hw_ver(struct usb_device *ude=
v)
>         __le32 *tmp;
>         u8 version;
>         int ret;
> +       int i;
>
>         tmp =3D kmalloc(sizeof(*tmp), GFP_KERNEL);
>         if (!tmp)
>                 return 0;
>
> -       ret =3D usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
> -                             RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
> -                             PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp),
> -                             USB_CTRL_GET_TIMEOUT);
> -       if (ret > 0)
> -               ocp_data =3D (__le32_to_cpu(*tmp) >> 16) & VERSION_MASK;
> +       /* Retry up to 3 times in case there is a transitory error. We do=
 this
> +        * since retrying a read of the version is always safe and this
> +        * function doesn't take advantage of r8152_control_msg().
> +        */
> +       for (i =3D 0; i < 3; i++) {
> +               ret =3D usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
> +                                     RTL8152_REQ_GET_REGS, RTL8152_REQT_=
READ,
> +                                     PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof=
(*tmp),
> +                                     USB_CTRL_GET_TIMEOUT);
> +               if (ret > 0) {
> +                       ocp_data =3D (__le32_to_cpu(*tmp) >> 16) & VERSIO=
N_MASK;
> +                       break;
> +               }
> +       }
> +
> +       if (i !=3D 0 && ret > 0)
> +               dev_warn(&udev->dev, "Needed %d retries to read version\n=
", i);
>
>         kfree(tmp);
>
> @@ -9603,25 +9713,14 @@ static bool rtl8152_supports_lenovo_macpassthru(s=
truct usb_device *udev)
>         return 0;
>  }
>
> -static int rtl8152_probe(struct usb_interface *intf,
> -                        const struct usb_device_id *id)
> +static int rtl8152_probe_once(struct usb_interface *intf,
> +                             const struct usb_device_id *id, u8 version)
>  {
>         struct usb_device *udev =3D interface_to_usbdev(intf);
>         struct r8152 *tp;
>         struct net_device *netdev;
> -       u8 version;
>         int ret;
>
> -       if (intf->cur_altsetting->desc.bInterfaceClass !=3D USB_CLASS_VEN=
DOR_SPEC)
> -               return -ENODEV;
> -
> -       if (!rtl_check_vendor_ok(intf))
> -               return -ENODEV;
> -
> -       version =3D rtl8152_get_version(intf);
> -       if (version =3D=3D RTL_VER_UNKNOWN)
> -               return -ENODEV;
> -
>         usb_reset_device(udev);
>         netdev =3D alloc_etherdev(sizeof(struct r8152));
>         if (!netdev) {
> @@ -9784,10 +9883,20 @@ static int rtl8152_probe(struct usb_interface *in=
tf,
>         else
>                 device_set_wakeup_enable(&udev->dev, false);
>
> +       /* If we saw a control transfer error while probing then we may
> +        * want to try probe() again. Consider this an error.
> +        */
> +       if (test_bit(PROBE_SHOULD_RETRY, &tp->flags))
> +               goto out2;
> +
> +       set_bit(PROBED_WITH_NO_ERRORS, &tp->flags);
>         netif_info(tp, probe, netdev, "%s\n", DRIVER_VERSION);
>
>         return 0;
>
> +out2:
> +       unregister_netdev(netdev);
> +
>  out1:
>         tasklet_kill(&tp->tx_tl);
>         cancel_delayed_work_sync(&tp->hw_phy_work);
> @@ -9796,10 +9905,46 @@ static int rtl8152_probe(struct usb_interface *in=
tf,
>         rtl8152_release_firmware(tp);
>         usb_set_intfdata(intf, NULL);
>  out:
> +       if (test_bit(PROBE_SHOULD_RETRY, &tp->flags))
> +               ret =3D -EAGAIN;
> +
>         free_netdev(netdev);
>         return ret;
>  }
>
> +#define RTL8152_PROBE_TRIES    3
> +
> +static int rtl8152_probe(struct usb_interface *intf,
> +                        const struct usb_device_id *id)
> +{
> +       u8 version;
> +       int ret;
> +       int i;
> +
> +       if (intf->cur_altsetting->desc.bInterfaceClass !=3D USB_CLASS_VEN=
DOR_SPEC)
> +               return -ENODEV;
> +
> +       if (!rtl_check_vendor_ok(intf))
> +               return -ENODEV;
> +
> +       version =3D rtl8152_get_version(intf);
> +       if (version =3D=3D RTL_VER_UNKNOWN)
> +               return -ENODEV;
> +
> +       for (i =3D 0; i < RTL8152_PROBE_TRIES; i++) {
> +               ret =3D rtl8152_probe_once(intf, id, version);
> +               if (ret !=3D -EAGAIN)
> +                       break;
> +       }
> +       if (ret =3D=3D -EAGAIN) {
> +               dev_err(&intf->dev,
> +                       "r8152 failed probe after %d tries; giving up\n",=
 i);
> +               return -ENODEV;
> +       }
> +
> +       return ret;
> +}
> +
>  static void rtl8152_disconnect(struct usb_interface *intf)
>  {
>         struct r8152 *tp =3D usb_get_intfdata(intf);
> --
> 2.42.0.758.gaed0368e0e-goog
>
