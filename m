Return-Path: <linux-kernel+bounces-142107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE5A8A27A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3AF283DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46A44AEE3;
	Fri, 12 Apr 2024 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hNCmohwj"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203571DDDB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905571; cv=none; b=HNS47fuASOALHu5isnuANn0FicovqqU6/qU8/SR4keMusRxM7qH3o3UNvWnNKgRq+NzgaSLyAMSKiT9wg/mvgsEmqg/+Dg3CucWPuAtQHOvScFLAWofNbgXEZzrnpH+kvlqJoKAs2OVR01FjikW1BYJhbAsRJuHPbu4OVI4M1zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905571; c=relaxed/simple;
	bh=tRy1Ie/x50JtBT1fGqNzSa8ffN/Y9DEvPlT0J6K/VMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqVoDhtH4Kr+paUUlyYrLjuUgX1w/gPuYKKUhOiSkw5HOACoRrRSeOaCBdXSzEeJ8rkhjhm2JOnxfy4mm90AEQX6mJlr546Q/WOTCJ1MshbUwfbxyqQVIRtzAMzGTYJ/5VBRKk0jZIsPqJ05U+hu6htoJFuTkaYfhFzykukpKFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hNCmohwj; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-47a337c18d3so270084137.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712905568; x=1713510368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLJ6WBpywrEkNYqayoCZ2xhXGhuIn8yJpIzmzY4EqOQ=;
        b=hNCmohwjd55EC7MfutLZFtFZhS/FIphu9ApH1RZk+8gy2rIIwvWxpdgBKFKE4auF2t
         hCMDdRzz0U0kAz7LyQKxuowRYxIOs82MsMk5C1Q4Py6Noh49f83omRTIiwA31/26eLQQ
         YKFgspGZwrguKGOXupJHPmHAJPG5k+ZwI/4MDaLF+tBTClSfYKLz8Z99XtZtbLX9XgDp
         X4l5FStwlurRqov8kfUo3KXdwHAlGgflqKh1zNoP5eROsa4QajkvEqJGm+80sTQGsS73
         d+sT+7ungZIq9lkLCEQHw4ePpxI9MdIUgUgGCfnKJhfVPo9NoBN8w6KCIv8Oq9HSIumW
         YR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712905568; x=1713510368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLJ6WBpywrEkNYqayoCZ2xhXGhuIn8yJpIzmzY4EqOQ=;
        b=NQcSe+l7lO5Z/yOvJxslJ/nVWfREpq6GOmHp6Lfk/bsvZPRZ7z4DFshMBFGOU8u7+c
         gJlT8d2u8aWro6yFRdOvfox/VjBy/8fcz/nYikvOEVPyghg7bDEaktmEjfZqmkBcNfU6
         YD/qd3ZpCTRSTTSxfihfY5QgynUGIs8NwMrKKTaKFn2TIvJUCI0d/aWFmBO+axF0ybCX
         WLg8Xxj9eXJw7GuC2RkmQ6tnxBpYk8EEDWSUXpwv2g8gRUfqP/vYsOh7av7o0jc90rS5
         IDpohFqA/BCO7l8nKirdJ8byBdn8bd3yRtLbSBycebZHko2BKqjIy/f0n/hgMtkRh8BF
         9YcQ==
X-Gm-Message-State: AOJu0YxFi3m2tgLkREjpyDHEZLXAbEu+ixRjYB/YcAZ3xM8cXVVasTaj
	m6Pg8hxpk7mT/q+VVQAC7c2LfMVH4NgTymeBgHNvQUsxAd4Mw7FSUVSJhNsUONavsMF5klFAOYY
	SSfbMDJAfM9R3I+L7bEkv9hZ56jTRiN0t92KkUQ==
