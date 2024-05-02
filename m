Return-Path: <linux-kernel+bounces-166257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DFE8B9821
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B2E284DBA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9B35647B;
	Thu,  2 May 2024 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ikaz5+8C"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC2B55C0A
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643634; cv=none; b=i0pnqUGrvOZzUwl0srNT+zBLsjCh96OGj5p+WOtQ+RLiOiRmm2NifyLtXxfElbXLbrzH+PJ4gzrhbkIDjXRY9PvgWlinnIiBtoY/xbUYU8KJZo6EXU4S+6t1BA/sB1FozO9Oa2GYK1G4Llc08LIhCKpQ2vt3UatiI5Ni1x0UVCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643634; c=relaxed/simple;
	bh=o87WVhVjQRBP+6ThfYJoj0Z2951o3PlEy881O0myrMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYU9FskhQy9/E5vEBP1XMi0KTqhWk5PT7bPh6utVTHL4caslNrwHyYWEm5OUaIeYrlFB9j4oJKV2SVur3FRV6ENGUAU9KH+TshUzGAp1xnTY/PtUjry8nSXgnc7yBSOxU/6uEuSbfn7Y4Wt6FAFWE/xveL5i+Y25aFegTfK7Ncc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ikaz5+8C; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b1bbff09f8so296801eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714643632; x=1715248432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AcRINpNVGLwFNrbPHoo/3mfgbO66yT1OWofD/Yj738=;
        b=ikaz5+8C9bxLyC5nWoMOMQae6Mfv4QcdM/kP2OrmQvRx4jtLHzYg3s6f6fHX1jZm3n
         X2WctwqAXGe/gQillEXGZWeMvRuZlJ8Y9jctaGbXXOLjbladiuZL52jKHvAlRR0+ykoV
         U+H2LhL45vTMiWdbDXTzoSaemV7FIqHbvYtDHaDLkaJ0xP1rJRlDaz0Gq4lbU/B87Ngz
         pk6ovOHSaL/vhREfRzi90WEApxG4JIMPn32kBXA3CunJQSptKDApTGvhp5hHM06LG1Sw
         Uuvq1YosYMy1SEKZRaeRG6/ZBr0hRVLNbmm2UYWvoGhT9a+ME3sZsDXn0RMJir2CXZ67
         +xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714643632; x=1715248432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AcRINpNVGLwFNrbPHoo/3mfgbO66yT1OWofD/Yj738=;
        b=ugCD7beio9D3t9eA7Mxu6E7Y1+0z/8aRpGNY+1/G5BkwfwWuk/NvYXTiMsRGL60jfK
         wInZCnhPzBdRV5HnG7g77JDNfGCr6+IzQSDH2QHOnmI5ILnkriGhMZ1bYbT26kyWOBkG
         QbFJrCo74x3QKbjWnlwcunCdp2PV/lfeW1s+F52AP5tlU86g1F8zPs/1gvOtAhB1pXoh
         OEKKaE2gmfc52chGkZHd5yH/gO8w8pfZNmEVRCFyZ1U6viuA+qIlKoTOKTCiV+gArRlY
         GZqMsVLQIV8oMclMD+tyhOxNMlhYh9wGjTAssT0Dvu8C9zunYNe70gwmDRQBn9tg0fzL
         l2IQ==
X-Gm-Message-State: AOJu0YyxSRm+mXgkHY0vIUncerHoTLJD5MKoqsEltWHGJcAG7RTbYVmB
	ea4EPpPxp2weTP9v02mR0RJGB137O0UnqGE54xOfX+8q9yxCusrNedCaGLzjcrduzmztnzwrFiv
	VzzFSdM4CF77aG7ymdclKzDpQN4g6XhzRuKgC5g==
