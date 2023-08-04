Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F85776FB09
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjHDHVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjHDHVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:21:42 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBEF35B5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:21:40 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-407db3e9669so151161cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 00:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691133700; x=1691738500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWW3ABIHQi6sSRhQFBIuC8dDMRNhoaTSKtIySe9XQwo=;
        b=oalSL2Nj2569hNGzaA4ZUGPRlQEU1mpkdPlYh8vxIfXVsFE6u8KYUb6gR+B4DGci4+
         HrBKbVmA1+lH2OrAa/TtwzzVpW4/hfirAbWyRIujzAFX43m8I6EKlmI7/ZTAzvfk6Jkb
         hnTWcQoyyeS/Htz6uLrJ8ix8aR5MKieSoMqjxiZIndf396Sx0OPSqjalZ1K9V9RvnzIz
         UaQMKg4YWlhaJlUpAlTNy1vpQAkJHD8hlCgTVGfTHah4pmUcJPG50mU8SjxW5XxbCJMK
         WFMzLUgmlw/o0f+tldwIlIkyjfvBR6yrWlaxxj3ze+hoxJYmvRKoC5fBhRX8Y2Ak6F6q
         u/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691133700; x=1691738500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWW3ABIHQi6sSRhQFBIuC8dDMRNhoaTSKtIySe9XQwo=;
        b=OFp2NwRGQsfMthlLDHVK22nct3qv27CxsxfFALZieBOLTFzXN5WOEdX+i/Z1dExllz
         iLPNtS3/UHrFvswIsW9OgG+mxmDiDFFwIsHOHt8+oOogPz6QMySQRZeTzRZqd0bFkCMs
         0RLtfHe0EgSMSK96TWk0UEf0qJcIEDUTozo3h8PbDaHQCFTCGbC2UG+AEG8hydo4cxKI
         420ZmgWFNEU8B+sESngfZP+S512H2AKwY0feRTzVE3GCLihXt9VksY7De3NNZU6y5Z6U
         IcBqrygz0tJbouXGfR8krYIAuKB2XzzI/qgMZnT/pw15c1olwgFtvQhnOCoNVQnabP2L
         qQ3Q==
X-Gm-Message-State: AOJu0YyRdneztrzdcNbI7gQUokjJ1OVsupVYcgWzX6Zsh/mWFOozjPuk
        bnxB8PpymBadjps3qWpwIrNUPy8E2bEE2+OzZijiGg==
X-Google-Smtp-Source: AGHT+IHW0Yl7enhTDicLoDmaectlTTgexjAtstb98uUxc03BXJCt5zmKWK8uPqo10EcW3WemN9TF9eGWe9UjKkZccck=
X-Received: by 2002:a05:622a:1827:b0:403:eeb9:a76 with SMTP id
 t39-20020a05622a182700b00403eeb90a76mr107512qtc.17.1691133699862; Fri, 04 Aug
 2023 00:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230801142824.1772134-1-vladimir.oltean@nxp.com> <20230801142824.1772134-13-vladimir.oltean@nxp.com>
In-Reply-To: <20230801142824.1772134-13-vladimir.oltean@nxp.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 4 Aug 2023 09:21:28 +0200
Message-ID: <CANn89iLOspJsvjPj+y8jikg7erXDomWe8sqHMdfL_2LQSFrPAg@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 12/12] net: remove phy_has_hwtstamp() ->
 phy_mii_ioctl() decision from converted drivers
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxim Georgiev <glipus@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        UNGLinuxDriver@microchip.com,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        Casper Andersson <casper.casan@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 4:29=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nxp=
.com> wrote:
>
> It is desirable that the new .ndo_hwtstamp_set() API gives more
> uniformity, less overhead and future flexibility w.r.t. the PHY
> timestamping behavior.
>
> Currently there are some drivers which allow PHY timestamping through
> the procedure mentioned in Documentation/networking/timestamping.rst.
> They don't do anything locally if phy_has_hwtstamp() is set, except for
> lan966x which installs PTP packet traps.
>
> Centralize that behavior in a new dev_set_hwtstamp_phylib() code
> function, which calls either phy_mii_ioctl() for the phylib PHY,
> or .ndo_hwtstamp_set() of the netdev, based on a single policy
> (currently simplistic: phy_has_hwtstamp()).
>
> Any driver converted to .ndo_hwtstamp_set() will automatically opt into
> the centralized phylib timestamping policy. Unconverted drivers still
> get to choose whether they let the PHY handle timestamping or not.
>
> Netdev drivers with integrated PHY drivers that don't use phylib
> presumably don't set dev->phydev, and those will always see
> HWTSTAMP_SOURCE_NETDEV requests even when converted. The timestamping
> policy will remain 100% up to them.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---


