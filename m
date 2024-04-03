Return-Path: <linux-kernel+bounces-129522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64218896BE7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FCA1C23763
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A2D136650;
	Wed,  3 Apr 2024 10:18:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A6413443A;
	Wed,  3 Apr 2024 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139512; cv=none; b=f+HwqGB/XqsmQaG2/BoV2WCZctaX3Rz8CR2kMMluHORaBQfg6V5Rf8x72smqaRtq3GyxxGYXVVmGxm4XtGsok5OdKRhp6ZpJTUf7dEmBFsP10MtD73lqpYlnXD2I9pUNAnFv/EhSJ54utFp/K6vm25Rsmxh4yFYSvIUENJPmvWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139512; c=relaxed/simple;
	bh=u3KbXLQX7Pe1B8wL5OfNuEA5+5F4QzKSSClrDF23FJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tW+eV1Ich6JwCtu8n2L1MNyGrpEVn6xJUgWfcPlAkxpM6nlnnNgNPGN5J37CCppIj6qqHckdnpuN83HTB9hU2tE7o4pm4X00rDFnKabgrvrHJGbfDjiLAujdjbsfRwL/mLTFcZB0+YlB/7nPnZ3DhKxVDKsb6iYizKk5cqvzURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6E451007;
	Wed,  3 Apr 2024 03:19:00 -0700 (PDT)
Received: from [10.57.17.17] (unknown [10.57.17.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC04E3F64C;
	Wed,  3 Apr 2024 03:18:27 -0700 (PDT)
From: Balint Dobszay <balint.dobszay@arm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 sumit.garg@linaro.org, corbet@lwn.net, sudeep.holla@arm.com,
 rdunlap@infradead.org, krzk@kernel.org, gyorgy.szing@arm.com
Subject: Re: [PATCH v4 2/5] tee: optee: Move pool_op helper functions
Date: Wed, 03 Apr 2024 12:18:25 +0200
X-Mailer: MailMate (1.14r5937)
Message-ID: <06138C06-8BC5-4F02-85A6-EAFCD94777E6@arm.com>
In-Reply-To: <CAHUa44HHikgA2R_nZw9+f6ug1nKBZgwVEYvqPgKo6dx=iijAqA@mail.gmail.com>
References: <20240325151105.135667-1-balint.dobszay@arm.com>
 <20240325151105.135667-3-balint.dobszay@arm.com>
 <CAHUa44HHikgA2R_nZw9+f6ug1nKBZgwVEYvqPgKo6dx=iijAqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On 3 Apr 2024, at 11:43, Jens Wiklander wrote:

> Hi Balint,
>
> On Mon, Mar 25, 2024 at 4:11=E2=80=AFPM Balint Dobszay <balint.dobszay@=
arm.com> wrote:
>>
>> Move the pool alloc and free helper functions from the OP-TEE driver t=
o
>> the TEE subsystem, since these could be reused in other TEE drivers.
>> This patch is not supposed to change behavior, it's only reorganizing
>> the code.
>>
>> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>> Suggested-by: Jens Wiklander <jens.wiklander@linaro.org>
>> Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
>> ---
>>  drivers/tee/optee/core.c          | 64 ------------------------------=
-
>>  drivers/tee/optee/ffa_abi.c       |  6 +--
>>  drivers/tee/optee/optee_private.h | 12 ------
>>  drivers/tee/optee/smc_abi.c       |  9 ++---
>>  drivers/tee/tee_shm.c             | 64 ++++++++++++++++++++++++++++++=
+
>>  include/linux/tee_core.h          | 10 +++++
>>  6 files changed, 81 insertions(+), 84 deletions(-)
>
> This patch fails to build on x86_64:
>   CC [M]  drivers/tee/tee_shm.o
> drivers/tee/tee_shm.c: In function =E2=80=98tee_dyn_shm_alloc_helper=E2=
=80=99:
> linux/drivers/tee/tee_shm.c:226:22: error: implicit declaration of
> function =E2=80=98virt_to_phys=E2=80=99; did you mean =E2=80=98virt_to_=
page=E2=80=99?
> [-Werror=3Dimplicit-function-declaration]
>   226 |         shm->paddr =3D virt_to_phys(shm->kaddr);
>       |                      ^~~~~~~~~~~~
>       |                      virt_to_page
>
> It's fixed by adding
> #include <linux/io.h>
>
> I'll fix up the patch if you agree with the fix.

Thanks for catching this. I agree with the fix, please apply it.

Regards,
Balint

>>
>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>> index f762e3a25119..39e688d4e974 100644
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

>> index cee8ccb84cb8..3235e1c719e8 100644
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
>> +       return tee_dyn_shm_alloc_helper(shm, size, align,
>> +                                       optee_ffa_shm_register);
>>  }
>>
>>  static void pool_ffa_op_free(struct tee_shm_pool *pool,
>>                              struct tee_shm *shm)
>>  {
>> -       optee_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister)=
;
>> +       tee_dyn_shm_free_helper(shm, optee_ffa_shm_unregister);
>>  }
>>
>>  static void pool_ffa_op_destroy_pool(struct tee_shm_pool *pool)
>> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/opt=
ee_private.h
>> index a0698ac18993..429cc20be5cc 100644
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

