Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3716679C847
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjILHhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjILHhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:37:14 -0400
X-Greylist: delayed 848 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Sep 2023 00:37:09 PDT
Received: from dilbert.mork.no (dilbert.mork.no [IPv6:2a01:4f9:c010:a439::d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CECBE78;
        Tue, 12 Sep 2023 00:37:09 -0700 (PDT)
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:964:4b04:3697:f6ff:fe5d:314])
        (authenticated bits=0)
        by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 38C7MVW12686926
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 08:22:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1694503346; bh=2F4nqnLzYY063JtRlfe21BiVQR+M9A0W69yALeokWvs=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=ImO84iC69OmMNjz2XpsjCSFqwkSdAB0J5JaPvmubDiDVxqddiQYjA5MauV3Y1SWF9
         rcl7MTArjTrz3lLDAAI04uRAhj8fi0bNmoWWhph7hqnaf4xPfTd15MnbckYbb2LVFd
         OsCl7iAc28X79JgRlCeTPEp+0XGVNQ6fQToaLRnw=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e0:8300:13c:9450:7f1:fd90])
        (authenticated bits=0)
        by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 38C7MPUc110735
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 09:22:25 +0200
Received: (nullmailer pid 135215 invoked by uid 1000);
        Tue, 12 Sep 2023 07:22:20 -0000
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Stefan x Nilsson <stefan.x.nilsson@axis.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>
Subject: Re: [PATCH net-next] qmi_wwan: Add rawip module param
Organization: m
References: <20230912-qmiraw-v1-1-21bc812fa0cf@axis.com>
Date:   Tue, 12 Sep 2023 09:22:20 +0200
In-Reply-To: <20230912-qmiraw-v1-1-21bc812fa0cf@axis.com> (Stefan x. Nilsson's
        message of "Tue, 12 Sep 2023 09:04:13 +0200")
Message-ID: <87a5tramab.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.1 at canardo
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan x Nilsson <stefan.x.nilsson@axis.com> writes:

> Certain QMI modems will start communicating in rawip mode after
> bootup, and will not work properly if communication starts off in
> ethernet mode. So add a module parameter, rawip_as_default, that
> can be used to load the qmi driver in rawip mode.
>
> The advantage compared to changing rawip at a later point using
> sysfs is that the os will not detect the device and start talking
> to it while the driver is still in incorrect mode.
>
> Signed-off-by: Stefan x Nilsson <stefan.x.nilsson@axis.com>
> ---
>  drivers/net/usb/qmi_wwan.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> index 344af3c5c836..968c60ececf8 100644
> --- a/drivers/net/usb/qmi_wwan.c
> +++ b/drivers/net/usb/qmi_wwan.c
> @@ -46,6 +46,10 @@
>   * commands on a serial interface
>   */
>=20=20
> +/* Module parameters */
> +static bool rawip_as_default;
> +module_param(rawip_as_default, bool, 0644);
> +
>  /* driver specific data */
>  struct qmi_wwan_state {
>  	struct usb_driver *subdriver;
> @@ -843,6 +847,13 @@ static int qmi_wwan_bind(struct usbnet *dev, struct =
usb_interface *intf)
>  	}
>  	dev->net->netdev_ops =3D &qmi_wwan_netdev_ops;
>  	dev->net->sysfs_groups[0] =3D &qmi_wwan_sysfs_attr_group;
> +
> +	/* Set the driver into rawip mode if requested by module param */
> +	if (rawip_as_default) {
> +		info->flags |=3D QMI_WWAN_FLAG_RAWIP;
> +		qmi_wwan_netdev_setup(dev->net);
> +	}
> +
>  err:
>  	return status;
>  }
>

NAK

There is no reason to start communicating with the device before
changing the framing, using the existing sysfs interface.

This seems to be a workaround for some userspace bug.  I don't think we
yet another userspace knob for that.  And certainly not one that applies
to every device.



Bj=C3=B8rn
