Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4DE7E1975
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 05:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjKFEwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 23:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjKFEv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 23:51:58 -0500
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF5EE1;
        Sun,  5 Nov 2023 20:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1699246312; x=1699505512;
        bh=dut+DCoHkZ6CdEZqzZ2/tTUSxjnnVUmoOixdpBeFz4I=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=PsL+XrqmkeEuQVHia9IuPk2/F/1drtxg+fN422ISdChAsh8kV08Md6SWTpoAVo7Mw
         +DBM8Rtiec79zwTOVBzAR6RwyNRX7t2W+jK1rnlqFW7Fd56hktTjfp7migIwtWHIKE
         Yew7cLZKb5BqjwjeOQGCJEUCAUsC+y0z1ZTXB9PXIpm1WWLh36eM/8D2gQDkNJmb0E
         jDYB3EdUY+SR4rjwinRM8mPgzjWuIKX+oxLDFIsg+G9o2qtONwXtJ7U6AEseM0X3OA
         bYS4akNw1tw+WnoKmcQvGEk8MxkWs9CJC8wcHqrL95+KjuIqZ2Eta6za3lXAOyIS2c
         fIOazOsYqnm/g==
Date:   Mon, 06 Nov 2023 04:51:38 +0000
To:     Charles Yi <be286@163.com>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: fix a crash in hid_debug_events_release
Message-ID: <87ttpzzdpm.fsf@protonmail.com>
In-Reply-To: <20231031043239.157943-1-be286@163.com>
References: <20231031043239.157943-1-be286@163.com>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lets clean up the subject/commit message heading.

  HID: fix HID device resource race between HID core and debugging support

In the commit message body, we can expand on the details a bit more.

On Tue, 31 Oct, 2023 12:32:39 +0800 "Charles Yi" <be286@163.com> wrote:
> hid_debug_events_release() access released memory by
> hid_device_release(). This is fixed by the patch.
>
> When hid_debug_events_release() was being called, in most case,
> hid_device_release() finish already, the memory of list->hdev
> freed by hid_device_release(), if list->hdev memory
> reallocate by others, and it's modified, zeroed, then
> list->hdev->debug_list_lock occasioned crash come out.

Lets clean up these paragraphs a bit.

  hid_debug_events_release releases resources bound to the HID device
  instance. hid_device_release releases the underlying HID device
  instance potentially before hid_debug_events_release has completed
  releasing debug resources bound to the same HID device instance.

  Reference count to prevent the HID device instance from being torn
  down preemptively when HID debugging support is used. When count
  reaches zero, release core resources of HID device instance using
  hiddev_free.

Feel free to use the above if you think its nice or feel free to polish
up the commit message body you originally had a bit more.

>
> The crash:
>
> [  120.728477][ T4396] kernel BUG at lib/list_debug.c:53!
> [  120.728505][ T4396] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [  120.739806][ T4396] Modules linked in: bcmdhd dhd_static_buf 8822cu pc=
ie_mhi r8168
> [  120.747386][ T4396] CPU: 1 PID: 4396 Comm: hidt_bridge Not tainted 5.1=
0.110 #257
> [  120.754771][ T4396] Hardware name: Rockchip RK3588 EVB4 LP4 V10 Board =
(DT)
> [  120.761643][ T4396] pstate: 60400089 (nZCv daIf +PAN -UAO -TCO BTYPE=
=3D--)
> [  120.768338][ T4396] pc : __list_del_entry_valid+0x98/0xac
> [  120.773730][ T4396] lr : __list_del_entry_valid+0x98/0xac
> [  120.779120][ T4396] sp : ffffffc01e62bb60
> [  120.783126][ T4396] x29: ffffffc01e62bb60 x28: ffffff818ce3a200
> [  120.789126][ T4396] x27: 0000000000000009 x26: 0000000000980000
> [  120.795126][ T4396] x25: ffffffc012431000 x24: ffffff802c6d4e00
> [  120.801125][ T4396] x23: ffffff8005c66f00 x22: ffffffc01183b5b8
> [  120.807125][ T4396] x21: ffffff819df2f100 x20: 0000000000000000
> [  120.813124][ T4396] x19: ffffff802c3f0700 x18: ffffffc01d2cd058
> [  120.819124][ T4396] x17: 0000000000000000 x16: 0000000000000000
> [  120.825124][ T4396] x15: 0000000000000004 x14: 0000000000003fff
> [  120.831123][ T4396] x13: ffffffc012085588 x12: 0000000000000003
> [  120.837123][ T4396] x11: 00000000ffffbfff x10: 0000000000000003
> [  120.843123][ T4396] x9 : 455103d46b329300 x8 : 455103d46b329300
> [  120.849124][ T4396] x7 : 74707572726f6320 x6 : ffffffc0124b8cb5
> [  120.855124][ T4396] x5 : ffffffffffffffff x4 : 0000000000000000
> [  120.861123][ T4396] x3 : ffffffc011cf4f90 x2 : ffffff81fee7b948
> [  120.867122][ T4396] x1 : ffffffc011cf4f90 x0 : 0000000000000054
> [  120.873122][ T4396] Call trace:
> [  120.876259][ T4396]  __list_del_entry_valid+0x98/0xac
> [  120.881304][ T4396]  hid_debug_events_release+0x48/0x12c
> [  120.886617][ T4396]  full_proxy_release+0x50/0xbc
> [  120.891323][ T4396]  __fput+0xdc/0x238
> [  120.895075][ T4396]  ____fput+0x14/0x24
> [  120.898911][ T4396]  task_work_run+0x90/0x148
> [  120.903268][ T4396]  do_exit+0x1bc/0x8a4
> [  120.907193][ T4396]  do_group_exit+0x8c/0xa4
> [  120.911458][ T4396]  get_signal+0x468/0x744
> [  120.915643][ T4396]  do_signal+0x84/0x280
> [  120.919650][ T4396]  do_notify_resume+0xd0/0x218
> [  120.924262][ T4396]  work_pending+0xc/0x3f0
>
> Fixes: <cd667ce24796> (HID: use debugfs for events/reports dumping)

The formatting of the Fixes: tag would look like the following.

  Fixes: cd667ce24796 ("HID: use debugfs for events/reports dumping")

You can also eliminate the whitespace between your git trailers, so the
end result looks like the following (minus the indentation).

  Fixes: cd667ce24796 ("HID: use debugfs for events/reports dumping")
  Signed-off-by: Charles Yi <be286@163.com>

>
> Signed-off-by: Charles Yi <be286@163.com>
>
> ---
> Changes in V2:
> - Add "Fixes:" tag and call trace to commit message.
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

Lets call this hid_hiddev_free. Took a look through hid-core.c, and I
think this would be better than calling it just hiddev_free.

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
Thanks for the patch,

Rahul Rameshbabu

