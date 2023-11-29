Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235C97FE258
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbjK2Vuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK2Vuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:50:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100729A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:50:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A015EC433C8;
        Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701294657;
        bh=e1bNk2Y02IUrvPq3JW/J0kW9YOkEkHQ2aztr89JaGE4=;
        h=From:Subject:Date:To:Cc:From;
        b=W4BAlXK08iPXH0COup9QFgLk6G49L7sRK2PXOO21jAo/qR2LGnWJrnXkK8VDY82PV
         IGoz3DawT/VmzsKrAVoiNQKe9MISc/2hm0kl3HDLbS1UN57/HT08KwuIqFzf4uMkHx
         aZnITikONFuj8yXduittb0f3Agj2gJpYJ8NriikUxNJs6/7pwgUWPiTDGffiDWOneP
         y335tOEMg7FQIU5JlNaSXWePyt5cBg6G8TkpHQs1OL++xMhydITncxPBUbsIPWQGQi
         DYTR3Md2Nr9P8HglHsiqUUXTCL7giFDx3G8qK2SLXiSUOgDQdDpgluvX9RllvHid6h
         zYUGf1GaisjMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 86865C07CB1;
        Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
From:   "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Subject: [PATCH 00/16] fs: use type-safe uid representation for filesystem
 capabilities
Date:   Wed, 29 Nov 2023 15:50:18 -0600
Message-Id: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABqyZ2UC/x2NSwrDMAxErxK0rsEf6kWvUrqQXbkRpE6Q2hAwu
 XtFNwNvmMcMUBImhds0QGhn5bUbhMsEdcb+IsdPY4g+Jn8N0fCNm2taLYUa1s8qLqeSQ0OPKTc
 wtaCSK4K9zib377JYudmcj//X/XGeP3LapMJ7AAAA
To:     Christian Brauner <brauner@kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, audit@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3944; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=e1bNk2Y02IUrvPq3JW/J0kW9YOkEkHQ2aztr89JaGE4=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBlZ7IvK9HzszM2i/QraAFHa/VAD?=
 =?utf-8?q?mqY0TX3S+lGLdmx_3rXykB2JATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZWeyLwAKCRBTA5mu5fQxybUeB/_9SuaWrirztZmjFyIZj0l9JjtT/BlFqVDMNE?=
 =?utf-8?q?Q9u0K8av0oIJB6M4C+/RxW2HovO6Ze3et6gPlXNVVM+_EyGFKVn7W875FYmmGCEKw?=
 =?utf-8?q?dZ5VTyO8dFom9t8Upy/gl3rgVv3iFFG80ZtQ72B70/tsyKRSYzuyxsdDR_ey1cN6W?=
 =?utf-8?q?7S85ZBKF84pbR/CEiAhHNjFRYjh5iPJbyGtjvx32qKGcgDYtKJYP3csznkYGd+lEb?=
 =?utf-8?q?9aF5T1_dzpudoFlnW4B3oA67kMhTd5ptj+WVZwhfHNdslqbEBFad389VfZho7Y38Q?=
 =?utf-8?q?05t8pxDSg+hFsHv9OvKa?= iAd8bRVxTYQ7QQByaZ4+SebYPCa48r
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received: by B4 Relay for sforshee@kernel.org/default with auth_id=103
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts filesystem capabilities from passing around raw
xattr data to using a kernel-internal representation with type safe
uids, similar to the conversion done previously for posix ACLs.
Currently fscaps representations in the kernel have two different
instances of unclear or confused types:

 - fscaps are generally passed around in the raw xattr form, with the
   rootid sometimes containing the user uid value and at other times
   containing the filesystem value.

 - The existing kernel-internal representation of fscaps,
   cpu_vfs_cap_data, uses the kuid_t type, but the value stored is
   actually a vfsuid.

This series eliminates this confusion by converting the xattr data to
the kernel representation near the userspace and filesystem boundaries,
using the kernel representation within the vfs and commoncap code. The
internal representation is renamed to vfs_caps to reflect this broader
use, and the rootid is changed to a vfsuid_t to correctly identify the
type of uid which it contains.

New vfs interfaces are added to allow for getting and setting fscaps
using the kernel representation. This requires the addition of new inode
operations to allow overlayfs to handle fscaps properly; all other
filesystems fall back to a generic implementation. The top-level vfs
xattr interfaces will now reject fscaps xattrs, though the lower-level
interfaces continue to accept them for reading and writing the raw xattr
data.

The existing xattr security hooks can continue to be used for fscaps.
There is some awkwardness here, as EVM requires the on-disk fscaps data
to compare with any existing on-disk value. Security checks need to
happen before calling into filesystem inode operations, when the fscaps
are still in the kernel-internal format, so an extra conversion to the
on-disk format is necessary for EVM's setxattr checks.

The remainder of the changes are preparatory work and addition of
helpers for converting between the xattr and kernel fscaps
representation. 

I have tested this code with xfstests, ltp, libcap2, and libcap-ng with
no regressions found.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
Seth Forshee (DigitalOcean) (16):
      mnt_idmapping: split out core vfs[ug]id_t definitions into vfsid.h
      mnt_idmapping: include cred.h
      capability: rename cpu_vfs_cap_data to vfs_caps
      capability: use vfsuid_t for vfs_caps rootids
      capability: provide helpers for converting between xattrs and vfs_caps
      capability: provide a helper for converting vfs_caps to xattr for userspace
      fs: add inode operations to get/set/remove fscaps
      fs: add vfs_get_fscaps()
      fs: add vfs_set_fscaps()
      fs: add vfs_remove_fscaps()
      ovl: add fscaps handlers
      ovl: use vfs_{get,set}_fscaps() for copy-up
      fs: use vfs interfaces for capabilities xattrs
      commoncap: remove cap_inode_getsecurity()
      commoncap: use vfs fscaps interfaces for killpriv checks
      vfs: return -EOPNOTSUPP for fscaps from vfs_*xattr()

 MAINTAINERS                   |   1 +
 fs/overlayfs/copy_up.c        |  72 +++---
 fs/overlayfs/dir.c            |   3 +
 fs/overlayfs/inode.c          |  84 +++++++
 fs/overlayfs/overlayfs.h      |   6 +
 fs/xattr.c                    | 286 ++++++++++++++++++++++-
 include/linux/capability.h    |  23 +-
 include/linux/fs.h            |  13 ++
 include/linux/mnt_idmapping.h |  67 +-----
 include/linux/security.h      |   5 +-
 include/linux/vfsid.h         |  74 ++++++
 kernel/auditsc.c              |   9 +-
 security/commoncap.c          | 519 ++++++++++++++++++++++--------------------
 13 files changed, 802 insertions(+), 360 deletions(-)
---
base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
change-id: 20230512-idmap-fscap-refactor-63b61fa0a36f

Best regards,
-- 
Seth Forshee (DigitalOcean) <sforshee@kernel.org>

