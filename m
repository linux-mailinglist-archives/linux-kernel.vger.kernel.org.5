Return-Path: <linux-kernel+bounces-153017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389F28AC7B8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8B31C20D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCD454677;
	Mon, 22 Apr 2024 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aK8tzghh"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A6A5FB8B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775735; cv=none; b=k7UlHYrFHLDyMpyQxS51yInx1H3QrEa1A5aJmRwoIf/wqG9LtW14A9iDAAyIFkgK0ggZ/l5/8cmQCqPKEuXqnWHjQYibDJnui7Bl8UoXPSmvpCTWIU9QO05CrKHma4VPYBRlUX+pNuMe9pyUmB6u+NCLagOTDYnTKuOER9MSO4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775735; c=relaxed/simple;
	bh=9iHNxwxomnrMfGQgNFjZ3CG66BTHVDDH0Ni7B12K9Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRhdfzGfUSOVnUNx+THe4wIS3wtN7i5ZNDHz9Ywjsjc39+arN7uoByldACzRgI4dL/22QkAzW/cTJEaGQVkSoV3Ydsba0O2HyEzSjOGKcUXOinvYGajw7mfPUt+aMhgECDTDrtbugAEakO5crdptYfvFvNtk5kCODZy25vrYY7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aK8tzghh; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa1e9527d1so3480291eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713775731; x=1714380531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgxzw58wvLAM03SMFXqqLH2EsCFNJlWqlh0Z96TDb1E=;
        b=aK8tzghh5OyPAUgB2LQ3TiFnvvovjWjUufNUQ22zVUwYDjV0M7pNoIpumdnlEXcsvR
         035la+bLTYAJ2AMXcOEqiGxZcytr3OML20E9rNEqCS1HKmtlU/3cc2RDD0Wgc3aMCcat
         VHBTWifj4VDNWUUJ6GbShvwGbGdNgAVMbbf4DVc1HXj+aahUrvd0Lxi2WSVCsMClXEWB
         JCLAtp8VeG8Xyf72H4K5FyuvjOSelNUKsuicAXZH3xPzrRmrvgIq/uGo0pFnkguPF3In
         +4jAR7yPDsGMQa8iCBgUmX2uwQva2hVOW7WNBxGHO9StYchGAA3KqQHsTwdS9mAkn/H0
         SStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713775731; x=1714380531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgxzw58wvLAM03SMFXqqLH2EsCFNJlWqlh0Z96TDb1E=;
        b=kL/FlXX+ZVXC+3sgdAldwvDz+GYFucf1rB2OFxkfXWUbfmTNYcJSCofmf023hX+cAv
         wCfvK2wtdxE13C3086aEieZeTg/34/I7BrtduoLf07bUAKDPp8+kqX4Vg356YV4L8Amk
         u3CMBamdp6EEreXY7I7Vm5t1D6xOgTLC4tY90s7Ym5D8+nJJGc/iNtpGcU6TLOWGfeVq
         bQxokpXH15AcNMr1NoGYZ8dKDbQhFIDX5J1qXrip5LaeuieVNZr8/FVi1H9uOPQMbRWX
         axNsG99dOoaVxhtdYPXo6ofHaPUX1zjrOznW95Ycwsp9GP++uSe5G++vssgy2H48s57d
         kdmA==
X-Gm-Message-State: AOJu0YyVGHwqkTYbTQil8dntYRhSteQ9/51QPHxqUvrYZoIcRBv+mZPG
	H5/WnMmW2+mJDV56Fo0pcZ6B4RD7b/OVhn7NbsUs7duSO9XTiSoxLJI0JAigUPBQX1mA15WASmX
	QW1QoLhrQNWJqScNOwOeN7TNmSRh5vvx98jwJMw==
X-Google-Smtp-Source: AGHT+IGtiUmkgKyKouzY5KwBF9uou/45N2hHUFpx5r/6a1FkRRwbnS4Y0yacyb3vq2oDy7UVjQilXVIcMBYuRx484WI=
X-Received: by 2002:a05:6820:27c2:b0:5ad:ec6:bef1 with SMTP id
 dd2-20020a05682027c200b005ad0ec6bef1mr9560355oob.0.1713775731089; Mon, 22 Apr
 2024 01:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405115318.904143-1-jens.wiklander@linaro.org>
 <20240405115318.904143-4-jens.wiklander@linaro.org> <CAFA6WYPhe=Rqb50LQWu1H7D-WZw8dd7Ky3JgqOPFdmqbuKoVnQ@mail.gmail.com>
 <CAHUa44GE=0ggR-P52AnSfx0rSQcuN2_SNGn35knROkD91WpBGQ@mail.gmail.com> <CAFA6WYPyTAKr7G1RFtASkJf2qYRqMyHRcAphGn35ynQCyemQjQ@mail.gmail.com>
