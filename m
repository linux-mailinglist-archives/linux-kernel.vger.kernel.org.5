Return-Path: <linux-kernel+bounces-100868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159A1879E64
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C596F284C37
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ABB143C67;
	Tue, 12 Mar 2024 22:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icDlMOK7"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D0143757;
	Tue, 12 Mar 2024 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282046; cv=none; b=C1PecmHYNtIHrodEeaTfSmdAbEgPBbnJq7fH+0MWrH+ha87Tzv2IgH6ap1nGSpq/azSbOCDH6LCGc1aJSvajlqi2cxTglI7JqodMtG2qeb3qTfzkI55H45udPij+bJPUvT/b/yUnAq4cwJDU4CFo4YVNj1clMmGszjskd+0hYZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282046; c=relaxed/simple;
	bh=ci9FofB8WevgZ3qj/HSk9pkQ+o/wcKn/2Knb0EsWTiw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LQHi4eNU641o59EJJcgbSCo+N/09fjEcLBBnQr4iuajgDYjTqkbzLqWv6k2KcBpK+KnE5O2r/Wt/4mQPZBJv7hJCy0f5pDymI+l3lEMMeV7jycjUICoKVdsLQVsLSUvg9kLfJSBuYkw3hoEjDqaiuwqfQZ3KY4y/2w+DPXCtZ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icDlMOK7; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d3f962a9dfso52079281fa.1;
        Tue, 12 Mar 2024 15:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710282042; x=1710886842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KF00ZbyVoclFHER8jc9VSebfVQ78jmBZJFqrDYgxX/s=;
        b=icDlMOK7v6dybo7slM997z4eC0RmoQyzsjJMtG16ALTIynVD4Av+4EM4uT479543FK
         wo+GwPTmhXExq9i7DkC7CeWkiUuReL6Uqp5tlkJ+qY4FtmVKhRVS5oXDHPSGv5RdY65D
         qrlHzdH1iNaDyAxOAym6g11hF4xIv/OF1Gu7Zjx0s1hacdgAFgr3MKGHc5eOU4c3Twel
         5wZUSxMxZGuVt6N7lgmw1xqTDTVmRpJpST2zqW7Tb7vKDn0x3GmhQia3L/FnkBvZrAsZ
         ELs3vxeAYBRy3UCfjXZxERFMW9/ommrWlsq9ewC8A3k+usyemMmt5QAiybiveJcmJSiW
         MdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710282042; x=1710886842;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KF00ZbyVoclFHER8jc9VSebfVQ78jmBZJFqrDYgxX/s=;
        b=H5ZlidHFD/Hj+1kDxq1qvkFQyISaHXtPh/RdRgMnENeqhWD/09QNugY7PaVZdU1QJz
         Fk42ZIDUaL99hdLS9ym0Yuolczzv1oIwENQJgwehOao/c48RMHPkMpxn9rafdUF7WRuf
         qbyexWcs/0uS3w/DhGv4JlnYZ4eNPowBgfaUAaITqkl99bwKccD18qx0lZVuwwQp1Pek
         Ds7lCsrJezeTayK0QQlsasxfE4EqrcEHfGdBh25So76X1NFjynCmf3kOeZbk4bVRAakd
         ltAW2yGf6fW3lZMBNC6RkE4lpiYAOCAw+/PScGUf+Kk7aHP9LqdjCtEc7219grS45Sdq
         E+Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXA4Dw1SttFKrWKzFOIJu+gK2mA90H/QXUWYMsPkBHkUsQZHVnceoub3kF1QMa6RNVnczTTQOq8SPeKgn9h1hhXLk/gSihzuGWan4pt
X-Gm-Message-State: AOJu0YyCH2P0Nyf1L0tyDhOVzH8D9y8K/Giu9WqQmHKHZptNTlf+qy6S
	RQByHDGq2/wIAcdwFsO1XzjazgxciBNaqsdcOuSZSdxcpR0acygKwpB7a2Ep3Ebd0VHtcr3XkSa
	7daYRbFQGSV+E1rcfz0UBREaZsGQHQCEiv0NTWw==
X-Google-Smtp-Source: AGHT+IFmwIGrYGHXNTsIl9Aj72IHu2GBSCUqgnPgZXH+x0swrmAJ0lIIHGdCY+Cwb5UT4kO9O2qyqKSgA2t8TQQVfGE=
X-Received: by 2002:a2e:a316:0:b0:2d2:6227:d30a with SMTP id
 l22-20020a2ea316000000b002d26227d30amr1010810lje.2.1710282042126; Tue, 12 Mar
 2024 15:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Tue, 12 Mar 2024 17:20:30 -0500