X-Google-Smtp-Source: AGHT+IEjDbuqyVsk2qsjgXLJ1BSLivHipeJyGwAaSo0MDXRIX4RdrOSmAEgMHwJDjazyGnKsWl/R/AVcIFW2ShLFMak=
X-Received: by 2002:a05:6102:1593:b0:471:2478:71fd with SMTP id
 g19-20020a056102159300b00471247871fdmr2131259vsv.33.1712905567970; Fri, 12
 Apr 2024 00:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405115318.904143-1-jens.wiklander@linaro.org>
 <20240405115318.904143-4-jens.wiklander@linaro.org> <CAFA6WYPhe=Rqb50LQWu1H7D-WZw8dd7Ky3JgqOPFdmqbuKoVnQ@mail.gmail.com>
 <CAHUa44GE=0ggR-P52AnSfx0rSQcuN2_SNGn35knROkD91WpBGQ@mail.gmail.com>
In-Reply-To: <CAHUa44GE=0ggR-P52AnSfx0rSQcuN2_SNGn35knROkD91WpBGQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 12 Apr 2024 12:35:56 +0530
Message-ID: <CAFA6WYPyTAKr7G1RFtASkJf2qYRqMyHRcAphGn35ynQCyemQjQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] optee: probe RPMB device using RPMB subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Apr 2024 at 12:23, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Hi Sumit,
>
> On Wed, Apr 10, 2024 at 12:48=E2=80=AFPM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> >
> > Hi Jens,
> >
> > On Fri, 5 Apr 2024 at 17:23, Jens Wiklander <jens.wiklander@linaro.org>=
 wrote:
> > >
> > > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe =
and
> > > use an RPMB device via the RPBM subsystem instead of passing the RPMB
> >
> > s/RPBM/RPMB/
>
> Thanks, I'll fix it.
>
> >
> > > frames via tee-supplicant in user space. A fallback mechanism is kept=
 to
