Return-Path: <linux-kernel+bounces-72980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A350785BB65
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ADBE1F21A86
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1EB67C72;
	Tue, 20 Feb 2024 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab1jXw5H"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ECB67C45;
	Tue, 20 Feb 2024 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430795; cv=none; b=EreZWmQN871/TnUQSreJm+HAYXavsDwbp8sl1OG4dE9Y65TjIQtymbg5ycYIukS9UrndalQXfeZcSVqHSkBM9m0pbEs1L8PGe3uzLzJSotPNGIeKXtzx0OgYXblaWSpcxjBFSK5vdJe9wlwuP2wPJm/O1siBgOpXQg2ZmXTRl74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430795; c=relaxed/simple;
	bh=riAdh2zfn5aUz38o2wFqh8SrdVt9gjidHDa1oh4Zffg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogUA+chksjoaQBRSOyk4R8JObkr6yoUw9R4Uj5YW4QL/9yzd/LApjbUPV3s8yZJwAah5Ylqez4nTeH8gBIonfcc2mkHhSxQ/TNOn8rFiFZT9FNDt2NE2IL5YxDNaRlnNuGl6QdSkkTroRsmdxglX7dAFHM9U4s9p9/hdKnKCU3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ab1jXw5H; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c15d1bd5b1so1302371b6e.1;
        Tue, 20 Feb 2024 04:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708430792; x=1709035592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpCwEWmqYxExWudFAlJ5ocQ0Dz0cVCknGFlhgO/htME=;
        b=Ab1jXw5H/jJktGQh/CHfLZuy19fRu1wB/LLOUKsNXFy2t5MGNL+6m182mb0E7inJMx
         +P9Ni0lRs55ZTSv828NlpGiqhqhZcnCScHs3Hb/azPejvJov5gdfrw20jlwvhazNr9D+
         DWXOWFt7lPzQt+5duhEB9v1Vh8A3sv20/5u+yfdYk5Yw1TX6Lja5+7zC6a8/mPZrEo/V
         n3UJgRXSm2aimdVy/yGCUaTlcpQFDUa0wuTK8xwseJ/fFGjdL4D7IHYzEOHnW4vV8V6K
         VVFdXd6oys5Y1NiKrzCdYIds+1Uq3yUNKTd8V3FMX+uKLOPI310ikm2tt3MixC7M4x8V
         4+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708430792; x=1709035592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpCwEWmqYxExWudFAlJ5ocQ0Dz0cVCknGFlhgO/htME=;
        b=oxMsMTICOIx5Sdh/+7kFh7PslFXXx33BqQe/ibsIm44uu2NvRDXVNCi/byqU6o+joS
         96ev2NFveQgDKg0bVHZKSoqZPmdWXis7ftjfFBjuYfOkSRK21gC4gs0O9h6D1Cnjr1UH
         j8UsR8+uObZCQIj4xK7lsDEUXVUL52G7Wnc9clhUpTxN9nZs2xIUrSIdWdJhALq+MpdU
         0/y0ew3/Ju2bgULstGoRnCbqkLroPLKr2BOzcBmpgP5HWFC/VrqFCN+9VGFPGPBRKggv
         sERNEC3Y2SK5P25nLOa0ijBZWFfMmcHsXiEKHsnfnG9ZPAZre6GLBp1+fS9rh8PHN819
         y4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWidHYbkjVKb7dZ22lz6lU2btjBWSvogX02X9c8wbUm0mQl+cwY4G4lVlPKJc3hcyXhaE0D8DhiKPTBRBpZmyjBNoDflC+lFf5j6vla
X-Gm-Message-State: AOJu0Yx59KhxJoq1TOVl5jYvjUUT1fBDGbukPLnbkEV0nbBNpxXL/fII
	XI5kvHd6CGEQiCR9c1tU1BWCes78L8BBCf/70L0vOhb3uCZF6sWOy2aEXe2KysSoXH9HFCUYoa4
	AwE4V8w3YJ5ri/4fPaKN4U5wZPrE=
X-Google-Smtp-Source: AGHT+IHoBdtnSSlf8pvD3XS3IeefGooS/0PlYW8ptxpHLISso/56KiToNakHRuoBKXDeSUYHPeT4axXPVbEiHVawrEk=
X-Received: by 2002:a05:6808:220f:b0:3bf:fdb2:ca5b with SMTP id
 bd15-20020a056808220f00b003bffdb2ca5bmr18500215oib.3.1708430792242; Tue, 20
 Feb 2024 04:06:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-8-paweldembicki@gmail.com> <20240215172220.p7w2yyrveu7yd4w2@skbuf>
In-Reply-To: <20240215172220.p7w2yyrveu7yd4w2@skbuf>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Tue, 20 Feb 2024 13:06:20 +0100
Message-ID: <CAJN1KkwLmvu7FkWjgGs+VpqrW_ZT2Xqzr3YbmxmtZqCgYKKHiQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 07/15] net: dsa: vsc73xx: Add vlan filtering
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

