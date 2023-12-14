Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DE581331A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573487AbjLNO3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573481AbjLNO3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:29:33 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9229115
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:29:39 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-4649f003bcdso1736635137.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702564179; x=1703168979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfRayX2hEmSWi4tvx4w1Kk7KYgdDObIRBuKBCUCOV8E=;
        b=zbqM4KBt4XPP8xX7I0zfetKE0GZkxDTlSu64K0U82/zKC0EuploLNHCsMyzFxocndd
         hoLJLf7ytxclRMBtJUDkS9t7k5+pRrFQD9DtZkkN4Cy5Z38ftJJPjpgW+b4jxX3ak0W/
         6wo9TMjYbybI4SCALfsd8UG2v+k6gKWGXCgzUbjzMqCj5x65Dd3yeRjQhsutRGxDIlXs
         AL486vCbnGB6JeMD4JEhE4+wuVeTsrI5JxkBdOcXsQCRlPI9j8x8EGnrcOfT8VnBSVyE
         fibDcdWGSu58+pnsn40n6nomWTT3at/rjj0hVdjGyxao5IjspUxkv5tNc8odqULRLk0r
         HAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702564179; x=1703168979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfRayX2hEmSWi4tvx4w1Kk7KYgdDObIRBuKBCUCOV8E=;
        b=jLGHN7Eht879KSbxH2U84awcuHMArkOS7/Fa3v09RDY4fG9WwXtR16XxGoACAiFR+v
         Tii9ooDluFdNrDmxrijOTTXeZ+HTqn/lehX8NuGd3M0pJi33Yw9C9dlArVUY3QzzPbqY
         G/Bm3hDWC8myqEf2xgKek1XTKlLicR9xj+Hg3i964WmZH9qpIdF14v5gJbrfTQApq+G6
         DTZKb7FD6A0uRKpg1bgyXTHCmmAbW41DlVe490d37fyzU8D5PW+jGUk6TK5PcLcZDP8X
         zwPHZAzvH3RWjrjnJIq7DGrGR/TMBVkWgJVfRFkA9XyfWItLP7o0frnfswTVdojqfeZD
         +U3Q==
X-Gm-Message-State: AOJu0Yw9TiK5bx8wfhzqtC5y8aYzvHzmWGQJzMie591dMbaLFDc+mXqL
        exqMZLB6UNVWVLW6ep8TBI+CnFf8AjmYw+F/shargQ==
X-Google-Smtp-Source: AGHT+IGCttlN/u5JYjLcJ3Apj1euoXVxuW71MHkndnQIQJU3CZTaY9pDAPvUQjZU/r3OfFsKQ0VxtJl0XaLWpFrZgCM=
X-Received: by 2002:a05:6102:f12:b0:464:837e:2f84 with SMTP id
 v18-20020a0561020f1200b00464837e2f84mr8712192vss.6.1702564178900; Thu, 14 Dec
 2023 06:29:38 -0800 (PST)
MIME-Version: 1.0
References: <20231214095814.132400-1-warthog618@gmail.com> <20231214095814.132400-3-warthog618@gmail.com>
In-Reply-To: <20231214095814.132400-3-warthog618@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 14 Dec 2023 15:29:28 +0100
Message-ID: <CAMRc=MeoeOgZaz6xT+ScVjOemVovrEHvQDBvqsN1pD9U3haE_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 10:58=E2=80=AFAM Kent Gibson <warthog618@gmail.com>=
 wrote:
