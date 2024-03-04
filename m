Return-Path: <linux-kernel+bounces-90267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4075486FCA3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB987282E65
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3351B5B2;
	Mon,  4 Mar 2024 09:03:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BF01A58B;
	Mon,  4 Mar 2024 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543011; cv=none; b=Gis61dL53Jg6ox3WNJyU1I2RDFg0LOpqsXBo5FEljKHfS6QC5h3/9qOubO9xJ2p7oaH+GdduODRN2SwGXPoOj3AnYcN3QSnnbnrC+K2h/Qbz3RI7Y4Mtgbgdy93+VMw+5ssXHX4U+3B77yZK2M+0wOw2DDa2Y1Xw6SE6as6J21A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543011; c=relaxed/simple;
	bh=CC+1rirYTzLGvEtFwGB1EgD63WwGrPZRKnDwinQpM+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTAXg2xhYgSwcHaWjaifrVnF0jEOCRkDQF/fa+i9bYg3sSpsQCCkeyXwqdbOyyIXeBDPAZ76+DaYYCwCbGCuX3FlhQn4wdBILIdowhPgSSric+LHMyNYn+24kFjWSokxh4ZUboTXgHrMiRzD88xL6UH0Gqxd2jXJgfI3H/iQkTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EFF21FB;
	Mon,  4 Mar 2024 01:04:05 -0800 (PST)
Received: from [10.37.129.2] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1B6F3F762;
	Mon,  4 Mar 2024 01:03:26 -0800 (PST)
From: Balint Dobszay <balint.dobszay@arm.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jens.wiklander@linaro.org, corbet@lwn.net, sudeep.holla@arm.com,
 rdunlap@infradead.org, krzk@kernel.org, gyorgy.szing@arm.com
Subject: Re: [PATCH v2 1/3] tee: optee: Move pool_op helper functions
Date: Mon, 04 Mar 2024 10:03:24 +0100
X-Mailer: MailMate (1.14r5937)
Message-ID: <4E68610D-8F2B-4E27-AE5C-45CB59D7FEC0@arm.com>
In-Reply-To: <CAFA6WYNW9-7gCZQSEaV=Gcr+GLdu25rQ8MpTg9yNpX7OwyZ0Tg@mail.gmail.com>
References: <20240223095133.109046-1-balint.dobszay@arm.com>
 <20240223095133.109046-2-balint.dobszay@arm.com>
 <CAFA6WYNW9-7gCZQSEaV=Gcr+GLdu25rQ8MpTg9yNpX7OwyZ0Tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On 27 Feb 2024, at 7:06, Sumit Garg wrote:

> Hi Balint,
>
> On Fri, 23 Feb 2024 at 15:22, Balint Dobszay <balint.dobszay@arm.com> w=
rote:
>>
>> Move the pool alloc and free helper functions from the OP-TEE driver t=
o
>> the TEE subsystem, since these could be reused in other TEE drivers.
>> This patch is not supposed to change behavior, it's only reorganizing
>> the code.
>>
>> Suggested-by: Jens Wiklander <jens.wiklander@linaro.org>
>> Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
>> ---
>>  drivers/tee/optee/core.c          | 64 ------------------------------=

