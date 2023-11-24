Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A631A7F79AB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjKXQrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjKXQre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:47:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03819199A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:47:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7F1C433C8;
        Fri, 24 Nov 2023 16:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700844460;
        bh=BVlDq5Ewu2rdhljejSY79vNe84v5IwBc/GsApe5yU/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qzEdsyqs4qX/8QxQpY1uTGL4HjT8TD9PHyDFKrvVO8V4aMZWkHwQBR3R5xKe60OgY
         4P/zM6kd9pWUB7TaKewQTegxNBwW64+j4X86xFW+QgfblB2uysr0eQLcZhkZXMmxKF
         ZFTSkkV2hCRt1Ss+sFvxK4pyYPi/dK0e83c5jUHJlnksdwN1mD0ZZ1F9zFPi5hTTk2
         ka5MZP1GYaHPzjk1T4E0YsZpsc5J4ZoGa9vlDNWZVXEFiJWLyw0rp7Drsr3vlxwQtA
         wUhqVlnPDpoUxYfhHAqKqFTgnSv5zNhYEX6QvS3upn0WIwdVAWollBPUFNliLQR13/
         zz+3aL1xxPz+Q==
Date:   Fri, 24 Nov 2023 17:47:32 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>
Cc:     Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gyroidos@aisec.fraunhofer.de
Subject: Re: [RESEND RFC PATCH v2 00/14] device_cgroup: guard mknod for
 non-initial user namespace
Message-ID: <20231124-filzen-bohrinsel-7ff9c7f44fe1@brauner>
References: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> - Integrate this as LSM (Christian, Paul)

Huh, my rant made you write an LSM. I'm not sure if that's a good or bad
thing...

So I dislike this less than the initial version that just worked around
SB_I_NODEV and this might be able to go somewhere. _But_ I want to see
the rules written down:

(1) current device access management
    I summarized the current places where that's done very very briefly in
    https://lore.kernel.org/all/20230815-feigling-kopfsache-56c2d31275bd@brauner

    * inode_permission()
      -> devcgroup_inode_permission()

    * vfs_mknod()
      -> devcgroup_inode_mknod()

    * blkdev_get_by_dev() // sget()/sget_fc(), other ways to open block devices and friends
      -> devcgroup_check_permission()

    * drivers/gpu/drm/amd/amdkfd // weird restrictions on showing gpu info afaict
      -> devcgroup_check_permission()

    but that's not enough. What we need is a summary of how device node
    creation and device node opening currently interact.

    Because it is subtle. Currently you cannot even create device nodes
    without capable(CAP_SYS_ADMIN) and you can't open any existing ones
    if you lack capable(CAP_SYS_ADMIN).

    Years ago we tried that insane model where we enabled userspace to
    create device nodes but not open them. IOW, the capability check
    for device node creation was lifted but the SB_I_NODEV limitation
    wasn't lifted. That broke the whole world and had to be reverted.

(2) LSM device access management

    I really want to be able to see how you envision the permission
    checking to work in the new model. Specifically:

    * How do device node creation and device node opening interact.
    * The consequences of allowing to remove the SB_I_NODEV restriction.
    * Permission checking for users without and without a bpf guarded
      profile.

If you write this down we'll add it to documentation as well or to the
commit messages. It won't be lost. It doesn't have to be some really
long thing. I just want to better understand what you think this is
going to do and what the code does.