In-Reply-To: <CAFA6WYPyTAKr7G1RFtASkJf2qYRqMyHRcAphGn35ynQCyemQjQ@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 22 Apr 2024 10:48:39 +0200
Message-ID: <CAHUa44G+54ao-ZxBrh4Lrtv8po3aCsu8JQxEKGLjrmeO7F6HSw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] optee: probe RPMB device using RPMB subsystem
To: Sumit Garg <sumit.garg@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 9:06=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Thu, 11 Apr 2024 at 12:23, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Hi Sumit,
> >
> > On Wed, Apr 10, 2024 at 12:48=E2=80=AFPM Sumit Garg <sumit.garg@linaro.=
org> wrote:
> > >
> > > Hi Jens,
> > >
> > > On Fri, 5 Apr 2024 at 17:23, Jens Wiklander <jens.wiklander@linaro.or=
g> wrote:
> > > >
> > > > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to prob=
e and
> > > > use an RPMB device via the RPBM subsystem instead of passing the RP=
MB
> > >
> > > s/RPBM/RPMB/
> >
> > Thanks, I'll fix it.
> >
> > >
> > > > frames via tee-supplicant in user space. A fallback mechanism is ke=
pt to
> > > > route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> > > > available.
> > > >
> > > > The OP-TEE RPC ABI is extended to support iterating over all RPMB
> > > > devices until one is found with the expected RPMB key already
> > > > programmed.
> > > >
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > ---
> > > >  drivers/tee/optee/core.c          |  30 ++++
> > > >  drivers/tee/optee/device.c        |   7 +
> > > >  drivers/tee/optee/ffa_abi.c       |   8 +
> > > >  drivers/tee/optee/optee_private.h |  21 ++-
> > > >  drivers/tee/optee/optee_rpc_cmd.h |  35 +++++
> > > >  drivers/tee/optee/rpc.c           | 233 ++++++++++++++++++++++++++=
++++
> > > >  drivers/tee/optee/smc_abi.c       |   7 +
> > > >  7 files changed, 340 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > > index 3aed554bc8d8..082691c10a90 100644
> > > > --- a/drivers/tee/optee/core.c
> > > > +++ b/drivers/tee/optee/core.c
> > > > @@ -11,6 +11,7 @@
> > > >  #include <linux/io.h>
> > > >  #include <linux/mm.h>
> > > >  #include <linux/module.h>
> > > > +#include <linux/rpmb.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/string.h>
> > > >  #include <linux/tee_drv.h>
> > > > @@ -80,6 +81,31 @@ void optee_pool_op_free_helper(struct tee_shm_po=
ol *pool, struct tee_shm *shm,
> > > >         shm->pages =3D NULL;
> > > >  }
> > > >
> > > > +void optee_bus_scan_rpmb(struct work_struct *work)
> > > > +{
> > > > +       struct optee *optee =3D container_of(work, struct optee,
> > > > +                                          rpmb_scan_bus_work);
> > > > +       int ret;
> > > > +
> > > > +       if (!optee->rpmb_scan_bus_done) {
> > > > +               ret =3D optee_enumerate_devices(PTA_CMD_GET_DEVICES=
_RPMB);
> > > > +               optee->rpmb_scan_bus_done =3D !ret;
> > > > +               if (ret && ret !=3D -ENODEV)
> > > > +                       pr_info("Scanning for RPMB device: ret %d\n=
", ret);
> > > > +       }
> > > > +}
> > > > +
> > > > +int optee_rpmb_intf_rdev(struct notifier_block *intf, unsigned lon=
g action,
> > > > +                        void *data)
> > > > +{
> > > > +       struct optee *optee =3D container_of(intf, struct optee, rp=
mb_intf);
> > > > +
> > > > +       if (action =3D=3D RPMB_NOTIFY_ADD_DEVICE)
> > > > +               schedule_work(&optee->rpmb_scan_bus_work);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  static void optee_bus_scan(struct work_struct *work)
> > > >  {
> > > >         WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> > > > @@ -161,6 +187,8 @@ void optee_release_supp(struct tee_context *ctx=
)
> > > >
> > > >  void optee_remove_common(struct optee *optee)
> > > >  {
> > > > +       rpmb_interface_unregister(&optee->rpmb_intf);
> > > > +       cancel_work_sync(&optee->rpmb_scan_bus_work);
> > > >         /* Unregister OP-TEE specific client devices on TEE bus */
> > > >         optee_unregister_devices();
> > > >
> > > > @@ -177,6 +205,8 @@ void optee_remove_common(struct optee *optee)
> > > >         tee_shm_pool_free(optee->pool);
> > > >         optee_supp_uninit(&optee->supp);
> > > >         mutex_destroy(&optee->call_queue.mutex);
> > > > +       rpmb_dev_put(optee->rpmb_dev);
> > > > +       mutex_destroy(&optee->rpmb_dev_mutex);
> > > >  }
> > > >
> > > >  static int smc_abi_rc;
> > > > diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.=
c
> > > > index 4b1092127694..4274876857c8 100644
> > > > --- a/drivers/tee/optee/device.c
> > > > +++ b/drivers/tee/optee/device.c
> > > > @@ -43,6 +43,13 @@ static int get_devices(struct tee_context *ctx, =
u32 session,
> > > >         ret =3D tee_client_invoke_func(ctx, &inv_arg, param);
> > > >         if ((ret < 0) || ((inv_arg.ret !=3D TEEC_SUCCESS) &&
> > > >                           (inv_arg.ret !=3D TEEC_ERROR_SHORT_BUFFER=
))) {
> > > > +               /*
> > > > +                * TEE_ERROR_STORAGE_NOT_AVAILABLE is returned when=
 getting
> > > > +                * the list of device TAs that depends on RPMB but =
a usable
> > > > +                * RPMB device isn't found.
> > > > +                */
> > > > +               if (inv_arg.ret =3D=3D TEE_ERROR_STORAGE_NOT_AVAILA=
BLE)
> > > > +                       return -ENODEV;
> > > >                 pr_err("PTA_CMD_GET_DEVICES invoke function err: %x=
\n",
> > > >                        inv_arg.ret);
> > > >                 return -EINVAL;
> > > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_ab=
i.c
> > > > index ecb5eb079408..a8dfdb30b4e8 100644
> > > > --- a/drivers/tee/optee/ffa_abi.c
> > > > +++ b/drivers/tee/optee/ffa_abi.c
> > > > @@ -7,6 +7,7 @@
> > > >
> > > >  #include <linux/arm_ffa.h>
> > > >  #include <linux/errno.h>
> > > > +#include <linux/rpmb.h>
> > > >  #include <linux/scatterlist.h>
> > > >  #include <linux/sched.h>
> > > >  #include <linux/slab.h>
> > > > @@ -934,6 +935,7 @@ static int optee_ffa_probe(struct ffa_device *f=
fa_dev)
> > > >         optee_cq_init(&optee->call_queue, 0);
> > > >         optee_supp_init(&optee->supp);
> > > >         optee_shm_arg_cache_init(optee, arg_cache_flags);
> > > > +       mutex_init(&optee->rpmb_dev_mutex);
> > > >         ffa_dev_set_drvdata(ffa_dev, optee);
> > > >         ctx =3D teedev_open(optee->teedev);
> > > >         if (IS_ERR(ctx)) {
> > > > @@ -955,6 +957,9 @@ static int optee_ffa_probe(struct ffa_device *f=
fa_dev)
> > > >         if (rc)
> > > >                 goto err_unregister_devices;
> > > >
> > > > +       INIT_WORK(&optee->rpmb_scan_bus_work, optee_bus_scan_rpmb);
> > > > +       optee->rpmb_intf.notifier_call =3D optee_rpmb_intf_rdev;
> > > > +       rpmb_interface_register(&optee->rpmb_intf);
> > > >         pr_info("initialized driver\n");
> > > >         return 0;
> > > >
> > > > @@ -968,6 +973,9 @@ static int optee_ffa_probe(struct ffa_device *f=
fa_dev)
> > > >         teedev_close_context(ctx);
> > > >  err_rhashtable_free:
> > > >         rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free=
_fn, NULL);
> > > > +       rpmb_dev_put(optee->rpmb_dev);
> > > > +       mutex_destroy(&optee->rpmb_dev_mutex);
> > > > +       rpmb_interface_unregister(&optee->rpmb_intf);
> > > >         optee_supp_uninit(&optee->supp);
> > > >         mutex_destroy(&optee->call_queue.mutex);
> > > >         mutex_destroy(&optee->ffa.mutex);
> > > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/=
optee_private.h
> > > > index 7a5243c78b55..ae72f3dda1d2 100644
> > > > --- a/drivers/tee/optee/optee_private.h
> > > > +++ b/drivers/tee/optee/optee_private.h
> > > > @@ -8,6 +8,7 @@
> > > >
> > > >  #include <linux/arm-smccc.h>
> > > >  #include <linux/rhashtable.h>
> > > > +#include <linux/rpmb.h>
> > > >  #include <linux/semaphore.h>
> > > >  #include <linux/tee_drv.h>
> > > >  #include <linux/types.h>
> > > > @@ -20,11 +21,13 @@
> > > >  /* Some Global Platform error codes used in this driver */
> > > >  #define TEEC_SUCCESS                   0x00000000
> > > >  #define TEEC_ERROR_BAD_PARAMETERS      0xFFFF0006
> > > > +#define TEEC_ERROR_ITEM_NOT_FOUND      0xFFFF0008
> > > >  #define TEEC_ERROR_NOT_SUPPORTED       0xFFFF000A
> > > >  #define TEEC_ERROR_COMMUNICATION       0xFFFF000E
> > > >  #define TEEC_ERROR_OUT_OF_MEMORY       0xFFFF000C
> > > >  #define TEEC_ERROR_BUSY                        0xFFFF000D
> > > >  #define TEEC_ERROR_SHORT_BUFFER                0xFFFF0010
> > > > +#define TEE_ERROR_STORAGE_NOT_AVAILABLE 0xF0100003
> > > >
> > > >  #define TEEC_ORIGIN_COMMS              0x00000002
> > > >
> > > > @@ -197,6 +200,12 @@ struct optee_ops {
> > > >   * @notif:             notification synchronization struct
> > > >   * @supp:              supplicant synchronization struct for RPC t=
o supplicant
> > > >   * @pool:              shared memory pool
> > > > + * @mutex:             mutex protecting @rpmb_dev
> > > > + * @rpmb_dev:          current RPMB device or NULL
> > > > + * @rpmb_scan_bus_done flag if device registation of RPMB dependen=
t devices
> > > > + *                     was already done
> > > > + * @rpmb_scan_bus_work workq to for an RPMB device and to scan opt=
ee bus
> > > > + *                     and register RPMB dependent optee drivers
> > > >   * @rpc_param_count:   If > 0 number of RPC parameters to make roo=
m for
> > > >   * @scan_bus_done      flag if device registation was already done=
.
> > > >   * @scan_bus_work      workq to scan optee bus and register optee =
drivers
> > > > @@ -215,9 +224,15 @@ struct optee {
> > > >         struct optee_notif notif;
> > > >         struct optee_supp supp;
> > > >         struct tee_shm_pool *pool;
> > > > +       /* Protects rpmb_dev pointer */
> > > > +       struct mutex rpmb_dev_mutex;
> > > > +       struct rpmb_dev *rpmb_dev;
> > > > +       struct notifier_block rpmb_intf;
> > > >         unsigned int rpc_param_count;
> > > > -       bool   scan_bus_done;
> > > > +       bool scan_bus_done;
> > > > +       bool rpmb_scan_bus_done;
> > > >         struct work_struct scan_bus_work;
> > > > +       struct work_struct rpmb_scan_bus_work;
> > > >  };
> > > >
> > > >  struct optee_session {
> > > > @@ -280,8 +295,12 @@ int optee_cancel_req(struct tee_context *ctx, =
u32 cancel_id, u32 session);
> > > >
> > > >  #define PTA_CMD_GET_DEVICES            0x0
> > > >  #define PTA_CMD_GET_DEVICES_SUPP       0x1
> > > > +#define PTA_CMD_GET_DEVICES_RPMB       0x2
> > > >  int optee_enumerate_devices(u32 func);
> > > >  void optee_unregister_devices(void);
> > > > +void optee_bus_scan_rpmb(struct work_struct *work);
> > > > +int optee_rpmb_intf_rdev(struct notifier_block *intf, unsigned lon=
g action,
> > > > +                        void *data);
> > > >
> > > >  int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct t=
ee_shm *shm,
> > > >                                size_t size, size_t align,
> > > > diff --git a/drivers/tee/optee/optee_rpc_cmd.h b/drivers/tee/optee/=
optee_rpc_cmd.h
> > > > index f3f06e0994a7..f351a8ac69fc 100644
> > > > --- a/drivers/tee/optee/optee_rpc_cmd.h
> > > > +++ b/drivers/tee/optee/optee_rpc_cmd.h
> > > > @@ -16,6 +16,14 @@
> > > >   * and sends responses.
> > > >   */
> > > >
> > > > +/*
> > > > + * Replay Protected Memory Block access
> > > > + *
> > > > + * [in]     memref[0]      Frames to device
> > > > + * [out]    memref[1]      Frames from device
> > > > + */
> > > > +#define OPTEE_RPC_CMD_RPMB             1
> > > > +
> > > >  /*
> > > >   * Get time
> > > >   *
> > > > @@ -103,4 +111,31 @@
> > > >  /* I2C master control flags */
> > > >  #define OPTEE_RPC_I2C_FLAGS_TEN_BIT    BIT(0)
> > > >
> > > > +/*
> > > > + * Reset RPMB probing
> > > > + *
> > > > + * Releases an eventually already used RPMB devices and starts ove=
r searching
> > > > + * for RPMB devices. Returns the kind of shared memory to use in s=
ubsequent
> > > > + * OPTEE_RPC_CMD_RPMB_PROBE_NEXT and OPTEE_RPC_CMD_RPMB calls.
> > > > + *
> > > > + * [out]    value[0].a     OPTEE_RPC_SHM_TYPE_*, the parameter for
> > > > + *                         OPTEE_RPC_CMD_SHM_ALLOC
> > > > + */
> > > > +#define OPTEE_RPC_CMD_RPMB_PROBE_RESET 22
> > > > +
> > >
> > > AFAICS from [1], this RPMB reset probing is only used to check if the
> > > kernel supports RPMB probing or not. I suppose that should be detecte=
d
> > > via a single RPC call like: OPTEE_RPC_CMD_RPMB_PROBE. Other than that
> > > the shared memory allocation type can be used as
> > > THREAD_SHM_TYPE_KERNEL_PRIVATE if OPTEE_RPC_CMD_RPMB_PROBE works
> > > otherwise THREAD_SHM_TYPE_APPLICATION can be used for legacy RPMB ini=
t
> > > via tee-supplicant.
> > >
> > > Is there any other specific scenario I am missing which requires an
> > > explicit RPMB probe reset call?
> >
> > That assumes that we're not going to implement
> > OPTEE_RPC_CMD_RPMB_PROBE_RESET and OPTEE_RPC_CMD_RPMB_PROBE_NEXT in
> > the tee-supplicant. We should implement those RPCs in the
> > tee-supplicant too since it solves the problem with finding the RPMB
> > device without device-specific runtime arguments for the
> > tee-supplicant.
>
> IMO, we should try to deprecate the tee-supplicant accesses to
> hardware RPMB. The tee-supplicant can be useful for RPMB emulation
> scenarios where we shouldn't require the dynamic discovery of RPMB.

There's no rush to do that, there's not too much maintenance. We can
discuss the next step once this is upstream.

>
> >
> > I'd also like to keep the ABI flexible so we for instance can handle a
> > removable RPMB from the secure world.
>
> That's an interesting scenario but I am not sure if we really would
> like to deal with the complications of removable RPMB like what we
> should do if a TA is accessing RPMB during which it is hot plugged?

We may need to panic the TA if the RPMB is unplugged at an unfavorable
moment. It's a special case, but it would be nice to resume RPMB
access once it's plugged in.

>
> However, I am in favour of an ABI which is simple enough to maintain
> and allow flexibility for extension like adding a new RPC when it's
> really needed etc.

Thanks,
Jens

