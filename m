Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F099D75923C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGSKBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjGSKAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:00:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF91C1FD5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689760787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNrKXYsgEjY0/J/1wkQSOKUKgfUi70H3dQ+kbUIwfvE=;
        b=eaMW8kMwiJXNIpRB7CVEKfS5++sarXBfrElWDA8N6emU9ZsDD8dptHTO2mImtmECjprjl5
        WOqpNDLe94MTvN3dfJEizb8wZuPyreHXndc2cFZxgeVfwO5EzI8oYBKZgQQ1VoiXjpVFY6
        ZSe1k3s2XZElJGTtJHKkbldW0vK7CCA=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-Cfl5uCx7PuS3LaCig1el5g-1; Wed, 19 Jul 2023 05:59:46 -0400
X-MC-Unique: Cfl5uCx7PuS3LaCig1el5g-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-440bf45dc93so958491137.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689760784; x=1690365584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNrKXYsgEjY0/J/1wkQSOKUKgfUi70H3dQ+kbUIwfvE=;
        b=JCWLmY2eLczKt7sc9H9i1gxD2oLzWIGQ800Sw7XCb/SHS1va9g8XGn7CMGR+feP6Py
         eHyQc44M94AG/smpAlbojwAi7L5UWngoITs4nBuxoxjQ9332pq2IeuIsSKG++IKlAcqD
         ndFFme0YrBdVc9E6vVidiVnic+hMg1vx4WTZJl55MPh9XTpVeIpg9BvMUQWTbnmNXWyJ
         Z0xoX2ssu6XldKsnJOg/Z/JAvhGs3RWgnED0zF5F6n+rfM+njjg13hzb6xa7EcF8x4gP
         4OZwU4eXs/8tMjGRDoXSCH0gJZw0KcBOpJcwY92Zv5bngoGLZeigMr61OfiaCLg8J7k7
         D1ug==
X-Gm-Message-State: ABy/qLbFShi/zg9INI+kfBXVw+X4bQ8RIaBa/WRyv/cJOtXL64ks+VTG
        Yo1hbqb/sSAyBmDp/4IWHdG2fBopfTBupMLGuDj5RsRoWeCA3pYIxWzIsQlaaAx4jDUeiPNp/5u
        M1OnyYYF6CLZAH7jWRHJ51FRUYPYYqvMLiT/8BpOaygr8/wsV
X-Received: by 2002:a05:6102:3641:b0:443:92a5:f454 with SMTP id s1-20020a056102364100b0044392a5f454mr1173898vsu.26.1689760784173;
        Wed, 19 Jul 2023 02:59:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFwKOu8b4zcqwPRcj2+RXhb5RTGbj+yORZfXXm71333srBj3Ys0/jezl+KtyZ7G+yi4xKL5gMQ73qTHxC5zK3E=
X-Received: by 2002:a05:6102:3641:b0:443:92a5:f454 with SMTP id
 s1-20020a056102364100b0044392a5f454mr1173880vsu.26.1689760783923; Wed, 19 Jul
 2023 02:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <d477d789-3e73-9d00-1daf-ff0ed6f18e6c@easystack.cn>
In-Reply-To: <d477d789-3e73-9d00-1daf-ff0ed6f18e6c@easystack.cn>
From:   Maurizio Lombardi <mlombard@redhat.com>
Date:   Wed, 19 Jul 2023 11:59:32 +0200
Message-ID: <CAFL455ni63jgLha_AypB6hW=w2YQjWzbi9CJo9oK8yG1VM-=6A@mail.gmail.com>
Subject: Re: Close connection aborting an out-of-order cmd will hang
To:     Jirong Feng <jirong.feng@easystack.cn>
Cc:     nab@linux-iscsi.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello,

=C3=BAt 18. 7. 2023 v 8:52 odes=C3=ADlatel Jirong Feng <jirong.feng@easysta=
ck.cn> napsal:
>
> Hi,
>
> I recently encountered a hanging issue as follow:

Can you please provide the kernel version?

Thanks,
Maurizio