czw., 15 lut 2024 o 18:22 Vladimir Oltean <olteanv@gmail.com> napisa=C5=82(=
a):
>
> On Tue, Feb 13, 2024 at 11:03:20PM +0100, Pawel Dembicki wrote:
> > This patch implements VLAN filtering for the vsc73xx driver.
> >
> > After starting VLAN filtering, the switch is reconfigured from QinQ to
> > a simple VLAN aware mode. This is required because VSC73XX chips do not
> > support inner VLAN tag filtering.
> >
> > Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> > ---
>
> This looks good, please keep working on it. I have a lot of comments
> below, but they are all minor and don't involve structural rework.
>
> > v4:
> >   - reworked most of conditional register configs
> >   - simplified port_vlan function
> >   - move vlan table clearing from port_setup to setup
> >   - pvid configuration simplified (now kernel take care about no of
> >     pvids per port)
> >   - port vlans are stored in list now
> >   - introduce implementation of all untagged vlans state
> >   - many minor changes
> > v3:
> >   - reworked all vlan commits
> >   - added storage variables for pvid and untagged vlans
> >   - move length extender settings to port setup
> >   - remove vlan table cleaning in wrong places
> > v2:
> >   - no changes done
> >
> >  drivers/net/dsa/vitesse-vsc73xx-core.c | 523 ++++++++++++++++++++++++-
> >  drivers/net/dsa/vitesse-vsc73xx.h      |  25 ++
> >  2 files changed, 546 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/v=
itesse-vsc73xx-core.c
> > index 1dca3c476fac..6c7bd1c200b4 100644
> > --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> > +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> > @@ -21,9 +21,11 @@
> >  #include <linux/of_mdio.h>
> >  #include <linux/bitops.h>
> >  #include <linux/if_bridge.h>
> > +#include <linux/if_vlan.h>
> >  #include <linux/etherdevice.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/gpio/driver.h>
> > +#include <linux/dsa/8021q.h>
> >  #include <linux/random.h>
> >  #include <net/dsa.h>
> >
> > @@ -61,6 +63,8 @@
> >  #define VSC73XX_CAT_DROP     0x6e
> >  #define VSC73XX_CAT_PR_MISC_L2       0x6f
> >  #define VSC73XX_CAT_PR_USR_PRIO      0x75
> > +#define VSC73XX_CAT_VLAN_MISC        0x79
> > +#define VSC73XX_CAT_PORT_VLAN        0x7a
> >  #define VSC73XX_Q_MISC_CONF  0xdf
> >
> >  /* MAC_CFG register bits */
> > @@ -121,6 +125,17 @@
> >  #define VSC73XX_ADVPORTM_IO_LOOPBACK BIT(1)
> >  #define VSC73XX_ADVPORTM_HOST_LOOPBACK       BIT(0)
> >
> > +/*  TXUPDCFG transmit modify setup bits */
> > +#define VSC73XX_TXUPDCFG_DSCP_REWR_MODE      GENMASK(20, 19)
> > +#define VSC73XX_TXUPDCFG_DSCP_REWR_ENA       BIT(18)
> > +#define VSC73XX_TXUPDCFG_TX_INT_TO_USRPRIO_ENA       BIT(17)
> > +#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID     GENMASK(15, 4)
> > +#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA BIT(3)
> > +#define VSC73XX_TXUPDCFG_TX_UPDATE_CRC_CPU_ENA       BIT(1)
> > +#define VSC73XX_TXUPDCFG_TX_INSERT_TAG       BIT(0)
> > +
> > +#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT 4
>
> nitpick: align a tab, not a space.
>
> > +
> >  /* CAT_DROP categorizer frame dropping register bits */
> >  #define VSC73XX_CAT_DROP_DROP_MC_SMAC_ENA    BIT(6)
> >  #define VSC73XX_CAT_DROP_FWD_CTRL_ENA                BIT(4)
> > @@ -134,6 +149,15 @@
> >  #define VSC73XX_Q_MISC_CONF_EARLY_TX_512     (1 << 1)
> >  #define VSC73XX_Q_MISC_CONF_MAC_PAUSE_MODE   BIT(0)
> >
> > +/* CAT_VLAN_MISC categorizer VLAN miscellaneous bits*/
>
> nitpick: space before */
>
> > +#define VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA BIT(8)
> > +#define VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA BIT(7)
> > +
> > +/* CAT_PORT_VLAN categorizer port VLAN*/
>
> nitpick: space before */
>
> > +#define VSC73XX_CAT_PORT_VLAN_VLAN_CFI BIT(15)
> > +#define VSC73XX_CAT_PORT_VLAN_VLAN_USR_PRIO GENMASK(14, 12)
> > +#define VSC73XX_CAT_PORT_VLAN_VLAN_VID GENMASK(11, 0)
> > +
> >  /* Frame analyzer block 2 registers */
> >  #define VSC73XX_STORMLIMIT   0x02
> >  #define VSC73XX_ADVLEARN     0x03
> > @@ -188,7 +212,8 @@
> >  #define VSC73XX_VLANACCESS_VLAN_MIRROR               BIT(29)
> >  #define VSC73XX_VLANACCESS_VLAN_SRC_CHECK    BIT(28)
> >  #define VSC73XX_VLANACCESS_VLAN_PORT_MASK    GENMASK(9, 2)
> > -#define VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK GENMASK(2, 0)
> > +#define VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT      2
> > +#define VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK GENMASK(1, 0)
> >  #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_IDLE 0
> >  #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_READ_ENTRY   1
> >  #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_WRITE_ENTRY  2
> > @@ -343,6 +368,12 @@ static const struct vsc73xx_counter vsc73xx_tx_cou=
nters[] =3D {
> >       { 29, "TxQoSClass3" }, /* non-standard counter */
> >  };
> >
> > +enum vsc73xx_port_vlan_conf {
> > +     VSC73XX_VLAN_FILTER,
> > +     VSC73XX_VLAN_FILTER_UNTAG_ALL,
> > +     VSC73XX_VLAN_IGNORE,
> > +};
> > +
> >  int vsc73xx_is_addr_valid(u8 block, u8 subblock)
> >  {
> >       switch (block) {
> > @@ -560,6 +591,82 @@ static enum dsa_tag_protocol vsc73xx_get_tag_proto=
col(struct dsa_switch *ds,
> >       return DSA_TAG_PROTO_NONE;
> >  }
> >
> > +static int vsc73xx_wait_for_vlan_table_cmd(struct vsc73xx *vsc)
> > +{
> > +     int ret, err;
> > +     u32 val;
> > +
> > +     ret =3D read_poll_timeout(vsc73xx_read, err,
> > +                             err < 0 || ((val & VSC73XX_VLANACCESS_VLA=
N_TBL_CMD_MASK) =3D=3D
> > +                                         VSC73XX_VLANACCESS_VLAN_TBL_C=
MD_IDLE),
> > +                             1000, 10000, false, vsc, VSC73XX_BLOCK_AN=
ALYZER,
>
> #define VSC73XX_VLAN_TBL_SLEEP_US
> #define VSC73XX_VLAN_TBL_TIMEOUT_US
>
> > +                             0, VSC73XX_VLANACCESS, &val);
> > +     if (ret)
> > +             return ret;
> > +     return err;
> > +}
> > +
> > +static int
> > +vsc73xx_read_vlan_table_entry(struct vsc73xx *vsc, u16 vid, u8 *portma=
p)
> > +{
> > +     u32 val;
> > +     int ret;
> > +
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANTIDX, v=
id);
> > +     ret =3D vsc73xx_wait_for_vlan_table_cmd(vsc);
> > +     if (ret)
> > +             return ret;
>
> Some blank lines before and after the sequences:
>
>         ret =3D do_x();
>         if (ret)
>                 return ret;
>
> would improve the readability.
>
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANA=
CCESS,
> > +                         VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK,
> > +                         VSC73XX_VLANACCESS_VLAN_TBL_CMD_READ_ENTRY);
> > +     ret =3D vsc73xx_wait_for_vlan_table_cmd(vsc);
> > +     if (ret)
> > +             return ret;
> > +     vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS, =
&val);
> > +     *portmap =3D (val & VSC73XX_VLANACCESS_VLAN_PORT_MASK) >>
> > +                VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT;
> > +     return 0;
> > +}
> > +
> > +static int
> > +vsc73xx_write_vlan_table_entry(struct vsc73xx *vsc, u16 vid, u8 portma=
p)
> > +{
> > +     int ret;
> > +
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANTIDX, v=
id);
> > +     ret =3D vsc73xx_wait_for_vlan_table_cmd(vsc);
> > +     if (ret)
> > +             return ret;
> > +
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANA=
CCESS,
> > +                         VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK |
> > +                         VSC73XX_VLANACCESS_VLAN_SRC_CHECK |
> > +                         VSC73XX_VLANACCESS_VLAN_PORT_MASK,
> > +                         VSC73XX_VLANACCESS_VLAN_TBL_CMD_WRITE_ENTRY |
> > +                         VSC73XX_VLANACCESS_VLAN_SRC_CHECK |
> > +                         (portmap << VSC73XX_VLANACCESS_VLAN_PORT_MASK=
_SHIFT));
> > +
> > +     return vsc73xx_wait_for_vlan_table_cmd(vsc);
> > +}
> > +
> > +static int
> > +vsc73xx_update_vlan_table(struct vsc73xx *vsc, int port, u16 vid, bool=
 set)