X-Google-Smtp-Source: AGHT+IHpgmdM47sX6tHYGjiSKktGpCzsQjaRz/epLFCL8xJ5DlMgSvy3wd4tmG84krtRl6yPhG6Cc2DrCWia6ccKHAs=
X-Received: by 2002:a4a:55d1:0:b0:5af:292b:6986 with SMTP id
 e200-20020a4a55d1000000b005af292b6986mr1132222oob.3.1714643631809; Thu, 02
 May 2024 02:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422091936.3714381-1-jens.wiklander@linaro.org>
 <20240422091936.3714381-3-jens.wiklander@linaro.org> <ZioXkvnIw5V5MXBU@mecka.net>
 <CAHUa44Fojanryuc+ciJrVZUopRLcTt2teS_pC4BBjt1Wmy240A@mail.gmail.com>
 <Zi9rKzz8u8z7cIy0@mecka.net> <CAHUa44HHtcaYXhcWg5zL5EQ8pEP7aEDKS+yjpaMJH8vTtF3xFw@mail.gmail.com>
 <Zi93_0aCq9mQ_6cD@mecka.net> <CAHUa44FG3ge3nyQVStKjfpeJvpjuQjNiZsxHjyRz+CUjHwkS=g@mail.gmail.com>
 <CAHUa44EecehfyzE97z49e=-qA513um21JyJz_CNKweuctp=HoQ@mail.gmail.com> <Zi-c6QXySx78JoJ_@mecka.net>
