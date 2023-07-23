Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4040075E0EF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGWJcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGWJci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA68E60
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 02:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690104710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KnP1FvRt/WmVmVKNFuWV7tALXDgfHjSQsYEKOT5cUds=;
        b=EIzGy9GZQN5LQrZqOrV199AjvLyBgZCXMaRKHytiUtYyM5/X1Fyf3X73EJZeTwEo2ceQ37
        DoTvtMBvlISutN6GW2OGfnQbp/M2O9z5su/JxWfYoxUgBRoVHpDQuu2Y7bLjFo+qHK8Qzg
        ox6E79F9ILD7NvkegGD9LWbLhTNQf9A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-esA73rIGM5SkNo0mJAGcIQ-1; Sun, 23 Jul 2023 05:31:48 -0400
X-MC-Unique: esA73rIGM5SkNo0mJAGcIQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbb0c01e71so17029015e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 02:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690104708; x=1690709508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnP1FvRt/WmVmVKNFuWV7tALXDgfHjSQsYEKOT5cUds=;
        b=PZhz0slwHkVrxCBdFsoC0g5la50mN3X5Ja2C0hs4XUMvBcDU/6iLBP+R03T+lY9MMi
         uj0OCPAa0GRs/2nRbD6N6ij66+T8XMTRA1A5EyhhbfVzMZrpLC/EbmHwNK+wU7kIGM0P
         5RixhM/F57tTEU459FQLvMOxnqkFfqVTxYwtR11KM3fcDhbowGyVBCbT4oM6+u8nUkvc
         zNDSF6TgEDxK1Hes3SZ2htVe9r8G+3TjgHQ3ieXs6rK6HzwTXgoB5vomz43ObuPr3hp8
         hmGNcLexDuQo8Hbm5QKr54src9ISeRQx9/f7skofyc5emc4NiXyb4Lcm/2UxvImHer68
         XrLA==
X-Gm-Message-State: ABy/qLY5SfgDOZxggBSQ/womNAh945M2XWNlmMQj8UUazT3cqvwIoiK/
        ZXoxpytuu0Pp0xEzytthaDH7maSsOCvPT71QjcuFTccO9zFGmjZ2vzIHtWx1XrfPvWI2yP3ZKvn
        7onAyKjVjYupJuyvKckIJn2XF
X-Received: by 2002:adf:f283:0:b0:317:58fd:29c6 with SMTP id k3-20020adff283000000b0031758fd29c6mr475316wro.70.1690104707785;
        Sun, 23 Jul 2023 02:31:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFpURugFCWXHXOHG4DBWpzYEXSkSGvybDLH/yHQ+5/PVNnyQleFYSKOIOZg4Y7I/rnPhxJO7Q==
X-Received: by 2002:adf:f283:0:b0:317:58fd:29c6 with SMTP id k3-20020adff283000000b0031758fd29c6mr475304wro.70.1690104707428;
        Sun, 23 Jul 2023 02:31:47 -0700 (PDT)
Received: from redhat.com ([2.55.164.187])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d65d2000000b00314172ba213sm9117790wrw.108.2023.07.23.02.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 02:31:46 -0700 (PDT)
Date:   Sun, 23 Jul 2023 05:31:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     michael.christie@oracle.com
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        brauner@kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Message-ID: <20230723052921-mutt-send-email-mst@kernel.org>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <20230720090415-mutt-send-email-mst@kernel.org>
 <dcd74064-7617-c895-4f78-cb46ef1d582b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcd74064-7617-c895-4f78-cb46ef1d582b@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 11:03:29PM -0500, michael.christie@oracle.com wrote:
> On 7/20/23 8:06 AM, Michael S. Tsirkin wrote:
> > On Thu, Feb 02, 2023 at 05:25:17PM -0600, Mike Christie wrote:
> >> For vhost workers we use the kthread API which inherit's its values from
> >> and checks against the kthreadd thread. This results in the wrong RLIMITs
> >> being checked, so while tools like libvirt try to control the number of
> >> threads based on the nproc rlimit setting we can end up creating more
> >> threads than the user wanted.
> >>
> >> This patch has us use the vhost_task helpers which will inherit its
> >> values/checks from the thread that owns the device similar to if we did
> >> a clone in userspace. The vhost threads will now be counted in the nproc
> >> rlimits. And we get features like cgroups and mm sharing automatically,
> >> so we can remove those calls.
> >>
> >> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> >> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > 
> > Hi Mike,
> > So this seems to have caused a measureable regression in networking
> > performance (about 30%). Take a look here, and there's a zip file
> > with detailed measuraments attached:
> > 
> > https://bugzilla.redhat.com/show_bug.cgi?id=2222603
> > 
> > 
> > Could you take a look please?
> > You can also ask reporter questions there assuming you
> > have or can create a (free) account.
> > 
> 
> Sorry for the late reply. I just got home from vacation.
> 
> The account creation link seems to be down. I keep getting a
> "unable to establish SMTP connection to bz-exim-prod port 25 " error.
> 
> Can you give me Quan's email?

Thanks for getting back!  I asked whether it's ok to share the email.
For now pasted your request in the bugzilla.

> I think I can replicate the problem. I just need some extra info from Quan:
> 
> 1. Just double check that they are using RHEL 9 on the host running the VMs.
> 2. The kernel config
> 3. Any tuning that was done. Is tuned running in guest and/or host running the
> VMs and what profile is being used in each.
> 4. Number of vCPUs and virtqueues being used.
> 5. Can they dump the contents of:
> 
> /sys/kernel/debug/sched
> 
> and
> 
> sysctl  -a
> 
> on the host running the VMs.
> 
> 6. With the 6.4 kernel, can they also run a quick test and tell me if they set
> the scheduler to batch:
> 
> ps -T -o comm,pid,tid $QEMU_THREAD
> 
> then for each vhost thread do:
> 
> chrt -b -p 0 $VHOST_THREAD
> 
> Does that end up increasing perf? When I do this I see throughput go up by
> around 50% vs 6.3 when sessions was 16 or more (16 was the number of vCPUs
> and virtqueues per net device in the VM). Note that I'm not saying that is a fix.
> It's just a difference I noticed when running some other tests.

