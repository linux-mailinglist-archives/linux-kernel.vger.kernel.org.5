Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E636081154F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441936AbjLMOzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbjLMOzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:55:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45421E3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702479327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uIFKxiFZihO9GqXmA3HovwJ/rQqe1hgcv8SZULAHlOU=;
        b=HhKl73A5Uc8VYtrwyua6mHg9EOXidNoGF44IFNufyY/nmVHg2LMvkyNntrfTmea81U3y5x
        FznFPubknwmyQAexIy0LujBI86dIKe8mzsJpjBpger7IJYlgfeJYhEzndSK9O0In2m8sLH
        2K6yqB0bHppQAyv2uFameO3ZzTidxkc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-W-CseXvdNuKjn7QXZhMLxg-1; Wed, 13 Dec 2023 09:55:25 -0500
X-MC-Unique: W-CseXvdNuKjn7QXZhMLxg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ca31b054e4so54313561fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479324; x=1703084124;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uIFKxiFZihO9GqXmA3HovwJ/rQqe1hgcv8SZULAHlOU=;
        b=o8ORAGt+Xj218THe/2DVSluy19BXKYhbcnCKue+8LetNs+EKVF8EE02yW/yZkZ7/2e
         m7uef4LErdj7X9TtH5wfJYIKug/zIcCybH/YmQgGq32ZCK0y8Jrt0KuvYll0ALseodIn
         CUWM1JviM0iPtGHqnXr82baPjlZl7yY7Wh4EEZ8TWhRGqlx4XCHGMc1/qRIycmcCRzhf
         FreUbQvlewPT6b2L2kVKWZsOWGANDTJOvKZXmEZ2axb7yMqofNN32H3HKH0MKa3QfayK
         q7FLweq9YxiwIv8Krq0PkSyi1K+7Mf24isErDPVt8AE3VrGnC3kG/WjqcmY03jPra1Pg
         +LUA==
X-Gm-Message-State: AOJu0YwfH3i6+F2vyiXba+IJyMvG/RZpIwbuR7sBD778aSZosovH0OCQ
        fCyfKOlzdWoPhl2LI7cwimdDjQtKAfgibNjaBiaIy57Zxo1eg8nlLY+FM0ZeAQonnzeLkKh4ByM
        KEG6J1nxqEqPgAh+jBV1n1dF4
X-Received: by 2002:a2e:828f:0:b0:2c9:e9eb:8ccb with SMTP id y15-20020a2e828f000000b002c9e9eb8ccbmr3769063ljg.69.1702479324253;
        Wed, 13 Dec 2023 06:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHviyKH7wfcVf+I7xtZv4/UFi1AvA8vImQUb3UJSgTbMIYjDNrX0hdJf2t7gC7r7QeAbgewkg==
X-Received: by 2002:a2e:828f:0:b0:2c9:e9eb:8ccb with SMTP id y15-20020a2e828f000000b002c9e9eb8ccbmr3769060ljg.69.1702479323843;
        Wed, 13 Dec 2023 06:55:23 -0800 (PST)
Received: from redhat.com ([2a02:14f:16d:d414:dc39:9ae8:919b:572d])
        by smtp.gmail.com with ESMTPSA id ck9-20020a0564021c0900b0054f4097fea2sm5763020edb.0.2023.12.13.06.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:55:23 -0800 (PST)
Date:   Wed, 13 Dec 2023 09:55:18 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tobias Huschle <huschle@linux.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20231213094854-mutt-send-email-mst@kernel.org>
References: <20231208052150-mutt-send-email-mst@kernel.org>
 <53044.123120806415900549@us-mta-342.us.mimecast.lan>
 <20231209053443-mutt-send-email-mst@kernel.org>
 <CACGkMEuSGT-e-i-8U7hum-N_xEnsEKL+_07Mipf6gMLFFhj2Aw@mail.gmail.com>
 <20231211115329-mutt-send-email-mst@kernel.org>
 <CACGkMEudZnF7hUajgt0wtNPCxH8j6A3L1DgJj2ayJWhv9Bh1WA@mail.gmail.com>
 <20231212111433-mutt-send-email-mst@kernel.org>
 <42870.123121305373200110@us-mta-641.us.mimecast.lan>
 <20231213061719-mutt-send-email-mst@kernel.org>
 <25485.123121307454100283@us-mta-18.us.mimecast.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25485.123121307454100283@us-mta-18.us.mimecast.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 01:45:35PM +0100, Tobias Huschle wrote:
> On Wed, Dec 13, 2023 at 07:00:53AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Dec 13, 2023 at 11:37:23AM +0100, Tobias Huschle wrote:
> > > On Tue, Dec 12, 2023 at 11:15:01AM -0500, Michael S. Tsirkin wrote:
> > > > On Tue, Dec 12, 2023 at 11:00:12AM +0800, Jason Wang wrote:
> > > > > On Tue, Dec 12, 2023 at 12:54 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> [...]
> > 
> > Apparently schedule is already called?
> > 
> 
> What about this: 
> 
> static int vhost_task_fn(void *data)
> {
> 	<...>
> 	did_work = vtsk->fn(vtsk->data);  --> this calls vhost_worker if I'm not mistaken
> 	if (!did_work)
> 		schedule();
> 	<...>
> }
> 
> static bool vhost_worker(void *data)
> {
> 	struct vhost_worker *worker = data;
> 	struct vhost_work *work, *work_next;
> 	struct llist_node *node;
> 
> 	node = llist_del_all(&worker->work_list);
> 	if (node) {
> 		<...>
> 		llist_for_each_entry_safe(work, work_next, node, node) {
> 			<...>
> 		}
> 	}
> 
> 	return !!node;
> }
> 
> The llist_for_each_entry_safe does not actually change the node value, doesn't it?
> 
> If it does not change it, !!node would return 1.
> Thereby skipping the schedule.
> 
> This was changed recently with:
> f9010dbdce91 fork, vhost: Use CLONE_THREAD to fix freezer/ps regression
> 
> It returned a hardcoded 0 before. The commit message explicitly mentions this
> change to make vhost_worker return 1 if it did something.
> 
> Seems indeed like a nasty little side effect caused by EEVDF not scheduling
> the woken up kworker right away.


So we are actually making an effort to be nice.
Documentation/kernel-hacking/hacking.rst says:

If you're doing longer computations: first think userspace. If you
**really** want to do it in kernel you should regularly check if you need
to give up the CPU (remember there is cooperative multitasking per CPU).
Idiom::

    cond_resched(); /* Will sleep */


and this is what vhost.c does.

At this point I'm not sure why it's appropriate to call schedule() as opposed to
cond_resched(). Ideas?


-- 
MST

