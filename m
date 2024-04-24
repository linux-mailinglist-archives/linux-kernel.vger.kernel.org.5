Return-Path: <linux-kernel+bounces-156707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59F88B071D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054021C21A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA9D159566;
	Wed, 24 Apr 2024 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OncTH6Fu"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48FA1591F0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953930; cv=none; b=aZ5eOISVSzuuRZdih+kByb23Dbq7tvOEtUdbrMFLmg7zZKsSgj0hhN4apbfMC98ZOOY74EDMfbbWkDJ3pJ2TV08CTkwheHba1RSRYgZQCphUxuqiEoOdGK5wWpajmzbN2f4GeNGwB372BNMlLd5vJx+5K3hhrlncDKo9F0CIPrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953930; c=relaxed/simple;
	bh=lK83DFMMrheEcjmLGnhK7+OwBHnpFcHV4An4Tq+hklQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gI9tTajGN0gIZbsfRhR0Z+qyin5mbq4b6i4bIerfGk54YoQYPbisPE5zi9aeDt/TuK1GFM7zhSRwjcMfaN34a4Y4MNqJzPKs2nymil/8vT4/eoM0vZjw1x5rHLzAUYA4KOcL90Ade+dCl53pbCHX5mu1/afvtDyvVFAUqAERFak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OncTH6Fu; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d6c1e238so8424735e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 03:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713953927; x=1714558727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFdw4V9U4NST4C8w1cj4IEkGhdH2VTb3cZ2ewOJFDY8=;
        b=OncTH6FujuC0CGt8CzSQHMJlJ0+X1C5+TGThi2US1Pl/TuRMBpb+3ib/Y22DraCOlZ
         apmACURksvrHaxMZ84TzO0xCKz/pF34SXFn0UM/w6UKZacdGm7Iv/S4FFUZkncgBdp1i
         /GygrQw+RizFWxNzGskbGp14jlpx75AjMa8qODcGzWWkAt4fbI/HCXXNHsiY5JjVfUZy
         UMCvDdBn+kCrbgvjF3j/DTyn98CrWk3ZlBtA6HE+xz1O3y9EnF0Vd5Gljf+agCn6LiGc
         csVOeyN+UL5stmX/C/+XxQHTmRe36OV80lV7/OB1XqHBTWPQhgKHZw8Q/9/WgHJz68dG
         Gs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713953927; x=1714558727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFdw4V9U4NST4C8w1cj4IEkGhdH2VTb3cZ2ewOJFDY8=;
        b=wLw2B32emn4WwA5Aa+KM6JmqrCbslbiWG8C40KZ4BSY5nitjakmSRCTBVRPhMKeume
         d9v5tEF/0yR6XrkCT5ZvOdMr9yAmmbW1lPz494eWUC/j0ZzP6VFkD6QnPF4N2ByJYE5a
         4HUJIdc2t648rSnFAkn3brm1NBu46e5Vae0i3oYwpaEj055ZtnUzKQJyYt6R2fG7GhRc
         wokoSTk3Mbwk8oEBKXKN5BxvIukgdXmCMBFYU+QhK9p634WFFkRn7k+1rryXMO36Cg1E
         RNYgokx4Oa2GyUQActCX6XhG2c3BKx7N7A1OEyY+/nuqQ+JY8qoqi0gz33hE3KDx1aNn
         6bWg==
X-Forwarded-Encrypted: i=1; AJvYcCXvknXTEZhGJv7bpj3QTnRBupt5wcKGheziYUHS+B2A3eWQ8OzMYpEqt7b2GxZoLaK4VJA5ekKcF5BGQwtNP4iSH2etpibtrnMeDBH5
X-Gm-Message-State: AOJu0Yz+qKrIfSviJ4WLgpAe8l0j98OLVmWA487fjWZx46+mUkXj/kpg
	1pfe4g7H91Fyte3nc51UZBCENvgVwlbLWvkUXTIDvKu1EC46qOwXQWkUTonS9gAV37GFhSt2KrE
	0K4ZY+LeFxohh3JuR9T2eWCzVWnEJ6oWT62JZ
X-Google-Smtp-Source: AGHT+IG8wWkRon3EGwbXNZDXFJeXYV2g79QRt563aKJF+Zlpi8UbIP8U7SqapviVgrO6cjhFlvXRk8rG8EBwrRTYgAE=
X-Received: by 2002:a19:690a:0:b0:51a:bdd6:e718 with SMTP id
 e10-20020a19690a000000b0051abdd6e718mr1226965lfc.31.1713953926472; Wed, 24
 Apr 2024 03:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424074242.519895-1-joychakr@google.com> <20240424074242.519895-2-joychakr@google.com>
 <20240424104048.1b02b07e@donnerap.manchester.arm.com>
