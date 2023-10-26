Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51F37D79FA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjJZBKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZBKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:10:36 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDB6185;
        Wed, 25 Oct 2023 18:10:30 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5a9d8f4388bso287176a12.3;
        Wed, 25 Oct 2023 18:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698282629; x=1698887429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUBzpVkpLNbFtNYzSQ/dT5Sjq1MjfN+aNZ944u0NjPo=;
        b=K5Z5/rmRwr1rdUeYKzu0B8WMWsYDF/jRGV8zR62hs2Ex1SkN1hdI9kFPWhH1PubQB1
         VZHgck99ZIgOwTsqNjExzgdto8eqpLsxZjiNA/NeLet1I+P23ofMWmqTFlSKj9bMeTrs
         1DHD1KyGuUThGtsxTOXha+7ozeKrAAUrHvfSaSy1w2OH5sfmZz5dR2IHqEI8Ng2WJvfi
         CbIzo67jnz8KT5rHe1fHxW5VtUKm5UzEujUCZ38iLFb1kv3c2mWyyMY+ouNZiNNTR2xG
         2okdegzd/SRb4AaDIMFtOaM0WbCT2TV5RsAZ9wdL7eG4XM9zFQoi2EtsQVk75h/SNPA2
         3gMQ==
X-Gm-Message-State: AOJu0YxetgCXVfl9Na9g9yLW0qOCL9ac8APfKbpllk/VA+GlvUUHYMan
        l/Y+kGk06PoQsbY3Z9hoSlZoQW2pcHFjGKlX5ek=
X-Google-Smtp-Source: AGHT+IFghLohp38PK4DehAbPkA0QbQNd22/PDnBx04SWDGz3PaMK3OjoQoWT1RcYSqunvgwXsOOds0pbz0ziEDbH/r4=
X-Received: by 2002:a17:90a:dc0d:b0:27d:a94e:607f with SMTP id
 i13-20020a17090adc0d00b0027da94e607fmr13985898pjv.43.1698282629027; Wed, 25
 Oct 2023 18:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231025173300.1776832-1-florian.fainelli@broadcom.com> <20231025173300.1776832-5-florian.fainelli@broadcom.com>
In-Reply-To: <20231025173300.1776832-5-florian.fainelli@broadcom.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 26 Oct 2023 10:10:17 +0900
Message-ID: <CAMZ6RqJJXK5EyyOwXXbdA-bDTY=_JQ+xfKpoCHDJZqv+rNnASQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] net: phy: broadcom: Add support for WAKE_FILTER
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        Willem de Bruijn <willemb@google.com>,
        Daniil Tatianin <d-tatianin@yandex-team.ru>,
        Simon Horman <horms@kernel.org>,
        Justin Chen <justin.chen@broadcom.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Joe Damato <jdamato@fastly.com>, Jiri Pirko <jiri@resnulli.us>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Thu. 26 Oct. 2023 at 02:32, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
> Since the PHY is capable of matching any arbitrary Ethernet MAC
> destination as a programmable wake-up pattern, add support for doing
> that using the WAKE_FILTER and ethtool::rxnfc API. For instance, in
> order to wake-up from the Ethernet MAC address corresponding to the IPv4
> multicast IP address of 224.0.0.251 (e.g.: multicast DNS), one could do:
>
> ethtool -N eth0 flow-type ether dst 01:00:5e:00:00:fb loc 0 action -2
> ethtool -n eth0
> Total 1 rules
>
> Filter: 0
>         Flow Type: Raw Ethernet
>         Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
>         Dest MAC addr: 01:00:5E:00:00:FB mask: 00:00:00:00:00:00
>         Ethertype: 0x0 mask: 0xFFFF
>         Action: Wake-on-LAN
> ethtool -s eth0 wol f

Nit: indent the commands and their output with two spaces.

> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/phy/bcm-phy-lib.c | 195 +++++++++++++++++++++++++++++++++-
>  drivers/net/phy/bcm-phy-lib.h |   5 +
>  drivers/net/phy/broadcom.c    |   2 +
>  3 files changed, 201 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
> index 876f28fd8256..cfbeedc5ee81 100644
> --- a/drivers/net/phy/bcm-phy-lib.c
> +++ b/drivers/net/phy/bcm-phy-lib.c
> @@ -827,7 +827,8 @@ EXPORT_SYMBOL_GPL(bcm_phy_cable_test_get_status_rdb);
>                                          WAKE_MCAST | \
>                                          WAKE_BCAST | \
>                                          WAKE_MAGIC | \
> -                                        WAKE_MAGICSECURE)
> +                                        WAKE_MAGICSECURE | \
> +                                        WAKE_FILTER)

Nit: you may want to have the closing bracket on a newline to have a
cleaner diff for new future additions.

>  int bcm_phy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
>  {
> @@ -881,6 +882,12 @@ int bcm_phy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
>         ctl &= ~BCM54XX_WOL_DIR_PKT_EN;
>         ctl &= ~(BCM54XX_WOL_SECKEY_OPT_MASK << BCM54XX_WOL_SECKEY_OPT_SHIFT);
>
> +       /* For WAKE_FILTER, we have already programmed the desired MAC DA
> +        * and associated mask by the time we get there.
> +        */
> +       if (wol->wolopts & WAKE_FILTER)
> +               goto program_ctl;
> +
>         /* When using WAKE_MAGIC, we program the magic pattern filter to match
>          * the device's MAC address and we accept any MAC DA in the Ethernet
>          * frame.
> @@ -935,6 +942,7 @@ int bcm_phy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
>                         return ret;
>         }
>
> +program_ctl:
>         if (wol->wolopts & WAKE_MAGICSECURE) {
>                 ctl |= BCM54XX_WOL_SECKEY_OPT_6B <<
>                        BCM54XX_WOL_SECKEY_OPT_SHIFT;
> @@ -999,6 +1007,16 @@ void bcm_phy_get_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
>         if (!(ctl & BCM54XX_WOL_EN))
>                 return;
>
> +       ret = bcm_phy_read_exp(phydev, BCM54XX_WOL_SEC_KEY_8B);
> +       if (ret < 0)
> +               return;
> +
> +       /* Mutualy exclusive with other modes */
> +       if (ret) {
> +               wol->wolopts |= WAKE_FILTER;
> +               return;
> +       }
> +
>         for (i = 0; i < sizeof(da) / 2; i++) {
>                 ret = bcm_phy_read_exp(phydev,
>                                        BCM54XX_WOL_MPD_DATA2(2 - i));
> @@ -1066,6 +1084,181 @@ int bcm_phy_led_brightness_set(struct phy_device *phydev,
>  }
>  EXPORT_SYMBOL_GPL(bcm_phy_led_brightness_set);
>
> +static int bcm_phy_get_rule(struct phy_device *phydev,
> +                           struct ethtool_rxnfc *nfc,
> +                           int loc)
> +{
> +       u8 da[ETH_ALEN];
> +       unsigned int i;
> +       int ret;
> +
> +       if (loc != 0)
> +               return -EINVAL;
> +
> +       memset(nfc, 0, sizeof(*nfc));
> +       nfc->flow_type = ETHER_FLOW;
> +       nfc->fs.flow_type = ETHER_FLOW;
> +
> +       for (i = 0; i < sizeof(da) / 2; i++) {
> +               ret = bcm_phy_read_exp(phydev,
> +                                      BCM54XX_WOL_MPD_DATA2(2 - i));
> +               if (ret < 0)
> +                       return ret;
> +
> +               da[i * 2] = ret >> 8;
> +               da[i * 2 + 1] = ret & 0xff;

This looks like an endianness conversion (I can not tell if this is
big to little or the opposite)...

> +       }
> +       ether_addr_copy(nfc->fs.h_u.ether_spec.h_dest, da);
> +
> +       for (i = 0; i < sizeof(da) / 2; i++) {
> +               ret = bcm_phy_read_exp(phydev,
> +                                      BCM54XX_WOL_MASK(2 - i));
> +               if (ret < 0)
> +                       return ret;
> +
> +               da[i * 2] = ~(ret >> 8);
> +               da[i * 2 + 1] = ~(ret & 0xff);
> +       }
> +       ether_addr_copy(nfc->fs.m_u.ether_spec.h_dest, da);
> +
> +       ret = bcm_phy_read_exp(phydev, BCM54XX_WOL_INNER_PROTO);
> +       if (ret < 0)
> +               return ret;
> +
> +       nfc->fs.h_u.ether_spec.h_proto = be16_to_cpu(ret);

... but here it is big endian to cpu endian? It does not look coherent.

Also, did you run parse to check your endianness conversions?

  https://www.kernel.org/doc/html/latest/dev-tools/sparse.html

For example, I would have expected htons() (a.k.a. cpu_to_be16())
instead of be16_to_cpu().

> +       nfc->fs.ring_cookie = RX_CLS_FLOW_WAKE;
> +       nfc->fs.location = 0;
> +
> +       return 0;
> +}
> +
> +static int bcm_phy_set_rule(struct phy_device *phydev,
> +                           struct ethtool_rxnfc *nfc)
> +{
> +       int ret = -EOPNOTSUPP;
> +       unsigned int i;
> +       __be16 h_proto;
> +       const u8 *da;
> +
> +       /* We support only matching on the MAC DA with a custom mask and
> +        * optionally with a specific Ethernet type, reject anything else.
> +        */
> +       if (nfc->fs.ring_cookie != RX_CLS_FLOW_WAKE ||
> +           (nfc->fs.location != 0 &&
> +            nfc->fs.location != RX_CLS_LOC_ANY &&
> +            nfc->fs.location != RX_CLS_LOC_FIRST) ||
> +           nfc->fs.flow_type != ETHER_FLOW ||
> +           !is_zero_ether_addr(nfc->fs.h_u.ether_spec.h_source) ||
> +           !is_zero_ether_addr(nfc->fs.m_u.ether_spec.h_source))
> +               return ret;
> +
> +       ret = bcm_phy_read_exp(phydev, BCM54XX_WOL_SEC_KEY_8B);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (ret)
> +               return -EBUSY;
> +
> +       if (nfc->fs.location == RX_CLS_LOC_ANY ||
> +           nfc->fs.location == RX_CLS_LOC_FIRST)
> +               nfc->fs.location = 0;
> +
> +       da = nfc->fs.h_u.ether_spec.h_dest;
> +       for (i = 0; i < ETH_ALEN / 2; i++) {
> +               ret = bcm_phy_write_exp(phydev,
> +                                       BCM54XX_WOL_MPD_DATA2(2 - i),
> +                                       da[i * 2] << 8 | da[i * 2 + 1]);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       da = nfc->fs.m_u.ether_spec.h_dest;
> +       for (i = 0; i < ETH_ALEN / 2; i++) {
> +               ret = bcm_phy_write_exp(phydev,
> +                                       BCM54XX_WOL_MASK(2 - i),
> +                                       da[i * 2] << 8 | da[i * 2 + 1]);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       /* Restore default inner protocol field unless overridden by the flow
> +        * specification.
> +        */
> +       h_proto = be16_to_cpu(nfc->fs.h_u.ether_spec.h_proto);
> +       if (!h_proto)
> +               h_proto = ETH_P_8021Q;
> +
> +       ret = bcm_phy_write_exp(phydev, BCM54XX_WOL_INNER_PROTO,
> +                               h_proto);
> +       if (ret)
> +               return ret;
> +
> +       /* Use BCM54XX_WOL_SEC_KEY_8B as a scratch register to record
> +        * that we installed a filter rule.
> +        */
> +       return bcm_phy_write_exp(phydev, BCM54XX_WOL_SEC_KEY_8B, 1);
> +}
> +
> +int bcm_phy_get_rxnfc(struct phy_device *phydev,
> +                     struct ethtool_rxnfc *cmd, u32 *rule_locs)
> +{
> +       int err = 0, rule_cnt = 0;
> +
> +       err = bcm_phy_read_exp(phydev, BCM54XX_WOL_SEC_KEY_8B);
> +       if (err < 0)
> +               return err;
> +
> +       rule_cnt = err;
> +       err = 0;
> +
> +       switch (cmd->cmd) {
> +       case ETHTOOL_GRXCLSRLCNT:
> +               cmd->rule_cnt = rule_cnt;
> +               cmd->data = 1 | RX_CLS_LOC_SPECIAL;
> +               break;
> +       case ETHTOOL_GRXCLSRULE:
> +               err = bcm_phy_get_rule(phydev, cmd, cmd->fs.location);
> +               break;
> +       case ETHTOOL_GRXCLSRLALL:
> +               if (rule_cnt)
> +                       rule_locs[0] = 0;
> +               cmd->rule_cnt = rule_cnt;
> +               cmd->data = 1;
> +               break;
> +       default:
> +               err = -EOPNOTSUPP;
> +               break;
> +       }
> +
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(bcm_phy_get_rxnfc);
> +
> +int bcm_phy_set_rxnfc(struct phy_device *phydev,
> +                     struct ethtool_rxnfc *cmd)
> +{
> +       int err = 0;
> +
> +       switch (cmd->cmd) {
> +       case ETHTOOL_SRXCLSRLINS:
> +               err = bcm_phy_set_rule(phydev, cmd);
> +               break;
> +       case ETHTOOL_SRXCLSRLDEL:
> +               if (cmd->fs.location != 0)
> +                       return err;
> +
> +               err = bcm_phy_write_exp(phydev, BCM54XX_WOL_SEC_KEY_8B, 0);
> +               break;
> +       default:
> +               err = -EOPNOTSUPP;
> +               break;
> +       }
> +
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(bcm_phy_set_rxnfc);
> +
>  MODULE_DESCRIPTION("Broadcom PHY Library");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Broadcom Corporation");
> diff --git a/drivers/net/phy/bcm-phy-lib.h b/drivers/net/phy/bcm-phy-lib.h
> index b52189e45a84..7081edcec06b 100644
> --- a/drivers/net/phy/bcm-phy-lib.h
> +++ b/drivers/net/phy/bcm-phy-lib.h
> @@ -121,4 +121,9 @@ irqreturn_t bcm_phy_wol_isr(int irq, void *dev_id);
>  int bcm_phy_led_brightness_set(struct phy_device *phydev,
>                                u8 index, enum led_brightness value);
>
> +int bcm_phy_get_rxnfc(struct phy_device *phydev,
> +                     struct ethtool_rxnfc *nfc, u32 *rule_locs);
> +int bcm_phy_set_rxnfc(struct phy_device *phydev,
> +                     struct ethtool_rxnfc *nfc);
> +
>  #endif /* _LINUX_BCM_PHY_LIB_H */
> diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
> index 3a627105675a..6c2212bd2779 100644
> --- a/drivers/net/phy/broadcom.c
> +++ b/drivers/net/phy/broadcom.c
> @@ -1107,6 +1107,8 @@ static struct phy_driver broadcom_drivers[] = {
>         .get_wol        = bcm54xx_phy_get_wol,
>         .set_wol        = bcm54xx_phy_set_wol,
>         .led_brightness_set     = bcm_phy_led_brightness_set,
> +       .get_rxnfc      = bcm_phy_get_rxnfc,
> +       .set_rxnfc      = bcm_phy_set_rxnfc,
>  }, {
>         .phy_id         = PHY_ID_BCM5461,
>         .phy_id_mask    = 0xfffffff0,
> --
> 2.34.1
>