Message-ID: <CAH2r5msG_j1vDKpvn=R5Gw9=uhi+JwHQcped4rm84bcmqKZEKw@mail.gmail.com>
Subject: [GIT PULL] smb client fixes part 1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
e8f897f4afef0031fe618a8e94127a0934896aba:

  Linux 6.8 (2024-03-10 13:38:09 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.9-rc-smb3-client-fixes-part1

for you to fetch changes up to 3681fe1b0fee42da3d763fdb0aae62ea032aab86:

  cifs: update internal module version number for cifs.ko (2024-03-10
19:52:42 -0500)

----------------------------------------------------------------
24 cifs.ko changesets
- fix for folios/netfs data corruption (in cifs_extend_writeback)
- improvement to tracing (additional tracepoint added)
- Ten for special files and symlinks (improvements to allow
  selecting use of either WSL or NFS reparse point format on
  creating special files)
- allocation size improvement for cached files
- two minor cleanup patches
- fix to allow changing the password on remount when password
  for the session is expired.
- three lease key related fixes (one for caching hardlinked files,
  one for deletes of deferred close files, and an important fix to better
  reuse lease keys for compound operations, which also can avoid
  lease break timeouts when low on credits)
- fix potential data corruption with write/readdir races
- two compression cleanups and a fix for compression headers

There may be a conflict between this and current mainline, but
Stephen Rothwell has already addressed in linux-next this merge conflict
between the recent VFS series (already in mainline for 6.9-rc) and this series.

Also two important follow on changesets for the lease related patches are still
being tested and are not included.
----------------------------------------------------------------
Bharath SM (1):
      cifs: prevent updating file size from server if we have a read/write lease

Chengming Zhou (1):
      smb: remove SLAB_MEM_SPREAD flag usage

Dan Carpenter (1):
      smb: client: Fix a NULL vs IS_ERR() check in wsl_set_xattrs()

David Howells (1):
      cifs: Fix writeback data corruption

Enzo Matsumiya (3):
      smb: client: negotiate compression algorithms
      smb: common: fix fields sizes in compression_pattern_payload_v1
      smb: common: simplify compression headers

Meetakshi Setiya (3):
      smb: client: reuse file lease key in compound operations
      smb: client: do not defer close open handles to deleted files
      smb: client: retry compound request without reusing lease

Paulo Alcantara (9):
      smb: client: introduce reparse mount option
      smb: client: move most of reparse point handling code to common file
      smb: client: fix potential broken compound request
      smb: client: reduce number of parameters in smb2_compound_op()
      smb: client: add support for WSL reparse points
      smb: client: introduce SMB2_OP_QUERY_WSL_EA
      smb: client: parse uid, gid, mode and dev from WSL reparse points
      smb: client: set correct d_type for reparse DFS/DFSR and mount point
      smb: client: return reparse type in /proc/mounts

Steve French (5):
      cifs: allow changing password during remount
      cifs: minor update to list of reviewers
      smb3: update allocation size more accurately on write completion
      smb3: add dynamic trace point for ioctls
      cifs: update internal module version number for cifs.ko

 MAINTAINERS                |   1 +
 fs/smb/client/Makefile     |   2 +-
 fs/smb/client/cifs_debug.c |  34 +++-
 fs/smb/client/cifsfs.c     |   4 +-
 fs/smb/client/cifsfs.h     |   4 +-
 fs/smb/client/cifsglob.h   |  61 +++++--
 fs/smb/client/cifsproto.h  |  20 ++-
 fs/smb/client/cifssmb.c    |   4 +-
 fs/smb/client/connect.c    |   4 +-
 fs/smb/client/file.c       | 303 +++++++++++++++++--------------
 fs/smb/client/fs_context.c |  64 ++++++-
 fs/smb/client/fs_context.h |  11 +-
 fs/smb/client/inode.c      | 135 +++++---------
 fs/smb/client/ioctl.c      |   5 +
 fs/smb/client/misc.c       |  34 ++++
 fs/smb/client/readdir.c    |  22 +--
 fs/smb/client/reparse.c    | 532
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/smb/client/reparse.h    | 113 ++++++++++++
 fs/smb/client/smb2glob.h   |   3 +-
 fs/smb/client/smb2inode.c  | 487
++++++++++++++++++++++++++++++++++++--------------
 fs/smb/client/smb2ops.c    | 254 +-------------------------
 fs/smb/client/smb2pdu.c    |  37 +++-
 fs/smb/client/smb2pdu.h    |  36 +++-
 fs/smb/client/smb2proto.h  |  15 +-
 fs/smb/client/trace.h      |  34 ++++
 fs/smb/common/smb2pdu.h    |  49 ++---
 fs/smb/common/smbfsctl.h   |   6 -
 27 files changed, 1566 insertions(+), 708 deletions(-)
 create mode 100644 fs/smb/client/reparse.c
 create mode 100644 fs/smb/client/reparse.h


-- 
Thanks,

Steve