>>  drivers/tee/optee/ffa_abi.c       |  6 +--
>>  drivers/tee/optee/optee_private.h | 12 ------
>>  drivers/tee/optee/smc_abi.c       | 11 +++---
>>  drivers/tee/tee_shm.c             | 65 ++++++++++++++++++++++++++++++=
+
>>  include/linux/tee_drv.h           | 11 ++++++
>>  6 files changed, 85 insertions(+), 84 deletions(-)
>>
>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>> index 3aed554bc8d8..9390f21f9902 100644
>> --- a/drivers/tee/optee/core.c
>> +++ b/drivers/tee/optee/core.c
>> @@ -9,7 +9,6 @@
>>  #include <linux/crash_dump.h>
>>  #include <linux/errno.h>
>>  #include <linux/io.h>
>> -#include <linux/mm.h>
>>  #include <linux/module.h>
>>  #include <linux/slab.h>
>>  #include <linux/string.h>
>> @@ -17,69 +16,6 @@
>>  #include <linux/types.h>
>>  #include "optee_private.h"
>>
>> -int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_=
shm *shm,
>> -                              size_t size, size_t align,
>> -                              int (*shm_register)(struct tee_context =
*ctx,
>> -                                                  struct tee_shm *shm=
,
>> -                                                  struct page **pages=
,
>> -                                                  size_t num_pages,
>> -                                                  unsigned long start=
))
>> -{
>> -       size_t nr_pages =3D roundup(size, PAGE_SIZE) / PAGE_SIZE;
>> -       struct page **pages;
>> -       unsigned int i;
>> -       int rc =3D 0;
>> -
>> -       /*
>> -        * Ignore alignment since this is already going to be page ali=
gned
>> -        * and there's no need for any larger alignment.
>> -        */
>> -       shm->kaddr =3D alloc_pages_exact(nr_pages * PAGE_SIZE,
>> -                                      GFP_KERNEL | __GFP_ZERO);
>> -       if (!shm->kaddr)
>> -               return -ENOMEM;
>> -
>> -       shm->paddr =3D virt_to_phys(shm->kaddr);
>> -       shm->size =3D nr_pages * PAGE_SIZE;
>> -
>> -       pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
>> -       if (!pages) {
>> -               rc =3D -ENOMEM;
>> -               goto err;
>> -       }
>> -
>> -       for (i =3D 0; i < nr_pages; i++)
>> -               pages[i] =3D virt_to_page((u8 *)shm->kaddr + i * PAGE_=
SIZE);
>> -
>> -       shm->pages =3D pages;
>> -       shm->num_pages =3D nr_pages;
>> -
>> -       if (shm_register) {
>> -               rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
>> -                                 (unsigned long)shm->kaddr);
>> -               if (rc)
>> -                       goto err;
>> -       }
>> -
>> -       return 0;
>> -err:
>> -       free_pages_exact(shm->kaddr, shm->size);
>> -       shm->kaddr =3D NULL;
>> -       return rc;
>> -}
>> -
>> -void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_=
shm *shm,
>> -                              int (*shm_unregister)(struct tee_contex=
t *ctx,
>> -                                                    struct tee_shm *s=
hm))
>> -{
>> -       if (shm_unregister)
>> -               shm_unregister(shm->ctx, shm);
>> -       free_pages_exact(shm->kaddr, shm->size);
>> -       shm->kaddr =3D NULL;
>> -       kfree(shm->pages);
>> -       shm->pages =3D NULL;
>> -}
>> -
>>  static void optee_bus_scan(struct work_struct *work)
>>  {
>>         WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
>> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c=

>> index ecb5eb079408..ee11918a2b35 100644
>> --- a/drivers/tee/optee/ffa_abi.c
>> +++ b/drivers/tee/optee/ffa_abi.c
>> @@ -374,14 +374,14 @@ static int optee_ffa_shm_unregister_supp(struct =
tee_context *ctx,
>>  static int pool_ffa_op_alloc(struct tee_shm_pool *pool,
>>                              struct tee_shm *shm, size_t size, size_t =
align)
>>  {
>> -       return optee_pool_op_alloc_helper(pool, shm, size, align,
>> -                                         optee_ffa_shm_register);
>> +       return tee_shm_pool_op_alloc_helper(pool, shm, size, align,
>> +                                           optee_ffa_shm_register);
>>  }
>>
>>  static void pool_ffa_op_free(struct tee_shm_pool *pool,
>>                              struct tee_shm *shm)
>>  {
>> -       optee_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister)=
;
>> +       tee_shm_pool_op_free_helper(pool, shm, optee_ffa_shm_unregiste=
r);
>>  }
>>
>>  static void pool_ffa_op_destroy_pool(struct tee_shm_pool *pool)
>> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/opt=
ee_private.h
>> index 7a5243c78b55..a153285a1919 100644
>> --- a/drivers/tee/optee/optee_private.h
>> +++ b/drivers/tee/optee/optee_private.h
>> @@ -283,18 +283,6 @@ int optee_cancel_req(struct tee_context *ctx, u32=
 cancel_id, u32 session);
>>  int optee_enumerate_devices(u32 func);
>>  void optee_unregister_devices(void);
>>
>> -int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_=
shm *shm,
>> -                              size_t size, size_t align,
>> -                              int (*shm_register)(struct tee_context =
*ctx,
>> -                                                  struct tee_shm *shm=
,
>> -                                                  struct page **pages=
,
>> -                                                  size_t num_pages,
>> -                                                  unsigned long start=
));
>> -void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_=
shm *shm,
>> -                              int (*shm_unregister)(struct tee_contex=
t *ctx,
>> -                                                    struct tee_shm *s=
hm));
>> -
>> -
>>  void optee_remove_common(struct optee *optee);
>>  int optee_open(struct tee_context *ctx, bool cap_memref_null);
>>  void optee_release(struct tee_context *ctx);
>> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c=

>> index a37f87087e5c..b0c616b6870d 100644
>> --- a/drivers/tee/optee/smc_abi.c
>> +++ b/drivers/tee/optee/smc_abi.c
>> @@ -592,19 +592,20 @@ static int pool_op_alloc(struct tee_shm_pool *po=
ol,
>>          * to be registered with OP-TEE.
>>          */
>>         if (shm->flags & TEE_SHM_PRIV)
>> -               return optee_pool_op_alloc_helper(pool, shm, size, ali=
gn, NULL);
>> +               return tee_shm_pool_op_alloc_helper(pool, shm, size, a=
lign,
>> +                                                   NULL);
>>
>> -       return optee_pool_op_alloc_helper(pool, shm, size, align,
>> -                                         optee_shm_register);
>> +       return tee_shm_pool_op_alloc_helper(pool, shm, size, align,
>> +                                           optee_shm_register);
>>  }
>>
>>  static void pool_op_free(struct tee_shm_pool *pool,
>>                          struct tee_shm *shm)
>>  {
>>         if (!(shm->flags & TEE_SHM_PRIV))
>> -               optee_pool_op_free_helper(pool, shm, optee_shm_unregis=
ter);
>> +               tee_shm_pool_op_free_helper(pool, shm, optee_shm_unreg=
ister);
>>         else
>> -               optee_pool_op_free_helper(pool, shm, NULL);
>> +               tee_shm_pool_op_free_helper(pool, shm, NULL);
>>  }
>>
>>  static void pool_op_destroy_pool(struct tee_shm_pool *pool)
>> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
>> index 731d9028b67f..641aad92ffe2 100644
>> --- a/drivers/tee/tee_shm.c
>> +++ b/drivers/tee/tee_shm.c
>> @@ -202,6 +202,71 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee=
_context *ctx, size_t size)
>>  }
>>  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
>>
>> +int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struct te=
e_shm *shm,
>
> I don't see the first argument (struct tee_shm_pool *pool) being used,
> so drop that. Also, we can just rename it as
> tee_dyn_shm_alloc_helper().