> > > route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> > > available.
> > >
> > > The OP-TEE RPC ABI is extended to support iterating over all RPMB
> > > devices until one is found with the expected RPMB key already
> > > programmed.
> > >
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > ---
> > >  drivers/tee/optee/core.c          |  30 ++++
> > >  drivers/tee/optee/device.c        |   7 +
> > >  drivers/tee/optee/ffa_abi.c       |   8 +
> > >  drivers/tee/optee/optee_private.h |  21 ++-
> > >  drivers/tee/optee/optee_rpc_cmd.h |  35 +++++
> > >  drivers/tee/optee/rpc.c           | 233 ++++++++++++++++++++++++++++=
++
> > >  drivers/tee/optee/smc_abi.c       |   7 +
> > >  7 files changed, 340 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > index 3aed554bc8d8..082691c10a90 100644
> > > --- a/drivers/tee/optee/core.c
> > > +++ b/drivers/tee/optee/core.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/io.h>
> > >  #include <linux/mm.h>
> > >  #include <linux/module.h>
> > > +#include <linux/rpmb.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/string.h>
> > >  #include <linux/tee_drv.h>
> > > @@ -80,6 +81,31 @@ void optee_pool_op_free_helper(struct tee_shm_pool=
 *pool, struct tee_shm *shm,
> > >         shm->pages =3D NULL;
> > >  }
> > >
> > > +void optee_bus_scan_rpmb(struct work_struct *work)
> > > +{
> > > +       struct optee *optee =3D container_of(work, struct optee,
> > > +                                          rpmb_scan_bus_work);
> > > +       int ret;
> > > +
> > > +       if (!optee->rpmb_scan_bus_done) {
> > > +               ret =3D optee_enumerate_devices(PTA_CMD_GET_DEVICES_R=
PMB);
> > > +               optee->rpmb_scan_bus_done =3D !ret;
> > > +               if (ret && ret !=3D -ENODEV)
> > > +                       pr_info("Scanning for RPMB device: ret %d\n",=
 ret);
> > > +       }
> > > +}
> > > +
> > > +int optee_rpmb_intf_rdev(struct notifier_block *intf, unsigned long =
action,
> > > +                        void *data)
> > > +{
> > > +       struct optee *optee =3D container_of(intf, struct optee, rpmb=
_intf);
> > > +
> > > +       if (action =3D=3D RPMB_NOTIFY_ADD_DEVICE)
> > > +               schedule_work(&optee->rpmb_scan_bus_work);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static void optee_bus_scan(struct work_struct *work)
> > >  {
> > >         WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> > > @@ -161,6 +187,8 @@ void optee_release_supp(struct tee_context *ctx)
> > >
> > >  void optee_remove_common(struct optee *optee)
> > >  {
> > > +       rpmb_interface_unregister(&optee->rpmb_intf);
> > > +       cancel_work_sync(&optee->rpmb_scan_bus_work);
> > >         /* Unregister OP-TEE specific client devices on TEE bus */
> > >         optee_unregister_devices();
> > >
> > > @@ -177,6 +205,8 @@ void optee_remove_common(struct optee *optee)
> > >         tee_shm_pool_free(optee->pool);
> > >         optee_supp_uninit(&optee->supp);
> > >         mutex_destroy(&optee->call_queue.mutex);
> > > +       rpmb_dev_put(optee->rpmb_dev);
> > > +       mutex_destroy(&optee->rpmb_dev_mutex);
> > >  }
> > >
> > >  static int smc_abi_rc;
> > > diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> > > index 4b1092127694..4274876857c8 100644
> > > --- a/drivers/tee/optee/device.c
> > > +++ b/drivers/tee/optee/device.c
> > > @@ -43,6 +43,13 @@ static int get_devices(struct tee_context *ctx, u3=
2 session,
> > >         ret =3D tee_client_invoke_func(ctx, &inv_arg, param);
> > >         if ((ret < 0) || ((inv_arg.ret !=3D TEEC_SUCCESS) &&
> > >                           (inv_arg.ret !=3D TEEC_ERROR_SHORT_BUFFER))=
) {
> > > +               /*
> > > +                * TEE_ERROR_STORAGE_NOT_AVAILABLE is returned when g=
etting
> > > +                * the list of device TAs that depends on RPMB but a =
usable
> > > +                * RPMB device isn't found.
> > > +                */
> > > +               if (inv_arg.ret =3D=3D TEE_ERROR_STORAGE_NOT_AVAILABL=
E)
> > > +                       return -ENODEV;
> > >                 pr_err("PTA_CMD_GET_DEVICES invoke function err: %x\n=
",
> > >                        inv_arg.ret);
> > >                 return -EINVAL;
> > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.=
c
> > > index ecb5eb079408..a8dfdb30b4e8 100644
> > > --- a/drivers/tee/optee/ffa_abi.c
> > > +++ b/drivers/tee/optee/ffa_abi.c
> > > @@ -7,6 +7,7 @@
> > >
> > >  #include <linux/arm_ffa.h>
> > >  #include <linux/errno.h>
> > > +#include <linux/rpmb.h>
> > >  #include <linux/scatterlist.h>
> > >  #include <linux/sched.h>
> > >  #include <linux/slab.h>
> > > @@ -934,6 +935,7 @@ static int optee_ffa_probe(struct ffa_device *ffa=
_dev)
> > >         optee_cq_init(&optee->call_queue, 0);
> > >         optee_supp_init(&optee->supp);
> > >         optee_shm_arg_cache_init(optee, arg_cache_flags);
> > > +       mutex_init(&optee->rpmb_dev_mutex);
> > >         ffa_dev_set_drvdata(ffa_dev, optee);
> > >         ctx =3D teedev_open(optee->teedev);
> > >         if (IS_ERR(ctx)) {
> > > @@ -955,6 +957,9 @@ static int optee_ffa_probe(struct ffa_device *ffa=
_dev)
> > >         if (rc)
> > >                 goto err_unregister_devices;
> > >
> > > +       INIT_WORK(&optee->rpmb_scan_bus_work, optee_bus_scan_rpmb);
> > > +       optee->rpmb_intf.notifier_call =3D optee_rpmb_intf_rdev;
> > > +       rpmb_interface_register(&optee->rpmb_intf);
> > >         pr_info("initialized driver\n");
> > >         return 0;
> > >
> > > @@ -968,6 +973,9 @@ static int optee_ffa_probe(struct ffa_device *ffa=
_dev)
> > >         teedev_close_context(ctx);
> > >  err_rhashtable_free:
> > >         rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_f=
n, NULL);
> > > +       rpmb_dev_put(optee->rpmb_dev);
> > > +       mutex_destroy(&optee->rpmb_dev_mutex);
> > > +       rpmb_interface_unregister(&optee->rpmb_intf);
> > >         optee_supp_uninit(&optee->supp);
> > >         mutex_destroy(&optee->call_queue.mutex);
> > >         mutex_destroy(&optee->ffa.mutex);
> > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/op=
tee_private.h
> > > index 7a5243c78b55..ae72f3dda1d2 100644
> > > --- a/drivers/tee/optee/optee_private.h
> > > +++ b/drivers/tee/optee/optee_private.h
> > > @@ -8,6 +8,7 @@
> > >
> > >  #include <linux/arm-smccc.h>
> > >  #include <linux/rhashtable.h>
> > > +#include <linux/rpmb.h>
> > >  #include <linux/semaphore.h>
> > >  #include <linux/tee_drv.h>
> > >  #include <linux/types.h>
> > > @@ -20,11 +21,13 @@
> > >  /* Some Global Platform error codes used in this driver */
> > >  #define TEEC_SUCCESS                   0x00000000
> > >  #define TEEC_ERROR_BAD_PARAMETERS      0xFFFF0006
> > > +#define TEEC_ERROR_ITEM_NOT_FOUND      0xFFFF0008
> > >  #define TEEC_ERROR_NOT_SUPPORTED       0xFFFF000A
> > >  #define TEEC_ERROR_COMMUNICATION       0xFFFF000E
> > >  #define TEEC_ERROR_OUT_OF_MEMORY       0xFFFF000C
> > >  #define TEEC_ERROR_BUSY                        0xFFFF000D
> > >  #define TEEC_ERROR_SHORT_BUFFER                0xFFFF0010
> > > +#define TEE_ERROR_STORAGE_NOT_AVAILABLE 0xF0100003
> > >
> > >  #define TEEC_ORIGIN_COMMS              0x00000002
> > >
> > > @@ -197,6 +200,12 @@ struct optee_ops {
> > >   * @notif:             notification synchronization struct
> > >   * @supp:              supplicant synchronization struct for RPC to =
supplicant
> > >   * @pool:              shared memory pool
> > > + * @mutex:             mutex protecting @rpmb_dev
> > > + * @rpmb_dev:          current RPMB device or NULL
> > > + * @rpmb_scan_bus_done flag if device registation of RPMB dependent =
devices
> > > + *                     was already done
> > > + * @rpmb_scan_bus_work workq to for an RPMB device and to scan optee=
 bus
> > > + *                     and register RPMB dependent optee drivers
> > >   * @rpc_param_count:   If > 0 number of RPC parameters to make room =
for
> > >   * @scan_bus_done      flag if device registation was already done.
> > >   * @scan_bus_work      workq to scan optee bus and register optee dr=
ivers
> > > @@ -215,9 +224,15 @@ struct optee {
> > >         struct optee_notif notif;
> > >         struct optee_supp supp;
> > >         struct tee_shm_pool *pool;
> > > +       /* Protects rpmb_dev pointer */
> > > +       struct mutex rpmb_dev_mutex;
> > > +       struct rpmb_dev *rpmb_dev;
> > > +       struct notifier_block rpmb_intf;
> > >         unsigned int rpc_param_count;
> > > -       bool   scan_bus_done;
> > > +       bool scan_bus_done;
> > > +       bool rpmb_scan_bus_done;
> > >         struct work_struct scan_bus_work;
> > > +       struct work_struct rpmb_scan_bus_work;
> > >  };
> > >
> > >  struct optee_session {
> > > @@ -280,8 +295,12 @@ int optee_cancel_req(struct tee_context *ctx, u3=
2 cancel_id, u32 session);
> > >
> > >  #define PTA_CMD_GET_DEVICES            0x0
> > >  #define PTA_CMD_GET_DEVICES_SUPP       0x1
> > > +#define PTA_CMD_GET_DEVICES_RPMB       0x2
> > >  int optee_enumerate_devices(u32 func);
> > >  void optee_unregister_devices(void);
> > > +void optee_bus_scan_rpmb(struct work_struct *work);
> > > +int optee_rpmb_intf_rdev(struct notifier_block *intf, unsigned long =
action,
> > > +                        void *data);
> > >
> > >  int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee=
_shm *shm,
> > >                                size_t size, size_t align,
> > > diff --git a/drivers/tee/optee/optee_rpc_cmd.h b/drivers/tee/optee/op=
tee_rpc_cmd.h
> > > index f3f06e0994a7..f351a8ac69fc 100644
> > > --- a/drivers/tee/optee/optee_rpc_cmd.h
> > > +++ b/drivers/tee/optee/optee_rpc_cmd.h
> > > @@ -16,6 +16,14 @@
> > >   * and sends responses.
> > >   */
> > >
> > > +/*
> > > + * Replay Protected Memory Block access
> > > + *
> > > + * [in]     memref[0]      Frames to device
> > > + * [out]    memref[1]      Frames from device
> > > + */
> > > +#define OPTEE_RPC_CMD_RPMB             1
> > > +
> > >  /*
> > >   * Get time
> > >   *
> > > @@ -103,4 +111,31 @@
> > >  /* I2C master control flags */
> > >  #define OPTEE_RPC_I2C_FLAGS_TEN_BIT    BIT(0)
> > >
> > > +/*
> > > + * Reset RPMB probing
> > > + *
> > > + * Releases an eventually already used RPMB devices and starts over =
searching
> > > + * for RPMB devices. Returns the kind of shared memory to use in sub=
sequent
> > > + * OPTEE_RPC_CMD_RPMB_PROBE_NEXT and OPTEE_RPC_CMD_RPMB calls.
> > > + *
> > > + * [out]    value[0].a     OPTEE_RPC_SHM_TYPE_*, the parameter for
> > > + *                         OPTEE_RPC_CMD_SHM_ALLOC
> > > + */
> > > +#define OPTEE_RPC_CMD_RPMB_PROBE_RESET 22
> > > +
> >
> > AFAICS from [1], this RPMB reset probing is only used to check if the
> > kernel supports RPMB probing or not. I suppose that should be detected
> > via a single RPC call like: OPTEE_RPC_CMD_RPMB_PROBE. Other than that
> > the shared memory allocation type can be used as
> > THREAD_SHM_TYPE_KERNEL_PRIVATE if OPTEE_RPC_CMD_RPMB_PROBE works
> > otherwise THREAD_SHM_TYPE_APPLICATION can be used for legacy RPMB init
> > via tee-supplicant.
> >
> > Is there any other specific scenario I am missing which requires an
> > explicit RPMB probe reset call?
>
> That assumes that we're not going to implement
> OPTEE_RPC_CMD_RPMB_PROBE_RESET and OPTEE_RPC_CMD_RPMB_PROBE_NEXT in
> the tee-supplicant. We should implement those RPCs in the
> tee-supplicant too since it solves the problem with finding the RPMB
> device without device-specific runtime arguments for the
> tee-supplicant.

IMO, we should try to deprecate the tee-supplicant accesses to
hardware RPMB. The tee-supplicant can be useful for RPMB emulation
scenarios where we shouldn't require the dynamic discovery of RPMB.

>
> I'd also like to keep the ABI flexible so we for instance can handle a
> removable RPMB from the secure world.

That's an interesting scenario but I am not sure if we really would
like to deal with the complications of removable RPMB like what we
should do if a TA is accessing RPMB during which it is hot plugged?

However, I am in favour of an ABI which is simple enough to maintain
and allow flexibility for extension like adding a new RPC when it's
really needed etc.

-Sumit

