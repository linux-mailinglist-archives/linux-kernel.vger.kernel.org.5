Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B86773582
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 02:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjHHAqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 20:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHHAqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 20:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F23F1729
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 17:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691455515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sGJFayB7bCVn9/1N40kGbarhDrToVdrzWQTJfbXai58=;
        b=fMNH5UN2dF594MkgE5+1z2oo0uiWgP7tgQdaxaq7kFOKK6hQ2OmzUymrkq1GgeDPUNLhqR
        WzCKduH7nCkgLVbMLJxx1K4t0p7SBDR59C2A55r5H8TUYDqpUax6ipwrct0rBXtfA3D6hA
        yKF7wAhDnz6QCGfO/qvboLnPs+Rzalg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-mo-ZCOFZPLe2m9K3sqQxGA-1; Mon, 07 Aug 2023 20:45:13 -0400
X-MC-Unique: mo-ZCOFZPLe2m9K3sqQxGA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-686c06b9338so3590525b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 17:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691455512; x=1692060312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGJFayB7bCVn9/1N40kGbarhDrToVdrzWQTJfbXai58=;
        b=XHK1d8DxhJScM4KttgxU1X0QBumO15dSh4Ay2rjjiJ9Q0W/G39DEHOLwfcIiS+DtBV
         kRjoCT7fXuIW/Q5MCqg5a+FkUO7KYf36NSCqUjd8fKjIxwtf18AvMc36mweU0ydshuxs
         6fJeODUyCQ/u0TGnojo9nZMgQ6MfwWpHa0avtsCQZoqPBE8KX6QTjfeQSepyUMs1OI/w
         UwaM+rOThr8KRED6KNUmuR4pcZm5YRSXcyzEyZ2UNzJsjvKlc5mAWBKT1oL5bXGTVeTx
         u182u291uZv6eSkgXhr1DF5oy8Z7LUTczPFc70/dr4/So5Bv4rgM9iB1KYtpmteEwHFY
         pWaQ==
X-Gm-Message-State: AOJu0YyHJv9XfFTztJdkXZEvU+hJnBfexkLtUNbW8y0ZSH4rpVV8B4Ju
        XsHF1mJlLiKuaLl1u6d4sAihyON7AAPklaoD9QmGMDmv813JA60pqHl9LCCvlD5A4QH0JMRpW4s
        F5lRhdT0t0Saqc8lTv5ntjU+r
X-Received: by 2002:a05:6a00:2d0d:b0:682:95ab:32f with SMTP id fa13-20020a056a002d0d00b0068295ab032fmr8840870pfb.1.1691455512455;
        Mon, 07 Aug 2023 17:45:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPkg2N/6rv8StSTvx9osL3J8Biz7ajOJBmiOw02E0b1JL6aepB6QDRdOjdXV+aH+upMyu4Nw==
X-Received: by 2002:a05:6a00:2d0d:b0:682:95ab:32f with SMTP id fa13-20020a056a002d0d00b0068295ab032fmr8840855pfb.1.1691455512062;
        Mon, 07 Aug 2023 17:45:12 -0700 (PDT)
Received: from [10.72.112.77] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s18-20020aa78292000000b0064928cb5f03sm6770401pfm.69.2023.08.07.17.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 17:45:11 -0700 (PDT)
Message-ID: <bcda164b-e4b7-1c16-2714-13e3c6514b47@redhat.com>
Date:   Tue, 8 Aug 2023 08:45:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v10 00/12] ceph: support idmapped mounts
Content-Language: en-US
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM.

Reviewed-by: Xiubo Li <xiubli@redhat.com>

I will queue this to the 'testing' branch and then we will run ceph qa 
tests.

Thanks Alex.

- Xiubo