>
> Store the debounce period for a requested line locally, rather than in
> the debounce_period_us field in the gpiolib struct gpio_desc.
>
> Add a global tree of lines containing supplemental line information
> to make the debounce period available to be reported by the
> GPIO_V2_GET_LINEINFO_IOCTL and the line change notifier.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 167 +++++++++++++++++++++++++++++++-----
>  1 file changed, 145 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index d03698812f61..7da3b3706547 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -21,6 +21,7 @@
>  #include <linux/mutex.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/poll.h>
> +#include <linux/rbtree.h>
>  #include <linux/seq_file.h>
>  #include <linux/spinlock.h>
>  #include <linux/timekeeping.h>
> @@ -461,6 +462,7 @@ static int linehandle_create(struct gpio_device *gdev=
, void __user *ip)
>
>  /**
>   * struct line - contains the state of a requested line
> + * @node: to store the object in supinfo if supplemental
>   * @desc: the GPIO descriptor for this line.
>   * @req: the corresponding line request
>   * @irq: the interrupt triggered in response to events on this GPIO
> @@ -473,6 +475,7 @@ static int linehandle_create(struct gpio_device *gdev=
, void __user *ip)
>   * @line_seqno: the seqno for the current edge event in the sequence of
>   * events for this line.
>   * @work: the worker that implements software debouncing
> + * @debounce_period_us: the debounce period in microseconds
>   * @sw_debounced: flag indicating if the software debouncer is active
>   * @level: the current debounced physical level of the line
>   * @hdesc: the Hardware Timestamp Engine (HTE) descriptor
> @@ -481,6 +484,7 @@ static int linehandle_create(struct gpio_device *gdev=
, void __user *ip)
>   * @last_seqno: the last sequence number before debounce period expires
>   */
>  struct line {
> +       struct rb_node node;
>         struct gpio_desc *desc;
>         /*
>          * -- edge detector specific fields --
> @@ -514,6 +518,15 @@ struct line {
>          * -- debouncer specific fields --
>          */
>         struct delayed_work work;
> +       /*
> +        * debounce_period_us is accessed by debounce_irq_handler() and
> +        * process_hw_ts() which are disabled when modified by
> +        * debounce_setup(), edge_detector_setup() or edge_detector_stop(=
)
> +        * or can live with a stale version when updated by
> +        * edge_detector_update().
> +        * The modifying functions are themselves mutually exclusive.
> +        */
> +       unsigned int debounce_period_us;
>         /*
>          * sw_debounce is accessed by linereq_set_config(), which is the
>          * only setter, and linereq_get_values(), which can live with a
> @@ -546,6 +559,19 @@ struct line {
>  #endif /* CONFIG_HTE */
>  };
>
> +/*
> + * Used to populate gpio_v2_line_info with cdev specific fields not cont=
ained
> + * in the struct gpio_desc.
> + * A line is determined to contain supplemental information by
> + * line_is_supplemental().
> + */
> +static struct {
> +       /* a rbtree of the struct lines containing the supplemental info =
*/
> +       struct rb_root tree;
> +       /* covers tree */
> +       spinlock_t lock;

Looks like this is never taken from atomic context? Can this be a mutex ins=
tead?

> +} supinfo;
> +
>  /**
>   * struct linereq - contains the state of a userspace line request
>   * @gdev: the GPIO device the line request pertains to
> @@ -575,6 +601,100 @@ struct linereq {
>         struct line lines[] __counted_by(num_lines);
>  };
>
> +static void supinfo_init(void)
> +{
> +       supinfo.tree =3D RB_ROOT;
> +       spin_lock_init(&supinfo.lock);
> +}
> +
> +static void supinfo_insert(struct line *line)
> +{
> +       struct rb_node **new =3D &(supinfo.tree.rb_node), *parent =3D NUL=
L;
> +       struct line *entry;
> +
> +       scoped_guard(spinlock, &supinfo.lock) {
> +               while (*new) {
> +                       entry =3D container_of(*new, struct line, node);
> +
> +                       parent =3D *new;
> +                       if (line->desc < entry->desc) {
> +                               new =3D &((*new)->rb_left);
> +                       } else if (line->desc > entry->desc) {
> +                               new =3D &((*new)->rb_right);
> +                       } else {
> +                               /* this should never happen */
> +                               WARN(1, "duplicate line inserted");
> +                               return;
> +                       }
> +               }
> +
> +               rb_link_node(&line->node, parent, new);
> +               rb_insert_color(&line->node, &supinfo.tree);
> +       }
> +}
> +
> +static void supinfo_erase(struct line *line)
> +{
> +       scoped_guard(spinlock, &supinfo.lock)
> +               rb_erase(&line->node, &supinfo.tree);
> +}
> +
> +static struct line *supinfo_find(struct gpio_desc *desc)
> +{
> +       struct rb_node *node =3D supinfo.tree.rb_node;
> +       struct line *line;
> +
> +       while (node) {
> +               line =3D container_of(node, struct line, node);
> +               if (desc < line->desc)
> +                       node =3D node->rb_left;
> +               else if (desc > line->desc)
> +                       node =3D node->rb_right;
> +               else
> +                       return line;
> +       }
> +       return NULL;
> +}
> +
> +static void supinfo_to_lineinfo(struct gpio_desc *desc,
> +                               struct gpio_v2_line_info *info)
> +{
> +       struct gpio_v2_line_attribute *attr;
> +       struct line *line;
> +
> +       scoped_guard(spinlock, &supinfo.lock) {
> +               line =3D supinfo_find(desc);
> +               if (line) {
> +                       attr =3D &info->attrs[info->num_attrs];
> +                       attr->id =3D GPIO_V2_LINE_ATTR_ID_DEBOUNCE;
> +                       attr->debounce_period_us =3D
> +                               READ_ONCE(line->debounce_period_us);
> +                       info->num_attrs++;
> +               }
> +       }
> +}
> +
> +static inline bool line_is_supplemental(struct line *line)

