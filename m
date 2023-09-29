Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E503F7B3355
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjI2NSw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Sep 2023 09:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjI2NSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:18:50 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220AEB7;
        Fri, 29 Sep 2023 06:18:48 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-57bf04841ccso851271eaf.0;
        Fri, 29 Sep 2023 06:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695993527; x=1696598327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN8DsXjpnwwdKwwuRQAbxWLd/VJ6QmmZmSxP4LzKLFM=;
        b=b5IE6OPUgICG/S+zJyTY1OD09fZYcdLpkjEtOqEX8V4SsBemLEg1P2jqh18Fday5ve
         IJJp3PWUUDhGDcwhJci4bcYtFIVC2ilW4AaWtAu74BO7S7tptyZiBm6vnppZZRI8+n6G
         Q7sfwcLANtIYYDCZ3M9DBrlJD4M9IWenaCjQWFHcZwBmE5ZgZlPv7YNVJ+v4Jt5nMlW5
         T4u3vlw/C4A+vW5Z4zTxNtYGZGDHkzBRavbWVAKJNhbwvLA0tUFsPcTJEgG83js/KWVv
         r/q6mjfb1ns+6D6/pcStrXO64MSpsgqZwwWfq3VQTpuqrT+FNAqN06V4LzOfSAEXvCK6
         A5OA==
X-Gm-Message-State: AOJu0YyMT6UJ/pei/OzuuF+mbcfTXfavNhT6ZSkVkFa3zgq192Cq4lPY
        fhfpbL/970RONozz/2ubjRPaNGW2Kequx6ZyJy0=
X-Google-Smtp-Source: AGHT+IE8kxs8jZ7qOdr7ur9o+LAaYVeL0S8+xOVyMwluAODY07tu+JAOByIH80Vtezd++SQKMDs7eFtRyAT5Nj1RBGc=
X-Received: by 2002:a4a:a342:0:b0:57b:7804:9d72 with SMTP id
 u2-20020a4aa342000000b0057b78049d72mr4234797ool.1.1695993527255; Fri, 29 Sep
 2023 06:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230925081139.1305766-1-lukasz.luba@arm.com> <20230925081139.1305766-12-lukasz.luba@arm.com>
 <CAJZ5v0iebSOT--AiP-9-CYwqtTe7+kRddryJ3DdvFb3WUeji7w@mail.gmail.com> <a3907ec0-7e20-e3a5-3814-476a25e1efaa@arm.com>
In-Reply-To: <a3907ec0-7e20-e3a5-3814-476a25e1efaa@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Sep 2023 15:18:36 +0200
Message-ID: <CAJZ5v0jU1SZ5kPHYqM3DLGY9j8DgGp7XCciyy=fJAyHnkyGgtA@mail.gmail.com>
Subject: Re: [PATCH v4 11/18] PM: EM: Add runtime update interface to modify
 EM power
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:59 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 9/26/23 20:48, Rafael J. Wysocki wrote:
> > On Mon, Sep 25, 2023 at 10:11 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >
> > First off, I would merge this with the previous patch, as the changes
> > would be much clearer then IMO.
>
> I was trying to avoid a big patch ~150 lines. I will do that merge.
>
> >
> >> Add an interface which allows to modify EM power data at runtime.
> >> The new power information is populated by the provided callback, which
> >> is called for each performance state.
> >
> > But it all starts with copying the frequencies from the default table.
>
> Yes, I can add that to the description.
>
> >
> >> The CPU frequencies' efficiency is
> >> re-calculated since that might be affected as well. The old EM memory
> >> is going to be freed later using RCU mechanism.
> >
> > Not all of it, but the old runtime table that is not going to be used any more.
>
> True, I will rephrase that, to make it more precised.
>
> >
> >> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>
> [snip]
>
> >>
> >> +/**
> >> + * em_dev_update_perf_domain() - Update runtime EM table for a device
> >> + * @dev                : Device for which the EM is to be updated
> >> + * @cb         : Callback function providing the power data for the EM
> >> + * @priv       : Pointer to private data useful for passing context
> >> + *             which might be required while calling @cb
> >
> > It is still unclear to me who is going to use this priv pointer and how.
>
> I have explained that in some previous patch response. A driver or
> kernel module which monitors the thermal situation and has context.
>
> >
> >> + *
> >> + * Update EM runtime modifiable table for a @dev using the callback
> >> + * defined in @cb. The EM new power values are then used for calculating
> >> + * the em_perf_state::cost for associated performance state.
> >
> > It actually allocates a new runtime table and populates it from
> > scratch, using the frequencies from the default table and the
> > callback.
>
> Yes, it allocated new table and put the updated power values there.
> I can add that to the comment.
>
> >
> >> + *
> >> + * This function uses mutex to serialize writers, so it must not be called
> >
> > "a mutex"
>
> ACK
>
> >
> >> + * from non-sleeping context.
>
> [snip]
>
> >> +
> >> +       if (!dev || !dev->em_pd) {
> >
> > Checking dev against NULL under the mutex is pointless (either it is
> > NULL or it isn't, so check it earlier).
>
> ACK
>
> >
> >> +               ret = -EINVAL;
> >> +               goto unlock_em;
> >> +       }
> >> +
> >> +       pd = dev->em_pd;
> >
> > And I would check pd against NULL here.
>
> It's done above, next to '!dev || !dev->em_pd'

Yes, it is, I meant something like this:

    if (!cb || !cb->update_power || !dev)
        return -EINVAL;

    mutex_lock(&em_pd_mutex);

    pd = dev->em_pd;
    if (!pd) {
        ret = -EINVAL; /* or perhaps -ENODATA */
        goto unlock_em;
    }


