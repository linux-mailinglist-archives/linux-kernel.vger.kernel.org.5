Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2099802286
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 11:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjLCKf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 05:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjLCKf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 05:35:56 -0500
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF43CD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 02:36:01 -0800 (PST)
Received: from [192.168.1.18] ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id 9jnnrzqJl1Jmd9jpQrQmqS; Sun, 03 Dec 2023 11:36:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1701599760;
        bh=7/7K3QF/l4pTTPUL+W/tS/1zgsUPdfiCIZI4+ljPaaU=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To;
        b=SwqzDwrMZsvjAF7VbnrUrv+EpGe2clYQRaJ/mJ0dI8OWVyZED+Ok9/h7ps7nCsxrL
         Cz+xhL48AdOoDn+Pe3Yrj1JuBoOFbCK/r1tDClbBpmYZvJEOfoJpvY7Pr9luQ4FDgI
         KKUVKmbxwbAg47Qmwh4JQYNZuSYF6XNicEov0YjSXJ+/g0qi6gH4n9ULrt6xV+uqwz
         xaC5QSgXeFzxxqKJOAkOHFmdthKMayfgo1bVFYbiEISGknPKAs6SBNuEd+n3kGW2DH
         aoRb4ZrCnlBBQ1afRaGzAvHN3Yrh8h3CAh78SzgYm0JBECkrXcDVnK1m0x0o7P2RQk
         WLo9hO32IE0fg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 03 Dec 2023 11:36:00 +0100
X-ME-IP: 92.140.202.140
Message-ID: <eb13fc84-d1e8-4121-8569-cf405a35e721@wanadoo.fr>
Date:   Sun, 3 Dec 2023 11:36:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] scsi: aic7xxx: return negative error codes in
 aic7770_probe()
Content-Language: fr
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Su Hui <suhui@nfschina.com>, dan.carpenter@linaro.org,
        hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20231201025955.1584260-1-suhui@nfschina.com>
 <20231201025955.1584260-4-suhui@nfschina.com>
 <87d394e4-e290-41a6-aaf2-92cf6b5ad919@wanadoo.fr>
In-Reply-To: <87d394e4-e290-41a6-aaf2-92cf6b5ad919@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/12/2023 à 11:34, Christophe JAILLET a écrit :
> Le 01/12/2023 à 03:59, Su Hui a écrit :
>> aic7770_config() returns both negative and positive error code.
>> it's better to make aic7770_probe() only return negative error codes.
>>
>> And the previous patch made ahc_linux_register_host() return negative 
>> error
>> codes, which makes sure aic7770_probe() returns negative error codes.
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   drivers/scsi/aic7xxx/aic7770_osm.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/scsi/aic7xxx/aic7770_osm.c 
>> b/drivers/scsi/aic7xxx/aic7770_osm.c
>> index bdd177e3d762..a19cdd87c453 100644
>> --- a/drivers/scsi/aic7xxx/aic7770_osm.c
>> +++ b/drivers/scsi/aic7xxx/aic7770_osm.c
>> @@ -87,17 +87,17 @@ aic7770_probe(struct device *dev)
>>       sprintf(buf, "ahc_eisa:%d", eisaBase >> 12);
>>       name = kstrdup(buf, GFP_ATOMIC);
>>       if (name == NULL)
>> -        return (ENOMEM);
>> +        return -ENOMEM;
>>       ahc = ahc_alloc(&aic7xxx_driver_template, name);
>>       if (ahc == NULL)
> 
> Unrelated to your fix, but 'name' is leaking here.

Oups, no, ahc_alloc() handles it.
Really strange API!

CJ

> 
> Also, kasprintf() could be used to avoid buf+sprintf()+kstrdup()
> 
> The GFP_ATOMIC in the allocation could certainly also be just a GFP_KERNEL.
> 
> CJ
> 
>> -        return (ENOMEM);
>> +        return -ENOMEM;
>>       ahc->dev = dev;
>>       error = aic7770_config(ahc, aic7770_ident_table + 
>> edev->id.driver_data,
>>                      eisaBase);
>>       if (error != 0) {
>>           ahc->bsh.ioport = 0;
>>           ahc_free(ahc);
>> -        return (error);
>> +        return error < 0 ? error : -error;
>>       }
>>        dev_set_drvdata(dev, ahc);
> 
> 
