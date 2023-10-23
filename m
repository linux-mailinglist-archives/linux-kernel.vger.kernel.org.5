Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16467D3A55
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjJWPEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjJWPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:04:00 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBE2FF;
        Mon, 23 Oct 2023 08:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1698073433; x=1698332633;
        bh=0c3JKyxrwN1y83bJD05SyppIYuEj3A/9KtZPuGixCOY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=A741tiTFR96yaUuRQswNLRrAbkhuz6AJBv/qu35aOQQ/iSyG8dkwC/u9TE5Y7yF4R
         Jh+EgqSK4za5Fa7enAfHaC34ON6SHY3QKtemenFj1bis1OWwA2gn7QEjHHHyK/v9NU
         7iBNJa7puEOzsz2XO6+/TcNAEBlXWDboqboyAvVVlD0BrIdSAcnVtQC9leoYavexAw
         4hDba1q328HP53dLgWSUQeW/rVdDyh2jLn3sq5e3bSSez2OJEL8AlYre9ynVrps6oJ
         VccEG+S8oWWuqA8Wfs/DajXzYhuzpde0AoS7SaQFjypVdHC+MJd5XMqaao14Sjt1Wa
         JHdSsxW0XW5xw==
Date:   Mon, 23 Oct 2023 15:03:35 +0000
To:     Charles Yi <be286@163.com>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: fix a crash in hid_debug_events_release
Message-ID: <87a5s9mldo.fsf@protonmail.com>
In-Reply-To: <20231023093500.1391443-1-be286@163.com>
References: <20231023093500.1391443-1-be286@163.com>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On Mon, 23 Oct, 2023 17:35:00 +0800 "Charles Yi" <be286@163.com> wrote:
> hid_debug_events_release() access released memory by
> hid_device_release(). This is fixed by the patch.
>

A couple of things here. Can you add a Fixes: tag?

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#desc=
ribe-your-changes

Before any v2 however, it would be nice to understand where this issue
is coming from. I am wondering if it's really a core issue or rather an
issue with a higher level device specific driver making use of the hid
subsystem. I am having a hard time seeing how this issue occurs
currently. A stack trace in a follow-up email to this one pertaining to
the crash would be helpful. If you are resolving a syzbot report, a link
to that report would suffice.

This patch doesn't make a lot of sense to me as-is because
hid_debug_events_release is about release resources related to hid debug
events (at least from my current understanding). It should not be
free-ing the underlying hid device/instance itself.

> Signed-off-by: Charles Yi <be286@163.com>
> ---
>  drivers/hid/hid-core.c  | 12 ++++++++++--
>  drivers/hid/hid-debug.c |  3 +++
>  include/linux/hid.h     |  3 +++
>  3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 8992e3c1e769..e0181218ad85 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -702,15 +702,22 @@ static void hid_close_report(struct hid_device *dev=
ice)
>   * Free a device structure, all reports, and all fields.
>   */
>
> -static void hid_device_release(struct device *dev)
> +void hiddev_free(struct kref *ref)
>  {
> -=09struct hid_device *hid =3D to_hid_device(dev);
> +=09struct hid_device *hid =3D container_of(ref, struct hid_device, ref);
>
>  =09hid_close_report(hid);
>  =09kfree(hid->dev_rdesc);
>  =09kfree(hid);
>  }
>
> +static void hid_device_release(struct device *dev)
> +{
> +=09struct hid_device *hid =3D to_hid_device(dev);
> +
> +=09kref_put(&hid->ref, hiddev_free);
> +}
> +
>  /*
>   * Fetch a report description item from the data stream. We support long
>   * items, though they are not used yet.
> @@ -2846,6 +2853,7 @@ struct hid_device *hid_allocate_device(void)
>  =09spin_lock_init(&hdev->debug_list_lock);
>  =09sema_init(&hdev->driver_input_lock, 1);
>  =09mutex_init(&hdev->ll_open_lock);
> +=09kref_init(&hdev->ref);
>
>  =09hid_bpf_device_init(hdev);
>
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index e7ef1ea107c9..7dd83ec74f8a 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -1135,6 +1135,7 @@ static int hid_debug_events_open(struct inode *inod=
e, struct file *file)
>  =09=09goto out;
>  =09}
>  =09list->hdev =3D (struct hid_device *) inode->i_private;
> +=09kref_get(&list->hdev->ref);
>  =09file->private_data =3D list;
>  =09mutex_init(&list->read_mutex);
>
> @@ -1227,6 +1228,8 @@ static int hid_debug_events_release(struct inode *i=
node, struct file *file)
>  =09list_del(&list->node);
>  =09spin_unlock_irqrestore(&list->hdev->debug_list_lock, flags);
>  =09kfifo_free(&list->hid_debug_fifo);
> +
> +=09kref_put(&list->hdev->ref, hiddev_free);
>  =09kfree(list);
>
>  =09return 0;
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 964ca1f15e3f..3b08a2957229 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -679,6 +679,7 @@ struct hid_device {=09=09=09=09=09=09=09/* device rep=
ort descriptor */
>  =09struct list_head debug_list;
>  =09spinlock_t  debug_list_lock;
>  =09wait_queue_head_t debug_wait;
> +=09struct kref=09=09=09ref;
>
>  =09unsigned int id;=09=09=09=09=09=09/* system unique id */
>
> @@ -687,6 +688,8 @@ struct hid_device {=09=09=09=09=09=09=09/* device rep=
ort descriptor */
>  #endif /* CONFIG_BPF */
>  };
>
> +void hiddev_free(struct kref *ref);
> +
>  #define to_hid_device(pdev) \
>  =09container_of(pdev, struct hid_device, dev)

--
Thank you for the patch,

Rahul Rameshbabu