> [root@node-6 ~]# ps -aux | grep ' D '
> root      8648  0.4  0.0      0     0 ?        D    Jul12  21:04 [iscsi_n=
p]
> root     17572  0.0  0.0      0     0 ?        D    Jul12   0:09
> [kworker/7:3+events]
> root     56555  0.0  0.0 216576  1536 pts/1    S+   14:57   0:00 grep
> --color=3Dauto  D
> root     59853  0.0  0.0      0     0 ?        D    Jul12   0:04 [iscsi_t=
rx]
>
> the call stack:
> kworker:
> PID: 17572  TASK: ffff862470df0e00  CPU: 7   COMMAND: "kworker/7:3"
>   #0 [ffff0000528afab0] __switch_to at ffff4a49c69e74b8
>   #1 [ffff0000528afad0] __schedule at ffff4a49c72b60f4
>   #2 [ffff0000528afb60] schedule at ffff4a49c72b6754
>   #3 [ffff0000528afb70] schedule_timeout at ffff4a49c72ba980
>   #4 [ffff0000528afc30] wait_for_common at ffff4a49c72b7504
>   #5 [ffff0000528afcb0] wait_for_completion at ffff4a49c72b7594
>   #6 [ffff0000528afcd0] target_put_cmd_and_wait at ffff4a49a3dad38c
> [target_core_mod]
>   #7 [ffff0000528afd30] core_tmr_abort_task at ffff4a49a3da55c8
> [target_core_mod]
>   #8 [ffff0000528afd80] target_tmr_work at ffff4a49a3daa1c8
> [target_core_mod]
>   #9 [ffff0000528afdb0] process_one_work at ffff4a49c6a603c0
> #10 [ffff0000528afe00] worker_thread at ffff4a49c6a60640
> #11 [ffff0000528afe60] kthread at ffff4a49c6a67474
>
> iscsi_trx:
> PID: 59853  TASK: ffff8624fe0b5200  CPU: 7   COMMAND: "iscsi_trx"
>   #0 [ffff000095f6fa50] __switch_to at ffff4a49c69e74b8
>   #1 [ffff000095f6fa70] __schedule at ffff4a49c72b60f4
>   #2 [ffff000095f6fb00] schedule at ffff4a49c72b6754
>   #3 [ffff000095f6fb10] schedule_timeout at ffff4a49c72ba870
>   #4 [ffff000095f6fbd0] wait_for_common at ffff4a49c72b7504
>   #5 [ffff000095f6fc50] wait_for_completion_timeout at ffff4a49c72b75d0
>   #6 [ffff000095f6fc70] __transport_wait_for_tasks at ffff4a49a3da9c28
> [target_core_mod]
>   #7 [ffff000095f6fcb0] transport_generic_free_cmd at ffff4a49a3da9dd0
> [target_core_mod]
>   #8 [ffff000095f6fd20] iscsit_free_cmd at ffff4a49a3fc4464
> [iscsi_target_mod]
>   #9 [ffff000095f6fd50] iscsit_close_connection at ffff4a49a3fccf48
> [iscsi_target_mod]
> #10 [ffff000095f6fdf0] iscsit_take_action_for_connection_exit at
> ffff4a49a3fb7614 [iscsi_target_mod]
> #11 [ffff000095f6fe20] iscsi_target_rx_thread at ffff4a49a3fcc064
> [iscsi_target_mod]
> #12 [ffff000095f6fe60] kthread at ffff4a49c6a67474
>
> inspect the aborting cmd in kworker:
> crash> struct iscsi_cmd FFFFA62592F4B400
> struct iscsi_cmd {
>    dataout_timer_flags =3D (unknown: 0),
>    dataout_timeout_retries =3D 0 '\000',
>    error_recovery_count =3D 0 '\000',
>    deferred_i_state =3D ISTATE_NEW_CMD,
>    i_state =3D ISTATE_DEFERRED_CMD,
>    immediate_cmd =3D 0 '\000',
>    immediate_data =3D 0 '\000',
>    iscsi_opcode =3D 1 '\001',
>    iscsi_response =3D 0 '\000',
>    logout_reason =3D 0 '\000',
>    logout_response =3D 0 '\000',
>    maxcmdsn_inc =3D 0 '\000',
>    unsolicited_data =3D 0 '\000',
>    reject_reason =3D 0 '\000',
>    logout_cid =3D 0,
>    cmd_flags =3D ICF_OOO_CMDSN,
>    init_task_tag =3D 2415919152,
>    targ_xfer_tag =3D 205,
>    cmd_sn =3D 2860352639,
>    exp_stat_sn =3D 2502541166,
>    stat_sn =3D 0,
>    data_sn =3D 0,
> ...
>
> so this is an out-of-order cmd. In my conclusion, trx is waiting for
> kworker to abort the cmd,  while kworker is waiting for someone to
> complete the cmd, and that is never going to happen, hence the hanging.
>
> Could someone please help me to confirm the case?
>
> Regards,
> Jirong Feng
>
>