>> index 9c296b887dc1..734c484ed0f6 100644
>> --- a/drivers/tee/optee/smc_abi.c
>> +++ b/drivers/tee/optee/smc_abi.c
>> @@ -592,19 +592,18 @@ static int pool_op_alloc(struct tee_shm_pool *po=
ol,
>>          * to be registered with OP-TEE.
>>          */
>>         if (shm->flags & TEE_SHM_PRIV)
>> -               return optee_pool_op_alloc_helper(pool, shm, size, ali=
gn, NULL);
>> +               return tee_dyn_shm_alloc_helper(shm, size, align, NULL=
);
>>
>> -       return optee_pool_op_alloc_helper(pool, shm, size, align,
>> -                                         optee_shm_register);
>> +       return tee_dyn_shm_alloc_helper(shm, size, align, optee_shm_re=
gister);
>>  }
>>
>>  static void pool_op_free(struct tee_shm_pool *pool,
>>                          struct tee_shm *shm)
>>  {
>>         if (!(shm->flags & TEE_SHM_PRIV))
>> -               optee_pool_op_free_helper(pool, shm, optee_shm_unregis=
ter);
>> +               tee_dyn_shm_free_helper(shm, optee_shm_unregister);
>>         else
>> -               optee_pool_op_free_helper(pool, shm, NULL);
>> +               tee_dyn_shm_free_helper(shm, NULL);
>>  }
>>
>>  static void pool_op_destroy_pool(struct tee_shm_pool *pool)
>> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
>> index 96a45c817427..5bf76c35cd9e 100644
>> --- a/drivers/tee/tee_shm.c
>> +++ b/drivers/tee/tee_shm.c
>> @@ -202,6 +202,70 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee=
_context *ctx, size_t size)
>>  }
>>  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
>>
>> +int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t=
 align,
>> +                            int (*shm_register)(struct tee_context *c=
tx,
>> +                                                struct tee_shm *shm,
>> +                                                struct page **pages,
>> +                                                size_t num_pages,
>> +                                                unsigned long start))=

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
>> +EXPORT_SYMBOL_GPL(tee_dyn_shm_alloc_helper);
>> +
>> +void tee_dyn_shm_free_helper(struct tee_shm *shm,
>> +                            int (*shm_unregister)(struct tee_context =
*ctx,
>> +                                                  struct tee_shm *shm=
))
>> +{
>> +       if (shm_unregister)
>> +               shm_unregister(shm->ctx, shm);
>> +       free_pages_exact(shm->kaddr, shm->size);
>> +       shm->kaddr =3D NULL;
>> +       kfree(shm->pages);
>> +       shm->pages =3D NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(tee_dyn_shm_free_helper);
>> +
>>  static struct tee_shm *
>>  register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u=
32 flags,
>>                     int id)
>> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
>> index d9b3ba8e8fa9..efd16ed52315 100644
>> --- a/include/linux/tee_core.h
>> +++ b/include/linux/tee_core.h
>> @@ -232,6 +232,16 @@ void *tee_get_drvdata(struct tee_device *teedev);=

>>   */
>>  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_=
t size);
>>
>> +int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t=
 align,
>> +                            int (*shm_register)(struct tee_context *c=
tx,
>> +                                                struct tee_shm *shm,
>> +                                                struct page **pages,
>> +                                                size_t num_pages,
>> +                                                unsigned long start))=
;
>> +void tee_dyn_shm_free_helper(struct tee_shm *shm,
>> +                            int (*shm_unregister)(struct tee_context =
*ctx,
>> +                                                  struct tee_shm *shm=
));
>> +
>>  /**
>>   * tee_shm_is_dynamic() - Check if shared memory object is of the dyn=
amic kind
>>   * @shm:       Shared memory handle
>> --
>> 2.34.1
>>