In-Reply-To: <Zi-c6QXySx78JoJ_@mecka.net>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 2 May 2024 11:53:40 +0200
Message-ID: <CAHUa44F1GrHpg4tatm_3+c9sg=CBWMjpdU5YE9BmQKRa+5vvaQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mmc: block: register RPMB partition with the RPMB subsystem
To: Manuel Traut <manut@mecka.net>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	Alexander Usyskin <alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 3:13=E2=80=AFPM Manuel Traut <manut@mecka.net> wrot=
e:
>
> On Mon, Apr 29, 2024 at 01:13:58PM +0200, Jens Wiklander wrote:
> > On Mon, Apr 29, 2024 at 12:45=E2=80=AFPM Jens Wiklander
> > <jens.wiklander@linaro.org> wrote:
> > >
> > > On Mon, Apr 29, 2024 at 12:35=E2=80=AFPM Manuel Traut <manut@mecka.ne=
t> wrote:
> > > >
> > > > On Mon, Apr 29, 2024 at 12:08:45PM +0200, Jens Wiklander wrote:
> > > > > On Mon, Apr 29, 2024 at 11:41=E2=80=AFAM Manuel Traut <manut@meck=
a.net> wrote:
> > > > > >
> > > > > > On Fri, Apr 26, 2024 at 03:24:21PM +0200, Jens Wiklander wrote:
> > > > > > > On Thu, Apr 25, 2024 at 10:43=E2=80=AFAM Manuel Traut <manut@=
mecka.net> wrote:
> > > > > > > >
> > > > > > > > On Mon, Apr 22, 2024 at 11:19:35AM +0200, Jens Wiklander wr=
ote:
> > > > > > > > > Register eMMC RPMB partition with the RPMB subsystem and =
provide
> > > > > > > > > an implementation for the RPMB access operations abstract=
ing
> > > > > > > > > the actual multi step process.
> > > > > > > > >
> > > > > > > > > Add a callback to extract the needed device information a=
t registration
> > > > > > > > > to avoid accessing the struct mmc_card at a later stage a=
s we're not
> > > > > > > > > holding a reference counter for this struct.
> > > > > > > > >
> > > > > > > > > Taking the needed reference to md->disk in mmc_blk_alloc_=
rpmb_part()
> > > > > > > > > instead of in mmc_rpmb_chrdev_open(). This is needed by t=
he
> > > > > > > > > route_frames() function pointer in struct rpmb_ops.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > > > > > > > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel=
com>
> > > > > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > > > > ---
> > > > > > > > >  drivers/mmc/core/block.c | 241 +++++++++++++++++++++++++=
+++++++++++++-
> > > > > > > > >  1 file changed, 239 insertions(+), 2 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/=
block.c
> > > > > > > > > index 32d49100dff5..a7f126fbc605 100644
> > > > > > > > > --- a/drivers/mmc/core/block.c
> > > > > > > > > +++ b/drivers/mmc/core/block.c
> > > > > > > > > @@ -33,6 +33,7 @@
> > > > > > > > >  #include <linux/cdev.h>
> > > > > > > > >  #include <linux/mutex.h>
> > > > > > > > >  #include <linux/scatterlist.h>
> > > > > > > > > +#include <linux/string.h>
> > > > > > > > >  #include <linux/string_helpers.h>
> > > > > > > > >  #include <linux/delay.h>
> > > > > > > > >  #include <linux/capability.h>
> > > > > > > > > @@ -40,6 +41,7 @@
> > > > > > > > >  #include <linux/pm_runtime.h>
> > > > > > > > >  #include <linux/idr.h>
> > > > > > > > >  #include <linux/debugfs.h>
> > > > > > > > > +#include <linux/rpmb.h>
> > > > > > > > >
> > > > > > > > >  #include <linux/mmc/ioctl.h>
> > > > > > > > >  #include <linux/mmc/card.h>
> > > > > > > > > @@ -76,6 +78,48 @@ MODULE_ALIAS("mmc:block");
> > > > > > > > >  #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) =
>> 16)
> > > > > > > > >  #define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) =
>> 8)
> > > > > > > > >
> > > > > > > > > +/**
> > > > > > > > > + * struct rpmb_frame - rpmb frame as defined by eMMC 5.1=
 (JESD84-B51)
> > > > > > > > > + *
> > > > > > > > > + * @stuff        : stuff bytes
> > > > > > > > > + * @key_mac      : The authentication key or the message=
 authentication
> > > > > > > > > + *                 code (MAC) depending on the request/r=
esponse type.
> > > > > > > > > + *                 The MAC will be delivered in the last=
 (or the only)
> > > > > > > > > + *                 block of data.
> > > > > > > > > + * @data         : Data to be written or read by signed =
access.
> > > > > > > > > + * @nonce        : Random number generated by the host f=
or the requests
> > > > > > > > > + *                 and copied to the response by the RPM=
B engine.
> > > > > > > > > + * @write_counter: Counter value for the total amount of=
 the successful
> > > > > > > > > + *                 authenticated data write requests mad=
e by the host.
> > > > > > > > > + * @addr         : Address of the data to be programmed =
to or read
> > > > > > > > > + *                 from the RPMB. Address is the serial =
number of
> > > > > > > > > + *                 the accessed block (half sector 256B)=
.
> > > > > > > > > + * @block_count  : Number of blocks (half sectors, 256B)=
 requested to be
> > > > > > > > > + *                 read/programmed.
> > > > > > > > > + * @result       : Includes information about the status=
 of the write counter
> > > > > > > > > + *                 (valid, expired) and result of the ac=
cess made to the RPMB.
> > > > > > > > > + * @req_resp     : Defines the type of request and respo=
nse to/from the memory.
> > > > > > > > > + *
> > > > > > > > > + * The stuff bytes and big-endian properties are modeled=
 to fit to the spec.
> > > > > > > > > + */
> > > > > > > > > +struct rpmb_frame {
> > > > > > > > > +     u8     stuff[196];
> > > > > > > > > +     u8     key_mac[32];
> > > > > > > > > +     u8     data[256];
> > > > > > > > > +     u8     nonce[16];
> > > > > > > > > +     __be32 write_counter;
> > > > > > > > > +     __be16 addr;
> > > > > > > > > +     __be16 block_count;
> > > > > > > > > +     __be16 result;
> > > > > > > > > +     __be16 req_resp;
> > > > > > > > > +} __packed;
> > > > > > > > > +
> > > > > > > > > +#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Au=
thentication Key */
> > > > > > > > > +#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write=
 counter */
