Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BD4792BC9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbjIERAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353875AbjIEI1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3C6CC7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693902391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wr7DwURnCr/necd9JNHVzn6++72JC9JfYbJ7saAJJBg=;
        b=H4oh7587IXQSnF5KRXqDxr1sEETXRJAq5p9KwrUFvjPF4wBE6t9a9Ppxf3iWH30u3OTtPl
        h+u6rgMf8gTUcOSiGCPH+r5C7L7T/TKXNDXLbCNugMkN+d8LRQGOAJ4DP6dIK/BeMKM35f
        dgfBb1lx9khY15Pcq55MYRU9VqPfzsw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-7UXTA6PZM1G_oGLX9DRuhw-1; Tue, 05 Sep 2023 04:26:28 -0400
X-MC-Unique: 7UXTA6PZM1G_oGLX9DRuhw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9a62b121c43so46322866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 01:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693902387; x=1694507187;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wr7DwURnCr/necd9JNHVzn6++72JC9JfYbJ7saAJJBg=;
        b=GtNH+oeohr11AFY0KeZeaTMtS87gVwBVjRmqJucNi3yT/LsXbFQ6KRDGrSkhugT8a9
         yE3Tw94Z4EAhebUG5XLGCQMTghtCbi0FeqUpylMRe/+RyuGDiMtb5g0nxIycvzyBJJxI
         uuYgXykdPGQlco1kCVigvyxFq8DllS3uYHFAMvI43oYLPolHR+ZtDfdTjo43rfEi2V4K
         B842fkwug5ygeiE5PxfKUCLh28hKN1Lc4aIdTqb7fr3iiRiRAWD0iPUuouau1LapibPF
         NXk5qZj3EceqwqdI48EB+qFwqf9181yH3xelQSiYnuhVdc2oeKXwPZXLeq9guwn2G4fM
         ALyQ==
X-Gm-Message-State: AOJu0YxIdHKBF6PKPBxcmZGd6/Rg2jD6VsFQI5qpXmOmHeq1OshMPrNc
        gbsrjQOpRBc7Dco+n8ibgGjLM7mjLdjS28hWnOqZ1K/NO6CFBz0ukfx3ecCVru97zmEMuEGrk1c
        QRUgCgNACewxf7DQ1bwKbd7DX
X-Received: by 2002:a17:906:109b:b0:9a1:c4ce:65b8 with SMTP id u27-20020a170906109b00b009a1c4ce65b8mr8489406eju.4.1693902387153;
        Tue, 05 Sep 2023 01:26:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG+whJWY7ZKsZzIZ+azxlEM5vF1xXpWf5XsikJWrsPYr05TGyW5mgNt+gzuGt+4iSo+solTA==
X-Received: by 2002:a17:906:109b:b0:9a1:c4ce:65b8 with SMTP id u27-20020a170906109b00b009a1c4ce65b8mr8489388eju.4.1693902386790;
        Tue, 05 Sep 2023 01:26:26 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-254-194.dyn.eolo.it. [146.241.254.194])
        by smtp.gmail.com with ESMTPSA id cf20-20020a170906b2d400b00988dbbd1f7esm7210115ejb.213.2023.09.05.01.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 01:26:26 -0700 (PDT)
Message-ID: <7125d734bdf73708aae9f431fb5d18b1699499a5.camel@redhat.com>
Subject: Re: [PATCH net v3] team: fix null-ptr-deref when team device type
 is changed
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ziyang Xuan <william.xuanziyang@huawei.com>, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, liuhangbin@gmail.com
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 05 Sep 2023 10:26:25 +0200
In-Reply-To: <20230905081056.3365013-1-william.xuanziyang@huawei.com>
References: <20230905081056.3365013-1-william.xuanziyang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-05 at 16:10 +0800, Ziyang Xuan wrote:
> Get a null-ptr-deref bug as follows with reproducer [1].
>=20
> BUG: kernel NULL pointer dereference, address: 0000000000000228
> ...
> RIP: 0010:vlan_dev_hard_header+0x35/0x140 [8021q]
> ...
> Call Trace:
>  <TASK>
>  ? __die+0x24/0x70
>  ? page_fault_oops+0x82/0x150
>  ? exc_page_fault+0x69/0x150
>  ? asm_exc_page_fault+0x26/0x30
>  ? vlan_dev_hard_header+0x35/0x140 [8021q]
>  ? vlan_dev_hard_header+0x8e/0x140 [8021q]
>  neigh_connected_output+0xb2/0x100
>  ip6_finish_output2+0x1cb/0x520
>  ? nf_hook_slow+0x43/0xc0
>  ? ip6_mtu+0x46/0x80
>  ip6_finish_output+0x2a/0xb0
>  mld_sendpack+0x18f/0x250
>  mld_ifc_work+0x39/0x160
>  process_one_work+0x1e6/0x3f0
>  worker_thread+0x4d/0x2f0
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xe5/0x120
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x34/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
>=20
> [1]
> $ teamd -t team0 -d -c '{"runner": {"name": "loadbalance"}}'
> $ ip link add name t-dummy type dummy
> $ ip link add link t-dummy name t-dummy.100 type vlan id 100
> $ ip link add name t-nlmon type nlmon
> $ ip link set t-nlmon master team0
> $ ip link set t-nlmon nomaster
> $ ip link set t-dummy up
> $ ip link set team0 up
> $ ip link set t-dummy.100 down
> $ ip link set t-dummy.100 master team0
>=20
> When enslave a vlan device to team device and team device type is changed
> from non-ether to ether, header_ops of team device is changed to
> vlan_header_ops. That is incorrect and will trigger null-ptr-deref
> for vlan->real_dev in vlan_dev_hard_header() because team device is not
> a vlan device.
>=20
> Assign eth_header_ops to header_ops of team device when its type is chang=
ed
> from non-ether to ether to fix the bug.
>=20
> Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
> Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>

I'm sorry to note that this submission does not fit our process:

https://elixir.bootlin.com/linux/latest/source/Documentation/process/mainta=
iner-netdev.rst#L353

this specific kind of process violations tend to make reviewers quite
unhappy, please be more careful.

Regards,

Paolo

