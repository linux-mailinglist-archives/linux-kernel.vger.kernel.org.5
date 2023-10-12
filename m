Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156737C62F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376914AbjJLCjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbjJLCjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:39:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FFFBA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:38:55 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S5Ydk12DXzVl1X;
        Thu, 12 Oct 2023 10:35:22 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 12 Oct 2023 10:38:52 +0800
Subject: Re: [PATCH RFC] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20231010142925.545238-1-wangzhaolong1@huawei.com>
 <9f96baf1-962e-d595-0e4f-797315cd0348@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <b972f615-3882-18cf-5b44-7ec021f92e0a@huawei.com>
Date:   Thu, 12 Oct 2023 10:38:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9f96baf1-962e-d595-0e4f-797315cd0348@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/10/11 10:32, ZhaoLong Wang 写道:
> 
>> This patch assumes that the gluebi module is not designed to work with
>> the ftl module. In this case, the patch only needs to prevent the ftl
>> notifier operation.
>>
>> Add some correctness check for gluebi->desc in gluebi_read/write/erase(),
>> If the pointer is invalid, the -EINVAL is returned.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217992 [1]
>> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
>> ---
>>   drivers/mtd/ubi/gluebi.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/mtd/ubi/gluebi.c b/drivers/mtd/ubi/gluebi.c
>> index 1b980d15d9fb..189ecc0eacd1 100644
>> --- a/drivers/mtd/ubi/gluebi.c
>> +++ b/drivers/mtd/ubi/gluebi.c
>> @@ -157,6 +157,9 @@ static int gluebi_read(struct mtd_info *mtd, 
>> loff_t from, size_t len,
>>       struct gluebi_device *gluebi;
>>       gluebi = container_of(mtd, struct gluebi_device, mtd);
>> +    if (IS_ERR_OR_NULL(gluebi->desc))
>> +        return -EINVAL;
>> +
>>       lnum = div_u64_rem(from, mtd->erasesize, &offs);
>>       bytes_left = len;
>>       while (bytes_left) {
>> @@ -197,6 +200,9 @@ static int gluebi_write(struct mtd_info *mtd, 
>> loff_t to, size_t len,
>>       struct gluebi_device *gluebi;
>>       gluebi = container_of(mtd, struct gluebi_device, mtd);
>> +    if (IS_ERR_OR_NULL(gluebi->desc))
>> +        return -EINVAL;
>> +
>>       lnum = div_u64_rem(to, mtd->erasesize, &offs);
>>       if (len % mtd->writesize || offs % mtd->writesize)
>> @@ -242,6 +248,8 @@ static int gluebi_erase(struct mtd_info *mtd, 
>> struct erase_info *instr)
>>       lnum = mtd_div_by_eb(instr->addr, mtd);
>>       count = mtd_div_by_eb(instr->len, mtd);
>>       gluebi = container_of(mtd, struct gluebi_device, mtd);
>> +    if (IS_ERR_OR_NULL(gluebi->desc))
>> +        return -EINVAL;
>>       for (i = 0; i < count - 1; i++) {
>>           err = ubi_leb_unmap(gluebi->desc, lnum + i);
> 
> 
> This modification attempts another solution. Always check the validity
> of gluebi->desc. If the gluebi->desc pointer is invalid, try to get MTD
> device.
> 
> 
> diff --git a/drivers/mtd/ubi/gluebi.c b/drivers/mtd/ubi/gluebi.c
> index 1b980d15d9fb..f1a74ccf1718 100644
> --- a/drivers/mtd/ubi/gluebi.c
> +++ b/drivers/mtd/ubi/gluebi.c
> @@ -154,9 +154,19 @@ static int gluebi_read(struct mtd_info *mtd, loff_t 
> from, size_t len,
>                  size_t *retlen, unsigned char *buf)
>   {
>       int err = 0, lnum, offs, bytes_left;
> -    struct gluebi_device *gluebi;
> +    struct gluebi_device *gluebi = container_of(mtd, struct gluebi_device,
> +                            mtd);
> +    int not_get = IS_ERR_OR_NULL(gluebi->desc);
> +
> +    if (not_get) {
> +        err = __get_mtd_device(mtd);
> +        if (err) {
> +            err_msg("cannot get MTD device %d, UBI device %d, volume 
> %d, error %d",
> +                mtd->index, gluebi->ubi_num, gluebi->vol_id, err);
> +            return err;
> +        }
> +    }
> 
> -    gluebi = container_of(mtd, struct gluebi_device, mtd);
>       lnum = div_u64_rem(from, mtd->erasesize, &offs);
>       bytes_left = len;
>       while (bytes_left) {
> @@ -176,6 +186,9 @@ static int gluebi_read(struct mtd_info *mtd, loff_t 
> from, size_t len,
>       }
> 
>       *retlen = len - bytes_left;
> +
> +    if (not_get)
> +        __put_mtd_device(mtd);
>       return err;
>   }
> 

I'm afraid that this patch won't cover following three situations 
completely:
1. gluebi_create -> ftl_add_mtd -> mtd_read -> gluebi_read:
    gluebi->desc is NULL.       (√)
2. fd = open(/dev/ubi0_0, O_WRONLY)
     ubi_open_volume  // vol->writers = 1

          P1                    P2
    gluebi_create -> mtd_device_register -> add_mtd_device:
    device_register   // dev/mtd1 is visible

                      fd = open(/dev/mtd1, O_WRONLY)
                       gluebi_get_device
                        gluebi->desc = ubi_open_volume
                         gluebi->desc = ERR_PTR(EBUSY)

    ftl_add_mtd
     mtd_read
      gluebi_read
       gluebi->desc is ERR_PTR       (√)
3.         P1                    P2
    gluebi_create -> mtd_device_register -> add_mtd_device:
    device_register   // dev/mtd1 is visible

                      fd = open(/dev/mtd1, O_WRONLY)
                       gluebi_get_device
                        gluebi->desc = ubi_open_volume

    ftl_add_mtd
     mtd_read
      gluebi_read
       gluebi->desc is not ERR_PTR/NULL

                     close(fd)
                      gluebi_put_device
                       ubi_close_volume
                        kfree(desc)
       ubi_read(gluebi->desc)   // UAF  (×)

> @@ -194,9 +207,19 @@ static int gluebi_write(struct mtd_info *mtd, 
> loff_t to, size_t len,
>               size_t *retlen, const u_char *buf)
>   {
>       int err = 0, lnum, offs, bytes_left;
> -    struct gluebi_device *gluebi;
> +    struct gluebi_device *gluebi = container_of(mtd, struct gluebi_device,
> +                            mtd);
> +    int not_get = IS_ERR_OR_NULL(gluebi->desc);
> +
> +    if (not_get) {
> +        err = __get_mtd_device(mtd);
> +        if (err) {
> +            err_msg("cannot get MTD device %d, UBI device %d, volume 
> %d, error %d",
> +                mtd->index, gluebi->ubi_num, gluebi->vol_id, err);
> +            return err;
> +        }
> +    }
> 
> -    gluebi = container_of(mtd, struct gluebi_device, mtd);
>       lnum = div_u64_rem(to, mtd->erasesize, &offs);
> 
>       if (len % mtd->writesize || offs % mtd->writesize)
> @@ -220,6 +243,9 @@ static int gluebi_write(struct mtd_info *mtd, loff_t 
> to, size_t len,
>       }
> 
>       *retlen = len - bytes_left;
> +
> +    if (not_get)
> +        __put_mtd_device(mtd);
>       return err;
>   }
> 
> @@ -234,14 +260,24 @@ static int gluebi_write(struct mtd_info *mtd, 
> loff_t to, size_t len,
>   static int gluebi_erase(struct mtd_info *mtd, struct erase_info *instr)
>   {
>       int err, i, lnum, count;
> -    struct gluebi_device *gluebi;
> +    struct gluebi_device *gluebi = container_of(mtd, struct gluebi_device,
> +                            mtd);
> +    int not_get = IS_ERR_OR_NULL(gluebi->desc);
> +
> +    if (not_get) {
> +        err = __get_mtd_device(mtd);
> +        if (err) {
> +            err_msg("cannot get MTD device %d, UBI device %d, volume 
> %d, error %d",
> +                mtd->index, gluebi->ubi_num, gluebi->vol_id, err);
> +            return err;
> +        }
> +    }
> 
>       if (mtd_mod_by_ws(instr->addr, mtd) || mtd_mod_by_ws(instr->len, 
> mtd))
>           return -EINVAL;
> 
>       lnum = mtd_div_by_eb(instr->addr, mtd);
>       count = mtd_div_by_eb(instr->len, mtd);
> -    gluebi = container_of(mtd, struct gluebi_device, mtd);
> 
>       for (i = 0; i < count - 1; i++) {
>           err = ubi_leb_unmap(gluebi->desc, lnum + i);
> @@ -259,10 +295,14 @@ static int gluebi_erase(struct mtd_info *mtd, 
> struct erase_info *instr)
>       if (err)
>           goto out_err;
> 
> +    if (not_get)
> +        __put_mtd_device(mtd);
>       return 0;
> 
>   out_err:
>       instr->fail_addr = (long long)lnum * mtd->erasesize;
> +    if (not_get)
> +        __put_mtd_device(mtd);
>       return err;
>   }
> 

No need to modify 'gluebi_write' and 'gluebi_erase'.

