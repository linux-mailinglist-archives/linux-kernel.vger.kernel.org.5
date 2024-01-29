Return-Path: <linux-kernel+bounces-43411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D253C84137D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104421C25926
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D34B7603C;
	Mon, 29 Jan 2024 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzxviD/U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DDC60EFF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556558; cv=none; b=tvb2iIVjFU1bIgaG4V+FDnKw3Lu4UoN/7EjS9FiAn1EGYSS5Ma1j6hZ1UP1nK1cRUwvv6GuaDcMiDd8lmIqRgWZ4rv8BVuImL8QU8PitZXnIm1SEqlq0tey0FpwlurIo737743Hn67jjwXFi2OrnuxQU/GKUWfoyfvTQX7UM8Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556558; c=relaxed/simple;
	bh=ZESgME+ALPbx9lJo++BhthHpPseuVzsqW4G7/pIDDu8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Kn4CoNleTOpE9pbCS/pgRVzrekNEV/jQXtH3ZggaPU9PCmHrDlhJIz81llHp1mtGIvpzy9ETPExg3CThqi6g0JdkXbsa0rYD1oAL6FGBNFv4F9JpiM7u2Ucqhh8LS1zVaTDSh8ZJGuVXPc5Ai2vzhuXTI8wRxGAXT9ni3d/cXmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dzxviD/U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706556555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cfAt1hi0Z3grmQvgCjXAH8jNPiFb7a7TOp8BzFVC+CU=;
	b=dzxviD/UlfDTsyN7eo45uvi5kar49ra7IAQzXFqVPl6TnWw42vtmm0Z2RoaWK3A5TzepWM
	zRHXQkSAeZaPZElTrwKnhAKTgO73Iu4z6dirghDkZQtMSsrc5AX2oKxLYeTuzusO15t8PK
	YWkM3T3GiGtC7IsR/fByaHLG6T9pKF8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-xTtw-wHBNZe64_K3hDLlAQ-1; Mon, 29 Jan 2024 14:29:11 -0500
X-MC-Unique: xTtw-wHBNZe64_K3hDLlAQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6D5685A58E;
	Mon, 29 Jan 2024 19:29:10 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7648EC2590E;
	Mon, 29 Jan 2024 19:29:10 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 5F15330C14EB; Mon, 29 Jan 2024 19:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 54E793FB4E;
	Mon, 29 Jan 2024 20:29:10 +0100 (CET)
Date: Mon, 29 Jan 2024 20:29:10 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Hongyu Jin <hongyu.jin.cn@gmail.com>
cc: agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk, ebiggers@kernel.org, 
    zhiguo.niu@unisoc.com, ke.wang@unisoc.com, yibin.ding@unisoc.com, 
    hongyu.jin@unisoc.com, linux-kernel@vger.kernel.org, 
    dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: [PATCH v8 0/5] Fix I/O priority lost in device-mapper
In-Reply-To: <20240124053556.126468-1-hongyu.jin.cn@gmail.com>
Message-ID: <8b31bbef-35f7-6efd-d1ba-381cc1952e5d@redhat.com>
References: <20231221103139.15699-6-hongyu.jin.cn@gmail.com> <20240124053556.126468-1-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

The patchset seems OK to me.

Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>


On Wed, 24 Jan 2024, Hongyu Jin wrote:

> From: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> High-priority tasks get data from dm-verity devices via RT IO priority,
> I/O will lose RT priority when reading FEC and hash values via kworker
> submission IO during verification, and the verification phase may be
> blocked by low-priority IO.
> 
> Dm-crypt has the same problem in the data writing process.
> 
> This is because io_context and blkcg are missing.
> 
> Move bio_set_ioprio() into submit_bio():
> 1. Only call bio_set_ioprio() once to set the priority of original bio,
>    the bio that cloned and splited from original bio will auto inherit
>    the priority of original bio in clone process.
> 
> 2. Make the IO priority of the original bio to be passed to dm,
>    and the dm target inherits the IO priority as needed.
> 
> Changes in v8:
>   - Rebase patch 1 on commit 7ed2632ec7d7
> Changes in v7:
>   - Modify patch 4: change dm-verity-fec.c
> Changes in v6:
>   - Rebase patch and resolve conflict for patch 1, 3, 4
>   - Modify patch 4: fec_read_parity() follow the priority of original
>     bio
>   - Update commit message
> Changes in v5:
>   - Rewrite patch 2, add ioprio parameter in dm_io();
>   - Modify dm_io() in patch 3
> Changes in v4:
>   - Modify commit message by Suggestion
>   - Modify patch for dm-crypt
> Changes in v3:
>   - Split patch for device-mapper
>   - Add patch to fix dm-crypy I/O priority question
>   - Add block patch to review together
>   - Fix some error in v2 patch
> Changes in v2:
>   - Add ioprio field in struct dm_io_region
>   - Initial struct dm_io_region::ioprio to IOPRIO_DEFAULT
>   - Add two interface
> 
> 
> Hongyu Jin (5):
>   block: Fix bio IO priority setting
>   dm: Support I/O priority for dm_io()
>   dm-bufio: Support I/O priority
>   dm verity: Fix I/O priority lost when read FEC and hash
>   dm-crypt: Fix lost ioprio when queuing write bios
> 
>  block/blk-core.c                              | 10 +++++
>  block/blk-mq.c                                | 10 -----
>  drivers/md/dm-bufio.c                         | 43 +++++++++++--------
>  drivers/md/dm-crypt.c                         |  1 +
>  drivers/md/dm-ebs-target.c                    |  8 ++--
>  drivers/md/dm-integrity.c                     | 12 +++---
>  drivers/md/dm-io.c                            | 23 +++++-----
>  drivers/md/dm-kcopyd.c                        |  4 +-
>  drivers/md/dm-log.c                           |  4 +-
>  drivers/md/dm-raid1.c                         |  6 +--
>  drivers/md/dm-snap-persistent.c               |  8 ++--
>  drivers/md/dm-verity-fec.c                    | 21 +++++----
>  drivers/md/dm-verity-target.c                 | 13 ++++--
>  drivers/md/dm-writecache.c                    |  8 ++--
>  drivers/md/persistent-data/dm-block-manager.c |  6 +--
>  include/linux/dm-bufio.h                      |  5 ++-
>  include/linux/dm-io.h                         |  3 +-
>  17 files changed, 102 insertions(+), 83 deletions(-)
> 
> 
> base-commit: 7ed2632ec7d72e926b9e8bcc9ad1bb0cd37274bf
> -- 
> 2.34.1


