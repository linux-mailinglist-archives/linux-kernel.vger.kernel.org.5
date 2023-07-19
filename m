Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F76759C68
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjGSRba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGSRb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:31:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4EFE69
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:31:27 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-668711086f4so756294b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1689787887; x=1692379887;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L7nnX+X/d5VdmyNCN/iT5OllpkZ2UXSxtrHtNFyFV3E=;
        b=AkZkqBM4m0YuLPchC+1vc5MxvmlUQ+PMcllau+kiPv8dw946l8ECDrRtRiCSgPEQT3
         qkFaAV/gU573NponlZaV1OUkeRUCs/oUv6fm4FHKa72i4Nf3/tBXrVGImWklpeKgbVjI
         kMxPtrkcp7bzJ5w8YpwOkyn4rewCNS6szhcbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689787887; x=1692379887;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7nnX+X/d5VdmyNCN/iT5OllpkZ2UXSxtrHtNFyFV3E=;
        b=EePh1/z9+eGwaiRsRg5IMXBLpoyLqTvxHsD3lS0b5KmETcU7WYA2XvqSr/BJ5NQVyd
         6E7o2EKoZdqGeYf8txO3V9Nb8oTX4PpE4I7ab8azcUFDwgF21LxSelvRkvf10TPc/WqJ
         kk5pLIWatbfgl2C8VmBsIapvOM/Td/OVNtzEeAKS9edqYETSwlq94Q6Zir5lVG5wMUQU
         2HOwxGE4EgsJPBthosolPrqiz1ql+JBts0MifVHg+usyCmSdvaqnWtcqIz+BbaUtlNK7
         CQt9X8wcd1vctrnKvQLgAL6pARL3UADTNfDnRDmzvkEMTVgSieWAZlS9VeLIsXd6ImD3
         KaHw==
X-Gm-Message-State: ABy/qLZChrqcadqDl3kBR7o+/Fo69CmvSdDbiZAEiuuMoJCX4cWrKbef
        9vThM4+ttSHtBBIj0cPhz0TMPA==
X-Google-Smtp-Source: APBJJlGc6IO3JkidXe6dv0viKx5UZDZK7CV3wWH57MC4G39uebxMtSCOXuWm2Pu7eAI/klJrOsQGGw==
X-Received: by 2002:a05:6a20:3ca7:b0:133:6696:1db with SMTP id b39-20020a056a203ca700b00133669601dbmr3788340pzj.29.1689787886586;
        Wed, 19 Jul 2023 10:31:26 -0700 (PDT)
Received: from [10.136.64.163] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id f25-20020aa782d9000000b00682aac1e2b8sm3558696pfn.60.2023.07.19.10.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 10:31:25 -0700 (PDT)
Message-ID: <07406ab9-fbb0-4f98-56b1-0c64b7e695e1@broadcom.com>
Date:   Wed, 19 Jul 2023 10:31:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] misc: bcm_vk: Fix potential deadlock on &vk->ctx_lock
To:     Scott Branden <scott.branden@broadcom.com>,
        Chengfeng Ye <dg573847474@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, desmond.yan@broadcom.com
References: <20230629182941.13045-1-dg573847474@gmail.com>
 <4fb34b91-13af-cfff-0118-0f263e0e0d27@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
In-Reply-To: <4fb34b91-13af-cfff-0118-0f263e0e0d27@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c252940600da669c"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c252940600da669c
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/19/2023 10:07 AM, Scott Branden wrote:
> Works fine - thanks.

So apparently the choice of using the timer previously was not due to
performance reasons?