I would call this function line_has_suppinfo().

> +{
> +       return READ_ONCE(line->debounce_period_us);
> +}
> +
> +static void line_set_debounce_period(struct line *line,
> +                                    unsigned int debounce_period_us)
> +{
> +       bool was_suppl =3D line_is_supplemental(line);

This logic could use some comments, it took me a while to figure out
what it's doing.

> +
> +       WRITE_ONCE(line->debounce_period_us, debounce_period_us);
> +
> +       if (line_is_supplemental(line) =3D=3D was_suppl)
> +               return;
> +
> +       if (was_suppl)
> +               supinfo_erase(line);
> +       else
> +               supinfo_insert(line);
> +}
> +
>  #define GPIO_V2_LINE_BIAS_FLAGS \
>         (GPIO_V2_LINE_FLAG_BIAS_PULL_UP | \
>          GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN | \
> @@ -723,7 +843,7 @@ static enum hte_return process_hw_ts(struct hte_ts_da=
ta *ts, void *p)
>                 line->total_discard_seq++;
>                 line->last_seqno =3D ts->seq;
>                 mod_delayed_work(system_wq, &line->work,
> -                 usecs_to_jiffies(READ_ONCE(line->desc->debounce_period_=
us)));
> +                 usecs_to_jiffies(READ_ONCE(line->debounce_period_us)));
>         } else {
>                 if (unlikely(ts->seq < line->line_seqno))
>                         return HTE_CB_HANDLED;
> @@ -864,7 +984,7 @@ static irqreturn_t debounce_irq_handler(int irq, void=
 *p)
>         struct line *line =3D p;
>
>         mod_delayed_work(system_wq, &line->work,
> -               usecs_to_jiffies(READ_ONCE(line->desc->debounce_period_us=
)));
> +               usecs_to_jiffies(READ_ONCE(line->debounce_period_us)));
>
>         return IRQ_HANDLED;
>  }
> @@ -946,7 +1066,7 @@ static int debounce_setup(struct line *line, unsigne=
d int debounce_period_us)
>         /* try hardware */
>         ret =3D gpiod_set_debounce(line->desc, debounce_period_us);
>         if (!ret) {
> -               WRITE_ONCE(line->desc->debounce_period_us, debounce_perio=
d_us);
> +               line_set_debounce_period(line, debounce_period_us);
>                 return ret;
>         }
>         if (ret !=3D -ENOTSUPP)
> @@ -1025,8 +1145,7 @@ static void edge_detector_stop(struct line *line)
>         cancel_delayed_work_sync(&line->work);
>         WRITE_ONCE(line->sw_debounced, 0);
>         WRITE_ONCE(line->edflags, 0);
> -       if (line->desc)
> -               WRITE_ONCE(line->desc->debounce_period_us, 0);
> +       line_set_debounce_period(line, 0);
>         /* do not change line->level - see comment in debounced_value() *=
/
>  }
>
> @@ -1051,7 +1170,7 @@ static int edge_detector_setup(struct line *line,
>                 ret =3D debounce_setup(line, debounce_period_us);
>                 if (ret)
>                         return ret;
> -               WRITE_ONCE(line->desc->debounce_period_us, debounce_perio=
d_us);
> +               line_set_debounce_period(line, debounce_period_us);
>         }
>
>         /* detection disabled or sw debouncer will provide edge detection=
 */