> > +{
> > +     u8 portmap;
> > +     int ret;
> > +
> > +     ret =3D vsc73xx_read_vlan_table_entry(vsc, vid, &portmap);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (set)
> > +             portmap |=3D BIT(port);
> > +     else
> > +             portmap &=3D ~BIT(port);
> > +
> > +     return  vsc73xx_write_vlan_table_entry(vsc, vid, portmap);
>
> nitpick: remove extra space.
>
> > +}
> > +
> >  static int vsc73xx_setup(struct dsa_switch *ds)
> >  {
> >       struct vsc73xx *vsc =3D ds->priv;
> > @@ -594,7 +701,7 @@ static int vsc73xx_setup(struct dsa_switch *ds)
> >                     VSC73XX_MACACCESS,
> >                     VSC73XX_MACACCESS_CMD_CLEAR_TABLE);
> >
> > -     /* Clear VLAN table */
> > +     /* Set VLAN table to default values*/
> >       vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> >                     VSC73XX_VLANACCESS,
> >                     VSC73XX_VLANACCESS_VLAN_TBL_CMD_CLEAR_TABLE);
> > @@ -623,6 +730,9 @@ static int vsc73xx_setup(struct dsa_switch *ds)
> >       vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
> >                     VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
> >                     VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
> > +     /* Ingess VLAN reception mask (table 145) */
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANMASK,
> > +                   0x5f);
> >       /* IP multicast flood mask (table 144) */
> >       vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
> >                     0xff);
> > @@ -635,6 +745,12 @@ static int vsc73xx_setup(struct dsa_switch *ds)
> >
> >       udelay(4);
> >
> > +     /* Clear VLAN table*/
>
> nitpick: space before */
>
> > +     for (i =3D 0; i < VLAN_N_VID; i++)
> > +             vsc73xx_write_vlan_table_entry(vsc, i, 0);
> > +
> > +     INIT_LIST_HEAD(&vsc->vlans);
> > +
> >       return 0;
> >  }
> >
> > @@ -1024,6 +1140,405 @@ static void vsc73xx_phylink_get_caps(struct dsa=
_switch *dsa, int port,
> >       config->mac_capabilities =3D MAC_SYM_PAUSE | MAC_10 | MAC_100 | M=
AC_1000;
> >  }
> >
> > +static void
> > +vsc73xx_set_vlan_conf(struct vsc73xx *vsc, int port,
> > +                   enum vsc73xx_port_vlan_conf port_vlan_conf)
> > +{
> > +     u32 val =3D (port_vlan_conf =3D=3D VSC73XX_VLAN_IGNORE) ?
> > +               VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA : 0;
> > +
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_VLA=
N_MISC,
> > +                         VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA, va=
l);
> > +
> > +     val =3D (port_vlan_conf =3D=3D VSC73XX_VLAN_IGNORE) ?
> > +           VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA : 0;
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_VLA=
N_MISC,
> > +                         VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA, val)=
;
>
> Could you perform the VSC73XX_CAT_VLAN_MISC modification as part of a
> single call? Something like this:
>
>         u32 val =3D 0;
>
>         if (port_vlan_conf =3D=3D VSC73XX_VLAN_IGNORE) {
>                 val =3D VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA |
>                       VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA;
>         }
>
>         vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_VLA=
N_MISC,
>                             VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA |
>                             VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA, val)=
;
>
> > +
> > +     val =3D (port_vlan_conf =3D=3D VSC73XX_VLAN_FILTER) ?
> > +           VSC73XX_TXUPDCFG_TX_INSERT_TAG : 0;
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCF=
G,
> > +                         VSC73XX_TXUPDCFG_TX_INSERT_TAG, val);
> > +}
> > +
> > +static int
> > +vsc73xx_vlan_change_untagged(struct vsc73xx *vsc, int port, u16 vid, b=
ool set,
> > +                          bool operate_on_storage)
>
> This also returns 0, so it can be made void. Although vsc73xx_update_bits=
()
> can fail on register access too, but... yeah. We don't have a great story
> for that. Your choice on whether to propagate the unlikely error, or just
> print it somewhere. Just don't let it fail completely silently.
>
> > +{
> > +     u32 val;
> > +
> > +     if (operate_on_storage) {
> > +             vsc->untagged_storage[port] =3D set ? vid : VLAN_N_VID;
> > +             return 0;
> > +     }
> > +
> > +     val =3D set ? VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA : 0;
> > +     vid =3D set ? vid : 0;
> > +
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCF=
G,
> > +                         VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA, val);
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCF=
G,
> > +                         VSC73XX_TXUPDCFG_TX_UNTAGGED_VID,
> > +                         (vid << VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIF=
T) &
> > +                          VSC73XX_TXUPDCFG_TX_UNTAGGED_VID);
>
> Same here, try to merge, otherwise you get 4 I/O operations on a slow
> bus instead of 2.
>
> > +     return 0;
> > +}
> > +
> > +static int
> > +vsc73xx_vlan_change_pvid(struct vsc73xx *vsc, int port, u16 vid, bool =
set, bool operate_on_storage)
>
> nitpick: 80 character line limit
>
> > +{
> > +     u32 val;
> > +
> > +     if (operate_on_storage) {
> > +             vsc->pvid_storage[port] =3D set ? vid : VLAN_N_VID;
> > +             return 0;
> > +     }
> > +
> > +     val =3D set ? 0 : VSC73XX_CAT_DROP_UNTAGGED_ENA;
> > +     vid =3D set ? vid : 0;
> > +
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DRO=
P,
> > +                         VSC73XX_CAT_DROP_UNTAGGED_ENA, val);
> > +
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_POR=
T_VLAN,
> > +                         VSC73XX_CAT_PORT_VLAN_VLAN_VID,
> > +                         vid & VSC73XX_CAT_PORT_VLAN_VLAN_VID);
> > +     return 0;
> > +}
> > +
> > +static bool
> > +vsc73xx_port_get_pvid(struct vsc73xx *vsc, int port, u16 *vid, bool op=
erate_on_storage)
>
> nitpick: 80 character line limit
>
> All comments apply elsewhere too, I might have missed some, so please
> take a second look.
>
> > +{
> > +     u32 val;
> > +
> > +     if (operate_on_storage) {
> > +             if (vsc->pvid_storage[port] < VLAN_N_VID) {
> > +                     *vid =3D vsc->pvid_storage[port];
> > +                     return true;
> > +             }
> > +             return false;
> > +     }
> > +
> > +     vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DROP, &val=
);
> > +     if (val & VSC73XX_CAT_DROP_UNTAGGED_ENA)
> > +             return false;
> > +
> > +     vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_PORT_VLAN,=
 &val);