In-Reply-To: <20240424104048.1b02b07e@donnerap.manchester.arm.com>
From: Joy Chakraborty <joychakr@google.com>
Date: Wed, 24 Apr 2024 15:48:32 +0530
Message-ID: <CAOSNQF1cVFTgZN4uzmxLEUG9cEq6bCNMQ9Mar9Y8AHaYKh6OEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] nvmem: Change return type of reg read/write to ssize_t
To: Andre Przywara <andre.przywara@arm.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Vladimir Zapolskiy <vz@mleia.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Heiko Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Vincent Shih <vincent.sunplus@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Rafal Milecki <rafal@milecki.pl>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
	manugautam@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 3:11=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> On Wed, 24 Apr 2024 07:42:42 +0000
> Joy Chakraborty <joychakr@google.com> wrote:
>
> > Change return type of reg_read() and reg_write() callback to ssize_t fo=
r
> > nvmem suppliers to return number of bytes read/written to the nvmem cor=
e.
> >
> > Currently nvmem core assumes the amount of data read/written is equal
> > to what it has requested from the supplier, this return code facilitate=
s
> > better error handling in the nvmem core.
> >
> > Signed-off-by: Joy Chakraborty <joychakr@google.com>
>
> There are two problems in the sunxi driver:
>
> > ---
> >  drivers/nvmem/apple-efuses.c        |  7 +--
> >  drivers/nvmem/bcm-ocotp.c           | 12 ++---
> >  drivers/nvmem/brcm_nvram.c          | 10 ++--
> >  drivers/nvmem/core.c                | 83 +++++++++++++----------------
> >  drivers/nvmem/imx-iim.c             |  6 +--
> >  drivers/nvmem/imx-ocotp-ele.c       |  4 +-
> >  drivers/nvmem/imx-ocotp-scu.c       | 12 ++---
> >  drivers/nvmem/imx-ocotp.c           | 10 ++--
> >  drivers/nvmem/jz4780-efuse.c        |  7 +--
> >  drivers/nvmem/lan9662-otpc.c        | 12 ++---
> >  drivers/nvmem/layerscape-sfp.c      | 11 ++--
> >  drivers/nvmem/lpc18xx_eeprom.c      | 14 ++---
> >  drivers/nvmem/lpc18xx_otp.c         |  6 +--
> >  drivers/nvmem/meson-efuse.c         | 22 +++++---
> >  drivers/nvmem/meson-mx-efuse.c      |  6 +--
> >  drivers/nvmem/microchip-otpc.c      |  6 +--
> >  drivers/nvmem/mtk-efuse.c           |  6 +--
> >  drivers/nvmem/mxs-ocotp.c           |  7 +--
> >  drivers/nvmem/nintendo-otp.c        |  6 +--
> >  drivers/nvmem/qcom-spmi-sdam.c      | 12 ++---
> >  drivers/nvmem/qfprom.c              | 14 ++---
> >  drivers/nvmem/qoriq-efuse.c         |  6 +--
> >  drivers/nvmem/rave-sp-eeprom.c      | 18 +++----
> >  drivers/nvmem/rmem.c                |  4 +-
> >  drivers/nvmem/rockchip-efuse.c      | 19 +++----
> >  drivers/nvmem/rockchip-otp.c        | 19 +++----
> >  drivers/nvmem/sc27xx-efuse.c        |  3 +-
> >  drivers/nvmem/sec-qfprom.c          |  4 +-
> >  drivers/nvmem/snvs_lpgpr.c          | 17 +++---
> >  drivers/nvmem/sprd-efuse.c          |  8 +--
> >  drivers/nvmem/stm32-bsec-optee-ta.c | 12 ++---
> >  drivers/nvmem/stm32-bsec-optee-ta.h | 20 +++----
> >  drivers/nvmem/stm32-romem.c         | 26 ++++-----
> >  drivers/nvmem/sunplus-ocotp.c       |  4 +-
> >  drivers/nvmem/sunxi_sid.c           | 15 +++---
> >  drivers/nvmem/u-boot-env.c          |  6 +--
> >  drivers/nvmem/uniphier-efuse.c      |  6 +--
> >  drivers/nvmem/vf610-ocotp.c         |  7 +--
> >  drivers/nvmem/zynqmp_nvmem.c        | 13 ++---
> >  include/linux/nvmem-provider.h      |  4 +-
> >  40 files changed, 253 insertions(+), 231 deletions(-)
>
> [ ... ]
>
> >
> > diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> > index ba14a76208ab..0133263d2adb 100644
> > --- a/drivers/nvmem/sunxi_sid.c
> > +++ b/drivers/nvmem/sunxi_sid.c
> > @@ -36,8 +36,8 @@ struct sunxi_sid {
> >       u32                     value_offset;
> >  };
> >
> > -static int sunxi_sid_read(void *context, unsigned int offset,
> > -                       void *val, size_t bytes)
> > +static ssize_t sunxi_sid_read(void *context, unsigned int offset,
> > +                           void *val, size_t bytes)
> >  {
> >       struct sunxi_sid *sid =3D context;
> >       u32 word;
> > @@ -56,7 +56,7 @@ static int sunxi_sid_read(void *context, unsigned int=
 offset,
>
>         (adding more context here)
>
> >
> >       val +=3D round_down(bytes, 4);
> >       offset +=3D round_down(bytes, 4);
> >       bytes =3D bytes % 4;
> >
> >       if (!bytes)
> >               return 0;
> >
> >       /* Handle any trailing bytes */
> >       word =3D readl_relaxed(sid->base + sid->value_offset + offset);
> >       memcpy(val, &word, bytes);
> >
> > -     return 0;
> > +     return bytes;
>
> So this is only the code path in case the read request was not 4 byte
> aligned, so the "return 0;" above must also be changed. But please note
> that the bytes parameter is changed, so we either need to save that, or
> derive the amount read from something else.
>
> Cheers,
> Andre

Ack, Missed the return logic above.
Will fix this next version by saving bytes read in another variable.
Thanks for reviewing.

Thanks
Joy

>
> >  }
> >
> >  static int sun8i_sid_register_readout(const struct sunxi_sid *sid,
> > @@ -90,10 +90,11 @@ static int sun8i_sid_register_readout(const struct =
sunxi_sid *sid,
> >   * to be not reliable at all.
> >   * Read by the registers instead.
> >   */
> > -static int sun8i_sid_read_by_reg(void *context, unsigned int offset,
> > -                              void *val, size_t bytes)
> > +static ssize_t sun8i_sid_read_by_reg(void *context, unsigned int offse=
t,
> > +                                  void *val, size_t bytes)
> >  {
> >       struct sunxi_sid *sid =3D context;
> > +     size_t bytes_read =3D bytes;
> >       u32 word;
> >       int ret;
> >
> > @@ -109,7 +110,7 @@ static int sun8i_sid_read_by_reg(void *context, uns=
igned int offset,
> >       }
> >
> >       if (!bytes)
> > -             return 0;
> > +             return bytes_read;
> >
> >       /* Handle any trailing bytes */
> >       ret =3D sun8i_sid_register_readout(sid, offset, &word);
> > @@ -118,7 +119,7 @@ static int sun8i_sid_read_by_reg(void *context, uns=
igned int offset,
> >
> >       memcpy(val, &word, bytes);
> >
> > -     return 0;
> > +     return bytes_read;
> >  }
> >
> >  static int sunxi_sid_probe(struct platform_device *pdev)
> > diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
> > index befbab156cda..2288a2891bb2 100644
> > --- a/drivers/nvmem/u-boot-env.c
> > +++ b/drivers/nvmem/u-boot-env.c
> > @@ -47,8 +47,8 @@ struct u_boot_env_image_broadcom {
> >       DECLARE_FLEX_ARRAY(uint8_t, data);
> >  } __packed;
> >
> > -static int u_boot_env_read(void *context, unsigned int offset, void *v=
al,
> > -                        size_t bytes)
> > +static ssize_t u_boot_env_read(void *context, unsigned int offset, voi=
d *val,
> > +                            size_t bytes)
> >  {
> >       struct u_boot_env *priv =3D context;
> >       struct device *dev =3D priv->dev;
> > @@ -66,7 +66,7 @@ static int u_boot_env_read(void *context, unsigned in=
t offset, void *val,
> >               return -EIO;
> >       }
> >
> > -     return 0;
> > +     return bytes_read;
> >  }
> >
> >  static int u_boot_env_read_post_process_ethaddr(void *context, const c=
har *id, int index,
> > diff --git a/drivers/nvmem/uniphier-efuse.c b/drivers/nvmem/uniphier-ef=
use.c
> > index 6ad3295d3195..a6c28e03adc2 100644
> > --- a/drivers/nvmem/uniphier-efuse.c
> > +++ b/drivers/nvmem/uniphier-efuse.c
> > @@ -16,8 +16,8 @@ struct uniphier_efuse_priv {
> >       void __iomem *base;
> >  };
> >
> > -static int uniphier_reg_read(void *context,
> > -                          unsigned int reg, void *_val, size_t bytes)
> > +static ssize_t uniphier_reg_read(void *context,
> > +                              unsigned int reg, void *_val, size_t byt=
es)
> >  {
> >       struct uniphier_efuse_priv *priv =3D context;
> >       u8 *val =3D _val;
> > @@ -26,7 +26,7 @@ static int uniphier_reg_read(void *context,
> >       for (offs =3D 0; offs < bytes; offs +=3D sizeof(u8))
> >               *val++ =3D readb(priv->base + reg + offs);
> >
> > -     return 0;
> > +     return bytes;
> >  }
> >
> >  static int uniphier_efuse_probe(struct platform_device *pdev)
> > diff --git a/drivers/nvmem/vf610-ocotp.c b/drivers/nvmem/vf610-ocotp.c
> > index ee9c61ae727d..4e2bdb38305d 100644
> > --- a/drivers/nvmem/vf610-ocotp.c
> > +++ b/drivers/nvmem/vf610-ocotp.c
> > @@ -143,11 +143,12 @@ static int vf610_get_fuse_address(int base_addr_o=
ffset)
> >       return -EINVAL;
> >  }
> >
> > -static int vf610_ocotp_read(void *context, unsigned int offset,
> > -                     void *val, size_t bytes)
> > +static ssize_t vf610_ocotp_read(void *context, unsigned int offset,
> > +                             void *val, size_t bytes)
> >  {
> >       struct vf610_ocotp *ocotp =3D context;
> >       void __iomem *base =3D ocotp->base;
> > +     size_t bytes_read =3D bytes;
> >       u32 reg, *buf =3D val;
> >       int fuse_addr;
> >       int ret;
> > @@ -193,7 +194,7 @@ static int vf610_ocotp_read(void *context, unsigned=
 int offset,
> >               offset +=3D 4;
> >       }
> >
> > -     return 0;
> > +     return bytes_read;
> >  }
> >
> >  static struct nvmem_config ocotp_config =3D {
> > diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.=
c
> > index 8682adaacd69..1502d4998159 100644
> > --- a/drivers/nvmem/zynqmp_nvmem.c
> > +++ b/drivers/nvmem/zynqmp_nvmem.c
> > @@ -56,8 +56,8 @@ struct xilinx_efuse {
> >       u32 pufuserfuse;
> >  };
> >
> > -static int zynqmp_efuse_access(void *context, unsigned int offset,
> > -                            void *val, size_t bytes, enum efuse_access=
 flag,
> > +static ssize_t zynqmp_efuse_access(void *context, unsigned int offset,
> > +                                void *val, size_t bytes, enum efuse_ac=
cess flag,
> >                              unsigned int pufflag)
> >  {
> >       struct device *dev =3D context;
> > @@ -140,10 +140,10 @@ static int zynqmp_efuse_access(void *context, uns=
igned int offset,
> >       dma_free_coherent(dev, sizeof(struct xilinx_efuse),
> >                         efuse, dma_addr);
> >
> > -     return ret;
> > +     return ret < 0 ? ret : bytes;
> >  }
> >
> > -static int zynqmp_nvmem_read(void *context, unsigned int offset, void =
*val, size_t bytes)
> > +static ssize_t zynqmp_nvmem_read(void *context, unsigned int offset, v=
oid *val, size_t bytes)
> >  {
> >       struct device *dev =3D context;
> >       int ret;
> > @@ -166,6 +166,7 @@ static int zynqmp_nvmem_read(void *context, unsigne=
d int offset, void *val, size
> >
> >               dev_dbg(dev, "Read chipid val %x %x\n", idcode, version);
> >               *(int *)val =3D version & SILICON_REVISION_MASK;
> > +             ret =3D SOC_VER_SIZE;
> >               break;
> >       /* Efuse offset starts from 0xc */
> >       case EFUSE_START_OFFSET ... EFUSE_END_OFFSET:
> > @@ -182,8 +183,8 @@ static int zynqmp_nvmem_read(void *context, unsigne=
d int offset, void *val, size
> >       return ret;
> >  }
> >
> > -static int zynqmp_nvmem_write(void *context,
> > -                           unsigned int offset, void *val, size_t byte=
s)
> > +static ssize_t zynqmp_nvmem_write(void *context,
> > +                               unsigned int offset, void *val, size_t =
bytes)
> >  {
> >       int pufflag =3D 0;
> >
> > diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provi=
der.h
> > index 3ebeaa0ded00..f7e83a59aa2f 100644
> > --- a/include/linux/nvmem-provider.h
> > +++ b/include/linux/nvmem-provider.h
> > @@ -16,9 +16,9 @@
> >  #include <linux/gpio/consumer.h>
> >
> >  struct nvmem_device;
> > -typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
> > +typedef ssize_t (*nvmem_reg_read_t)(void *priv, unsigned int offset,
> >                               void *val, size_t bytes);
> > -typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
> > +typedef ssize_t (*nvmem_reg_write_t)(void *priv, unsigned int offset,
> >                                void *val, size_t bytes);
> >  /* used for vendor specific post processing of cell data */
> >  typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, i=
nt index,
>

