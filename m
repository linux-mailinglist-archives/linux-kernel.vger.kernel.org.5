Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EADE759C32
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjGSROb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjGSRO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:14:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BBE172E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:14:28 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6689430d803so4882141b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1689786867; x=1690391667;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qalv+Q4Ug8+K0+0tgKoGeHLaBY2cykE7CA2ZTIz7x+E=;
        b=fjbLHIh+EQ6yGJ6KwjuQjH9u49mhnDY/cL6wkusFHEQFvPuzqghxU+duCkcdjXIftQ
         2PfL0LMLa3P4RwAD82HDbH9I86LuvqkpppCSJQcm2GuZOMSVtAQYKMfVRZkZn2Y7lLdV
         f1/9JPz6rjujr9kjEDilF5gbBGpG/AlPXwAV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689786867; x=1690391667;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qalv+Q4Ug8+K0+0tgKoGeHLaBY2cykE7CA2ZTIz7x+E=;
        b=cDIjShOOAOkKLiSG/8BA7oiZJRmpAv6EeUkKDwqi3NAhSQ/As6F1UvrG0yWYQm9Gu/
         NH9k0mpZS3JTR6u6rc8NFk/tMNT6cisuw30AWyxhCgvR6eXb0VM3UMrrzGEY9aYy7gQz
         AOLWFNnTIwRdOGygK/BAoOeQAmw3UxHMyBD9wYGVa6NgjWrGpx7TwstNGjItrhfD3XbQ
         ZP0AKAxgSYuuE2NKhZRsmEzr5py1gdVkZC8fJvrhBkDNmrUQdybbleSWCDMSBChnpb+6
         sjGsV3weOljxowrB3PBPjQ0wcaqyZShKnZZQ+bmga9ybeIF3ouHrkUcu3ugCoQ+0GBem
         hiHw==
X-Gm-Message-State: ABy/qLZ4vLKZpDzIBwm3uYCUbhYJt9yKF24FDuqRQe9TWkx3bHyr5MYv
        cyIsO0zI2UzIXFY9xoudDlpHog==
X-Google-Smtp-Source: APBJJlH4qAGyCn3Pjhfr2yBINwFWna8Px7ZEguvUWaYDiv6s6h4AarUlPCFLiP/0UbqjddbW/L4jzA==
X-Received: by 2002:a05:6a20:3d15:b0:127:72c3:fd60 with SMTP id y21-20020a056a203d1500b0012772c3fd60mr111783pzi.1.1689786867395;
        Wed, 19 Jul 2023 10:14:27 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902ea8300b001b895336435sm4271659plb.21.2023.07.19.10.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 10:14:27 -0700 (PDT)
Message-ID: <873b7f79-6049-a5fc-f64c-f2c5c09c43ce@broadcom.com>
Date:   Wed, 19 Jul 2023 10:10:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] misc: bcm_vk: Fix potential deadlock on &vk->ctx_lock
To:     Chengfeng Ye <dg573847474@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20230629182941.13045-1-dg573847474@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
In-Reply-To: <20230629182941.13045-1-dg573847474@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ffca330600da2985"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000ffca330600da2985
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Works fine.  Corrected Acked-by and Tested-by below.

On 2023-06-29 11:29, Chengfeng Ye wrote:
> As &vk->ctx_lock is acquired by timer bcm_vk_hb_poll() under softirq
> context, other process context code should disable irq or bottom-half
> before acquire the same lock, otherwise deadlock could happen if the
> timer preempt the execution while the lock is held in process context
> on the same CPU.
> 
> Possible deadlock scenario
> bcm_vk_open()
>      -> bcm_vk_get_ctx()
>      -> spin_lock(&vk->ctx_lock)
> 	<timer iterrupt>
> 	-> bcm_vk_hb_poll()
> 	-> bcm_vk_blk_drv_access()
> 	-> spin_lock_irqsave(&vk->ctx_lock, flags) (deadlock here)
> 
> This flaw was found using an experimental static analysis tool we are
> developing for irq-related deadlock, which reported the following
> warning when analyzing the linux kernel 6.4-rc7 release.
> 
> [Deadlock]: &vk->ctx_lock
>    [Interrupt]: bcm_vk_hb_poll
>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
>    [Locking Unit]: bcm_vk_ioctl
>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:1181
>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
> 
> [Deadlock]: &vk->ctx_lock
>    [Interrupt]: bcm_vk_hb_poll
>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
>    [Locking Unit]: bcm_vk_ioctl
>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:1169
> 
> [Deadlock]: &vk->ctx_lock
>    [Interrupt]: bcm_vk_hb_poll
>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
>    [Locking Unit]: bcm_vk_open
>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:216
> 
> [Deadlock]: &vk->ctx_lock
>    [Interrupt]: bcm_vk_hb_poll
>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
>    [Locking Unit]: bcm_vk_release
>      -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:306
> 
> As suggested by Arnd, the tentative patch fix the potential deadlocks
> by replacing the timer with delay workqueue. x86_64 allyesconfig using
> GCC shows no new warning. Note that no runtime testing was performed
> due to no device on hand.
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
Tested-by: Desmond Yan <desmond.yan@broadcom.com>