> > > > > > > > > +#define RPMB_WRITE_DATA        0x3    /* Write data to R=
PMB partition */
> > > > > > > > > +#define RPMB_READ_DATA         0x4    /* Read data from =
RPMB partition */
> > > > > > > > > +#define RPMB_RESULT_READ       0x5    /* Read result req=
uest  (Internal) */
> > > > > > > > > +
> > > > > > > > >  static DEFINE_MUTEX(block_mutex);
> > > > > > > > >
> > > > > > > > >  /*
> > > > > > > > > @@ -163,6 +207,7 @@ struct mmc_rpmb_data {
> > > > > > > > >       int id;
> > > > > > > > >       unsigned int part_index;
> > > > > > > > >       struct mmc_blk_data *md;
> > > > > > > > > +     struct rpmb_dev *rdev;
> > > > > > > > >       struct list_head node;
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > > @@ -2672,7 +2717,6 @@ static int mmc_rpmb_chrdev_open(str=
uct inode *inode, struct file *filp)
> > > > > > > > >
> > > > > > > > >       get_device(&rpmb->dev);
> > > > > > > > >       filp->private_data =3D rpmb;
> > > > > > > > > -     mmc_blk_get(rpmb->md->disk);
> > > > > > > > >
> > > > > > > > >       return nonseekable_open(inode, filp);
> > > > > > > > >  }
> > > > > > > > > @@ -2682,7 +2726,6 @@ static int mmc_rpmb_chrdev_release(=
struct inode *inode, struct file *filp)
> > > > > > > > >       struct mmc_rpmb_data *rpmb =3D container_of(inode->=
i_cdev,
> > > > > > > > >                                                 struct mm=
c_rpmb_data, chrdev);
> > > > > > > > >
> > > > > > > > > -     mmc_blk_put(rpmb->md);
> > > > > > > > >       put_device(&rpmb->dev);
> > > > > > > > >
> > > > > > > > >       return 0;
> > > > > > > > > @@ -2703,10 +2746,165 @@ static void mmc_blk_rpmb_device_=
release(struct device *dev)
> > > > > > > > >  {
> > > > > > > > >       struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev)=
;
> > > > > > > > >
> > > > > > > > > +     rpmb_dev_unregister(rpmb->rdev);
> > > > > > > > > +     mmc_blk_put(rpmb->md);
> > > > > > > > >       ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> > > > > > > > >       kfree(rpmb);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static void free_idata(struct mmc_blk_ioc_data **idata, =
unsigned int cmd_count)
> > > > > > > > > +{
> > > > > > > > > +     unsigned int n;
> > > > > > > > > +
> > > > > > > > > +     for (n =3D 0; n < cmd_count; n++)
> > > > > > > > > +             kfree(idata[n]);
> > > > > > > > > +     kfree(idata);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static struct mmc_blk_ioc_data **alloc_idata(struct mmc_=
rpmb_data *rpmb,
> > > > > > > > > +                                          unsigned int c=
md_count)
> > > > > > > > > +{
> > > > > > > > > +     struct mmc_blk_ioc_data **idata;
> > > > > > > > > +     unsigned int n;
> > > > > > > > > +
> > > > > > > > > +     idata =3D kcalloc(cmd_count, sizeof(*idata), GFP_KE=
RNEL);
> > > > > > > > > +     if (!idata)
> > > > > > > > > +             return NULL;
> > > > > > > > > +     for (n =3D 0; n < cmd_count; n++) {
> > > > > > > > > +             idata[n] =3D kcalloc(1, sizeof(**idata), GF=
P_KERNEL);
> > > > > > > > > +             if (!idata[n]) {
> > > > > > > > > +                     free_idata(idata, n);
> > > > > > > > > +                     return NULL;
> > > > > > > > > +             }
> > > > > > > > > +             idata[n]->rpmb =3D rpmb;
> > > > > > > > > +     }
> > > > > > > > > +
> > > > > > > > > +     return idata;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static void set_idata(struct mmc_blk_ioc_data *idata, u3=
2 opcode,
> > > > > > > > > +                   int write_flag, u8 *buf, unsigned int=
 buf_bytes)
> > > > > > > > > +{
> > > > > > > > > +     /*
> > > > > > > > > +      * The size of an RPMB frame must match what's expe=
cted by the
> > > > > > > > > +      * hardware.
> > > > > > > > > +      */
> > > > > > > > > +     BUILD_BUG_ON(sizeof(struct rpmb_frame) !=3D 512);
> > > > > > > > > +
> > > > > > > > > +     idata->ic.opcode =3D opcode;
> > > > > > > > > +     idata->ic.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
> > > > > > > > > +     idata->ic.write_flag =3D write_flag;
> > > > > > > > > +     idata->ic.blksz =3D sizeof(struct rpmb_frame);
> > > > > > > > > +     idata->ic.blocks =3D buf_bytes /  idata->ic.blksz;
> > > > > > > > > +     idata->buf =3D buf;
> > > > > > > >
> > > > > > > > I tested the series on a i.MX8MM with a eMMC connected via =
the imx-sdhci
> > > > > > > > controller. Reading from RPMB does not work. It ends in tim=
eouts due to
> > > > > > > > no response from the SDHCI controller.
> > > > > > > >
> > > > > > > > If idata->buf is allocated here with kmalloc(buf_bytes, GFP=
_KERNEL) and
> > > > > > > > the content of buf is copied to the new allocated area, tra=
nsfers succeed.
> > > > > > > >
> > > > > > > > Is it possible that idata->buf is not DMA capable? Any othe=
r ideas?
> > > > > > >
> > > > > > > Thanks for testing. I don't know, the idata->buf is allocated=
 using