> > +     *vid =3D val & VSC73XX_CAT_PORT_VLAN_VLAN_VID;
> > +
> > +     return true;
> > +}
> > +
> > +static bool vsc73xx_tag_8021q_active(struct dsa_port *dp)
> > +{
> > +     return !dsa_port_is_vlan_filtering(dp);
> > +}
> > +
> > +static bool
> > +vsc73xx_port_get_untagged(struct vsc73xx *vsc, int port, u16 *vid, boo=
l operate_on_storage)
>
> nitpick: 80 character line limit
>
> > +{
> > +     u32 val;
> > +
> > +     if (operate_on_storage) {
> > +             if (vsc->untagged_storage[port] < VLAN_N_VID) {
> > +                     *vid =3D vsc->untagged_storage[port];
> > +                     return true;
> > +             }
> > +             return false;
> > +     }
> > +
> > +     vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG, &val=
);
> > +     if (!(val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA))
> > +             return false;
> > +
> > +     *vid =3D (val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID) >>
> > +             VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT;
> > +
> > +     return true;
> > +}
> > +
> > +static struct vsc73xx_bridge_vlan *vsc73xx_bridge_vlan_find(struct vsc=
73xx *vsc, u16 vid)
>
> nitpick: 80 character line limit
>
> > +{
> > +     struct vsc73xx_bridge_vlan *vlan;
> > +
> > +     list_for_each_entry(vlan, &vsc->vlans, list)
> > +             if (vlan->vid =3D=3D vid)
> > +                     return vlan;
> > +
> > +     return NULL;
> > +}
> > +
> > +static u16 vsc73xx_bridge_vlan_num_tagged(struct vsc73xx *vsc, int por=
t, u16 ignored_vid)
>
> nitpick: 80 character line limit
>
> Also, any reason why this has to return a fixed-size u16? You could use
> the size_t type for object counts.
>

