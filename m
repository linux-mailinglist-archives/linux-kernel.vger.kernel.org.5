Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E311811530
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441823AbjLMOrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbjLMOrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:47:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B478EE3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702478874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0jKzahdW3Z8DiMF4k91DJLvHn4lH9K58mF9LO/614r8=;
        b=TP8muHC81kX6Q2ehx9md1hzw2b5sZ8zDdc5XfupTYJJg0PS7d4Hnns9x329JgF9xmpmz/+
        EEoxIor4Y6s2YTEVVSBHkj2qF4gPuBsgqCiI4H4w5TyWEBhUwdYj7X/9QW4R0wZc4Myis2
        LF2607Mei0RMMIntZQxuY1EZCO/OhJk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-PC0YtiZqOICT2l4jKqIr3g-1; Wed, 13 Dec 2023 09:47:53 -0500
X-MC-Unique: PC0YtiZqOICT2l4jKqIr3g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1da829c653so424550666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:47:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702478872; x=1703083672;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jKzahdW3Z8DiMF4k91DJLvHn4lH9K58mF9LO/614r8=;
        b=mgI7c/+sUQdvX1GcwXOdo4n3teCk7zxJ7CPGjN3bYPjyHD/0Y2O9cyAdlZZ6laIBI4
         RV0d1ZQ2gDInjfDkdybagnskIduWFUON+KNSRaxb1glIcYcBTvWxa707unW0Si9FVnio
         ngEZZSf4EzyPcAmRm13B6d6WzBz3OrxJOFr5MXSz8Pkmp6bYe/jIQCBsEHsyppHLWiTn
         Tv9+OcibOrZiBFKp1A9Bg063dIU27vaxXdhlr68Rfu+Yd7HnvhLWEgz3u7T49Tf9WPzE
         M248UT0yWFoQyt5eygqpfXPxn3CIVvjyyfMSm17B3e/0y/14d6SKJ4WRnf7NjdHX1T4v
         /Cdw==
X-Gm-Message-State: AOJu0YxMejb4QhbPV9MG0OQsnBIeUC8f/eiWB4P2S5vu3D86RJhGvE6c
        hSYaGVy0QZFIkV49Nvog9L5pZOXmgrjrN2YIlg8c4PdFdidQlCTNTdE8mz0fT14oOhfVRHNSoOI
        L1MoUKb+U9XfbWqPVHcO5BK8K
X-Received: by 2002:a17:907:72cb:b0:a1d:9d7b:f2cf with SMTP id du11-20020a17090772cb00b00a1d9d7bf2cfmr2746753ejc.15.1702478872416;
        Wed, 13 Dec 2023 06:47:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH225M+fWShUJGXunG1g7mFoAwsjGf+FIVoxeFbFwopVnE+cUOXBfhM3binQy7H2O/ZZGcAw==
X-Received: by 2002:a17:907:72cb:b0:a1d:9d7b:f2cf with SMTP id du11-20020a17090772cb00b00a1d9d7bf2cfmr2746745ejc.15.1702478872109;
        Wed, 13 Dec 2023 06:47:52 -0800 (PST)
Received: from redhat.com ([2a02:14f:16d:d414:dc39:9ae8:919b:572d])
        by smtp.gmail.com with ESMTPSA id tb19-20020a1709078b9300b00a1cd30d06d1sm8049662ejc.14.2023.12.13.06.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:47:51 -0800 (PST)
Date:   Wed, 13 Dec 2023 09:47:47 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tobias Huschle <huschle@linux.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, Mike Christie <michael.christie@oracle.com>
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20231213093627-mutt-send-email-mst@kernel.org>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Indeed, but previously vhost_worker was looping itself.
And it did:
-               node = llist_del_all(&worker->work_list);
-               if (!node)
-                       schedule();

so I don't think this was changed at all.






-- 
MST