If performance is a concern by converting to use workqueue (now it runs
in process/thread context than softirq), I assume you are aware of
another easy way to fix this potential deadlock issue? :)
> 
> On 2023-06-29 11:29, Chengfeng Ye wrote:
>> As &vk->ctx_lock is acquired by timer bcm_vk_hb_poll() under softirq
>> context, other process context code should disable irq or bottom-half
>> before acquire the same lock, otherwise deadlock could happen if the
>> timer preempt the execution while the lock is held in process context
>> on the same CPU.
>>
>> Possible deadlock scenario
>> bcm_vk_open()
>>      -> bcm_vk_get_ctx()
>>      -> spin_lock(&vk->ctx_lock)
>>     <timer iterrupt>
>>     -> bcm_vk_hb_poll()
>>     -> bcm_vk_blk_drv_access()
>>     -> spin_lock_irqsave(&vk->ctx_lock, flags) (deadlock here)
>>
>> This flaw was found using an experimental static analysis tool we are
>> developing for irq-related deadlock, which reported the following
>> warning when analyzing the linux kernel 6.4-rc7 release.
>>
>> [Deadlock]: &vk->ctx_lock
>>    [Interrupt]: bcm_vk_hb_poll
>>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
>>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
>>    [Locking Unit]: bcm_vk_ioctl
>>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:1181
>>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
>>
>> [Deadlock]: &vk->ctx_lock
>>    [Interrupt]: bcm_vk_hb_poll
>>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
>>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
>>    [Locking Unit]: bcm_vk_ioctl
>>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:1169
>>
>> [Deadlock]: &vk->ctx_lock
>>    [Interrupt]: bcm_vk_hb_poll
>>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
>>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
>>    [Locking Unit]: bcm_vk_open
>>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:216
>>
>> [Deadlock]: &vk->ctx_lock
>>    [Interrupt]: bcm_vk_hb_poll
>>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
>>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
>>    [Locking Unit]: bcm_vk_release
>>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:306
>>
>> As suggested by Arnd, the tentative patch fix the potential deadlocks
>> by replacing the timer with delay workqueue. x86_64 allyesconfig using
>> GCC shows no new warning. Note that no runtime testing was performed
>> due to no device on hand.
>>
>> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> Acked-by: Scott Branden <scott.branden@broadcom.com>
> Tested-by: Desmond Yan <desmond.branden@broadcom.com>
> 
>> ---
>>   drivers/misc/bcm-vk/bcm_vk.h     |  2 +-
>>   drivers/misc/bcm-vk/bcm_vk_msg.c | 14 +++++++-------
>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
>> index 25d51222eedf..386884c2a263 100644
>> --- a/drivers/misc/bcm-vk/bcm_vk.h
>> +++ b/drivers/misc/bcm-vk/bcm_vk.h
>> @@ -340,7 +340,7 @@ struct bcm_vk_proc_mon_info {
>>   };
>>     struct bcm_vk_hb_ctrl {
>> -    struct timer_list timer;
>> +    struct delayed_work work;
>>       u32 last_uptime;
>>       u32 lost_cnt;
>>   };
>> diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c
>> b/drivers/misc/bcm-vk/bcm_vk_msg.c
>> index 3c081504f38c..e17d81231ea6 100644
>> --- a/drivers/misc/bcm-vk/bcm_vk_msg.c
>> +++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
>> @@ -137,11 +137,11 @@ void bcm_vk_set_host_alert(struct bcm_vk *vk,
>> u32 bit_mask)
>>   #define BCM_VK_HB_TIMER_VALUE (BCM_VK_HB_TIMER_S * HZ)
>>   #define BCM_VK_HB_LOST_MAX (27 / BCM_VK_HB_TIMER_S)
>>   -static void bcm_vk_hb_poll(struct timer_list *t)
>> +static void bcm_vk_hb_poll(struct work_struct *work)
>>   {
>>       u32 uptime_s;
>> -    struct bcm_vk_hb_ctrl *hb = container_of(t, struct bcm_vk_hb_ctrl,
>> -                         timer);
>> +    struct bcm_vk_hb_ctrl *hb = container_of(to_delayed_work(work),
>> struct bcm_vk_hb_ctrl,
>> +                         work);
>>       struct bcm_vk *vk = container_of(hb, struct bcm_vk, hb_ctrl);
>>         if (bcm_vk_drv_access_ok(vk) && hb_mon_is_on()) {
>> @@ -177,22 +177,22 @@ static void bcm_vk_hb_poll(struct timer_list *t)
>>           bcm_vk_set_host_alert(vk, ERR_LOG_HOST_HB_FAIL);
>>       }
>>       /* re-arm timer */
>> -    mod_timer(&hb->timer, jiffies + BCM_VK_HB_TIMER_VALUE);
>> +    schedule_delayed_work(&hb->work, BCM_VK_HB_TIMER_VALUE);
>>   }
>>     void bcm_vk_hb_init(struct bcm_vk *vk)
>>   {
>>       struct bcm_vk_hb_ctrl *hb = &vk->hb_ctrl;
>>   -    timer_setup(&hb->timer, bcm_vk_hb_poll, 0);
>> -    mod_timer(&hb->timer, jiffies + BCM_VK_HB_TIMER_VALUE);
>> +    INIT_DELAYED_WORK(&hb->work, bcm_vk_hb_poll);
>> +    schedule_delayed_work(&hb->work, BCM_VK_HB_TIMER_VALUE);
>>   }
>>     void bcm_vk_hb_deinit(struct bcm_vk *vk)
>>   {
>>       struct bcm_vk_hb_ctrl *hb = &vk->hb_ctrl;
>>   -    del_timer(&hb->timer);
>> +    cancel_delayed_work_sync(&hb->work);
>>   }
>>     static void bcm_vk_msgid_bitmap_clear(struct bcm_vk *vk,

--000000000000c252940600da669c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YVhHgdTTB3aAzFyz4UFRLwxCzIG7d7GIiB9MoLImssS08R5WQ5EJCd1fAF6iefLupAn/plPmn2w0
GF8bLF/FhwOn8jObLW5pQiKhjQSv3QIDAQABo4IB1TCCAdEwDgYDVR0PAQH/BAQDAgWgMIGjBggr
BgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9j
YWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8v
b2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBE
MEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20v
cmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2Jh
bHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAfBgNVHREEGDAWgRRyYXku
anVpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdb
NHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIScG7uNJuCYBQieQC+eonQS9tdkwDQYJKoZIhvcNAQEL
BQADggEBAGLwq/sDtwLmkAa5/UpIG4o5HA9EH7SaYi05EUlzrDdIeZsJnXDkxmG9144wNZBbndHx
nKXRnpJjCX4jhZeNQFyY4m5c9c8bMytO4zb8XUJIxCjqkhtukJtqHieEogwGsmZlpOxt6Ucc2JXg
6oTTbyITD4Bvn7cFb7EI2FBcT7K8bf8AvwtNLl/dKYtUA/nEvVhjqp0wsDL3t//Q3GTwGWZB41gf
LC04V6gD9TVFl7i/N48Gu8PzTt4Kt0SZvBr7kQ9PKi7DVyXe23Ou89QVflaja3bPjt2UZCyq0JxJ
Nu5SjFDWjKlBCzbLDGkCBlM4DpjAb0y4MyKOsiVv7vIxNlYxggJtMIICaQIBATBrMFsxCzAJBgNV
BAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdD
QyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwcAgHcg4j27cIp1UUwDQYJYIZIAWUDBAIBBQCg
gdQwLwYJKoZIhvcNAQkEMSIEIOl1SjF21ZagBf3fpErnpyjRAx/at4HHchVsxODLX8LgMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDcxOTE3MzEyN1owaQYJKoZI
hvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQCrrnhfhpg8h7jGY7aBPurkBWn3kp37CKahyKnSeApYpW8v2nZQzWHffY1QTplTQ+6BmFFt
zAxS0YdjnYZO8D2p68DE7QKze56TQPeygQ8pWYOv2aJ0kJPHGrZe4XKZ+IW3VrjcmDwjZAN93QaJ
V1wo8RQ3+pXu0cU+/Dkca032XvWKZmGQByn207JeOMOghOci9GLZlV6OD+jDRQHlfOXlUrkv2i6j
HZdg+IPK/i5VDwse5vA3A9V4Jy5OOqic/6ZGfZN5U6oRdsNpM0Jnc2pCgJMCCdDXmVSArh1kVZpL
ABt3P/8jJFEg3BKO8AVS0ur9GCv44yowyTA0hrNW2tKA
--000000000000c252940600da669c--