> +/**
> + * dev_set_hwtstamp_phylib() - Change hardware timestamping of NIC
> + *     or of attached phylib PHY
> + * @dev: Network device
> + * @cfg: Timestamping configuration structure
> + * @extack: Netlink extended ack message structure, for error reporting
> + *
> + * Helper for enforcing a common policy that phylib timestamping, if ava=
ilable,
> + * should take precedence in front of hardware timestamping provided by =
the
> + * netdev. If the netdev driver needs to perform specific actions even f=
or PHY
> + * timestamping to work properly (a switch port must trap the timestampe=
d
> + * frames and not forward them), it must set IFF_SEE_ALL_HWTSTAMP_REQUES=
TS in
> + * dev->priv_flags.
> + */
> +static int dev_set_hwtstamp_phylib(struct net_device *dev,
> +                                  struct kernel_hwtstamp_config *cfg,
> +                                  struct netlink_ext_ack *extack)
> +{
> +       const struct net_device_ops *ops =3D dev->netdev_ops;
> +       bool phy_ts =3D phy_has_hwtstamp(dev->phydev);
> +       struct kernel_hwtstamp_config old_cfg =3D {};
> +       bool changed =3D false;
> +       int err;
> +
> +       cfg->source =3D phy_ts ? HWTSTAMP_SOURCE_PHYLIB : HWTSTAMP_SOURCE=
_NETDEV;
> +
> +       if (!phy_ts || (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS))=
 {
> +               err =3D ops->ndo_hwtstamp_get(dev, &old_cfg);

old_cfg.ifr is NULL at this point.

This causes a crash later in generic_hwtstamp_ioctl_lower()

    ifrr.ifr_ifru =3D kernel_cfg->ifr->ifr_ifru;



> +               if (err)
> +                       return err;
> +
> +               err =3D ops->ndo_hwtstamp_set(dev, cfg, extack);
> +               if (err) {
> +                       if (extack->_msg)
> +                               netdev_err(dev, "%s\n", extack->_msg);
> +                       return err;
> +               }
> +
> +               changed =3D kernel_hwtstamp_config_changed(&old_cfg, cfg)=
;
> +       }
> +
> +       if (phy_ts) {
> +               err =3D phy_hwtstamp_set(dev->phydev, cfg, extack);
> +               if (err) {
> +                       if (changed)
> +                               ops->ndo_hwtstamp_set(dev, &old_cfg, NULL=
);
> +                       return err;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
>  {
>         const struct net_device_ops *ops =3D dev->netdev_ops;
> @@ -314,12 +392,9 @@ static int dev_set_hwtstamp(struct net_device *dev, =
struct ifreq *ifr)
>         if (!netif_device_present(dev))
>                 return -ENODEV;
>
> -       err =3D ops->ndo_hwtstamp_set(dev, &kernel_cfg, &extack);
> -       if (err) {
> -               if (extack._msg)
> -                       netdev_err(dev, "%s\n", extack._msg);
> +       err =3D dev_set_hwtstamp_phylib(dev, &kernel_cfg, &extack);
> +       if (err)
>                 return err;
> -       }
>
>         /* The driver may have modified the configuration, so copy the
>          * updated version of it back to user space
> @@ -362,7 +437,7 @@ int generic_hwtstamp_get_lower(struct net_device *dev=
,
>                 return -ENODEV;
>
>         if (ops->ndo_hwtstamp_get)
> -               return ops->ndo_hwtstamp_get(dev, kernel_cfg);
> +               return dev_get_hwtstamp_phylib(dev, kernel_cfg);
>
>         /* Legacy path: unconverted lower driver */
>         return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cf=
g);
> @@ -379,7 +454,7 @@ int generic_hwtstamp_set_lower(struct net_device *dev=
,
>                 return -ENODEV;
>
>         if (ops->ndo_hwtstamp_set)
> -               return ops->ndo_hwtstamp_set(dev, kernel_cfg, extack);
> +               return dev_set_hwtstamp_phylib(dev, kernel_cfg, extack);
>
>         /* Legacy path: unconverted lower driver */
>         return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cf=
g);
> --
> 2.34.1
>
