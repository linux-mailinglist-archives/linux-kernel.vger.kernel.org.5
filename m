Return-Path: <linux-kernel+bounces-79108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C46861DA7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A589B247E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A40613B7A6;
	Fri, 23 Feb 2024 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAefhRU8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90AED2E6
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720435; cv=none; b=PzmJSbZnuhDp6WCE10azBnt15UNcFXGmwDJlf98v6ZY0lDFvSljSQCuLtwB+GTwXCiZ9KqR2jZ+edxOP9QaKmr+2qebQJZ9Q/aO1SEQUJHjFoMlvhKCHGwNzUYaaBje+kuYPkqOEPHoNdwbB+f/zLNikVPCREzvv6j5hy5z12eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720435; c=relaxed/simple;
	bh=UO+kNR+4GiScp6Qc5LSj4182IL6AdAaAMEGObL3NwzI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Lc6zOyr9x46t+RodTc4+Oo0AlXmNfBxCrloyP5PQZbLGTNdcZEzpS1DkyBZngaWlAaHUd/0HLIMfoJ5irWkux61CJELCxAHpr0CBKfhE/L3lYJHqnfEOwy39zJkbU1fW0tcqZpmXZQ/LrIXYStPzFEfrot00yQSvSkZytsUtQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAefhRU8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708720431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pZGJPRxx4dMEm20S/+xsVtXIs0A/Q7eXIofxVvhZOdw=;
	b=JAefhRU8hXqI1WNGvufY4nx/+Z/SP/8rgJrzDFRJMaHor6gqbBE7MqjfYiAxVDiPLyHB65
	mLMMbBzyXMRgcP+XJkjZaFwVRGJYJcjHSJiGVt7n1rV0or9LrtPjlElbg1crwi5ceQDTnw
	22uy4goG06pHgzVSwHY6DGqkYEU7UV8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-F6eAhvOmOg2_u6oKky05zg-1; Fri, 23 Feb 2024 15:33:48 -0500
X-MC-Unique: F6eAhvOmOg2_u6oKky05zg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FFBF832C08;
	Fri, 23 Feb 2024 20:33:47 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 48DF840C6EBA;
	Fri, 23 Feb 2024 20:33:47 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 29B6F30C1B8F; Fri, 23 Feb 2024 20:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 25C953FB4E;
	Fri, 23 Feb 2024 21:33:47 +0100 (CET)
Date: Fri, 23 Feb 2024 21:33:47 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: =?ISO-8859-15?Q?Wei=DF=2C_Simone?= <Simone.Weiss@elektrobit.com>
cc: "song@kernel.org" <song@kernel.org>, 
    "Tomerius, Kai" <Kai.Tomerius@elektrobit.com>, 
    "simone.p.weiss@posteo.net" <simone.p.weiss@posteo.net>, 
    "agk@redhat.com" <agk@redhat.com>, 
    "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, 
    "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>, 
    "yukuai3@huawei.com" <yukuai3@huawei.com>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>, 
    "snitzer@kernel.org" <snitzer@kernel.org>
Subject: Re: [PATCH] [RFQ] dm-integrity: Add a lazy commit mode for journal
In-Reply-To: <3e5a2087667333bb88135a6b6f9620201989605f.camel@elektrobit.com>
Message-ID: <9788e2a-8a61-3c76-e11e-a3f23b4d90c8@redhat.com>
References: <20240209192542.449367-1-simone.weiss@elektrobit.com> <8a485b9-6dbb-78c-9a84-ed3ba65d9cb3@redhat.com> <3e5a2087667333bb88135a6b6f9620201989605f.camel@elektrobit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="185210117-834878095-1708720427=:3731485"
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185210117-834878095-1708720427=:3731485
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Fri, 23 Feb 2024, Weiß, Simone wrote:

> On Tue, 2024-02-20 at 19:52 +0100, Mikulas Patocka wrote:
> > CAUTION: This email originated from outside of the Elektrobit organization. Do
> > not click links or open attachments unless you recognize the sender and know
> > the content is safe.
> > 
> > 
> > On Fri, 9 Feb 2024, Simone Weiß wrote:
> > 
> > > Extend the dm-integrity driver to omit writing unused journal data sectors.
> > > Instead of filling up the whole journal section, mark the last used
> > > sector with a special commit ID. The commit ID still uses the same base
> > > value,
> > > but section number and sector number are inverted. At replay when commit IDs
> > > are analyzed this special commit ID is detected as end of valid data for
> > > this
> > > section. The main goal is to prolong the live times of e.g. eMMCs by
> > > avoiding
> > > to write the whole journal data sectors.
> > > 
> > > The change is right now to be seen as experimental and gets applied if
> > > CONFIG_DMINT_LAZY_COMMIT is set to y. Note please that this is NOT
> > > planned for a final version of the changes. I would make it configurable
> > > via flags passed e.g. via dmsetup and stored in the superblock.
> > > 
> > > Architectural Limitations:
> > > - A dm-integrity partition, that was previously used with lazy commit,
> > >  can't be replayed with a dm-integrity driver not using lazy commit.
> > > - A dm-integrity driver that uses lazy commit is expected
> > >  to be able to cope with a partition that was created and used without
> > >  lazy commit.
> > > - With dm-integrity lazy commit, a partially written journal (e.g. due to a
> > >  power cut) can cause a tag mismatch during replay if the journal entry
> > > marking
> > >  the end of the journal section is missing. Due to lazy commit, older
> > > journal
> > >  entries are not erased and might be processed if they have the same commit
> > > ID
> > >  as adjacent newer journal entries.
> > 
> > Hi
> > 
> > I was thinking about it and I think that this problem is a showstopper.
> > 
> > Suppose that a journal section contains these commit IDs:
> > 
> >         2       2       2       2(EOF)  3       3       3       3
> > 
> > The IDs "3" are left over from previous iterations. The IDs "2" contain
> > the current data. And now, the journal rolls over and we attempt to write
> > all 8 pages with the ID "3". However, a power failure happens and we only
> > write 4 pages with the ID "3". So, the journal will look like:
> > 
> >         3(new)  3(new)  3(new)  3(new)  3(old)  3(old)  3(old)  3(old)
> > 
> > After a reboot, the journal-replay logic will falsely believe that the
> > whole journal section is consistent and it will attempt to replay it.
> > 
> > This could be fixed by having always increasing commit IDs - the commit
> > IDs have 8 bytes, so we can assume that they never roll-over and it would
> > prevent us from mixing old IDs into the current transaction.
> Hi
> 
> Thanks for the review of the concept. I was out this week and could only think
> about it now. I understood it right, that the proposal is to add an extra value
> to the commit ID, that is e.g. incremented when integrity_commit is executed?
> 
> If so, I tried this quickly and looks good on first glance. Will check and test
> further next.
> 
> Simone

I propose to use the commit ID 0 when writing the journal for the first 
time, then 1 when the journal rolls over, 2 when it rolls over again, 3 
when it rolls over again, 4 on another roll over and so on up to 
0x7fffffffffffffff (which will be never reached in practice).

And use the top bit as an end-of-section marker. As the commit IDs will 
never roll over, it won't happen that an old transaction would be mixed 
into a new transaction on partial journal write.

Mikulas
--185210117-834878095-1708720427=:3731485--


