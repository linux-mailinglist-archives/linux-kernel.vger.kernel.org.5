Return-Path: <linux-kernel+bounces-73549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4285C400
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B407F1F22AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F8E13667B;
	Tue, 20 Feb 2024 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GI/w2cbf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71D1350C0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455168; cv=none; b=G7zuj5/XUkIH4Or/UdjrJSSImL6a2LUnBTVGo3NXRaSyYRKVbJJPFV1NwZhikUGh0r6Wd1/saSLIU7LKYcNcrcucy8M7psWRV1a2Kf1lixIV+y5/XHXWeKZ/4y7ni4WcKlLKyMuCHXpzQUAPZWUdW92GCrbkbmhYz3tip2II0WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455168; c=relaxed/simple;
	bh=jVGlv+puRHszhkwzwsU0lyp/wfAVHZq/GVIMR/loB8o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PQk3h8GzYLgEPadpNSmtOiIx1ugZGBlXuryCBF7n/Dzn6X/9RbN19MPfyPXetwh9u68DAvd6iIn+DQlwwT14eqLCoq4xf9NFeS8ajtpjRc6QYeoSw0wQ4kA3+hiVaQQenzlN0fB/zwe7zw2/m7mP37fA6rgVuVNRUuVziYghFkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GI/w2cbf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708455165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P2wYttr5YYkjy1PbxuIXEie9EtBh3ZDzD6Qej/FpcCQ=;
	b=GI/w2cbfWz7sKdDIkuyJdlHc0eph7LBjEfvovem6/7AXMB7TvR6fawsrUZ0hn8LtjZlv9w
	FpGiLRmdXFrSjwBaJxoQx78MuPNt1zn8q/44BphB3+WAdXs6YpkW4Jzw/TsvcC2SBV7B3V
	r0BjS3ptm/Kjl/YRZOZ5doRimijW2hw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-g2orAwwTOmKlrqpKxLWZ0Q-1; Tue,
 20 Feb 2024 13:52:39 -0500
X-MC-Unique: g2orAwwTOmKlrqpKxLWZ0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA8ED38212C1;
	Tue, 20 Feb 2024 18:52:38 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 96EC210800;
	Tue, 20 Feb 2024 18:52:38 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 7D8CE30C1B8F; Tue, 20 Feb 2024 18:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 7A3253FB4E;
	Tue, 20 Feb 2024 19:52:38 +0100 (CET)
Date: Tue, 20 Feb 2024 19:52:38 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: =?ISO-8859-15?Q?Simone_Wei=DF?= <simone.weiss@elektrobit.com>
cc: lukas.bulwahn@gmail.com, simone.p.weiss@posteo.net, 
    Kai Tomerius <kai.tomerius@elektrobit.com>, 
    Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    dm-devel@lists.linux.dev, Song Liu <song@kernel.org>, 
    Yu Kuai <yukuai3@huawei.com>, linux-raid@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFQ] dm-integrity: Add a lazy commit mode for journal
In-Reply-To: <20240209192542.449367-1-simone.weiss@elektrobit.com>
Message-ID: <8a485b9-6dbb-78c-9a84-ed3ba65d9cb3@redhat.com>
References: <20240209192542.449367-1-simone.weiss@elektrobit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="185210117-1528542385-1708454829=:2837266"
Content-ID: <19bdaab-220-364a-26ef-b7e1f6447b7a@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185210117-1528542385-1708454829=:2837266
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <31b6218e-52d4-9728-16-da4e5e2dce77@redhat.com>



On Fri, 9 Feb 2024, Simone Weiﬂ wrote:

> Extend the dm-integrity driver to omit writing unused journal data sectors.
> Instead of filling up the whole journal section, mark the last used
> sector with a special commit ID. The commit ID still uses the same base value,
> but section number and sector number are inverted. At replay when commit IDs
> are analyzed this special commit ID is detected as end of valid data for this
> section. The main goal is to prolong the live times of e.g. eMMCs by avoiding
> to write the whole journal data sectors.
> 
> The change is right now to be seen as experimental and gets applied if
> CONFIG_DMINT_LAZY_COMMIT is set to y. Note please that this is NOT
> planned for a final version of the changes. I would make it configurable
> via flags passed e.g. via dmsetup and stored in the superblock.
> 
> Architectural Limitations:
> - A dm-integrity partition, that was previously used with lazy commit,
>  can't be replayed with a dm-integrity driver not using lazy commit.
> - A dm-integrity driver that uses lazy commit is expected
>  to be able to cope with a partition that was created and used without
>  lazy commit.
> - With dm-integrity lazy commit, a partially written journal (e.g. due to a
>  power cut) can cause a tag mismatch during replay if the journal entry marking
>  the end of the journal section is missing. Due to lazy commit, older journal
>  entries are not erased and might be processed if they have the same commit ID
>  as adjacent newer journal entries.

Hi

I was thinking about it and I think that this problem is a showstopper.

Suppose that a journal section contains these commit IDs:

	2	2	2	2(EOF)	3	3	3	3

The IDs "3" are left over from previous iterations. The IDs "2" contain 
the current data. And now, the journal rolls over and we attempt to write 
all 8 pages with the ID "3". However, a power failure happens and we only 
write 4 pages with the ID "3". So, the journal will look like:

	3(new)	3(new)	3(new)	3(new)	3(old)	3(old)	3(old)	3(old)

After a reboot, the journal-replay logic will falsely believe that the 
whole journal section is consistent and it will attempt to replay it.

This could be fixed by having always increasing commit IDs - the commit 
IDs have 8 bytes, so we can assume that they never roll-over and it would 
prevent us from mixing old IDs into the current transaction.

Mikulas

>  If dm-integrity detects bad sections while
>  replaying the journal, keep track about those sections and try to at least
>  replay older, good sections.
>  This is based on the assumption that most likely the newest
>  section(s) will be damaged, which might have been only partially written
>  due to a sudden reset. Previously, the whole journal would be cleared in
>  such a case.
> 
> Signed-off-by: Simone Weiﬂ <simone.weiss@elektrobit.com>
> Signed-off-by: Kai Tomerius <kai.tomerius@elektrobit.com>
--185210117-1528542385-1708454829=:2837266--


