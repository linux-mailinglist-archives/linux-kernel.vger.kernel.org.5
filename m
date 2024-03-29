Return-Path: <linux-kernel+bounces-124708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D8A891BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBFD1F22B96
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9917E143C61;
	Fri, 29 Mar 2024 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfKZNYdl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C5813664E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715910; cv=none; b=BbuWyDXmo5g9oED/5OXX5C5aSbayQjIGR6qzbhooB+7YAn2NfRJZwFt/b9zM5iP3p4mf3f8Q/YA1LjK07nQnmNUg75YPnmc3OE83w6nHgafeyB2/PKzHHi/bdJ+OBZUcCxAc5iZ+7yMmYByfod+dAjWol9ClXX7YbB7xNWd/qJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715910; c=relaxed/simple;
	bh=/Vcs98eIwBfAVmQudxzEl/D2HfXg0h5pd/qnhUjw8Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmHiqiZ6Gt9V/Kd9C/KlepDuywSUcfs5c443nHNk33B834F6FroaiF1fd9JvALpZLlSaIdM4RYhcYAdpI5lwHb/Wog4gIoD2rDs+ZvXrNNlxP3krxdFnuBAiD39RCeUN0GPFXp0Zm8c7piqsHGrU/h1pTNYKV295ZlHqCDYKC2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hfKZNYdl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711715908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1h/sI7lud1TUTbC3pqJNKCflJ35bQiddXm8poucTAE=;
	b=hfKZNYdlLphaCTkvHxNg2pdVcwd/IDFfmxgIKKXCFWZfi7KB6K2NiwR3ARNGmW7PUmkYJ4
	mtsFG3qSlzrr3PMhWm+sCSQ7K3qrNJ4Gk63slI4hPmRvpYCprDYqQIlApXKsy3sFdPn4HQ
	SlJo8/nSz7P0MMAk5r7F+zKh5blJLtI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-jud4lLB8PvKF1NeK86-r7w-1; Fri, 29 Mar 2024 08:38:26 -0400
X-MC-Unique: jud4lLB8PvKF1NeK86-r7w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AA7B85A58C;
	Fri, 29 Mar 2024 12:38:25 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ADE19111E3F3;
	Fri, 29 Mar 2024 12:38:22 +0000 (UTC)
Date: Fri, 29 Mar 2024 07:38:17 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alasdair Kergon <agk@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	David Teigland <teigland@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 3/9] selftests: block_seek_hole: add loop block driver tests
Message-ID: <6mssvnoq4bpaf53kkla45np5lijptyh4c2orayqx4mqacj572u@6s4y6bhdtcpm>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240328203910.2370087-4-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328203910.2370087-4-stefanha@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Thu, Mar 28, 2024 at 04:39:04PM -0400, Stefan Hajnoczi wrote:
> Run the tests with:
> 
>   $ make TARGETS=block_seek_hole -C tools/selftests run_tests
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  .../selftests/block_seek_hole/Makefile        |  17 +++
>  .../testing/selftests/block_seek_hole/config  |   1 +
>  .../selftests/block_seek_hole/map_holes.py    |  37 +++++++
>  .../testing/selftests/block_seek_hole/test.py | 103 ++++++++++++++++++
>  5 files changed, 159 insertions(+)
>  create mode 100644 tools/testing/selftests/block_seek_hole/Makefile
>  create mode 100644 tools/testing/selftests/block_seek_hole/config
>  create mode 100755 tools/testing/selftests/block_seek_hole/map_holes.py
>  create mode 100755 tools/testing/selftests/block_seek_hole/test.py
> 

> +
> +def map_holes(fd):
> +    end = os.lseek(fd, 0, os.SEEK_END)
> +    offset = 0
> +
> +    print('TYPE START END SIZE')
> +
> +    while offset < end:
> +        contents = 'DATA'
> +        new_offset = os.lseek(fd, offset, os.SEEK_HOLE)
> +        if new_offset == offset:
> +            contents = 'HOLE'
> +            try:
> +              new_offset = os.lseek(fd, offset, os.SEEK_DATA)
> +            except OSError as err:
> +                if err.errno == errno.ENXIO:
> +                    new_offset = end
> +                else:
> +                    raise err
> +            assert new_offset != offset
> +        print(f'{contents} {offset} {new_offset} {new_offset - offset}')
> +        offset = new_offset

Over the years, I've seen various SEEK_HOLE implementation bugs where
things work great on the initial boundary, but fail when requested on
an offset not aligned to the start of the extent boundary.  It would
probably be worth enhancing the test to prove that:

if lseek(fd, offset, SEEK_HOLE) == offset:
  new_offset = lseek(fd, offset, SEEK_DATA)
  assert new_offset > offset
  assert lseek(fd, new_offset - 1, SEEK_HOLE) == new_offset - 1
else:
  assert lseek(fd, offset, SEEK_DATA) == offset
  new_offset = lseek(fd, offset, SEEK_HOLE)
  assert new_offset > offset
  assert lseek(fd, new_offset - 1, SEEK_DATA) == new_offset - 1

Among other things, this would prove that even though block devices
generally operate on a minimum granularity of a sector, lseek() still
gives byte-accurate results for a random offset that falls in the
middle of a sector, and doesn't accidentally round down reporting an
offset less than the value passed in to the request.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