> ---
>   drivers/misc/bcm-vk/bcm_vk.h     |  2 +-
>   drivers/misc/bcm-vk/bcm_vk_msg.c | 14 +++++++-------
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
> index 25d51222eedf..386884c2a263 100644
> --- a/drivers/misc/bcm-vk/bcm_vk.h
> +++ b/drivers/misc/bcm-vk/bcm_vk.h
> @@ -340,7 +340,7 @@ struct bcm_vk_proc_mon_info {
>   };
>   
>   struct bcm_vk_hb_ctrl {
> -	struct timer_list timer;
> +	struct delayed_work work;
>   	u32 last_uptime;
>   	u32 lost_cnt;
>   };
> diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
> index 3c081504f38c..e17d81231ea6 100644
> --- a/drivers/misc/bcm-vk/bcm_vk_msg.c
> +++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
> @@ -137,11 +137,11 @@ void bcm_vk_set_host_alert(struct bcm_vk *vk, u32 bit_mask)
>   #define BCM_VK_HB_TIMER_VALUE (BCM_VK_HB_TIMER_S * HZ)
>   #define BCM_VK_HB_LOST_MAX (27 / BCM_VK_HB_TIMER_S)
>   
> -static void bcm_vk_hb_poll(struct timer_list *t)
> +static void bcm_vk_hb_poll(struct work_struct *work)
>   {
>   	u32 uptime_s;
> -	struct bcm_vk_hb_ctrl *hb = container_of(t, struct bcm_vk_hb_ctrl,
> -						 timer);
> +	struct bcm_vk_hb_ctrl *hb = container_of(to_delayed_work(work), struct bcm_vk_hb_ctrl,
> +						 work);
>   	struct bcm_vk *vk = container_of(hb, struct bcm_vk, hb_ctrl);
>   
>   	if (bcm_vk_drv_access_ok(vk) && hb_mon_is_on()) {
> @@ -177,22 +177,22 @@ static void bcm_vk_hb_poll(struct timer_list *t)
>   		bcm_vk_set_host_alert(vk, ERR_LOG_HOST_HB_FAIL);
>   	}
>   	/* re-arm timer */
> -	mod_timer(&hb->timer, jiffies + BCM_VK_HB_TIMER_VALUE);
> +	schedule_delayed_work(&hb->work, BCM_VK_HB_TIMER_VALUE);
>   }
>   
>   void bcm_vk_hb_init(struct bcm_vk *vk)
>   {
>   	struct bcm_vk_hb_ctrl *hb = &vk->hb_ctrl;
>   
> -	timer_setup(&hb->timer, bcm_vk_hb_poll, 0);
> -	mod_timer(&hb->timer, jiffies + BCM_VK_HB_TIMER_VALUE);
> +	INIT_DELAYED_WORK(&hb->work, bcm_vk_hb_poll);
> +	schedule_delayed_work(&hb->work, BCM_VK_HB_TIMER_VALUE);
>   }
>   
>   void bcm_vk_hb_deinit(struct bcm_vk *vk)
>   {
>   	struct bcm_vk_hb_ctrl *hb = &vk->hb_ctrl;
>   
> -	del_timer(&hb->timer);
> +	cancel_delayed_work_sync(&hb->work);
>   }
>   
>   static void bcm_vk_msgid_bitmap_clear(struct bcm_vk *vk,

--000000000000ffca330600da2985
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
aon9PduLGVgSMfiFb2nQ2w0PzDSefbrZKRQAGcSvcQlWb8XU7YKGbLhjR9c/r3KF4iUW8w2T2pd+
bO6aQXt8b1C9YG/V+B65TuJXxgX0veIJEyP+Cl0Im5vNwwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzY290dC5icmFuZGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU8+MSO/sprODwb9D5cjaq
JNiLqgkwDQYJKoZIhvcNAQELBQADggEBAA25uPHwC95BhvFXuEOAk+J5FZV4v82uly/X7LATDzrf
tsww461GRAidKV8lvziiIw6OQQgO9Ei/yC8bVdzDLQJF2PhxcWhc+4II6AkUyRC+Tmfk7xmPEYSv
MHgQfpwPU6C1o4FI/8XjfJgk1dE4j4v16iLKC2qfBqfdzdT/cJaCg/fZfL0w5RLtGOOVIMBWwObx
UKmtYSCgcvRKmLailjlxgiUaYgxdZSpwR0RvFJapt0KzMR5OIP96iyXYVWbl9qy8uY9gqEeNaaQm
Bt8T4oEXHxRvse+Ij162RjEysEsDgkiE/koCb3YFlkVu5lL1N0M7EIo+XiuWWUEjuhztPasxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxPA+M+AQMMGpZn
bCswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIG+47WPMaYwjwVYtrkTh3Nae/aTe
ZrLBE5h775qhP7v6MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDcxOTE3MTQyN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBQQDD5mAxU31pgVHixFRzWM5INFv0L7jjtuiEquzI6uVK5
bDzp1kr3m0Nddstnn4WsRIeHBgyZtdwNsA3oinkEMRlE57Zv/S8Z8qjj6Us3HQcKJgE9j0QVqq58
rJ7Oncs1XwciksAlU2z+7ceOQ3U+lpSAzBZNfx/QKr6dJCGYnFYllhi8+uMUfvxZxqQV7EriDUhb
jgP8Y7Jmcy8FgKjsTcp41K1G/vwfjUV55UhOg10cBzaIb4mM7+RXFNbmKw0CIqhmWgjtjMCnSSMp
ZoSaDaK4DY8nEwpQtGiE30oX/ILNfaExauLmGI5+1gbgsZLhvfiVBp9hSmH4a4HO4bU8
--000000000000ffca330600da2985--