> >
> >> +
> >> +       runtime_table = kzalloc(sizeof(*runtime_table), GFP_KERNEL);
> >> +       if (!runtime_table) {
> >> +               ret = -ENOMEM;
> >> +               goto unlock_em;
> >> +       }
> >> +
> >> +       runtime_table->state = kcalloc(pd->nr_perf_states,
> >> +                                      sizeof(struct em_perf_state),
> >> +                                      GFP_KERNEL);
> >> +       if (!runtime_table->state) {
> >> +               ret = -ENOMEM;
> >> +               goto free_runtime_table;
> >> +       }
> >
> > The above allocations can be merged into one and allocating memory
> > under the mutex is questionable.
>
> So how to make sure that there is no 2 callers trying to update the
> same EM or unregistration is not in the background?

You can allocate memory upfront and take the mutex before accessing
the shared data structures.  If there's an error in the code running
under the mutex, release it and then free the memory.

Allocating memory is one operation, updating the shared data
structures to use it is another one.  The former doesn't affect the
shared state in any way, so why do it under the mutex?

> [snip]
>
> >>
> >> @@ -501,9 +598,23 @@ void em_dev_unregister_perf_domain(struct device *dev)
> >>
> >>          runtime_table = pd->runtime_table;
> >>
> >> +       /*
> >> +        * Safely destroy runtime modifiable EM. By using the call
> >> +        * synchronize_rcu() we make sure we don't progress till last user
> >> +        * finished the RCU section and our update got applied.
> >> +        */
> >>          rcu_assign_pointer(pd->runtime_table, NULL);
> >>          synchronize_rcu();
> >>
> >> +       /*
> >> +        * After the sync no updates will be in-flight, so free the
> >> +        * memory allocated for runtime table (if there was such).
> >> +        */
> >> +       if (runtime_table != pd->default_table) {
> >> +               kfree(runtime_table->state);
> >> +               kfree(runtime_table);
> >> +       }
> >
> > Can't this race with the RCU callback freeing the runtime table?
>
> That's why there is this 'synchronize_rcu()' above and the mutex. The
> updating caller if finished the update, would unlock the mutex and this
> unregister code can go. Here we call the synchronize_rcu() so we assure
> the callback has finished for the update path and than we explicitly
> free the saved 'runtime_table' here. So all data should be freed and
> code serialized in those two paths.

This doesn't quite agree with my understanding of what synchronize_rcu() does.

IIUC, RCU callbacks can run as soon as the grace period has elapsed
and they need not wait for synchronize_rcu() to return.  Conversely,
synchronize_rcu() doesn't wait for all of the RCU callbacks to
complete.

Now, em_destroy_rt_table_rcu() doesn't actually use the mutex, so how
exactly is it protected against racing with this code?