I used the smallest size. It will never exceed 3076.
But I will use size_t .

> > +{
> > +     struct vsc73xx_bridge_vlan *vlan;
> > +     u16 num_tagged =3D 0;
> > +
> > +     list_for_each_entry(vlan, &vsc->vlans, list)
> > +             if ((vlan->portmask & BIT(port)) &&
> > +                 !(vlan->untagged & BIT(port)) &&
> > +                 vlan->vid !=3D ignored_vid)
> > +                     num_tagged++;
> > +
> > +     return num_tagged;
> > +}
> > +
> > +static u16 vsc73xx_bridge_vlan_num_untagged(struct vsc73xx *vsc, int p=
ort, u16 ignored_vid)
>
> nitpick: 80 character line limit
>
> > +{
> > +     struct vsc73xx_bridge_vlan *vlan;
> > +     u16 num_untagged =3D 0;
> > +
> > +     list_for_each_entry(vlan, &vsc->vlans, list)
> > +             if ((vlan->portmask & BIT(port)) &&
> > +                 (vlan->untagged & BIT(port)) &&
> > +                 vlan->vid !=3D ignored_vid)
> > +                     num_untagged++;
> > +
> > +     return num_untagged;
> > +}
> > +
> > +static u16 vsc73xx_find_first_vlan_untagged(struct vsc73xx *vsc, int p=
ort)
> > +{
> > +     struct vsc73xx_bridge_vlan *vlan;
> > +
> > +     list_for_each_entry(vlan, &vsc->vlans, list)
> > +             if ((vlan->portmask & BIT(port)) &&
> > +                 (vlan->untagged & BIT(port)))
> > +                     return vlan->vid;
> > +
> > +     return VLAN_N_VID;
> > +}
> > +
> > +static int
> > +vsc73xx_port_vlan_filtering(struct dsa_switch *ds, int port,
> > +                         bool vlan_filtering, struct netlink_ext_ack *=
extack)
> > +{
> > +     enum vsc73xx_port_vlan_conf port_vlan_conf =3D VSC73XX_VLAN_IGNOR=
E;
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     bool store_untagged  =3D false;
>
> nitpick: remove one extra space
>
> > +     bool store_pvid =3D false;
> > +     u16 vlan_no, vlan_untagged;
>
> nitpick: order variable declaration lines in the order of decreasing
> line length.
>
> Also, "vid" is a more conventional name than "vlan_no".
>
> > +
> > +     /* The swap processed bellow is required because vsc73xx is using=
 tag8021q.
>
> s/bellow/below/
> s/tag8021q/tag_8021q/
>
> > +      * When vlan_filtering is disabled, tag8021q use pvid/untagged vl=
ans for
>
> s/tag8021q use/tag_8021q uses/
>
> > +      * port recognition. The values configured for vlans < 3072 are s=
tored
> > +      * in storage table. When vlan_filtering is enabled, we need to r=
estore
> > +      * pvid/untagged from storage and keep values used for tag8021q.
> > +      */
> > +
>
> nitpick: remove blank line
>
> > +     if (vlan_filtering) {
> > +             /* Use VLAN_N_VID to count all vlans */
> > +             u16 num_untagged =3D vsc73xx_bridge_vlan_num_untagged(vsc=
, port, VLAN_N_VID);
> > +
> > +             port_vlan_conf =3D (num_untagged > 1) ?
> > +                              VSC73XX_VLAN_FILTER_UNTAG_ALL : VSC73XX_=
VLAN_FILTER;
> > +
> > +             vlan_untagged =3D vsc73xx_find_first_vlan_untagged(vsc, p=
ort);
> > +             if (vlan_no < VLAN_N_VID) {
> > +                     store_untagged  =3D vsc73xx_port_get_untagged(vsc=
, port, &vlan_no, false);
> > +                     vsc73xx_vlan_change_untagged(vsc, port, vlan_unta=
gged,
> > +                                                  vlan_untagged < VLAN=
_N_VID, false);
> > +                     vsc->untagged_storage[port] =3D store_untagged ? =
vlan_no : VLAN_N_VID;
> > +             }
> > +     } else {
> > +             vsc73xx_vlan_change_untagged(vsc, port, vsc->untagged_sto=
rage[port],
> > +                                          vsc->untagged_storage[port] =
< VLAN_N_VID, false);
> > +     }
> > +
> > +     vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
> > +
> > +     store_pvid =3D vsc73xx_port_get_pvid(vsc, port, &vlan_no, false);
> > +     vsc73xx_vlan_change_pvid(vsc, port, vsc->pvid_storage[port],
> > +                              vsc->pvid_storage[port] < VLAN_N_VID, fa=
lse);
> > +     vsc->pvid_storage[port] =3D store_pvid ? vlan_no : VLAN_N_VID;
> > +
> > +     return 0;
> > +}
> > +
> > +static int vsc73xx_port_vlan_add(struct dsa_switch *ds, int port,
> > +                              const struct switchdev_obj_port_vlan *vl=
an,
> > +                              struct netlink_ext_ack *extack)
> > +{
> > +     bool untagged =3D vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
> > +     bool pvid =3D vlan->flags & BRIDGE_VLAN_INFO_PVID;
> > +     struct vsc73xx_bridge_vlan *vsc73xx_vlan;
> > +     u16 vlan_no, num_tagged, num_untagged;
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     int ret;
> > +
> > +     /* Be sure to deny alterations to the configuration done by tag_8=
021q.
> > +      */
> > +     if (vid_is_dsa_8021q(vlan->vid)) {
> > +             NL_SET_ERR_MSG_MOD(extack,
> > +                                "Range 3072-4095 reserved for dsa_8021=
q operation");
> > +             return -EBUSY;
> > +     }
> > +
> > +     num_tagged =3D vsc73xx_bridge_vlan_num_tagged(vsc, port, vlan->vi=
d);
> > +     num_untagged =3D vsc73xx_bridge_vlan_num_untagged(vsc, port, vlan=
->vid);
>
> Could you add a comment explaining why you need to exclude vlan->vid
> from the search? I guess it's because the VLAN can be re-added with a
> different set of flags, so it's easiest to ignore its old flags from the
> VLAN database software copy.
>
> > +
> > +     /* VSC73XX allow only three untagged states: none, one or all */
> > +     if ((untagged && num_tagged > 0 && num_untagged > 0) ||
> > +         (!untagged && num_untagged > 1)) {
> > +             NL_SET_ERR_MSG_MOD(extack,
> > +                                "Port can have only none, one or all u=
ntagged vlan!\n");
>
> No need for \n in extack message. Also, no need for exclamation mark.
>
> > +             return -EBUSY;
> > +     }
> > +
> > +     vsc73xx_vlan =3D vsc73xx_bridge_vlan_find(vsc, vlan->vid);
> > +
> > +     if (!vsc73xx_vlan) {
> > +             vsc73xx_vlan =3D kzalloc(sizeof(*vsc73xx_vlan), GFP_KERNE=
L);
> > +             if (!vsc73xx_vlan)
> > +                     return -ENOMEM;
> > +
> > +             vsc73xx_vlan->vid =3D vlan->vid;
> > +             vsc73xx_vlan->portmask =3D BIT(port);
> > +             vsc73xx_vlan->untagged |=3D untagged ? BIT(port) : 0;
>
> kzalloc zero-initializes the memory, so |=3D can be simplified to just =
=3D.
>
> > +
> > +             INIT_LIST_HEAD(&vsc73xx_vlan->list);
> > +             list_add_tail(&vsc73xx_vlan->list, &vsc->vlans);
> > +     } else {
> > +             vsc73xx_vlan->portmask |=3D BIT(port);
> > +
> > +             if (untagged)
> > +                     vsc73xx_vlan->untagged |=3D BIT(port);
> > +             else
> > +                     vsc73xx_vlan->untagged &=3D ~BIT(port);
> > +     }
> > +
> > +     /* CPU port must be always tagged because port separation are bas=
ed on 8021q.*/
>
> nitpick: space before */
>
> s/are based/is based/
> s/8021q/tag_8021q/
>
> > +     if (port !=3D CPU_PORT) {
> > +             bool operate_on_storage =3D vsc73xx_tag_8021q_active(dsa_=
to_port(ds, port));
>
> It would look better if you had a local variable declaration at the
> beginning:
>
>         struct dsa_port *dp =3D dsa_to_port(ds, port);
>
>         if (port !=3D CPU_PORT) {
>                 bool operate_on_storage =3D vsc73xx_tag_8021q_active(dp);
>
> > +
> > +             if (!operate_on_storage) {
> > +                     enum vsc73xx_port_vlan_conf port_vlan_conf =3D VS=
C73XX_VLAN_FILTER;
> > +
> > +                     if (num_tagged =3D=3D 0 && untagged)
> > +                             port_vlan_conf =3D VSC73XX_VLAN_FILTER_UN=
TAG_ALL;
> > +                     vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
> > +
> > +                     if (port_vlan_conf =3D=3D VSC73XX_VLAN_FILTER) {
> > +                             if (untagged) {
> > +                                     ret =3D vsc73xx_vlan_change_untag=
ged(vsc, port, vlan->vid,
> > +                                                                      =
  true,
> > +                                                                      =
  operate_on_storage);
> > +                                     if (ret)
> > +                                             return ret;
>
> This leaks vsc73xx_vlan.
>
> > +                             } else if (num_untagged =3D=3D 1) {
> > +                                     vlan_no =3D vsc73xx_find_first_vl=
an_untagged(vsc, port);
> > +                                     ret =3D vsc73xx_vlan_change_untag=
ged(vsc, port, vlan_no, true,
> > +                                                                      =
  operate_on_storage);
> > +                                     if (ret)
> > +                                             return ret;
>
> Same here.
>
> > +                             }
> > +                     }
> > +             }
> > +
> > +             if (pvid) {
> > +                     ret =3D vsc73xx_vlan_change_pvid(vsc, port, vlan-=
>vid, true,
> > +                                                    operate_on_storage=
);
> > +                     if (ret)
> > +                             return ret;
>
> Same here.
>
> > +             } else {
> > +                     if (vsc73xx_port_get_pvid(vsc, port, &vlan_no, fa=
lse) &&
> > +                         vlan_no =3D=3D vlan->vid)
> > +                             vsc73xx_vlan_change_pvid(vsc, port, 0, fa=
lse, false);
> > +                     else if (vsc->pvid_storage[port] =3D=3D vlan->vid=
)
> > +                             vsc73xx_vlan_change_pvid(vsc, port, 0, fa=
lse, true);
>
> Nitpick:
>
>         if () {
>         } else {
>                 if ()
>                 else if
>         }
>
> can be expressed with one indentation level less as:
>
>         if () {
>         } else if () {
>         } else if () {
>         }
>
> > +             }
> > +     }
> > +
> > +     return vsc73xx_update_vlan_table(vsc, port, vlan->vid, true);
>
> If this returns an error, it also leaks vsc73xx_vlan.
>
> > +}
> > +
> > +static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
> > +                              const struct switchdev_obj_port_vlan *vl=
an)
> > +{
> > +     struct vsc73xx_bridge_vlan *vsc73xx_vlan;
> > +     u16 vlan_no, num_tagged, num_untagged;
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     bool operate_on_storage;
> > +     int ret;
> > +
> > +     num_tagged =3D vsc73xx_bridge_vlan_num_tagged(vsc, port, vlan->vi=
d);
> > +     num_untagged =3D vsc73xx_bridge_vlan_num_untagged(vsc, port, vlan=
->vid);
> > +
> > +     ret =3D vsc73xx_update_vlan_table(vsc, port, vlan->vid, false);
> > +     if (ret)
> > +             return ret;
> > +
> > +     operate_on_storage =3D vsc73xx_tag_8021q_active(dsa_to_port(ds, p=
ort));
> > +
> > +     if (!operate_on_storage) {
> > +             enum vsc73xx_port_vlan_conf port_vlan_conf =3D VSC73XX_VL=
AN_FILTER;
> > +
> > +             if (num_tagged =3D=3D 0)
> > +                     port_vlan_conf =3D VSC73XX_VLAN_FILTER_UNTAG_ALL;
> > +             vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
> > +
> > +             if (num_untagged <=3D 1) {
> > +                     vlan_no =3D vsc73xx_find_first_vlan_untagged(vsc,=
 port);
> > +                     vsc73xx_vlan_change_untagged(vsc, port, vlan_no, =
num_untagged, false);
> > +             }
> > +     } else if (vsc->untagged_storage[port] =3D=3D vlan->vid) {
> > +             vsc73xx_vlan_change_untagged(vsc, port, 0, false, true);
> > +     }
> > +
> > +     if (vsc73xx_port_get_pvid(vsc, port, &vlan_no, false) && vlan_no =
=3D=3D vlan->vid)
> > +             vsc73xx_vlan_change_pvid(vsc, port, 0, false, false);
> > +     else if (vsc->pvid_storage[port] =3D=3D vlan->vid)
> > +             vsc73xx_vlan_change_pvid(vsc, port, 0, false, true);
> > +
> > +     vsc73xx_vlan =3D vsc73xx_bridge_vlan_find(vsc, vlan->vid);
> > +
> > +     if (vsc73xx_vlan) {
> > +             vsc73xx_vlan->portmask &=3D ~BIT(port);
> > +
> > +             if (vsc73xx_vlan->portmask)
> > +                     return 0;
> > +
> > +             list_del(&vsc73xx_vlan->list);
> > +             kfree(vsc73xx_vlan);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
> > +{
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +
> > +     /* Those bits are responsible for MTU only. Kernel take care abou=
t MTU,
> > +      * let's enable +8 bytes frame length unconditionally.
> > +      */
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG=
,
> > +                         VSC73XX_MAC_CFG_VLAN_AWR | VSC73XX_MAC_CFG_VL=
AN_DBLAWR,
> > +                         VSC73XX_MAC_CFG_VLAN_AWR | VSC73XX_MAC_CFG_VL=
AN_DBLAWR);
> > +
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DRO=
P,
> > +                         VSC73XX_CAT_DROP_TAGGED_ENA, 0);
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DRO=
P,
> > +                         VSC73XX_CAT_DROP_UNTAGGED_ENA,
> > +                         VSC73XX_CAT_DROP_UNTAGGED_ENA);
>
> Merge operations.
>
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCF=
G,
> > +                         VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA, 0);
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCF=
G,
> > +                         VSC73XX_TXUPDCFG_TX_UNTAGGED_VID, 0);
>
> Merge operations.
>
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_POR=
T_VLAN,
> > +                         VSC73XX_CAT_PORT_VLAN_VLAN_VID, 0);
> > +
> > +     if (port =3D=3D CPU_PORT)
> > +             vsc73xx_set_vlan_conf(vsc, port, VSC73XX_VLAN_FILTER);
> > +     else
> > +             vsc73xx_set_vlan_conf(vsc, port, VSC73XX_VLAN_IGNORE);
> > +
> > +     /* Set storage values out of range */
>
> please make the comment more useful by adding an explanation why. Like
> "Initially, there is no backup VLAN configuration to keep track of, so
> configure the storage values out of range".
>
> > +     vsc->pvid_storage[port] =3D VLAN_N_VID;
> > +     vsc->untagged_storage[port] =3D VLAN_N_VID;
> > +
> > +     return 0;
> > +}
> > +
> >  static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, b=
ool configure)
> >  {
> >       struct dsa_port *dp =3D dsa_to_port(ds, port);
> > @@ -1107,11 +1622,15 @@ static const struct dsa_switch_ops vsc73xx_ds_o=
ps =3D {
> >       .get_strings =3D vsc73xx_get_strings,
> >       .get_ethtool_stats =3D vsc73xx_get_ethtool_stats,
> >       .get_sset_count =3D vsc73xx_get_sset_count,
> > +     .port_setup =3D vsc73xx_port_setup,
> >       .port_enable =3D vsc73xx_port_enable,
> >       .port_disable =3D vsc73xx_port_disable,
> >       .port_change_mtu =3D vsc73xx_change_mtu,
> >       .port_max_mtu =3D vsc73xx_get_max_mtu,
> >       .port_stp_state_set =3D vsc73xx_port_stp_state_set,
> > +     .port_vlan_filtering =3D vsc73xx_port_vlan_filtering,
> > +     .port_vlan_add =3D vsc73xx_port_vlan_add,
> > +     .port_vlan_del =3D vsc73xx_port_vlan_del,
> >       .phylink_get_caps =3D vsc73xx_phylink_get_caps,
> >  };
> >
> > diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitess=
e-vsc73xx.h
> > index 99c5c24ffde0..01eb2dd48f03 100644
> > --- a/drivers/net/dsa/vitesse-vsc73xx.h
> > +++ b/drivers/net/dsa/vitesse-vsc73xx.h
> > @@ -24,6 +24,14 @@
> >   * @addr: MAC address used in flow control frames
> >   * @ops: Structure with hardware-dependent operations
> >   * @priv: Pointer to the configuration interface structure
> > + * @pvid_storage: Storage table with PVID configured for other state o=
f vlan_filtering.
> > + *   It have two roles: Keep PVID when PVID is configured but vlan fil=
tering is off
>
> "It has two alternating roles: it stores the PVID when configured by the
> bridge but VLAN filtering is off, and it stores the PVID necessary for
> tag_8021q operation when bridge VLAN filtering is enabled".
>
> > + *   and keep PVID necessary for tag8021q operations when vlan filteri=
ng is enabled.
> > + * @untagged_storage: Storage table with eggress untagged VLAN configu=
red for
>
> s/eggress/egress/
>
> > + *   other state of vlan_filtering.Keep VID necessary for tag8021q ope=
rations when
> > + *   vlan filtering is enabled.
> > + * @vlans: List of configured vlans. Contain port mask and untagged st=
atus of every
>
> Contains
>
> > + *   vlan configured in port vlan operation. It doesn't cover tag8021q=
 vlans.
> >   */
> >  struct vsc73xx {
> >       struct device                   *dev;
> > @@ -34,6 +42,9 @@ struct vsc73xx {
> >       u8                              addr[ETH_ALEN];
> >       const struct vsc73xx_ops        *ops;
> >       void                            *priv;
> > +     u16                             pvid_storage[VSC73XX_MAX_NUM_PORT=
S];
> > +     u16                             untagged_storage[VSC73XX_MAX_NUM_=
PORTS];
> > +     struct list_head                vlans;
> >  };
> >
> >  /**
> > @@ -48,6 +59,20 @@ struct vsc73xx_ops {
> >                    u32 val);
> >  };
> >
> > +/**
> > + * struct vsc73xx_bridge_vlan - VSC73xx driver structure which keeps v=
lan database copy
>
> More succinct: "Copy of VLAN database entry"
>
> > + * @vid: VLAN number
> > + * @portmask: each bit represends one port
>
> s/represends/represents/
>
> > + * @untagged: each bit represends one port configured with @vid untagg=
ed
>
> s/represends/represents/
>
> > + * @list: list structure
> > + */
> > +struct vsc73xx_bridge_vlan {
> > +     u16 vid;
> > +     u8 portmask;
> > +     u8 untagged;
> > +     struct list_head list;
> > +};
> > +
> >  int vsc73xx_is_addr_valid(u8 block, u8 subblock);
> >  int vsc73xx_probe(struct vsc73xx *vsc);
> >  void vsc73xx_remove(struct vsc73xx *vsc);
> > --
> > 2.34.1
> >
>