On 8/7/23 21:26, Alexander Mikhalitsyn wrote:
> Dear friends,
>
> This patchset was originally developed by Christian Brauner but I'll continue
> to push it forward. Christian allowed me to do that :)
>
> This feature is already actively used/tested with LXD/LXC project.
>
> Git tree (based on https://github.com/ceph/ceph-client.git testing):
> v10: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v10
> current: https://github.com/mihalicyn/linux/tree/fs.idmapped.ceph
>
> In the version 3 I've changed only two commits:
> - fs: export mnt_idmap_get/mnt_idmap_put
> - ceph: allow idmapped setattr inode op
> and added a new one:
> - ceph: pass idmap to __ceph_setattr
>
> In the version 4 I've reworked the ("ceph: stash idmapping in mdsc request")
> commit. Now we take idmap refcounter just in place where req->r_mnt_idmap
> is filled. It's more safer approach and prevents possible refcounter underflow
> on error paths where __register_request wasn't called but ceph_mdsc_release_request is
> called.
>
> Changelog for version 5:
> - a few commits were squashed into one (as suggested by Xiubo Li)
> - started passing an idmapping everywhere (if possible), so a caller
> UID/GID-s will be mapped almost everywhere (as suggested by Xiubo Li)
>
> Changelog for version 6:
> - rebased on top of testing branch
> - passed an idmapping in a few places (readdir, ceph_netfs_issue_op_inline)
>
> Changelog for version 7:
> - rebased on top of testing branch
> - this thing now requires a new cephfs protocol extension CEPHFS_FEATURE_HAS_OWNER_UIDGID
> https://github.com/ceph/ceph/pull/52575
>
> Changelog for version 8:
> - rebased on top of testing branch
> - added enable_unsafe_idmap module parameter to make idmapped mounts
> work with old MDS server versions
> - properly handled case when old MDS used with new kernel client
>
> Changelog for version 9:
> - added "struct_len" field in struct ceph_mds_request_head as requested by Xiubo Li
>
> Changelog for version 10:
> - fill struct_len field properly (use cpu_to_le32)
> - add extra checks IS_CEPH_MDS_OP_NEWINODE(..) as requested by Xiubo to match
>    userspace client behavior
> - do not set req->r_mnt_idmap for MKSNAP operation
> - atomic_open: set req->r_mnt_idmap only for CEPH_MDS_OP_CREATE as userspace client does
>
> I can confirm that this version passes xfstests and
> tested with old MDS (without CEPHFS_FEATURE_HAS_OWNER_UIDGID)
> and with recent MDS version.
>
> Links to previous versions:
> v1: https://lore.kernel.org/all/20220104140414.155198-1-brauner@kernel.org/
> v2: https://lore.kernel.org/lkml/20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com/
> tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v2
> v3: https://lore.kernel.org/lkml/20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com/#t
> v4: https://lore.kernel.org/lkml/20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com/#t
> tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v4
> v5: https://lore.kernel.org/lkml/20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com/#t
> tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v5
> v6: https://lore.kernel.org/lkml/20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com/
> tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v6
> v7: https://lore.kernel.org/all/20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com/
> tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v7
> v8: https://lore.kernel.org/all/20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com/
> tree: -
> v9: https://lore.kernel.org/all/20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com/
> tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v9
>
> Kind regards,
> Alex
>
> Original description from Christian:
> ========================================================================
> This patch series enables cephfs to support idmapped mounts, i.e. the
> ability to alter ownership information on a per-mount basis.
>
> Container managers such as LXD support sharaing data via cephfs between
> the host and unprivileged containers and between unprivileged containers.
> They may all use different idmappings. Idmapped mounts can be used to
> create mounts with the idmapping used for the container (or a different
> one specific to the use-case).
>
> There are in fact more use-cases such as remapping ownership for
> mountpoints on the host itself to grant or restrict access to different
> users or to make it possible to enforce that programs running as root
> will write with a non-zero {g,u}id to disk.
>
> The patch series is simple overall and few changes are needed to cephfs.
> There is one cephfs specific issue that I would like to discuss and
> solve which I explain in detail in:
>
> [PATCH 02/12] ceph: handle idmapped mounts in create_request_message()
>
> It has to do with how to handle mds serves which have id-based access
> restrictions configured. I would ask you to please take a look at the
> explanation in the aforementioned patch.
>
> The patch series passes the vfs and idmapped mount testsuite as part of
> xfstests. To run it you will need a config like:
>
> [ceph]
> export FSTYP=ceph
> export TEST_DIR=/mnt/test
> export TEST_DEV=10.103.182.10:6789:/
> export TEST_FS_MOUNT_OPTS="-o name=admin,secret=$password
>
> and then simply call
>
> sudo ./check -g idmapped
>
> ========================================================================
>
> Alexander Mikhalitsyn (3):
>    fs: export mnt_idmap_get/mnt_idmap_put
>    ceph: add enable_unsafe_idmap module parameter
>    ceph: pass idmap to __ceph_setattr
>
> Christian Brauner (9):
>    ceph: stash idmapping in mdsc request
>    ceph: handle idmapped mounts in create_request_message()
>    ceph: pass an idmapping to mknod/symlink/mkdir
>    ceph: allow idmapped getattr inode op
>    ceph: allow idmapped permission inode op
>    ceph: allow idmapped setattr inode op
>    ceph/acl: allow idmapped set_acl inode op
>    ceph/file: allow idmapped atomic_open inode op
>    ceph: allow idmapped mounts
>
>   fs/ceph/acl.c                 |  6 +--
>   fs/ceph/crypto.c              |  2 +-
>   fs/ceph/dir.c                 |  4 ++
>   fs/ceph/file.c                | 11 ++++-
>   fs/ceph/inode.c               | 29 +++++++------
>   fs/ceph/mds_client.c          | 78 ++++++++++++++++++++++++++++++++---
>   fs/ceph/mds_client.h          |  8 +++-
>   fs/ceph/super.c               |  7 +++-
>   fs/ceph/super.h               |  3 +-
>   fs/mnt_idmapping.c            |  2 +
>   include/linux/ceph/ceph_fs.h  | 10 ++++-
>   include/linux/mnt_idmapping.h |  3 ++
>   12 files changed, 136 insertions(+), 27 deletions(-)
>

