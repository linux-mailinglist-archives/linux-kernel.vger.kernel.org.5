Return-Path: <linux-kernel+bounces-48023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1D1845661
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0245D287D80
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8D515D5A0;
	Thu,  1 Feb 2024 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzxcYQrl"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70688159594
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787622; cv=none; b=scUSvIJKl6L39Ro1z/3RM1lTFO66kkt25apU7L6SrPoeECwmlBeKdVcQHvsmuXLaOl/aGLZC86qGkW9MBaHvjc0186KPjwsFQGkjDEqIE1EqcsxEVs0Z1RE5aEHdu+h2V9py2Bzmrq4rFpFxyTyCe5ky1h7Ozg29j56WfQaF4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787622; c=relaxed/simple;
	bh=xMQvn+3/7VxppgPzMp6SZaEthWwq5m0xzQXxCB1laBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8j8Ho4jvJz1pRSWkaSUTqJVMX7VzG2+N07k0REIwhZVllKxoMgGjpuYaqJWMvJ1b6t+NT+lH8vGlzPBelZhiaKPot0fT9CmJ+sECAxR9LovutVpqD9uuivyKcvm8jzWODJ1IsxJrhKmsoNYn4U31e146di05R4RTi9pJPOd808=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bzxcYQrl; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-218dc74d850so465565fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 03:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706787619; x=1707392419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsOmF+VJyJPCVpINC1+gSR9aC4HOHHZSQfGRhLfWLS0=;
        b=bzxcYQrlU303VgM2uJvffEKDCDTaQoOqyOjf3sh+8DLfsCJebyu0QaFn+vD5Ys+iLU
         8HXdE7woO++X6i/HFkV7Bcmihi4ZI+vNguASeuAthMlRVvFo7kweILRIgwJf7aHwEoct
         8AZnJqcdzCyPRIhMKlJisHX1eYaap0ssi47jAioDHaZCHPztLfy+wPTS5bG9Fgr+MJPO
         ygUKEXA/JtxHJwvDoGpKm85bqUM096AQ6rdlENsVfi5lEhJpaiklE4EFSFsM706ibVgH
         hDMmIj8jJ1P8uBMZaE60fcUsv5nJNYXzPScf/lQIwqPUE9Dqccs3Gqy89U68ckyI7yCP
         1FtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706787619; x=1707392419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsOmF+VJyJPCVpINC1+gSR9aC4HOHHZSQfGRhLfWLS0=;
        b=mCLzKYgEbNcN+XigvzHXSTRXBLhyRnkUiQCu2vCfWcLGlLeYR/GfYpLsaX80tD+yzy
         RKTMFjyC/jDrtUL3VQPJSW9XollftGC578A6m5d16HURJ0jgab282bpKEqs4Al/EVD1j
         lYJziW3TLzN35wJKD+79nnPTGn4qG177Pn/j/Wekc5JAS60loM8TyiZddqi6lA+nDcF+
         dq0QfRqavFpahhC1YyHqkblKGrHGsJZpzChBAnInA7eOgsbH1sawTHHzw8EAD7dtgBnw
         8OVSpW3zUqHlMbZhcvAVol6IrhBCgrjYMlOgtw9oL0O3hhbkEe647mtdnXe2PihYRGK5
         XVzA==
X-Gm-Message-State: AOJu0Ywu6ylqt7W+IsDakYR3uk2CUMC8Akiu17u5QFHx8geA6sJ+PPa2
	pYvpavVbzoCG08Wth0wodWAYo5qHHk8mG2i3j+39Suw+N6eaKNGJ9Q5I0j1/N6n/MA8Ej7N2x33
	UmGtnHKTjPmwOBPSgu0iRbUeZqCezhKafXoBvTQ==
X-Google-Smtp-Source: AGHT+IHCkkuWvE8lAV/8v7/smjyAnSq/mMasOVQX6v8ay/XTTa+vUuTC4FG0WDsE+5QE6QjlfsVhKY940rksvBEbRKQ=
X-Received: by 2002:a05:6870:d60b:b0:214:cd76:caf5 with SMTP id
 a11-20020a056870d60b00b00214cd76caf5mr4820849oaq.24.1706787619499; Thu, 01
 Feb 2024 03:40:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
 <20240131174347.510961-3-jens.wiklander@linaro.org> <Zbth2wZ+TtGuCJux@trax>