> > > > > > > alloc_pages_exact(nr_pages * PAGE_SIZE, GFP_KERNEL | __GFP_ZE=
RO); in
> > > > > > > optee_pool_op_alloc_helper().
> > > > > >
> > > > > > Is this really true for idata->buf or isnt the complete RPMB fr=
ame memory
> > > > > > allocated like this and therefore idata->buf not page aligned?
> > > > >
> > > > > You're right.
> > > > >
> > > > > >
> > > > > > For RPMB via tee-supplicant the idata->buf is allocated within =
memdup_user
> > > > > > and therefore page aligned.
> > > > >
> > > > > Yes, that's a difference. Have you tested with page-aligned buffe=
rs to
> > > > > see if it helps?
> > > >
> > > > Yes, this helps. I tested with the following patch, but probably it=
 can also
> > > > be solved during frame allocation in optee?
> > >
> > > Great, thanks for confirming. Yes, we should fix that in the secure w=
orld.
> >
> > I've pushed an update to
> > https://github.com/jenswi-linaro/optee_os/tree/rpmb_probe
>
> Thanks for taking care. I applied the additional patch
>
> https://github.com/OP-TEE/optee_os/commit/cdbe8d149f1eed62bc8ef9137d20885=
8bb7691d8.patch
>
> to optee_os and removed the kmalloc dynalloc hack mentioned before from t=
he
> kernel.
>
> The issue persists, please see below.

So it's not the alignment that is the problem. We need to understand
this problem better before adding workarounds. If I'm not mistaken,
alloc_pages_exact () and kmalloc() are supposed to provide DMAable
memory. Could this be a symptom of some other error in your system?

Thanks,
Jens