Okay, I'll refactor.

>> +                                size_t size, size_t align,
>> +                                int (*shm_register)(struct tee_contex=
t *ctx,
>> +                                                    struct tee_shm *s=
hm,
>> +                                                    struct page **pag=
es,
>> +                                                    size_t num_pages,=

>> +                                                    unsigned long sta=
rt))
>> +{
>> +       size_t nr_pages =3D roundup(size, PAGE_SIZE) / PAGE_SIZE;
>> +       struct page **pages;
>> +       unsigned int i;
>> +       int rc =3D 0;
>> +
>> +       /*
>> +        * Ignore alignment since this is already going to be page ali=
gned
>> +        * and there's no need for any larger alignment.
>> +        */
>> +       shm->kaddr =3D alloc_pages_exact(nr_pages * PAGE_SIZE,
>> +                                      GFP_KERNEL | __GFP_ZERO);
>> +       if (!shm->kaddr)
>> +               return -ENOMEM;
>> +
>> +       shm->paddr =3D virt_to_phys(shm->kaddr);
>> +       shm->size =3D nr_pages * PAGE_SIZE;
>> +
>> +       pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
>> +       if (!pages) {
>> +               rc =3D -ENOMEM;
>> +               goto err;
>> +       }
>> +
>> +       for (i =3D 0; i < nr_pages; i++)
>> +               pages[i] =3D virt_to_page((u8 *)shm->kaddr + i * PAGE_=
SIZE);
>> +
>> +       shm->pages =3D pages;
>> +       shm->num_pages =3D nr_pages;
>> +
>> +       if (shm_register) {
>> +               rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
>> +                                 (unsigned long)shm->kaddr);
>> +               if (rc)
>> +                       goto err;
>> +       }
>> +
>> +       return 0;
>> +err:
>> +       free_pages_exact(shm->kaddr, shm->size);
>> +       shm->kaddr =3D NULL;
>> +       return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(tee_shm_pool_op_alloc_helper);
>> +
>> +void tee_shm_pool_op_free_helper(struct tee_shm_pool *pool, struct te=
e_shm *shm,
>
> Ditto tee_shm_pool_op_free_helper() -> tee_dyn_shm_free_helper()

Okay, actually the first argument is unused here too, I'll drop it.

>> +                                int (*shm_unregister)(struct tee_cont=
ext *ctx,
>> +                                                      struct tee_shm =
*shm))
>> +{
>> +       if (shm_unregister)
>> +               shm_unregister(shm->ctx, shm);
>> +       free_pages_exact(shm->kaddr, shm->size);
>> +       shm->kaddr =3D NULL;
>> +       kfree(shm->pages);
>> +       shm->pages =3D NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(tee_shm_pool_op_free_helper);
>> +
>>  static struct tee_shm *
>>  register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u=
32 flags,
>>                     int id)
>> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
>> index 911ddf92dcee..4cf402424e71 100644
>> --- a/include/linux/tee_drv.h
>> +++ b/include/linux/tee_drv.h
>> @@ -275,6 +275,17 @@ void *tee_get_drvdata(struct tee_device *teedev);=

>>  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_=
t size);
>>  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, siz=
e_t size);
>>
>> +int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struct te=
e_shm *shm,
>> +                                size_t size, size_t align,
>> +                                int (*shm_register)(struct tee_contex=
t *ctx,
>> +                                                    struct tee_shm *s=
hm,
>> +                                                    struct page **pag=
es,
>> +                                                    size_t num_pages,=

>> +                                                    unsigned long sta=
rt));
>> +void tee_shm_pool_op_free_helper(struct tee_shm_pool *pool, struct te=
e_shm *shm,
>> +                                int (*shm_unregister)(struct tee_cont=
ext *ctx,
>> +                                                      struct tee_shm =
*shm));
>> +
>
> These rather belong to drivers/tee/tee_private.h as we shouldn't
> expose them to other kernel client drivers.

As per the discussion in the other thread I'll ignore this.

Regards,
Balint

>>  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
>>                                             void *addr, size_t length)=
;
>>
>> --
>> 2.34.1
>>