In-Reply-To: <Zbth2wZ+TtGuCJux@trax>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 1 Feb 2024 12:40:08 +0100
Message-ID: <CAHUa44HjVGPLHajrppL5=YQuOHns-ccCTLYCrEmrYYfe+X1Usg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: block: register RPMB partition with the RPMB subsystem
To: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	Alexander Usyskin <alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 10:18=E2=80=AFAM Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:
>
> On 31/01/24 18:43:46, Jens Wiklander wrote:
> > Register eMMC RPMB partition with the RPMB subsystem and provide
> > an implementation for the RPMB access operations abstracting
> > the actual multi step process.
> >
> > Add callbacks for getting and putting the needed resources, that is, th=
e
> > RPMB data and the RPMB disk.
> >
> > Add a callback to extract the needed device information at registration
> > to avoid accessing the struct mmc_card at a later stage as we're not
> > holding a reference counter for this struct.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/mmc/core/block.c | 177 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 177 insertions(+)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index 32d49100dff5..5286e0b3a5a2 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/cdev.h>
> >  #include <linux/mutex.h>
> >  #include <linux/scatterlist.h>
> > +#include <linux/string.h>
> >  #include <linux/string_helpers.h>
> >  #include <linux/delay.h>
> >  #include <linux/capability.h>
> > @@ -40,6 +41,7 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/idr.h>
> >  #include <linux/debugfs.h>
> > +#include <linux/rpmb.h>
> >
> >  #include <linux/mmc/ioctl.h>
> >  #include <linux/mmc/card.h>
> > @@ -163,6 +165,7 @@ struct mmc_rpmb_data {
> >       int id;
> >       unsigned int part_index;
> >       struct mmc_blk_data *md;
> > +     struct rpmb_dev *rdev;
> >       struct list_head node;
> >  };
> >
> > @@ -2707,6 +2710,169 @@ static void mmc_blk_rpmb_device_release(struct =
device *dev)
> >       kfree(rpmb);
> >  }
> >
> > +static void rpmb_op_mmc_get_resources(struct device *dev)
> > +{
> > +     struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
> > +
> > +     /*
> > +      * When the MMC card is removed rpmb_dev_unregister() is called
> > +      * from mmc_blk_remove_rpmb_part(). That removes references to th=
e
> > +      * devices in struct mmc_rpmb_data and rpmb->md. Since struct
> > +      * rpmb_dev can still reach those structs we must hold a referenc=
e
> > +      * until struct rpmb_dev also is released.
> > +      *
> > +      * This is analogous to what's done in mmc_rpmb_chrdev_open() and
> > +      * mmc_rpmb_chrdev_release() below.
> > +      */
> > +     get_device(dev);
> > +     mmc_blk_get(rpmb->md->disk);
> > +}
> > +
> > +static void rpmb_op_mmc_put_resources(struct device *dev)
> > +{
> > +     struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
> > +
> > +     mmc_blk_put(rpmb->md);
> > +     put_device(dev);
> > +}
> > +
> > +static struct mmc_blk_ioc_data **alloc_idata(struct mmc_rpmb_data *rpm=
b,
> > +                                          unsigned int cmd_count)
> > +{
> > +     struct mmc_blk_ioc_data **idata;
> > +     unsigned int n;
> > +
> > +     idata =3D kcalloc(cmd_count, sizeof(*idata), GFP_KERNEL);
> > +     if (!idata)
> > +             return NULL;
> > +
> > +     for (n =3D 0; n < cmd_count; n++) {
> > +             idata[n] =3D kcalloc(1, sizeof(**idata), GFP_KERNEL);
> > +             if (!idata[n]) {
> > +                     kfree(idata);
>
> don't you need to unwind these allocations on error?
>

Yes, you're right.

Thanks,
Jens

> > +                     return NULL;
> > +             }
> > +             idata[n]->rpmb =3D rpmb;
> > +     }
> > +
> > +     return idata;
> > +}
> > +
> > +static void set_idata(struct mmc_blk_ioc_data *idata, u32 opcode,
> > +                   int write_flag, u8 *buf, unsigned int buf_bytes)
> > +{
> > +     idata->ic.opcode =3D opcode;
> > +     idata->ic.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
> > +     idata->ic.write_flag =3D write_flag;
> > +     idata->ic.blksz =3D sizeof(struct rpmb_frame);
> > +     idata->ic.blocks =3D buf_bytes /  idata->ic.blksz;
> > +     idata->buf =3D buf;
> > +     idata->buf_bytes =3D buf_bytes;
> > +}
> > +
> > +static void free_idata(struct mmc_blk_ioc_data **idata, unsigned int c=
md_count)
> > +{
> > +     unsigned int n;
> > +
> > +     for (n =3D 0; n < cmd_count; n++)
> > +             kfree(idata[n]);
> > +     kfree(idata);
> > +}
> > +
> > +static int rpmb_op_mmc_route_frames(struct device *dev, bool write, u8=
 *req,
> > +                                 unsigned int req_len, u8 *resp,
> > +                                 unsigned int resp_len)
> > +{
> > +     struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
> > +     struct mmc_blk_data *md =3D rpmb->md;
> > +     struct mmc_blk_ioc_data **idata;
> > +     unsigned int cmd_count;
> > +     struct request *rq;
> > +     int ret;
> > +
> > +     if (write)
> > +             cmd_count =3D 3;
> > +     else
> > +             cmd_count =3D 2;
> > +
> > +     if (IS_ERR(md->queue.card))
> > +             return PTR_ERR(md->queue.card);
> > +
> > +     idata =3D alloc_idata(rpmb, cmd_count);
> > +     if (!idata)
> > +             return -ENOMEM;
> > +
> > +     if (write) {
> > +             struct rpmb_frame *frm =3D (struct rpmb_frame *)resp;
> > +
> > +             /* Send write request frame(s) */
> > +             set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK,
> > +                       1 | MMC_CMD23_ARG_REL_WR, req, req_len);
> > +
> > +             /* Send result request frame */
> > +             memset(frm, 0, sizeof(*frm));
> > +             frm->req_resp =3D cpu_to_be16(RPMB_RESULT_READ);
> > +             set_idata(idata[1], MMC_WRITE_MULTIPLE_BLOCK, 1, resp,
> > +                       resp_len);
> > +
> > +             /* Read response frame */
> > +             set_idata(idata[2], MMC_READ_MULTIPLE_BLOCK, 0, resp, res=
p_len);
> > +     } else {
> > +             /* Send write request frame(s) */
> > +             set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK, 1, req, req=
_len);
> > +
> > +             /* Read response frame */
> > +             set_idata(idata[1], MMC_READ_MULTIPLE_BLOCK, 0, resp, res=
p_len);
> > +     }
> > +
> > +     rq =3D blk_mq_alloc_request(md->queue.queue, REQ_OP_DRV_OUT, 0);
> > +     if (IS_ERR(rq)) {
> > +             ret =3D PTR_ERR(rq);
> > +             goto out;
> > +     }
> > +
> > +     req_to_mmc_queue_req(rq)->drv_op =3D MMC_DRV_OP_IOCTL_RPMB;
> > +     req_to_mmc_queue_req(rq)->drv_op_result =3D -EIO;
> > +     req_to_mmc_queue_req(rq)->drv_op_data =3D idata;
> > +     req_to_mmc_queue_req(rq)->ioc_count =3D cmd_count;
> > +     blk_execute_rq(rq, false);
> > +     ret =3D req_to_mmc_queue_req(rq)->drv_op_result;
> > +
> > +     blk_mq_free_request(rq);
> > +
> > +out:
> > +     free_idata(idata, cmd_count);
> > +     return ret;
> > +}
> > +
> > +static int rpmb_op_mmc_set_dev_info(struct device *dev, struct rpmb_de=
v *rdev)
> > +{
> > +     struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
> > +     struct mmc_card *card =3D rpmb->md->queue.card;
> > +     unsigned int n;
> > +     u32 cid[4];
> > +
> > +     for (n =3D 0; n < 4; n++)
> > +             cid[n] =3D be32_to_cpu(card->raw_cid[n]);
> > +
> > +     rdev->dev_id =3D kmemdup(cid, sizeof(cid), GFP_KERNEL);
> > +     if (!rdev->dev_id)
> > +             return -ENOMEM;
> > +     rdev->dev_id_len =3D sizeof(cid);
> > +     rdev->reliable_wr_count =3D card->ext_csd.raw_rpmb_size_mult;
> > +     rdev->capacity =3D card->ext_csd.rel_sectors;
> > +
> > +     return 0;
> > +}
> > +
> > +static struct rpmb_ops rpmb_mmc_ops =3D {
> > +     .type =3D RPMB_TYPE_EMMC,
> > +     .get_resources =3D rpmb_op_mmc_get_resources,
> > +     .put_resources =3D rpmb_op_mmc_put_resources,
> > +     .route_frames =3D rpmb_op_mmc_route_frames,
> > +     .set_dev_info =3D rpmb_op_mmc_set_dev_info,
> > +};
> > +
> >  static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
> >                                  struct mmc_blk_data *md,
> >                                  unsigned int part_index,
> > @@ -2751,6 +2917,14 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_ca=
rd *card,
> >               goto out_put_device;
> >       }
> >
> > +     rpmb->rdev =3D rpmb_dev_register(&rpmb->dev, &rpmb_mmc_ops);
> > +     if (IS_ERR(rpmb->rdev)) {
> > +             pr_err("%s: could not register RPMB device\n", rpmb_name)=
;
> > +             ret =3D PTR_ERR(rpmb->rdev);
> > +             rpmb->rdev =3D NULL;
> > +             goto out_cdev_device_del;
> > +     }
> > +
> >       list_add(&rpmb->node, &md->rpmbs);
> >
> >       string_get_size((u64)size, 512, STRING_UNITS_2,
> > @@ -2762,6 +2936,8 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_car=
d *card,
> >
> >       return 0;
> >
> > +out_cdev_device_del:
> > +     cdev_device_del(&rpmb->chrdev, &rpmb->dev);
> >  out_put_device:
> >       put_device(&rpmb->dev);
> >       return ret;
> > @@ -2770,6 +2946,7 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_car=
d *card,
> >  static void mmc_blk_remove_rpmb_part(struct mmc_rpmb_data *rpmb)
> >
> >  {
> > +     rpmb_dev_unregister(rpmb->rdev);
> >       cdev_device_del(&rpmb->chrdev, &rpmb->dev);
> >       put_device(&rpmb->dev);
> >  }
> > --
> > 2.34.1
> >