>
> Thanks for your support
> Manuel
>
> E/TC:? 0
> E/TC:? 0 TA panicked with code 0xffff0006
> [   18.661761] mmc0: Timeout waiting for hardware interrupt.
> [   18.661776] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI RE=
GISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> E/LD:  Status of TA bc50d971-d4c9-42c4-82cb-343fb7f37896
> E/LD:   arch: arm
> E/LD:  region  0: va 0x40005000 pa 0xbe81b000 size 0x002000 flags rw-s (l=
delf)
> E/LD:  region  1: va 0x40007000 pa 0xbe81d000 size 0x008000 flags r-xs (l=
delf)
> E/LD:  region  2: va 0x4000f000 pa 0xbe825000 size 0x001000 flags rw-s (l=
delf)
> E/LD:  region  3: va 0x40010000 pa 0xbe826000 size 0x004000 flags rw-s (l=
delf)
> E/LD:  region  4: va 0x40014000 pa 0xbe82a000 size 0x001000 flags r--s
> E/LD:  region  5: va 0x40015000 pa 0xbe88b000 size 0x011000 flags rw-s (s=
tack)
> E/LD:  region  6: va 0x40026000 pa 0x534f8000 size 0x002000 flags rw-- (p=
aram)
> E/LD:  region  7: va 0x40035000 pa 0x00001000 size 0x042000 flags r-xs [0=
]
> E/LD:  region  8: va 0x40077000 pa 0x00043000 size 0x01e000 flags rw-s [0=
]
> E/LD:   [0] bc50d971-d4c9-42c4-82cb-343fb7f37896 @ 0x40035000
> E/LD:  Call stack:
> E/LD:   0x40064d48
> E/LD:   0x40060c17
> E/LD:   0x40037d81
> E/LD:   0x40038223
> E/LD:   0x4004d343
> E/LD:   0x4005d52d
> E/LD:   0x4003885f
> E/LD:   0x40064cd9
> E/LD:   0x4006a8a3
> E/LD:   0x4005d68c
> [   18.661782] mmc0: sdhci: Sys addr:  0x00000008 | Version:  0x00000002
> [   18.661790] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000006
> [   18.661796] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x0000003b
> [   18.661802] mmc0: sdhci: Present:   0x01088a8e | Host ctl: 0x00000031
> [   18.661808] mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
> [   18.661814] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000000f
> [   18.661820] mmc0: sdhci: Timeout:   0x0000008f | Int stat: 0x00000000
> [   18.661825] mmc0: sdhci: Int enab:  0x117f100b | Sig enab: 0x117f100b
> [   18.661831] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000502
> [   18.661837] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x0000b407
> [   18.661842] mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x00ffffff
> [   18.661848] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
> [   18.661856] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00000900
> [   18.661862] mmc0: sdhci: Host ctl2: 0x00000008
> [   18.661868] mmc0: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0x412c0200
> [   18.661874] mmc0: sdhci-esdhc-imx: =3D=3D=3D=3D=3D=3D=3D=3D=3D ESDHC I=
MX DEBUG STATUS DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   18.661879] mmc0: sdhci-esdhc-imx: cmd debug status:  0x2120
> [   18.661885] mmc0: sdhci-esdhc-imx: data debug status:  0x22d0
> [   18.661893] mmc0: sdhci-esdhc-imx: trans debug status:  0x23c0
> [   18.661900] mmc0: sdhci-esdhc-imx: dma debug status:  0x2400
> [   18.661907] mmc0: sdhci-esdhc-imx: adma debug status:  0x25b4
> [   18.661915] mmc0: sdhci-esdhc-imx: fifo debug status:  0x2650
> [   18.661922] mmc0: sdhci-esdhc-imx: async fifo debug status:  0x2760
> [   18.661929] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> [   18.662615] sdhci-esdhc-imx 30b40000.mmc: __mmc_blk_ioctl_cmd: data er=
ror -110
> [   18.772374] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke erro=
r: 0xffff3024
> [   18.772393] tpm tpm0: tpm_try_transmit: send(): error -53212
> [   18.772447] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke erro=
r: 0xffff3024
> [   18.772455] tpm tpm0: tpm_try_transmit: send(): error -53212
> [   18.772465] ftpm-tee tpm: ftpm_tee_probe: tpm_chip_register failed wit=
h rc=3D-53212
> [   18.772545] ftpm-tee: probe of tpm failed with error -53212
> [   19.430011] caam_jr 30902000.jr: 20000254: CCB: desc idx 2: RNG: Not i=
nstantiated
> [   28.901794] mmc0: Timeout waiting for hardware interrupt.
> [  *** ] (1 of 2) Job dev-tpmrm0.device/start running (37s / 1min 30s)
> [ ***  ] (2 of 2) Job dev-tpm0.device/start running (47s / 1min 30s)
> [ ***  ] (2 of 2) Job dev-tpm0.device/start
>