> @@ -1093,12 +1212,12 @@ static int edge_detector_update(struct line *line=
,
>                         gpio_v2_line_config_debounce_period(lc, line_idx)=
;
>
>         if ((active_edflags =3D=3D edflags) &&
> -           (READ_ONCE(line->desc->debounce_period_us) =3D=3D debounce_pe=
riod_us))
> +           (READ_ONCE(line->debounce_period_us) =3D=3D debounce_period_u=
s))
>                 return 0;
>
>         /* sw debounced and still will be...*/
>         if (debounce_period_us && READ_ONCE(line->sw_debounced)) {
> -               WRITE_ONCE(line->desc->debounce_period_us, debounce_perio=
d_us);
> +               line_set_debounce_period(line, debounce_period_us);
>                 return 0;
>         }
>
> @@ -1561,6 +1680,7 @@ static ssize_t linereq_read(struct file *file, char=
 __user *buf,
>
>  static void linereq_free(struct linereq *lr)
>  {
> +       struct line *line;
>         unsigned int i;
>
>         if (lr->device_unregistered_nb.notifier_call)
> @@ -1568,10 +1688,14 @@ static void linereq_free(struct linereq *lr)
>                                                    &lr->device_unregister=
ed_nb);
>
>         for (i =3D 0; i < lr->num_lines; i++) {
> -               if (lr->lines[i].desc) {
> -                       edge_detector_stop(&lr->lines[i]);
> -                       gpiod_free(lr->lines[i].desc);
> -               }
> +               line =3D &lr->lines[i];
> +               if (!line->desc)
> +                       continue;
> +
> +               edge_detector_stop(line);
> +               if (line_is_supplemental(line))
> +                       supinfo_erase(line);
> +               gpiod_free(line->desc);
>         }
>         kfifo_free(&lr->events);
>         kfree(lr->label);
> @@ -2256,8 +2380,6 @@ static void gpio_desc_to_lineinfo(struct gpio_desc =
*desc,
>         struct gpio_chip *gc =3D desc->gdev->chip;
>         bool ok_for_pinctrl;
>         unsigned long flags;
> -       u32 debounce_period_us;
> -       unsigned int num_attrs =3D 0;
>
>         memset(info, 0, sizeof(*info));
>         info->offset =3D gpio_chip_hwgpio(desc);
> @@ -2323,14 +2445,6 @@ static void gpio_desc_to_lineinfo(struct gpio_desc=
 *desc,
>         else if (test_bit(FLAG_EVENT_CLOCK_HTE, &desc->flags))
>                 info->flags |=3D GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE;
>
> -       debounce_period_us =3D READ_ONCE(desc->debounce_period_us);
> -       if (debounce_period_us) {
> -               info->attrs[num_attrs].id =3D GPIO_V2_LINE_ATTR_ID_DEBOUN=
CE;
> -               info->attrs[num_attrs].debounce_period_us =3D debounce_pe=
riod_us;
> -               num_attrs++;
> -       }
> -       info->num_attrs =3D num_attrs;
> -
>         spin_unlock_irqrestore(&gpio_lock, flags);
>  }
>
> @@ -2437,6 +2551,7 @@ static int lineinfo_get(struct gpio_chardev_data *c=
dev, void __user *ip,
>                         return -EBUSY;
>         }
>         gpio_desc_to_lineinfo(desc, &lineinfo);
> +       supinfo_to_lineinfo(desc, &lineinfo);
>
>         if (copy_to_user(ip, &lineinfo, sizeof(lineinfo))) {
>                 if (watch)
> @@ -2527,6 +2642,7 @@ static int lineinfo_changed_notify(struct notifier_=
block *nb,
>         chg.event_type =3D action;
>         chg.timestamp_ns =3D ktime_get_ns();
>         gpio_desc_to_lineinfo(desc, &chg.info);
> +       supinfo_to_lineinfo(desc, &chg.info);
>
>         ret =3D kfifo_in_spinlocked(&cdev->events, &chg, 1, &cdev->wait.l=
ock);
>         if (ret)
> @@ -2786,3 +2902,10 @@ void gpiolib_cdev_unregister(struct gpio_device *g=
dev)
>         cdev_device_del(&gdev->chrdev, &gdev->dev);
>         blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
>  }
> +
> +static int __init gpiolib_cdev_init(void)
> +{
> +       supinfo_init();
> +       return 0;
> +}
> +postcore_initcall(gpiolib_cdev_init);
> --
> 2.39.2
>

Bart
